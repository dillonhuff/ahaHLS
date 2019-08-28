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

  // TODO: Add initiation interval
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
    
    ConstantInt* loopBound = mkInt("512", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);

    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    auto a = loadRAMVal(loopBuilder, getArg(f, 0), indPhi);
    auto b = loadRAMVal(loopBuilder, getArg(f, 1), indPhi);
    auto c = loopBuilder.CreateAdd(a, b);
    storeRAMVal(loopBuilder, getArg(f, 2), indPhi, c);
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);
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
    set<BasicBlock*> toPipeline{loopBlock};
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    //printAllInstructions(arch, info);

    emitVerilog(arch, info);
    TestBenchSpec tb;
    tb.maxCycles = 2000;
    tb.name = "vadd";
    tb.useModSpecs = true;
    
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}, {"arg_2", 0}};
   
    vector<int> ram0Vals;
    vector<int> ram1Vals;
    vector<int> ram2Vals;
    for (int i = 0; i < 512; i++) {
      ram0Vals.push_back(i);
      ram1Vals.push_back(2*i);
      ram2Vals.push_back(3*i);
    }
    map<string, vector<int> > memoryInit{{"arg_0", ram0Vals}, {"arg_1", ram1Vals}};
    map<string, vector<int> > memoryExpected{{"arg_2", ram2Vals}};
    
    int startSetMemCycle = 1;
    //setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    map<string, vector<int> > arg0Init{{"arg_0", ram0Vals}};
    map<string, vector<int> > arg1Init{{"arg_1", ram1Vals}};
    setRAM(tb, 1, "arg_1", arg0Init, testLayout);
    setRAM(tb, 1, "arg_0", arg1Init, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 1400;
    checkRAM(tb, checkMemCycle, "arg_2", memoryExpected, testLayout);

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
