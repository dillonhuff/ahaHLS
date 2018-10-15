#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "algorithm.h"

#include "scheduling.h"
#include "verilog_backend.h"

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

  bool runCmd(const std::string& cmd) {
    cout << "Running command: " << cmd << endl;
    bool res = system(cmd.c_str());
    return res == 0;
  }

  bool runIVerilogTB(const std::string& moduleName) {
    string mainName = moduleName + "_tb.v";
    string modFile = moduleName + ".v";

    string genCmd = "iverilog -g2005-sv -o " + moduleName + " " + mainName + " " + modFile + " RAM.v delay.v";
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
    
    runCmd("rm -f " + resFile);

    return str == "Passed\n";
  }
  
  void createLLFile(const std::string& moduleName) {
    system(("clang -O1 -c -S -emit-llvm " + moduleName + ".c -o " + moduleName + ".ll").c_str());
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

    auto& retInstr = f->getBasicBlockList().back().back();
    //cout << "Retinstr = " << retInstr << endl;
    REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    // Now we should emit verilog.
    // I don't really understand the interaction between edge transitions in CDFG,
    // edge transitions in the STG, registers and wires in final verilog. Also
    // I dont really understand the meaning of repeatedly going to the same state if
    // there is more than one instruction there. What does staying in state 3 mean
    // if the end of the store instruction is there and the return instruction
    // is there? I guess the completion of the store would not be executed.
    // Maybe that is where guard conditions come in to play. The store is guarded
    // by a condition that guarantees that it only executes when you reached
    // state 3 from state 2

    // Note: The condition that you got to state 3 from state 2 is really a
    // description of what happened in the past. When you reach state 3 from
    // state 2 that means that a store instruction that started in state 0 is
    // just now finishing. When you reach state 3 from state 3

    emitVerilog(f, graph);

    REQUIRE(runIVerilogTB("single_store"));
  }

  TEST_CASE("Adding two numbers and storing them back") {
    createLLFile("./test/ll_files/plus");    

    SMDiagnostic Err;
    LLVMContext Context;

    string modFile = "./test/ll_files/plus.ll";
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);    
    hcs.setLatency(ADD_OP, 0);

    Function* f = Mod->getFunction("plus");
    Schedule s = scheduleFunction(f, hcs);

    REQUIRE(s.clockTicksToFinish() == 4);

    auto& retInstr = f->getBasicBlockList().back().back();
    //REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    emitVerilog(f, graph);

    REQUIRE(runIVerilogTB("plus"));
    
  }

  // TEST_CASE("Parse a tiny C program") {
  //   createLLFile("./test/ll_files/tiny_test");

  //   SMDiagnostic Err;
  //   LLVMContext Context;

  //   string modFile = "./test/ll_files/tiny_test.ll";
  //   std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
  //   if (!Mod) {
  //     outs() << "Error: No mod\n";
  //     assert(false);
  //   }

  //   outs() << "--All functions\n";
  //   for (auto& f : Mod->functions()) {
  //     outs() << "\t" << f.getName() << "\n";
  //   }

  //   Function* f = Mod->getFunction("foo");
  //   assert(f != nullptr);

  //   LowFSM programState;

  //   map<BasicBlock*, NodeId> bbIds;

  //   cout << "Basic blocks in main" << endl;
  //   for (auto& bb : f->getBasicBlockList()) {
  //     NodeId id = programState.addState({});

  //     bbIds.insert({&bb, id});

  //     outs() << "----- BASIC BLOCK" << "\n";
  //     outs() << bb << "\n";
  //     outs() << "Terminator for this block" << "\n";
  //   }

  //   for (auto& bb : f->getBasicBlockList()) {
  //     assert(contains_key(&bb, bbIds));
      
  //     auto termInst = bb.getTerminator();
  //     outs() << bb.getTerminator()->getOpcode() << "\n";
  //     if (BranchInst::classof(termInst)) {
  //       outs() << "\t\tIs a branch" << "\n";
  //     } else {
  //       outs() << "\t\tNOT branch" << "\n";
  //     }

  //     if (termInst->getNumSuccessors() == 1) {
  //       for (auto* nextBB : termInst->successors()) {
  //         assert(contains_key(nextBB, bbIds));

  //         programState.addEdge(map_find(&bb, bbIds),
  //                              map_find(nextBB, bbIds), {});
  //       }
  //     } else if (termInst->getNumSuccessors() == 0) {
  //       programState.addEdge(map_find(&bb, bbIds),
  //                            map_find(&bb, bbIds), {});
  //     }

  //   }

  //   auto& bb = f->getEntryBlock();
  //   assert(contains_key(&bb, bbIds));

  //   programState.setStartState(map_find(&bb, bbIds));

  //   emitVerilog("tiny_test", programState);
  // }

}
