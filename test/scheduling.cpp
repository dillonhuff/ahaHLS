#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "algorithm.h"

#include "scheduling.h"

#include <fstream>

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

#include "llvm/ADT/STLExtras.h"
#include "llvm/Option/OptTable.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/Signals.h"
#include "llvm/Support/TargetSelect.h"

#include <iostream>

using namespace dbhc;
using namespace llvm;
using namespace std;

LLVMContext context;

namespace DHLS {

  void createLLFile(const std::string& moduleName) {
    system(("clang -O1 -c -S -emit-llvm " + moduleName + ".c -o " + moduleName + ".ll").c_str());
  }

  class FSMState {
  };

  class FSMCondition {
  };

  typedef int NodeId;
  
  class FSMEdge {
  public:
    NodeId dst;
    FSMCondition cond;
  };


  class LowFSM {

    NodeId nextNode;
    NodeId startState;
    std::map<NodeId, FSMState> states;
    std::map<NodeId, std::vector<FSMEdge> > receivers;

  public:

    LowFSM() : nextNode(1) {}

    NodeId addState(const FSMState& st) {
      NodeId id = nextNode;
      nextNode++;
      states.insert({id, st});

      receivers[id] = {};
      return id;
    }

    void setStartState(const NodeId id) {
      assert(contains_key(id, states));
      startState = id;
    }

    void addEdge(const NodeId src, const NodeId dst, const FSMCondition cond) {
      map_insert(receivers, src, {dst, cond});
    }

    std::set<NodeId> getNodeIds() const {
      std::set<NodeId> ids;
      for (auto s : states) {
        ids.insert(s.first);
      }
      return ids;
    }

    NodeId startStateId() const {
      return startState;
    }

    std::vector<FSMEdge> getReceivers(const NodeId id) const {
      return map_find(id, receivers);
    }
  };

  void emitVerilog(const std::string& moduleName, const LowFSM& fsm) {
    ofstream out(moduleName + ".v");
    out << "module " << moduleName << "(input clk, input rst)" << endl;

    out << "\treg [31:0] current_state;" << endl;
    out << "\talways @(negedge rst) begin" << endl;
    out << "\t\tcurrent_state <= " << fsm.startStateId() << ";" << endl;
    out << "\tend" << endl;

    out << "\talways @(posedge clk) begin" << endl;
    for (auto nodeId : fsm.getNodeIds()) {
      out << "\t\t// Code for state " << nodeId << endl;
      out << "\t\tif (current_state == " << nodeId << ") begin" << endl;
      for (auto rc : fsm.getReceivers(nodeId)) {
        out << "\t\t\t" << "current_state <= " << rc.dst << ";" << endl;
      }
      out << "\t\tend" << endl;
    }
    out << "\tend" << endl;

    out << "endmodule" << endl;
    
    out.close();
  }

  TEST_CASE("Schedule a single store operation") {
    createLLFile("./test/ll_files/single_store");    

    SMDiagnostic Err;
    LLVMContext Context;

    string modFile = "./test/ll_files/single_store.ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);

    Function* f = Mod->getFunction("single_store");    
    Schedule s = scheduleFunction(f, hcs);

    REQUIRE(s.clockTicksToFinish() == 3);

  }

  TEST_CASE("Parse a tiny C program") {
    createLLFile("./test/ll_files/tiny_test");

    SMDiagnostic Err;
    LLVMContext Context;

    string modFile = "./test/ll_files/tiny_test.ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    outs() << "--All functions\n";
    for (auto& f : Mod->functions()) {
      outs() << "\t" << f.getName() << "\n";
    }

    Function* f = Mod->getFunction("foo");
    assert(f != nullptr);

    LowFSM programState;

    map<BasicBlock*, NodeId> bbIds;

    cout << "Basic blocks in main" << endl;
    for (auto& bb : f->getBasicBlockList()) {
      NodeId id = programState.addState({});

      bbIds.insert({&bb, id});

      outs() << "----- BASIC BLOCK" << "\n";
      outs() << bb << "\n";
      outs() << "Terminator for this block" << "\n";
    }

    for (auto& bb : f->getBasicBlockList()) {
      assert(contains_key(&bb, bbIds));
      
      auto termInst = bb.getTerminator();
      outs() << bb.getTerminator()->getOpcode() << "\n";
      if (BranchInst::classof(termInst)) {
        outs() << "\t\tIs a branch" << "\n";
      } else {
        outs() << "\t\tNOT branch" << "\n";
      }

      if (termInst->getNumSuccessors() == 1) {
        for (auto* nextBB : termInst->successors()) {
          assert(contains_key(nextBB, bbIds));

          programState.addEdge(map_find(&bb, bbIds),
                               map_find(nextBB, bbIds), {});
        }
      } else if (termInst->getNumSuccessors() == 0) {
        programState.addEdge(map_find(&bb, bbIds),
                             map_find(&bb, bbIds), {});
      }

    }

    auto& bb = f->getEntryBlock();
    assert(contains_key(&bb, bbIds));

    programState.setStartState(map_find(&bb, bbIds));

    emitVerilog("tiny_test", programState);
  }

}
