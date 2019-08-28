
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
    Function* f = mkFunc(inputs, "vadd", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    IRBuilder<> entryBuilder(entryBlock);
    
    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);

    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
    loopBuilder.CreateCondBr(exitCond, exitBlock, loopBlock);
    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    // Build verilog

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_512")] =
      [](StructType* tp) { return ramSpec(32, 512); };
    InterfaceFunctions interfaces;
    Function* ramRead = ramLoadFunction(getArg(f, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(f, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));

    ExecutionConstraints exec;
    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);
    TestBenchSpec tb;
    tb.runCycles = 600;
    tb.name = "vadd";
    tb.useModSpecs = true;
    
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
    
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {11}}};
    
    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 30;
    checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("vadd"));
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
