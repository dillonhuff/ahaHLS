#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace DHLS {

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

  // Handling ready / valid FIFO:
  //   1. Should it be a builtin?
  //   2. My first thought is that we should have a custom function
  //      that is recognized by the system to represent FIFOs
  //   3. LLVM externally declared struct?

  // Other thing is how efficient does AXI / external memory handling need to be
  // in order for the generated code to beat normal code? Possible problems:
  //   1. AXI burst mode may be mandatory for good performance
  //   2. AXI transactions have variable completion times, but the generated
  //      hardware needs to overlap transactions
  //   3. AXI data bus is much wider than the widest load / store, so we need to
  //      be able to pack accesses together to get the best data storage possible
  //      (a form of vectorization)

  // Q: What test cases do I need?
  // A: Test that uses multiple different RAM types
  //    Test that uses limited numbers of memory read/write ports
  //    Test case that merges basic blocks that execute different numbers of times
  //    Test case that uses a struct as an argument
  //    Test case with outer loop pipelining
  //    Test case using unit with ready valid interface
  //    Test case using ready valid interface together with pipelining
  //    Test case that builds a linebuffer from LLVM
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
    tb.maxCycles = 41;
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

    cout << "Memory mapping" << endl;
    for (auto mm : hcs.memoryMapping) {
      cout << "\t" << valueString(mm.first) << " -> " << valueString(mm.second) << endl;
    }
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
    StructType* tp = StructType::create(context, "builtin_fifo_i32");

    cout << "type name = " << typeString(tp) << endl;
  }
  

}
