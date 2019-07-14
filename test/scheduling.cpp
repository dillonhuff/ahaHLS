#define CATCH_CONFIG_MAIN

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

  TestBenchSpec buildTB(std::string name,
                        map<string, vector<int> >& memoryInit,
                        map<string, vector<int> >& memoryExpected,
                        map<string, int>& testLayout);
  
  ModuleSpec axiWriterSpec(llvm::StructType* tp) {
    map<string, string> modParams;
    map<string, Port> ports{{"write_data", inputPort(32, "write_data")},
        {"write_addr", inputPort(5, "write_addr")},
          {"valid", outputPort(1, "valid")},
            {"ready", outputPort(1, "ready")},
              {"start_write", inputPort(1, "start_write")}};

    map<string, int> defaults{{"start_write", 0}};
    return {modParams, "axi_write_handler", ports, defaults};
  }

  ModuleSpec axiReaderSpec(llvm::StructType* tp) {
    map<string, string> modParams;
    map<string, Port> ports{{"read_data", outputPort(32, "read_data")},
        {"read_addr", inputPort(5, "read_addr")},
          {"valid", outputPort(1, "valid")},
            {"ready", outputPort(1, "ready")},
              {"start_read", inputPort(1, "start_read")}};
    
    map<string, int> defaults{{"start_read", 0}};
    return {modParams, "axi_read_handler", ports, defaults};
  }

  // Q: System TODOs:
  // A: Remove useless address fields from registers (allow custom memory interfaces)
  //    Move test layout into testbenchspec
  //    Add some simple examples to the README
  //    Convert ptr to builtin codes to RAM templates
  //    Shrink registers to reduce area costs
  //    Remove modspecs
  //    Remove internal RAM code
  //    Add full paths for interface classes

  // NOTE: The code for testbenches is getting really complicated. Some of that
  // is automatic testbench generation, but some of it is just the hodgepodge of
  // different data structures for scheduling, verilog code generation, and
  // constraint generation. These really need to be fixed up.
  // Ideas?
  //  1. Merge schedule and STG creation in to one function when the schedule
  //     does not need to be checked
  //  2. Remove or wrap the function -> SchedulingConstraints map

  // Q: What test cases do I need?
  // A: Test case with outer loop pipelining
  //    Test case that pipelines inner loop surrounded by outer loop
  //    Test case using a ready-valid interface together with pipelining
  //    Test case that builds a linebuffer from LLVM
  //    Test case with struct (compound type) passed via channel (or used by value)
  TEST_CASE("Schedule a single store operation") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "single_store");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "single_store");
    getArg(f, 0)->setName("a");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    
    REQUIRE(s.numStates() == 4);

    auto& retInstr = f->getBasicBlockList().back().back();
    REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    map<llvm::Value*, int> layout = {};
    //ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("single_store", arch, info);

    REQUIRE(runIVerilogTB("single_store"));
  }

  TEST_CASE("Histogram with pipelining") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "hist_simple");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "hist_simple");
    getArg(f, 0)->setName("img");
    getArg(f, 1)->setName("hist");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM.0"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM.0.2"] = ramSpecFunc;    
    hcs.typeSpecs["class.RAM.1"] = ramSpecFunc;    
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    map<string, int> testLayout = {};
    TestBenchSpec tb;
    tb.memoryExpected = {};
    tb.runCycles = 100;
    tb.name = "hist_simple";
    tb.useModSpecs = true;
    int startSetMemCycle = 1;

    
    int startRunCycle = startSetMemCycle + 20;
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 100;
    //checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

    setRAMContents(tb, startSetMemCycle, "img", {0, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3});
    setRAMContents(tb, startSetMemCycle, "hist", {0, 0, 0, 0});
    checkRAMContents(tb, checkMemCycle + 100, "hist", {1, 8, 5, 2});

    SECTION("Baseline: No pipelining") {
      Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout = {};
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);
      emitVerilog("hist_simple", arch, info);

      
      emitVerilogTestBench(tb, arch, testLayout);
      REQUIRE(runIVerilogTB("hist_simple"));
    }

    SECTION("With illegal pipeline II") {
      set<BasicBlock*> toPipeline;
      for (auto& bb : f->getBasicBlockList()) {
        toPipeline.insert(&bb);
      }
      Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout = {};
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);
      emitVerilog("hist_simple_illegal", arch, info);


      tb.name = "hist_simple_illegal";
      emitVerilogTestBench(tb, arch, testLayout);

      // This should fail
      REQUIRE(!runIVerilogTB("hist_simple_illegal"));
    }

    SECTION("Pipelined, forwarded histogram") {
      auto mod = loadCppModule(context, err, "hist_forwarded");
      setGlobalLLVMModule(mod.get());

      auto f = getFunctionByDemangledName(mod.get(), "hist_forwarded");
      getArg(f, 0)->setName("img");
      getArg(f, 1)->setName("hist");

      cout << "LLVM Function" << endl;
      cout << valueString(f) << endl;

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      PipelineSpec all{false, {}};
      for (auto& blk : f->getBasicBlockList()) {
        if (&blk != &(f->getEntryBlock())) {
          if (!ReturnInst::classof(blk.getTerminator())) {
            all.blks.insert(&blk);

            cout << "Pipelining block " << endl;
            cout << valueString(&blk) << endl;
          }
        }
      }
      toPipeline.insert(all);

      // Changed
      SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout = {};
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);
      emitVerilog("hist_forwarded", arch, info);

      tb.name = "hist_forwarded";
      emitVerilogTestBench(tb, arch, testLayout);

      //REQUIRE(runIVerilogTB("hist_forwarded"));    
    }

  }
  
  TEST_CASE("Schedule a single store operation and lowering the microarchitecture") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "single_store");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "single_store");
    getArg(f, 0)->setName("a");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    
    REQUIRE(s.numStates() == 4);

    auto& retInstr = f->getBasicBlockList().back().back();
    REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    map<llvm::Value*, int> layout = {};
    //ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    convertRegisterControllersToPortControllers(arch);

    VerilogDebugInfo info;
    emitVerilog("single_store", arch, info);

    REQUIRE(runIVerilogTB("single_store"));
  }  

  TEST_CASE("Adding two numbers and storing them back") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "plus");
    setGlobalLLVMModule(Mod.get());
    
    Function* f = getFunctionByDemangledName(Mod.get(), "plus");
    getArg(f, 0)->setName("mem");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;    
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    
    Schedule s = scheduleInterface(f, hcs, interfaces);

    REQUIRE(s.numStates() == 5);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 5);

    map<llvm::Value*, int> layout = {};
    //ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("plus", arch, info);
    
    REQUIRE(runIVerilogTB("plus"));
  }

  TEST_CASE("A simple if") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "if_else");
    setGlobalLLVMModule(Mod.get());
    
    Function* f = getFunctionByDemangledName(Mod.get(), "if_else");
    getArg(f, 0)->setName("mem");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    map<llvm::Value*, int> layout = {};
    //ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    emitVerilog("if_else", arch, info);
    
    REQUIRE(runIVerilogTB("if_else"));
  }
  
  TEST_CASE("Accessing a memory address that requires address calculation") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "read_2"); // Cpp
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "read_2");
    getArg(f, 0)->setName("mem");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("read_2", graph, hcs);
    
    REQUIRE(runIVerilogTB("read_2"));
    
  }

  TEST_CASE("Histogram of image colors") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "histogram");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "histogram");
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    // emitVerilog("histogram", graph, hcs);

    // REQUIRE(runIVerilogTB("histogram"));
  }

  TEST_CASE("Looping over an array doing a[i] + 7") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    //std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_7");
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_7");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_7");
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;

    map<Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    addControlSanityChecks(arch, info);
    emitVerilog("loop_add_7", arch, info);
    
    // auto arch = buildMicroArchictecture(graph, hcs);
    // addNoXChecks(arch, info);    
    // //emitVerilog("loop_add_7", graph, hcs);
    // emitVerilog("loop_add_7", arch, info);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Adding numbers with resource limits") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "many_adds");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "many_adds");
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

    // Limits number of adders
    hcs.setCount(ADD_OP, 1);

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    for (auto st : graph.opStates) {
      map<OperationType, int> opCounts;
      for (auto instrG : st.second) {
        Instruction* instr = instrG;
        OperationType tp = opType(instr);
        if (contains_key(tp, opCounts)) {
          opCounts[tp] = opCounts[tp] + 1;
        } else {
          opCounts[tp] = 1;
        }
      }

      for (auto op : opCounts) {
        REQUIRE(op.second <= hcs.getCount(op.first));
      }
    }

    emitVerilog("many_adds", graph, hcs);
    
    REQUIRE(runIVerilogTB("many_adds"));
  }

  TEST_CASE("Greater than") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "cmp_gt");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "cmp_gt");
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

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    emitVerilog("cmp_gt", graph, hcs);

    REQUIRE(runIVerilogTB("cmp_gt"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 7") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_7");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_7");
    getArg(f, 0)->setName("ram");

    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              // Now need to compute two things:
              //   1. The internal schedule that will be used within iterations
              //      of the loop
              //   2. The initiation interval

              // To incorporate this into real code we will also need
              // a way to express which blocks are pipelined to the whole
              // system scheduler. This scheduler will then have to isolate
              // those blocks from the rest of the system

              blocksToPipeline.insert(&bb);

            }
          }
        }
      }
    }

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    PipelineSpec spec{true, {*begin(blocksToPipeline)}};
    //REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);
    REQUIRE(map_find(spec, s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    emitVerilog("loop_add_7", graph, hcs);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations small enough to never fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_4");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4");
    getArg(f, 0)->setName("ram");

    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              blocksToPipeline.insert(&bb);
            }
          }
        }
      }
    }

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    PipelineSpec spec{true, {*begin(blocksToPipeline)}};
    //REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);
    REQUIRE(map_find(spec, s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);
    
    VerilogDebugInfo info;

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("loop_add_4", graph, hcs, info);

    REQUIRE(runIVerilogTB("loop_add_4"));
  }

  // Issue: How do we express the need to set defaults on ports? We need to be
  // able to express that the wen == 0 at the end of a RAM write is only a default
  // value and should not be considered essential
  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations large enough to fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "loop_add_4_6_iters");
    setGlobalLLVMModule(Mod.get());

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;    
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4_6_iters");
    getArg(f, 0)->setName("ram");

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);

    
    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              blocksToPipeline.insert(&bb);
            }
          }
        }
      }
    }

    // Pipelined
    ExecutionConstraints exec;

    addDataConstraints(f, exec);
    inlineWireCalls(f, exec, interfaces);

    SchedulingProblem p = createSchedulingProblem(f, hcs, blocksToPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline, constraints);
    // Pipelined

    REQUIRE(s.numStates() == 7);
    PipelineSpec spec{true, {*(begin(blocksToPipeline))}};
    REQUIRE(map_find(spec, s.pipelineSchedules) == 1);    
    //REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog("loop_add_4_6_iters", arch, info);

    REQUIRE(runIVerilogTB("loop_add_4_6_iters"));
  }
  
  TEST_CASE("Using temporary memory") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_4_copy");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4_copy");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead0;  
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    // Arch debug
    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});

    emitVerilog("loop_add_4_copy", graph, hcs, info);
    
    // runCmd("cat loop_add_4_copy.v");
    // runCmd("cat RAM2.v");
    // runCmd("cat loop_add_4_copy_tb.v");

    REQUIRE(runIVerilogTB("loop_add_4_copy"));
  }
  
  TestBenchSpec buildTB(std::string name,
                        map<string, vector<int> >& memoryInit,
                        map<string, vector<int> >& memoryExpected,
                        map<string, int>& testLayout) {
    TestBenchSpec tb;
    tb.useModSpecs = true;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 200;
    tb.name = name;

    int startSetMemCycle = 1;
    setRAM(tb, 1, "ram", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 150;
    checkRAM(tb, checkMemCycle, "ram", memoryExpected, testLayout);

    return tb;
  }

  TEST_CASE("Blur without linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "blur_no_lb");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "blur_no_lb");
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

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    VerilogDebugInfo info;

    
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}}; //, {getArg(f, 1), 8}};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    addNoXChecks(arch, info);    
    //emitVerilog("blur_no_lb", graph, hcs);
    emitVerilog("blur_no_lb", arch, info);
    
    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<string, vector<int> > memoryInit{{"a", {0, 1, 2, 3, 7, 5, 5, 2}}};
    map<string, vector<int> > memoryExpected{{"b", {}}};

    auto ma = map_find(string("a"), memoryInit);
    for (int i = 1; i < 8 - 1; i++) {
      map_insert(memoryExpected, string("b"), (ma[i - 1] + ma[i] + ma[i + 1]));
    }

    cout << "Expected values" << endl;
    for (auto val : map_find(string("b"), memoryExpected)) {
      cout << "\t" << val << endl;
    }

    TestBenchSpec tb = buildTB("blur_no_lb", memoryInit, memoryExpected, testLayout);
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("blur_no_lb"));
  }

  TEST_CASE("Blur with linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "blur_lb");
    setGlobalLLVMModule(Mod.get());

    // HardwareConstraints hcs;
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);
    // HardwareConstraints hcs = standardConstraints();

    Function* f = getFunctionByDemangledName(Mod.get(), "blur_lb"); //Mod->getFunction("blur_lb");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    Schedule s = scheduleInterface(f, hcs, interfaces);

    // Schedule s = scheduleInter
    //Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 8}};
    map<llvm::Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    //auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});

    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    //emitVerilog(f, arch, info);
    emitVerilog("blur_lb", graph, hcs); //, arch, info);

    // Testbench specification
    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<string, vector<int> > memoryInit{{"a", {0, 1, 2, 3, 7, 5, 5, 2}}};
    map<string, vector<int> > memoryExpected{{"b", {}}};

    auto ma = map_find(string("a"), memoryInit);
    for (int i = 1; i < 8 - 1; i++) {
      map_insert(memoryExpected, string("b"), (ma[i - 1] + ma[i] + ma[i + 1]));
    }

    TestBenchSpec tb = buildTB("blur_lb", memoryInit, memoryExpected, testLayout);
    tb.useModSpecs = true;

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("blur_lb"));
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

    Schedule s = scheduleInterface(f, hcs, interfaces);
    
    STG graph = buildSTG(s, f);

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

  TEST_CASE("Simple outer loop pipeline") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple outer loop pipeline", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "simple_outer_pipe", mod.get());

    auto entryBlk = mkBB("entry_block", f);
    auto outerEntryBlk = mkBB("outer_loop_entry_block", f);
    auto outerExitBlk = mkBB("outer_loop_exit_block", f);
    auto innerBlk = mkBB("inner_loop_block", f);
    auto exitBlk = mkBB("exit_block", f);

    IRBuilder<> entryBuilder(entryBlk);
    entryBuilder.CreateBr(outerEntryBlk);

    IRBuilder<> outerEntryBuilder(outerEntryBlk);
    auto indPhi = outerEntryBuilder.CreatePHI(intType(32), 2);
    auto nextInd = outerEntryBuilder.CreateAdd(indPhi, mkInt(1, 32));

    outerEntryBuilder.CreateBr(innerBlk);

    indPhi->addIncoming(mkInt(0, 32), entryBlk);
    indPhi->addIncoming(nextInd, outerExitBlk);
    
    IRBuilder<> innerBuilder(innerBlk);
    auto innerInd = innerBuilder.CreatePHI(intType(32), 2);
    auto nextInnerInd = innerBuilder.CreateAdd(innerInd, mkInt(1, 32));
    auto innerLoopDone = innerBuilder.CreateICmpEQ(nextInnerInd, mkInt(4, 32));
    innerBuilder.CreateCondBr(innerLoopDone, outerExitBlk, innerBlk);

    innerInd->addIncoming(mkInt(0, 32), outerEntryBlk);
    innerInd->addIncoming(nextInnerInd, innerBlk);
    
    IRBuilder<> outerExitBuilder(outerExitBlk);
    auto outerLoopDone = outerExitBuilder.CreateICmpEQ(nextInd, mkInt(5, 32));
    storeRAMVal(outerExitBuilder, getArg(f, 0), indPhi, innerInd);
    outerExitBuilder.CreateCondBr(outerLoopDone, exitBlk, outerEntryBlk);

    IRBuilder<> exitBuilder(exitBlk);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;
    
    Function* ramRead = ramLoadFunction(getArg(f, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(f, 0));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));

    SECTION("No pipelining") {
      Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // Create testing infrastructure
      map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      map<string, vector<int> > memoryExpected{{"arg_0", {3, 3, 3, 3, 3}}};

      auto arg0 = dyn_cast<Argument>(getArg(f, 0));
      string in0Name = string(arg0->getName());
    
      TestBenchSpec tb;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 8;
      tb.name = "simple_outer_pipe";
      tb.useModSpecs = true;
      int startSetMemCycle = 1;
    
      int startRunCycle = startSetMemCycle + 2; 
      map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      int checkMemCycle = 100;
      checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("simple_outer_pipe"));
    }

    SECTION("With pipelining") {

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      PipelineSpec all{false, {}};
      for (auto& blk : f->getBasicBlockList()) {
        if (&blk != &(f->getEntryBlock())) {
          if (!ReturnInst::classof(blk.getTerminator())) {
            all.blks.insert(&blk);

            cout << "Pipelining block " << endl;
            cout << valueString(&blk) << endl;
          }
        }
      }
      toPipeline.insert(all);

      // Changed
      SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

      // Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // Create testing infrastructure
      map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      map<string, vector<int> > memoryExpected{{"arg_0", {3, 3, 3, 3, 3}}};

      auto arg0 = dyn_cast<Argument>(getArg(f, 0));
      string in0Name = string(arg0->getName());
    
      TestBenchSpec tb;
      tb.memoryExpected = memoryExpected;
      tb.name = "simple_outer_pipe";
      tb.useModSpecs = true;
      int startSetMemCycle = 1;
    
      int startRunCycle = startSetMemCycle + 2; 
      map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      int checkMemCycle = 30;
      checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("simple_outer_pipe"));
    }
    
  }

  TEST_CASE("Task parallelism and pipelining with successive simple loops") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("task parallel loop pairs", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo(),};
    Function* f = mkFunc(inputs, "task_parallel_loops", mod.get());

    auto entryBlk = mkBB("entry_block", f);
    auto loop0Blk = mkBB("loop0", f);
    auto loop1Blk = mkBB("loop1", f);
    auto exitBlk = mkBB("exit_block", f);

    IRBuilder<> entryBuilder(entryBlk);
    entryBuilder.CreateBr(loop0Blk);

    {
      IRBuilder<> loop0Builder(loop0Blk);
      auto indPhi = loop0Builder.CreatePHI(intType(32), 2);
      auto nextInd = loop0Builder.CreateAdd(indPhi, mkInt(1, 32));
      storeRAMVal(loop0Builder, getArg(f, 0), indPhi, indPhi);
      auto loop0Done = loop0Builder.CreateICmpEQ(nextInd, mkInt(4, 32));
      loop0Builder.CreateCondBr(loop0Done, loop1Blk, loop0Blk);

      indPhi->addIncoming(mkInt(0, 32), entryBlk);
      indPhi->addIncoming(nextInd, loop0Blk);
    }

    {
      IRBuilder<> loop0Builder(loop1Blk);
      auto indPhi = loop0Builder.CreatePHI(intType(32), 2);
      auto nextInd = loop0Builder.CreateAdd(indPhi, mkInt(1, 32));
      //storeRAMVal(loop0Builder, getArg(f, 0), loop0Builder.CreateAdd(indPhi, mkInt(4, 32)), indPhi);
      storeRAMVal(loop0Builder, getArg(f, 1), indPhi, indPhi);
      auto loop0Done = loop0Builder.CreateICmpEQ(nextInd, mkInt(4, 32));
      loop0Builder.CreateCondBr(loop0Done, exitBlk, loop1Blk);

      indPhi->addIncoming(mkInt(0, 32), loop0Blk);
      indPhi->addIncoming(nextInd, loop1Blk);
    }
    
    IRBuilder<> exitBuilder(exitBlk);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    
    HardwareConstraints hcs = standardConstraints();
    //setMemSpec(getArg(srUser, 0), hcs, ramSpec(1, 3, 2, 1, ramWidth, ramDepth));
    hcs.typeSpecs[string("SRAM_32_16")] =
      // new ram spec
      //[](StructType* tp) { return ramSpec(32, 16, 2, 1); };
      [](StructType* tp) { return ramSpec(32, 16); };

    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;
    
    Function* ramRead = ramLoadFunction(getArg(f, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(f, 0));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));


      // Create testing infrastructure
      map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      map<string, vector<int> > memoryExpected{{"arg_0", {0, 1, 2, 3, 0, 1, 2, 3}}};

      TestBenchSpec tb;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 8;
      tb.name = "task_parallel_loops";
      tb.useModSpecs = true;
      int startSetMemCycle = 1;
    
      int startRunCycle = startSetMemCycle + 2; 
      map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      int checkMemCycle = 100;
      //checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      checkRAMContents(tb, checkMemCycle, "arg_0", {0, 1, 2, 3});
      checkRAMContents(tb, checkMemCycle + 30, "arg_1", {0, 1, 2, 3});
    
    SECTION("No pipelining and no task parallelism") {
      Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      checkSignal(tb,
                   "valid",
                  {{3, 0}, {10, 0}, {30, 0}, {35, 1}, {40, 1}, {100, 1}});
      
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("task_parallel_loops"));
    }

    SECTION("Both successive loops inside a single pipeline") {

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      set<BasicBlock*> task0{entryBlk, loop0Blk};
      set<BasicBlock*> task1{loop1Blk, exitBlk};
      
      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      PipelineSpec l0{false, {loop0Blk, loop1Blk}};
      //PipelineSpec l1{false, {loop1Blk}};      
      toPipeline.insert(l0);
      //toPipeline.insert(l1);

      // TODO: Remove when we have real hazard resolution
      exec.addConstraint(end(loop0Blk) < start(loop1Blk));

      // Changed
      SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

      // Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // Create testing infrastructure
      // map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      // map<string, vector<int> > memoryExpected{{"arg_0", {0, 1, 2, 3, 0, 1, 2, 3}}};

      // TestBenchSpec tb;
      // tb.memoryExpected = memoryExpected;
      // tb.name = "task_parallel_loops";
      // tb.useModSpecs = true;
      // int startSetMemCycle = 1;
    
      // int startRunCycle = startSetMemCycle + 2; 
      // map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      // map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      // int checkMemCycle = 100;
      // checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      checkSignal(tb,
                   "valid",
                  {{3, 0}, {10, 0}, {15, 0}, {17, 1}, {20, 1}, {30, 1}, {35, 1}, {40, 1}, {100, 1}});
      
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("task_parallel_loops"));
    }

    SECTION("Each loop in a different task") {

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      set<BasicBlock*> task0{entryBlk, loop0Blk};
      set<BasicBlock*> task1{loop1Blk, exitBlk};
      set<TaskSpec> tasks{{task0}, {task1}};
      
      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      SchedulingProblem p =
        createSchedulingProblem(f, hcs, toPipeline, tasks, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // // Create testing infrastructure
      // map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      // map<string, vector<int> > memoryExpected{{"arg_0", {0, 1, 2, 3, 0, 1, 2, 3}}};

      // TestBenchSpec tb;
      // tb.memoryExpected = memoryExpected;
      // tb.name = "task_parallel_loops";
      // tb.useModSpecs = true;
      // int startSetMemCycle = 1;
    
      // int startRunCycle = startSetMemCycle + 2; 
      // map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      // map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      // int checkMemCycle = 100;
      // checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      checkSignal(tb,
                   "valid",
                  {{3, 0}, {10, 0}, {15, 0}, {17, 0}, {19, 0}, {20, 1}, {25, 1}, {30, 1}, {35, 1}, {40, 1}, {100, 1}});

      //tb.actionOnCondition("1", "$display(\"valid = %d\", valid);");
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("task_parallel_loops"));
    }

    SECTION("Each loop pipelined in a different task") {

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      set<BasicBlock*> task0{entryBlk, loop0Blk};
      set<BasicBlock*> task1{loop1Blk, exitBlk};
      set<TaskSpec> tasks{{task0}, {task1}};
      
      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      toPipeline.insert({false, {loop0Blk}});
      toPipeline.insert({false, {loop1Blk}});
      
      SchedulingProblem p =
        createSchedulingProblem(f, hcs, toPipeline, tasks, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_0", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // // Create testing infrastructure
      // map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      // map<string, vector<int> > memoryExpected{{"arg_0", {0, 1, 2, 3, 0, 1, 2, 3}}};

      // TestBenchSpec tb;
      // tb.memoryExpected = memoryExpected;
      // tb.name = "task_parallel_loops";
      // tb.useModSpecs = true;
      // int startSetMemCycle = 1;
    
      // int startRunCycle = startSetMemCycle + 2; 
      // map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      // map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      // int checkMemCycle = 100;
      // checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

      checkSignal(tb,
                   "valid",
                  {{3, 0}, {10, 0}, {15, 1}, {17, 1}, {19, 1}, {20, 1}, {25, 1}, {30, 1}, {35, 1}, {40, 1}, {100, 1}});

      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("task_parallel_loops"));
    }
    
    
  }
  

  TEST_CASE("AXI based memory transfer") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "stalled_single_store_axi");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stalled_single_store_axi");
    getArg(f, 0)->setName("reader");
    getArg(f, 1)->setName("writer");

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);

    hcs.typeSpecs["class.axi_writer"] = axiWriterSpec;
    hcs.typeSpecs["class.axi_reader"] = axiReaderSpec;
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementAXIRead;
    interfaces.functionTemplates[string("write")] = implementAXIWrite;
    
    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});

    map<Value*, int> memLayout;
    auto arch = buildMicroArchitecture(graph, memLayout, hcs);
    addNoXChecks(arch, info);
    //emitVerilog("stalled_single_store_axi", graph, hcs, info);
    emitVerilog("stalled_single_store_axi", arch, info);
    
    REQUIRE(runIVerilogTB("stalled_single_store_axi"));
  }

  TEST_CASE("AXI raw memory transfer") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "raw_axi_wr");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "raw_axi_wr");
    getArg(f, 0)->setName("ram");

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.axi_ram"] = axiRamSpec;

    cout << "AXIL spec = " << axiRamSpec(nullptr) << endl;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRawAXIRead;
    interfaces.functionTemplates[string("write")] = implementRawAXIWrite;
    
    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);


    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;    
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    addNoXChecks(arch, info);

    //emitVerilog("raw_axi_wr", graph, hcs, info);
    emitVerilog("raw_axi_wr", arch, info);

    map<string, vector<int> > memoryInit;
    map<string, vector<int> > memoryExpected;
    map<string, int> testLayout;
    TestBenchSpec tb = buildTB("raw_axi_wr", memoryInit, memoryExpected, testLayout);
    map_insert(tb.actionsOnCycles, 50, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 50, assertString("ram_debug_data === 24"));
    
    tb.settableWires.insert("ram_debug_wr_en");
    tb.settableWires.insert("ram_debug_wr_addr");
    tb.settableWires.insert("ram_debug_wr_data");
    tb.settableWires.insert("ram_debug_addr");
    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_en = 1;"));
    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_addr = 1;"));
    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_data = 12;"));
    map_insert(tb.actionsInCycles, 2, string("ram_debug_wr_en = 0;"));

    map_insert(tb.actionsInCycles, 49, string("ram_debug_addr = 0;"));
    map_insert(tb.actionsInCycles, 50, string("ram_debug_addr = 0;"));

    //auto arch = buildMicroArchitecture(graph, layout, hcs);
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("raw_axi_wr"));
  }

  TEST_CASE("AXI memory transfer with multiple reads and writes") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "axi_multi_transfer");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "axi_multi_transfer");
    getArg(f, 0)->setName("ram");

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.axi_ram"] = axiRamSpec;
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRawAXIRead;
    interfaces.functionTemplates[string("write")] = implementRawAXIWrite;
    
    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});

    emitVerilog("axi_multi_transfer", graph, hcs, info);

    map<string, vector<int> > memoryInit;
    map<string, vector<int> > memoryExpected;
    map<string, int> testLayout;
    map<Value*, int> layout;    
    TestBenchSpec tb = buildTB("axi_multi_transfer", memoryInit, memoryExpected, testLayout);

    int endCycle = 100;
    map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));
    
    tb.settableWires.insert("ram_debug_wr_en");
    tb.settableWires.insert("ram_debug_wr_addr");
    tb.settableWires.insert("ram_debug_wr_data");
    tb.settableWires.insert("ram_debug_addr");
    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_en = 1;"));

    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_addr = 0;"));
    map_insert(tb.actionsInCycles, 1, string("ram_debug_wr_data = 12;"));

    map_insert(tb.actionsInCycles, 2, string("ram_debug_wr_addr = 1;"));
    map_insert(tb.actionsInCycles, 2, string("ram_debug_wr_data = 7;"));

    map_insert(tb.actionsInCycles, 3, string("ram_debug_wr_addr = 2;"));
    map_insert(tb.actionsInCycles, 3, string("ram_debug_wr_data = 8;"));

    map_insert(tb.actionsInCycles, 4, string("ram_debug_wr_addr = 3;"));
    map_insert(tb.actionsInCycles, 4, string("ram_debug_wr_data = 14;"));

    map_insert(tb.actionsInCycles, 5, string("ram_debug_wr_addr = 4;"));
    map_insert(tb.actionsInCycles, 5, string("ram_debug_wr_data = 12;"));
    
    map_insert(tb.actionsInCycles, 6, string("ram_debug_wr_en = 0;"));

    //map_insert(tb.actionsInCycles, 49, string("ram_debug_addr = 0;"));
    map_insert(tb.actionsInCycles, endCycle, string("ram_debug_addr = 5;"));
    map_insert(tb.actionsOnCycles, endCycle, assertString("ram_debug_data === 12 + 34"));

    map_insert(tb.actionsInCycles, endCycle + 1, string("ram_debug_addr = 6;"));
    map_insert(tb.actionsOnCycles, endCycle + 1, assertString("ram_debug_data === 7 + 34"));

    map_insert(tb.actionsInCycles, endCycle + 2, string("ram_debug_addr = 7;"));
    map_insert(tb.actionsOnCycles, endCycle + 2, assertString("ram_debug_data === 8 + 34"));

    map_insert(tb.actionsInCycles, endCycle + 3, string("ram_debug_addr = 8;"));
    map_insert(tb.actionsOnCycles, endCycle + 3, assertString("ram_debug_data === 14 + 34"));

    map_insert(tb.actionsInCycles, endCycle + 4, string("ram_debug_addr = 9;"));
    map_insert(tb.actionsOnCycles, endCycle + 4, assertString("ram_debug_data === 12 + 34"));
    
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("axi_multi_transfer"));
  }
  
  TEST_CASE("Building a simple function directly in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("shift register test", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* srUser = mkFunc(inputs, voidType(), "using_shift_register");

    cout << "Function = " << valueString(srUser) << endl;

    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* zero = mkInt("0", 32);
    ConstantInt* five = mkInt("5", 32);        
    IRBuilder<> builder(entryBlock);
    auto ldA = loadRAMVal(builder, getArg(srUser, 0), zero);
    auto plus = builder.CreateAdd(ldA, five);
    storeRAMVal(builder, getArg(srUser, 1), zero, plus);
    builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    InterfaceFunctions interfaces;
    Function* ramRead = ramLoadFunction(getArg(srUser, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(srUser, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));
    
    Schedule s = scheduleInterface(srUser, hcs, interfaces);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("using_shift_register", graph, hcs, info);

    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {11}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "using_shift_register";
    tb.useModSpecs = true;
    
    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 30;
    checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("using_shift_register"));
  }

  // Next test case: Need to do a stenciled loop where I fill
  // and then use a shift register for the loop computation
  TEST_CASE("Building a simple loop in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM accumulate loop", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto ldA = loadRAMVal(builder, dyn_cast<Value>(getArg(srUser, 0)), zero);
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
    //exitBuilder.CreateStore(nextSum, dyn_cast<Value>(srUser->arg_begin() + 1));
    storeRAMVal(exitBuilder, dyn_cast<Value>(getArg(srUser, 1)), mkInt(15, 32), nextSum);
    exitBuilder.CreateRet(nullptr);

    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    InterfaceFunctions interfaces;
    Function* ramRead = ramLoadFunction(getArg(srUser, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(srUser, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));
    
    Schedule s = scheduleInterface(srUser, hcs, interfaces);
    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*5}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "accum_loop";
    tb.useModSpecs = true;
    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 40;
    checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("accum_loop"));
  }

  // Next test case: Need to do a stenciled loop where I fill
  // and then use a shift register for the loop computation
  TEST_CASE("Outer loop pipelining of transfer from FIFO to RAM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("FIFO-RAM transfer", context);
    setGlobalLLVMModule(mod.get());

    int width = 32;
    
    InterfaceFunctions interfaces;
    StructType* tp = fifoType(width);
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    cout << "Read fifo func" << endl;
    cout << valueString(readFifo) << endl;

    Function* writeFifo = fifoWrite(width, mod.get());
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

    cout << "Write fifo func" << endl;
    cout << valueString(writeFifo) << endl;

    std::vector<Type *> inputs{tp->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "outer_loop_pipe", mod.get());

    auto entryBlk = mkBB("entry_block", f);
    auto loopBlk = mkBB("loop_stall_block", f);
    auto exitBlk = mkBB("exit_block", f);

    auto loopBound = mkInt(5, 32);
    
    IRBuilder<> entryBuilder(entryBlk);
    entryBuilder.CreateBr(loopBlk);

    IRBuilder<> loopBuilder(loopBlk);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, mkInt(1, 32));
    auto shouldLoop = loopBuilder.CreateICmpNE(nextInd, loopBound);
    auto readFromFifo = loopBuilder.CreateCall(readFifo, {getArg(f, 0)});
    storeRAMVal(loopBuilder, getArg(f, 1), indPhi, readFromFifo);

    indPhi->addIncoming(mkInt(0, 32), entryBlk);
    indPhi->addIncoming(nextInd, loopBlk);
    
    loopBuilder.CreateCondBr(shouldLoop, loopBlk, exitBlk);

    IRBuilder<> exitBuilder(exitBlk);
    exitBuilder.CreateRet(nullptr);
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;
    
    Function* ramRead = ramLoadFunction(getArg(f, 1));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(f, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));

    SECTION("No pipelining") {
      Schedule s = scheduleInterface(f, hcs, interfaces);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_1", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // Create testing infrastructure
      map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1, 2, 5, 9, 18}}};

      auto arg0 = dyn_cast<Argument>(getArg(f, 0));
      string in0Name = string(arg0->getName());
    
      TestBenchSpec tb;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 100;
      tb.name = "outer_loop_pipe";
      tb.useModSpecs = true;
      tb.settableWires.insert(in0Name + "_in_data");
      tb.settableWires.insert(in0Name + "_write_valid");

      int startSetMemCycle = 1;

      tb.setArgPort(arg0, "write_valid", 4, "1");
      tb.setArgPort(arg0, "in_data", 4, "1");
      //tb.setArgPort(arg0, "write_valid", 5, "0");

      tb.setArgPort(arg0, "write_valid", 5, "1");
      tb.setArgPort(arg0, "in_data", 5, "2");
      //tb.setArgPort(arg0, "write_valid", 6, "0");

      tb.setArgPort(arg0, "write_valid", 6, "1");
      tb.setArgPort(arg0, "in_data", 6, "5");
      tb.setArgPort(arg0, "write_valid", 7, "0");

      tb.setArgPort(arg0, "write_valid", 15, "1");
      tb.setArgPort(arg0, "in_data", 15, "9");
      tb.setArgPort(arg0, "write_valid", 16, "0");
 
      tb.setArgPort(arg0, "write_valid", 17, "1");
      tb.setArgPort(arg0, "in_data", 17, "18");
      tb.setArgPort(arg0, "write_valid", 18, "0");
   
    
      int startRunCycle = startSetMemCycle + 2; 
      map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      int checkMemCycle = 40;
      checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("outer_loop_pipe"));
    }

    SECTION("With pipelining") {

      ExecutionConstraints exec;
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      auto preds = buildControlPreds(f);

      set<PipelineSpec> toPipeline;
      PipelineSpec all{false, {}};
      for (auto& blk : f->getBasicBlockList()) {
        if (blk.getName() == "exit_block_il") {
          cout << "No branch sinking in exit block il" << endl;
          exec.addConstraint(instrEnd(blk.getTerminator()) == end(&blk));
        }
        
        if (&blk != &(f->getEntryBlock())) {
          if (!ReturnInst::classof(blk.getTerminator())) {
            all.blks.insert(&blk);

            cout << "Pipelining block " << endl;
            cout << valueString(&blk) << endl;
          }
        }
      }
      toPipeline.insert(all);

      SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<string, int> testLayout = {{"arg_1", 0}};
      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(graph, layout, hcs);

      VerilogDebugInfo info;
      addNoXChecks(arch, info);

      emitVerilog(arch, info);

      // Create testing infrastructure
      map<string, vector<int> > memoryInit{{"arg_0", {6}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1, 2, 5, 9, 18}}};

      auto arg0 = dyn_cast<Argument>(getArg(f, 0));
      string in0Name = string(arg0->getName());
    
      TestBenchSpec tb;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 100;
      tb.name = "outer_loop_pipe";
      tb.useModSpecs = true;
      tb.settableWires.insert(in0Name + "_in_data");
      tb.settableWires.insert(in0Name + "_write_valid");

      int startSetMemCycle = 1;

      tb.setArgPort(arg0, "write_valid", 4, "1");
      tb.setArgPort(arg0, "in_data", 4, "1");
      //tb.setArgPort(arg0, "write_valid", 5, "0");

      tb.setArgPort(arg0, "write_valid", 5, "1");
      tb.setArgPort(arg0, "in_data", 5, "2");
      //tb.setArgPort(arg0, "write_valid", 6, "0");

      tb.setArgPort(arg0, "write_valid", 6, "1");
      tb.setArgPort(arg0, "in_data", 6, "5");
      tb.setArgPort(arg0, "write_valid", 7, "0");

      tb.setArgPort(arg0, "write_valid", 15, "1");
      tb.setArgPort(arg0, "in_data", 15, "9");
      tb.setArgPort(arg0, "write_valid", 16, "0");
 
      tb.setArgPort(arg0, "write_valid", 17, "1");
      tb.setArgPort(arg0, "in_data", 17, "18");
      tb.setArgPort(arg0, "write_valid", 18, "0");
   
    
      int startRunCycle = startSetMemCycle + 2; 
      map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
      map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

      int checkMemCycle = 40;
      checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);
      map_insert(tb.actionsOnCycles, checkMemCycle, assertString("valid === 1"));

      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("outer_loop_pipe"));
    }

  }
  
  TEST_CASE("Block outside loop but in same state defines value used in loop") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("LLVM Merged loop", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto loopBlock = mkBB("loop_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> entryBuilder(entryBlock);
    auto ldA = loadRAMVal(entryBuilder, dyn_cast<Value>(getArg(f, 0)), zero);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto twoIndPhi = loopBuilder.CreateMul(mkInt(2, 32), indPhi);
    auto xPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto yPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    storeRAMVal(loopBuilder,
                getArg(f, 0),
                twoIndPhi,
                yPhi);

    storeRAMVal(loopBuilder,
                getArg(f, 0),
                loopBuilder.CreateAdd(twoIndPhi, mkInt(1, 32)),
                xPhi);
    
    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    xPhi->addIncoming(ldA, entryBlock);
    xPhi->addIncoming(indPhi, loopBlock);

    yPhi->addIncoming(indPhi, entryBlock);
    yPhi->addIncoming(ldA, loopBlock);
    
    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
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

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 10}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {0, 6, 6, 1}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "accum_loop";
    tb.useModSpecs = true;
    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 40;
    checkRAM(tb, checkMemCycle, "arg_0", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("accum_loop"));
  }
  
  TEST_CASE("1D stencil without shift register in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM 1D stencil", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "one_d_stencil", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    ConstantInt* loopBound = mkInt("6", 32);
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    builder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);

    auto indPhiP1 = loopBuilder.CreateAdd(indPhi, one);
    auto indPhiM1 = loopBuilder.CreateSub(indPhi, one);

    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(one, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    auto ai = loadRAMVal(loopBuilder, getArg(srUser, 0), indPhi);
    auto aip1 = loadRAMVal(loopBuilder, getArg(srUser, 0), indPhiP1);
    auto aim1 = loadRAMVal(loopBuilder, getArg(srUser, 0), indPhiM1);
    
    auto inputSum = loopBuilder.CreateAdd(aim1, loopBuilder.CreateAdd(ai, aip1), "stencil_accum");

    storeRAMVal(loopBuilder,
                getArg(srUser, 1),
                loopBuilder.CreateSub(indPhi, one),
                inputSum);

    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    InterfaceFunctions interfaces;
    Function* ramRead = ramLoadFunction(getArg(srUser, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(srUser, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));
    
    Schedule s = scheduleInterface(srUser, hcs, interfaces);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
    //map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 5, 1, 2, 9, 8, 4}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6 + 5 + 1, 5 + 1 + 2, 1 + 2 + 9, 2 + 9 + 8, 9 + 8 + 4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 40;
    tb.name = "one_d_stencil";
    emitVerilogTestBench(tb, arch, testLayout);
    tb.useModSpecs = true;
    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 50;
    checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("one_d_stencil"));
  }

  TEST_CASE("LLVM program that uses a register") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("program that uses a register", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "one_register", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);

    ConstantInt* zero = mkInt("0", 32);    

    IRBuilder<> builder(entryBlock);
    auto reg = builder.CreateAlloca(intType(32), nullptr, "dhsreg");
    auto ldA = loadRAMVal(builder, getArg(srUser, 0), zero);

    auto gpr = builder.CreateGEP(reg, zero);

    builder.CreateStore(ldA, gpr);
    
    auto v = builder.CreateLoad(gpr);
    storeRAMVal(builder, getArg(srUser, 1), zero, v);
    builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };
    InterfaceFunctions interfaces;
    Function* ramRead = ramLoadFunction(getArg(srUser, 0));
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(getArg(srUser, 1));
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));
    
    Schedule s = scheduleInterface(srUser, hcs, interfaces);
    
    // HardwareConstraints hcs = standardConstraints();
    // InterfaceFunctions interfaces;
    
    //hcs.memoryMapping = memoryOpLocations(srUser);
    //setAllAllocaMemTypes(hcs, srUser, registerSpec(32));

    // Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout; // = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6}}};

    TestBenchSpec tb;
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};    
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.name = "one_register";
    tb.useModSpecs = true;

    int startSetMemCycle = 1;
    setRAM(tb, 1, "arg_0", memoryInit, testLayout);

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 50;
    checkRAM(tb, checkMemCycle, "arg_1", memoryExpected, testLayout);

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("one_register"));
  }
  
  class ShiftRegister {
  public:
    int width;
    int depth;

    std::vector<llvm::Value*> registers;
    std::map<llvm::Value*, MemorySpec> regTypes;

    ShiftRegister(const int w, const int d) : width(w), depth(d) {}

    void init(IRBuilder<>& builder) {
      for (int i = 0; i < depth; i++) {
        auto reg = builder.CreateAlloca(intType(width), nullptr, "sr_" + to_string(i));
        registers.push_back(reg);
        regTypes[reg] = registerSpec(width);
      }

      assert(((int) registers.size()) == depth);
    }

    void shift(IRBuilder<>& builder) {
      for (int i = 0; i < depth - 1; i++) {
        auto ldVal = loadVal(builder,registers[i + 1], mkInt("0", 32));
        storeVal(builder, registers[i], mkInt("0", 32), ldVal);
      }
    }

  };

  TEST_CASE("Shifting a value through a shift register") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    cout << "1d stencil via shift register" << endl;
    
    auto mod =
      llvm::make_unique<Module>("shift registered LLVM 1D stencil", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "shift_register_1", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);

    ConstantInt* zero = mkInt("0", 32);    

    IRBuilder<> builder(entryBlock);

    ShiftRegister sr(32, 3);
    auto inVal = loadVal(builder, getArg(srUser, 0), zero);
    sr.init(builder);

    for (int i = 0; i < sr.depth; i++) {
      sr.shift(builder);
      storeVal(builder, sr.registers[sr.depth - 1], zero, inVal);
    }

    auto lastVal = loadVal(builder, sr.registers[0], zero);
    storeVal(builder,
             getArg(srUser, 1),
             zero,
             lastVal);

    builder.CreateRet(nullptr);
    
    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    addMemInfo(hcs, sr.regTypes);
    hcs.memoryMapping = memoryOpLocations(srUser);
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};

    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {19}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {19}}};
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};
    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.name = "shift_register_1";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("shift_register_1"));
  }

  TEST_CASE("Scheduling a basic block diamond") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("BB diamond", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);
    auto tBlock = mkBB("true_block", f);    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto condVal = builder.CreateTrunc(loadVal(builder, getArg(f, 0), zero),
                                       intType(1));
    builder.CreateCondBr(condVal, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    fBuilder.CreateBr(exitBlock);

    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateBr(exitBlock);


    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(32), 2);
    valPhi->addIncoming(one, tBlock);
    valPhi->addIncoming(zero, fBlock);

    storeVal(exitBuilder,
             getArg(f, 1),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};

    auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    SECTION("Taking true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond"));
    }

    SECTION("Taking false path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {0}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond"));
    }

  }

  TEST_CASE("Scheduling a basic block diamond with sub-diamond") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("BB diamond 2", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond_2", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);

    auto ffBlock = mkBB("false_false_block", f);
    auto ftBlock = mkBB("false_true_block", f);        
    auto tBlock = mkBB("true_block", f);    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    
    ConstantInt* two = mkInt("2", 32);    

    IRBuilder<> builder(entryBlock);
    auto condVal =
      builder.CreateTrunc(loadVal(builder, getArg(f, 0), zero), intType(1));
    builder.CreateCondBr(condVal, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    auto cond1Val =
      fBuilder.CreateTrunc(loadVal(fBuilder, getArg(f, 1), zero), intType(1));
    fBuilder.CreateCondBr(cond1Val, ftBlock, ffBlock);

    IRBuilder<> ffBuilder(ffBlock);
    ffBuilder.CreateBr(exitBlock);

    IRBuilder<> ftBuilder(ftBlock);
    ftBuilder.CreateBr(exitBlock);
    
    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateBr(exitBlock);


    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(32), 3);
    valPhi->addIncoming(one, tBlock);
    valPhi->addIncoming(zero, ffBlock);
    valPhi->addIncoming(two, ftBlock);
    
    storeVal(exitBuilder,
             getArg(f, 2),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}, {"arg_2", 15}};

    auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    SECTION("Taking false, true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}, {"arg_1", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_2", {2}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_2";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_2"));
    }

    SECTION("Taking false path") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}, {"arg_1", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_2", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_2";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_2"));
    }

  }

  TEST_CASE("Using 16 bit external memory instead of 32 bit external memory") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("16 bit mem test", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{Type::getInt16Ty(context)->getPointerTo(),
        Type::getInt16Ty(context)->getPointerTo()};
    Function *srUser = mkFunc(inputs, voidType(), "mem_16_test");    

    int ramWidth = 16;
    int ramDepth = 8;
    
    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* zero = mkInt("0", ramWidth);
    ConstantInt* five = mkInt("5", ramWidth);

    cout << "five bit width = " << getValueBitWidth(five) << endl;

    REQUIRE(getValueBitWidth(five) == ramWidth);
    
    IRBuilder<> builder(entryBlock);
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);
    auto plus = builder.CreateAdd(ldA, five);
    storeVal(builder, getArg(srUser, 1), zero, plus);
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    setMemSpec(getArg(srUser, 0), hcs, ramSpec(1, 3, 2, 1, ramWidth, ramDepth));
    setMemSpec(getArg(srUser, 1), hcs, ramSpec(1, 3, 2, 1, ramWidth, ramDepth));

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 1}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 1}};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    map<string, vector<int> > memoryInit{{"arg_0", {(1 << 16) - 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "mem_16_test";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_16_test"));
  }

  void resetOnCycle(const int rstCycle, TestBenchSpec& tb) {
    map_insert(tb.actionsInCycles, rstCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, rstCycle + 1, string("rst_reg = 0;"));
  }

  void addRAMFunctions(Value* ramArg,
                       HardwareConstraints& hcs,
                       InterfaceFunctions& interfaces) {

    hcs.typeSpecs[string("SRAM_32_16")] =
      [](StructType* tp) { return ramSpec(32, 16); };

    Function* ramRead = ramLoadFunction(ramArg);
    interfaces.addFunction(ramRead);
    implementRAMRead0(ramRead,
                      interfaces.getConstraints(ramRead));

    Function* ramWrite = ramStoreFunction(ramArg);
    interfaces.addFunction(ramWrite);
    implementRAMWrite0(ramWrite,
                       interfaces.getConstraints(ramWrite));
  }
  
  // Critical issue: How to add pipelining constraints
  // before scheduling so that the scheduler is aware of II
  // constraints?
  TEST_CASE("Pipeline with resource constraints") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with resource constraints", context);
    setGlobalLLVMModule(mod.get());

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo()};
    
    Function* f = mkFunc(inputs, "constrained_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      auto v = loadRAMVal(builder, getArg(f, 0), i);
      auto z = builder.CreateMul(v, v);
      auto r = builder.CreateMul(z, v);
      storeRAMVal(builder, getArg(f, 0), builder.CreateAdd(i, mkInt(5, 32)), r);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);
    InterfaceFunctions interfaces;    
    addRAMFunctions(getArg(f, 0), hcs, interfaces);
    
    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);
    Schedule s =
      scheduleInterface(f, hcs, interfaces, blocksToPipeline);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 4, 5, 2, 1, 6*6*6, 4*4*4, 5*5*5, 2*2*2, 1*1*1}}};

    TestBenchSpec tb;
    tb.maxCycles = 42;
    tb.useModSpecs = true;
    tb.name = "constrained_pipe";

    resetOnCycle(1, tb);

    setRAM(tb, 0, "arg_0", memoryInit, testLayout);
    checkRAM(tb, 20, "arg_0", memoryExpected, testLayout);
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("constrained_pipe"));
  }

  TEST_CASE("Pipeline that needs temporary storage") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with temp storage", context);
    setGlobalLLVMModule(mod.get());

    // std::vector<Type *> inputs{intType(32)->getPointerTo(),
    //     intType(32)->getPointerTo()};

    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo(),
        sramType(32, 16)->getPointerTo()};

    Function* f = mkFunc(inputs, "temp_storage_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      //auto v = loadVal(builder, getArg(f, 0), i);
      auto v = loadRAMVal(builder, getArg(f, 0), i);
      auto three = mkInt("3", 32);
      auto seven = mkInt("7", 32);      

      auto z = builder.CreateMul(v, three);
      auto r = builder.CreateMul(v, seven);
      auto c = builder.CreateAdd(z, r);

      //storeVal(builder, getArg(f, 1), i, c);
      storeRAMVal(builder, getArg(f, 1), i, c);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);
    InterfaceFunctions interfaces;    
    addRAMFunctions(getArg(f, 0), hcs, interfaces);
    addRAMFunctions(getArg(f, 1), hcs, interfaces);    

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    

    ExecutionConstraints exec;
    exec.toPipeline = {{true, {loopBlock}}};
    createMemoryConstraints(f, hcs, exec);

    //Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline, exec);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 0}};
    //map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    //map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    map<llvm::Value*, int> layout;
    //auto arch = buildMicroArchitecture(graph, layout);
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*3 + 6*7, 4*3 + 4*7, 5*3 + 5*7, 2*3 + 2*7, 1*3 + 1*7}}};

    TestBenchSpec tb;
    // tb.memoryInit = memoryInit;
    // tb.memoryExpected = memoryExpected;
    // tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.useModSpecs = true;
    tb.name = "temp_storage_pipe";

    resetOnCycle(1, tb);
    setRAM(tb, 0, "arg_0", memoryInit, testLayout);
    checkRAM(tb, 30, "arg_1", memoryExpected, testLayout);
    
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("temp_storage_pipe"));
  }

  TEST_CASE("Reading a stored value from outside a pipeline inside a pipeline") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with external read", context);
    setGlobalLLVMModule(mod.get());
    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "outer_read_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    IRBuilder<> entryBuilder(entryBlock);    
    auto q = loadVal(entryBuilder, getArg(f, 0), zero);
    auto bodyF = [f, q](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto three = mkInt("3", 32);
      auto seven = mkInt("7", 32);      

      auto z = builder.CreateMul(v, three);
      auto r = builder.CreateMul(v, seven);
      auto c = builder.CreateAdd(z, r);
      auto final = builder.CreateAdd(c, q);
      storeVal(builder, getArg(f, 1), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*3 + 6*7 + 6, 4*3 + 4*7 + 6, 5*3 + 5*7 + 6, 2*3 + 2*7 + 6, 1*3 + 1*7 + 6}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "outer_read_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("outer_read_pipe"));
  }

  TEST_CASE("Loop pipeline II increased by memory dependence") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with memory dependence", context);
    setGlobalLLVMModule(mod.get());
    //std::vector<Type *> inputs{intType(32)->getPointerTo()};
    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    auto loopBlock = mkBB("loop_block", f);            

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* one = mkInt("1", 32);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    //auto bodyF = [f, one](IRBuilder<>& builder, Value* i) {
    auto i = loopBuilder.CreatePHI(intType(32), 2);
    auto ind = loopBuilder.CreateSub(i, one);
    auto nextInd = loopBuilder.CreateAdd(i, one);
      
    auto v = loadRAMVal(loopBuilder, getArg(f, 0), ind);
    auto final = loopBuilder.CreateAdd(v, one);

    storeRAMVal(loopBuilder, getArg(f, 0), i, final);

    auto shouldExit = loopBuilder.CreateICmpEQ(nextInd, loopBound);
    loopBuilder.CreateCondBr(shouldExit, exitBlock, loopBlock);

    i->addIncoming(one, entryBlock);
    i->addIncoming(nextInd, loopBlock);    
    // };
    // auto loopBlock = sivLoop(f, entryBlock, exitBlock, one, loopBound, bodyF);



    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);
    InterfaceFunctions interfaces;
    addRAMFunctions(getArg(f, 0), hcs, interfaces);
    
    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);

    ExecutionConstraints exec;
    exec.toPipeline = {{true, {loopBlock}}};
    createMemoryConstraints(f, hcs, exec);

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline, exec);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() > 1);
    
    map<string, int> testLayout = {{"arg_0", 0}};
    //map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    //printAllInstructions(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 6 + 1, 6 + 2, 6 + 3, 6 + 4}}};

    TestBenchSpec tb;
    tb.maxCycles = 42;
    tb.name = "mem_dep_pipe";
    tb.useModSpecs = true;

    resetOnCycle(1, tb);
    setRAM(tb, 0, "arg_0", memoryInit, testLayout);
    checkRAM(tb, 30, "arg_0", memoryExpected, testLayout);
    
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe"));
  }

  TEST_CASE("Loop pipeline II == 1 with long memory dependence") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with long memory dependence", context);
    setGlobalLLVMModule(mod.get());
    //std::vector<Type *> inputs{intType(32)->getPointerTo()};
    std::vector<Type *> inputs{sramType(32, 16)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe_long", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* loopBound = mkInt("10", 32);
    ConstantInt* one = mkInt("1", 32);
    ConstantInt* three = mkInt("3", 32);
    IRBuilder<> entryBuilder(entryBlock);    
    auto bodyF = [f, one, three](IRBuilder<>& builder, Value* i) {
      auto ind = builder.CreateSub(i, three);
      
      //auto v = loadVal(builder, getArg(f, 0), ind);
      auto v = loadRAMVal(builder, getArg(f, 0), ind);
      auto final = builder.CreateAdd(v, one);

      //storeVal(builder, getArg(f, 0), i, final);
      storeRAMVal(builder, getArg(f, 0), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, three, loopBound, bodyF);

    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);
    InterfaceFunctions interfaces;
    addRAMFunctions(getArg(f, 0), hcs, interfaces);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    

    ExecutionConstraints exec;
    exec.toPipeline = {{true, {loopBlock}}};
    createMemoryConstraints(f, hcs, exec);

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline, exec);    
    //Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    //REQUIRE(graph.pipelines[0].II() == 2);
    REQUIRE(graph.pipelines[0].II() > 1);
    
    map<string, int> testLayout = {{"arg_0", 0}};
    //map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1, 8, 0, 2, 9, 6}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 4, 5, 6 + 1, 4 + 1, 5 + 1, 7 + 1, 5 + 1, 5 + 2, 7 + 2}}};

    TestBenchSpec tb;
    tb.maxCycles = 50;
    tb.useModSpecs = true;
    tb.name = "mem_dep_pipe_long";

    resetOnCycle(1, tb);
    setRAM(tb, 0, "arg_0", memoryInit, testLayout);
    checkRAM(tb, 30, "arg_0", memoryExpected, testLayout);
    
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe_long"));
  }

  TEST_CASE("Builtin FIFO as argument to function") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use", context);
    setGlobalLLVMModule(mod.get());
    
    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    InterfaceFunctions interfaces;
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    vector<Type*> writeArgs = {tp->getPointerTo(), intType(32)};
    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_user", mod.get());
    auto blk = mkBB("entry_block", f);
    
    IRBuilder<> builder(blk);
    auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
    auto writeVal = builder.CreateCall(writeFifo, {val, getArg(f, 1)});
    builder.CreateRet(nullptr);

    ExecutionConstraints exec;
    exec.addConstraint(instrEnd(val) < instrStart(writeVal));
    
    inlineWireCalls(f, exec, interfaces);

    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    REQUIRE(runIVerilogTB("fifo_user"));
  }

  TEST_CASE("Delay between reading from FIFO and using the result") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_read_delay", mod.get());
    auto blk = mkBB("entry_block", f);
    
    IRBuilder<> builder(blk);
    auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
    auto p0 = builder.CreateAdd(mkInt(2, width), val);
    auto prod = builder.CreateAdd(p0, val);
    builder.CreateCall(writeFifo, {prod, getArg(f, 1)});
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };
    
    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    
    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    REQUIRE(runIVerilogTB("fifo_read_delay"));
  }

  TEST_CASE("2 x 2 systolic array with FIFOs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);
    setGlobalLLVMModule(mod.get());

    InterfaceFunctions interfaces;
    StructType* tp = fifoType(width);
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    cout << "Read fifo func" << endl;
    cout << valueString(readFifo) << endl;

    Function* writeFifo = fifoWrite(width, mod.get());
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

    cout << "Write fifo func" << endl;
    cout << valueString(writeFifo) << endl;

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "sys_array_2x2", mod.get());

    auto blk = mkBB("entry_block", f);

    IRBuilder<> b(blk);
    
    auto aRow0 = getArg(f, 0);
    auto aRow1 = getArg(f, 1);
    vector<llvm::Value*> aRows{aRow0, aRow1};

    auto bCol0 = getArg(f, 2);
    auto bCol1 = getArg(f, 3);
    vector<llvm::Value*> bCols{bCol0, bCol1};    

    auto cRow0 = getArg(f, 4);
    auto cRow1 = getArg(f, 5);
    vector<llvm::Value*> cCols{cRow0, cRow1};
    
    vector<Value*> rightRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        b.CreateAlloca(intType(width), nullptr, "right_" + to_string(i));
      storeReg(b, reg, mkInt(0, width));
      rightRegisters.push_back(reg);
    }

    vector<Value*> downRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        b.CreateAlloca(intType(width), nullptr, "down_" + to_string(i));
      storeReg(b, reg, mkInt(0, width));
      downRegisters.push_back(reg);
    }
    
    vector<Value*> accumRegisters;
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        auto reg =
          b.CreateAlloca(intType(width), nullptr, "accum_" + to_string(i) + "_" + to_string(j));
        storeReg(b, reg, mkInt(0, width));
        accumRegisters.push_back(reg);
      }
    }

    for (int i = 0; i < 4; i++) {
      cout << "i = " << i << endl;
      
      vector<Value*> aRowVals;
      for (int i = 0; i < 2; i++) {
        aRowVals.push_back(b.CreateCall(readFifo, aRows[i]));
      }

      vector<Value*> bColVals;
      for (int i = 0; i < 2; i++) {
        bColVals.push_back(b.CreateCall(readFifo, bCols[i]));
      }

      for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 2; col++) {
          Value* aVal = nullptr;

          if (col == 0) {
            aVal = aRowVals[row];
          } else {
            aVal = loadReg(b, rightRegisters[row]);
          }

          Value* bVal = nullptr;
          if (row == 0) {
            bVal = bColVals[col];
          } else {
            bVal = loadReg(b, downRegisters[col]);
          }
          
          auto accumReg = accumRegisters[2*row + col];
          auto newAccum =
            b.CreateAdd(loadReg(b, accumReg), b.CreateMul(aVal, bVal));

          storeReg(b, accumReg, newAccum);

        }
      }

      // Update register values
      for (int col = 0; col < 2; col++) {
        storeReg(b, downRegisters[col], bColVals[col]);
      }

      for (int row = 0; row < 2; row++) {
        storeReg(b, rightRegisters[row], aRowVals[row]);
      }
      
    }

    // Store out final results
    for (int j = 0; j < 2; j++) {
      auto cCol = cCols[j];
      for (int i = 0; i < 2; i++) {
        b.CreateCall(writeFifo, {loadReg(b, accumRegisters[2*i + j]), cCol});
      }
    }

    b.CreateRet(nullptr);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };
    
    // More constraints
    
    // HardwareConstraints hcs = standardConstraints();

    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);

    // cout << "Memory mapping" << endl;
    // for (auto mm : hcs.memoryMapping) {
    //   cout << "\t" << valueString(mm.first) << " -> " << valueString(mm.second) << endl;
    // }
    setAllAllocaMemTypes(hcs, f, registerSpec(width));

    hcs.setCount(MUL_OP, 4);

    // set<BasicBlock*> toPipeline;
    // SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    // exec.addConstraints(p, f);
    // p.setObjective(p.blockEnd(blk) - p.blockStart(blk));
    // // Add gep restriction
    // for (auto& bb : f->getBasicBlockList()) {
    //   for (auto& instrR : bb) {
    //     auto instr = &instrR;
    //     int numUsers = instr->getNumUses();

    //     if (!BinaryOperator::classof(instr) && (numUsers == 1)) {
    //       auto& user = *(instr->uses().begin());
    //       assert(Instruction::classof(user));
    //       auto userInstr = dyn_cast<Instruction>(user.getUser());
    //       p.addConstraint(p.instrEnd(instr) == p.instrStart(userInstr));
    //     }
    //   }
    // }
    // map<Function*, SchedulingProblem> constraints{{f, p}};
    // Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    // STG graph = buildSTG(s, f);

    // cout << "STG Is" << endl;
    // graph.print(cout);

    // //REQUIRE(graph.numControlStates() == 8);

    // for (auto& st : graph.opStates) {
    //   int numReads = 0;
    //   int numWrites = 0;
    //   int numMuls = 0;
    //   int numAdds = 0;
    //   int numLoads = 0;
    //   int numStores = 0;

    //   for (auto instrG : graph.instructionsStartingAt(st.first)) {
    //     Instruction* instr = instrG;
    //     if (isBuiltinFifoRead(instr)) {
    //       numReads++;
    //     }

    //     if (isBuiltinFifoWrite(instr)) {
    //       numWrites++;
    //     }

    //     if (instr->getOpcode() == Instruction::Mul) {
    //       numMuls++;
    //     }

    //     if (instr->getOpcode() == Instruction::Add) {
    //       numAdds++;
    //     }

    //     if (LoadInst::classof(instr)) {
    //       numLoads++;
    //     }

    //     if (StoreInst::classof(instr)) {
    //       numStores++;
    //     }
        
    //   }

    //   // Looks like a register cannot be loaded from and stored to
    //   // 
    //   cout << "At state " << st.first << endl;
    //   cout << tab(1) << " numReads     == " << numReads << endl;
    //   cout << tab(1) << " numWrites    == " << numWrites << endl;
    //   cout << tab(1) << " numMuls      == " << numMuls << endl;
    //   cout << tab(1) << " numAdds      == " << numAdds << endl;
    //   cout << tab(1) << " numLoads     == " << numLoads << endl;
    //   cout << tab(1) << " numStores    == " << numStores << endl;

    //   bool res = (numReads == 0) || (numReads == 4);
    //   REQUIRE(res);
    // }

    // map<Value*, int> layout;
    // // ArchOptions options;
    // auto arch = buildMicroArchitecture(graph,
    //                                    layout,
    //                                    hcs);

    // VerilogDebugInfo info;
    // addNoXChecks(arch, info);
    // info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    // info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    // emitVerilog(arch, info);

    // REQUIRE(runIVerilogTB("sys_array_2x2"));
  }

  TEST_CASE("Phi node with 4 inputs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;

    auto mod = llvm::make_unique<Module>("BB diamond 4", context);
    setGlobalLLVMModule(mod.get());
    
    std::vector<Type *> inputs{intType(width)->getPointerTo(),
        intType(width)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond_4", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);
    auto tBlock = mkBB("true_block", f);
    
    auto ffBlock = mkBB("false_false_block", f);
    auto ftBlock = mkBB("false_true_block", f);        

    auto tfBlock = mkBB("true_false_block", f);
    auto ttBlock = mkBB("true_true_block", f);
    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", width);
    ConstantInt* one = mkInt("1", width);
    ConstantInt* two = mkInt("2", width);    
    ConstantInt* three = mkInt("3", width);    

    IRBuilder<> builder(entryBlock);
    auto condVal = loadVal(builder, getArg(f, 0), zero);
    auto lt2 = builder.CreateICmpULT(condVal, two);
    auto lt1 = builder.CreateICmpULT(condVal, one);
    auto lt3 = builder.CreateICmpULT(condVal, three);
    builder.CreateCondBr(lt2, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    fBuilder.CreateCondBr(lt3, ftBlock, ffBlock);

    IRBuilder<> ffBuilder(ffBlock);
    ffBuilder.CreateBr(exitBlock);

    IRBuilder<> ftBuilder(ftBlock);
    ftBuilder.CreateBr(exitBlock);
    
    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateCondBr(lt1, ttBlock, tfBlock);

    IRBuilder<> tfBuilder(tfBlock);
    tfBuilder.CreateBr(exitBlock);

    IRBuilder<> ttBuilder(ttBlock);
    ttBuilder.CreateBr(exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(width), 3);
    valPhi->addIncoming(three, ffBlock);
    valPhi->addIncoming(two, ftBlock);
    valPhi->addIncoming(one, tfBlock);
    valPhi->addIncoming(zero, ttBlock);    
    
    storeVal(exitBuilder,
             getArg(f, 1),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};

    auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    SECTION("Taking true, true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {0}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking true, false") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking false, true") {
      map<string, vector<int> > memoryInit{{"arg_0", {2}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {2}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking false, false") {
      map<string, vector<int> > memoryInit{{"arg_0", {3}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {3}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }
    
  }

  TEST_CASE("Running verilog fifo tests") {

    string mainName = "fifo.v";
    string exeName = "fifo";
    REQUIRE(runIVerilogTest(mainName, exeName));

    string mName = "fifo_3.v";
    string eName = "fifo_3";
    REQUIRE(runIVerilogTest(mName, eName));
    
  }

  TEST_CASE("Reading and writing FIFOs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use in a loop", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_in_loop", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* three = mkInt("3", width);
    ConstantInt* zero = mkInt("0", width);

    auto bodyF = [f, readFifo, writeFifo, width](IRBuilder<>& builder, Value* i) {
      auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
      auto p0 = builder.CreateAdd(mkInt(2, width), val);
      auto sum = builder.CreateAdd(p0, val);
      builder.CreateCall(writeFifo, {sum, getArg(f, 1)});
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, three, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);
    
    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);
    
    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;
    
    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    REQUIRE(runIVerilogTB("fifo_in_loop"));
  }

  TEST_CASE("Reduce loop") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadModule(context, err, "add_reduce_15");
    setGlobalLLVMModule(mod.get());
    
    Function* f = mod->getFunction("add_reduce_15");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"in", 0}, {"out", 17}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 17}};
    auto arch = buildMicroArchitecture(graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"in", {4, 8, 6, 12, 3, 1, 3, 1, 5, 2, 5, 2, 5, 2, 7}}};
    map<string, vector<int> > memoryExpected{{"out", {4 + 8 + 6 + 12 + 3 + 1 + 3 + 1 + 5 + 2 + 5 + 2 + 5 + 2 + 7}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.maxCycles = 200;
    tb.name = "add_reduce_15";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("add_reduce_15"));
  }

  TEST_CASE("Timed wire reduction") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("Add-reduce with timed wires", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_reduce", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in = getArg(f, 0);
    Value* val = mkInt(0, width);
    for (int i = 0; i < 4; i++) {
      auto nextVal = b.CreateCall(readFifo, {in});
      val = b.CreateAdd(val, nextVal);
    }

    auto out = getArg(f, 1);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(readFifo) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return wireSpec(width); };

    // TODO: Add relative timing constraints on wires
    
    hcs.setCount(ADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    s.setDefaultReturnState(0);
    
    // auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
    //   map_insert(stg.opTransitions, st, {0, cond});
    // };
    
    // std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f); // , returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph,
                                       layout,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(arch, info);

    REQUIRE(runIVerilogTB("timed_wire_reduce"));
  }

  TEST_CASE("One floating point add") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("One float add", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);

    InterfaceFunctions interfaces;    
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_fp_add", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in0 = getArg(f, 0);
    auto in1 = getArg(f, 1);
    auto a = b.CreateCall(readFifo, {in0});
    auto b0 = b.CreateCall(readFifo, {in1});
    auto val = b.CreateFAdd(a, b0);
    auto out = getArg(f, 2);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };

    // TODO: Set latency of fadd to 15?
    hcs.setCount(FADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    s.setDefaultReturnState(0);

    // auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
    //   map_insert(stg.opTransitions, st, {0, cond});
    // };
    
    // std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f); //, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph,
                                       layout,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(arch, info);

    float af = 3.0;
    float bf = 4.0;
    float cf = af + bf;

    cout << "Sum bits = " << floatBits(cf) << endl;
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "timed_wire_fp_add";
    tb.settableWires.insert("arg_0_out_data");
    tb.settableWires.insert("arg_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 21, assertString("arg_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 21, string("$display(\"arg_2_in_data = %d\", arg_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_fp_add"));
  }
  
  TEST_CASE("Floating point reduce with timed wires") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("floating point reduce with timed wires", context);
    setGlobalLLVMModule(mod.get());    

    StructType* tp = fifoType(width);
    vector<Type*> readArgs = {tp->getPointerTo()};

    InterfaceFunctions interfaces;        
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_reduce_fp", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in = getArg(f, 0);
    Value* val = mkFloat(0);
    for (int i = 0; i < 4; i++) {
      auto nextVal = b.CreateCall(readFifo, {in});
      val = b.CreateFAdd(val, nextVal);
    }

    auto out = getArg(f, 1);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };
    
    hcs.setCount(FADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    // TODO: Fix the fadd instantiation problem: 2 fadds but scheduled like
    // there is only 1?
    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    s.setDefaultReturnState(0);

    // auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
    //   map_insert(stg.opTransitions, st, {0, cond});
    // };
    
    // std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f); //, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph,
                                       layout,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(arch, info);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 10;
    tb.maxCycles = 100;
    tb.name = "timed_wire_reduce_fp";
    tb.settableWires.insert("arg_0_out_data");
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 81, assertString("arg_1_in_data === (1 + 2 + 3 + 4)"));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = 1;"));
    map_insert(tb.actionsInCycles, 2, string("arg_0_out_data_reg = 2;"));
    map_insert(tb.actionsInCycles, 3, string("arg_0_out_data_reg = 3;"));    
    map_insert(tb.actionsInCycles, 4, string("arg_0_out_data_reg = 4;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_reduce_fp"));
  }

  // Some problems with this prototype:
  // 2. Writing out constraints like these is tedious and error prone
  // 3. I want to be able to express loop related constraints as well
  //    (constraints on execution order of instances of an action)
  // 5. Eventually I want a constraint API that is good enough to write a paper
  //    about. Ideally using C/C++ as a frontend
  // 6. Not only is writing these constraints tedious, writing LLVM code for
  //    reads and writes to ports is also tedious. Id like to encapsulate
  //    these reads and writes and the accompanying scheduling constraints
  //    in a data structure.
  TEST_CASE("One floating point add via readport and writeport") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("One float add via port API", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);
    
    vector<Type*> readArgs = {tp->getPointerTo()};

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width, mod.get());
    interfaces.addFunction(readFifo);
    implementWireRead(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    interfaces.addFunction(writeFifo);
    implementWireWrite(writeFifo);

    auto fpuType =
      llvm::StructType::create(getGlobalLLVMContext(),
                               "builtin_fadd");
    
    Function* fadd =
      mkFunc({fpuType, intType(width), intType(width)}, intType(width), "jd_fadd");
    interfaces.addFunction(fadd);
    {
      ExecutionConstraints& exec = interfaces.getConstraints(fadd);
      auto entryBlock = mkBB("entry_block", fadd);
      IRBuilder<> b(entryBlock);
      auto f = fadd;

      auto fpu = getArg(f, 0);
      auto a = getArg(f, 1);
      auto b0 = getArg(f, 2);

      // Interface with floating point adder
      auto writeRst = writePort("rst", 1, fpuType);
      auto writeA = writePort("input_a", 32, fpuType);
      auto writeAStb = writePort("input_a_stb", 1, fpuType);

      auto writeB = writePort("input_b", 32, fpuType);
      auto writeBStb = writePort("input_b_stb", 1, fpuType);
      auto stall = stallFunction();

      auto readAAck = readPort("input_a_ack", 1, fpuType);
      auto readBAck = readPort("input_b_ack", 1, fpuType);
      auto readZStb = readPort("output_z_stb", 1, fpuType);

      auto rst0 = b.CreateCall(writeRst, {fpu, mkInt(1, 1)});
      // Wait until next cycle
      auto rst1 = b.CreateCall(writeRst, {fpu, mkInt(0, 1)});

      exec.add(instrEnd(rst0) < instrStart(rst1));
      //exec.endsBeforeStarts(rst0, rst1);

      auto wA = b.CreateCall(writeA, {fpu, a});
      auto wAStb = b.CreateCall(writeAStb, {fpu, mkInt(1, 1)});

      exec.add(instrEnd(rst1) < instrStart(wA));
      //exec.startSameTime(rst1, wA);    
      //exec.startSameTime(wA, wAStb);
      exec.add(instrStart(wA) == instrStart(wAStb));

      // Wait for input_a_ack == 1, and then wait 1 more cycle
      auto aAck = b.CreateCall(readAAck, {fpu});
      auto stallUntilAAck = b.CreateCall(stall, {aAck});

      auto wAStb0 = b.CreateCall(writeAStb, {fpu, mkInt(0, 1)});
      auto wB = b.CreateCall(writeB, {fpu, b0});
      auto wBStb = b.CreateCall(writeBStb, {fpu, mkInt(1, 1)});

      auto bAck = b.CreateCall(readBAck, {fpu});
      auto stallUntilBAck = b.CreateCall(stall, {bAck});
    
      // Wait one or two cycles?
      auto wBStb0 = b.CreateCall(writeBStb, {fpu, mkInt(0, 1)});

      // Wait at least one cycle after input_b_stb == 1, for output_z_stb == 1
      auto zStb = b.CreateCall(readZStb, {fpu});
      auto stallUntilZStb = b.CreateCall(stall, {zStb});
      auto val = b.CreateCall(readPort("output_z", 32, fpuType), {fpu});

      b.CreateRet(val);
      
      // A / B stall
      exec.addConstraint(instrStart(aAck) == instrEnd(wAStb));
      //exec.startsBeforeStarts(aAck, wAStb0);
      exec.add(instrStart(aAck) < instrStart(wAStb0));
      exec.addConstraint(instrStart(stallUntilAAck) == instrEnd(aAck));

      
      //exec.startSameTime(wA, wAStb);
      exec.add(instrStart(wA) == instrStart(wAStb));

      exec.addConstraint(instrStart(bAck) == instrEnd(wBStb));
      //exec.endsBeforeStarts(bAck, wBStb0);
      exec.add(instrEnd(bAck) < instrStart(wBStb0));

      exec.addConstraint(instrStart(stallUntilBAck) == instrEnd(bAck));
      //exec.startSameTime(wB, wBStb);
      exec.add(instrStart(wB) == instrStart(wBStb));    

      // Wait for A to be written before writing b
      exec.addConstraint(instrEnd(aAck) < instrStart(wB));

      // Wait for b to be acknowledged before reading Z
      exec.addConstraint(instrEnd(bAck) < instrStart(val));

      //exec.startSameTime(val, zStb);
      exec.add(instrStart(val) == instrStart(zStb));

      //exec.startSameTime(stallUntilZStb, zStb);
      exec.add(instrStart(stallUntilZStb) == instrStart(zStb));
      addDataConstraints(fadd, exec);
    }

    ExecutionConstraints exeConstraints;
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "direct_port_fp_add", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto fpu = b.CreateAlloca(fpuType, nullptr, "fpu_0");
    
    auto in0 = getArg(f, 0);
    auto in1 = getArg(f, 1);

    auto a0 = b.CreateCall(readFifo, {in0});
    auto b0 = b.CreateCall(readFifo, {in1});
    auto val = b.CreateCall(fadd, {fpu, a0, b0});
    auto out = getArg(f, 2);

    auto writeZ = b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    map<string, Port> adderPorts = {
      {"input_a", inputPort(width, "input_a")},
      {"input_a_stb", inputPort(1, "input_a_stb")},
      {"input_b", inputPort(width, "input_b")},
      {"input_b_stb", inputPort(1, "input_b_stb")},
      {"rst", inputPort(1, "rst")},

      {"output_z", outputPort(width, "output_z")},
      {"input_a_ack", outputPort(1, "input_a_ack")},
      {"input_b_ack", outputPort(1, "input_b_ack")},
      {"output_z_stb", outputPort(1, "output_z_stb")}
    };

    map<string, int> defaults = {
      {"input_a", 0},
      {"input_a_stb", 0},
      {"input_b", 0},
      {"input_b_stb", 0},
      {"rst", 0}
    };

    set<string> insensitivePorts{"input_a", "input_b"};
    hcs.typeSpecs[fpuType->getName()] =
      [adderPorts, defaults, insensitivePorts](StructType* fp) { return ModuleSpec({}, "adder", adderPorts, defaults, insensitivePorts); };
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };
    
    exeConstraints.addConstraint(instrEnd(val) < instrStart(writeZ));

    inlineWireCalls(f, exeConstraints, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;
    
    // Note: It is also a pain that I cannot run-the getOrAddFunction
    // method of llvm::Module and get back a function each time. Being able
    // to do that would be awesome.

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    exeConstraints.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    s.setDefaultReturnState(0);
    // auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
    //   map_insert(stg.opTransitions, st, {0, cond});
    // };
    
    // std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f); //, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    //emitVerilatorBinding(graph);
    
    map<Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph,
                                       layout,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(arch, info);

    float af = 3.0;
    float bf = 4.0;
    float cf = af + bf;

    cout << "Sum bits = " << floatBits(cf) << endl;
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "direct_port_fp_add";
    tb.settableWires.insert("arg_0_out_data");
    tb.settableWires.insert("arg_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 18, assertString("arg_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 8, string("$display(\"arg_2_in_data = %d\", arg_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("direct_port_fp_add"));
  }
  
  TEST_CASE("Creating memory interface functions") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("dynamic arch", context);
    setGlobalLLVMModule(mod.get());

    int width = 32;
    int depth = 128;
    int addrWidth = clog2(depth);
    StructType* sramTp = sramType(width, depth);
    
    std::vector<Type *> inputs{sramTp->getPointerTo()};

    InterfaceFunctions interfaces;
    Function* ramRead0 =
      mkFunc({sramTp, intType(addrWidth)}, intType(width), "read0");
    interfaces.addFunction(ramRead0);
    implementRAMRead0(ramRead0, interfaces.getConstraints(ramRead0));

    Function* ramWrite0 = mkFunc({sramTp, intType(addrWidth), intType(width)}, voidType(), "write0");
    interfaces.addFunction(ramWrite0);
    implementRAMWrite0(ramWrite0, interfaces.getConstraints(ramWrite0));
  

    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "dynamic_arch_sram_class", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* five = mkInt("5", width);
    ConstantInt* zero = mkInt("0", addrWidth);    

    IRBuilder<> builder(entryBlock);
    auto ldA = builder.CreateCall(ramRead0, {getArg(srUser, 0), zero});
    auto plus = builder.CreateAdd(ldA, five);
    auto st = builder.CreateCall(ramWrite0, {getArg(srUser, 0), zero, plus});
    auto ret = builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    ExecutionConstraints exec;

    // Control time dependencies
    exec.add(instrStart(ldA) + 1 == instrEnd(ldA));
    exec.add(instrStart(plus) == instrEnd(plus));
    exec.add(instrStart(st) + 3 == instrEnd(st));
    exec.add(instrStart(ret) == instrEnd(ret));

    inlineWireCalls(srUser, exec, interfaces);
    addDataConstraints(srUser, exec);

    cout << "LLVM Function after inlining" << endl;
    cout << valueString(srUser) << endl;

    // cout << "Constraints after inlining" << endl;
    // for (auto c : exec.constraints) {
    //   cout << tab(1) << *c << endl;
    // }

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[sramTp->getName()] =
      [width, depth](StructType* tp) { return ramSpec(width, depth); };

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(srUser, hcs, toPipeline);
    exec.addConstraints(p, srUser);

    map<Function*, SchedulingProblem> constraints{{srUser, p}};
    Schedule s = scheduleFunction(srUser, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.opStates.size() == 5);

    map<Value*, int> layout;
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph,
                                       layout,
                                       hcs);

    VerilogDebugInfo info;
    // addNoXChecks(arch, info);
    emitVerilog(arch, info);
    
    REQUIRE(runIVerilogTB("dynamic_arch_sram_class"));
  }

  TEST_CASE("Reduce 4 with FIFOs") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadModule(context, err, "reduce_4");
    setGlobalLLVMModule(mod.get());

    int width = 32;

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

    auto f = mod->getFunction("reduce_4");

    HardwareConstraints hcs = standardConstraints();
    // NOTE: Its a little annoying to have to put module specifications
    // in to the hardware constraints in one place, and then put
    // the interface function definition in another place.

    hcs.typeSpecs["struct.builtin_fifo_32"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
    
    auto arch = synthesizeVerilog(f, interfaces, hcs);

    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 40;
    tb.maxCycles = 50;
    tb.name = "reduce_4";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    int checkValidCycle = 35;
    map_insert(tb.actionsOnCycles, checkValidCycle, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, checkValidCycle + 1, assertString(outName + "_out_data === 1 + 4 + 7 + 9"));
    //to_string(1 + 3 + 5 + 19)));
    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 1, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 1, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 2, string(in0Name + "_in_data = 4;"));
    map_insert(tb.actionsInCycles, 2, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 5, string(in0Name + "_in_data = 7;"));
    map_insert(tb.actionsInCycles, 5, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 6, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 9, string(in0Name + "_in_data = 9;"));
    map_insert(tb.actionsInCycles, 9, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 10, string(in0Name + "_write_valid = 0;")); 

    map_insert(tb.actionsInCycles, checkValidCycle, string(outName + "_read_valid = 1;"));    
    map_insert(tb.actionsInCycles, checkValidCycle + 1, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("reduce_4"));
  }
  
  TEST_CASE("Templatized FIFO") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "add_10_template");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "add_10_template");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteTemplate;

    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.ahaHLS::Fifo"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    

    addDataConstraints(f, exec);

    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("add_10_template", arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "add_10_template";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 1 + 10"));

    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));    

    map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("add_10_template"));
  }


  // Now I can make channels work with a pass-by-value write. Could
  // I do it with pass-by-reference write? What would that even mean?

  // I suppose it would mean that I was creating a register that contained
  // an integer and connecting the output of the register to the data input
  // of the underlying FIFO?

  // Idea: Use some sort of register elimination optimization after inlining
  // and scheduling to turn this in to a pass-by-value operation?

  // Note: I really need to convert the old c examples using pointers as arbitrary
  // width memories into examples that use SRAMs. Then I can re-purpose pointers
  // to a built-in type to mean "registers of that type". Note also: Distinction
  // between a types width (the sum of the widths of all of its state), and the
  // types hardware interface.
  TEST_CASE("Templatized channel") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "add_10_channel");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "add_10_channel");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;

    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    // Set registers
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
    addDataConstraints(f, exec);

    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("add_10_channel", arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "add_10_channel";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 1 + 10"));

    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));    

    map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("add_10_channel"));
  }

  TEST_CASE("Templatized channel add") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "channel_add");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "channel_add");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;

    //addDataConstraints(f, exec);

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    inlineWireCalls(f, exec, interfaces);

    addDataConstraints(f, exec);    
    
    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("channel_add", arch, info);

    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string in1Name =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();
    
    string outName =
      getArg(f, 2)->getName() == "" ? "arg_2" : getArg(f, 2)->getName();

    auto in0 = dyn_cast<Argument>(getArg(f, 0));
    auto in1 = dyn_cast<Argument>(getArg(f, 1));
    auto out = dyn_cast<Argument>(getArg(f, 2));
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "channel_add";
    tb.useModSpecs = true;
    tb.settablePort(in0, "in_data");
    tb.settablePort(in0, "write_valid");    
    tb.settablePort(in1, "in_data");
    tb.settablePort(in1, "write_valid");    
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 2 + 14"));
    
    SECTION("Writing to both inputs in the same cycle") {

      tb.setArgPort(in0, "write_valid", 0, "0");
      tb.setArgPort(in1, "write_valid", 0, "0");

      tb.setArgPort(in0, "in_data", 3, "2");
      tb.setArgPort(in0, "write_valid", 3, "1");      

      tb.setArgPort(in1, "in_data", 3, "14");
      tb.setArgPort(in1, "write_valid", 3, "1");

      tb.setArgPort(in0, "write_valid", 4, 0);
      tb.setArgPort(in1, "write_valid", 4, 0);      

      tb.setArgPort(in1, "write_valid", 8, 0);

      tb.setArgPort(out, "read_valid", 20, 1);
      tb.setArgPort(out, "read_valid", 21, 0);

      emitVerilogTestBench(tb, arch, testLayout);
    
      REQUIRE(runIVerilogTB("channel_add"));
    }

    SECTION("Waiting between writes to in0 and in1") {
      
      map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
      map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));
      map_insert(tb.actionsInCycles, 0, string(in1Name + "_write_valid = 0;"));

      map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 2;"));
      map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

      map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));

      map_insert(tb.actionsInCycles, 7, string(in1Name + "_in_data = 14;"));
      map_insert(tb.actionsInCycles, 7, string(in1Name + "_write_valid = 1;"));

      map_insert(tb.actionsInCycles, 8, string(in1Name + "_write_valid = 0;"));
    
      map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));
      map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

      emitVerilogTestBench(tb, arch, testLayout);
    
      REQUIRE(runIVerilogTB("channel_add"));

    }
  }

  TEST_CASE("Reduce 4 channels") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "channel_reduce_4");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "channel_reduce_4");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;



    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    //addDataConstraints(f, exec);    
    inlineWireCalls(f, exec, interfaces);

    addDataConstraints(f, exec);    
    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };

    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog("channel_reduce_4", arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 40;
    tb.maxCycles = 50;
    tb.name = "channel_reduce_4";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 37, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 36, assertString(outName + "_out_data === 2 + 5 + 9 + 7"));
    
    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 2;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 8, string(in0Name + "_in_data = 5;"));
    map_insert(tb.actionsInCycles, 8, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 9, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 12, string(in0Name + "_in_data = 9;"));
    map_insert(tb.actionsInCycles, 12, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 13, string(in0Name + "_write_valid = 0;"));    

    map_insert(tb.actionsInCycles, 16, string(in0Name + "_in_data = 7;"));
    map_insert(tb.actionsInCycles, 16, string(in0Name + "_write_valid = 1;"));
    
    map_insert(tb.actionsInCycles, 17, string(in0Name + "_write_valid = 0;"));
    
    map_insert(tb.actionsInCycles, 35, string(outName + "_read_valid = 1;"));

    map_insert(tb.actionsInCycles, 36, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("channel_reduce_4"));
  }

  TEST_CASE("Complex number type") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "complex_num");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "complex_num");
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    // TODO: Make pointers to primitives registers of their width by default
    hcs.memoryMapping = memoryOpLocations(f);
    
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("complex_num", graph, hcs);

    REQUIRE(runIVerilogTB("complex_num"));
  }

  TEST_CASE("Using a FIFO with compound type as argument") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "compound_fifo");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "compound_fifo");
    getArg(f, 0)->setName("in");
    getArg(f, 1)->setName("out");

    deleteLLVMLifetimeCalls(f);

    HardwareConstraints hcs = standardConstraints();
    // TODO: Make pointers to primitives registers of their width by default
    hcs.memoryMapping = memoryOpLocations(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] =
      [hcs](llvm::Function* readFifo,
            ExecutionConstraints& exec) {
      implementRVCompoundRead(readFifo, exec, hcs);
    };
    interfaces.functionTemplates[string("write")] =
      [hcs](llvm::Function* writeFifo,
            ExecutionConstraints& exec) {
      implementRVCompoundWrite(writeFifo, exec, hcs);
    };
    interfaces.functionTemplates[string("get")] =
      [hcs](llvm::Function* busGet,
            ExecutionConstraints& exec) {
      implementBusGet(busGet, exec, hcs);
    };
    
    int width = 64;
    hcs.typeSpecs["class.Fifo"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    hcs.typeSpecs["class.Fifo.0"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    hcs.typeSpecs["class.bus"] =
      [width](StructType* tp) { return busSpec(tp); };

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("compound_fifo", graph, hcs);

    //REQUIRE(runIVerilogTB("compound_fifo"));
  }

  Instruction* findCall(int callNum, BasicBlock& bb) {
    int curNum = 0;
    for (auto& instr : bb) {
      if (CallInst::classof(&instr)) {
        if (curNum == callNum) {
          return &instr;
        }
        curNum++;
      }
    }
    assert(false);
  }

  TEST_CASE("Read and write from stencil stream") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_stream_rw");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_stream_rw");
    getArg(f, 0)->setName("in");
    getArg(f, 1)->setName("out");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    // Instruction* c0 = findCall(0, f->getEntryBlock());
    // Instruction* c1 = findCall(1, f->getEntryBlock());
    // Instruction* c2 = findCall(2, f->getEntryBlock());    
    // exec.add(instrEnd(c0) < instrStart(c1));
    // exec.add(instrEnd(c1) < instrStart(c2));    
    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("stencil_stream_rw", graph, hcs);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 40;
    tb.maxCycles = 50;
    tb.name = "stencil_stream_rw";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b1");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "write_valid", 3, "1'b0");

    tb.setArgPort(out, "read_valid", 20, "1'b1");
    tb.setArgPort(out, "read_valid", 21, "1'b0");

    map_insert(tb.actionsOnCycles, 21, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(string(out->getName()) + "_data_bus === 16'd28"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_stream_rw"));
  }

  TEST_CASE("Read mult by 2 and write from stencil stream") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_stream_mul");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_stream_mul");
    getArg(f, 0)->setName("in");
    getArg(f, 1)->setName("out");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);
    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("stencil_stream_mul", graph, hcs);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 40;
    tb.maxCycles = 50;
    tb.name = "stencil_stream_mul";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b1");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "write_valid", 3, "1'b0");

    tb.setArgPort(out, "read_valid", 20, "1'b1");
    tb.setArgPort(out, "read_valid", 21, "1'b0");

    map_insert(tb.actionsOnCycles, 21, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(string(out->getName()) + "_data_bus === 16'd56"));
    map_insert(tb.actionsOnCycles, 21, assertString(string(out->getName()) + "_last_bus === 1'b1"));    
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_stream_mul"));
  }

  TEST_CASE("Read in stencils and then read them out in the testbench") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_write_loop");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_write_loop");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("stencil_write_loop", graph, hcs, info);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 400;
    tb.maxCycles = 500;
    tb.name = "stencil_write_loop";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    //tb.actionOnCondition("1", "$display(\"arg_1_data_bus = %d, arg_1_last_bus = %d\", arg_1_data_bus, arg_1_last_bus);");

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    tb.setArgPort(out, "read_valid", 402, "1'b1");
    tb.setArgPort(out, "read_valid", 403, "1'b0");
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd28"));
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 404, "1'b1");
    tb.setArgPort(out, "read_valid", 405, "1'b0");
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_data_bus === 16'd10"));
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 406, "1'b1");
    tb.setArgPort(out, "read_valid", 407, "1'b0");
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_data_bus === 16'd7"));
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 408, "1'b1");
    tb.setArgPort(out, "read_valid", 409, "1'b0");
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_data_bus === 16'd3"));
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, 350, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 403, assertString("valid === 1"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_write_loop"));
  }

  TEST_CASE("Read in stencils, copy to another stream without if checks") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_copy_no_ifs");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_copy_no_ifs");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("stencil_copy_no_ifs", graph, hcs, info);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 400;
    tb.maxCycles = 500;
    tb.name = "stencil_copy_no_ifs";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    //tb.actionOnCondition("1", "$display(\"arg_1_data_bus = %d, arg_1_last_bus = %d\", arg_1_data_bus, arg_1_last_bus);");

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    tb.setArgPort(out, "read_valid", 402, "1'b1");
    tb.setArgPort(out, "read_valid", 403, "1'b0");
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd28"));
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 404, "1'b1");
    tb.setArgPort(out, "read_valid", 405, "1'b0");
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_data_bus === 16'd10"));
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 406, "1'b1");
    tb.setArgPort(out, "read_valid", 407, "1'b0");
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_data_bus === 16'd7"));
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 408, "1'b1");
    tb.setArgPort(out, "read_valid", 409, "1'b0");
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_data_bus === 16'd3"));
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, 350, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 403, assertString("valid === 1"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_copy_no_ifs"));
  }

  TEST_CASE("Read in stencils, copy to another stream with less complicated if") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_copy_simple_if");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_copy_simple_if");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("stencil_copy_simple_if", graph, hcs, info);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 400;
    tb.maxCycles = 500;
    tb.name = "stencil_copy_simple_if";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    //tb.actionOnCondition("1", "$display(\"arg_1_data_bus = %d, arg_1_last_bus = %d\", arg_1_data_bus, arg_1_last_bus);");

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    tb.setArgPort(out, "read_valid", 402, "1'b1");
    tb.setArgPort(out, "read_valid", 403, "1'b0");
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd28"));
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 404, "1'b1");
    tb.setArgPort(out, "read_valid", 405, "1'b0");
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_data_bus === 16'd10"));
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 406, "1'b1");
    tb.setArgPort(out, "read_valid", 407, "1'b0");
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_data_bus === 16'd7"));
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 408, "1'b1");
    tb.setArgPort(out, "read_valid", 409, "1'b0");
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_data_bus === 16'd3"));
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, 350, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 403, assertString("valid === 1"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_copy_simple_if"));
  }
  
  TEST_CASE("Read in stencils and copy them to another stencil") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_copy");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_copy");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});



    map<llvm::Value*, int> layout = {};
    
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    addNoXChecks(arch, info);
    addSetStencilChecks(arch, info);
    emitVerilog("stencil_copy", arch, info);

    //emitVerilog("stencil_copy", graph, hcs, info);


    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 400;
    tb.maxCycles = 500;
    tb.name = "stencil_copy";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    tb.setArgPort(out, "read_valid", 402, "1'b1");
    tb.setArgPort(out, "read_valid", 403, "1'b0");
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd28"));
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 404, "1'b1");
    tb.setArgPort(out, "read_valid", 405, "1'b0");
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_data_bus === 16'd10"));
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 406, "1'b1");
    tb.setArgPort(out, "read_valid", 407, "1'b0");
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_data_bus === 16'd7"));
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 408, "1'b1");
    tb.setArgPort(out, "read_valid", 409, "1'b0");
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_data_bus === 16'd3"));
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, 350, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 403, assertString("valid === 1"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_copy"));
  }
  
  TEST_CASE("Read in stencil stream and multiply by 2") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "stencil_mul_2");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "stencil_mul_2");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("stencil_mul_2", graph, hcs, info);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 400;
    tb.maxCycles = 500;
    tb.name = "stencil_mul_2";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    tb.setArgPort(out, "read_valid", 402, "1'b1");
    tb.setArgPort(out, "read_valid", 403, "1'b0");
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd56"));
    map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 404, "1'b1");
    tb.setArgPort(out, "read_valid", 405, "1'b0");
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_data_bus === 16'd20"));
    map_insert(tb.actionsOnCycles, 405, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 406, "1'b1");
    tb.setArgPort(out, "read_valid", 407, "1'b0");
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_data_bus === 16'd14"));
    map_insert(tb.actionsOnCycles, 407, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", 408, "1'b1");
    tb.setArgPort(out, "read_valid", 409, "1'b0");
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_data_bus === 16'd6"));
    map_insert(tb.actionsOnCycles, 409, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, 350, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 403, assertString("valid === 1"));
    //map_insert(tb.actionsOnCycles, 403, assertString(string(out->getName()) + "_data_bus === 16'd56"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("stencil_mul_2"));
  }
  
  // Now there is an issue with port accesses. The operator(x, y) function that I use
  // in the stencils to get and set values returns a pointer to one of its elements.
  // This corresponds to a bundle of fields that can be set. It is set by
  // reading the pointer to an i16 from an opaque function and then storing a value
  // to that pointer. What does that correspond to in hardware?

  // Case 1: Suppose the stencil is a bunch of registers under the surface. The
  // operator(i) takes in 2 constants and corresponds to wiring the write port
  // of the ith register in the stencil to the value %25

  // So in this interpretation a pointer to a type represents "some way to write
  // to a value of that type?" or more generally: "some way to perform any
  // action in this types API?"

  // Q: What if you dont need to perform any action on that type?
  // Q: Why does that matter? Just dont use the wires that you got?
  // Q: Id like for the dereference to be implemented as a slice that
  //    just returns one wire?

  // Stencil module: stencil(v0i, v1i, v2i, v3i, v0o, v1o, v2o, v3o)
  // Deref module:   deref(stencil_v0i, stencil_v1i, stencil_v2i, stencil_v3i,
  //                       stencil_v0o, stencil_v1o, stencil_v2o, stencil_v3o,
  //                       index0, index1, index2,
  //                       output_value_input, output_value_output)

  // So then what are temporary values? Temps of primitive types are busses
  // Temp values of compound types? Maybe just ban them?

  // This seems like a reasonable start. I think the next step is actually
  // to comment back to passing tests and then clean up the memory related
  // code. Check that pointers are only produced by:
  //   1. alloca
  //   2. return values of functions
  //   3. arguments to the function?

  // Note: Should the pre-scheduling assignment of ports have a distinction
  // between wires and registers?
  // Q: What about pointers to temporary objects? What do I mean temporary?
  // A: I guess an object that gets optimized in to a wire?
  //    So if I create an object, then start referencing it through pointers
  //    the module itself has to have all of its internal state saved in
  //    registers or memory.
  //    You have cycle-scoping?

  // problem:
  // Stencil& a = channel.read();
  // Stencil& b = channel.read();
  // a.do_something();
  // b.do_something();
  // a still needs to refer to the original stored value in channel, but
  // if passing by pointer just means connecting to ports that refer to the
  // channel state, then the values will change when the channel is read again
  TEST_CASE("2 x 2 pointwise multiply from Halide") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "vhls_target");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    //getArg(f, 0)->setName("ram");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("write")] = implementStencilWrite;
    interfaces.functionTemplates[string("read")] = implementStencilRead;    
    interfaces.functionTemplates[string("set")] = implementStencilSet;
    interfaces.functionTemplates[string("get")] = implementStencilGet;            
    interfaces.functionTemplates[string("set_last")] = implementStencilSetLast;
    interfaces.functionTemplates[string("AxiPackedStencil_uint16_t_1_1_")] =
      implementStencilConstructor;
    interfaces.functionTemplates[string("copy")] =
      implementStencilConstructor;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.hls_stream_AxiPackedStencil_uint16_t_1_1__"] =
      [](StructType* axiStencil) { return streamAxiPackedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.Stencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return stencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.PackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return packedStencilSpec(16, 1, 1); };
    hcs.typeSpecs["class.AxiPackedStencil_uint16_t_1_1_"] =
      [](StructType* axiStencil) { return axiPackedStencilSpec(16, 1, 1); };

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);
    set<BasicBlock*> toPipeline;    


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
    tb.settablePort(in, "in_data_bus");
    tb.settablePort(in, "in_last_bus");    
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
    tb.setArgPort(in, "in_data_bus", 2, "16'd28");
    tb.setArgPort(in, "in_last_bus", 2, "1'b0");
    tb.setArgPort(in, "write_valid", 2, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 3, "16'd10");
    tb.setArgPort(in, "in_last_bus", 3, "1'b0");
    tb.setArgPort(in, "write_valid", 3, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 4, "16'd7");
    tb.setArgPort(in, "in_last_bus", 4, "1'b0");
    tb.setArgPort(in, "write_valid", 4, "1'b1");    

    tb.setArgPort(in, "in_data_bus", 5, "16'd3");
    tb.setArgPort(in, "in_last_bus", 5, "1'b1");
    tb.setArgPort(in, "write_valid", 5, "1'b1");    
    
    tb.setArgPort(in, "write_valid", 6, "1'b0");

    int endCycle = 700;
    tb.setArgPort(out, "read_valid", endCycle + 2, "1'b1");
    tb.setArgPort(out, "read_valid", endCycle + 3, "1'b0");
    map_insert(tb.actionsOnCycles, endCycle + 3, assertString(string(out->getName()) + "_data_bus === 16'd56"));
    map_insert(tb.actionsOnCycles, endCycle + 3, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", endCycle + 4, "1'b1");
    tb.setArgPort(out, "read_valid", endCycle + 5, "1'b0");
    map_insert(tb.actionsOnCycles, endCycle + 5, assertString(string(out->getName()) + "_data_bus === 16'd20"));
    map_insert(tb.actionsOnCycles, endCycle + 5, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", endCycle + 6, "1'b1");
    tb.setArgPort(out, "read_valid", endCycle + 7, "1'b0");
    map_insert(tb.actionsOnCycles, endCycle + 7, assertString(string(out->getName()) + "_data_bus === 16'd14"));
    map_insert(tb.actionsOnCycles, endCycle + 7, assertString(string(out->getName()) + "_last_bus === 1'b0"));

    tb.setArgPort(out, "read_valid", endCycle + 8, "1'b1");
    tb.setArgPort(out, "read_valid", endCycle + 9, "1'b0");
    map_insert(tb.actionsOnCycles, endCycle + 9, assertString(string(out->getName()) + "_data_bus === 16'd6"));
    map_insert(tb.actionsOnCycles, endCycle + 9, assertString(string(out->getName()) + "_last_bus === 1'b1"));
    
    map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

    SECTION("No task parallelism") {
      Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
      STG graph = buildSTG(s, f);
    
      cout << "STG Is" << endl;
      graph.print(cout);


      map<llvm::Value*, int> layout = {};
      auto arch = buildMicroArchitecture(graph, layout, hcs);
    
      VerilogDebugInfo info;
      addControlSanityChecks(arch, info);

      checkSignal(tb,
                   "valid",
                  {{3, 0}, {10, 0}, {15, 0}, {17, 0}, {100, 1}, {103, 1}, {106, 1}, {112, 1}, {125, 1}, {150, 1}, {200, 1}});

      checkSignal(tb,
                   "arg_1_read_ready",
                  {{3, 0}, {10, 0}, {15, 0}, {17, 0}, {25, 0}, {37, 0}, {43, 0}, {47, 1}, {50, 1}, {100, 1}, {103, 1}, {106, 1}, {112, 1}, {125, 1}, {150, 1}, {200, 1}});
      
      emitVerilog("vhls_target", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("vhls_target"));      
    }

    SECTION("With each block in its own task") {

      auto preds = buildControlPreds(f);
      addStencilCallConstraints(f, preds, exec);
      
      inlineWireCalls(f, exec, interfaces);
      addDataConstraints(f, exec);
    
      cout << "After inlining" << endl;
      cout << valueString(f) << endl;

      set<TaskSpec> tasks = halideTaskSpecs(f);

      preds = buildControlPreds(f);
      
      set<PipelineSpec> toPipeline;
      SchedulingProblem p =
        createSchedulingProblem(f, hcs, toPipeline, tasks, preds);
      exec.addConstraints(p, f);

      map<Function*, SchedulingProblem> constraints{{f, p}};
      Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
      STG graph = buildSTG(s, f);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout = {};
      auto arch = buildMicroArchitecture(graph, layout, hcs);
      
      VerilogDebugInfo info;
      addControlSanityChecks(arch, info);

      checkSignal(tb,
                   "arg_1_read_ready",
                  {{3, 0}, {10, 0}, {15, 0}, {17, 0}, {22, 0}, {25, 1}, {37, 1}, {43, 1}, {47, 1}, {50, 1}, {100, 1}, {103, 1}, {106, 1}, {112, 1}, {125, 1}, {150, 1}, {200, 1}});
      
      emitVerilog("vhls_target", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("vhls_target"));      
    }

  }

  TEST_CASE("Set kernel ram in halide function") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "cascade_halide_ram_set_loop");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "cascade_halide_ram_set_loop");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("arg_1");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);

    InterfaceFunctions interfaces;
    HardwareConstraints hcs = standardConstraints();
    populateHalideStencils(f, interfaces, hcs);

    ExecutionConstraints exec;
    //sequentialCalls(f, exec);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 300;
    tb.maxCycles = 300;
    tb.name = "cascade_halide_ram_set_loop";
    tb.useModSpecs = true;
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));    
    map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));    

    // Now reset?
    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    checkSignal(tb,
                "valid",
                {{3, 0}, {7, 0}, {15, 1}, {200, 1}});

    emitVerilog("cascade_halide_ram_set_loop", arch, info);

    //setRVChannel(tb, "arg_0", fifoIns);
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("cascade_halide_ram_set_loop"));
    
  }

  TEST_CASE("Feed data to linebuffer then read it out") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "cascade_halide_first_lb");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "cascade_halide_first_lb");
    getArg(f, 0)->setName("arg_0");
    getArg(f, 1)->setName("_hw_input_stencil_stream");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;

    deleteLLVMLifetimeCalls(f);

    InterfaceFunctions interfaces;
    HardwareConstraints hcs = standardConstraints();
    populateHalideStencils(f, interfaces, hcs);

    ExecutionConstraints exec;

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 5000;
    tb.maxCycles = 5000;
    tb.name = "cascade_halide_first_lb";
    tb.useModSpecs = true;
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 1;"));
    map_insert(tb.actionsOnCycles, 3, string("rst_reg <= 0;"));    

    // Now reset?
    set<BasicBlock*> toPipeline;
    Schedule s = scheduleInterface(f, hcs, interfaces, toPipeline, exec);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    checkSignal(tb,
                "valid",
                {{3, 0}, {7, 0}, {15, 0}, {4999, 1}});

    emitVerilog("cascade_halide_first_lb", arch, info);

    int numIns = 16*16;
    int writeTime = 3;
    vector<pair<int, int> > fifoIns;
    for (int i = 0; i < numIns; i++) {
      fifoIns.push_back({writeTime, i});
      writeTime += 2;
    }
    // CS
    setRVChannel(tb, "arg_0", fifoIns);

    //vector<pair<int, string> > fifoOuts;
    //fifoOuts.push_back({4000, "{{1'b0, 32'd0}, {1'b0, 32'd1}, {1'b0, 32'd2}, {1'b1, 32'd3}, {1'b0, 32'd4}, {1'b0, 32'd5}, {1'b0, 32'd6}, {1'b0, 32'd7}, {1'b0, 32'd8}}"});
    //checkRVChannel(tb, "_hw_input_stencil_stream", fifoOuts);
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("cascade_halide_first_lb"));
    
  }
  
}
