#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace DHLS {

  // Q: System TODOs:
  // A: Remove useless address fields from registers (allow custom memory interfaces)
  //    Add an "I dont care about default values to this FU" option?
  //    Move test layout int testbenchspec

  // NOTE: Systolic array example has correct binding by chance. The control
  // structure around the array is a tricky question. Most papers on systolic
  // arrays just show the datapath not the control logic that feeds the array.
  // Im not sure what the most area efficient way to create control logic for
  // the array is.

  // Is the initiation interval multiplexing loop problem a problem that can
  // be solved by a binding API?
  // I guess if I was given a target II for the loop and given unlimited resources
  // I could just find a schedule for that II, and then duplicate that schedule
  // with control logic to offset it? Is there ever a better way to do this? And
  // if not how do I incorporate it in to the current control structure?

  // One form of pipelining is mapping different instances of the same computation
  // on to the same functional units at overlapping times.
  // Another form of pipelining is mapping different instances of the same
  // computation on to different instances of a computation, but the wires that
  // are inputs are mapped to the same units, there is no resource duplication
  // on wires.

  // Q: What test cases do I need?
  // A: Test that uses multiple different RAM types
  //    Test that uses limited numbers of memory read/write ports
  //    Test case that merges basic blocks that execute different numbers of times
  //    Test case with outer loop pipelining
  //    Test case that pipelines inner loop surrounded by outer loop
  //    Test case using a ready-valid interface together with pipelining
  //    Test case that builds a linebuffer from LLVM
  //    Test case that uses multiple functions with interface specs connecting them
  TEST_CASE("Schedule a single store operation") {
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "single_store");

    Function* f = Mod->getFunction("single_store");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};

    Schedule s = scheduleFunction(f, hcs);

    REQUIRE(s.numStates() == 4);

    auto& retInstr = f->getBasicBlockList().back().back();
    REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("single_store"));
  }

  TEST_CASE("Adding two numbers and storing them back") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "plus");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("plus");
    Schedule s = scheduleFunction(f, hcs);

    REQUIRE(s.numStates() == 5);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 5);

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 3}, {getArg(f, 2), 4}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("plus"));
  }

  TEST_CASE("A simple if") {
    SMDiagnostic Err;
    LLVMContext Context;

    std::unique_ptr<Module> Mod = loadModule(Context, Err, "if_else");
    
    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("if_else");
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 3}, {getArg(f, 2), 4}};    
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("if_else"));
  }

  TEST_CASE("Accessing a memory address that requires address calculation") {
    SMDiagnostic Err;
    LLVMContext Context;

    std::unique_ptr<Module> Mod = loadModule(Context, Err, "read_2");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("read_2");
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 3}};
    synthesizeVerilog(f, hcs, layout);

    REQUIRE(runIVerilogTB("read_2"));
    
  }

  TEST_CASE("Looping over an array doing a[i] + 7") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_7");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("loop_add_7");
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Adding numbers with resource limits") {
    createLLFile("./test/ll_files/many_adds");    

    SMDiagnostic Err;
    LLVMContext Context;

    string modFile = "./test/ll_files/many_adds.ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    // Limits number of adders
    hcs.setCount(ADD_OP, 1);

    Function* f = Mod->getFunction("many_adds");
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    for (auto st : graph.opStates) {
      map<OperationType, int> opCounts;
      for (auto instrG : st.second) {
        Instruction* instr = instrG.instruction;
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

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}, {getArg(f, 2), 2}, {getArg(f, 3), 3}};    
    emitVerilog(f, graph, layout);
    REQUIRE(runIVerilogTB("many_adds"));
    
  }

  TEST_CASE("Greater than") {
    createLLFile("./test/ll_files/cmp_gt");

    SMDiagnostic Err;
    LLVMContext Context;

    string modFile = "./test/ll_files/cmp_gt.ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);
    hcs.setLatency(ZEXT_OP, 1);
    hcs.setLatency(SELECT_OP, 0);

    Function* f = Mod->getFunction("cmp_gt");
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    //map<string, int> layout = {{"a", 0}, {"b", 1}, {"c", 2}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}, {getArg(f, 2), 2}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("cmp_gt"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 7") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_7");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("loop_add_7");

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

    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations small enough to never fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_4");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("loop_add_4");

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

    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);
    
    //map<string, int> layout = {{"a", 0}, {"b", 10}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}};
    VerilogDebugInfo info;

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    // info.debugWires.push_back({true, 32, "num_clocks_after_reset"});
    // addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    // addWirePrintoutIf("num_clocks_after_reset == 10", "last_BB", info);
    // addAssert("num_clocks_after_reset !== 2 || last_BB === 2", info);

    emitVerilog(f, graph, layout, info);

    REQUIRE(runIVerilogTB("loop_add_4"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations large enough to fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_4_6_iters");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("loop_add_4_6_iters");

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

    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("loop_add_4_6_iters"));
  }

  TEST_CASE("Using temporary memory") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_4_copy");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);


    Function* f = Mod->getFunction("loop_add_4_copy");
    assert(f != nullptr);

    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, ramSpec(1, 3, 1, 1, 32, 32));
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}};

    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    
    addNoXChecks(arch, info);    

    emitVerilog(f, arch, info);
    
    REQUIRE(runIVerilogTB("loop_add_4_copy"));
  }

  TEST_CASE("Blur without linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "blur_no_lb");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("blur_no_lb");
    assert(f != nullptr);
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    
    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 8}};

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    emitVerilog(f, arch, info);

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

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.name = "blur_no_lb";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("blur_no_lb"));
    
  }

  TEST_CASE("Blur with linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "blur_lb");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("blur_lb");
    assert(f != nullptr);
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 8}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);

    noStoredValuesXWhenUsed(arch, info);

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});

    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    emitVerilog(f, arch, info);

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

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 40;
    tb.name = "blur_lb";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("blur_lb"));
  }

  TEST_CASE("Matrix vector multiply") {
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "mvmul");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);
    hcs.setLatency(MUL_OP, 0);

    Function* f = Mod->getFunction("mvmul");
    assert(f != nullptr);
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"a", 0}, {"b", 9}, {"c", 12}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 9}, {getArg(f, 2), 12}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

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

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.name = "mvmul";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mvmul"));
  }

  TEST_CASE("Single store with stall") {
    
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "stalled_single_store");

    Function* f = Mod->getFunction("stalled_single_store");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    hcs.setCount(ADD_OP, 1);
    
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}};
    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    ArchOptions options;
    options.globalStall = true;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("stalled_single_store"));
  }

  TEST_CASE("AXI based memory transfer") {
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod =
      loadModule(Context, Err, "stalled_single_store_axi");

    Function* f = Mod->getFunction("stalled_single_store_axi");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    hcs.setCount(ADD_OP, 1);
    
    //map<string, int> layout = {{"a", 0}, {"b", 1}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}};

    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    ArchOptions options;
    options.globalStall = true;
    options.setMemInterface(MEM_INTERFACE_AXI4_LITE);

    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("stalled_single_store_axi"));
  }

  // Random Thought: Test if an access pattern maps onto a cache type
  // by checking whether the recurrence that describes the loop pattern
  // is equivalent to the recurrence that describes the cache access pattern
  TEST_CASE("Schedule 1D Halide App (Brighter)") {
    SMDiagnostic Err;
    LLVMContext Context;
    //std::unique_ptr<Module> Mod = loadModule(Context, Err, "brighter");
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "brighter");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);
    hcs.setLatency(SUB_OP, 0);    
    hcs.setLatency(MUL_OP, 0);
    hcs.setLatency(SEXT_OP, 0);

    Function* f = Mod->getFunction("brighter");
    assert(f != nullptr);
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    bool noDuplicates = true;
    for (auto st : graph.opStates) {
      std::set<Instruction*> alreadyDone;
      for (auto instrG : st.second) {
        auto instr = instrG.instruction;
        if (elem(instr, alreadyDone)) {
          cout << "Duplicate instruction " << instructionString(instr)
               << " in state " << st.first << endl;
          noDuplicates = false;
        } else {
          alreadyDone.insert(instr);
        }
      }
    }

    REQUIRE(noDuplicates);

    // 3 x 3
    map<string, int> testLayout = {{"input", 0}, {"input1", 10}, {"brighter", 20}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}, {getArg(f, 2), 20}};    

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noLoadedValuesXWhenUsed(arch, info);
    noLoadAddressesXWhenUsed(arch, info);    
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    map<string, vector<int> > memoryInit{{"input", {6, 1, 2, 3, 7, 5, 5, 2, 9, 3}},
        {"input1", {129, 34, 13, 5, 5, 9, 51, 49, 46, 95}}};
    map<string, vector<int> > memoryExpected{{"brighter", {}}};

    auto input = map_find(string("input"), memoryInit);
    auto input0 = map_find(string("input1"), memoryInit);
    for (int i = 0; i < 10; i++) {
      int res = input[i] + input0[i];
      map_insert(memoryExpected, string("brighter"), res);
    }


    cout << "Expected values" << endl;
    for (auto val : map_find(string("brighter"), memoryExpected)) {
      cout << "\t" << val << endl;
    }

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 60;
    tb.name = "brighter";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("brighter"));
    
  }

  TEST_CASE("Building a simple function directly in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("shift register test", context);

    std::vector<Type *> inputs{Type::getInt32Ty(context)->getPointerTo(),
        Type::getInt32Ty(context)->getPointerTo()};
    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "using_shift_register", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* zero = mkInt("0", 32);
    ConstantInt* five = mkInt("5", 32);        
    IRBuilder<> builder(entryBlock);
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);
    auto plus = builder.CreateAdd(ldA, five);
    storeVal(builder, getArg(srUser, 1), zero, plus);
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 1}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 1}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {11}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "using_shift_register";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("using_shift_register"));
  }

  // Next test case: Need to do a stenciled loop where I fill
  // and then use a shift register for the loop computation
  TEST_CASE("Building a simple loop in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM accumulate loop", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto ldA = builder.CreateLoad(dyn_cast<Value>(srUser->arg_begin()));

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
    exitBuilder.CreateStore(nextSum, dyn_cast<Value>(srUser->arg_begin() + 1));
    exitBuilder.CreateRet(nullptr);

    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 15}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*5}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "accum_loop";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("accum_loop"));
  }

  TEST_CASE("1D stencil without shift register in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM 1D stencil", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
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

    auto ai = loadVal(loopBuilder, getArg(srUser, 0), indPhi);
    auto aip1 = loadVal(loopBuilder, getArg(srUser, 0), indPhiP1);
    auto aim1 = loadVal(loopBuilder, getArg(srUser, 0), indPhiM1);
    
    auto inputSum = loopBuilder.CreateAdd(aim1, loopBuilder.CreateAdd(ai, aip1), "stencil_accum");

    storeVal(loopBuilder,
             getArg(srUser, 1),
             loopBuilder.CreateSub(indPhi, one),
             inputSum);

    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 5, 1, 2, 9, 8, 4}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6 + 5 + 1, 5 + 1 + 2, 1 + 2 + 9, 2 + 9 + 8, 9 + 8 + 4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.name = "one_d_stencil";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("one_d_stencil"));
  }

  TEST_CASE("LLVM program that uses a register") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("program that uses a register", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "one_register", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);

    ConstantInt* zero = mkInt("0", 32);    

    IRBuilder<> builder(entryBlock);
    auto reg = builder.CreateAlloca(intType(32), nullptr, "dhsreg");
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);

    auto gpr = builder.CreateGEP(reg, zero);

    builder.CreateStore(ldA, gpr);
    
    auto v = builder.CreateLoad(gpr);
    storeVal(builder, getArg(srUser, 1), zero, v);
    builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(srUser);
    setAllAllocaMemTypes(hcs, srUser, registerSpec(32));

    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6}}};

    TestBenchSpec tb;
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};    
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.name = "one_register";
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

    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

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
    auto condVal = loadVal(builder, getArg(f, 0), zero);
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

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

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
    auto condVal = loadVal(builder, getArg(f, 0), zero);
    builder.CreateCondBr(condVal, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    auto cond1Val = loadVal(fBuilder, getArg(f, 1), zero);
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

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

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

    std::vector<Type *> inputs{Type::getInt16Ty(context)->getPointerTo(),
        Type::getInt16Ty(context)->getPointerTo()};
    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "mem_16_test", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

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
    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

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

  TEST_CASE("Pipeline with resource constraints") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with resource constraints", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "constrained_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto z = builder.CreateMul(v, v);
      auto r = builder.CreateMul(z, v);
      storeVal(builder, getArg(f, 1), i, r);
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

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*6*6, 4*4*4, 5*5*5, 2*2*2, 1*1*1}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "constrained_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("constrained_pipe"));
  }

  TEST_CASE("Pipeline that needs temporary storage") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with temp storage", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "temp_storage_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto three = mkInt("3", 32);
      auto seven = mkInt("7", 32);      

      auto z = builder.CreateMul(v, three);
      auto r = builder.CreateMul(v, seven);
      auto c = builder.CreateAdd(z, r);
      storeVal(builder, getArg(f, 1), i, c);
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

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*3 + 6*7, 4*3 + 4*7, 5*3 + 5*7, 2*3 + 2*7, 1*3 + 1*7}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "temp_storage_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("temp_storage_pipe"));
  }

  TEST_CASE("Reading a stored value from outside a pipeline inside a pipeline") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with external read", context);

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
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

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

    std::vector<Type *> inputs{intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* one = mkInt("1", 32);

    IRBuilder<> entryBuilder(entryBlock);    
    auto bodyF = [f, one](IRBuilder<>& builder, Value* i) {
      auto ind = builder.CreateSub(i, one);
      
      auto v = loadVal(builder, getArg(f, 0), ind);
      auto final = builder.CreateAdd(v, one);

      storeVal(builder, getArg(f, 0), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, one, loopBound, bodyF);

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

    map<string, int> testLayout = {{"arg_0", 0}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 6 + 1, 6 + 2, 6 + 3, 6 + 4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "mem_dep_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe"));
  }

  TEST_CASE("Loop pipeline II == 1 with long memory dependence") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with long memory dependence", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe_long", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* loopBound = mkInt("10", 32);
    ConstantInt* one = mkInt("1", 32);
    ConstantInt* three = mkInt("3", 32);
    IRBuilder<> entryBuilder(entryBlock);    
    auto bodyF = [f, one, three](IRBuilder<>& builder, Value* i) {
      auto ind = builder.CreateSub(i, three);
      
      auto v = loadVal(builder, getArg(f, 0), ind);
      auto final = builder.CreateAdd(v, one);

      storeVal(builder, getArg(f, 0), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, three, loopBound, bodyF);

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

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);
    
    map<string, int> testLayout = {{"arg_0", 0}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1, 8, 0, 2, 9, 6}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 4, 5, 6 + 1, 4 + 1, 5 + 1, 7 + 1, 5 + 1, 5 + 2, 7 + 2}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 20;
    tb.maxCycles = 43;
    tb.name = "mem_dep_pipe_long";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe_long"));
  }

  TEST_CASE("1 x 2 systolic array") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("1 x 2 systolic array", context);

    int width = 32;
    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "sys_array_1_2", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    IRBuilder<> entryBuilder(entryBlock);

    auto aRow0 = getArg(f, 0);

    auto bCol0 = getArg(f, 1);
    auto bCol1 = getArg(f, 2);

    auto cRow0 = getArg(f, 3);

    vector<Value*> rightRegisters;
    for (int i = 0; i < 1; i++) {
      auto reg =
        entryBuilder.CreateAlloca(intType(width), nullptr, "right_" + to_string(i));
      storeReg(entryBuilder, reg, mkInt(0, 32));
      rightRegisters.push_back(reg);
    }

    vector<Value*> accumRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        entryBuilder.CreateAlloca(intType(width), nullptr, "accum_" + to_string(i));
      storeReg(entryBuilder, reg, mkInt(0, 32));
      accumRegisters.push_back(reg);
    }

    for (int i = 0; i < 3; i++) {
      cout << "i = " << i << endl;

      auto ind = mkInt(i, 32);

      auto iStr = to_string(i);
      auto aRow0V = loadVal(entryBuilder, aRow0, ind, "aRow0_" + iStr);
      auto left0 = loadVal(entryBuilder, rightRegisters[0], mkInt(0, 32), "left0_" + iStr);
      auto bCol0V = loadVal(entryBuilder, bCol0, ind, "bCol0_" + iStr);
      auto bCol1V = loadVal(entryBuilder, bCol1, ind, "bCol1_" + iStr);

      cout << "Storing computed values" << endl;
      
      // Store to new down / left registers
      auto newAccum0 =
        entryBuilder.CreateAdd(loadReg(entryBuilder, accumRegisters[0]),
                               entryBuilder.CreateMul(aRow0V, bCol0V));

      auto newAccum1 =
        entryBuilder.CreateAdd(loadReg(entryBuilder, accumRegisters[1]),
                               entryBuilder.CreateMul(left0, bCol1V));

      cout << "Storing regs" << endl;

      storeReg(entryBuilder, accumRegisters[0], newAccum0);
      storeReg(entryBuilder, accumRegisters[1], newAccum1);

      // Transfer left to right
      storeReg(entryBuilder, rightRegisters[0], aRow0V);

    }

    // Store out final results
    storeVal(entryBuilder, cRow0, mkInt(0, 32), loadReg(entryBuilder, accumRegisters[0]));
    storeVal(entryBuilder, cRow0, mkInt(1, 32), loadReg(entryBuilder, accumRegisters[1]));

    entryBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);

    setAllAllocaMemTypes(hcs, f, registerSpec(32));

    hcs.setCount(MUL_OP, 2);

    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    // TODO: Build layout and test layout from one data structure so they must
    // match
    // TODO: Pass hardware constraints through the whole flow
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0},
                                     {getArg(f, 1), 3},
                                     {getArg(f, 2), 6},
                                     {getArg(f, 3), 10}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, int> testLayout =
      {{"aRow0", 0}, {"bCol0", 3}, {"bCol1", 6}, {"cRow0", 10}};
    map<string, vector<int> > memoryInit{{"aRow0", {1, 2, 0}}, {"bCol0", {4, 6, 0}}, {"bCol1", {0, 5, 7}}};
    map<string, vector<int> > memoryExpected{{"cRow0", {16, 19}}};
    
    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 20;
    tb.maxCycles = 41;
    tb.name = "sys_array_1_2";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("sys_array_1_2"));
  }

  TEST_CASE("Builtin FIFO as argument to function") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    auto mod = llvm::make_unique<Module>("fifo use", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo =
      mkFunc(readArgs, intType(32), "builtin_read_fifo_" + iStr, mod.get());

    vector<Type*> writeArgs = {tp->getPointerTo(), intType(32)};
    Function* writeFifo =
      mkFunc(readArgs, "builtin_write_fifo_" + iStr, mod.get());
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_user", mod.get());
    auto blk = mkBB("entry_block", f);
    
    IRBuilder<> builder(blk);
    auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
    builder.CreateCall(writeFifo, {val, getArg(f, 1)});
    builder.CreateRet(nullptr);

    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_user"));
  }

  TEST_CASE("Delay between reading from FIFO and using the result") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo =
      mkFunc(readArgs, intType(width), "builtin_read_fifo_" + iStr, mod.get());

    vector<Type*> writeArgs = {tp->getPointerTo(), intType(width)};
    Function* writeFifo =
      mkFunc(readArgs, "builtin_write_fifo_" + iStr, mod.get());
    
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

    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_read_delay"));
  }

  TEST_CASE("2 x 2 systolic array with FIFOs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    StructType* tp = fifoType(width);
    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());

    cout << "Read fifo func" << endl;
    cout << valueString(readFifo) << endl;

    Function* writeFifo = fifoWrite(width, mod.get());

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

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);

    cout << "Memory mapping" << endl;
    for (auto mm : hcs.memoryMapping) {
      cout << "\t" << valueString(mm.first) << " -> " << valueString(mm.second) << endl;
    }
    setAllAllocaMemTypes(hcs, f, registerSpec(width));

    hcs.setCount(MUL_OP, 4);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));
    // Add gep restriction
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        int numUsers = instr->getNumUses();

        if (!BinaryOperator::classof(instr) && (numUsers == 1)) {
          auto& user = *(instr->uses().begin());
          assert(Instruction::classof(user));
          auto userInstr = dyn_cast<Instruction>(user.getUser());
          p.addConstraint(p.instrEnd(instr) == p.instrStart(userInstr));
        }
      }
    }
    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 8);

    for (auto& st : graph.opStates) {
      int numReads = 0;
      int numWrites = 0;
      int numMuls = 0;
      int numAdds = 0;
      int numLoads = 0;
      int numStores = 0;

      for (auto instrG : graph.instructionsStartingAt(st.first)) {
        Instruction* instr = instrG.instruction;
        if (isBuiltinFifoRead(instr)) {
          numReads++;
        }

        if (isBuiltinFifoWrite(instr)) {
          numWrites++;
        }

        if (instr->getOpcode() == Instruction::Mul) {
          numMuls++;
        }

        if (instr->getOpcode() == Instruction::Add) {
          numAdds++;
        }

        if (LoadInst::classof(instr)) {
          numLoads++;
        }

        if (StoreInst::classof(instr)) {
          numStores++;
        }
        
      }

      // Looks like a register cannot be loaded from and stored to
      // 
      cout << "At state " << st.first << endl;
      cout << tab(1) << " numReads     == " << numReads << endl;
      cout << tab(1) << " numWrites    == " << numWrites << endl;
      cout << tab(1) << " numMuls      == " << numMuls << endl;
      cout << tab(1) << " numAdds      == " << numAdds << endl;
      cout << tab(1) << " numLoads     == " << numLoads << endl;
      cout << tab(1) << " numStores    == " << numStores << endl;

      bool res = (numReads == 0) || (numReads == 4);
      REQUIRE(res);
    }

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    // map<string, int> testLayout;      
    // TestBenchSpec tb;
    // tb.name = "sys_array_2x2";

    // emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("sys_array_2x2"));
  }

  TEST_CASE("Phi node with 4 inputs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;

    auto mod = llvm::make_unique<Module>("BB diamond 4", context);

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

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

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

  bool runIVerilogTest(const std::string& mainName,
                       const std::string& exeName) {

    string genCmd = "iverilog -g2005 -o " + exeName + " " + mainName + string(" ") + " RAM.v RAM2.v RAM3.v axil_ram.v delay.v builtins.v";

    bool compiled = runCmd(genCmd);

    REQUIRE(compiled);

    string resFile = exeName + "_tb_result.txt";
    string exeCmd = "./" + exeName + " > " + resFile;
    bool ran = runCmd(exeCmd);

    assert(ran);

    ifstream res(resFile);
    std::string str((std::istreambuf_iterator<char>(res)),
                    std::istreambuf_iterator<char>());

    cout << "str = " << str << endl;
    
    reverse(begin(str), end(str));
    string lastLine;

    for (int i = 1; i < (int) str.size(); i++) {
      if (str[i] == '\n') {
        break;
      }

      lastLine += str[i];
    }

    reverse(begin(lastLine), end(lastLine));

    cout << "Lastline = " << lastLine << endl;

    return lastLine == "Passed";
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

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);

    auto mod = llvm::make_unique<Module>("fifo use in a loop", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo =
      mkFunc(readArgs, intType(width), "builtin_read_fifo_" + iStr, mod.get());

    vector<Type*> writeArgs = {tp->getPointerTo(), intType(width)};
    Function* writeFifo =
      mkFunc(readArgs, "builtin_write_fifo_" + iStr, mod.get());
    
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
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_in_loop"));
  }

  TEST_CASE("Reduce loop") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadModule(context, err, "add_reduce_15");

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
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

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

    StructType* tp = fifoType(width);
    auto mod = llvm::make_unique<Module>("Add-reduce with timed wires", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());

    Function* writeFifo = fifoWrite(width, mod.get());

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
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.fifoSpecs[getArg(f, 0)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 1)] = FifoSpec(0, 0, FIFO_TIMED);

    hcs.setCount(ADD_OP, 1);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("timed_wire_reduce"));
  }

  TEST_CASE("One floating point add") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    StructType* tp = fifoType(width);
    auto mod = llvm::make_unique<Module>("One float add", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());

    Function* writeFifo = fifoWrite(width, mod.get());

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
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.fifoSpecs[getArg(f, 0)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 1)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 2)] = FifoSpec(0, 0, FIFO_TIMED);

    // TODO: Set latency of fadd to 15?
    hcs.setCount(FADD_OP, 1);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

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
    tb.settableWires.insert("fifo_0_out_data");
    tb.settableWires.insert("fifo_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 21, assertString("fifo_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("fifo_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("fifo_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("fifo_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 21, string("$display(\"fifo_2_in_data = %d\", fifo_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_fp_add"));
  }
  
  TEST_CASE("Floating point reduce with timed wires") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    StructType* tp = fifoType(width);
    auto mod = llvm::make_unique<Module>("floating point reduce with timed wires", context);

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());

    Function* writeFifo = fifoWrite(width, mod.get());

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
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.fifoSpecs[getArg(f, 0)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 1)] = FifoSpec(0, 0, FIFO_TIMED);

    hcs.setCount(FADD_OP, 1);

    // TODO: Fix the fadd instantiation problem: 2 fadds but scheduled like
    // there is only 1?
    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 10;
    tb.maxCycles = 100;
    tb.name = "timed_wire_reduce_fp";
    tb.settableWires.insert("fifo_0_out_data");
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 81, assertString("fifo_1_in_data === (1 + 2 + 3 + 4)"));

    map_insert(tb.actionsInCycles, 1, string("fifo_0_out_data_reg = 1;"));
    map_insert(tb.actionsInCycles, 2, string("fifo_0_out_data_reg = 2;"));
    map_insert(tb.actionsInCycles, 3, string("fifo_0_out_data_reg = 3;"));    
    map_insert(tb.actionsInCycles, 4, string("fifo_0_out_data_reg = 4;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_reduce_fp"));
  }

  TEST_CASE("One floating point add via readport and writeport") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    StructType* tp = fifoType(width);
    auto mod = llvm::make_unique<Module>("One float add via port API", context);
    setGlobalLLVMModule(mod.get());

    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());

    Function* writeFifo = fifoWrite(width, mod.get());

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

    // Create transaction constraints data structure?

    // Interface with floating point adder
    auto fpuType =
      llvm::StructType::create(getGlobalLLVMContext(),
                               "builtin_fadd");
    
    auto writeRst = writePort("rst", 1, fpuType);
    auto writeA = writePort("input_a", 32, fpuType);
    auto writeAStb = writePort("input_a_stb", 1, fpuType);

    auto writeB = writePort("input_b", 32, fpuType);
    auto writeBStb = writePort("input_b_stb", 1, fpuType);

    auto fpu = b.CreateAlloca(fpuType, nullptr, "fpu_0");
    b.CreateCall(writeRst, {fpu, mkInt(1, 1)});
    // Wait until next cycle
    b.CreateCall(writeRst, {fpu, mkInt(0, 1)});
    b.CreateCall(writeA, {fpu, a});
    b.CreateCall(writeAStb, {fpu, mkInt(1, 1)});

    // Wait for input_a_ack == 1, and then wait 1 more cycle
    b.CreateCall(writeAStb, {fpu, mkInt(0, 1)});
    b.CreateCall(writeB, {fpu, b0});
    b.CreateCall(writeBStb, {fpu, mkInt(1, 1)});

    // Wait one or two cycles?
    b.CreateCall(writeBStb, {fpu, mkInt(0, 1)});

    // Wait at least one cycle after input_b_stb == 1, for output_z_stb == 1
    auto val = b.CreateCall(readPort("output_z", 32, fpuType), {fpu});

    //auto val = b.CreateFAdd(a, b0);
    auto out = getArg(f, 2);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.fifoSpecs[getArg(f, 0)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 1)] = FifoSpec(0, 0, FIFO_TIMED);
    hcs.fifoSpecs[getArg(f, 2)] = FifoSpec(0, 0, FIFO_TIMED);

    // TODO: Set latency of fadd to 15?
    hcs.setCount(FADD_OP, 1);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

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
    tb.settableWires.insert("fifo_0_out_data");
    tb.settableWires.insert("fifo_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 21, assertString("fifo_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("fifo_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("fifo_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("fifo_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 21, string("$display(\"fifo_2_in_data = %d\", fifo_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_fp_add"));
  }
  
}
