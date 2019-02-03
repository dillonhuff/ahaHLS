#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/Transforms/Utils/BasicBlockUtils.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace DHLS {

  class InterfaceFunctions {
  public:
    std::map<llvm::Function*, ExecutionConstraints> constraints;

    void addFunction(Function* const f) {
      constraints[f] = ExecutionConstraints();
    }

    ExecutionConstraints& getConstraints(llvm::Function* const f) {
      assert(contains_key(f, constraints));
      return constraints.find(f)->second;
    }

    bool containsFunction(llvm::Function* const f) const {
      return contains_key(f, constraints);
    }
    
  };

  void replaceValues(map<Value*, Value*>& argsToValues,
                     map<Instruction*, Instruction*>& oldInstrsToClones,
                     Instruction* const clone) {
    for (int i = 0; i < (int) clone->getNumOperands(); i++) {
      Value* opI = clone->getOperand(i);
      if (contains_key(opI, argsToValues)) {
        clone->setOperand(i, map_find(opI, argsToValues));
      } else if (Instruction::classof(opI)) {
        auto opII = dyn_cast<Instruction>(opI);
        if (contains_key(opII, oldInstrsToClones)) {
          clone->setOperand(i, map_find(opII, oldInstrsToClones));
        }
      }
    }
  }

  void inlineFunctionWithConstraints(Function* const f,
                                     ExecutionConstraints& exec,
                                     CallInst* const toInline,
                                     ExecutionConstraints& constraintsToInline) {

    cout << "Inlining " << valueString(toInline) << endl;
    cout << "# of operands = " << toInline->getNumOperands() << endl;
    
    map<Value*, Value*> argsToValues;
    Function* called = toInline->getCalledFunction();
    for (int i = 0; i < (int) toInline->getNumOperands() - 1; i++) {
      cout << "i = " << i << endl;
      cout << "Operand " << i << " = " << valueString(toInline->getOperand(i)) << endl;
      argsToValues[getArg(called, i)] = toInline->getOperand(i);
    }

    assert(called->getBasicBlockList().size() == 1);

    cout << "Built value list" << endl;
    
    map<Instruction*, Instruction*> oldInstrsToClones;
    vector<Instruction*> inlinedInstrs;
    // Inline the constraints
    Value* finalRetVal = nullptr;

    // Real procedure should be to replace all references to start(toInline),
    // end(toInline) in the receiver function with references to start(funcMarker)
    // end(funcMarker), and in the constraints internally replace all references
    // to start(ret), end(ret) with end(funcMarker)
    for (auto& bb : called->getBasicBlockList()) {
      for (auto& instr : bb) {
        if (!ReturnInst::classof(&instr)) {
          Instruction* clone = instr.clone();
          oldInstrsToClones[&instr] = clone;
          replaceValues(argsToValues, oldInstrsToClones, clone);
          clone->insertBefore(toInline);
          inlinedInstrs.push_back(clone);

        } else {

          if (instr.getNumOperands() > 0) {
            assert(instr.getNumOperands() == 1);

            Value* retVal = instr.getOperand(0);

            assert(Instruction::classof(retVal));

            finalRetVal = map_find(dyn_cast<Instruction>(retVal), oldInstrsToClones);
          }
        }
      }
    }

    // Replace the inline start and end times with marker action noops
    ExecutionAction inlineAction(toInline);
    ExecutionAction inlineMarkerAction(sanitizeFormatForVerilogId(valueString(toInline)));
    for (auto c : exec.constraints) {
      c->replaceAction(inlineAction, inlineMarkerAction);
    }

    // Require that all instructions that have been inlined finish inside
    // the inlined function start and end time
    for (auto instr : inlinedInstrs) {
      exec.addConstraint(actionStart(inlineMarkerAction) <= instrStart(instr));
      exec.addConstraint(instrEnd(instr) <= actionEnd(inlineMarkerAction));
    }

    exec.addConstraint(actionStart(inlineMarkerAction) <= actionEnd(inlineMarkerAction));
    
    if (finalRetVal != nullptr) {
      toInline->replaceAllUsesWith(finalRetVal);
      // Replace constraints on toInline
      Instruction* replacementRet = dyn_cast<Instruction>(finalRetVal);
      for (auto c : exec.constraints) {
        c->replaceInstruction(toInline, replacementRet);
      }
    }

    // Remove old call
    toInline->eraseFromParent();

    cout << "Inlining constraints" << endl;
    // Inline constraints
    // TODO: How to handle constraints on the return instruction,
    // since the return instruction is not handled?
    cout << "Iterating over constraints" << endl;
    
    for (auto c : constraintsToInline.constraints) {
      //c->replaceAction(inlineAction, inlineMarkerAction);

      if (c->type() == CONSTRAINT_TYPE_ORDERED) {
        Ordered* oc = static_cast<Ordered*>(c->clone());
        auto beforeInstr = oc->before.getInstr();
        auto afterInstr = oc->after.getInstr();        
        oc->before.replaceInstruction(beforeInstr, map_find(beforeInstr, oldInstrsToClones));
        oc->after.replaceInstruction(afterInstr, map_find(afterInstr, oldInstrsToClones));
        exec.addConstraint(oc); // Add to existing constraints
      } else {
        assert(false);
      }
    }
  }
  
  void inlineWireCalls(Function* f,
                       ExecutionConstraints& exec,
                       InterfaceFunctions& interfaces) {
    bool replaced = true;
    vector<Instruction*> reads;

    while (replaced) {
      replaced = false;

      for (auto& bb : f->getBasicBlockList()) {
        for (auto& instr : bb) {

          if (CallInst::classof(&instr)) {
            CallInst* call = dyn_cast<CallInst>(&instr);

            Function* inlineFunc = call->getCalledFunction();
            if (interfaces.containsFunction(inlineFunc)) {

              inlineFunctionWithConstraints(f, exec, call, interfaces.getConstraints(inlineFunc));
              replaced = true;
            
              break;
            }
          }
        }

        if (replaced) {
          break;
        }
      }
    }

  }


  ModuleSpec ramSpec(const int width, const int depth) {
    int addrWidth = clog2(depth);

    map<string, Port> ramPorts = {
      {"raddr_0", inputPort(addrWidth, "raddr_0")},
      {"waddr_0", inputPort(addrWidth, "waddr_0")},
      {"wdata_0", inputPort(width, "wdata_0")},
      {"wen_0", inputPort(1, "wen_0")},            
      {"rst", inputPort(1, "rst")},

      {"rdata_0", outputPort(1, "rdata_0")}
    };
    
    return {{{"WIDTH", to_string(width)}, {"DEPTH", to_string(depth)}}, "RAM", ramPorts};

  }

  ModuleSpec fifoSpec(int width, int depth) {
    map<string, Port> fifoPorts = {
      {"in_data", inputPort(width, "in_data")},
      {"read_valid", inputPort(1, "read_valid")},
      {"write_valid", inputPort(width, "write_valid")},
      {"rst", inputPort(1, "rst")},

      {"out_data", outputPort(width, "out_data")},
      {"read_ready", outputPort(1, "read_ready")},
      {"write_ready", outputPort(1, "write_ready")}
    };
    
    return {{{"WIDTH", to_string(width)}, {"DEPTH", to_string(depth)}}, "fifo", fifoPorts};
  }

  ModuleSpec wireSpec(int width) {
    map<string, Port> wirePorts = {
      {"in_data", inputPort(width, "in_data")},
      {"out_data", outputPort(width, "out_data")}};
    
    return {{{"WIDTH", to_string(width)}}, "wire", wirePorts};
  }
  
  // Q: System TODOs:
  // A: Remove useless address fields from registers (allow custom memory interfaces)
  //    Add an "I dont care about default values to this FU" option?
  //    Move test layout int testbenchspec
  //    Incorporate fifoSpecs in to scheduling constraints automatically
  //    Add some simple examples to the README
  //    Fix createFunction to return a function every time without the useless cast

  // NOTE: The code for testbenches is getting really complicated. Some of that
  // is automatic testbench generation, but some of it is just the hodgepodge of
  // different data structures for scheduling, verilog code generation, and
  // constraint generation. These really need to be fixed up.
  // Ideas?
  //  1. Merge schedule and STG creation in to one function when the schedule
  //     does not need to be checked
  //  2. Remove or wrap the function -> SchedulingConstraints map

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

  void implementRVFifoRead(llvm::Function* readFifo, ExecutionConstraints& exec) {
    auto out = getArg(readFifo, 0);

    auto tp = out->getType();
    int width = getTypeBitWidth(readFifo->getReturnType());
      
    auto eb = mkBB("entry_block", readFifo);
    IRBuilder<> b(eb);

    auto readInDataF = readPort("out_data", width, tp);
    auto readReadyF = readPort("read_ready", 1, tp);

    auto setValidF = writePort("read_valid", 1, tp);
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {out});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {out, mkInt(0, 1)});
    auto readValue = b.CreateCall(readInDataF, {out});

    b.CreateRet(readValue);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(readValue));
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));
  }

  void implementRVFifoWrite(llvm::Function* writeFifo, ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", writeFifo);
    IRBuilder<> b(eb);

    auto out = getArg(writeFifo, 1);

    auto tp = out->getType();
    int width = getValueBitWidth(getArg(writeFifo, 0));
    
    auto writeDataF = writePort("in_data", width, tp);
    auto readReadyF = readPort("write_ready", 1, tp);

    auto setValidF = writePort("write_valid", 1, tp);
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {out});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {out, mkInt(0, 1)});
    auto writeValue = b.CreateCall(writeDataF, {out, getArg(writeFifo, 0)});
      
    b.CreateRet(nullptr);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrStart(setValid1) == instrStart(writeValue));
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));
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
    hcs.modSpecs[getArg(f, 0)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 1)] = fifoSpec(width, 16);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

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
    hcs.modSpecs[getArg(f, 0)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 1)] = fifoSpec(width, 16);

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
    hcs.modSpecs[getArg(f, 0)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 1)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 2)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 3)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 4)] = fifoSpec(width, 16);            
    hcs.modSpecs[getArg(f, 5)] = fifoSpec(width, 16);

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

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
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

    //REQUIRE(graph.numControlStates() == 8);

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

    REQUIRE(runIVerilogTB("sys_array_2x2"));
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

    hcs.modSpecs[getArg(f, 0)] = fifoSpec(width, 16);
    hcs.modSpecs[getArg(f, 1)] = fifoSpec(width, 16);
    
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

  void implementWireRead(Function* readFifo) {
    int width = getTypeBitWidth(readFifo->getReturnType());
    auto tp = getArg(readFifo, 0)->getType();
    {
      auto readEntry = mkBB("entry_block", readFifo);
      IRBuilder<> eb(readEntry);
      auto rp = readPort("out_data", width, tp);
      auto readValue = eb.CreateCall(rp, {getArg(readFifo, 0)});
      eb.CreateRet(readValue);
    }

  }

  void implementWireWrite(Function* writeFifo) {
    int width = getValueBitWidth(getArg(writeFifo, 0));
    auto tp = getArg(writeFifo, 1)->getType();
    auto writeEntry = mkBB("entry_block", writeFifo);
    IRBuilder<> eb(writeEntry);
    auto wp = writePort("in_data", width, tp);
    eb.CreateCall(wp, {getArg(writeFifo, 1), getArg(writeFifo, 0)});
    eb.CreateRet(nullptr);
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
    setAllAllocaMemTypes(hcs, f, registerSpec(width));

    hcs.modSpecs[getArg(f, 0)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 1)] = wireSpec(width);

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
    setAllAllocaMemTypes(hcs, f, registerSpec(width));

    hcs.modSpecs[getArg(f, 0)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 1)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 2)] = wireSpec(width);

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
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.modSpecs[getArg(f, 0)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 1)] = wireSpec(width);    

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
      // TODO: Implement fadd and add execution constraints
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

      exec.endsBeforeStarts(rst0, rst1);

      auto wA = b.CreateCall(writeA, {fpu, a});
      auto wAStb = b.CreateCall(writeAStb, {fpu, mkInt(1, 1)});

      exec.startSameTime(rst1, wA);    
      exec.startSameTime(wA, wAStb);    

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
      exec.startsBeforeStarts(aAck, wAStb0);
      exec.addConstraint(instrStart(stallUntilAAck) == instrEnd(aAck));

      exec.startSameTime(wA, wAStb);

      exec.addConstraint(instrStart(bAck) == instrEnd(wBStb));
      exec.endsBeforeStarts(bAck, wBStb0);
      exec.addConstraint(instrStart(stallUntilBAck) == instrEnd(bAck));
      exec.startSameTime(wB, wBStb);    

      // Wait for A to be written before writing b
      exec.addConstraint(instrEnd(aAck) < instrStart(wB));

      // Wait for b to be acknowledged before reading Z
      exec.addConstraint(instrEnd(bAck) < instrStart(val));

      exec.startSameTime(val, zStb);
      exec.startSameTime(stallUntilZStb, zStb);        
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
    hcs.modSpecs[fpu] = {{}, "adder", adderPorts};
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.modSpecs[getArg(f, 0)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 1)] = wireSpec(width);
    hcs.modSpecs[getArg(f, 2)] = wireSpec(width);

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

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    //emitVerilatorBinding(graph);
    
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

  // What should the instructions be?
  // Instruction start time, instruction end time
  // Instruction has started flag and has ended flag
  // Combinational flags saying if the instruction is ending now?
  // Global clock

  class ActionTracker {
  public:
    Wire startedFlag;
    Wire endedFlag;
    Wire startTimeCounter;
    Wire endTimeCounter;
    Wire startingThisCycleFlag;
    Wire endingThisCycleFlag;
  };

  class DynArch {
    Function* f;
    ExecutionConstraints& exe;
    HardwareConstraints& hcs;

    Wire globalTime;

    std::map<ExecutionAction, ActionTracker> actionTrackers;

  public:

    std::map<llvm::Instruction*, Wire> tempStorage;
    std::vector<Wire> allWires;

    std::vector<FunctionalUnit> functionalUnits;
    std::map<llvm::Instruction*, FunctionalUnit> unitAssignment;

    Wire addReg(const int width, const std::string& name) {
      Wire w = {true, width, name};
      if (elem_by(w, allWires, [](const Wire a, const Wire b) { return a.name == b.name; })) {
        return w;
      }
                        
      allWires.push_back(w);
      return w;
    }

    Wire addWire(const int width, const std::string& name) {
      Wire w = {false, width, name};

      if (elem_by(w, allWires, [](const Wire a, const Wire b) { return a.name == b.name; })) {
        return w;
      }

      allWires.push_back(w);
      return w;
    }

    string outputName(llvm::Value* const val) {
      if (Instruction::classof(val)) {
        cout << "Value for " << valueString(val) << endl;
        Instruction* instr = dyn_cast<Instruction>(val);
        FunctionalUnit unit = map_find(instr, unitAssignment);
        string unitOut;
        if (LoadInst::classof(instr)) {
          cout << "loading rdata" << endl;
          unitOut = map_find(string("rdata_0"), unit.outWires).name;
        } else if (isBuiltinPortRead(instr)) {
          string name = getPortName(instr);
          unitOut = map_find(name, unit.outWires).name;
        } else {
          unitOut = map_find(string("out"), unit.outWires).name;
        }

        cout << "finding temp storage" << endl;
        string regOut = map_find(instr, tempStorage).name;
        return parens(couldEndFlag(instr) + " ? " + unitOut + " : " + regOut);
      } else if (Argument::classof(val)) {

        // TODO: For now assume all memory starts at 0?
        return "0";
      } else if (ConstantInt::classof(val)) {
        auto valC = dyn_cast<ConstantInt>(val);
        auto apInt = valC->getValue();

        return to_string(dyn_cast<ConstantInt>(val)->getSExtValue());
      }

      cout << "Unsupported value = " << valueString(val) << endl;
      // Value
      assert(false);
    }
    
    FunctionalUnit addFunctionalUnit(llvm::Instruction* instr) {
      map<string, string> modParams;
      string modName = instr->getOpcodeName();
      string rStr = to_string(functionalUnits.size());
      string prefix = instr->getOpcodeName() + rStr;
      string unitName = prefix + "_unit";
      map<string, Wire> inWires;
      map<string, Wire> outWires;
      bool isExternal = false;


      if (BinaryOperator::classof(instr)) {
        int w = getValueBitWidth(instr);
        Wire in0 = addReg(w, "in0_" + rStr);
        Wire in1 = addReg(w, "in1_" + rStr);
        Wire out = addWire(w, "out_" + rStr);
        inWires = {{"in0", in0}, {"in1", in1}};
        outWires = {{"out", out}};
        modParams = {{"WIDTH", to_string(w)}};
      } else if (GetElementPtrInst::classof(instr)) {
        modName += "_" + to_string(instr->getNumOperands() - 1);

        Wire baseAddr = {true, 32, "base_addr_" + rStr};
        allWires.push_back(baseAddr);
        inWires = {{"base_addr", baseAddr}};
        for (int i = 1; i < (int) instr->getNumOperands(); i++) {
          Wire offset = {true, 32, "gep_add_in" + to_string(i) + "_" + rStr};
          allWires.push_back(offset);
          inWires.insert({"in" + to_string(i), offset});
        }

        Wire outWire = {false, 32, "getelementptr_out_" + rStr};
        allWires.push_back(outWire);
        outWires = {{"out", outWire}};
        
      } else if (LoadInst::classof(instr) || StoreInst::classof(instr)) {
        modName = "external_RAM";
        unitName = "external_RAM";

        int w = 0;
        if (LoadInst::classof(instr)) {
          w = getValueBitWidth(instr);
        } else {
          w = getValueBitWidth(instr->getOperand(0));
        }
        Wire raddr = addReg(w, "raddr_0_reg");
        Wire waddr = addReg(w, "waddr_0_reg");
        Wire wdata = addReg(w, "wdata_0_reg");
        Wire wen = addReg(1, "wen_0_reg");
        Wire ren = addReg(1, "ren_0_reg");

        Wire rdata = addWire(32, "rdata_0_out");
        
        inWires = {{"raddr_0", raddr}, {"ren_0", ren}, {"waddr_0", waddr}, {"wdata_0", wdata}, {"wen_0", wen}};
        outWires = {{"rdata_0", rdata}};
      } else if (ReturnInst::classof(instr)) {

        modName = "external_RET";
        unitName = "external_RET";

        inWires = {{"valid", {true, 1, "valid"}}};
      } else if (isBuiltinPortCall(instr)) {
        auto fuPtr = instr->getOperand(0);
        assert(contains_key(fuPtr, hcs.modSpecs));

        if (Argument::classof(fuPtr)) {
          isExternal = true;
        }

        ModuleSpec modSpec = map_find(fuPtr, hcs.modSpecs);
        modName = modSpec.name;
        unitName = fuPtr->getName();

        for (auto pt : modSpec.ports) {
          if (pt.second.input()) {
            inWires.insert({pt.first, {true, pt.second.width, unitName + "_" + pt.second.name}});
          } else {
            outWires.insert({pt.first, {false, pt.second.width, unitName + "_" + pt.second.name}});            
          }
        }
        
      }

      if (LoadInst::classof(instr) ||
          StoreInst::classof(instr) ||
          ReturnInst::classof(instr)) {
        isExternal = true;
      }
      FunctionalUnit unit = {{modParams, modName}, unitName, inWires, outWires, isExternal};

      if (!elem_by(unit, functionalUnits, [](const FunctionalUnit& a, const FunctionalUnit& b) { return a.instName == b.instName; })) {
        functionalUnits.push_back(unit);
      }

      cout << "Unit name" << endl;
      for (auto unit : functionalUnits) {
        cout << tab(1) << unit.instName << endl;
      }

      return unit;
    }
    
    DynArch(Function* f_, ExecutionConstraints& exe_, HardwareConstraints& hcs_) : f(f_), exe(exe_), hcs(hcs_) {
      globalTime = {true, 32, "clocks_since_reset"};
      allWires.push_back(globalTime);
      
      int i = 0;
      for (auto& bb : f->getBasicBlockList()) {
        for (auto& instr : bb) {
          
          string prefix = sanitizeFormatForVerilogId(valueString(&instr));

          if (hasOutput(&instr)) {
            Wire tempValue = {true, getValueBitWidth(&instr), prefix + "_tmp"};
            allWires.push_back(tempValue);
            tempStorage[&instr] = tempValue;
          }

          FunctionalUnit unit = addFunctionalUnit(&instr);
          unitAssignment[&instr] = unit;

          addAction(&instr);

          i++;
        }
      }

      std::set<ExecutionAction> added;
      for (auto c : exe.constraints) {
        if (c->type() == CONSTRAINT_TYPE_ORDERED) {
          Ordered* oc = static_cast<Ordered*>(c);
          InstructionTime before = oc->before;
          if (!before.action.isInstruction() && !elem(before.action, added)) {
            added.insert(before.action);
            addAction(before.action);
          }

          InstructionTime after = oc->after;
          if (!after.action.isInstruction() && !elem(after.action, added)) {
            added.insert(after.action);
            addAction(after.action);
          }

        } else {
          assert(false);
        }
      }
    }

    void addAction(ExecutionAction action) {
      string prefix;
      if (action.isInstruction()) {
        prefix =
          sanitizeFormatForVerilogId(valueString(action.getInstruction()));
      } else {
        prefix = action.getName();
      }

      Wire si = {true, 1, prefix + "_started"};
      allWires.push_back(si);

      Wire se = {true, 1, prefix + "_finished"};
      allWires.push_back(se);          

      Wire sc = addReg(32, prefix + "_time_started");

      Wire ec = addReg(32, prefix + "_time_finished");

      Wire ssc = {false, 1, prefix + "_starting_this_cycle"};
      allWires.push_back(ssc);          
      Wire esc = {false, 1, prefix + "_done_this_cycle"};
      allWires.push_back(esc);

      actionTrackers[action] = {si, se, sc, ec, ssc, esc};
          

    }

    std::string couldStartFlag(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).startingThisCycleFlag.name;
    }

    std::string couldEndFlag(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).endingThisCycleFlag.name;      
    }

    std::string instrDoneString(ExecutionAction instr) const {
      return doneFlag(instr);
    }

    std::string instrStartString(ExecutionAction instr) const {
      return startedFlag(instr);
    }

    std::string instrEndString(ExecutionAction instr) const {
      return doneFlag(instr);
    }
    
    std::string startedFlag(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).startedFlag.name;
    }

    std::string doneFlag(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).endedFlag.name;
    }

    std::string doneTimeString(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).endTimeCounter.name;
    }

    std::string startTimeString(ExecutionAction instr) const {
      return map_find(instr, actionTrackers).startTimeCounter.name;
    }
    
    std::string globalTimeString() const {
      return globalTime.name;
    }
    
    // Time at which an instruction started or finished
    std::string instrTimeString(InstructionTime& time) const {
      string alreadyDoneTime;
      string thisCycleFlag;
      if (time.isEnd) {
        alreadyDoneTime = doneTimeString(time.getAction());
        thisCycleFlag = couldEndFlag(time.getAction());
      } else {
        alreadyDoneTime = startTimeString(time.getAction());
        thisCycleFlag = couldStartFlag(time.getAction());
      }

      // If this time is the start or end then the time of the event is
      // the current global time, otherwise it is the saved complete time
      // Result is invalid if the event is not starting
      return condStr(thisCycleFlag, globalTimeString(), alreadyDoneTime);
    }

    std::string afterTimeString(InstructionTime& time) {

      string eventHappened = atOrAfterTime(time);

      string requiredTimeElapsed = parens(parens(instrTimeString(time) + " + " + to_string(time.offset)) + " < " + globalTimeString());
      return andStr(eventHappened, requiredTimeElapsed);
    }

    std::string atOrAfterTime(InstructionTime& time) {
      string eventHappened;
      string eventHappening;
      if (time.isEnd) {
        eventHappened = doneFlag(time.getAction());
        eventHappening = couldEndFlag(time.getAction());
      } else {
        eventHappened = startedFlag(time.getAction());
        eventHappening = couldStartFlag(time.getAction());
      }

      return orStr(eventHappened, eventHappening);
    }

    std::string atTimeString(InstructionTime& time) {

      
      string eventHappened = atOrAfterTime(time);

      string requiredTimeElapsed = parens(parens(instrTimeString(time) + " + " + to_string(time.offset)) + " == " + globalTimeString());
      return andStr(eventHappened, requiredTimeElapsed);
    }

    std::string afterOrAtTimeString(InstructionTime& time) {
      return orStr(atTimeString(time), afterTimeString(time));
    }
    
    std::string constraintString(ExecutionConstraint* c) {
      assert(c->type() == CONSTRAINT_TYPE_ORDERED);
      Ordered* oc = static_cast<Ordered*>(c);
      InstructionTime before = oc->before;

      if (oc->restriction == ORDER_RESTRICTION_BEFORE) {
        return afterTimeString(before);
      } if (oc->restriction == ORDER_RESTRICTION_BEFORE_OR_SIMULTANEOUS) {
        return afterOrAtTimeString(before);
      } if (oc->restriction == ORDER_RESTRICTION_SIMULTANEOUS) {
        return atTimeString(before);
      } else {
        assert(false);
      }
    }

    std::string startInstrConstraint(Instruction* instr) {
      vector<string> rcs;
      for (auto c : exe.constraintsOnStart(instr)) {
        rcs.push_back(constraintString(c));
      }

      rcs.push_back(notStr(instrStartString(instr)));
      return separatedListString(rcs, " && ");
    }

    std::string endInstrConstraint(Instruction* instr) {
      vector<string> rcs;
      for (auto c : exe.constraintsOnEnd(instr)) {
        rcs.push_back(constraintString(c));
      }

      rcs.push_back(orStr(instrStartString(instr), couldStartFlag(instr)));
      rcs.push_back(notStr(instrEndString(instr)));
      return separatedListString(rcs, " && ");
    }
    
    Function* getFunction() const { return f; }
  };

  std::vector<Port> getPorts(DynArch& arch) {
    vector<Port> pts;
    pts.push_back(inputPort(1, "clk"));
    pts.push_back(inputPort(1, "rst"));
    // pts.push_back(outputPort(1, "valid"));

    // pts.push_back(outputPort(32, "raddr_0"));
    // pts.push_back(outputPort(1, "ren_0"));
    // pts.push_back(inputPort(32, "rdata_0"));
    // pts.push_back(outputPort(32, "waddr_0"));
    // pts.push_back(outputPort(32, "wdata_0"));
    // pts.push_back(outputPort(1, "wen_0"));

    for (auto unit : arch.functionalUnits) {
      if (unit.isExternal()) {
        for (auto w : unit.portWires) {
          Port pt = wireToOutputPort(w.second);
          pt.registered = true;
          pts.push_back(pt);
        }

        for (auto w : unit.outWires) {
          pts.push_back(wireToInputPort(w.second));
        }
      }
    }

    return pts;
  }

  void emitVerilog(std::ostream& out, DynArch& arch) {
    vector<Port> pts = getPorts(arch);

    VerilogComponents comps;
    for (auto w : arch.allWires) {
      comps.debugWires.push_back(w);
    }
    // Adding module instances      

    for (auto unit : arch.functionalUnits) {
      map<string, string> wireConns;
      for (auto w : unit.portWires) {
        wireConns.insert({w.first, w.second.name});
      }

      // TODO: Put sequential vs combinational distincion in module description
      if ((unit.getModName() == "RAM") ||
          (unit.getModName() == "register") ||
          (unit.getModName() == "adder")) {
        wireConns.insert({"clk", "clk"});
        wireConns.insert({"rst", "rst"});
      }

      if (unit.getModName() == "fadd") {
        wireConns.insert({"clk", "clk"});
      }

      string modName = unit.getModName();
      auto params = unit.getParams();
      string instName = unit.instName;

      for (auto w : unit.outWires) {
        wireConns.insert({w.first, w.second.name});
      }

      ModuleInstance inst = {modName, params, instName, wireConns};

      if (!unit.isExternal()) {
        comps.instances.push_back(inst);
      } else {
        // for (auto w : unit.portWires) {
        //   comps.debugAssigns.push_back({w.second.name, w.second.name + "_reg"});
        // }

        // for (auto w : unit.outWires) {
        //   comps.debugAssigns.push_back({w.second.name, w.first});
        // }

      }
    }
    // Done adding module instances

    addAlwaysBlock({"clk"}, "if (rst) begin " + arch.globalTimeString() + " <= 0; end", comps);
    addAlwaysBlock({"clk"}, "if (!rst) begin " + arch.globalTimeString() + " <= " + arch.globalTimeString() + " + 1; end", comps);
    
    for (auto& bb : arch.getFunction()->getBasicBlockList()) {
      for (auto& instr : bb) {

        // Instruction start / end in cycle flag
        comps.debugAssigns.push_back({arch.couldStartFlag(&instr), arch.startInstrConstraint(&instr)});
        comps.debugAssigns.push_back({arch.couldEndFlag(&instr), arch.endInstrConstraint(&instr)});

        // Reset behavior
        addAlwaysBlock({"clk"}, "if (rst) begin " + arch.startedFlag(&instr) + " <= 0; end", comps);
        addAlwaysBlock({"clk"}, "if (rst) begin " + arch.doneFlag(&instr) + " <= 0; end", comps);        

        addAlwaysBlock({"clk"}, "if (" + arch.couldStartFlag(&instr) + ") begin " + arch.startedFlag(&instr) + " <= 1; end", comps);
        addAlwaysBlock({"clk"}, "if (" + arch.couldEndFlag(&instr) + ") begin " + arch.doneFlag(&instr) + " <= 1; end", comps);

        // Set completion times
        addAlwaysBlock({"clk"}, "if (" + arch.couldStartFlag(&instr) + ") begin " + arch.startTimeString(&instr) + " <= " + arch.globalTimeString() + "; end", comps);
        addAlwaysBlock({"clk"}, "if (" + arch.couldEndFlag(&instr) + ") begin " + arch.doneTimeString(&instr) + " <= " + arch.globalTimeString() + "; end", comps);

        // Debug printouts, TODO: Move these to separate debug function
        addAlwaysBlock({"clk"}, "if (" + arch.couldStartFlag(&instr) + ") begin $display(\"Starting " + sanitizeFormatForVerilog(valueString(&instr)) + " at cycle %d\", " + arch.globalTimeString() + "); end", comps);
        addAlwaysBlock({"clk"}, "if (" + arch.couldEndFlag(&instr) + ") begin $display(\"Ending " + sanitizeFormatForVerilog(valueString(&instr)) + " at cycle %d\", " + arch.globalTimeString() + "); end", comps);
        // End debug printouts
        
        // Actually execute instructions, should move this to another function?
        FunctionalUnit unit = map_find(&instr, arch.unitAssignment);
        string portSetting = "";
        string resultValue = "";

        if (BinaryOperator::classof(&instr)) {
          portSetting += unit.portWires["in0"].name + " = " + arch.outputName(instr.getOperand(0)) + "; ";
          portSetting += unit.portWires["in1"].name + " = " + arch.outputName(instr.getOperand(1)) + "; ";
          resultValue = unit.outWires["out"].name;
        } else if (GetElementPtrInst::classof(&instr)) {
          portSetting += unit.portWires["base_addr"].name + " = " + arch.outputName(instr.getOperand(0)) + "; ";
          for (int i = 1; i < (int) instr.getNumOperands(); i++) {
            portSetting += unit.portWires["in" + to_string(i)].name + " = " + arch.outputName(instr.getOperand(i)) + ";";

          }

          resultValue = unit.outWires["out"].name;
        } else if (LoadInst::classof(&instr)) {
          portSetting += unit.portWires["raddr_0"].name + " = " + arch.outputName(instr.getOperand(0)) + "; ";
          portSetting += unit.portWires["ren_0"].name + " = 1;";

          resultValue = unit.outWires["rdata_0"].name;
        } else if (StoreInst::classof(&instr)) {
          portSetting += unit.portWires["waddr_0"].name + " = " + arch.outputName(instr.getOperand(1)) + "; ";
          portSetting += unit.portWires["wdata_0"].name + " = " + arch.outputName(instr.getOperand(0)) + "; ";
          portSetting += unit.portWires["wen_0"].name + " = 1;";
        } else if (ReturnInst::classof(&instr)) {
          portSetting += unit.portWires["valid"].name + " = 1;";          
        } else if (isBuiltinPortRead(&instr)) {
          string portName = getPortName(&instr);
          resultValue = unit.outWires[portName].name;          
        } else if (isBuiltinPortWrite(&instr)) {
          string portName = getPortName(&instr);          
          portSetting += unit.portWires[portName].name + " = " + arch.outputName(instr.getOperand(1)) + "; ";
        }

        addAlwaysBlock({}, "if (" + arch.couldStartFlag(&instr) + ") begin " + portSetting + " end", comps);

        // Store results to temporaries
        if (hasOutput(&instr)) {
          addAlwaysBlock({"clk"}, "if (" + arch.couldEndFlag(&instr) + ") begin " + map_find(&instr, arch.tempStorage).name + " <= " + resultValue + "; end", comps);
        }
        
        
      }
    }

    emitModule(out, string(arch.getFunction()->getName()), pts, comps);
  }

  TEST_CASE("Constraint free out of order microarchitecture") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("dynamic arch", context);

    std::vector<Type *> inputs{Type::getInt32Ty(context)->getPointerTo()};

    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "dynamic_arch", mod.get());

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
    auto st = storeVal(builder, getArg(srUser, 0), zero, plus);
    auto ret = builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    ExecutionConstraints exec;
    addDataConstraints(srUser, exec);

    // Control time dependencies
    exec.add(instrStart(ldA) + 1 == instrEnd(ldA));
    exec.add(instrStart(plus) == instrEnd(plus));
    exec.add(instrStart(st) + 3 == instrEnd(st));
    exec.add(instrStart(ret) == instrEnd(ret));

    // Create architecture that respects these constraints
    HardwareConstraints hcs;    
    DynArch arch(srUser, exec, hcs);

    // Move result
    ofstream out(string(arch.getFunction()->getName()) + ".v");
    emitVerilog(out, arch);
    out.close();

    REQUIRE(runIVerilogTB("dynamic_arch"));
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
    Function* ramRead0 = mkFunc({sramTp, intType(addrWidth)}, intType(width), "read0");
    interfaces.addFunction(ramRead0);
    {
      ExecutionConstraints& exec = interfaces.getConstraints(ramRead0);
      auto waddr0F = writePort("raddr_0", addrWidth, sramTp);
      auto rdata0F = readPort("rdata_0", width, sramTp);

      auto sram = getArg(ramRead0, 0);
      auto addr = getArg(ramRead0, 1);
      
      auto bb = mkBB("entry_block", ramRead0);
      IRBuilder<> eb(bb);
      auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
      auto readData = eb.CreateCall(rdata0F, {sram});
      eb.CreateRet(readData);

      exec.add(instrStart(setAddr) + 1 == instrStart(readData));
      //addDataConstraints(ramRead0, exec);
    }
    Function* ramWrite0 = mkFunc({sramTp, intType(addrWidth), intType(width)}, voidType(), "write0");
    interfaces.addFunction(ramWrite0);
    {
      auto exec = interfaces.getConstraints(ramWrite0);
      auto waddr0F = writePort("waddr_0", addrWidth, sramTp);
      auto wdata0F = writePort("wdata_0", width, sramTp);
      auto wen0F = writePort("wen_0", 1, sramTp);

      auto sram = getArg(ramWrite0, 0);
      auto addr = getArg(ramWrite0, 1);
      auto data = getArg(ramWrite0, 2);

      auto bb = mkBB("entry_block", ramWrite0);
      IRBuilder<> eb(bb);
      auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
      auto setData = eb.CreateCall(wdata0F, {sram, data});
      auto setEn1 = eb.CreateCall(wen0F, {sram, mkInt(1, 1)});
      auto setEn0 = eb.CreateCall(wen0F, {sram, mkInt(0, 1)});
      eb.CreateRet(nullptr);

      exec.add(instrStart(setAddr) == instrStart(setData));
      exec.add(instrStart(setAddr) == instrStart(setEn1));

      exec.add(instrEnd(setEn1) + 1 == instrStart(setEn0));
      //addDataConstraints(ramWrite0, exec);
    }
  

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
    addDataConstraints(srUser, exec);

    // Control time dependencies
    exec.add(instrStart(ldA) + 1 == instrEnd(ldA));
    exec.add(instrStart(plus) == instrEnd(plus));
    exec.add(instrStart(st) + 3 == instrEnd(st));
    exec.add(instrStart(ret) == instrEnd(ret));

    inlineWireCalls(srUser, exec, interfaces);

    cout << "LLVM Function after inlining" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs;
    hcs.modSpecs[getArg(srUser, 0)] = ramSpec(width, depth);
    // Create architecture that respects these constraints
    DynArch arch(srUser, exec, hcs);

    // Move result
    ofstream out(string(arch.getFunction()->getName()) + ".v");
    emitVerilog(out, arch);
    out.close();

    REQUIRE(runIVerilogTB("dynamic_arch_sram_class"));
    
  }
  
}
