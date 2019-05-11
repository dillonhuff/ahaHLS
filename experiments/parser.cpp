#include "parser.h"

#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Scalar.h"
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>

#include <functional>

#include "verilog_backend.h"
#include "test_utils.h"

using namespace dbhc;
using namespace ahaHLS;
using namespace std;

class SynthCppModule;
void optimizeModuleLLVM(SynthCppModule& mod);
void optimizeModuleLLVM(llvm::Module& mod);

void setZeroRows(TestBenchSpec& tb, const int cycleNo, const int stencilWidth, const int loadWidth, vector<Argument*> words) {
  for (int row = 0; row < stencilWidth; row++) {
    auto word = words[row];
    string values = "";
    for (int col = 0; col < loadWidth; col++) {
      values += "8'd0";
      if (col != (loadWidth - 1)) {
        values += ",";
      }
    }
    tb.setArgPort(word, "in_wire", cycleNo,
                  "{" + values + "}");
  }
}


// Simpler store elimination, since our formulation has no aliasing by
// construction
void optimizeStores(llvm::Function* f) {
  bool erased = true;
  while (erased) {
    erased = false;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instr : bb) {
        //int numUses = instr.getNumUses();

        if (AllocaInst::classof(&instr)) {
          bool allStores = true;
          for (auto& user : instr.uses()) {
            if (!StoreInst::classof(user.getUser())) {
              allStores = false;
            }
          }

          if (allStores) {

            cout << "All uses of " << valueString(&instr) << " are stores" << endl;
            for (auto& user : instr.uses()) {
              cout << "Erasing " << valueString(user) << endl;
              dyn_cast<Instruction>(user.getUser())->eraseFromParent();
            }

            instr.eraseFromParent();
            
            erased = true;
            break;
          }
        }
      }

      if (erased) {
        break;
      }
    }
  }
}

MemorySpec pss(const int width) {
  return {0, 0, 1, 1, width, 1, false, {{{"width", std::to_string(width)}}, "reg_passthrough"}};
}

bool isPresent(InstructionTime& time, llvm::Function* const f) {
  ExecutionAction action = time.action;
  if (action.isTag()) {
    return true;
  }

  if (action.isBasicBlock()) {
    BasicBlock* bb = action.getBasicBlock();
    for (auto& other : f->getBasicBlockList()) {
      if (bb == &other) {
        return true;
      }
    }

    return false;
  }

  if (action.isInstruction()) {
    Instruction* instr = action.getInstruction();
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& other : bb) {
        if (instr == &other) {
          return true;
        }
      }
    }

    return false;
  }

  return false;
}

void clearExecutionConstraints(llvm::Function* const f,
                               ExecutionConstraints& exec) {
  set<ExecutionConstraint*> toRemove;
  for (auto c : exec.constraints) {
    if (c->type() == CONSTRAINT_TYPE_ORDERED) {
      auto oc = static_cast<Ordered*>(c);
      bool startPresent = isPresent(oc->before, f);
      bool endPresent = isPresent(oc->after, f);

      if (!startPresent || !endPresent) {
        toRemove.insert(c);
      }
    } else {
      assert(false);
    }
  }

  for (auto r : toRemove) {
    exec.remove(r);
  }
}

Schedule scheduleInterfaceZeroReg(llvm::Function* f,
                                  HardwareConstraints& hcs,
                                  InterfaceFunctions& interfaces,
                                  std::set<BasicBlock*>& toPipeline,
                                  ExecutionConstraints& exec) {

  cout << "Before inlining" << endl;
  cout << valueString(f) << endl;

  addDataConstraints(f, exec);
  inlineWireCalls(f, exec, interfaces);

  // TODO: Where to put this stuff
  optimizeModuleLLVM(*(f->getParent()));
  optimizeStores(f);
  clearExecutionConstraints(f, exec);
  
  cout << "After inlining" << endl;
  cout << valueString(f) << endl;

  setAllAllocaMemTypes(hcs, f, pss(32));
  hcs.memoryMapping =
    memoryOpLocations(f);

  // Single load optimization
  for (auto& bb : f->getBasicBlockList()) {
    for (auto& instrR : bb) {
      auto instr = &instrR;
      int numUsers = instr->getNumUses();

      if ((BinaryOperator::classof(instr) ||
           UnaryInstruction::classof(instr) ||
           LoadInst::classof(instr) ||
           CmpInst::classof(instr))
          && (numUsers == 1)) {
        auto& user = *(instr->uses().begin());
        assert(Instruction::classof(user));
        auto userInstr = dyn_cast<Instruction>(user.getUser());
        exec.add(instrEnd(instr) == instrStart(userInstr));
      }
    }
  }

  // cout << "Hardware memory storage names" << endl;
  // for (auto mspec : hcs.memSpecs) {
  //   cout << valueString(mspec.first) << " -> " << mspec.second.modSpec.name << endl;
  // }

  SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
  exec.addConstraints(p, f);

  map<Function*, SchedulingProblem> constraints{{f, p}};
  Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

  return s;
}

class CodeGenState {
public:

  SynthCppClass* activeClass;
  SynthCppFunction* activeFunction;
  BasicBlock* activeBlock;
  int globalNum;

  SymbolTable symtab;

  CodeGenState() : activeBlock(nullptr) {}

  BasicBlock& getActiveBlock() const { return *activeBlock; }
  void setActiveBlock(BasicBlock* blk) {
    activeBlock = blk;
  }

  IRBuilder<> builder() { return IRBuilder<>(activeBlock); }

  void pushClassContext(SynthCppClass* ac) {
    activeClass = ac;
  }

  void popClassContext() {
    activeClass = nullptr;
  }

  SynthCppClass* getActiveClass() {
    return activeClass;
  }
};

pair<string, int> extractDefault(Statement* stmt) {
  auto eStmt = extract<ExpressionStmt>(stmt);
  auto expr = eStmt->expr;
  FunctionCall* writeCall = extract<FunctionCall>(expr);
  assert(writeCall->getName() == "write_port");
  Expression* portId = writeCall->args[0];
  Identifier* id = extract<Identifier>(portId);
  Expression* portVal = writeCall->args[1];
  IntegerExpr* val = extract<IntegerExpr>(portVal);

  return {id->getName(), val->getInt()};
}

int countTerminators(const BasicBlock& bb) {
  int numTerminators = 0;
  for (auto& instr : bb) {
    if (TerminatorInst::classof(&instr)) {
      numTerminators++;
    }
  }

  return numTerminators;
}

void sanityCheck(llvm::Function* f) {
  for (auto& bb : f->getBasicBlockList()) {
    int numTerminators = countTerminators(bb);
    if (numTerminators != 1) {
      cout << "Error: In function " << endl;
      cout << valueString(f) << endl;
      cout << "basic block " << endl;
      cout << valueString(&bb) << " has zero or multiple terminators" << endl;
      assert(false);
    }
  }
}

// Idea: Caller constraints that inline in to each user of a function?
// For each called user function check if caller constraints are satisified
// and if not propagate them up the stack? A form of type checking I suppose?
class SynthCppModule {

  HardwareConstraints hcs;
  InterfaceFunctions interfaces;
  
public:

  llvm::LLVMContext context;
  unique_ptr<llvm::Module> mod;
  std::vector<SynthCppClass*> classes;
  std::vector<SynthCppFunction*> functions;
  std::set<BasicBlock*> blocksToPipeline;

  CodeGenState cgs;
  SynthCppFunction* activeFunction;
  int globalNum;
  std::map<Token, Instruction*> labelsToInstructions;
  std::map<Token, BasicBlock*> labelsToBlockStarts;
  std::map<Token, BasicBlock*> labelsToBlockEnds;
  
  std::string uniqueNumString() {
    auto s = std::to_string(globalNum);
    globalNum++;
    return s;
  }

  void genLLVMCopyTo(llvm::Value* receiver,
                     llvm::Value* source) {
    
    cgs.builder().CreateCall(mkFunc({receiver->getType(), source->getType()}, voidType(), "copy_" + typeString(receiver->getType())), {receiver, source});
  }

  llvm::Value* bvCastTo(Value* value, Type* const destTp) {
    int vWidth = getTypeBitWidth(value->getType());
    int rWidth = getTypeBitWidth(destTp);

    if (vWidth == rWidth) {
      return value;
    }

    if (vWidth < rWidth) {
      return cgs.builder().CreateSExt(value, destTp);
    }

    assert(vWidth > rWidth);
    
    return cgs.builder().CreateTrunc(value, destTp);
  }
  
  // argNum could be 1 if the function being synthesized is actually a
  // method
  void setArgumentSymbols(IRBuilder<>& b,
                          map<string, SynthCppType*>& symtab,
                          vector<ArgumentDecl*>& args,
                          Function* f,
                          int argOffset) {

    cout << "f = " << endl;
    cout << valueString(f) << endl;
    cout << "argOffset = " << argOffset << endl;
    //int argNum = argOffset;
    int argNum = 0;    
    for (auto argDecl : args) {
      cout << "\targ = " << argDecl->name << endl;

      // Create local copy if argument is passed by value
      // For arguments originally passed by pointer:
      // - Add the underlying type to the value map (setValue)
      // For arguments originally passed by value
      // - Create internal copy
      symtab[argDecl->name.getStr()] = argDecl->tp;
      cout << "Setting " << argDecl->name.getStr() << " in symbol table" << endl;
      if (!SynthCppPointerType::classof(argDecl->tp)) {
        auto val = cgs.builder().CreateAlloca(llvmTypeFor(argDecl->tp));
        cgs.builder().CreateStore(getArg(f, argNum + argOffset), val);
        setValue(argDecl->name, val);
      } else {
        setValue(argDecl->name, getArg(f, argNum + argOffset));
      }

      argNum++;
    }

  }

  
  SynthCppModule(ParserModule& parseRes) {
    activeFunction = nullptr;

    globalNum = 0;
    hcs = standardConstraints();
    
    mod = llvm::make_unique<Module>("synth_cpp", context);
    setGlobalLLVMContext(&context);
    setGlobalLLVMModule(mod.get());

    for (auto stmt : parseRes.getStatements()) {

      if (ClassDecl::classof(stmt)) {
        ClassDecl* decl = static_cast<ClassDecl* const>(stmt);
        ModuleSpec cSpec;

        SynthCppClass* c = new SynthCppClass();
        c->name = decl->name;
        cgs.symtab.pushTable(&(c->memberVars));
        cgs.pushClassContext(c);
        
        for (auto st : decl->body) {
          if (ArgumentDecl::classof(st)) {
            auto decl = sc<ArgumentDecl>(st);
            c->memberVars[decl->name.getStr()] = decl->tp;
          } else if (FunctionDecl::classof(st)) {

            // I would like to be able to generate method
            // and function code with the same generator so
            // that I dont end up with argument duplication
            auto methodFuncDecl = sc<FunctionDecl>(st);
            if (methodFuncDecl->getName() == "defaults") {
              for (auto stmt : methodFuncDecl->body) {
                pair<string, int> defaultValue = extractDefault(stmt);
                cSpec.defaultValues.insert(defaultValue);
              }
            } else {
              vector<Type*> argTps =
                functionInputs(methodFuncDecl);

              cout << "Method " << methodFuncDecl->getName() << " has arg types before return value and this:" << endl;
              for (auto a : argTps) {
                cout << tab(1) << typeString(a) << endl;
              }
            
              vector<Type*> tps;
              tps.push_back(llvmTypeFor(new SynthCppPointerType(new SynthCppStructType(c->name))));
              for (auto a : argTps) {
                tps.push_back(a);
              }

              cout << "Method " << methodFuncDecl->getName() << " has arg types" << endl;
              for (auto a : tps) {
                cout << tab(1) << typeString(a) << endl;
              }
              SynthCppFunction* sf = new SynthCppFunction();
              activeFunction = sf;
              sf->nameToken = methodFuncDecl->name;
              // Change voidType to the function output type
              auto f = mkFunc(tps, llvmTypeFor(methodFuncDecl->returnType), sf->getName());
              interfaces.addFunction(f);
              sf->func = f;
              sf->retType = methodFuncDecl->returnType;
              sf->constraints = &(interfaces.getConstraints(f));

              auto bb = mkBB("entry_block", f);
              cgs.setActiveBlock(bb);
              
              //IRBuilder<> b(bb);

              bool hasReturn = false; //sf->hasReturnValue();
              auto bd = cgs.builder();
              setArgumentSymbols(bd, sf->symtab, methodFuncDecl->args, f, 1 + (hasReturn ? 1 : 0));
              cgs.symtab.pushTable(&(sf->symtab));
              cout << "After setting argument symbols for "  << string(f->getName()) << endl;
              cgs.symtab.print(cout);
              
            
              for (auto stmt : methodFuncDecl->body) {
                cout << "Statement" << endl;
                genLLVM(stmt);
              }

              BasicBlock* activeBlock = &(cgs.getActiveBlock());
              //&(activeFunction->llvmFunction()->getEntryBlock());
              if (activeBlock->getTerminator() == nullptr) {
                cout << "Basic block " << valueString(activeBlock) << "has no terminator" << endl;
              
                cgs.builder().CreateRet(nullptr);
              }

              cout << "Just generated code for method " << endl;
              cout << valueString(sf->llvmFunction()) << endl;
              c->methods[sf->getName()] = sf;

              sanityCheck(f);
              
              //setAllAllocaMemTypes(hcs, f, registerSpec(32));
            
              activeFunction = nullptr;
            }
          } else {
            assert(false);
          }
        }
        classes.push_back(c);

        // TODO: Wrap this up in to a function
        // Add interface class module spec to hardware constraints
        cSpec.name = c->getName();
        cSpec.hasClock = true;
        cSpec.hasRst = true;

        for (auto vTp : c->memberVars) {
          auto tp = vTp.second;
          if (isPortType(tp)) {
            if (isOutputPort(tp)) {
              addOutputPort(cSpec.ports, portWidth(tp), vTp.first);
            } else {
              assert(isInputPort(tp));

              // Set non-default values to be insensitive
              string portName = vTp.first;
              if (!contains_key(portName, cSpec.defaultValues)) {
                cSpec.insensitivePorts.insert(portName);
              }
              addInputPort(cSpec.ports, portWidth(tp), vTp.first);
            }
          }
        }
        cout << "class has name " << c->getName() << endl;
        hcs.typeSpecs[c->getName()] = [cSpec](StructType* tp) { return cSpec; };
        hcs.hasTypeSpec(c->getName());

        cgs.symtab.popTable();
        cgs.popClassContext();
        
      } else if (FunctionDecl::classof(stmt)) {
        auto fd = static_cast<FunctionDecl*>(stmt);
        vector<Type*> inputTypes = functionInputs(fd);
        auto sf = new SynthCppFunction();
        sf->nameToken = fd->name;
        //activeSymtab = &(sf->symtab);
        cgs.symtab.pushTable(&(sf->symtab));

        // Add return type as first argument
        llvm::Function* f = mkFunc(inputTypes, llvmTypeFor(fd->returnType), sf->getName());

        // Add this function to the interface functions
        interfaces.addFunction(f);
        sf->constraints = &interfaces.getConstraints(f);

        auto bb = mkBB("entry_block", f);
        cgs.setActiveBlock(bb);
        
        //IRBuilder<> b(bb);

        //bool hasReturn = sf->hasReturnValue();
        auto bd = cgs.builder();
        setArgumentSymbols(bd, sf->symtab, fd->args, f, 0);

        // Now need to iterate over all statements in the body creating labels
        // that map to starts and ends of statements
        // and also adding code for each statement to the resulting function, f.
        sf->func = f;        
        activeFunction = sf;
        cout << "# of statements = " << fd->body.size() << endl;
        for (auto stmt : fd->body) {
          cout << "Statement" << endl;
          genLLVM(stmt);
        }

        BasicBlock* activeBlock = &(cgs.getActiveBlock());
          //&(activeFunction->llvmFunction()->getEntryBlock());
        if (activeBlock->getTerminator() == nullptr) {
          cout << "Basic block " << valueString(activeBlock) << "has no terminator" << endl;
          cgs.builder().CreateRet(nullptr);
        }

        // Set all calls to be sequential by default
        //sequentialCalls(f, interfaces.getConstraints(f));

        functions.push_back(sf);
        activeFunction = nullptr;

        sanityCheck(f);

        cgs.symtab.popTable();
      }
    }

  }

  map<std::string, llvm::Value*> valueMap;

  bool hasValue(Token t) const {
    return contains_key(t.getStr(), valueMap);
  }
  
  llvm::Value* getValueFor(Token t) {
    cout << "Getting value for " << t.getStr() << endl;
    assert(contains_key(t.getStr(), valueMap));
    return map_find(t.getStr(), valueMap);
  }

  void setValue(Token t, llvm::Value* v) {
    valueMap[t.getStr()] = v;
    assert(contains_key(t.getStr(), valueMap));    
  }

  EventTime eventFromLabel(string arg0Name, const string& labelName) {
    if (contains_key(Token(arg0Name), labelsToInstructions)) {
      Instruction* instrLabel = map_find(Token(arg0Name), labelsToInstructions);
      cout << "Instruction labeled = " << valueString(instrLabel) << endl;
      
      if (labelName == "start") {
        return {ExecutionAction(instrLabel), false, 0};
      } else {
        assert(labelName == "end");
        return {ExecutionAction(instrLabel), true, 0};
      }
    } else {
      assert(contains_key(Token(arg0Name), labelsToBlockStarts));
      assert(contains_key(Token(arg0Name), labelsToBlockEnds));

      if (labelName == "start") {
        BasicBlock* blkLabel = map_find(Token(arg0Name), labelsToBlockStarts);
        return {ExecutionAction(blkLabel), false, 0};        
      } else {
        assert(labelName == "end");

        BasicBlock* blkLabel = map_find(Token(arg0Name), labelsToBlockEnds);
        return {ExecutionAction(blkLabel), true, 0};
      }
    }
  }

  EventTime parseEventTime(Expression* const e) {
    auto mBop = extractM<BinopExpr>(e);
    if (mBop.has_value()) {
      auto bop = mBop.get_value();
      Token op = bop->op;
      EventTime tm = parseEventTime(bop->lhs);
      cout << "Integer rhs type = " << bop->rhs->getKind() << endl;
      IntegerExpr* val = extract<IntegerExpr>(bop->rhs);

      return tm + val->getInt();
    } else {
      cout << "Call type = " << e->getKind() << endl;      
      auto labelCall = extract<FunctionCall>(e);
      string name = labelCall->funcName.getStr();
      cout << "name = " << name << endl;
      assert((name == "start") || (name == "end"));

      Expression* arg0 = labelCall->args.at(0);
      cout << "arg0Kind = " << arg0->getKind() << endl;
      auto arg0Id = extract<Identifier>(arg0);
      string arg0Name = arg0Id->getName();

      cout << "got arg0 name = " << arg0Name << endl;

      return eventFromLabel(arg0Name, name);
    }
  }

  ExecutionConstraint* parseConstraint(Expression* const e) {
    BinopExpr* bop = extract<BinopExpr>(e);
    Token op = bop->op;
    cout << "Parsing binop = " << op << endl;
    assert(isComparator(op));

    Expression* lhs = bop->lhs;
    EventTime lhsTime = parseEventTime(lhs);
    Expression* rhs = bop->rhs;
    EventTime rhsTime = parseEventTime(rhs);

    if (op.getStr() == "==") {
      return lhsTime == rhsTime;
    } else if (op.getStr() == "<") {
      return lhsTime < rhsTime;
    } else {
      assert(false);
    }
  }

  bool isData(Type* const tp) {
    if (IntegerType::classof(tp)) {
      return true;
    }

    if (StructType::classof(tp)) {
      StructType* stp = dyn_cast<StructType>(tp);
      return stp->elements().size() > 0;
    }

    return false;
  }
  
  llvm::Value* genLLVM(Expression* const e) {
    auto bd = cgs.builder();
    
    if (Identifier::classof(e)) {

      Identifier* id = static_cast<Identifier* const>(e);
      if (!hasValue(id->name)) {
        cout << "Error: Id has no value = " << id->name << endl;        
        assert(false);
      }

      // Load the register value if we are dealing with an identifier for
      // a pointer to a piece of data? Load the pointer value
      // if we are dealing with an identifier for a pointer to a structure?

      Value* v = getValueFor(id->name);

      // TODO: Get SynthCppType instead?
      Type* tp = v->getType();
      assert(PointerType::classof(tp));
      Type* underlying = dyn_cast<PointerType>(tp)->getElementType();

      if (isData(underlying)) {
        return loadReg(bd, getValueFor(id->name));
      } else {
        assert(StructType::classof(underlying));
        return getValueFor(id->name);
      }

    } else if (BinopExpr::classof(e)) {
      BinopExpr* be = static_cast<BinopExpr* const>(e);
      auto bd = cgs.builder();
      auto l = genLLVM(be->lhs);
      auto r = genLLVM(be->rhs);

      cout << "left     = " << valueString(l) << endl;
      cout << "left tp  = " << typeString(l->getType()) << endl;
      cout << "rght tp  = " << typeString(r->getType()) << endl;

      assert(!PointerType::classof(l->getType()));
      assert(!PointerType::classof(r->getType()));

      auto lBaseType = l->getType();
      auto rBaseType = r->getType();

      if (IntegerType::classof(lBaseType) &&
          IntegerType::classof(rBaseType)) {
        if (l->getType() != r->getType()) {
          int lWidth = getTypeBitWidth(lBaseType);
          int rWidth = getTypeBitWidth(rBaseType);

          if (lWidth < rWidth) {
            l = bd.CreateSExt(l, rBaseType);
          } else {
            assert(lWidth > rWidth);
            r = bd.CreateSExt(r, lBaseType);         
          }
        }
      } else {
        assert(l->getType() == r->getType());
      }

      if (be->op.getStr() == "+") {
        return bd.CreateAdd(l, r);
      } else if (be->op.getStr() == "<") {
        return bd.CreateICmpSLT(l, r);
      } else if (be->op.getStr() == "*") {
        return bd.CreateMul(l, r);        
      } else if (be->op.getStr() == "-") {
        return bd.CreateSub(l, r);
      } else if (be->op.getStr() == "==") {
        return bd.CreateICmpEQ(l, r);
      } else {
        cout << "Error: Unsupported binop: " << be->op << endl;
        assert(false);
      }

    } else if (FunctionCall::classof(e)) {
      auto called = sc<FunctionCall>(e);

      string name = called->funcName.getStr();
      if (name == "add_constraint") {
        // TODO: Add constraint to active execonstraints
        ExecutionConstraints& exe =
          getInterfaceFunctions().getConstraints(activeFunction->llvmFunction());

        ExecutionConstraint* c =
          parseConstraint(called->args[0]);

        cout << "Adding constraint " << *c << endl;
        exe.add(c);
        return nullptr;
      }

      if ((name == "set_port") || (name == "write_port")) {
        assert(called->args.size() == 2);
        
        Expression* labelExpr = called->args[0];

        Identifier* labelId = extract<Identifier>(labelExpr);
        Expression* valueExpr = called->args[1];

        cout << "Value expression in write port is " << *valueExpr << endl;
        auto vExpr = genLLVM(valueExpr);
        cout << "LLVM value for expression is " << valueString(vExpr) << endl;
        
        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);
        //auto bitWidth = getValueBitWidth(vExpr);
        auto f = writePort(labelId->name.getStr(), getValueBitWidth(vExpr), structType->getPointerTo());

        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        // cout << "Active function = " << activeFunction->nameToken << endl;
        // cout << valueString(activeFunction->llvmFunction()) << endl;

        int thisOffset = 0;
        return bd.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset), vExpr});
      }

      if (name == "stall") {

        Expression* valueExpr = called->args[0];
        auto vExpr = genLLVM(valueExpr);
        
        return bd.CreateCall(stallFunction(), {vExpr});
      }

      if (name == "read_port") {
        assert(called->args.size() == 1);
        
        Expression* labelExpr = called->args[0];

        cout << "read port: " << *labelExpr << endl;

        Identifier* labelId = extract<Identifier>(labelExpr);

        // TODO: Replace with more general
        int outWidth = cgs.activeClass->getPortWidth(labelId->getName());

        SynthCppClass* sExpr = cgs.getActiveClass();
        SynthCppType* classTp = new SynthCppStructType(sExpr->name);
        Type* structType = llvmTypeFor(classTp);
        auto f =
          readPort(labelId->name.getStr(), outWidth, structType->getPointerTo());

        assert(activeFunction != nullptr);
        assert(activeFunction->llvmFunction() != nullptr);

        cout << "Active function = " << activeFunction->nameToken << endl;
        cout << valueString(activeFunction->llvmFunction()) << endl;

        int thisOffset = 0;
        return bd.CreateCall(f, {getArg(activeFunction->llvmFunction(), thisOffset)});
      }
      
      SynthCppFunction* calledFunc = getFunction(called->funcName.getStr());

      // Generate llvm for each argument
      vector<Value*> args;

      for (auto arg : called->args) {
        args.push_back(genLLVM(arg));
      }

      return bd.CreateCall(calledFunc->llvmFunction(), args);      
    } else if (MethodCall::classof(e)) {
      // Dummy code
      auto methodCall =
        static_cast<MethodCall* const>(e);

      // Should really be an expression
      Token caller = methodCall->callerName;
      FunctionCall* called = methodCall->called;
      SynthCppClass* cs = getClass(caller);
      SynthCppFunction* calledFunc = cs->getMethod(called->funcName);

      // Generate llvm for each argument
      vector<Value*> args;

      args.push_back(getValueFor(caller));
      int synthFuncIndex = 0;
      Function* calledLLVM = calledFunc->llvmFunction();
      for (auto arg : called->args) {
        auto argLLVM = genLLVM(arg);
        auto argParam = getArg(calledLLVM, synthFuncIndex + 1);

        // TODO: Insert this in function calls as well
        // Check if the argument being passed was a value
        if (!PointerType::classof(argLLVM->getType()) &&
            PointerType::classof(argParam->getType())) {
          cout << "Argument " << valueString(argLLVM) << " is value but bound type of parameter is " << valueString(getArg(calledLLVM, synthFuncIndex + 1)) << " (pointer), need to create temp first" << endl;

          auto argStorage = bd.CreateAlloca(argLLVM->getType());
          bd.CreateStore(argLLVM, argStorage);
          argLLVM = argStorage;
        }
        args.push_back(argLLVM);
      }

      return bd.CreateCall(calledFunc->llvmFunction(), args);

    } else if (IntegerExpr::classof(e)) {
      IntegerExpr* i = static_cast<IntegerExpr* const>(e);
      string digits = i->digits;
      auto val = stoi(digits);
      return mkInt(val, 32);
    } else {
      cout << "Unsupported expression in LLVM codegen" << endl;
      assert(false);      
    }
  }

  SynthCppType* getTypeForId(const Token id) {
    return cgs.symtab.getType(id.getStr());
  }

  SynthCppClass* getClassByName(const Token id) {
    for (auto c : classes) {
      if (c->getName() == id.getStr()) {
        return c;
      }
    }

    cout << "Error: Cannot find class with name " << id << endl;
    assert(false);
  }
  
  SynthCppClass* getClass(const Token id) {
    string idName = id.getStr();
    cout << "Getting class for " << idName << endl;
    SynthCppType* tp = getTypeForId(id);

    cout << "Got type for " << idName << endl;

    auto classType = extractBaseStructType(tp);
    for (auto c : classes) {
      if (c->name == classType->name) {
        return c;
      }
    }

    assert(false);
  }

  void genLLVM(ForStmt* const stmt) {
    Statement* init = stmt->init;
    Expression* exitTest = stmt->exitTest;
    Statement* update = stmt->update;
    auto stmts = stmt->stmts;
    
    auto bd = cgs.builder();

    // Need entry block to check
    auto loopTestBlock = mkBB( "for_blk_init_test_" + uniqueNumString(), activeFunction->llvmFunction());
    auto loopBodyBlock = mkBB( "for_body_" + uniqueNumString(), activeFunction->llvmFunction());
    auto nextBlock = mkBB( "for_body_" + uniqueNumString(), activeFunction->llvmFunction());    

    genLLVM(init);
    bd.CreateBr(loopTestBlock);

    cgs.setActiveBlock(loopTestBlock);
    auto testCond = genLLVM(exitTest);
    cgs.builder().CreateCondBr(testCond, loopBodyBlock, nextBlock);

    cgs.setActiveBlock(loopBodyBlock);
    for (auto stmt : stmts) {
      genLLVM(stmt);
    }
    genLLVM(update);
    cgs.builder().CreateBr(loopTestBlock);

    // Need major work block

    // Need exit block
    cgs.setActiveBlock(nextBlock);
  }
  
  void genLLVM(ArgumentDecl* const decl) {
    auto bd = cgs.builder();
    
    string valName = decl->name.getStr();
    Type* tp = llvmTypeFor(decl->tp);
    // TODO: add to name map?
    cgs.symtab.setType(valName, decl->tp);
    //auto n = b.CreateAlloca(tp, nullptr, valName);
    auto n = bd.CreateAlloca(tp, nullptr, valName);
    // Add to constraints?
    int width = getTypeBitWidth(tp);
    setMemSpec(n, getHardwareConstraints(), {0, 0, 1, 1, width, 1, false, {{{"width", std::to_string(width)}}, "register"}});
    setValue(decl->name, n);
  }

  void genLLVM(AssignStmt* const stmt) {

    // Note: Should really be an expression
    Token t = stmt->var;
    Expression* newVal = stmt->expr;

    Value* v = genLLVM(newVal);

    if (stmt->hasLabel()) {
      Token l = stmt->label;
      cout << "Label on assign = " << stmt->label << endl;

      // TODO: Remove this hack and replace with something more general
      //BasicBlock* blk = &(activeFunction->llvmFunction()->getEntryBlock());
      BasicBlock* blk = &(cgs.getActiveBlock());
      cout << "Block for label = " << valueString(blk) << endl;
      Instruction* last = &(blk->back());

      cout << "Last instruction" << valueString(last) << endl;
      labelsToInstructions[stmt->label] = last;
    }

    Value* tV = getValueFor(t);

    genSetCode(tV, v);
  }

  void genLLVM(ReturnStmt* const stmt) {
    auto bd = cgs.builder();

    Expression* retVal = stmt->returnVal;
    Value* v = nullptr;
    if (retVal != nullptr) {
      v = genLLVM(retVal);
    }
    bd.CreateRet(v);
    
    if (stmt->hasLabel()) {
      Token l = stmt->label;
      cout << "Label on assign = " << stmt->label << endl;
      BasicBlock* blk = &(cgs.getActiveBlock());
      cout << "Block for label = " << valueString(blk) << endl;
      Instruction* last = &(blk->back());

      cout << "Last instruction" << valueString(last) << endl;
      labelsToInstructions[stmt->label] = last;
    }

  }
  
  void genSetCode(Value* receiver, Value* value) {
    auto bd = cgs.builder();
    // Check types?
    
    Type* rType = receiver->getType();
    Type* vType = value->getType();

    cout << "receiver = " << valueString(receiver) << endl;
    cout << "value    = " << valueString(value) << endl;    
    cout << "rType = " << typeString(rType) << endl;
    cout << "vType = " << typeString(vType) << endl;

    if (rType == vType->getPointerTo()) {
      bd.CreateStore(value, receiver);
    } else {
      assert(PointerType::classof(rType));
      auto underlying = dyn_cast<PointerType>(rType)->getElementType();
      if (isData(underlying) &&
          isData(vType)) {

        auto valueCast = bvCastTo(value, underlying);
        assert(rType == valueCast->getType()->getPointerTo());
        bd.CreateStore(valueCast, receiver);
      } else {
        cout << "Error: Incompatible types in assignment, receiver "
             << valueString(receiver) << ", value " << valueString(value) << endl;
      }
    }
  }

  void genLLVM(DoWhileLoop* stmt) {
    cout << "Do while loop" << endl;
    Expression* test = stmt->test;
    vector<Statement*> stmts = stmt->body;

    auto lastBlock = cgs.builder();
    auto loopBlock =
      mkBB("while_loop_" + uniqueNumString(), activeFunction->llvmFunction());
    lastBlock.CreateBr(loopBlock);

    cgs.setActiveBlock(loopBlock);

    // Create exit block
    auto nextBlock =
      mkBB("after_while_" + uniqueNumString(), activeFunction->llvmFunction());

    for (auto stmt : stmts) {
      genLLVM(stmt);
    }

    // End of loop
    auto exitCond = genLLVM(test);
    cgs.builder().CreateCondBr(exitCond, loopBlock, nextBlock);
    
    cgs.setActiveBlock(nextBlock);

    if (stmt->hasLabel()) {
      Token label = stmt->getLabel();
      labelsToBlockStarts[label] = loopBlock;
      labelsToBlockEnds[label] = loopBlock;
    }
  }
  
  void genLLVM(Statement* const stmt) {
    auto bd = cgs.builder();
    
    if (ExpressionStmt::classof(stmt)) {
      auto es = static_cast<ExpressionStmt* const>(stmt);
      Expression* e = es->expr;
      genLLVM(e);


      if (stmt->hasLabel()) {
        Token l = stmt->label;
        cout << "Label = " << stmt->label << endl;
        //BasicBlock* blk = &(activeFunction->llvmFunction()->getEntryBlock());
        BasicBlock* blk = &(cgs.getActiveBlock());        
        cout << "Block for label = " << valueString(blk) << endl;
        Instruction* last = &(blk->back());

        cout << "Last instruction" << valueString(last) << endl;
        labelsToInstructions[stmt->label] = last;
      }
      
    } else if (ArgumentDecl::classof(stmt)) {
      auto decl = static_cast<ArgumentDecl* const>(stmt);
      genLLVM(decl);
    } else if (ForStmt::classof(stmt)) {
      auto loop = static_cast<ForStmt* const>(stmt);
      genLLVM(loop);
    } else if (AssignStmt::classof(stmt)) {
      auto asg = static_cast<AssignStmt* const>(stmt);
      genLLVM(asg);
      
    } else if (ReturnStmt::classof(stmt)) {
      genLLVM(sc<ReturnStmt>(stmt));
    } else if (DoWhileLoop::classof(stmt)) {
      genLLVM(sc<DoWhileLoop>(stmt));
    } else {
      // Add support for variable declarations, assignments, and for loops
      cout << "No support for code generation for statement" << endl;
    }

    if (stmt->hasLabel()) {
      cout << "Label = " << stmt->label << endl;
      // How do I tag statement starts and ends with a label?
      // Crude: Track the active block in CodeGenState and just attach
      // the start and end to the last instruction?
    }
    
  }

  SynthCppFunction* getFunction(const std::string& name) {
    cout << "Getting function for " << name << endl;

    // TODO: Generalize to work for any width input
    if (name == "set_port") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo(), intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("set_port", inputs, new VoidType());
      return stb;
    }

    if (name == "add_constraint") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("add_constraint", inputs, new VoidType());
      
      return stb;
    }


    if (name == "start") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("start", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
    }

    if (name == "end") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("end", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
    }

    if (name == "read_port") {
      vector<Type*> inputs =
        {intType(32)->getPointerTo()};
      SynthCppFunction* stb = builtinStub("read_port", inputs, new SynthCppStructType(Token("bit_32")));
      return stb;
    }
    
    for (auto f : functions) {
      cout << "f name = " << f->getName() << endl;
      cout << "name   = " << name << endl;
      if (f->getName() == name) {
        return f;
      }
    }
    assert(false);
  }

  HardwareConstraints& getHardwareConstraints() {
    return hcs;
  }

  InterfaceFunctions& getInterfaceFunctions() {
    return interfaces;
  }

  std::set<BasicBlock*>& getBlocksToPipeline() {
    return blocksToPipeline;
  }
  
  std::vector<SynthCppClass*> getClasses() const {
    return classes;
  }

  std::vector<SynthCppFunction*> getFunctions() const {
    return functions;
  }

};

void optimizeModuleLLVM(llvm::Module& mod) {
  llvm::legacy::PassManager pm;
  pm.add(new LoopInfoWrapperPass());
  pm.add(new AAResultsWrapperPass());
  pm.add(new TargetLibraryInfoWrapperPass());
  pm.add(createGVNPass());
  pm.add(createDeadStoreEliminationPass());
      
  pm.run(mod);
}

void optimizeModuleLLVM(SynthCppModule& scppMod) {
  optimizeModuleLLVM(*(scppMod.mod.get()));
}

MicroArchitecture
synthesizeVerilog(SynthCppModule& scppMod, const std::string& funcName) {
  SynthCppFunction* f = scppMod.getFunction(funcName);

  // Q: How do we pass the hardware constraints on f in to the synthesis flow?
  cout << "Scheduling function" << endl;
  cout << valueString(f->llvmFunction()) << endl;

  cout << "In synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
  for (auto func : scppMod.getInterfaceFunctions().constraints) {
    cout << tab(1) << "# of constraints on " <<
      string(func.first->getName()) << " = " <<
      func.second.constraints.size() << endl;
  }

  // Set pointers to primitives to be registers, not memories
  for (auto& arg : f->llvmFunction()->args()) {
    Type* argTp = arg.getType();
    if (PointerType::classof(argTp)) {
      Type* underlying = dyn_cast<PointerType>(argTp)->getElementType();
      if (IntegerType::classof(underlying)) {
        cout << "Should set " << valueString(&arg) << " to be register" << endl;
        scppMod.getHardwareConstraints().modSpecs.insert({&arg, registerModSpec(getTypeBitWidth(underlying))});
        scppMod.getHardwareConstraints().memSpecs.insert({&arg, registerSpec(getTypeBitWidth(underlying))});
      }
    }
  }
  
  Schedule s =
    scheduleInterfaceZeroReg(f->llvmFunction(),
                             scppMod.getHardwareConstraints(),
                             scppMod.getInterfaceFunctions(),
                             scppMod.getBlocksToPipeline(),
                             scppMod.getInterfaceFunctions().getConstraints(f->llvmFunction()));

  STG graph = buildSTG(s, f->llvmFunction());

  // TODO: Generate these automatically, or change generation code
  // to treat LLVM i<N> as builtin?

  // cout << "Hardware memory constraints before " << endl;
  // for (auto mspec : scppMod.getHardwareConstraints().memSpecs) {
  //   cout << valueString(mspec.first) << " -> " << mspec.second.modSpec.name << endl;
  // }
  
  //setAllAllocaMemTypes(scppMod.getHardwareConstraints(), f->llvmFunction(), registerSpec(32));

  cout << "STG is" << endl;
  graph.print(cout);

  map<Value*, int> layout;  
  auto arch = buildMicroArchitecture(graph, layout, scppMod.getHardwareConstraints());

  VerilogDebugInfo info;
  emitVerilog(arch, info);

  return arch;
}

int main() {
  cout << "Done with statement tests" << endl;

  {
    ifstream t("./experiments/axi_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_read_burst_func");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_read_burst_func")->llvmFunction(),
                            0));
      map<string, int> testLayout = {};
      tb.runCycles = 30;
      tb.maxCycles = 60; // No
      tb.name = "axi_read_burst_func";
      tb.useModSpecs = true;
      tb.settablePort(result, "read_valid");

      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      tb.setArgPort(result, "read_valid", 20, "1");
      tb.setArgPort(result, "read_valid", 21, "0");

      map_insert(tb.actionsOnCycles, 21, assertString("arg_0_out_data === (34)"));

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_read_burst_func_tb.v", "axi_read_burst_func", " builtins.v axi_read_burst_func.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }
  //}
    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_burst_multi");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_burst_multi")->llvmFunction(),
                            0));
      map<string, int> testLayout = {};
      tb.runCycles = 50;
      tb.maxCycles = 60; // No
      tb.name = "axi_burst_multi";
      tb.useModSpecs = true;
      tb.settablePort(result, "read_valid");

      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));        
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      int checkStart = 40;
      tb.setArgPort(result, "read_valid", checkStart, "1");
      tb.setArgPort(result, "read_valid", checkStart + 1, "1");
      tb.setArgPort(result, "read_valid", checkStart + 2, "1");
      tb.setArgPort(result, "read_valid", checkStart + 3, "1");
      tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

      map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
      map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
      map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
      map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_burst_multi_tb.v", "axi_burst_multi", " builtins.v axi_burst_multi.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_write_burst");

      map<llvm::Value*, int> layout = {};
      TestBenchSpec tb;
      auto result =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            0));
      auto input =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            1));
      auto size =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            2));
      auto startLoc =
        sc<Argument>(getArg(scppMod.getFunction("axi_write_burst")->llvmFunction(),
                            3));
      
      map<string, int> testLayout = {};
      tb.runCycles = 100;
      tb.maxCycles = 150; // No
      tb.name = "axi_write_burst";
      tb.useModSpecs = true;
      tb.settablePort(input, "write_valid");
      tb.settablePort(input, "in_data");            
      tb.settablePort(result, "read_valid");

      tb.settablePort(size, "wen");
      tb.settablePort(size, "wdata");            

      tb.settablePort(startLoc, "wen");
      tb.settablePort(startLoc, "wdata");            

      tb.setArgPort(size, "wen", 4, "1");
      tb.setArgPort(size, "wdata", 4, "4");
      tb.setArgPort(size, "wen", 5, "0");      

      tb.setArgPort(startLoc, "wen", 4, "1");
      tb.setArgPort(startLoc, "wdata", 4, "10");      
      tb.setArgPort(startLoc, "wen", 5, "0");
      
      tb.setArgPort(result, "read_valid", 0, "0");
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

      int setStartCycle = 5;
      int burstSize = 5;
      for (int i = 0; i < burstSize; i++) {
        tb.setArgPort(input, "write_valid", setStartCycle + i, "1");
        tb.setArgPort(input, "in_data", setStartCycle + i, to_string(i + 1));
      }
      tb.setArgPort(input, "write_valid", setStartCycle + burstSize, "0");
      
      int checkStart = 90;
      tb.setArgPort(result, "read_valid", checkStart, "1");
      tb.setArgPort(result, "read_valid", checkStart + 1, "1");
      tb.setArgPort(result, "read_valid", checkStart + 2, "1");
      tb.setArgPort(result, "read_valid", checkStart + 3, "1");
      tb.setArgPort(result, "read_valid", checkStart + 4, "0");      

      map_insert(tb.actionsOnCycles, checkStart + 1, assertString("arg_0_out_data === (1)"));
      map_insert(tb.actionsOnCycles, checkStart + 2, assertString("arg_0_out_data === (2)"));
      map_insert(tb.actionsOnCycles, checkStart + 3, assertString("arg_0_out_data === (3)"));
      map_insert(tb.actionsOnCycles, checkStart + 4, assertString("arg_0_out_data === (4)")); 

      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("axi_write_burst_tb.v", "axi_write_burst", " builtins.v axi_write_burst.v RAM.v delay.v ram_primitives.v axi_ram.v"));
    }

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_wb");
    }    

    {
      SynthCppModule scppMod(parseMod);
      auto arch = synthesizeVerilog(scppMod, "axi_rb");
    }    

  }
      
  {
    ifstream t("./experiments/register_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    SynthCppModule scppMod(parseMod);

    cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
    for (auto func : scppMod.getInterfaceFunctions().constraints) {
      cout << tab(1) << "# of constraints on " <<
        string(func.first->getName()) << " = " <<
        func.second.constraints.size() << endl;
    }

    {
      auto arch = synthesizeVerilog(scppMod, "store_to_reg");

      map<llvm::Value*, int> layout = {};

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 30;
      tb.maxCycles = 100;
      tb.name = "store_to_reg";
      tb.useModSpecs = true;
      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 19, assertString("arg_0_out === (15)"));
    
      emitVerilogTestBench(tb, arch, testLayout);

      assert(runIVerilogTest("store_to_reg_tb.v", "store_to_reg", " builtins.v store_to_reg.v RAM.v delay.v ram_primitives.v"));
    }

    {
      auto arch = synthesizeVerilog(scppMod, "instantiate_reg");
    }

  }
  
  {
    ifstream t("./experiments/ram_iclass.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    cout << "Tokens" << endl;
    for (auto t : tokens) {
      cout << "\t" << t.getStr() << endl;
    }

    ParserModule parseMod = parse(tokens);

    cout << parseMod << endl;

    assert(parseMod.getStatements().size() >= 2);

    SynthCppModule scppMod(parseMod);

    assert(scppMod.getClasses().size() >= 1);
    assert(scppMod.getFunctions().size() >= 1);

    cout << "Before synthesize verilog: # of interface functions = " << scppMod.getInterfaceFunctions().constraints.size() << endl;
    for (auto func : scppMod.getInterfaceFunctions().constraints) {
      cout << tab(1) << "# of constraints on " <<
        string(func.first->getName()) << " = " <<
        func.second.constraints.size() << endl;
    }
    
    auto arch = synthesizeVerilog(scppMod, "filter_ram");

    map<llvm::Value*, int> layout = {};

    auto in =
      sc<Argument>(getArg(scppMod.getFunction("filter_ram")->llvmFunction(), 0));
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 70;
    tb.maxCycles = 100;
    tb.name = "filter_ram";
    tb.useModSpecs = true;
    tb.settablePort(in, "debug_addr");
    tb.settablePort(in, "debug_write_addr");
    tb.settablePort(in, "debug_write_data");
    tb.settablePort(in, "debug_write_en");            

    tb.setArgPort(in, "debug_write_addr", 1, "0");
    tb.setArgPort(in, "debug_write_data", 1, "6");
    tb.setArgPort(in, "debug_write_en", 1, "1");    

    tb.setArgPort(in, "debug_write_addr", 2, "1");
    tb.setArgPort(in, "debug_write_data", 2, "8");
    tb.setArgPort(in, "debug_write_en", 2, "1");    

    tb.setArgPort(in, "debug_write_en", 3, "0");
    map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 75, assertString("valid === 1"));
    
    tb.setArgPort(in, "debug_addr", 76, "10");
    map_insert(tb.actionsOnCycles, 76, assertString("arg_0_debug_data === (8 + 6)"));
    
    emitVerilogTestBench(tb, arch, testLayout);

    // Need to figure out how to inline register specifications
    assert(runIVerilogTest("filter_ram_tb.v", "filter_ram", " builtins.v filter_ram.v RAM.v delay.v ram_primitives.v"));
  }

  {
    ifstream t("./experiments/eth_axi_tx.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule mod = parse(tokens);

    cout << "Ethernet mod" << endl;
    cout << mod << endl;

    
    assert(mod.getStatements().size() >= 1);

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_header_func");
    }

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_byte_func");
 
      llvm::legacy::PassManager pm;
      pm.add(new LoopInfoWrapperPass());
      pm.add(new AAResultsWrapperPass());
      pm.add(new TargetLibraryInfoWrapperPass());
      pm.add(createGVNPass());
      pm.add(createDeadStoreEliminationPass());
      cout << "Before GVN pass" << endl;
      cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
      
      pm.run(*(scppMod.mod.get()));

      cout << "After GVN" << endl;
      cout << valueString(scppMod.getFunction("write_byte_func")->llvmFunction()) << endl;
    }

    {
      SynthCppModule scppMod(mod);    
      auto arch = synthesizeVerilog(scppMod, "write_one_byte_packet");
      map<llvm::Value*, int> layout = {};

      auto tx =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 4));
      auto dest_mac =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 0));
      auto src_mac =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 1));
      auto type =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 2));
      auto payload =
        sc<Argument>(getArg(scppMod.getFunction("write_one_byte_packet")->llvmFunction(), 3));

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 200;
      tb.maxCycles = 300;
      tb.name = "write_one_byte_packet";
      tb.useModSpecs = true;
      tb.settablePort(tx, "m_axis_tready");
      tb.settablePort(dest_mac, "wdata");
      tb.settablePort(src_mac, "wdata");
      tb.settablePort(type, "wdata");
      tb.settablePort(payload, "wdata");                  

      tb.settablePort(dest_mac, "wen");
      tb.settablePort(src_mac, "wen");
      tb.settablePort(type, "wen");
      tb.settablePort(payload, "wen");                  

      map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
      map_insert(tb.actionsInCycles, 1, string("arg_0_wdata <= 25;"));
      map_insert(tb.actionsInCycles, 1, string("arg_1_wdata <= 13;"));
      map_insert(tb.actionsInCycles, 1, string("arg_2_wdata <= 8;"));
      map_insert(tb.actionsInCycles, 1, string("arg_3_wdata <= 49;"));

      map_insert(tb.actionsInCycles, 1, string("arg_0_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_1_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_2_wen <= 1;"));
      map_insert(tb.actionsInCycles, 1, string("arg_3_wen <= 1;"));

      map_insert(tb.actionsInCycles, 2, string("arg_0_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_1_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_2_wen <= 0;"));
      map_insert(tb.actionsInCycles, 2, string("arg_3_wen <= 0;"));
      
      map_insert(tb.actionsInCycles, 0, string("arg_4_m_axis_tready = 1;"));
      map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
      emitVerilogTestBench(tb, arch, testLayout);

      // Need to figure out how to inline register specifications
      assert(runIVerilogTest("write_one_byte_packet_tb.v", "write_one_byte_packet", " builtins.v write_one_byte_packet.v RAM.v delay.v ram_primitives.v eth_axis_tx.v"));
      
    }

  }

  {
    ifstream t("./experiments/fadd.cpp");
    std::string str((std::istreambuf_iterator<char>(t)),
                    std::istreambuf_iterator<char>());

    auto tokens = tokenize(str);
    ParserModule mod = parse(tokens);
    
    SynthCppModule scppMod(mod);

    cout << "-- Float adder" << endl;
    SynthCppClass* c = scppMod.getClassByName(Token("adder"));
    cout << *c << endl;
    cout << "-- End of adder" << endl;

    auto arch = synthesizeVerilog(scppMod, "fadd_32");

    map<llvm::Value*, int> layout = {};

    auto in0 =
      sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 0));
    auto in1 =
      sc<Argument>(getArg(scppMod.getFunction("fadd_32")->llvmFunction(), 1));
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 200;
    tb.maxCycles = 300;
    tb.name = "fadd_32";
    tb.useModSpecs = true;
    tb.settablePort(in0, "in_data");
    tb.settablePort(in1, "in_data");
      
    map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
    emitVerilogTestBench(tb, arch, testLayout);

    // Need to figure out how to inline register specifications
    //assert(runIVerilogTest("fadd_32_tb.v", "fadd_32", " builtins.v fadd_32.v"));
  }

  class Img {
    vector<int> values;
    int nRows, nCols;

  public:

    Img(const int nRows_, const int nCols_) : nRows(nRows_), nCols(nCols_) {
      values.resize(nRows*nCols);
    }

    int get(const int i, const int j) {
      assert(i < nRows);
      assert(j < nCols);
      
      return values[i*nCols + j];
    }

    void set(const int i, const int j, const int val) {
      values[i*nCols + j] = val;
    }

  };

  // {
  //   ifstream t("./experiments/median_filter.cpp");
  //   std::string str((std::istreambuf_iterator<char>(t)),
  //                   std::istreambuf_iterator<char>());

  //   auto tokens = tokenize(str);
  //   ParserModule mod = parse(tokens);
    
  //   SynthCppModule scppMod(mod);

  //   auto arch = synthesizeVerilog(scppMod, "run_median_func");

  //   {
  //     int imgWidth = 5;
  //     Img image(imgWidth, imgWidth);
  //     for (int i = 0; i < imgWidth; i++) {
  //       for (int j = 0; j < imgWidth; j++) {
  //         image.set(i, j, i*imgWidth + j);
  //       }
  //     }

  //     auto word0 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 1));
  //     auto word1 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 2));
  //     auto word2 =
  //       sc<Argument>(getArg(scppMod.getFunction("run_median_func")->llvmFunction(), 3));

  //     TestBenchSpec tb;
  //     map<string, int> testLayout = {};
  //     tb.memoryInit = {};
  //     tb.memoryExpected = {};
  //     tb.runCycles = 30;
  //     tb.maxCycles = 50;
  //     tb.name = "run_median_func";
  //     tb.useModSpecs = true;

  //     map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
  //     map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
  //     map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));
    
  //     tb.actionOnCondition("1", "$display(\"pixel1 = %d, pixel2 = %d, pixel3 = %d, pixel4 = %d\", arg_4_in_wire, arg_5_in_wire, arg_6_in_wire, arg_7_in_wire);");

  //     int loadWidth = 4;
  //     int startLoadCycle = 3;
  //     int stencilWidth = 3;

  //     int activeCycle = startLoadCycle;
  //     vector<Argument*> rows{word0, word1, word2};

  //     //for (int i = 0; i < imgWidth - (stencilWidth - 1); i++) {
  //     for (int i = 0; i < imgWidth - 1; i++) {

  //       // Clear row
  //       for (int k = 0; k < 3; k++) {
  //         setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //         activeCycle++;
  //       }
        
  //       for (int j = 0; j < imgWidth - (loadWidth - 1); j += loadWidth) {
  //       //for (int j = 0; j < imgWidth; j += loadWidth) {
  //         // Assemble values;
  //         for (int row = 0; row < stencilWidth; row++) {
  //           auto word = rows[row];
  //           string values = "";
  //           for (int col = 0; col < loadWidth; col++) {
  //             if ((i + row) < imgWidth) {
  //               values += "8'd" + to_string(image.get(i + row, j + col));
  //             } else {
  //               values += "8'hff";
  //             }

  //             if (col != (loadWidth - 1)) {
  //               values += ",";
  //             }
  //           }
  //           tb.setArgPort(word, "in_wire", activeCycle,
  //                         //startLoadCycle + i + (j / loadWidth),
  //                         "{" + values + "}");
  //         }
  //         activeCycle++;            
          

  //       }

  //       // setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //       // activeCycle++;
  //     }

  //     // for (int k = 0; k < 3; k++) {
  //     //   setZeroRows(tb, activeCycle, stencilWidth, loadWidth, rows);
  //     //   activeCycle++;
  //     // }
      
  //     tb.settablePort(word0, "in_wire");
  //     tb.settablePort(word1, "in_wire");
  //     tb.settablePort(word2, "in_wire");    

  //     //map_insert(tb.actionsOnCycles, 200, assertString("valid === 1"));
    
  //     emitVerilogTestBench(tb, arch, testLayout);
  //     assert(runIVerilogTest("run_median_func_tb.v", "run_median_func", " builtins.v run_median_func.v RAM.v delay.v ram_primitives.v eth_axis_tx.v median_wires.v median.v state_machine.v node.v common_network.v dff_3_pipe.v pixel_network.v"));
  //   }
  // }
  
}
