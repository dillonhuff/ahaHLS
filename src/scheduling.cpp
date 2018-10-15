#include "scheduling.h"

#include "z3++.h"

#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace DHLS {

  expr blockSource(BasicBlock* const bb,
                   const map<BasicBlock*, vector<expr> >& vars) {
    return map_find(bb, vars).front();
  }

  expr blockSink(BasicBlock* const bb,
                 const map<BasicBlock*, vector<expr> >& vars) {
    return map_find(bb, vars).back();
  }

  int getLatency(Instruction* iptr, HardwareConstraints& hdc) {
    int latency;
    if (ReturnInst::classof(iptr)) {
      latency = 0;
    } else if (StoreInst::classof(iptr)) {
      latency = hdc.getLatency(STORE_OP);
    } else if (LoadInst::classof(iptr)) {
      latency = hdc.getLatency(LOAD_OP);
    } else if (BinaryOperator::classof(iptr)) {
      auto opCode = iptr->getOpcode();
      if (opCode == Instruction::Add) {
        // auto op0 = iptr->getOperand(0);
        // assert(Instruction::classof(op0));

        latency = hdc.getLatency(ADD_OP);

      } else {
        assert(false);
      }
    } else {

      std::string str;
      llvm::raw_string_ostream ss(str);
      ss << *iptr;
      cout << "Error: Unsupported instruction type " << ss.str() << std::endl;

      assert(false);
    }

    return latency;
  }

  Schedule buildFromModel(model& m,
                          map<Instruction*, vector<expr> >& schedVars,
                          map<BasicBlock*, vector<expr> >& blockVars) {

    cout << "Final schedule" << endl;
    Schedule sched;
    
    for (auto blk : blockVars) {
      auto srcExpr = blk.second.front();
      auto snkExpr = blk.second.back();

      map_insert(sched.blockTimes, blk.first, (int) m.eval(srcExpr).get_numeral_int64());
      map_insert(sched.blockTimes, blk.first, (int) m.eval(snkExpr).get_numeral_int64());
      cout << srcExpr << " = " << m.eval(srcExpr) << endl;
      cout << snkExpr << " = " << m.eval(snkExpr) << endl;
    }

    for (auto v : schedVars) {
      for (auto ex : v.second) {
        map_insert(sched.instrTimes, v.first, (int) m.eval(ex).get_numeral_int64());
        cout << ex << " = " << m.eval(ex) << endl;
      }
    }
    
    return sched;

    return sched;
  }

  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc) {
    // Now need to: Create a Z3 context that can take in scheduling variables
    // and compute values for them

    map<Instruction*, vector<expr> > schedVars;
    map<BasicBlock*, vector<expr> > blockVars;

    context c;
    solver s(c);
    
    int blockNo = 0;
    string snkPre = "ssnk_";
    string srcPre = "ssrc_";

    for (auto& bb : f->getBasicBlockList()) {
      blockVars[&bb] = {c.int_const((srcPre + to_string(blockNo)).c_str()), c.int_const((snkPre + to_string(blockNo)).c_str())};
      blockNo += 1;

      // Basic blocks cannot start before the beginning of time
      s.add(blockSource(&bb, blockVars) >= 0);
      // Basic blocks must start before they finish
      s.add(blockSource(&bb, blockVars) <= blockSink(&bb, blockVars));

      int instrNo = 0;
      for (auto& instr : bb) {
        Instruction* iptr = &instr;

        // TODO: Add latency lookup instead of assuming it here
        int latency = getLatency(iptr, hdc);

        schedVars[iptr] = {};
        string instrPre = string(iptr->getOpcodeName()) + "_" + to_string(blockNo) + "_" + to_string(instrNo);
        for (int i = 0; i <= latency; i++) {
          map_insert(schedVars, iptr, c.int_const((instrPre + "_" + to_string(i)).c_str()));
        }

        auto svs = map_find(iptr, schedVars);
        assert(svs.size() > 0);

        // Operations must be processed within the basic block that contains them
        s.add(svs.front() >= blockSource(&bb, blockVars));
        s.add(svs.back() <= blockSink(&bb, blockVars));

        // Operations with latency N take N clock ticks to finish
        for (int i = 1; i < svs.size(); i++) {
          s.add(svs[i - 1] + 1 == svs[i]);
        }

        instrNo += 1;
      }

      auto termInstr = bb.getTerminator();
      if (!BranchInst::classof(termInstr)) {
        // This is a return instr?
        assert(ReturnInst::classof(termInstr));

        // Return instructions must finish after every instruction
        for (auto& instr : bb) {
          Instruction* iptr = &instr;
          if (iptr != termInstr) {
            s.add(map_find(iptr, schedVars).back() <= map_find((Instruction*) termInstr, schedVars).front());
          }
        }
      }
    }

    auto satRes = s.check();

    if (satRes == unsat) {
      cout << "NO VIABLE SCHEDULE" << endl;
      assert(false);
    }

    model m = s.get_model();

    return buildFromModel(m, schedVars, blockVars);
  }

  // What is left after creating the instruction bindings?
  //   1. Creating state transitions
  //   2. Add operation guards
  STG buildSTG(Schedule& sched, llvm::Function* const f) {
    STG g(sched);
    for (auto var : sched.instrTimes) {
      for (auto state : var.second) {
        map_insert(g.opStates, state, {var.first, Condition()});
      }
    }

    // Q: What is the difference between a control state and a state?
    // I suppose you are supposed to just unify adjacent basic block states?
    
    // To build edges:
    // For each state value in schedule
    //   Find all instructions in that state
    //   For each instruction find all subsequent instructions
    //   Find the contaning states of those instructions
    //   If no other states to transition to then transition to next numerical

    for (int i = 0; i < sched.clockTicksToFinish(); i++) {
      map_insert(g.opTransitions, i, {i + 1, Condition()});
    }

    // Really should iterate over every state with a terminator and potentially stay
    // there
    map_insert(g.opTransitions, sched.clockTicksToFinish(), {sched.clockTicksToFinish(), Condition()});

    return g;
  }

}
