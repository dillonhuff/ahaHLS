#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

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

  Value* findRewrite(Value* val, map<Value*, Value*>& rewrites) {
    if (ConstantInt::classof(val)) {
      // TODO: Replace this with copy!!
      return val;
    }

    if (!contains_key(val, rewrites)) {
      cout << "Error: No rewrite for " << valueString(val) << endl;
    }
    
    assert(contains_key(val, rewrites));
    return map_find(val, rewrites);
  }
  
  void rewriteInstr(Function* f,
                    Function* orig,
                    map<BasicBlock*, BasicBlock*>& bbRewrites,
                    map<Value*, Value*>& rewrites,
                    Instruction* toRewrite) {
    BasicBlock* repBB = map_find(toRewrite->getParent(), bbRewrites);
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
        // TODO: Add indexing
        rewrites[toRewrite] =
          b.CreateLoad(findRewrite(toRewrite->getOperand(0), rewrites));
      } else if (isConstructor("hls_stream", func)) {
        // Do nothing, the constructor is a no-op
      } else if (isMethod("hls_stream", "read", func)) {
        vector<Value*> argReplacements;
        for (int i = 0; i < toRewrite->getNumOperands() - 1; i++) {
          cout << "replacing " << valueString(toRewrite->getOperand(i)) << endl;
          argReplacements.push_back(findRewrite(toRewrite->getOperand(i), rewrites));
        }

        rewrites[toRewrite] =
          b.CreateCall(func, argReplacements);
      } else if (isConstructor("AxiPackedStencil_", func)) {
        
        assert(false);
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
    return f;
  }

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

    // Function* rewritten =
    //   rewriteHalideStencils(f);

    // cout << "Rewritten function" << endl;
    // cout << valueString(rewritten) << endl;
    
  }
  
}
