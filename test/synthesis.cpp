
#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  TEST_CASE("Vector add rams") {

    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("vector add in LLVM", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 512)->getPointerTo(),
        sramType(32, 512)->getPointerTo(),
        sramType(32, 512)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    IRBuilder<> entryBuilder(entryBlock);
    
    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);

    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);
  }

  TEST_CASE("Vector add fifos") {

    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

  }

  TEST_CASE("Histogram") {

    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    SECTION("without forwarding") {

    }

    SECTION("forwarding") {

    }
  }
}
