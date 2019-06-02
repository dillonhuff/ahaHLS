#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"
#include "parser.h"

#include <llvm/Analysis/CFG.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

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

  int lbInWidth(Type* lbTp) {
    return 16;
  }

  int lbOutWidth(Type* lbTp) {
    return 32;
  }
  
  // bool 
  //           hcs.modSpecs[instr] = pushLBModSpec(lbInWidth(allocTp), lbOutWidth(allocTp));
  
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

        return lbType(16, 16*2);
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
    return mkFunc(ins, voidType(), "fifo_read_ref." + to_string(width));
  }

  llvm::Function* lbHasValidFunction(Value* replacementLB) {
    vector<Type*> ins{replacementLB->getType()};
    int width = 0;
    return mkFunc(ins, intType(1), "lb_has_valid." + to_string(width));
  }
  
  llvm::Function* fifoWriteRefFunction(const int width) {
    vector<Type*> ins{fifoType(width)->getPointerTo(),
        intType(width)->getPointerTo()};
    return mkFunc(ins, voidType(), "fifo_write_ref." + to_string(width));
  }

  Function* lbWriteFunction(Value* replacementLB) {
    int outWidth = 32;
    vector<Type*> ins{replacementLB->getType(), intType(outWidth)->getPointerTo()};
    return mkFunc(ins, voidType(), "lb_push." + to_string(outWidth));
  }

  Function* lbReadFunction(Value* replacementLB) {
    int inWidth = 16;
    vector<Type*> ins{intType(inWidth)->getPointerTo(), replacementLB->getType()};
    return mkFunc(ins, voidType(), "lb_pop." + to_string(inWidth));
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
          rewrites[toRewrite] = fullLoad;
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
  
  void assignModuleSpecs(Function* f, HardwareConstraints& hcs) {
    
    for (int i = 0; i < f->arg_size(); i++) {
      auto argTp = getPointedToType(getArg(f, i)->getType());
      if (isBuiltinFifoType(argTp)) {
        hcs.modSpecs[getArg(f, i)] = fifoSpec(builtinFifoWidth(argTp), 128);
      }
    }
    
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        if (AllocaInst::classof(instr)) {
          auto allocTp = getPointedToType(instr->getType());
          cout << "Allocating type " << typeString(allocTp) << endl;
          if (isBuiltinFifoType(allocTp)) {
            hcs.modSpecs[instr] = fifoSpec(builtinFifoWidth(allocTp), 128);
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

  set<Instruction*> allInstrs(Function* f) {
    set<Instruction*> instrs;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        instrs.insert(&instrR);
      }
    }
    return instrs;
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
  
  MicroArchitecture halideArch(Function* f) {
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
            if (hasPrefix(name, "fifo_read_ref")) {
              interfaces.addFunction(func);
              implementRVFifoReadRef(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "fifo_write_ref")) {
              interfaces.addFunction(func);
              implementRVFifoWriteRef(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_has_valid")) {
              interfaces.addFunction(func);
              implementLBHasValidData(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.write.")) {
              interfaces.addFunction(func);
              implementRAMWrite0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "ram.read.")) {
              interfaces.addFunction(func);
              implementRAMRead0(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_push.")) {
              interfaces.addFunction(func);
              implementLBPush(func, interfaces.getConstraints(func));
            } else if (hasPrefix(name, "lb_pop.")) {
              interfaces.addFunction(func);
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

    cout << "Before inlining" << endl;
    cout << valueString(rewritten) << endl;

    std::set<PipelineSpec> toPipeline;
    ExecutionConstraints exec;

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
        
        if (isRAMType(getPointedToType(instr->getType()))) {
          //instr->eraseFromParent();
          toErase.insert(instr);
        }
      } else {
        cout << "Not erasing " << valueString(instr) << endl;
      }
    }

    for (auto instr : toErase) {
      assert(elem(instr, allInstrs(rewritten)));
      cout << "Erasing instruction " << valueString(instr) << endl;
      
      instr->eraseFromParent();
    }
    
    cout << "After RAM optimization" << endl;
    cout << valueString(rewritten) << endl;
    
    
    //addDataConstraints(rewritten, exec);
    inlineWireCalls(rewritten, exec, interfaces);

    optimizeModuleLLVM(*(rewritten->getParent()));
    optimizeStores(rewritten);

    clearExecutionConstraints(rewritten, exec);
    
    addDataConstraints(rewritten, exec);

    set<TaskSpec> tasks = halideTaskSpecs(rewritten);

    // TODO: Need a better way to sanity check tasks
    //REQUIRE(tasks.size() == 2);
    exec.tasks = tasks;

    // Now: Populate HLS data structures
    HardwareConstraints hcs = standardConstraints();
    assignModuleSpecs(rewritten, hcs);
    
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

  // TODO:
  //  Remove one-to-one fifos
  //  Specialize away constant RAMs
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

    MicroArchitecture arch = halideArch(f);
    
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
    
    MicroArchitecture arch = halideArch(f);

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

    vector<pair<int, string> > writeTimesAndValues{{10, "{16'd15, 16'd2}"}};
    setRVFifo(tb, "arg_0", writeTimesAndValues);

    vector<pair<int, string> > expectedValuesAndTimes{{20, "16'd15"}};
    checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

    VerilogDebugInfo info;
    //addDisplay("arg_1_read_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
    addDisplay("1", "arg_1 output: %d", {"arg_1_out_data"}, info);
    addNoXChecks(arch, info);
    
    emitVerilog("halide_stencil_get_01", arch, info);
    emitVerilogTestBench(tb, arch, testLayout);

    
    REQUIRE(runIVerilogTB("halide_stencil_get_01"));      
  }

  // TODO:
  //  Make sure store / load rewrites are correct
  //  Add sliced loads / stores
  TEST_CASE("conv_2_1 to verilog") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_source");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    MicroArchitecture arch = halideArch(f);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 800;
    tb.maxCycles = 1000;
    tb.name = "conv_2_1";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    vector<pair<int, int> > writeTimesAndValues;
    for (int i = 0; i < 8*8; i++) {
      writeTimesAndValues.push_back({2*i, i});
    }
    setRVFifo(tb, "arg_0", writeTimesAndValues);

    vector<pair<int, string> > expectedValuesAndTimes;
    int offset = 100;
    for (int i = 0; i < 8*8; i++) {
      expectedValuesAndTimes.push_back({offset, to_string(i + (i + 8))});
      offset += 2;
    }
    checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

    //int endCycle = 20;
    //map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

    VerilogDebugInfo info;
    // addDisplay("1", "global state = %d", {"global_state"}, info);
    // addDisplay("1", "arg_0_read_ready = %d", {"arg_0_read_ready"}, info);
    // addDisplay("1", "arg_0_read_valid = %d", {"arg_0_read_valid"}, info);
    // addDisplay("1", "arg_0_out_data = %d", {"arg_0_out_data"}, info);
    addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
    // addDisplay("1", "arg_1_out_data = %d", {"arg_1_out_data"}, info);
    // addDisplay("1", "arg_1_write_ready = %d", {"arg_1_write_ready"}, info);
    //printActiveBlocks(arch, info);
    addNoXChecks(arch, info);
    
    emitVerilog("conv_2_1", arch, info);
    emitVerilogTestBench(tb, arch, testLayout);

    
    REQUIRE(runIVerilogTB("conv_2_1"));      
    
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
