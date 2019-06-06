#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"
#include "parser.h"

#include <llvm/IR/LegacyPassManager.h>
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/Mem2Reg.h"

#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Transforms/Scalar/SimplifyCFG.h"
#include "llvm/Transforms/Scalar/DCE.h"
#include "llvm/Transforms/Scalar/ADCE.h"
#include "llvm/Transforms/Scalar/LoopSimplifyCFG.h"
#include "llvm/Transforms/Utils/PromoteMemToReg.h"
#include "llvm/IR/Dominators.h"
#include <llvm/Analysis/CFG.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  set<Instruction*> allInstrs(Function* f) {
    set<Instruction*> instrs;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        instrs.insert(&instrR);
      }
    }
    return instrs;
  }

  void
  checkValidChannel(MicroArchitecture& arch,
                    VerilogDebugInfo& info,
                    Value* targetChannel,
                    const std::string& validName,
                    const std::string& dataName,
                    const std::vector<std::string>& expectedWriteValues) {
    Instruction* channelWrite = nullptr;
    Instruction* channelValidCheck = nullptr;    

    for (auto instr : allInstrs(arch.stg.getFunction())) {
      if (isBuiltinPortWrite(instr)) {
        string portName = getPortName(instr);

        cout << "Checking port " << portName << " in instr " << valueString(instr) << endl;
        cout << tab(1) << "channel = " << valueString(instr->getOperand(0)) << endl;
        cout << tab(1) << "target  = " << valueString(targetChannel) << endl;        

        if ((portName == dataName) &&
            (instr->getOperand(0) == targetChannel)) {
          channelWrite = instr;
        }

        if ((portName == validName) &&
            (instr->getOperand(0) == targetChannel)) {
          channelValidCheck = instr;
        }
      }
    }
    
    assert(channelWrite != nullptr);
    assert(channelValidCheck != nullptr);    

    StateId writeValidCheckState = arch.stg.instructionStartState(channelValidCheck);
    StateId writeDataState = arch.stg.instructionStartState(channelWrite);

    assert(writeDataState == writeValidCheckState);

    Wire incrCond = blockActiveInState(writeValidCheckState, channelValidCheck->getParent(), arch);
    Wire ithValid = buildIncCounter(incrCond, 32, arch);
    for (int i = 0; i < (int) expectedWriteValues.size(); i++) {
      string expectedVal = expectedWriteValues[i];

      auto pos = position(writeValidCheckState, channelValidCheck, arch);
      string ev =
        andStr(parens(ithValid.valueString() + " === " + to_string(i)),
               incrCond.valueString());
      string writeIsExpectedVal =
        parens(outputName(channelWrite->getOperand(1), pos, arch) + " == " + expectedVal);
      addAssert(implies(ev, writeIsExpectedVal), info);
    }

  }  
  

  class HalideArchSettings {
  public:
    bool loopTasks;
    bool pushFifos;
    bool forToWhile;
    bool optimizeFifos;

    HalideArchSettings() : loopTasks(true), pushFifos(false), forToWhile(false), optimizeFifos(false) {}
  };

  ModuleSpec pushFifoSpec(int width, int depth) {
    map<string, Port> fifoPorts = {
      {"in_data", inputPort(width, "in_data")},
      {"write_valid", inputPort(1, "write_valid")},

      {"out_data", outputPort(width, "out_data")},
      {"read_valid", outputPort(1, "read_valid")},
    };

    map<string, int> defaults;
    defaults.insert({"write_valid", 0});    

    set<string> insensitivePorts{"in_data"};
    ModuleSpec modSpec = {{{"WIDTH", to_string(width)}}, "push_fifo", fifoPorts, defaults, insensitivePorts};
    modSpec.hasClock = true;
    modSpec.hasRst = true;
    return modSpec;
  }
  
  int64_t getInt(Value* val) {
    assert(ConstantInt::classof(val));
    int64_t ival = dyn_cast<ConstantInt>(val)->getSExtValue();
    return ival;
  }

  bool isBuiltinPushLBType(Type* allocTp) {
    if (StructType::classof(allocTp)) {
      return hasPrefix(dyn_cast<StructType>(allocTp)->getName(), "hls.lb.");
    }
    return false;
  }

  // TODO: Need to add image width
  ModuleSpec pushLBModSpec(int inWidth, int outWidth) {
    map<string, Port> fifoPorts = {
      {"wdata", inputPort(inWidth, "wdata")},
      {"wen", inputPort(1, "wen")},

      {"rdata", outputPort(outWidth, "rdata")},
      {"valid", outputPort(1, "valid")}
    };

    map<string, int> defaults;
    defaults.insert({"wen", 0});

    set<string> insensitivePorts{"in_data"};
    ModuleSpec modSpec = {{{"IN_WIDTH", to_string(inWidth)},
                           {"OUT_WIDTH", to_string(outWidth)}}, "push_linebuf", fifoPorts, defaults, insensitivePorts};
    modSpec.hasClock = true;
    modSpec.hasRst = true;
    return modSpec;
  }

  HalideStencilTp stencilSpec(const std::string& stencilName) {
    int typeWidth = stencilTypeWidth(stencilName);
    int nRows = stencilNumRows(stencilName);
    int nCols = stencilNumCols(stencilName);
    return {typeWidth, nRows, nCols};
  }
  
  LBSpec lbSpec(const std::string& lbName) {
    assert(hasPrefix(lbName, "class.linebuffer_"));
    string restOfName = drop("class.linebuffer_", lbName);
    auto inAndOutBnds = splitOn("_to_", lbName);
    auto outAndBnds = splitOn("_bnds_", inAndOutBnds.second);
    auto inSpec = stencilSpec(drop("hls_stream_", inAndOutBnds.first));
    auto outSpec = stencilSpec(drop("hls_stream", outAndBnds.first));

    return LBSpec{inSpec, outSpec};
  }

  LBSpec lbSpec(Type* const lbName) {
    return lbSpec(extract<StructType>(lbName)->getName());
  }

  int lbInWidth(Type* lbTp) {
    auto lbTpName = extract<StructType>(lbTp)->getName();
    return stoi(takeUntil(".", drop("hls.lb.", lbTpName)));
  }

  int lbOutWidth(Type* lbTp) {
    auto lbTpName = extract<StructType>(lbTp)->getName();
    return stoi(takeUntil(".", drop(".", drop("hls.lb.", lbTpName))));
    
    //return 32;
  }

  Type* halideType(Type* tp) {
    if (PointerType::classof(tp)) {
      Type* underlying = dyn_cast<PointerType>(tp)->getElementType();
      return halideType(underlying)->getPointerTo();
    } else if (StructType::classof(tp)) {
      StructType* stp = dyn_cast<StructType>(tp);
      string name = stp->getName();
      if (hasPrefix(name, "class.AxiPackedStencil_")) {
        int typeWidth = stencilTypeWidth(name);
        int nRows = stencilNumRows(name);
        int nCols = stencilNumCols(name);
        return intType(typeWidth*nRows*nCols);
      } else if (hasPrefix(name, "class.hls_stream")) {
        string stencilName = streamStencilName(name);        
        int typeWidth = stencilTypeWidth(stencilName);
        int nRows = stencilNumRows(stencilName);
        int nCols = stencilNumCols(stencilName);
        return fifoType(typeWidth*nRows*nCols);
      } else if (hasPrefix(name, "class.linebuffer")) {
        // TODO: Actually compute these
        //HalideStencilTp stencilIn{16, 1, 1};
        //HalideStencilTp stencilOut{16, 1, 2};

        LBSpec spec = lbSpec(tp);
        //return lbType(16, 16*2);
        return lbType(spec);
      } else {
        return tp;
      }
    } else {
      return tp;
    }
  }

  bool isConstructor(const std::string& classPrefix, Function* func) {
    string name = func->getName();
    if (canDemangle(name)) {
      name = demangle(name);
      if (hasPrefix(name, classPrefix)) {
        string mName = drop("::", name);
        string rName = takeUntil("(", mName);
        return hasPrefix(rName, classPrefix);
      }
    }

    return false;
  }

  Value* findSource(Value* val, map<Value*, Value*>& rewrites) {
    for (auto& ent : rewrites) {
      if (ent.second == val) {
        return ent.first;
      }
    }
    cout << "Error: No source entry for " << valueString(val) << endl;
    assert(false);
  }
  
  Value* findRewrite(Value* val, map<Value*, Value*>& rewrites) {
    if (ConstantInt::classof(val)) {
      return mkInt(getInt(val), getValueBitWidth(val)); //val;
    }

    if (!contains_key(val, rewrites)) {
      cout << "Error: No rewrite for " << valueString(val) << endl;
    }
    
    assert(contains_key(val, rewrites));
    return map_find(val, rewrites);
  }

  int streamWidth(const std::string& name) {
    cout << "Stram name = " << name << endl;
    string stencilName = streamStencilName(name);
    int typeWidth = stencilTypeWidth(stencilName);
    int nRows = stencilNumRows(stencilName);
    int nCols = stencilNumCols(stencilName);

    return typeWidth*nRows*nCols;
  }

  int streamWidth(Type* strm) {
    StructType* tp = extract<StructType>(getPointedToType(strm));
    string name = tp->getName();
    return streamWidth(name);
  }
  
  int streamWidth(Value* strm) {
    Type* tp = strm->getType();
    return streamWidth(tp);
  }

  llvm::Function* fifoReadRefFunction(const int width) {
    vector<Type*> ins{intType(width)->getPointerTo(),
        fifoType(width)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "fifo_read_ref." + to_string(width));
    f->addParamAttr(0, llvm::Attribute::ByVal);        
    return f;
  }

  llvm::Function* lbHasValidFunction(Value* replacementLB) {
    vector<Type*> ins{replacementLB->getType()};
    int width = 0;
    auto f = mkFunc(ins, intType(1), "lb_has_valid." + to_string(width));
    return f;
  }
  
  llvm::Function* fifoWriteRefFunction(const int width) {
    vector<Type*> ins{fifoType(width)->getPointerTo(),
        intType(width)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "fifo_write_ref." + to_string(width));
    f->addParamAttr(1, llvm::Attribute::ByVal);
    return f;
  }

  // W?
  Function* lbWriteFunction(Value* replacementLB) {
    // TODO: compute this width    
    int inWidth = 16;
    vector<Type*> ins{replacementLB->getType(), intType(inWidth)->getPointerTo()};
    auto f = mkFunc(ins, voidType(), "lb_push." + to_string(inWidth));
    f->addParamAttr(1, llvm::Attribute::ByVal);        
    return f;
  }

  Function* lbReadFunction(Value* replacementLB) {
    // TODO: compute this width
    int outWidth = 32;
    vector<Type*> ins{intType(outWidth)->getPointerTo(), replacementLB->getType()};
    auto f = mkFunc(ins, voidType(), "lb_pop." + to_string(outWidth));
    f->addParamAttr(0, llvm::Attribute::ByVal);    
    return f;
  }
  
  void rewriteInstr(Function* f,
                    Function* orig,
                    map<BasicBlock*, BasicBlock*>& bbRewrites,
                    map<Value*, Value*>& rewrites,
                    Instruction* toRewrite) {
    BasicBlock* repBB = map_find(toRewrite->getParent(), bbRewrites);

    assert(repBB->getParent() == f);
    
    IRBuilder<> b(repBB);
    if (AllocaInst::classof(toRewrite)) {
      AllocaInst* alloc = dyn_cast<AllocaInst>(toRewrite);
      Type* allocTp = halideType(alloc->getType()->getElementType());
      auto* rw = b.CreateAlloca(allocTp);
      rewrites[toRewrite] = rw;
    } else if (CallInst::classof(toRewrite)) {
      CallInst* callToRW = dyn_cast<CallInst>(toRewrite);
      Function* func = callToRW->getCalledFunction();

      if (isMethod("AxiPackedStencil_", "get", func)) {
        // TODO: Compute these strides
        vector<int64_t> strides{0, 16, 0, 0, 0, 0};
        int bitOffset = 0;
        int stride = strides[0];
        cout << "-- Starting stride comp for " << valueString(toRewrite) << endl;
        for (int i = 1; i < (int) func->arg_size(); i++) {
          Value* index = toRewrite->getOperand(i);
          cout << "Index = " << valueString(index) << endl;
          int64_t indI = getInt(index);
          cout << "indI = " << indI << ", stride = " << stride << endl;
          bitOffset += indI*stride;
          stride = strides[i];
        }

        cout << "Get bit offset in stencil reg = " << bitOffset << endl;

        auto fullLoad =
          b.CreateLoad(findRewrite(toRewrite->getOperand(0), rewrites));

        int typeWidth = getValueBitWidth(toRewrite);
        if (bitOffset > 0) {
          cout << "Bit offset = " << bitOffset << " not zero" << endl;
          auto shifted = b.CreateLShr(fullLoad, mkInt(bitOffset, getValueBitWidth(fullLoad)));
          cout << "shift = " << valueString(shifted) << endl;

          rewrites[toRewrite] = b.CreateTrunc(shifted, intType(typeWidth));
          
        } else {
          rewrites[toRewrite] = b.CreateTrunc(fullLoad, intType(getValueBitWidth(toRewrite)));
        }
      } else if (isMethod("AxiPackedStencil_", "set", func)) {
        // TODO: Add indexing
        rewrites[toRewrite] =
          b.CreateStore(findRewrite(toRewrite->getOperand(1), rewrites),
                        findRewrite(toRewrite->getOperand(0), rewrites));
        
      } else if (isConstructor("hls_stream", func)) {
        // Do nothing, the constructor is a no-op
      } else if (isMethod("hls_stream", "read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        auto replaceF = fifoReadRefFunction(streamWidth(toRewrite->getOperand(1)));
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (isMethod("hls_stream", "write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        auto replaceF = fifoWriteRefFunction(streamWidth(toRewrite->getOperand(0)));
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else if (isConstructor("AxiPackedStencil_", func)) {
        cout << "Replacing stencil constructor " << valueString(toRewrite) << endl;
        
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        if (argReplacements.size() == 1) {
          // Do nothing
          return;
        }
        
        assert(argReplacements.size() == 2);

        auto source = b.CreateLoad(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateStore(source, argReplacements[0]);
      } else if (isMethod("AxiPackedStencil_", "copy", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() == 2);

        auto source = b.CreateLoad(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateStore(source, argReplacements[0]);
      } else if (isMethod("AxiPackedStencil_", "set_last", func)) {
        // Do nothing
      } else if (isMethod("ram_", "ram_write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        // TODO: Replace with builtin ram read function
        int w =
          ramDataWidth(typeString(getPointedToType(getArg(func, 0)->getType())));
        // asdf
        int d =
          ramDepth(typeString(getPointedToType(getArg(func, 0)->getType())));
        auto replacement = ramStoreFunction(w, d);
        rewrites[toRewrite] =
          b.CreateCall(replacement, argReplacements);
      } else if (isMethod("ram_", "ram_read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        // TODO: Replace with builtin ram read function
        int w =
          ramDataWidth(typeString(getPointedToType(getArg(func, 0)->getType())));
        // asdf
        int d =
          ramDepth(typeString(getPointedToType(getArg(func, 0)->getType())));
        auto replacement = ramLoadFunction(w, d);
        rewrites[toRewrite] =
          b.CreateCall(replacement, argReplacements);
      } else if (isMethod("linebuffer_", "lb_write", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        auto replaceF = lbWriteFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
        
      } else if (isMethod("linebuffer_", "lb_read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        // TODO: Replace with real lb stats
        auto replaceF = lbReadFunction(argReplacements[1]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
        
      } else if (isMethod("linebuffer_", "has_valid_data", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        assert(argReplacements.size() > 0);
        
        // TODO: Replace with real lb stats
        auto replaceF = lbHasValidFunction(argReplacements[0]);
        rewrites[toRewrite] =
          b.CreateCall(replaceF, argReplacements);
      } else {
        cout << "Unsupported call" << valueString(toRewrite) << endl;
        if (canDemangle(func->getName())) {
          cout << "\tDemangled name = " << demangle(func->getName()) << endl;
        }
        assert(false);
      }
    } else if (BranchInst::classof(toRewrite)) {
      BranchInst* bi = dyn_cast<BranchInst>(toRewrite);
      if (bi->isConditional()) {
        //cout << "Error: Conditional branch " << valueString(toRewrite) << endl;
        //assert(false);
        assert(bi->getNumSuccessors() == 2);

        auto cond = findRewrite(bi->getOperand(0), rewrites);
        auto rLHS = map_find(bi->getSuccessor(0), bbRewrites);
        auto rRHS = map_find(bi->getSuccessor(1), bbRewrites);

        rewrites[toRewrite] = b.CreateCondBr(cond, rLHS, rRHS);
      } else {
        auto* targetInRewritten = map_find(bi->getSuccessor(0), bbRewrites);
        auto newBr = b.CreateBr(targetInRewritten);
        rewrites[toRewrite] = newBr;
      }

    } else if (PHINode::classof(toRewrite)) {
      int reservedVals = dyn_cast<PHINode>(toRewrite)->getNumIncomingValues();
      auto* replacement = b.CreatePHI(halideType(toRewrite->getType()), reservedVals);
      rewrites[toRewrite] = replacement;
    } else if (ZExtInst::classof(toRewrite)) {
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      rewrites[toRewrite] = b.CreateZExt(rLHS, toRewrite->getType());
      
    } else if (TruncInst::classof(toRewrite)) {
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      rewrites[toRewrite] = b.CreateTrunc(rLHS, toRewrite->getType());
      
    } else if (BinaryOperator::classof(toRewrite)) {
      llvm::Instruction::BinaryOps opcode =
        dyn_cast<BinaryOperator>(toRewrite)->getOpcode();

      cout << "Getting " << valueString(toRewrite->getOperand(0)) << endl;
      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);

      auto rRHS = findRewrite(toRewrite->getOperand(1), rewrites);      

      cout << "Got binop" << endl;
      rewrites[toRewrite] = b.CreateBinOp(opcode, rLHS, rRHS);
    } else if (ICmpInst::classof(toRewrite)) {
      llvm::ICmpInst::Predicate pred =
        dyn_cast<CmpInst>(toRewrite)->getPredicate();

      auto rLHS = findRewrite(toRewrite->getOperand(0), rewrites);
      auto rRHS = findRewrite(toRewrite->getOperand(1), rewrites);

      rewrites[toRewrite] = b.CreateICmp(pred, rLHS, rRHS);
      
    } else if (ReturnInst::classof(toRewrite)) {
      assert(toRewrite->getType()->isVoidTy());
      rewrites[toRewrite] = b.CreateRet(nullptr);
    } else {
      cout << "Error in Halide stencil rewrite: Unsupported instr = " << valueString(toRewrite) << endl;
      assert(false);
    }

  }

  void populatePHIs(Function* orig,
                    Function* f,
                    map<Value*, Value*>& rewrites,
                    map<BasicBlock*, BasicBlock*>& bbRewrites) {
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        Instruction* instr = &instrR;
        if (PHINode::classof(instr)) {

          cout << "Found phi " << valueString(instr) << endl;
          auto newPhi = dyn_cast<PHINode>(instr);
          
          auto origP = findSource(dyn_cast<Value>(instr), rewrites);
          assert(PHINode::classof(origP));
          auto origPhi = dyn_cast<PHINode>(origP);

          cout << "Populating replacement for " << valueString(origPhi) << endl;
          
          for (int i = 0; i < origPhi->getNumIncomingValues(); i++) {
            cout << "Getting " << i << "th block" << endl;
            BasicBlock* replaceBB =
              map_find(origPhi->getIncomingBlock(i), bbRewrites);
            cout << "Getting " << i << "th value" << endl;            

            Value* replaceVal =
              findRewrite(origPhi->getIncomingValue(i), rewrites);

            cout << "Getting " << i << "th value" << endl;                        
            newPhi->addIncoming(replaceVal, replaceBB);
          }
        }
      }
    }
  }
  
  Function* rewriteHalideStencils(Function* orig) {
    vector<Type*> inputTypes;
    for (int i = 0; i < orig->arg_size(); i++) {
      Type* rwTp = halideType(getArg(orig, i)->getType());
      inputTypes.push_back(rwTp);
    }
    Function* f = mkFunc(inputTypes, string(orig->getName( )) + "_rewritten", &(getGlobalLLVMModule()));

    map<Value*, Value*> rewrites;
    for (int i = 0; i < orig->arg_size(); i++) {
      rewrites[getArg(orig, i)] = getArg(f, i);
    }

    map<BasicBlock*, BasicBlock*> bbRewrites;
    for (auto& bb : orig->getBasicBlockList()) {
      bbRewrites[&bb] = mkBB(string(bb.getName()), f);
    }
    
    for (auto& bb : orig->getBasicBlockList()) {
      for (auto& instrR : bb) {
        Instruction* instr = &instrR;
        rewriteInstr(f, orig, bbRewrites, rewrites, instr);
      }
    }

    populatePHIs(orig, f, rewrites, bbRewrites);

    cout << "Immediately after rewrite " << endl;
    cout << valueString(f) << endl;
    
    sanityCheck(f);
    
    return f;
  }

  int builtinFifoWidth(Type* tp) {
    if (StructType::classof(tp)) {
      return stoi(drop("builtin_fifo_", dyn_cast<StructType>(tp)->getName()));
    }
    assert(false);
  }
  
  bool isBuiltinFifoType(Type* tp) {
    if (StructType::classof(tp)) {
      return hasPrefix(dyn_cast<StructType>(tp)->getName(), "builtin_fifo_");
    }
    return false;
  }
  
  void assignModuleSpecs(Function* f, HardwareConstraints& hcs, HalideArchSettings& settings) {
    
    for (int i = 0; i < f->arg_size(); i++) {
      auto argTp = getPointedToType(getArg(f, i)->getType());
      if (isBuiltinFifoType(argTp)) {
        if (!settings.pushFifos) {
          hcs.modSpecs[getArg(f, i)] = fifoSpec(builtinFifoWidth(argTp), 128);
        } else {
          hcs.modSpecs[getArg(f, i)] = pushFifoSpec(builtinFifoWidth(argTp), 128);
        }
      }
    }
    
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (AllocaInst::classof(instr)) {
          auto allocTp = getPointedToType(instr->getType());
          cout << "Allocating type " << typeString(allocTp) << endl;
          if (isBuiltinFifoType(allocTp)) {
            if (!settings.pushFifos) {
              hcs.modSpecs[instr] = fifoSpec(builtinFifoWidth(allocTp), 128);
            } else {
              hcs.modSpecs[instr] = pushFifoSpec(builtinFifoWidth(allocTp), 128);
            }
          } else if (isBuiltinPushLBType(allocTp)) {
            hcs.modSpecs[instr] = pushLBModSpec(lbInWidth(allocTp), lbOutWidth(allocTp));
          } else if (IntegerType::classof(allocTp)) {
            hcs.memSpecs[instr] = registerSpec(getTypeBitWidth(allocTp));
          } else {
            cout << "Unrecognized alloc type = " << typeString(allocTp) << endl;
          }
        }
      }
    }

    hcs.memoryMapping = memoryOpLocations(f);
  }

  bool precedes(BasicBlock* predBlk, BasicBlock* succBlk, vector<BasicBlock*> blkOrder) {
    if (predBlk == succBlk) {
      return false;
    }
    int predPos =
      distance(blkOrder.begin(), find(blkOrder.begin(), blkOrder.end(), predBlk));

    int succPos =
      distance(blkOrder.begin(), find(blkOrder.begin(), blkOrder.end(), succBlk));

    return (succPos - predPos) > 0;
  }

  bool isRAMWrite(Instruction* instr) {
    if (CallInst::classof(instr)) {
      CallInst* ci = dyn_cast<CallInst>(instr);
      cout << "Name of called = "
           << string(ci->getCalledFunction()->getName())
           << endl;
      return hasPrefix(ci->getCalledFunction()->getName(), "ram.write.");
    }

    return false;
  }

  bool isRAMRead(Instruction* instr) {
    if (CallInst::classof(instr)) {
      CallInst* ci = dyn_cast<CallInst>(instr);
      return hasPrefix(ci->getCalledFunction()->getName(), "ram.read.");
    }

    return false;
  }

  bool isRAMType(Type* tp) {
    if (StructType::classof(tp)) {
      return hasPrefix(dyn_cast<StructType>(tp)->getName(), "class.ram_");
    }

    return false;
  }

  TaskSpec wholeFunctionTask(Function* const f) {
    set<BasicBlock*> blks;
    for (auto& bb : *f) {
      blks.insert(&bb);
    }
    return {blks};
  }
  
  void implementPushFifoWriteRef(llvm::Function* writeFifo,
                                 ExecutionConstraints& exec) {

    auto out = getArg(writeFifo, 0);


    auto dataPtr = getArg(writeFifo, 1);

    assert(PointerType::classof(dataPtr->getType()));

    auto dataPtrTp = dyn_cast<PointerType>(dataPtr->getType());

    auto tp = out->getType();
    
    int width = getTypeBitWidth(dataPtrTp->getElementType());
    
    auto writeDataF = writePort("in_data", width, tp);
    auto setValidF = writePort("write_valid", 1, tp);

    auto entryBlk = mkBB("entry_block", writeFifo);

    IRBuilder<> entryBuilder(entryBlk);
    auto setValid1 = entryBuilder.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto data = entryBuilder.CreateLoad(dataPtr);    
    auto writeValue = entryBuilder.CreateCall(writeDataF, {out, data});
    auto ret = entryBuilder.CreateRet(nullptr);

    exec.add(instrEnd(data) == instrStart(writeValue));
    exec.add(instrEnd(data) == instrStart(setValid1));
    //exec.add(instrStart(writeValue) + 1 == instrStart(ret));
    exec.add(instrStart(writeValue) == instrStart(ret));
    
    addDataConstraints(writeFifo, exec);
  }
  
  void implementPushFifoReadRef(llvm::Function* readFifo, ExecutionConstraints& exec) {

    auto out = getArg(readFifo, 0);
    auto fifo = getArg(readFifo, 1);
    auto tp = getPointedToType(out->getType());

    int width = getTypeBitWidth(tp);

    auto readInDataF = readPort("out_data", width, tp);
    
    auto entryBlk = mkBB("entry_block", readFifo);

    IRBuilder<> entryBuilder(entryBlk);
    auto readValue = entryBuilder.CreateCall(readInDataF, {fifo});    
    auto store = entryBuilder.CreateStore(readValue, out);
    auto ret = entryBuilder.CreateRet(nullptr);
    
    exec.add(instrStart(store) == instrEnd(readValue));
    exec.add(instrEnd(store) == instrStart(ret));

    addDataConstraints(readFifo, exec);
  }  

  bool isPerfect(Loop* loop) {
    if (loop->getSubLoops().size() == 0) {
      return true;
    }

    return true;
  }

  class DataflowNestInfo {
  public:
    vector<int> tripCounts;
    set<BasicBlock*> body;
    set<Instruction*> blockingOps;
  };

  DataflowNestInfo computeDataflowInfo(Loop* loop, ScalarEvolution& scev) {
    DataflowNestInfo info;

    Loop* activeLoop = loop;
    while (activeLoop->getSubLoops().size() > 0) {
      assert(activeLoop->getSubLoops().size() == 1);

      unsigned tc = scev.getSmallConstantTripCount(activeLoop);
      cout << "Trip count of activeLoop = " << tc << endl;
      info.tripCounts.push_back(tc);
      
      activeLoop = activeLoop->getSubLoops()[0];

    }

    unsigned tc = scev.getSmallConstantTripCount(activeLoop);
    cout << "Trip count of base loop = " << tc << endl;
    info.tripCounts.push_back(tc);
    
    cout << "Body " << endl;
    for (auto blk : activeLoop->getBlocks()) {
      info.body.insert(blk);
      cout << tab(1) << "Includes block" << endl;
      cout << valueString(blk) << endl;
    }

    // Find all operations that we may need to block for
    for (auto blk : loop->getBlocks()) {
      for (auto& instrR : *blk) {
        auto instr = &instrR;
        if (matchesCall("lb_pop", instr) ||
            matchesCall("fifo_read_ref", instr)) {
          cout << tab(1) << "Blocking operation: " << valueString(instr) << endl;
          info.blockingOps.insert(instr);
        }
      }
    }

    return info;
  }

  void runCleanupPasses(Function* f) {
    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    FPM.addPass(ADCEPass());        
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);
  }

  set<Instruction*> getBlockingOps(BasicBlock* const opBlock) {
    set<Instruction*> blocking;
    for (auto& instrR : *opBlock) {
      auto instr = &instrR;
      if (matchesCall("lb_pop", instr) ||
          matchesCall("fifo_read_ref", instr)) {
        blocking.insert(instr);
      }
    }
    
    return blocking;
  }
  
  void liftBlockingOps(Function* f) {
    DominatorTree dt(*f);
    LoopInfo li(dt);

    for (Loop* loop : li) {
      assert(loop->getBlocks().size() == 1);

      BasicBlock* bb = loop->getBlocks()[0];
      auto* canonicalVar = loop->getCanonicalInductionVariable();
      auto* ind =
        loop->getCanonicalInductionVariable()->getNextNonDebugInstruction();
      assert(ind != nullptr);
      assert(ind->getParent() == bb);

      BasicBlock* opBlock = bb->splitBasicBlock(ind);

      cout << "opBlock = " << valueString(opBlock) << endl;
      
      auto* loopCond =
        //extract<Instruction>(extract<BranchInst>(opBlock->getTerminator()));
        extract<ICmpInst>(extract<BranchInst>(opBlock->getTerminator())->getCondition());

      // TODO: Need to move this code
      cout << "Splitting at " << valueString(loopCond) << endl;

      BasicBlock* exitBlock = opBlock->splitBasicBlock(loopCond);
      auto* branchCond =
        extract<ICmpInst>(extract<BranchInst>(exitBlock->getTerminator())->getCondition());
      cout << "Lifted loop latch cond = " << valueString(branchCond) << endl;
      auto* lhs = branchCond->getOperand(0);
      auto* rhs = branchCond->getOperand(1);

      assert(ConstantInt::classof(rhs));
      assert(Instruction::classof(lhs));
      assert(dyn_cast<Instruction>(lhs)->getParent() == opBlock);

      auto newLHS = PHINode::Create(lhs->getType(), 2);
      newLHS->addIncoming(lhs, opBlock);
      newLHS->addIncoming(canonicalVar, bb);
      newLHS->insertBefore(branchCond);

      cout << "Loop latch after adding new index = " << endl;
      cout << valueString(dyn_cast<Instruction>(lhs)->getParent()) << endl;

      branchCond->setOperand(0, newLHS);
      // auto newBrCond = CmpInst::Create(ICmp::EQ, newLHS, rhs);
      // branchCond->replaceAllUsesWidth(newBrCond);
      // branchCond->eraseFromParent();
      
      // This terminator needs to be replaced
      TerminatorInst* validCheckBr = bb->getTerminator();
      set<Instruction*> blockingOps = getBlockingOps(opBlock);
      IRBuilder<> bbBuilder(bb);
      Value* allInputsValid = mkInt(1, 1);
      for (auto op : blockingOps) {
        if (matchesCall("fifo_read_ref", op)) {
          CallInst* c = extract<CallInst>(op);
          auto readDataValid = readPort(bbBuilder, c->getOperand(1), 1, "read_valid");
          allInputsValid = bbBuilder.CreateAnd(allInputsValid, readDataValid);
        } else if (matchesCall("lb_pop", op)) {
          CallInst* c = extract<CallInst>(op);
          auto readDataValid = readPort(bbBuilder, c->getOperand(1), 1, "valid");
          allInputsValid = bbBuilder.CreateAnd(allInputsValid, readDataValid);
        }
      }
      validCheckBr->eraseFromParent();
      bbBuilder.CreateCondBr(allInputsValid, opBlock, exitBlock);
    }

    cout << "Done splitting" << endl;
    cout << valueString(f) << endl;

  }
  
  // Bad name, should really be "dataFlowLoops" or something similar
  void forToWhileLoopOpt(Function* f, HalideArchSettings settings) {

    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    //FPM.addPass(LoopSimplifyCFGPass());    
    FPM.addPass(DCEPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);

    llvm::legacy::PassManager pm;
    pm.add(new LoopInfoWrapperPass());
    pm.add(new AAResultsWrapperPass());
    pm.add(new TargetLibraryInfoWrapperPass());
    pm.add(createLoopSimplifyCFGPass());
    pm.run(*(f->getParent()));
    
    // LoopPassManager LPM;
    // LPM.addPass(SimplifyCFGPass());
    // LoopAnalysisManager LAM;
    // PassBuilder lbp;
    // lbp.registerLoopAnalyses(LAM);
    // lbp.run(*f, LAM);
    
    cout << "Before Dataflow loop opts" << endl;
    cout << valueString(f) << endl;
    
    DominatorTree dt(*f);
    LoopInfo li(dt);
    TargetLibraryInfoImpl i;
    TargetLibraryInfo tli(i);
    AssumptionCache ac(*f);
    ScalarEvolution scev(*f, tli, ac, dt, li);

    map<Loop*, DataflowNestInfo> dataflowNests;
    map<Loop*, BasicBlock*> preds;
    map<Loop*, BasicBlock*> exits;

    for (Loop* loop : li) {
      cout << "Found loop in for to while conversion, depth = " << loop->getLoopDepth() << ", subloops = " << loop->getSubLoops().size() << endl;
      
      assert(isPerfect(loop));

      // Q: What is the first thing to do?
      // A: Compute trip counts for each inner loop, compute product of the trip counts and extract the body of the function
      DataflowNestInfo info = computeDataflowInfo(loop, scev);
      dataflowNests[loop]= info;

      BasicBlock* pred = loop->getLoopPredecessor();
      if (pred == nullptr) {
        cout << "Loop does not have unique predecessor" << endl;        
        assert(false);
      }
      preds[loop] = pred;

      BasicBlock* exit = loop->getUniqueExitBlock();
      if (exit == nullptr) {
        cout << "Loop does not have unique exit block" << endl;
        SmallVector<BasicBlock*, 8> exitBlocks;
        loop->getUniqueExitBlocks(exitBlocks);
        for (auto blk : exitBlocks) {
          cout << "Exit blk" << endl;
          cout << valueString(blk) << endl;
        }
        
        SmallVector<std::pair<const BasicBlock *, const BasicBlock *>, 8> exitEdges;
        loop->getExitEdges(exitEdges);

        for (auto edge : exitEdges) {
          cout << "Out from " << endl;
          cout << valueString(edge.first) << endl;
          cout << "to" << endl;
          cout << valueString(edge.second) << endl;          
        }
        assert(false);
      }
      exits[loop] = exit;
    }

    for (auto lpInfo : dataflowNests) {
      Loop* loop = lpInfo.first;
      DataflowNestInfo info = lpInfo.second;
      assert(info.body.size() == 1);

      if (info.tripCounts.size() > 1) {
        assert(info.tripCounts.size() == 2);

        // Need to flatten the loop

        Loop* innerLoop = loop->getSubLoops()[0];
        auto outerInd = loop->getCanonicalInductionVariable();
        assert(outerInd != nullptr);

        auto innerInd = innerLoop->getCanonicalInductionVariable();
        assert(innerInd != nullptr);

        auto innerLatch = innerLoop->getLoopLatch();
        assert(innerLatch != nullptr);

        TerminatorInst* latchTerm = innerLatch->getTerminator();
        BranchInst* latchBr = extract<BranchInst>(latchTerm);
        assert(latchBr->getNumSuccessors() == 2);
        auto s0 = latchBr->getSuccessor(0);
        auto s1 = latchBr->getSuccessor(1);
        assert((s0 == innerLatch) || (s1 == innerLatch));

        auto onlyNewDest = s0 == innerLatch ? s1 : s0;
        latchTerm->eraseFromParent();
        IRBuilder<> lt(innerLatch);
        lt.CreateBr(onlyNewDest);
        innerInd->removeIncomingValue(innerLatch);

        // Change the bound on the new outer loop
        {
          int totalTripCount = 1;
          for (auto tc : info.tripCounts) {
            totalTripCount *= tc;
          }
          cout << "Total trip count of flattened = " << totalTripCount << endl;
          // We only handle 16 bits on CGRA now
          assert(totalTripCount < 300000);

          BasicBlock* outerLatch = loop->getLoopLatch();

          assert(outerLatch != nullptr);
          
          BranchInst* latchBr = extract<BranchInst>(outerLatch->getTerminator());

          assert(latchBr->isConditional());          
          assert(latchBr->getNumSuccessors() == 2);

          //auto test = latchBr->getCondition();
          auto s0 = latchBr->getSuccessor(0);
          auto s1 = latchBr->getSuccessor(1);

          latchBr->eraseFromParent();

          IRBuilder<> lt(outerLatch);
          //lt.CreateCondBr(lt.CreateICmpEQ(outerInd, mkInt(totalTripCount, 16)), s0, s1);
          lt.CreateCondBr(lt.CreateICmpEQ(lt.CreateAdd(outerInd, mkInt(1, 32)), mkInt(totalTripCount, 32)), s0, s1);
        }

        
      }
    }

    // map<Loop*, BasicBlock*> loopReplacements;
    // for (auto lpInfo : dataflowNests) {
    //   Loop* loop = lpInfo.first;
    //   DataflowNestInfo info = lpInfo.second;
    //   assert(info.body.size() == 1);

    //   if (info.tripCounts.size() > 1) {
    //     BasicBlock* bodyToReplace = *begin(info.body);
    //     BasicBlock* replacement = mkBB(string(bodyToReplace->getName()) + "_flat", f);

    //     loopReplacements[loop] = replacement;

    //     for (auto& pd : preds) {
    //       if (loop->contains(pd.second)) {
    //         cout << "Replacing block" << endl;
    //         pd.second = replacement;
    //         assert(preds[pd.first] == replacement);
    //       }
    //     }

    //     for (auto& pd : exits) {
    //       if (loop->contains(pd.second)) {
    //         cout << "Replacing exit block" << endl;
    //         pd.second = replacement;
    //         assert(exits[pd.first] == replacement);
    //       }
    //     }

    //   }
    // }

    // cout << "# of top level loops = " << dataflowNests.size() << endl;
    // map<BasicBlock*, BasicBlock*> replacements;
    // for (auto lpInfo : dataflowNests) {
    //   Loop* loop = lpInfo.first;
    //   DataflowNestInfo info = lpInfo.second;
    //   assert(info.body.size() == 1);

    //   if (info.tripCounts.size() > 1) {
    //     cout << "Flattening loop nest of depth " << info.tripCounts.size() << endl;
    //     int totalTripCount = 1;
    //     for (auto tc : info.tripCounts) {
    //       totalTripCount *= tc;
    //     }
    //     cout << "Total trip count of loop = " << totalTripCount << endl;
    //     assert(totalTripCount < 300000);

    //     BasicBlock* bodyToReplace = *begin(info.body);        
    //     auto replacement = map_find(loop, loopReplacements);
        
    //     IRBuilder<> b(replacement);
    //     auto indVar = b.CreatePHI(intType(16), 2);
    //     auto iNext = b.CreateAdd(indVar, mkInt(1, 16));

    //     indVar->addIncoming(iNext, replacement);
    //     indVar->addIncoming(mkInt(0, 16), map_find(loop, preds));

    //     auto exitCond = b.CreateICmpEQ(iNext, mkInt(totalTripCount, 16));
    //     assert(Instruction::classof(exitCond));
        
    //     vector<Instruction*> toMove;
    //     set<Instruction*> toErase;
    //     for (auto& instr : *bodyToReplace) {
    //       if (!TerminatorInst::classof(&instr)) {
    //         toMove.push_back(&instr);
    //       } else {
    //         toErase.insert(&instr);
    //       }
    //     }

    //     for (auto instr : toErase) {
    //       BasicBlock* oldLoopBody = instr->getParent();
    //       instr->eraseFromParent();
    //     }
        
    //     // for (auto instr : toMove) {
    //     //   instr->moveBefore(dyn_cast<Instruction>(exitCond));
    //     // }

    //     // // Need to create branch instruction to terminate each block
    //     // b.CreateCondBr(exitCond, map_find(loop, exits), replacement);
    //     b.CreateCondBr(exitCond, map_find(loop, exits), replacement);

    //     SimplifyInstructionsInBlock(replacement);
    //     //b.CreateCondBr(exitCond, replacement, replacement);

    //     // for (auto& p : preds) {
    //     //   if (p.second == bodyToReplace) {
            
    //     //   }
    //     // }
    //     // Now: Replace preds[

    //     // replacements[bodyToReplace] = replacement;
    //     for (auto blk : loop->getBlocks()) {
    //       replacements[blk] = replacement;
    //     }

    //     // Set phi nodes
    //   }

    //   // Need to delete all replaced loop nests
    // }

    // for (auto pd : preds) {
    //   Loop* l = pd.first;
    //   if (contains_key(l, loopReplacements)) {
    //     BasicBlock* newLoopBody = map_find(l, loopReplacements);
    //     BasicBlock* pred = pd.second;
    //     TerminatorInst* term = pred->getTerminator();
    //     cout << "Terminator " << valueString(term) << " should now jump to " << valueString(newLoopBody) << endl;
    //     //assert(BranchInst::classof(term));
    //     BranchInst* br = extract<BranchInst>(term);
    //     int numReplaced = 0;
    //     for (int i = 0; i < (int) br->getNumSuccessors(); i++) {
    //       if (l->contains(br->getSuccessor(i))) {
    //         br->setSuccessor(i, newLoopBody);
    //         numReplaced++;
    //       }
    //     }

    //     assert((numReplaced == 1) || (numReplaced == 0));
    //   }
    // }

    // for (auto blk : replacements) { //asdf
    // //   // for (auto& bb : *f) {
    // //   //   bool isPred = false;
    // //   //   for (auto p : predecessors(&bb)) {
    // //   //     if (p == blk.first) {
    // //   //       isPred = true;
    // //   //       break;
    // //   //     }
    // //   //   }

    // //   //   if (isPred) {
    // //   //     bb.removePredecessor(blk.first);
    // //   //   }
        
    // //   // }

    //   for (auto& use : blk.first->uses()) {
    //     use.eraseFromParent();
    //   }
    //   // blk.first->replaceAllUsesWith(blk.second);
      
    // }

    // cout << "After adding new loops and replacing uses" << endl;
    // cout << valueString(f) << endl;

    // //assert(false);
    
    // for (auto blk : replacements) {

    //   set<Instruction*> toDel;
    //   for (auto&  instr : *(blk.first)) {
    //     toDel.insert(&instr);
    //   }
    //   for (auto instr : toDel) {
    //     instr->eraseFromParent();
    //   }
    //   // auto term = blk.first->getTerminator();
    //   // if (term != nullptr) {
    //   //   term->eraseFromParent();
    //   // }
    // //   //blk.first->removeFromParent();

    // //   cout << "Deleting block" << endl;
    // //   assert(blk.first != nullptr);
    // //   //cout << valueString(blk.first) << endl;

    //   // for (auto& use : blk.first->uses()) {
    //   //   Value* u = use.get();
    //   //   Instruction* iUser = extract<Instruction>(u);
    //   //   iUser->eraseFromParent();
    //   // }
      
    // }

    // for (auto blk : replacements) {
    //   //blk.first->replaceAllUsesWith(UndefValue::get(blk.first->getType()));
    //   //cout << "# of uses of blk = " << blk.first->uses().size() << endl;
    //   for (auto& use : blk.first->uses()) {
        
    //     if (Instruction::classof(use.get())) {
    //       cout << "Deleting block user instruction = " << valueString(use.get()) << endl;          
    //       dyn_cast<Instruction>(use.get())->eraseFromParent();
    //     } else {
    //       cout << "User that is not instruction = " << valueString(use.get()) << endl;
    //     }
    //   }
    // }

    // cout << "After clearing replacement block users" << endl;
    // cout << valueString(f) << endl;
    
    // for (auto blk : replacements) {
    //   DeleteDeadBlock(blk.first);
    // }
    cout << "Done clearing replacement blocks" << endl;
    cout << valueString(f) << endl;

    //assert(false);
    
    // for (auto blk : replacements) {
    //   DeleteDeadBlock(blk.first);
    // }
    
    //assert(false);

    //assert(false);
    runCleanupPasses(f);
    
    cout << "After loop flattening opt" << endl;
    cout << valueString(f) << endl;
    sanityCheck(f);

    liftBlockingOps(f);
  }

  set<Instruction*> fifoReads(Loop* lp) {
    set<Instruction*> rds;
    for (auto* bb : lp->getBlocks()) {
      for (auto& instr : *bb) {
        if (matchesCall("fifo_read", &instr) ||
            matchesCall("lb_pop", &instr)) {
          rds.insert(&instr);
        }
      }
    }

    return rds;
  }

  // Wr
  set<Instruction*> fifoWrites(Loop* lp) {
    set<Instruction*> rds;
    for (auto* bb : lp->getBlocks()) {
      for (auto& instr : *bb) {
        if (matchesCall("fifo_write", &instr) ||
            matchesCall("lb_push", &instr)) {
          rds.insert(&instr);
        }
      }
    }

    return rds;
  }
  
  void optimizeFifos(Function* f) {
    // How to go about optimizing fifos?
    // Find loop nests that do not contain a fifo (linebuffer) read and fifo (linebuffer) write
    // then check that
    // - the read precedes the write
    // - the read value is immediately written to the output fifo

    // Find the loop nest that writes to the input fifo and have it write
    // to the output FIFO instead

    FunctionPassManager FPM;
    FPM.addPass(PromotePass());    
    FPM.addPass(SimplifyCFGPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*f, FAM);

    DominatorTree dt(*f);
    LoopInfo li(dt);

    for (Loop* loop : li) {
      set<Instruction*> freads = fifoReads(loop);
      set<Instruction*> fwrites = fifoWrites(loop);

      cout << "# of fifo reads  = " << freads.size() << endl;
      cout << "# of fifo writes = " << fwrites.size() << endl;

      if ((freads.size() == 1) &&
          (fwrites.size() == 1)) {
        auto rd = *begin(freads);
        auto wr = *begin(fwrites);
        if (dt.dominates(rd, wr)) {
          cout << "Possible fifo transfer loop" << endl;
          
        }
      }
    }

    runCleanupPasses(f);

    cout << "After fifo removal" << endl;
    cout << valueString(f) << endl;
    
  }
  
  void optimizeRAMs(Function* rewritten) {
    // RAM transformations?
    set<Instruction*> ramOps;
    map<Value*, map<Value*, Value*> > ramsToWrittenValues;
    map<Value*, set<Value*> > ramsToReads;
    for (auto instr : allInstrs(rewritten)) {
      if (isRAMWrite(instr)) {
        cout << valueString(instr) << " is ram write"  << endl;
        ramsToWrittenValues[instr->getOperand(0)][instr->getOperand(1)] =
          instr->getOperand(2);
      } else if (isRAMRead(instr)) {
        ramsToReads[instr->getOperand(0)].insert(instr); //instr->getOperand(1));
      }
    }

    cout << "RAM writes" << endl;
    map<Value*, map<int, int> > ramsToConstValues;
    for (auto rm : ramsToWrittenValues) {
      cout << tab(1) << valueString(rm.first) << endl;
      for (auto ir : rm.second) {
        Value* addr = ir.first;
        Value* val = ir.second;

        if (ConstantInt::classof(addr) &&
            ConstantInt::classof(val)) {
          int addrI = getInt(addr);
          int valI = getInt(val);

          ramsToConstValues[rm.first][addrI] = valI;
        }
        cout << tab(2) << valueString(ir.first) << " -> " << valueString(ir.second) << endl;

      }
    }

    cout << "RAM constants" << endl;
    for (auto rm : ramsToConstValues) {
      cout << tab(1) << valueString(rm.first) << endl;
      for (auto ir : rm.second) {
        auto addr = ir.first;
        auto val = ir.second;
        cout << addr << " -> " << val << endl;
      }      
    }

    set<Instruction*> toErase;
    
    for (auto ram : ramsToReads) {
      if (contains_key(ram.first, ramsToConstValues)) {
        cout << valueString(ram.first) << "is const ram" << endl;
        for (auto rd : ram.second) {
          cout << "rd = " << valueString(rd) << endl;
          assert(Instruction::classof(rd));
          int addr = getInt(dyn_cast<Instruction>(rd)->getOperand(1));
          int valueI = map_find(addr, ramsToConstValues[ram.first]);
          Value* value = mkInt(valueI, getValueBitWidth(rd));
          cout << "Replacing " << valueString(rd) << " with " << valueString(value) << endl;
          rd->replaceAllUsesWith(value);
          toErase.insert(dyn_cast<Instruction>(rd));
          //dyn_cast<Instruction>(rd)->eraseFromParent();
        }
      }
    }

    // For now assume only use of rams is as kernels
    for (auto instr : allInstrs(rewritten)) {
      if (isRAMWrite(instr)) {
        toErase.insert(instr);
        //instr->eraseFromParent();
      } else if (AllocaInst::classof(instr)) {
        
        // if (isRAMType(getPointedToType(instr->getType()))) {
        //   //instr->eraseFromParent();
        //   toErase.insert(instr);
        // }
      } else {
        cout << "Not erasing " << valueString(instr) << endl;
      }
    }

    for (auto instr : toErase) {
      assert(elem(instr, allInstrs(rewritten)));
      cout << "Erasing instruction " << valueString(instr) << endl;
      
      instr->eraseFromParent();
    }

    toErase = {};
    for (auto instr : allInstrs(rewritten)) {
      if (AllocaInst::classof(instr)) {
        
        if (isRAMType(getPointedToType(instr->getType()))) {
          //instr->eraseFromParent();
          toErase.insert(instr);
        }
      } 
    }

    for (auto instr : toErase) {
      assert(elem(instr, allInstrs(rewritten)));
      cout << "Erasing instruction " << valueString(instr) << endl;
      instr->eraseFromParent();
    }
  }
  
  MicroArchitecture halideArch(Function* f, HalideArchSettings settings) {
    Function* rewritten =
      rewriteHalideStencils(f);

    optimizeModuleLLVM(*(rewritten->getParent()));
    optimizeStores(rewritten);
    
    cout << "Rewritten function" << endl;
    cout << valueString(rewritten) << endl;

    InterfaceFunctions interfaces;
    set<string> funcs;

    for (auto& bb : rewritten->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (CallInst::classof(instr)) {
          CallInst* ci = dyn_cast<CallInst>(instr);
          Function* func = ci->getCalledFunction();
          string name = ci->getCalledFunction()->getName();
          if (!elem(name, funcs)) {
            interfaces.addFunction(func);
            
            if (hasPrefix(name, "fifo_read_ref")) {
              if (!settings.pushFifos) {
                implementRVFifoReadRef(func, interfaces.getConstraints(func));
              } else {
                cout << "Implementing push read" << endl;
                implementPushFifoReadRef(func, interfaces.getConstraints(func));
              }
            } else if (hasPrefix(name, "fifo_write_ref")) {
              if (!settings.pushFifos) {
                implementRVFifoWriteRef(func, interfaces.getConstraints(func));
              } else {
                cout << "Implementing push write" << endl;                
                implementPushFifoWriteRef(func, interfaces.getConstraints(func));
              }
            } else if (hasPrefix(name, "lb_has_valid")) {
              implementLBHasValidData(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.write.")) {
              implementRAMWrite0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.read.")) {
              implementRAMRead0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_push.")) {
              implementLBPush(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_pop.")) {
              implementLBPop(func, interfaces.getConstraints(func));
            } else {
              cout << "Error: Unsupported call " << valueString(ci) << endl;
              assert(false);
            }
            funcs.insert(name);
          }
        }
      }
    }


    cout << "Before RAM opts" << endl;
    cout << valueString(rewritten) << endl;

    optimizeRAMs(rewritten);
    
    cout << "After RAM optimization" << endl;
    cout << valueString(rewritten) << endl;

    if (settings.optimizeFifos) {
      optimizeFifos(rewritten);
    }

    if (settings.forToWhile) {
      forToWhileLoopOpt(rewritten, settings);
    }

    ExecutionConstraints exec;

    //addDataConstraints(rewritten, exec);
    inlineWireCalls(rewritten, exec, interfaces);

    DominatorTree DT(*rewritten);
    SmallVector<AllocaInst *, 200> PromotableAllocas;

    // For now assume all integer allocas are promotable
    for (auto instr : allInstrs(rewritten)) {
      if (AllocaInst::classof(instr)) {
        if (IntegerType::classof(getPointedToType(instr->getType()))) {
          PromotableAllocas.push_back(dyn_cast<AllocaInst>(instr));
        }
      }
    }
    PromoteMemToReg(PromotableAllocas, DT);

    optimizeModuleLLVM(*(rewritten->getParent()));
    optimizeStores(rewritten);

    FunctionPassManager FPM;
    FPM.addPass(SimplifyCFGPass());
    FunctionAnalysisManager FAM;
    PassBuilder PB;
    PB.registerFunctionAnalyses(FAM);
    FPM.run(*rewritten, FAM);

    clearExecutionConstraints(rewritten, exec);
    
    addDataConstraints(rewritten, exec);

    set<TaskSpec> tasks;
    if (settings.loopTasks) {
      tasks = halideTaskSpecs(rewritten);
    } else {
      tasks = {wholeFunctionTask(rewritten)};
    }
    exec.tasks = tasks;

    std::set<PipelineSpec> toPipeline;
    // for (auto task : exec.tasks) {
    //   PipelineSpec s;
    //   s.staticII = 1;
    //   for (auto blk : task.blks) {
    //     s.blks.insert(blk);
    //   }
    //   toPipeline.insert(s);
    // }
    
    // Now: Populate HLS data structures
    HardwareConstraints hcs = standardConstraints();
    assignModuleSpecs(rewritten, hcs, settings);
    
    cout << "After inlining" << endl;
    cout << valueString(rewritten) << endl;
    auto preds = buildControlPreds(rewritten);

    SchedulingProblem p = createSchedulingProblem(rewritten, hcs, toPipeline, tasks, preds);
    exec.addConstraints(p, rewritten);

    map<Function*, SchedulingProblem> constraints{{rewritten, p}};
    Schedule s = scheduleFunction(rewritten, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, rewritten);
    cout << "STG is" << endl;
    graph.print(cout);

    std::map<Value*, int> memoryMap;
    MicroArchitecture arch = buildMicroArchitecture(graph, memoryMap, hcs);

    return arch;
  }

  // Idea: Maybe just reconstruct the DAG of operations and build a true synchronous
  // dataflow machine? What would I need to do?
  // - Find loop nests
  // - Find loop trip counts
  // - Check that loops do not use loop indices for anything but exit computation
  // - Remove dead RAM loops
  // - Prove that each loop executes at least once (if LLVM cannot do this)
  // - Restructure each loop in to
  //     while (tripcount) { if (all inputs ready) { KERNEL<non-blocking reads> } }

  // TODO:
  //  Remove one-to-one fifos
  //  Use fifo definition that reads in same cycle that ready is high
  //  Do CFG simplification
  //  Do control signal simplification
  //  Get coreir backend running
  TEST_CASE("Rewrite stencils as int computation") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "vhls_target");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    cout << "Origin function" << endl;
    cout << valueString(f) << endl;


    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    MicroArchitecture arch = halideArch(f, archSettings);
    
    {
      auto in = dyn_cast<Argument>(getArg(f, 0));
      auto out = dyn_cast<Argument>(getArg(f, 1));    

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 800;
      tb.maxCycles = 1000;
      tb.name = "vhls_target";
      tb.useModSpecs = true;
      tb.settablePort(in, "in_data");
      tb.settablePort(in, "write_valid");
      tb.settablePort(out, "read_valid");    

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

      tb.setArgPort(out, "read_valid", 0, "1'b0");
      tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
      tb.setArgPort(in, "in_data", 2, "16'd28");
      tb.setArgPort(in, "write_valid", 2, "1'b1");    
      
      tb.setArgPort(in, "in_data", 3, "16'd10");
      tb.setArgPort(in, "write_valid", 3, "1'b1");    

      tb.setArgPort(in, "in_data", 4, "16'd7");
      tb.setArgPort(in, "write_valid", 4, "1'b1");    

      tb.setArgPort(in, "in_data", 5, "16'd3");
      tb.setArgPort(in, "write_valid", 5, "1'b1");    
      tb.setArgPort(in, "write_valid", 6, "1'b0");
      
      tb.setArgPort(in, "in_data", 7, "16'd9");
      tb.setArgPort(in, "write_valid", 7, "1'b1");
      tb.setArgPort(in, "write_valid", 8, "1'b0");      


      int endCycle = 700;
      tb.setArgPort(out, "read_valid", endCycle + 2, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 3, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 3, assertString(string(out->getName()) + "_out_data === 16'd56"));

      tb.setArgPort(out, "read_valid", endCycle + 4, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 5, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 5, assertString(string(out->getName()) + "_out_data === 16'd20"));

      tb.setArgPort(out, "read_valid", endCycle + 6, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 7, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 7, assertString(string(out->getName()) + "_out_data === 16'd14"));

      tb.setArgPort(out, "read_valid", endCycle + 8, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 9, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 9, assertString(string(out->getName()) + "_out_data === 16'd6"));
    
      map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

      VerilogDebugInfo info;
      // addDisplay("1", "global state = %d", {"global_state"}, info);
      // addDisplay("1", "arg_0_read_ready = %d", {"arg_0_read_ready"}, info);
      // addDisplay("1", "arg_0_read_valid = %d", {"arg_0_read_valid"}, info);
      // addDisplay("1", "arg_0_out_data = %d", {"arg_0_out_data"}, info);
      // addDisplay("1", "arg_1_out_data = %d", {"arg_1_out_data"}, info);
      // addDisplay("1", "arg_1_write_ready = %d", {"arg_1_write_ready"}, info);      
      //printActiveBlocks(arch, info);
      addNoXChecks(arch, info);
      
      emitVerilog("vhls_target", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("vhls_target"));      
    }
  }

  TEST_CASE("get element 0 1 from stencil") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "halide_stencil_get_01");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    cout << "Origin function" << endl;
    cout << valueString(f) << endl;

    HalideArchSettings archSettings;
    archSettings.loopTasks = false;
    MicroArchitecture arch = halideArch(f, archSettings);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.maxCycles = 100;
    tb.name = "halide_stencil_get_01";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    vector<pair<int, string> > writeTimesAndValues{{10, "{16'd15, 16'd2}"}};
    setRVFifo(tb, "arg_0", writeTimesAndValues);

    vector<pair<int, string> > expectedValuesAndTimes{{30, "16'd15"}};
    checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 1, string("arg_0_write_valid <= 0;"));
    map_insert(tb.actionsOnCycles, 1, string("arg_1_read_valid <= 0;"));        

    VerilogDebugInfo info;
    //addDisplay("arg_1_read_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
    // addDisplay("arg_0_write_valid", "writing to arg_0: %d", {"arg_0_in_data"}, info);        
    // addDisplay("arg_1_write_valid", "writing to arg_1: %d", {"arg_1_in_data"}, info);

    // addDisplay("1", "arg_1_write_ready: %d", {"arg_1_write_ready"}, info);    
    // addDisplay("1", "arg_1_out_data: %d", {"arg_1_out_data"}, info);    
    // addDisplay("1", "arg_1_write_valid: %d", {"arg_1_write_valid"}, info);    
    // addDisplay("1", "reading from arg_0: %d", {"arg_0_out_data"}, info);
    // addDisplay("1", "global state: %d", {"global_state"}, info);    

    //printActiveBlocks(arch, info);
    addNoXChecks(arch, info);
    
    emitVerilog("halide_stencil_get_01", arch, info);
    emitVerilogTestBench(tb, arch, testLayout);

    
    REQUIRE(runIVerilogTB("halide_stencil_get_01"));      
  }

  TEST_CASE("conv_2_1 manually optimized") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_manually_optimized");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    MicroArchitecture arch = halideArch(f, archSettings);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 900;
    tb.maxCycles = 10000;
    tb.name = "conv_2_1_manually_optimized";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");
    
    vector<pair<int, int> > writeTimesAndValues;
    for (int i = 0; i < 8*8; i++) {
      writeTimesAndValues.push_back({2*i + 5, i});
    }
    setRVFifo(tb, "arg_0", writeTimesAndValues);

    vector<pair<int, string> > expectedValuesAndTimes;
    int offset = 300;
    for (int i = 0; i < 8*7; i++) {
      expectedValuesAndTimes.push_back({offset, to_string(i + (i + 8))});
      offset += 2;
    }
    checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

    //int endCycle = 20;
    //map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
    //addDisplay("1", "arg_1_read_ready = %d", {"arg_1_read_ready"}, info);
    
    emitVerilog("conv_2_1_manually_optimized", arch, info);
    emitVerilogTestBench(tb, arch, testLayout);

    
    REQUIRE(runIVerilogTB("conv_2_1_manually_optimized"));
    
  }
  
  // TODO:
  //  Add sliced stores
  TEST_CASE("conv_2_1 to verilog") {
  //   SMDiagnostic Err;
  //   LLVMContext Context;
  //   setGlobalLLVMContext(&Context);
    
  //   std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_source");
  //   setGlobalLLVMModule(Mod.get());

  //   Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
  //   deleteLLVMLifetimeCalls(f);

  //   HalideArchSettings archSettings;
  //   archSettings.loopTasks = true;
  //   archSettings.forToWhile = true;
  //   MicroArchitecture arch = halideArch(f, archSettings);

  //   auto in = dyn_cast<Argument>(getArg(f, 0));
  //   auto out = dyn_cast<Argument>(getArg(f, 1));    

  //   TestBenchSpec tb;
  //   map<string, int> testLayout = {};
  //   tb.memoryInit = {};
  //   tb.memoryExpected = {};
  //   tb.runCycles = 800;
  //   tb.maxCycles = 10000;
  //   tb.name = "conv_2_1";
  //   tb.useModSpecs = true;
  //   tb.settablePort(in, "in_data");
  //   tb.settablePort(in, "write_valid");
  //   tb.settablePort(out, "read_valid");

  //   tb.setArgPort(out, "read_valid", 0, "1'b0");
  //   tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
  //   vector<pair<int, int> > writeTimesAndValues;
  //   for (int i = 0; i < 8*8; i++) {
  //     writeTimesAndValues.push_back({3*i + 5, i});
  //   }
  //   setRVFifo(tb, "arg_0", writeTimesAndValues);

  //   vector<pair<int, string> > expectedValuesAndTimes;
  //   int offset = 1000;
  //   for (int i = 0; i < 8*7; i++) {
  //     expectedValuesAndTimes.push_back({offset, to_string(i + (i + 8))});
  //     offset += 2;
  //   }
  //   checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
  //   map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

  //   //int endCycle = 20;
  //   //map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

  //   VerilogDebugInfo info;
  //   addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
  //   addNoXChecks(arch, info);
    
  //   emitVerilog("conv_2_1", arch, info);
  //   emitVerilogTestBench(tb, arch, testLayout);

    
  //   REQUIRE(runIVerilogTB("conv_2_1"));
    
  }

  TEST_CASE("conv_2_1 push architecture to verilog") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_source");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    archSettings.pushFifos = true;
    archSettings.forToWhile = true;
    archSettings.optimizeFifos = true;
    MicroArchitecture arch = halideArch(f, archSettings);

    auto in = dyn_cast<Argument>(getArg(arch.stg.getFunction(), 0));
    auto out = dyn_cast<Argument>(getArg(arch.stg.getFunction(), 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 800;
    tb.maxCycles = 145;
    tb.name = "conv_2_1_push";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");

    tb.setArgPort(in, "write_valid", 0, "1'b0");


    vector<string> expectedValues;
    for (int i = 0; i < 8*7; i++) {
      expectedValues.push_back(to_string(i + (i + 8)));
    }
    VerilogDebugInfo info;
    checkValidChannel(arch, info, getArg(arch.stg.getFunction(), 1), "write_valid", "in_data", expectedValues);
    
    SECTION("Inputs at rate II == 2") {
      vector<pair<int, int> > writeTimesAndValues;
      int resetTime = 1;
      for (int i = resetTime; i < 8*8 + resetTime; i++) {
        writeTimesAndValues.push_back({2*i + 5, i - resetTime});
      }
      setRVFifo(tb, "arg_0", writeTimesAndValues);

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 0;"));
    
      addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
      addNoXChecks(arch, info);
    
      emitVerilog("conv_2_1_push", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

    
      REQUIRE(runIVerilogTB("conv_2_1_push"));
    }

    SECTION("Inputs at rate II == 1") {
      vector<pair<int, int> > writeTimesAndValues;
      int resetTime = 1;
      for (int i = resetTime; i < 8*8 + resetTime; i++) {
        writeTimesAndValues.push_back({i + 5, i - resetTime});
      }
      setRVFifo(tb, "arg_0", writeTimesAndValues);
    
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 0;"));
    
      addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
      addNoXChecks(arch, info);
    
      emitVerilog("conv_2_1_push", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

    
      REQUIRE(runIVerilogTB("conv_2_1_push"));
    }
    
  }
  
  // TEST_CASE("Stencil cascade") {
  //   SMDiagnostic Err;
  //   LLVMContext Context;
  //   setGlobalLLVMContext(&Context);
    
  //   std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "halide_cascade");
  //   setGlobalLLVMModule(Mod.get());

  //   Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
  //   deleteLLVMLifetimeCalls(f);

  //   MicroArchitecture arch = halideArch(f);

  //   auto in = dyn_cast<Argument>(getArg(f, 0));
  //   auto out = dyn_cast<Argument>(getArg(f, 1));    

  //   TestBenchSpec tb;
  //   map<string, int> testLayout = {};
  //   tb.memoryInit = {};
  //   tb.memoryExpected = {};
  //   tb.runCycles = 800;
  //   tb.maxCycles = 1000;
  //   tb.name = "vhls_target";
  //   tb.useModSpecs = true;
  //   tb.settablePort(in, "in_data");
  //   tb.settablePort(in, "write_valid");
  //   tb.settablePort(out, "read_valid");    

  //   map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

  //   int endCycle = 200;
  //   map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

  //   VerilogDebugInfo info;
  //   // addDisplay("1", "global state = %d", {"global_state"}, info);
  //   // addDisplay("1", "arg_0_read_ready = %d", {"arg_0_read_ready"}, info);
  //   // addDisplay("1", "arg_0_read_valid = %d", {"arg_0_read_valid"}, info);
  //   // addDisplay("1", "arg_0_out_data = %d", {"arg_0_out_data"}, info);
  //   // addDisplay("1", "arg_1_out_data = %d", {"arg_1_out_data"}, info);
  //   // addDisplay("1", "arg_1_write_ready = %d", {"arg_1_write_ready"}, info);      
  //   //printActiveBlocks(arch, info);
  //   addNoXChecks(arch, info);
    
  //   emitVerilog("halide_cascade", arch, info);
  //   emitVerilogTestBench(tb, arch, testLayout);

    
  //   //REQUIRE(runIVerilogTB("halide_cascade"));      
    
  // }
}
