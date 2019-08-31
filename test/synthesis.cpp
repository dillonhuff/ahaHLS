#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"
#include "rams.h"

#include <llvm/IR/Dominators.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Transforms/Utils/BasicBlockUtils.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  void checkRAM(TestBenchSpec& tb, const int startTime, const std::string& argName, vector<int>& expectedValues) {
    map<string, int> layout{{argName, 0}};
    map<string, vector<int> > valMap{{argName, expectedValues}};
    checkRAM(tb, startTime, argName, valMap, layout);
  }

  void setRAM(TestBenchSpec& tb, const int startTime, const std::string& argName, vector<int>& values) {
    map<string, int> layout{{argName, 0}};
    map<string, vector<int> > valMap{{argName, values}};
    setRAM(tb, startTime, argName, valMap, layout);
  }

  TestBenchSpec newTB(const std::string& name, const int runCycles) {
    TestBenchSpec tb;
    tb.maxCycles = runCycles;
    tb.name = name;
    tb.useModSpecs = true;

    return tb;
  }

  TEST_CASE("Matrix add") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "matrix_add");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "matrix_add");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");
  }

  TEST_CASE("Matrix vector multiply") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "mvmul");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "mvmul");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");
   
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("read_2")] = implementRAMRead2;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    ExecutionConstraints exec;

    inlineWireCalls(f, exec, interfaces);
    auto preds = buildControlPreds(f);

    set<TaskSpec> tasks;
    TaskSpec ts;
    for (auto& bb : f->getBasicBlockList()) {
      ts.blks.insert(&bb);
    }
    tasks.insert(ts);
    set<PipelineSpec> toPipeline;
    //DominatorTree dt(*f);
    //LoopInfo li(dt);
    //for (auto loop : li) {

      //auto& sl = loop->getSubLoops();
      //assert(sl.size() == 1);
      //Loop* inner = sl[0];
      //PipelineSpec spec;
      //for (auto blk : inner->getBlocks()) {
        //spec.blks.insert(blk);
      //}

      //toPipeline.insert(spec);

      ////PipelineSpec spec;
      ////for (auto blk : loop->getBlocks()) {
        ////spec.blks.insert(blk);
      ////}
      ////toPipeline.insert(spec);
    //}

    exec.toPipeline = toPipeline;
    //createMemoryConstraints(f, hcs, exec);
    SchedulingProblem p =
      createSchedulingProblem(f, hcs, toPipeline, tasks, preds);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    STG graph = buildSTG(s, f);
    
    //ExecutionConstraints exec;
    //set<BasicBlock*> toPipeline;
    //Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    //STG graph = buildSTG(s, f);
    
    //Schedule s = scheduleInterface(f, hcs, interfaces);
    
    //STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("mvmul", graph, hcs);

    // 3 x 3
    map<string, int> testLayout = {{"a", 0}, {"b", 9}, {"c", 12}};
    map<llvm::Value*, int> layout;

    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    // addControlSanityChecks(arch, info);
    // noAddsTakeXInputs(arch, info);
    // noMulsTakeXInputs(arch, info);
    // noPhiOutputsXWhenUsed(arch, info);
    // noStoredValuesXWhenUsed(arch, info);

    emitVerilog("mvmul", arch, info);

    map<string, vector<int> > memoryInit{{"a", {6, 1, 2, 3, 7, 5, 5, 2, 9}},
        {"b", {9, 3, 7}}};
    map<string, vector<int> > memoryExpected{{"c", {}}};

    auto ma = map_find(string("a"), memoryInit);
    auto mb = map_find(string("b"), memoryInit);
    for (int i = 0; i < 3; i++) {
      int val = 0;
      for (int j = 0; j < 3; j++) {
        val += ma[i*3 + j] * mb[j];
      }
      map_insert(memoryExpected, string("c"), val);
    }

    cout << "Expected values" << endl;
    for (auto val : map_find(string("c"), memoryExpected)) {
      cout << "\t" << val << endl;
    }
    
    TestBenchSpec tb = buildTB("mvmul", memoryInit, memoryExpected, testLayout);
    tb.useModSpecs = true;
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mvmul"));
  }

  TEST_CASE("scalar mul with fifos") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("scalar mul with fifos in LLVM", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{fifoType(32)->getPointerTo(),
      fifoType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "smul_fifo", mod.get());

    int numIns = 15;
    ConstantInt* loopBound = mkInt(numIns, 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);        
    
    auto fRead = fifoRead(32, mod.get());
    auto fWrite = fifoWrite(32, mod.get());

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
  
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    
    auto a = loopBuilder.CreateCall(fRead, {getArg(f, 0)});
    auto c = loopBuilder.CreateMul(mkInt(2, 32), a);
    loopBuilder.CreateCall(fWrite, {c, getArg(f, 1)});
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);
    
    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);
    
    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;
    
    InterfaceFunctions interfaces;
    interfaces.addFunction(fRead);
    implementRVFifoRead(fRead,
        interfaces.getConstraints(fRead));

    interfaces.addFunction(fWrite);
    implementRVFifoWrite(fWrite,
        interfaces.getConstraints(fWrite));

    ExecutionConstraints exec;
    //set<BasicBlock*> toPipeline{loopBlock};
    set<BasicBlock*> toPipeline{};
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);
    //printAllInstructions(arch, info);
    emitVerilog(arch, info);

    int maxCycles = 300;
    TestBenchSpec tb = newTB("smul_fifo", maxCycles);
    //tb.settableWires.insert("arg_1_write_valid");
    //tb.settableWires.insert("arg_1_read_valid");
    //tb.injectVerilog("always @(posedge clk) begin arg_1_read_valid = 1; $display(\"arg_1_in_data = %d\", arg_1_in_data); end");
    //tb.injectVerilog("\n\t");
    //tb.injectVerilog("always @(posedge clk) begin $display(\"total cycles = %d\", total_cycles); end");
    //tb.injectVerilog("always @(posedge clk) begin $display(\"arg_1_out_data = %d\", arg_1_out_data); end");
    int startRunCycle = 0;

    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int writeTime = 3;
    vector<pair<int, int> > fifoAIns;
    vector<pair<int, int> > fifoBIns;
    vector<pair<int, string> > fifoExpected;
    int checkTime = 100;
    for (int i = 0; i < numIns; i++) {
      fifoAIns.push_back({writeTime, i});
      fifoBIns.push_back({writeTime, i});
      fifoExpected.push_back({checkTime, to_string(i + i)});
      checkTime += 2;
      writeTime += 2;
    }
    setRVFifo(tb, "arg_0", fifoAIns);

    checkRVFifo(tb, "arg_1", fifoExpected);
    map<string, int> testLayout;
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("smul_fifo"));
  } 

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
    implementRAMWriteP0(ramWrite,
        1,
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
    //addNoXChecks(arch, info);
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

    auto mod = llvm::make_unique<Module>("vector add with fifos in LLVM", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{fifoType(32)->getPointerTo(),
      fifoType(32)->getPointerTo(),
      fifoType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "vadd_fifo", mod.get());

    ConstantInt* loopBound = mkInt("512", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);        
    
    auto fRead = fifoRead(32, mod.get());
    auto fWrite = fifoWrite(32, mod.get());

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
  
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    
    auto a = loopBuilder.CreateCall(fRead, {getArg(f, 0)});
    auto b = loopBuilder.CreateCall(fRead, {getArg(f, 1)});
    auto c = loopBuilder.CreateAdd(a, b);
    loopBuilder.CreateCall(fWrite, {c, getArg(f, 2)});
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);
    
    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);
    
    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;
    
    InterfaceFunctions interfaces;
    interfaces.addFunction(fRead);
    implementRVFifoRead(fRead,
        interfaces.getConstraints(fRead));

    interfaces.addFunction(fWrite);
    implementRVFifoWrite(fWrite,
        interfaces.getConstraints(fWrite));

    ExecutionConstraints exec;
    //set<BasicBlock*> toPipeline{loopBlock};
    set<BasicBlock*> toPipeline{};
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);
    //printAllInstructions(arch, info);
    emitVerilog(arch, info);

    TestBenchSpec tb = newTB("vadd_fifo", 5000);
    tb.settableWires.insert("arg_2_write_valid");
    tb.injectVerilog("always @(*) begin arg_2_write_valid = 1; end");
    //tb.injectVerilog("always @(posedge clk) begin $display(\"total cycles = %d\", total_cycles); end");
    int startRunCycle = 10;

    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int numIns = 512;
    int writeTime = 3;
    vector<pair<int, int> > fifoAIns;
    vector<pair<int, int> > fifoBIns;
    vector<pair<int, string> > fifoExpected;
    int checkTime = 3000;
    for (int i = 0; i < numIns; i++) {
      fifoAIns.push_back({writeTime, i});
      fifoBIns.push_back({writeTime, i});
      fifoExpected.push_back({checkTime, to_string(i + i)});
      checkTime += 2;
      writeTime += 2;
    }
    setRVFifo(tb, "arg_0", fifoAIns);
    //setRVFifo(tb, "arg_1", fifoAIns);

    map<string, int> testLayout;
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("vadd_fifo"));
  } 
  
  TEST_CASE("Histogram") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    TestBenchSpec tb = newTB("histogram", 5000);
   
    int startRunCycle = 1000;
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));
    
    vector<int> imageValues;
    for (int i = 0; i < 1024; i++) {
      imageValues.push_back((i*3 + 17) % 256);
    }

    vector<int> correct;
    correct.resize(256);
    vector<int> allZerosValues;
    allZerosValues.resize(256);
    for (int i = 0; i < 256; i++) {
      correct[i] = 0;
      allZerosValues[i] = 0;
    }
    for (int i = 0; i < imageValues.size(); i++) {
      int pix = imageValues[i];
      correct[pix] = correct[pix] + 1;
    }

    int setMemCycle = 1;
    int checkMemCycle = 2500;
    setRAM(tb, setMemCycle, "arg_0", imageValues);
    setRAM(tb, setMemCycle, "arg_1", allZerosValues);
    checkRAM(tb, checkMemCycle, "arg_1", correct);
    
    SECTION("with forwarding") {

      auto mod = llvm::make_unique<Module>("histogram in LLVM", context);
      setGlobalLLVMModule(mod.get());

      std::vector<Type *> inputs{sramType(8, 1024)->getPointerTo(),
        sramType(32, 256)->getPointerTo()};
      Function* f = mkFunc(inputs, "histogram", mod.get());

      auto entryBlock = mkBB("entry_block", f);
      auto loopBlock = mkBB("loop_block", f);
      auto exitBlock = mkBB("exit_block", f);        

      IRBuilder<> entryBuilder(entryBlock);

      ConstantInt* loopBound = mkInt("1024", 32);
      ConstantInt* zero = mkInt("0", 32);    
      ConstantInt* one = mkInt("1", 32);    
      entryBuilder.CreateBr(loopBlock);

      IRBuilder<> loopBuilder(loopBlock);

      auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
      auto lastCnt = loopBuilder.CreatePHI(intType(32), 2);
      auto lastPix = loopBuilder.CreatePHI(intType(8), 2);
      auto nextInd = loopBuilder.CreateAdd(indPhi, one);

      auto pix = loadRAMVal(loopBuilder, getArg(f, 0), indPhi);
      auto cnt = loadRAMVal(loopBuilder, getArg(f, 1), pix);
      auto cntN = loopBuilder.CreateAdd(cnt, one);
      auto fwdCnt = loopBuilder.CreateAdd(lastCnt, one);

      auto shouldFwd = loopBuilder.CreateAnd(loopBuilder.CreateICmpEQ(lastPix, pix), loopBuilder.CreateICmpNE(indPhi, zero));
      loopBuilder.CreateSelect(shouldFwd, fwdCnt, cntN);
      storeRAMVal(loopBuilder, getArg(f, 1), pix, cntN);
      
      auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
      loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

      indPhi->addIncoming(zero, entryBlock);
      indPhi->addIncoming(nextInd, loopBlock);

      lastCnt->addIncoming(zero, entryBlock);
      lastCnt->addIncoming(cntN, loopBlock);

      lastPix->addIncoming(mkInt(0, 8), loopBlock);
      lastPix->addIncoming(pix, loopBlock);

      IRBuilder<> exitBuilder(exitBlock);
      exitBuilder.CreateRet(nullptr);
      // Build verilog

      cout << "Histogram function with forwarding" << endl;
      cout << valueString(f) << endl;

      HardwareConstraints hcs = standardConstraints();
      hcs.typeSpecs[string("SRAM_8_1024")] =
        [](StructType* tp) { return ramSpec(32, 512); };
      hcs.typeSpecs[string("SRAM_32_256")] =
        [](StructType* tp) { return ramSpec(32, 256); };

      InterfaceFunctions interfaces;
      Function* ramRead = ramLoadFunction(getArg(f, 0));
      interfaces.addFunction(ramRead);
      implementRAMRead0(ramRead,
          interfaces.getConstraints(ramRead));

      Function* ramRead0 = ramLoadFunction(getArg(f, 1));
      interfaces.addFunction(ramRead0);
      implementRAMRead0(ramRead0,
          interfaces.getConstraints(ramRead0));

      Function* ramWrite = ramStoreFunction(getArg(f, 1));
      interfaces.addFunction(ramWrite);
      implementRAMWriteP0(ramWrite,
          1,
          interfaces.getConstraints(ramWrite));

      set<BasicBlock*> blocksToPipeline{loopBlock};
      ExecutionConstraints exec;

      exec.toPipeline = {{true, {loopBlock}}};
      //createMemoryConstraints(f, hcs, exec);

      //set<BasicBlock*> toPipeline{loopBlock};
      Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline, exec);
      STG graph = buildSTG(s, f);

      cout << "Histogram STG Is" << endl;
      graph.print(cout);

      REQUIRE(graph.pipelines.size() == 1);
      REQUIRE(graph.pipelines[0].II() == 1);
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      //addNoXChecks(arch, info);
      //printAllInstructions(arch, info);

      emitVerilog(arch, info);

      map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("histogram"));
    }

    SECTION("no forwarding") {

      auto mod = llvm::make_unique<Module>("forwarding histogram in LLVM", context);
      setGlobalLLVMModule(mod.get());

      std::vector<Type *> inputs{sramType(8, 1024)->getPointerTo(),
        sramType(32, 256)->getPointerTo()};
      Function* f = mkFunc(inputs, "histogram_with_forwarding", mod.get());

      auto entryBlock = mkBB("entry_block", f);
      auto loopBlock = mkBB("loop_block", f);
      auto exitBlock = mkBB("exit_block", f);        

      IRBuilder<> entryBuilder(entryBlock);

      ConstantInt* loopBound = mkInt("1024", 32);
      ConstantInt* zero = mkInt("0", 32);    
      ConstantInt* one = mkInt("1", 32);    
      entryBuilder.CreateBr(loopBlock);

      IRBuilder<> loopBuilder(loopBlock);

      auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
      auto nextInd = loopBuilder.CreateAdd(indPhi, one);

      auto pix = loadRAMVal(loopBuilder, getArg(f, 0), indPhi);
      auto cnt = loadRAMVal(loopBuilder, getArg(f, 1), pix);
      auto cntN = loopBuilder.CreateAdd(cnt, one);
      storeRAMVal(loopBuilder, getArg(f, 1), pix, cntN);
      auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
      loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);
      indPhi->addIncoming(zero, entryBlock);
      indPhi->addIncoming(nextInd, loopBlock);

      IRBuilder<> exitBuilder(exitBlock);
      exitBuilder.CreateRet(nullptr);

      HardwareConstraints hcs = standardConstraints();
      hcs.typeSpecs[string("SRAM_8_1024")] =
        [](StructType* tp) { return ramSpec(32, 512); };
      hcs.typeSpecs[string("SRAM_32_256")] =
        [](StructType* tp) { return ramSpec(32, 256); };

      InterfaceFunctions interfaces;
      Function* ramRead = ramLoadFunction(getArg(f, 0));
      interfaces.addFunction(ramRead);
      implementRAMRead0(ramRead,
          interfaces.getConstraints(ramRead));


      Function* ramRead0 = ramLoadFunction(getArg(f, 1));
      interfaces.addFunction(ramRead0);
      implementRAMRead0(ramRead0,
          interfaces.getConstraints(ramRead0));
      
      Function* ramWrite = ramStoreFunction(getArg(f, 1));
      interfaces.addFunction(ramWrite);
      implementRAMWriteP0(ramWrite,
          1,
          interfaces.getConstraints(ramWrite));

      set<BasicBlock*> blocksToPipeline{loopBlock};
      ExecutionConstraints exec;

      exec.toPipeline = {{true, {loopBlock}}};
      // Equivalent of pragma ignore dependencies
      createMemoryConstraints(f, hcs, exec);

      //set<BasicBlock*> toPipeline{loopBlock};
      Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline, exec);
      STG graph = buildSTG(s, f);

      cout << "Histogram with forwarding STG Is" << endl;
      graph.print(cout);

      REQUIRE(graph.pipelines.size() == 1);
      //REQUIRE(graph.pipelines[0].II() == 2);
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      //addNoXChecks(arch, info);
      //printAllInstructions(arch, info);

      emitVerilog(arch, info);

      map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("histogram"));
    }
  }
}
