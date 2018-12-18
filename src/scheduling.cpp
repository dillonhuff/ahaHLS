#include "scheduling.h"

#include "z3++.h"

#include <llvm/IR/Instructions.h>

#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace DHLS {

  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline,
                            AAResults& aliasAnalysis);
  
  struct SkeletonPass : public FunctionPass {
    static char ID;
    Function* target;
    HardwareConstraints& hdc;
    std::set<BasicBlock*>& toPipeline;

    Schedule schedule;
    
    SkeletonPass(Function* target_,
                 HardwareConstraints& hdc_,
                 std::set<BasicBlock*>& toPipeline_) :
      FunctionPass(ID),      
      target(target_),
      hdc(hdc_),
      toPipeline(toPipeline_) {}


    std::string aliasString;
    
    virtual void getAnalysisUsage(AnalysisUsage& AU) const override {
      AU.addRequired<AAResultsWrapperPass>();
      AU.addRequired<LoopInfoWrapperPass>();
      AU.setPreservesAll();
    }

    virtual StringRef getPassName() const override {
      return StringRef("DillonHuffSkeletonPass");
    }
    
    virtual bool runOnFunction(Function &F) override {
      errs() << "I saw a function called " << F.getName() << "!\n";

      if (&F != target) {
        return false;
      }

      AAResults& a = getAnalysis<AAResultsWrapperPass>().getAAResults();

      schedule = scheduleFunction(&F,
                                  hdc,
                                  toPipeline,
                                  a);

      return false;
    }
  };

  char SkeletonPass::ID = 0;

  // Automatically enable the pass.
  // http://adriansampson.net/blog/clangpass.html
  // static void registerSkeletonPass(const PassManagerBuilder &,
  //                                  legacy::PassManagerBase &PM) {
  //   cout << "Calling register skeleton" << endl;
  //   PM.add(new LoopInfoWrapperPass());    
  //   PM.add(new SkeletonPass());
  // }

  // static RegisterStandardPasses
  // RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
  //                registerSkeletonPass);  
  
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
      } else if (opCode == Instruction::Mul) {
        return MUL_OP;
      } else if (opCode == Instruction::Sub) {
        return SUB_OP;
      } else {
        assert(false);
      }
    } else if (GetElementPtrInst::classof(iptr)) {
      return ADD_OP;
    } else if (ZExtInst::classof(iptr)) {
      return ZEXT_OP;
    } else if (SelectInst::classof(iptr)) {
      return SELECT_OP;

    } else if (AllocaInst::classof(iptr) ||
               BitCastInst::classof(iptr) ||
               CallInst::classof(iptr)) {
      // NOTE: When call instructions other than default llvm lifetime calls
      // are supported they will need an the operator.
      return NO_OP;
    } else if (SExtInst::classof(iptr)) {
      return SEXT_OP;
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

  std::string valueString(Value* const iptr) {
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

  int HardwareConstraints::getLatency(Instruction* iptr) const {
    int latency;
    if (ReturnInst::classof(iptr)) {
      latency = 0;
    } else if (StoreInst::classof(iptr)) {
      Value* dest = map_find(iptr, memoryMapping);
      if (contains_key(dest, memSpecs)) {
        return map_find(dest, memSpecs).writeLatency;
      }

      // If no spec is given use default
      latency = getLatency(STORE_OP);
    } else if (LoadInst::classof(iptr)) {

      Value* src = map_find(iptr, memoryMapping);
      if (contains_key(src, memSpecs)) {
        return map_find(src, memSpecs).readLatency;
      }
      
      latency = getLatency(LOAD_OP);
    } else if (CmpInst::classof(iptr)) {
      latency = getLatency(CMP_OP);
    } else if (BranchInst::classof(iptr)) {
      latency = getLatency(BR_OP);
    } else if (PHINode::classof(iptr)) {
      // Phi instructions are just wiring
      latency = 0;
    } else if (BinaryOperator::classof(iptr)) {
      auto opCode = iptr->getOpcode();
      if (opCode == Instruction::Add) {
        latency = getLatency(ADD_OP);
      } else if (opCode == Instruction::Mul) {
        latency = getLatency(MUL_OP);
      } else if (opCode == Instruction::Sub) {
        latency = getLatency(SUB_OP);
      } else {
        assert(false);
      }
    } else if (GetElementPtrInst::classof(iptr)) {
      latency = getLatency(ADD_OP);
    } else if (ZExtInst::classof(iptr)) {
      latency = getLatency(ZEXT_OP);
    } else if (SelectInst::classof(iptr)) {
      latency = getLatency(SELECT_OP);
    } else if (AllocaInst::classof(iptr)) {
      // Alloca represents the instantiation of a memory
      latency = 0;
    } else if (BitCastInst::classof(iptr)) {
      // Casts are just-reinterpretations
      latency = 0;
    } else if (CallInst::classof(iptr)) {
      // NOTE: For now the only call instructions are calls to lifetime start
      // and end calls that have no meaning in hardware
      latency = 0;
    } else if (SExtInst::classof(iptr)) {
      latency = getLatency(SEXT_OP);
    } else {

      cout << "Error: Unsupported instruction type " << instructionString(iptr) << std::endl;

      assert(false);
    }

    return latency;
  }
  
  int getLatency(Instruction* iptr, HardwareConstraints& hdc) {
    return hdc.getLatency(iptr);
  }

  Schedule buildFromModel(solver& s,
                          map<Instruction*, vector<expr> >& schedVars,
                          map<BasicBlock*, vector<expr> >& blockVars,
                          map<BasicBlock*, int>& pipelineSchedules) {


    auto satRes = s.check();

    if (satRes == unsat) {
      cout << "NO VIABLE SCHEDULE" << endl;
      assert(false);
    }

    model m = s.get_model();

    // cout << "Final model" << endl;
    // cout << m << endl;
    
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

      //if (!contains_key(v.first->getParent(), pipelineSchedules)) {
        for (auto ex : v.second) {
          map_insert(sched.instrTimes, v.first, (int) m.eval(ex).get_numeral_int64());
          cout << ex << " = " << m.eval(ex) << endl;
        }
        //}
    }

    sched.pipelineSchedules = pipelineSchedules;

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

  void addScheduleVars(llvm::BasicBlock& bb,
                       context& c,
                       std::map<Instruction*, std::vector<expr> >& schedVars,
                       std::map<BasicBlock*, std::vector<expr> >& blockVars,
                       HardwareConstraints& hdc,
                       int& blockNo) {

    string snkPre = "basic_block_end_state_";
    string srcPre = "basic_block_start_state_";

    cout << "Creating basic blocks" << endl;
    
    blockVars[&bb] = {c.int_const((srcPre + to_string(blockNo)).c_str()), c.int_const((snkPre + to_string(blockNo)).c_str())};
    blockNo += 1;

    int instrNo = 0;
    for (auto& instr : bb) {
      Instruction* iptr = &instr;

      int latency = getLatency(iptr, hdc);

      schedVars[iptr] = {};

      string instrPre = string(iptr->getOpcodeName()) + "_" + to_string(blockNo) + "_" + to_string(instrNo);
      for (int i = 0; i <= latency; i++) {
        map_insert(schedVars, iptr, c.int_const((instrPre + "_" + to_string(i)).c_str()));
      }

      instrNo += 1;
    }
  }

  void addBlockConstraints(llvm::BasicBlock& bb,
                           solver& s,
                           std::map<BasicBlock*, std::vector<expr> >& blockVars,
                           std::map<Instruction*, std::vector<expr> >& schedVars) {

    // Basic blocks cannot start before the beginning of time
    s.add(blockSource(&bb, blockVars) >= 0);
    // Basic blocks must start before they finish
    s.add(blockSource(&bb, blockVars) <= blockSink(&bb, blockVars));

    Instruction* term = bb.getTerminator();
    // By definition the completion of a branch is the completion of
    // the basic block that contains it.
    s.add(blockSink(&bb, blockVars) == map_find(term, schedVars).back());
  }

  void addLatencyConstraints(llvm::BasicBlock& bb,
                             solver& s,
                             std::map<Instruction*, std::vector<expr> >& schedVars,
                             std::map<BasicBlock*, std::vector<expr> >& blockVars) {

    for (auto& instruction : bb) {
      auto iptr = &instruction;
      auto svs = map_find(iptr, schedVars);
      assert(svs.size() > 0);

      // Operations must be processed within the basic block that contains them
      s.add(svs.front() >= blockSource(&bb, blockVars));
      s.add(svs.back() <= blockSink(&bb, blockVars));

      // Operations with latency N take N clock ticks to finish
      for (int i = 1; i < svs.size(); i++) {
        s.add(svs[i - 1] + 1 == svs[i]);
      }
    }

  }

  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline) {

    llvm::legacy::PassManager pm;
    auto skeleton = new SkeletonPass(f, hdc, toPipeline);
    pm.add(new LoopInfoWrapperPass());
    pm.add(new AAResultsWrapperPass());    
    pm.add(skeleton);

    pm.run(*(f->getParent()));

    Schedule s = skeleton->schedule;

    return s;
  }
  
  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline,
                            AAResults& aliasAnalysis) {

    map<Instruction*, vector<expr> > schedVars;
    map<BasicBlock*, vector<expr> > blockVars;

    context c;
    solver s(c);

    cout << "Starting to make schedule" << endl;

    int blockNo = 0;
    for (auto& bb : f->getBasicBlockList()) {
      
      addScheduleVars(bb,
                      c,
                      schedVars,
                      blockVars,
                      hdc,
                      blockNo);

      cout << "Added schedule vars" << endl;

      addBlockConstraints(bb, s, blockVars, schedVars);
      cout << "Added block constraints" << endl;
      addLatencyConstraints(bb, s, schedVars, blockVars);
      cout << "Added latency constraints" << endl;
    }

    cout << "Created schedule vars" << endl;

    // Connect the control edges
    std::deque<BasicBlock*> toVisit{&(f->getEntryBlock())};
    std::set<BasicBlock*> alreadyVisited;
    while (toVisit.size() > 0) {
      BasicBlock* next = toVisit.front();
      toVisit.pop_front();
      alreadyVisited.insert(next);

      Instruction* term = next->getTerminator();
      if (ReturnInst::classof(term)) {
      } else {
        assert(BranchInst::classof(term));

        for (auto* nextBB : dyn_cast<TerminatorInst>(term)->successors()) {
          if (!elem(nextBB, alreadyVisited)) {

            if (elem(nextBB, toPipeline) || elem(next, toPipeline)) {
              s.add(blockSink(next, blockVars) < blockSource(nextBB, blockVars));
            } else {
              s.add(blockSink(next, blockVars) < blockSource(nextBB, blockVars));
              //s.add(blockSink(next, blockVars) <= blockSource(nextBB, blockVars));
            }
            toVisit.push_back(nextBB);
          }
        }
      }
      
    }

    cout << "Added control edges" << endl;    

    cout << "Adding memory control" << endl;

    // Instructions must finish before their dependencies
    for (auto& bb : f->getBasicBlockList()) {

      int instrInd = 0;
      
      for (auto& instr : bb) {
        Instruction* iptr = &instr;
        
        for (auto& user : iptr->uses()) {
          assert(Instruction::classof(user));
          auto userInstr = dyn_cast<Instruction>(user.getUser());          

          if (!PHINode::classof(userInstr)) {

            s.add(instrEnd(iptr, schedVars) <= instrStart(userInstr, schedVars));
            cout << instructionString(iptr) << " must finish before " << instructionString(userInstr) << endl;
          }
        }

        int otherInd = 0;
        for (auto& otherInstr : bb) {
          if (otherInd > instrInd && (&otherInstr != &instr)) {

            if (StoreInst::classof(&instr) && LoadInst::classof(&otherInstr)) {
              cout << "Checking aliasing for " << valueString(instr) << " and " << valueString(otherInstr) << endl;

              Value* storeLoc = instr.getOperand(1);
              Value* loadLoc = otherInstr.getOperand(0);
              
              //AliasResult aliasRes = aliasAnalysis.alias(&instr, &otherInstr);
              AliasResult aliasRes = aliasAnalysis.alias(storeLoc, loadLoc);
              if (aliasRes != NoAlias) {
                cout << valueString(&instr) << " and " << valueString(&otherInstr) << " can alias" << endl;

                s.add(instrEnd(&instr, schedVars) <= instrStart(&otherInstr, schedVars));
              }
            }
          }

          otherInd++;
        }

        instrInd++;
      }
    }

    cout << "Added data dependencies" << endl;    

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

    // cout << "Solver constraints" << endl;
    // cout << s << endl;

    // TODO: Add real initiation interval analysis
    map<BasicBlock*, int> subSchedules;
    for (auto bb : toPipeline) {
      subSchedules[bb] = 1; 
    }
    
    return buildFromModel(s, schedVars, blockVars, subSchedules);
  }
  
  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc) {
    set<BasicBlock*> toPipeline;
    return scheduleFunction(f, hdc, toPipeline);
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

        // Does the true or false condition on this block executing in
        // the given state need to be considered when making this pathing
        // decision?

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

  // Q: How to generate transition conditions?
  // A: I think the way to do it is to track basic block activation conditions
  //    and to do this by looking at formulas that decide what the last active
  //    basic block was, or put another way, what the last edge in the CDFG
  //    that we traversed was.
  //    I still dont see how the Zhang STG construction algorithm avoids the
  //    problem of re-executing instructions from the initial basic block
  //    if instructions from it are scheduled in the same state as a basic
  //    block inside a loop. Without any paths to it in the dominator tree it
  //    either never executes or always executes depending on how an empty
  //    path is interpreted.

  // Q: Can I represent activation conditions for basic blocks without adding
  //    in an extra variable to represent the last executed block?
  STG buildSTG(Schedule& sched,
               BasicBlock* entryBlock,
               std::set<BasicBlock*>& blockList) {

    STG g(sched);

    map<BasicBlock*, vector<vector<Atom> > > blockGuards;

    // NOTE: One possible problem is that I only compute
    // path conditions from the entry and not pairwise between
    // blocks, but that should include all possible (non-looped)
    // paths
    for (auto bbR : blockList) {
      BasicBlock* target = bbR;
      set<BasicBlock*> considered;
      vector<vector<Atom> > allPaths =
        allPathConditions(entryBlock, target, considered);
      cout << "# of paths = " << allPaths.size() << endl;
      blockGuards[target] = allPaths;

    }

    // Make sure pipeline states are included in STG
    for (auto blk : sched.pipelineSchedules) {
      for (auto var : map_find(blk.first, sched.blockTimes)) {
        if (!contains_key(var, g.opStates)) {
          g.opStates[var] = {};
        }

        if (!contains_key(var, g.opTransitions)) {
          g.opTransitions[var] = {};
        }

      }
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
      map<BasicBlock*, vector<GuardedInstruction> > endingInstructions;
      map<BasicBlock*, vector<GuardedInstruction> > inProgressInstructions;
      std::set<BasicBlock*> blocksInState;
      
      for (auto instrG : st.second) {

        Instruction* instr = instrG.instruction;
        BasicBlock* parent = instr->getParent();
        blocksInState.insert(parent);
        
        // If the instruction is finished in this state
        if (st.first == map_find(instr, sched.instrTimes).back()) {
          map_insert(endingInstructions, parent, instrG);
        } else {
          map_insert(inProgressInstructions, parent, instrG);
        }

      }

      for (auto bb : blocksInState) {
        
        bool terminatorFinishing = false;
        Instruction* instr = nullptr;
        Condition cond;
        if (contains_key(bb, endingInstructions)) {
          for (auto ist : map_find(bb, endingInstructions)) {
            if (TerminatorInst::classof(ist.instruction)) {
              terminatorFinishing = true;
              instr = ist.instruction;
              cond = ist.cond;
            }
          }
        }

        // If terminator is finishing no instructions are still in progress
        if (terminatorFinishing) {
          assert(!contains_key(bb, inProgressInstructions));

          if (ReturnInst::classof(instr)) {
            if (!g.hasTransition(st.first, st.first)) {
              map_insert(g.opTransitions, st.first, {st.first, cond});
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
                map_insert(g.opTransitions, st.first, {nextState, Condition()});
              }
                
            }
          }

        } else {

          if (inProgressInstructions.size() == 0) {
            // No terminator and no in progress instructions, need to look for
            // a default
            cout << "Zero in progress instructions in basic block " << st.first << endl;

            auto endingInBlock = map_find(bb, endingInstructions);              
            assert(endingInBlock.size() > 0);

            GuardedInstruction instrG = endingInBlock.back();
            map_insert(g.opTransitions, st.first, {st.first + 1, instrG.cond});

          } else {
            // No terminator, but some instructions are in progress, need to
            // go to the numerically next state
            cout << "Some instructions are not finished " << endl;
            cout << "inserting transition from " << st.first << " to " << st.first + 1 << endl;

            auto inProgressInBlock = map_find(bb, inProgressInstructions);    
            assert(inProgressInBlock.size() > 0);

            GuardedInstruction instrG = inProgressInBlock.back();
            map_insert(g.opTransitions, st.first, {st.first + 1, instrG.cond});
              
          }
        }
      }
      
    }

    for (auto p : sched.pipelineSchedules) {
      int II = p.second;
      BasicBlock* bb = p.first;
      vector<int> states = map_find(bb, sched.blockTimes);

      // TODO: Check that:
      //   1. The transition condition is checked less than II cycles into the pipeline
      //   2. The sequence of states only have transitions from one to another and
      //      then back to the start of the pipeline or out of it

      vector<StateId> stateIds;
      for (StateId id = states[0]; id <= states[1]; id++) {
        stateIds.push_back(id);
      }

      g.pipelines.push_back(Pipeline(II, states[1] - states[0] + 1, stateIds));
    }

    return g;
  }

  STG buildSTG(Schedule& sched, llvm::Function* const f) {
    BasicBlock* entryBlock = &(f->getEntryBlock());
    SymbolTableList<BasicBlock>& blockList = f->getBasicBlockList();
    std::set<BasicBlock*> blockSet;
    for (auto& bb : blockList) {
      blockSet.insert(&bb);
    }

    return buildSTG(sched, entryBlock, blockSet);
  }

  // TODO: Add real compiler analysis to compute this
  int dependenceDistance(Instruction* const iptr,
                         Instruction* const jptr) {
    return 0;
  }

  Schedule schedulePipeline(llvm::BasicBlock* const bb,
                            HardwareConstraints& hdc) {
    context c;
    solver s(c);
    map<Instruction*, vector<expr> > schedVars;
    map<BasicBlock*, vector<expr> > blockVars;
    int blockNo = 0;

    addScheduleVars(*bb, c, schedVars, blockVars, hdc, blockNo);

    addBlockConstraints(*bb, s, blockVars, schedVars);
    addLatencyConstraints(*bb, s, schedVars, blockVars);

    expr II = c.int_const("II");
    s.add(II >= 1);

    for (auto& i : *bb) {
      Instruction* iptr = &i;
      for (auto& j : *bb) {
        Instruction* jptr = &j;

        int d = dependenceDistance(iptr, jptr);
        if (d > 0) {
          s.add(II*d + instrEnd(iptr, schedVars) <= instrStart(jptr, schedVars));
        }
      }
      
    }

    cout << "Pipeline solver constraints" << endl;
    cout << s << endl;

    map<BasicBlock*, int> subPipelines;
    auto sched = buildFromModel(s, schedVars, blockVars, subPipelines);

    return sched;
  }

}
