#include "scheduling.h"

#include "z3++.h"

#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace DHLS {

  OperationType opType(Instruction* const iptr) {
    if (ReturnInst::classof(iptr)) {
      return RETURN_OP;
    } else if (StoreInst::classof(iptr)) {
      return STORE_OP;
    } else if (LoadInst::classof(iptr)) {
      return LOAD_OP;
    } else if (CmpInst::classof(iptr)) {
      return CMP_OP;
    } else if (BranchInst::classof(iptr)) {
      return BR_OP;
    } else if (PHINode::classof(iptr)) {
      return PHI_OP;
    } else if (BinaryOperator::classof(iptr)) {
      auto opCode = iptr->getOpcode();
      if (opCode == Instruction::Add) {
        return ADD_OP;
      } else {
        assert(false);
      }
    } else if (GetElementPtrInst::classof(iptr)) {
      return ADD_OP;
    } else {

      cout << "Error: Unsupported instruction type " << instructionString(iptr) << std::endl;

      assert(false);
    }

  }

  std::string instructionString(Instruction* const iptr) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *iptr;

    return ss.str();
  }

  std::string typeString(Type* const tptr) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *tptr;

    return ss.str();
  }
  
  expr blockSource(BasicBlock* const bb,
                   const map<BasicBlock*, vector<expr> >& vars) {
    return map_find(bb, vars).front();
  }

  expr blockSink(BasicBlock* const bb,
                 const map<BasicBlock*, vector<expr> >& vars) {
    return map_find(bb, vars).back();
  }

  expr instrStart(Instruction* const bb,
                  const map<Instruction*, vector<expr> >& vars) {
    return map_find(bb, vars).front();
  }

  expr instrEnd(Instruction* const bb,
                const map<Instruction*, vector<expr> >& vars) {
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
    } else if (CmpInst::classof(iptr)) {
      latency = hdc.getLatency(CMP_OP);
    } else if (BranchInst::classof(iptr)) {
      latency = hdc.getLatency(BR_OP);
    } else if (PHINode::classof(iptr)) {
      // Phi instructions are just wiring
      latency = 0;
    } else if (BinaryOperator::classof(iptr)) {
      auto opCode = iptr->getOpcode();
      if (opCode == Instruction::Add) {
        latency = hdc.getLatency(ADD_OP);
      } else {
        assert(false);
      }
    } else if (GetElementPtrInst::classof(iptr)) {
      latency = hdc.getLatency(ADD_OP);
    } else {

      cout << "Error: Unsupported instruction type " << instructionString(iptr) << std::endl;

      assert(false);
    }

    return latency;
  }

  Schedule buildFromModel(solver& s,
                          map<Instruction*, vector<expr> >& schedVars,
                          map<BasicBlock*, vector<expr> >& blockVars) {


    auto satRes = s.check();

    if (satRes == unsat) {
      cout << "NO VIABLE SCHEDULE" << endl;
      assert(false);
    }

    model m = s.get_model();
    
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
  }

  int countOperations(const OperationType tp, BasicBlock* bb) {
    int count = 0;
    for (auto& instr : *bb) {
      if (opType(&instr) == tp) {
        count++;
      }
    }
    return count;
  }

  // A few new things to add:
  // 1. Control edges between basic blocks need to induce dependencies
  //    unless they are "back edges", which I suppose will be determined by
  //    linearization
  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc) {

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

    }

    // Connect the control edges
    // TODO: Prune backedges
    std::deque<BasicBlock*> toVisit{&(f->getEntryBlock())};
    std::set<BasicBlock*> alreadyVisited;
    while (toVisit.size() > 0) {
      BasicBlock* next = toVisit.front();
      toVisit.pop_front();
      alreadyVisited.insert(next);

      Instruction* term = next->getTerminator();
      if (ReturnInst::classof(term)) {
        // Return instructions must finish after every instruction in their block
        for (auto& instr : *next) {
          Instruction* iptr = &instr;
          if (iptr != term) {
            s.add(map_find(iptr, schedVars).back() <=
                  map_find((Instruction*) term, schedVars).front());
          }
        }
      } else {
        assert(BranchInst::classof(term));

        // By definition the completion of a branch is the completion of
        // the basic block that contains it.
        s.add(blockSink(next, blockVars) == map_find(term, schedVars).back());

        for (auto* nextBB : dyn_cast<TerminatorInst>(term)->successors()) {
          if (!elem(nextBB, alreadyVisited)) {
            s.add(blockSink(next, blockVars) <= blockSource(nextBB, blockVars));
            //if (!elem(nextBB, alreadyVisited)) {
            toVisit.push_back(nextBB);
          }
        }
      }
      
    }

    // Instructions must finish before their dependencies
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instr : bb) {
        Instruction* iptr = &instr;
        for (auto& user : iptr->uses()) {
          assert(Instruction::classof(user));
          if (!PHINode::classof(user)) {
            auto userInstr = dyn_cast<Instruction>(user.getUser());
            s.add(instrEnd(iptr, schedVars) <= instrStart(userInstr, schedVars));
          }
        }
      }
    }

    // Add partial order constraints to respect resource constraints
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& op : allOps()) {
        int opCount = countOperations(op, &bb);
        if (opCount >= hdc.getCount(op)) {
          vector<vector<Instruction*> > iGroups;
          vector<Instruction*> instrs;

          int ind = 0;
          for (auto& instr : bb) {
            if (opType(&instr) == op) {
              ind++;
              instrs.push_back(&instr);
            }

            if ((ind != 0) && (ind % hdc.getCount(op) == 0)) {
              ind = 0;
              iGroups.push_back(instrs);
              instrs = {};
            }
          }

          iGroups.push_back(instrs);

          cout << "iGroups = " << iGroups.size() << endl;
          for (auto gp : iGroups) {
            cout << "\tGroup" << endl;
            for (auto i : gp) {
              cout << "\t\t" << instructionString(i) << endl;
            }
          }
          
          iGroups.push_back(instrs);
          for (int i = 0; i < iGroups.size() - 1; i++) {
            auto gp = iGroups[i];
            auto next = iGroups[i + 1];
            for (auto preI : gp) {
              for (auto nextI : next) {
                s.add(instrEnd(preI, schedVars) < instrStart(nextI, schedVars));
              }
            }
          }
        }
      }
    }

    return buildFromModel(s, schedVars, blockVars);
  }

  void computeTransitions(BasicBlock* bb,
                          vector<Condition>& conditions,
                          map<BasicBlock*, vector<pair<BasicBlock*, vector<Condition> > > >& transitions) {
    assert(!contains_key(bb, transitions));
    return;
  }

  vector<vector<Atom> > allPathConditions(BasicBlock* src,
                                          BasicBlock* target,
                                          std::set<BasicBlock*>& considered) {

    if (elem(src, considered)) {
      return {};
    }

    if (src == target) {
      return {{}};
    }

    considered.insert(src);

    auto termInst = src->getTerminator();

    if (ReturnInst::classof(termInst)) {
      return {};
    } else if (BranchInst::classof(termInst)) {
      BranchInst* br = dyn_cast<BranchInst>(termInst);
      if (!br->isConditional()) {
        assert(br->getNumSuccessors() == 1);

        BasicBlock* nextB = br->getSuccessor(0);

        // True values are not represented
        return allPathConditions(nextB, target, considered);
      } else {
        assert(br->getNumSuccessors() == 2);

        cout << "Found cond branch" << endl;

        BasicBlock* trueB = br->getSuccessor(0);
        BasicBlock* falseB = br->getSuccessor(1);

        Value* cond = br->getCondition();

        Atom trueCond(cond);
        Atom falseCond(cond, true);
        
        vector<vector<Atom> > truePaths =
          allPathConditions(trueB, target, considered);

        vector<vector<Atom> > falsePaths =
          allPathConditions(falseB, target, considered);

        vector<vector<Atom> > allPaths;
        for (auto p : truePaths) {
          auto pCpy = p;
          pCpy.push_back(trueCond);
          allPaths.push_back(pCpy);
        }

        for (auto p : falsePaths) {
          auto pCpy = p;
          pCpy.push_back(falseCond);
          allPaths.push_back(pCpy);
        }

        return allPaths;
        
      }
      
    }

    assert(false);

  }

  // What is left after creating the instruction bindings?
  //   1. Creating state transitions
  //   2. Add operation guards
  STG buildSTG(Schedule& sched, llvm::Function* const f) {
    STG g(sched);

    
    // Compute basic block activation conditions (instruction guards)
    BasicBlock* entryBlock = &(f->getEntryBlock());
    map<BasicBlock*, vector<vector<Atom> > > blockGuards;
    for (auto& bbR : f->getBasicBlockList()) {
      BasicBlock* target = &bbR;
      set<BasicBlock*> considered;
      vector<vector<Atom> > allPaths =
        allPathConditions(entryBlock, target, considered);
      blockGuards[target] = allPaths;

    }

    // Add instruction mapping to schedule
    for (auto var : sched.instrTimes) {
      for (auto state : var.second) {
        BasicBlock* containerBB = var.first->getParent();
        map_insert(g.opStates, state, {var.first,
              Condition(map_find(containerBB, blockGuards))});
      }
    }

    // Q: What are the transition possibilities?
    // A: Each state contains instructions from many
    //    different basic blocks, b0, b1, ..., bn
    //    for each basic block a few things could be true:
    //    1. The terminator for that block finishes in S
    //    2. The terminator does not finish but:
    //       2.1 All non-terminator instructions finish
    //       2.2 At least one non-terminator instruction does not finish
    //
    // If 2.2 is true then if bi is executing we must transition to
    // (S + 1) to complete the in progress instructions
    //
    // Otherwise 2.1 is true and we are done with all instructions
    // from bi in S, but we have nowhere obvious to go. In that case
    // I suppose the legal choice is to find the next instruction in the
    // basic block that has not started transition to its state?

    // Compute transitions
    for (auto st : g.opStates) {
      for (auto instrG : st.second) {
        Instruction* instr = instrG.instruction;

        // If the instruction is finished in this state
        if (st.first == map_find(instr, sched.instrTimes).back()) {
          if (TerminatorInst::classof(instr)) {
            if (ReturnInst::classof(instr)) {
              if (!g.hasTransition(st.first, st.first)) {
                map_insert(g.opTransitions, st.first, {st.first, instrG.cond});
                //map_insert(g.opTransitions, st.first, {st.first, Condition()});
              }
            } else {

              auto* branch = dyn_cast<BranchInst>(instr);
              if (branch->isConditional()) {
                assert(branch->getNumSuccessors() == 2);
                Value* cond = branch->getCondition();

                BasicBlock* trueB = branch->getSuccessor(0);
                BasicBlock* falseB = branch->getSuccessor(1);

                StateId trueState =
                  map_find(trueB, sched.blockTimes).front();
                StateId falseState =
                  map_find(falseB, sched.blockTimes).front();

                // Only add a state transition if this branch takes
                // the control flow into a different state
                if ((trueB == instr->getParent()) || (trueState != st.first)) {
                  map_insert(g.opTransitions, st.first, {trueState, Condition(cond)});
                }
                if ((falseB == instr->getParent()) || (falseState != st.first)) {
                  map_insert(g.opTransitions, st.first, {falseState, Condition(cond, true)});
                }
                
              } else {
                assert(branch->getNumSuccessors() == 1);

                StateId nextState =
                  map_find(branch->getSuccessor(0), sched.blockTimes).front();
                if ((branch->getSuccessor(0) == instr->getParent()) ||
                    (nextState != st.first)) {
                  //if ((nextState > st.first) && !g.hasTransition(st.first, nextState)) {
                  map_insert(g.opTransitions, st.first, {nextState, Condition()});
                }
                
              }
            }
          } else {

            // TODO: Re-insert this code?
            
            Instruction* next = instr->getNextNode();
            StateId nextState = map_find(next, sched.instrTimes).front();
            Condition parentCond(map_find(instr->getParent(), blockGuards));
            
            // Do not jump to the start state of an instruction that has already
            // started and do not duplicate paths
            if ((nextState > st.first) && !g.hasTransition(st.first, nextState)) {
              map_insert(g.opTransitions, st.first, {nextState, parentCond});
            }
          }
        } else {
          // If the instruction is not finished then we must go to the numerically
          // next state
          if (!g.hasTransition(st.first, st.first + 1)) {
            BasicBlock* parent = instr->getParent();
            Condition parentCond(map_find(parent, blockGuards));
            map_insert(g.opTransitions, st.first, {st.first + 1, parentCond});
          }
        }
      }
    }

    return g;
  }

}
