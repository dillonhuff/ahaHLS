#include "catch.hpp"

namespace ahaHLS {

  TEST_CASE("Matrix vector multiply pipelined") {
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

    set<TaskSpec> tasks = allOneTask(f);
    set<PipelineSpec> toPipeline = pipelineAllLoops(f);
    createMemoryConstraints(f, hcs, exec);
    SchedulingProblem p =
      createSchedulingProblem(f, hcs, toPipeline, tasks, preds);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"a", 0}, {"b", 9}, {"c", 12}};
    map<llvm::Value*, int> layout;

    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);
    //printAllInstructions(arch, info);
    // addControlSanityChecks(arch, info);
    // noAddsTakeXInputs(arch, info);
    // noMulsTakeXInputs(arch, info);
    // noPhiOutputsXWhenUsed(arch, info);
    // noStoredValuesXWhenUsed(arch, info);

    emitVerilog("mvmul_pipelined", arch, info);

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
    
    TestBenchSpec tb = buildTB("mvmul_pipelined", memoryInit, memoryExpected, testLayout);
    tb.useModSpecs = true; 

    int startRunCycle = 10;
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));
    
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mvmul_pipelined"));
  
  }

}
