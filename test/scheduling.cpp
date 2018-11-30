#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "algorithm.h"

#include "scheduling.h"
#include "verilog_backend.h"

#include <fstream>

//#include <polly/ScopDetection.h>

#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include <llvm/Support/TargetSelect.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/IR/Module.h>
#include <llvm/IRReader/IRReader.h>
#include <llvm/Bitcode/BitcodeReader.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/Support/SourceMgr.h>

#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Pass.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/PassManager.h>
#include <llvm/IR/LegacyPassManager.h>

#include <llvm/Passes/PassBuilder.h>
#include <llvm/Transforms/InstCombine/InstCombine.h>

#include "llvm/ADT/STLExtras.h"
#include "llvm/Option/OptTable.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/TargetSelect.h"

#include <iostream>

using namespace dbhc;
//using namespace polly;
using namespace llvm;
using namespace std;

namespace DHLS {

  void createLLFile(const std::string& moduleName) {
    system(("clang -O1 -c -S -emit-llvm " + moduleName + ".c -o " + moduleName + ".ll").c_str());
  }

  std::unique_ptr<Module> loadModule(LLVMContext& Context,
                                     SMDiagnostic& Err,
                                     const std::string& name) {
    createLLFile("./test/ll_files/" + name);    
    string modFile = "./test/ll_files/" + name + ".ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    return Mod;
  }

  bool runCmd(const std::string& cmd) {
    cout << "Running command: " << cmd << endl;
    bool res = system(cmd.c_str());
    return res == 0;
  }

  bool runIVerilogTB(const std::string& moduleName) {
    string mainName = moduleName + "_tb.v";
    string modFile = moduleName + ".v";

    string genCmd = "iverilog -g2005-sv -o " + moduleName + " " + mainName + " " + modFile + " RAM.v RAM2.v RAM3.v delay.v builtins.v";
    bool compiled = runCmd(genCmd);

    if (!compiled) {
      return false;
    }

    string resFile = moduleName + "_tb_result.txt";
    string exeCmd = "./" + moduleName + " > " + resFile;
    bool ran = runCmd(exeCmd);

    assert(ran);

    ifstream res(resFile);
    std::string str((std::istreambuf_iterator<char>(res)),
                    std::istreambuf_iterator<char>());

    cout << "str = " << str << endl;
    
    //runCmd("rm -f " + resFile);

    reverse(begin(str), end(str));
    string lastLine;

    bool secondLine = false;
    for (int i = 1; i < str.size(); i++) {
      if (str[i] == '\n') {
        break;
      }

      lastLine += str[i];
    }

    reverse(begin(lastLine), end(lastLine));

    cout << "Lastline = " << lastLine << endl;
    return lastLine == "Passed";
  }
  
  TEST_CASE("Schedule a single store operation") {
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "single_store");

    Function* f = Mod->getFunction("single_store");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    map<string, int> layout = {{"a", 0}};

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

    auto& retInstr = f->getBasicBlockList().back().back();

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 5);

    map<string, int> layout = {{"a", 0}, {"b", 3}, {"c", 4}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("plus"));
  }

  // Q: What is the logical tension between software representations
  // and hardware memory architectures?
  // A: 1. Conventional software is designed around the assumption
  //       that cache already exists and is operating silently in
  //       the background
  //    2. Software assumes unlimited resources (ports, memory)
  //    3. Software uses a simple, imperative timing model
  //    4. When people write software they only really write the
  //       "steady state" behavior of a loop

  // You can encapsulate the logic of a memory like a linebuffer inside
  // a class and then write things like they are software, but the structure
  // of the loop where you use the linebuffer may force the creation of additional
  // control logic that is not encapsulated in the linebufer black-box class.

  // Q: I guess you have to add stalls between accesses?
  // Q: What if the user accesses multiple times?
  // Q: What if the data structure is instantiated inside a loop,
  //    and has to be cleared or reset many times?
  // Q: How do you do the warmup for a customized memory?
  // Q: How do you express what the source port of the linebuffer is?

  // I think you would have explicit load and store to buffer instructions?
  // but then the user has to prime the buffer by pre-loading? That is a big
  // question. I guess the ideal is that the user just says when he wants to
  // read and the compiler infers where write locations have to happen?

  // Box touched algorithm?

  // NOTE: The small addition of verilog injection tools really helped with
  // debugging that failing memory test case. I really ought to devise a better
  // memory checking testbench. What would the components of that test bench be?
  //   1. RAM generator that can emit verilog modules for the desired RAM type
  //   2. Testbench generator that can set initial RAM values, run the HLS verilog
  //      and then write out the results
  //   3. Output stage of testbench that can read through the entire output
  //      memory and check its contents

  // Q: What test cases do I need?
  // A: Test case that uses 16 (or other not 32 bit) width (parametric builtins)
  //    Test case that uses inner and outer loops
  //    Test that uses a loop with II != 1
  //    Test that mixes memory accesses and loop pipelining
  //    Test that uses multiple different RAM types
  //    Test that uses stack allocated variables as registers
  //    Later: Test case that can use AXI and variable arrival time inputs
  //    Test that uses limited numbers of memory read/write ports
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

    auto& retInstr = f->getBasicBlockList().back().back();

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    map<string, int> layout = {{"a", 0}, {"b", 3}, {"c", 4}};
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
    map<string, int> layout = {{"a", 0}, {"b", 3}};
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

    auto& retInstr = f->getBasicBlockList().back().back();

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"a", 0}, {"b", 10}};
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
    hcs.setCount(ADD_OP, 1);

    Function* f = Mod->getFunction("many_adds");
    Schedule s = scheduleFunction(f, hcs);

    auto& retInstr = f->getBasicBlockList().back().back();

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

    map<string, int> layout = {{"a", 0}, {"b", 1}, {"c", 2}, {"d", 3}};
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

    auto& retInstr = f->getBasicBlockList().back().back();

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    map<string, int> layout = {{"a", 0}, {"b", 1}, {"c", 2}};
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

              //Schedule s = schedulePipeline(&bb, hcs);

            }
          }
        }
      }
    }

    // Q: How should I incorporate this into standard scheduling?
    // A: 1. Isolate the looped block during constraint creation
    //    2. During scheduling do not consider its constraints directly
    //    3. Need to check somewhere that the loop condition happens
    //       in the first cycle of the pipeline, otherwise speculative
    //       execution will be needed
    //    4. During RTL synthesis I'll need to add sub-states for the
    //       pipeline schedule including:
    //         4.1 Initiation interval counter
    //         4.2 Valid signal for each stage of the pipeline
    //         4.3 ?? A completed signal? Or can I infer that from valid
    //             signals?

    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    
    map<string, int> layout = {{"a", 0}, {"b", 10}};
    emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  // Problem: With updated value of last_BB this test fails with incorrect data on
  // output.
  // HYP: The problem is that each stage of the pipeline needs its own last_BB state
  // in order to get the next action (fill stage 0 or not) and next index variable
  // value correct. The default basic block is overriding the normal pipeline
  // basic block structure and setting the last basic block to always be 0

  // Q: If this really is the problem, what is the fix for it?
  // A: Add pipeline variables that store the last basic block for each stage
  // and add control logic to update each one each cycle, and add control
  // logic to set the last_BB variable used in the rest of the generated code
  // so that the state of the system is correct when the pipeline completes.

  // Psychologically Im a bit blocked on how to do this. Problems:
  //  1. Im exhausted and on an airplane after two days of traveling
  //  2. The code to emit pipelines is a mess with lots of hacked
  //     together code that spits out text
  //  3. The code that emits the non-pipelined code is also messy, and is
  //     partially separate from the code for the pipelined portions of
  //     the design

  // One way of phrasing the problem is that the data structure that represents
  // how the last basic block is checked in each instruction is hidden in the
  // mass of text-generating code.

  // Need a few things:
  //  1. Mapping from instruction instance
  //     to the basic block variable tracking register
  //     that they should use.
  //  2. Chaining code to update pipeline basic block tracking registers
  //  3. Code to set the stage_0 basic block TR depending on whether we are
  //     entering the pipeline or already in it
  //  4. Code to set the last basic block TR for non-pipelined code correctly on
  //     exit from the pipeline

  // Note: Maybe there should be a current_BB and last_BB variable?
  // Also: I may be able to fix this problem just by merging the pipelined code
  // generation with non-pipelined instruction code generation.

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
    
    map<string, int> layout = {{"a", 0}, {"b", 10}};

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
    
    map<string, int> layout = {{"a", 0}, {"b", 10}};
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
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"a", 0}, {"b", 10}};

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});    

    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.debugAssigns.push_back({"wdata_temp_reg_dbg", "wdata_temp_reg"});

    info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    // Change this to check instruction input values
    // addAssert("num_clocks_after_reset !== 1 || waddr_temp_reg === 0", info);
    // addAssert("num_clocks_after_reset !== 1 || wdata_temp_reg === 5", info);
    // addAssert("num_clocks_after_reset !== 1 || wen_temp_reg === 1", info);        
    // addAssert("num_clocks_after_reset !== 1 || add_out_10 === rdata_0 + 4", info);
    // addAssert("num_clocks_after_reset !== 1 || add_in0_10 === 1", info);

    // addAssert("num_clocks_after_reset !== 6 || waddr_temp_reg === 1", info);
    // addAssert("num_clocks_after_reset !== 6 || add_out_10 === rdata_0 + 4", info);
    // addAssert("num_clocks_after_reset !== 6 || add_in0_10 === 2", info);

    // addAssert("num_clocks_after_reset !== 11 || waddr_temp_reg === 2", info);
    // addAssert("num_clocks_after_reset !== 11 || add_out_10 === rdata_0 + 4", info);
    // addAssert("num_clocks_after_reset !== 11 || add_in0_10 === 3", info);

    // addAssert("num_clocks_after_reset !== 11 || raddr_temp_reg === 0", info);

    // addAssert("global_state !== 5 || rdata_temp === 5", info);    
    // addAssert("global_state !== 5 || add_out_16 === 17", info);

    // addAlwaysBlock({"clk"}, "if (num_clocks_after_reset == 11) begin $display(\"add_in0_10 == %d\", add_in0_10); end", info);

    // // Assert that the value stored to temp[N - 1] is 17
    // addAlwaysBlock({"clk"}, "if (global_state == 5) begin $display(\"add_out_16 == %d\", add_out_16); end", info);

    emitVerilog(f, graph, layout, info);

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

    map<string, int> layout = {{"a", 0}, {"b", 8}};
    VerilogDebugInfo info;
    // info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    // info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});

    // info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    // info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    // addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    // addAssert("num_clocks_after_reset !== 1 || waddr_0_reg === 8", info);
    // addAssert("num_clocks_after_reset !== 1 || wen_0_reg === 1", info);        

    emitVerilog(f, graph, layout, info);

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
    emitVerilogTestBench(tb, layout);

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

    map<string, int> layout = {{"a", 0}, {"b", 8}};

    // Idea: Check in assertions that write data never has an x when write
    // enable is high
    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});

    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    addWirePrintoutIf("num_clocks_after_reset == 2", "wdata_0_reg", info);
    // addWirePrintout("phi_in0_13", info);
    // addWirePrintout("phi_in1_13", info);
    // addWirePrintout("phi_out_13", info);
    // addWirePrintout("last_BB_reg", info);
    // addWirePrintout("wdata_0_reg", info);

    // Still wrong after correcting transitions?

    addAssert("num_clocks_after_reset !== 2 || waddr_0_reg === 8", info);
    addAssert("num_clocks_after_reset !== 2 || wen_0_reg === 1", info);
    //addAssert("num_clocks_after_reset !== 2 || wdata_0_reg === 3", info);

    emitVerilog(f, graph, layout, info);

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
    tb.name = "blur_lb";
    emitVerilogTestBench(tb, layout);

    //REQUIRE(runIVerilogTB("blur_lb"));
    
  }
  
  // struct Hello : public FunctionPass {
  //   static char ID;
  //   Hello() : FunctionPass(ID) {}

  //   bool runOnFunction(Function &F) override {
  //     errs() << "Hello: ";
  //     errs().write_escaped(F.getName()) << '\n';
  //     return true;
  //   }
  // }; // end of struct Hello  

  // char Hello::ID = 0;
  // static RegisterPass<Hello> X("hello", "Hello World Pass",
  //                              false /* Only looks at CFG */,
  //                              false /* Analysis Pass */);
  
  // struct PipelineSched : public FunctionPass {
  //   static char ID;
  //   PipelineSched() : FunctionPass(ID) {}

  //   void getAnalysisUsage(AnalysisUsage& AU) const override {
  //     AU.addRequired<ScalarEvolutionWrapperPass>();
  //     AU.addRequired<AAResultsWrapperPass>();
  //     //AU.addRequired<ScopDetectionWrapperPass>();
  //   }

  //   bool runOnFunction(Function &F) override {
  //     errs() << "PipelineSched: ";
  //     errs().write_escaped(F.getName()) << '\n';
  //     return true;
  //   }
  // }; // end of struct PipelineSched  
  
  // char PipelineSched::ID = 0;
  // static RegisterPass<PipelineSched>
  // PipeSched("pipelinesched", "PipelineSched World Pass",
  //           false /* Only looks at CFG */,
  //           false /* Analysis Pass */);
  
  // TEST_CASE("LLVM running pass on single store") {

  //   SMDiagnostic Err;
  //   LLVMContext Context;
  //   std::unique_ptr<Module> Mod = loadModule(Context, Err, "single_store");

  //   Function* f = Mod->getFunction("single_store");

  //   llvm::legacy::PassManager pm;
  //   auto nh = new Hello();
  //   auto ps = new PipelineSched();    
  //   pm.add(nh);
  //   pm.add(ps);

  //   pm.run(*Mod);

  // }
  
}
