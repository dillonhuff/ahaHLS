#include "catch.hpp"

#include "algorithm.h"

#include "scheduling.h"
#include "verilog_backend.h"
#include "llvm_codegen.h"

#include <fstream>

#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/Analysis/LoopInfo.h>

using namespace llvm;
using namespace std;

namespace ahaHLS {

  TEST_CASE("Computing dependence distances via loop vectorizer") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM accumulate loop", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto ldA = builder.CreateLoad(dyn_cast<Value>(f->arg_begin()));

    builder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto sumPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    auto nextSum = loopBuilder.CreateAdd(sumPhi, ldA);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    sumPhi->addIncoming(zero, entryBlock);
    sumPhi->addIncoming(nextSum, loopBlock);
    
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateStore(nextSum, dyn_cast<Value>(f->arg_begin() + 1));
    exitBuilder.CreateRet(nullptr);

    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();

    scheduleFunction(f, hcs);
  }
  
}
