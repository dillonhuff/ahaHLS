#include "scheduling.h"

#include "z3++.h"

#include <llvm/IR/Instructions.h>

#include <llvm/Analysis/OrderedBasicBlock.h>

#include <llvm/IR/LegacyPassManager.h>
#include <llvm/Transforms/IPO/PassManagerBuilder.h>
#include <llvm/Analysis/AliasAnalysis.h>
#include <llvm/Analysis/LoopInfo.h>
#include <llvm/Analysis/LoopAccessAnalysis.h>
#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/Support/raw_ostream.h>

#include "llvm_codegen.h"

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace ahaHLS {

  // Maybe instructions in the STG opStates should be grouped by
  // their basic block
  // Also: Transitions in the STG should be grouped by their active block
  // Only one block can be executing at a time, so only one block can be
  // active on the transition
  // Q: Can we infer opTransitions from the values of branches and the raw
  //    schedule?
  // A: I think the answer is yes. Each transition is just
  //    the default numerically next state if no branches execute, or
  //    is stateOf(start(blk)) if activeBlock == container(br blk)
  //       stateOf(start(blk0)) if activeBlock == container(br c blk0, blk1) and c
  //       stateOf(start(blk1)) if activeBlock == container(br c blk0, blk1) and !c
  //    Active block is set by branch instructions themselves?
  //    Maybe: Have passthrough register for active block, have branches set the
  //           active block when they execute?
  //           Q: What about pipelined designs?
  //           A: Multiple active blocks, but only one frontier...

  void
  addMemoryConstraints(llvm::Function* f,
                       HardwareConstraints& hdc,
                       std::set<BasicBlock*>& toPipeline,
                       AAResults& aliasAnalysis,
                       ScalarEvolution& sc,
                       SchedulingProblem& p);
  
  HardwareConstraints standardConstraints() {
    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);
    hcs.setLatency(FADD_OP, 20);
    hcs.setLatency(SUB_OP, 0);    
    hcs.setLatency(MUL_OP, 0);
    hcs.setLatency(SEXT_OP, 0);
    hcs.setLatency(ZEXT_OP, 0);
    hcs.setLatency(AND_OP, 0);
    hcs.setLatency(OR_OP, 0);
    hcs.setLatency(SHL_OP, 0);    
    return hcs;
  }

  z3::expr toZ3(z3::context& c,
                const LinearConstraint& constraint);

  z3::expr toZ3(z3::context& c,
                const LinearExpression& expr);

  // This is the real schedule function
  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline,
                            AAResults& aliasAnalysis,
                            ScalarEvolution& scalarEvolution);

  struct SkeletonPass : public FunctionPass {
    static char ID;
    Function* target;
    HardwareConstraints& hdc;
    std::set<BasicBlock*>& toPipeline;

    Schedule schedule;

    std::map<Function*, SchedulingProblem> functionConstraints;
    
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
      AU.addRequired<ScalarEvolutionWrapperPass>();

      AU.setPreservesAll();
    }

    virtual StringRef getPassName() const override {
      return StringRef("DillonHuffSkeletonPass");
    }
    
    virtual bool runOnFunction(Function &F) override {
      //errs() << "I saw a function called " << F.getName() << "!\n";

      if (&F != target) {
        return false;
      }

      AAResults& a = getAnalysis<AAResultsWrapperPass>().getAAResults();
      ScalarEvolution& sc = getAnalysis<ScalarEvolutionWrapperPass>().getSE();

      //errs() << "Scheduling " << "\n" << valueString(&F) << "\n";
      if (!contains_key(&F, functionConstraints)) {
        schedule = scheduleFunction(&F,
                                    hdc,
                                    toPipeline,
                                    a,
                                    sc);
      } else {
        SchedulingProblem p = map_find(&F, functionConstraints);
        addMemoryConstraints(&F,
                           hdc,
                           toPipeline,
                           a,
                           sc,
                           p);

        schedule = buildFromModel(p);
        
      }

      return false;
    }
  };

  char SkeletonPass::ID = 0;

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
      } else if (opCode == Instruction::FAdd) {
        return FADD_OP;
      } else if (opCode == Instruction::And) {
        return AND_OP;
      } else if (opCode == Instruction::Or) {
        return OR_OP;        
      } else if (opCode == Instruction::Shl) {
        return SHL_OP;
      } else {
        assert(false);
      }
    } else if (GetElementPtrInst::classof(iptr)) {
      return ADD_OP;
    } else if (ZExtInst::classof(iptr)) {
      return ZEXT_OP;
    } else if (SelectInst::classof(iptr)) {
      return SELECT_OP;
    } else if (CallInst::classof(iptr)) {
      return CALL_OP;
    } else if (AllocaInst::classof(iptr) ||
               BitCastInst::classof(iptr)) {
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
  
  int HardwareConstraints::getLatency(Instruction* iptr) const {
    int latency;
    if (ReturnInst::classof(iptr)) {
      latency = 0;
    } else if (StoreInst::classof(iptr)) {
      // MemoryMapping should instead use the 
      if (contains_key(iptr, memoryMapping)) {
        Value* dest = map_find(iptr, memoryMapping);
        if (contains_key(dest, memSpecs)) {
          return map_find(dest, memSpecs).writeLatency;
        }
      }

      // If no spec is given use default
      // TODO: Need to set defaults for internal loads vs external
      latency = getLatency(STORE_OP);
    } else if (LoadInst::classof(iptr)) {

      if (contains_key(iptr, memoryMapping)) {
        Value* src = map_find(iptr, memoryMapping);
        if (contains_key(src, memSpecs)) {
          return map_find(src, memSpecs).readLatency;
        }
      }

      // If no spec for the memory being read, revert to default
      // TODO: Need to set defaults for internal loads vs external      
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
      } else if (opCode == Instruction::FAdd) {
        latency = getLatency(FADD_OP);        
      } else if (opCode == Instruction::Mul) {
        latency = getLatency(MUL_OP);
      } else if (opCode == Instruction::Sub) {
        latency = getLatency(SUB_OP);
      } else if (opCode == Instruction::And) {
        latency = getLatency(AND_OP);
      } else if (opCode == Instruction::Or) {
        latency = getLatency(OR_OP);
      } else if (opCode == Instruction::Shl) {
        latency = getLatency(SHL_OP);
      } else {
        cout << "Error: Unknown instruction " << valueString(iptr) << endl;
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
      CallInst* call = dyn_cast<CallInst>(iptr);
      Function* called = call->getCalledFunction();

      //cout << "Called function = " << valueString(called) << endl;
      string name = called->getName();

      //cout << "Called name     = " << name << endl;

      if (isBuiltinPortWrite(iptr)) {
        latency = 0;
      } else {
        latency = 0;
      }
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

  template<typename Solver>
  Schedule extractModel(SchedulingProblem& p, z3::context& c, Solver& s) {

    //cout << "Extracting model" << endl;
    for (auto& constraint : p.constraints) {
      //cout << "Constraint = " << constraint << endl;
      s.add(toZ3(c, constraint));
    }

    // cout << "Solver constraints" << endl;
    // cout << p.s << endl;

    auto satRes = s.check();

    if (satRes == unsat) {
      cout << "NO VIABLE SCHEDULE" << endl;
      assert(false);
    }

    model m = s.get_model();

    // cout << "Final model" << endl;
    // cout << m << endl;
    
    //cout << "Final schedule" << endl;
    Schedule sched;
    
    for (auto blk : p.blockVarNames) {
      auto srcExpr = blk.second.front();
      auto snkExpr = blk.second.back();

      map_insert(sched.blockTimes, blk.first, (int) m.eval(c.int_const(srcExpr.c_str())).get_numeral_int64());
      map_insert(sched.blockTimes, blk.first, (int) m.eval(c.int_const(snkExpr.c_str())).get_numeral_int64());
      //cout << srcExpr << " = " << m.eval(srcExpr) << endl;
      //cout << snkExpr << " = " << m.eval(snkExpr) << endl;
    }

    for (auto v : p.schedVarNames) {
      for (auto ex : v.second) {
        map_insert(sched.instrTimes, v.first, (int) m.eval(c.int_const(ex.c_str())).get_numeral_int64());
        //cout << ex << " = " << m.eval(ex) << endl;
      }
    }

    for (auto s : p.IInames) {
      int ii =
        m.eval(c.int_const(p.getIIName(s.first).c_str())).get_numeral_int64();
      //cout << iiVec[0] << " = " << ii << endl;
      sched.pipelineSchedules[s.first] = ii;
    }

    return sched;
  }

  Schedule buildFromModel(SchedulingProblem& p) {
    context c;
    optimize s(c);

    // cout << "Constraints" << endl;
    // cout << s << endl;
    if (p.optimize) {
      cout << "Objective function = " << p.objectiveFunction << endl;
      optimize::handle h = s.minimize(toZ3(c, p.objectiveFunction));
      Schedule sched = extractModel(p, c, s);
      cout << "h = " << s.lower(h).get_numeral_int64() << endl;
      return sched;
    } else {
      Schedule sched = extractModel(p, c, s);
      return sched;
    }
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

  void SchedulingProblem::addBasicBlock(llvm::BasicBlock* const bb) {
    std::string snkPre = "basic_block_end_state_";
    std::string srcPre = "basic_block_start_state_";

    std::string start = srcPre + std::to_string(blockNo);
    std::string end = snkPre + std::to_string(blockNo);

    //blockVars[bb] = {c.int_const(start.c_str()), c.int_const(end.c_str())};
    blockVarNames[bb] = {start, end};

    // Basic blocks cannot start before the beginning of time
    addConstraint(blockStart(bb) >= 0);
    //s.add(blockSource(bb) >= 0);
    // Basic blocks must start before they finish asdf
    //s.add(blockSource(bb) <= blockSink(bb));
    addConstraint(blockStart(bb) <= blockEnd(bb));

    int instrNo = 0;
    for (auto& instr : *bb) {
      Instruction* iptr = &instr;

      int latency = getLatency(iptr, hdc);

      //schedVars[iptr] = {};
      schedVarNames[iptr] = {};

      string instrPre = string(iptr->getOpcodeName()) + "_" + to_string(blockNumber()) + "_" + to_string(instrNo);
      for (int i = 0; i <= latency; i++) {
        //map_insert(schedVars, iptr, c.int_const((instrPre + "_" + to_string(i)).c_str()));
        map_insert(schedVarNames, iptr, (instrPre + "_" + to_string(i)));
      }

      instrNo += 1;
    }
    
    llvm::Instruction* term = bb->getTerminator();

    assert(term != nullptr);
    
    // By definition the completion of a branch is the completion of
    // the basic block that contains it.
    //s.add(blockSink(bb) == dbhc::map_find(term, schedVars).back());
    addConstraint(blockEnd(bb) == instrEnd(term));

    blockNo++;

    for (auto& instruction : *bb) {
      auto iptr = &instruction;

      // Operations must be processed within the basic block that contains them
      addConstraint(instrStart(iptr) >= blockStart(bb));
      addConstraint(instrEnd(iptr) <= blockEnd(bb));

      // Operations with latency N take N clock ticks to finish
      for (int i = 1; i < (int) numStages(iptr); i++) {
        addConstraint((instrStage(iptr, i - 1) + 1) == instrStage(iptr, i));
      }
    }

  }

  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline) {
    map<Function*, SchedulingProblem> cs;
    return scheduleFunction(f, hdc, toPipeline, cs);
  }  

  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline,
                            std::map<Function*, SchedulingProblem>& constraints) {

    llvm::legacy::PassManager pm;
    auto skeleton = new SkeletonPass(f, hdc, toPipeline);
    skeleton->functionConstraints = constraints;
    pm.add(new LoopInfoWrapperPass());
    pm.add(new AAResultsWrapperPass());
    pm.add(new TargetLibraryInfoWrapperPass());
    pm.add(skeleton);

    pm.run(*(f->getParent()));

    Schedule s = skeleton->schedule;

    return s;
  }

  // TODO: Re-name, this is not really a topological sort, since
  // it ignores back-edges, it is really just a linearization that tries
  // to respect forward control dependences
  std::vector<BasicBlock*>
  topologicalSortOfBlocks(llvm::Function* f,
                          std::map<BasicBlock*, std::vector<BasicBlock*> >& controlPredecessors) {

    std::set<BasicBlock*> alreadyVisited;
    vector<BasicBlock*> sortedOrder;
    
    while (sortedOrder.size() < f->getBasicBlockList().size()) {

      for (auto& nextBB : f->getBasicBlockList()) {
        auto next = &nextBB;

        if (elem(next, alreadyVisited)) {
          continue;
        }

        // Iterate over all blocks picking any whose predecessors are all
        bool allPredsAdded = true;

        if (contains_key(next, controlPredecessors)) {
          for (auto predBB : map_find(next, controlPredecessors)) {

            // // TODO: Change this check to respect the partial order computed
            // // in STG dependency construction

            if (!elem(predBB, alreadyVisited)) {
              allPredsAdded = false;
              break;
            }
          }
        }

        if (allPredsAdded) {
          sortedOrder.push_back(next);
          alreadyVisited.insert(next);
        }
      }
    }

    return sortedOrder;
  }

  std::string scevStr(const SCEV* scev) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *scev;
    return ss.str();    
  }

  bool appearsBefore(Instruction* const maybeBefore,
                     Instruction* const maybeAfter) {

    BasicBlock* argBB = maybeBefore->getParent();
    BasicBlock* userBB = maybeAfter->getParent();

    assert(argBB == userBB);

    OrderedBasicBlock obb(argBB);
    return obb.dominates(maybeBefore, maybeAfter);
  }

  expr scevToExpr(const SCEV* scev, map<Value*, vector<expr > >& valueNames, context& c) {
    if (SCEVConstant::classof(scev)) {
      auto sConst = dyn_cast<SCEVConstant>(scev);
      auto val = sConst->getValue()->getValue().getLimitedValue();
      cout << "Value of " << scevStr(scev) << " is " << val << endl;
      return c.int_val(val);
    } else if (SCEVAddExpr::classof(scev)) {
      auto sExpr = dyn_cast<SCEVAddExpr>(scev);
      auto arg0 = scevToExpr(sExpr->getOperand(0), valueNames, c);
      auto arg1 = scevToExpr(sExpr->getOperand(1), valueNames, c);
      return arg0 + arg1;
    } else if (SCEVUnknown::classof(scev)) {
      auto uExpr = dyn_cast<SCEVUnknown>(scev);

      Value* v = uExpr->getValue();
      if (contains_key(v, valueNames)) {
        return map_find(v, valueNames).at(0);
      }

      string name = "scev_val_";
      if (v->getName() != "") {
        name = v->getName().str() + "_";
      }
      name += to_string(valueNames.size());
      expr e = c.int_const(name.c_str());
      valueNames[v] = {e};

      return e;
    } else {
      cout << "ERROR: Unsupported SCEV " << scevStr(scev) << " in scevToExpr" << endl;
      assert(false);
    }
  }

  int rawMemoryDD(StoreInst* const maybeWriter,
                  LoadInst* const maybeReader,
                  AliasAnalysis& aliasAnalysis,
                  ScalarEvolution& scalarEvolution) {

    Value* storeLoc = maybeWriter->getOperand(1);
    Value* loadLoc = maybeReader->getOperand(0);
              
    AliasResult aliasRes = aliasAnalysis.alias(storeLoc, loadLoc);
    if (aliasRes == NoAlias) {
      return -1;
    }

    bool lexicallyForward = appearsBefore(maybeWriter, maybeReader);
    int minDD = lexicallyForward ? 0 : 1;
    
    const SCEV* writeSCEV = scalarEvolution.getSCEV(storeLoc);
    const SCEV* readSCEV = scalarEvolution.getSCEV(loadLoc);

    cout << "Write location scev = " << scevStr(writeSCEV) << endl;
    cout << "Read location scev  = " << scevStr(readSCEV) << endl;

    if (!SCEVAddRecExpr::classof(writeSCEV)) {
      return minDD;
    }

    auto wScev = dyn_cast<SCEVAddRecExpr>(writeSCEV);

    if (!wScev->isAffine()) {
      return minDD;
    }

    if (!SCEVAddRecExpr::classof(readSCEV)) {
      return minDD;
    }

    auto rScev = dyn_cast<SCEVAddRecExpr>(readSCEV);

    if (!rScev->isAffine()) {
      return minDD;
    }

    // Create z3 solver and optimizer and build the constraints on trip count
    context c;
    optimize opt(c);
    expr Iw = c.int_const("Iw");
    expr Ir = c.int_const("Ir");
    expr DD = c.int_const("DD");

    opt.add(0 <= Iw);

    if (lexicallyForward) {
      opt.add(Iw <= Ir);
    } else {
      opt.add(Iw < Ir);
    }

    opt.add(DD == (Ir - Iw));

    map<Value*, vector<expr> > valueNames;
    expr writeBase = scevToExpr(wScev->getStart(), valueNames, c);
    expr writeInc = scevToExpr(wScev->getOperand(1), valueNames, c);

    expr readBase = scevToExpr(rScev->getStart(), valueNames, c);
    expr readInc = scevToExpr(rScev->getOperand(1), valueNames, c);
    
    opt.add(writeBase + Iw*writeInc == readBase + Ir*readInc);

    optimize::handle h1 = opt.minimize(DD);

    if (sat == opt.check()) {
      return opt.lower(h1).get_numeral_int64();
    } else {
      cout << "No solution for dependence distance, set distance == -1" << endl;
      return -1;
    }
  }
  
  int rawOperandDD(Instruction* const maybeWriter,
                   Instruction* const maybeReader,
                   DominatorTree& domTree) {
    assert(maybeWriter->getParent() == maybeReader->getParent());

    bool readerReadsWriter = false;
    for (unsigned i = 0; i < maybeReader->getNumOperands(); i++) {
      Value* op = maybeReader->getOperand(i);
      if (op == maybeWriter) {
        readerReadsWriter = true;
        break;
      }
    }

    if (!readerReadsWriter) {
      return -1;
    }

    // Does instrA write a value instrB reads?
    if (!domTree.dominates(maybeWriter, maybeReader)) {
      return 1;
    }

    return 0;
  }

  z3::expr toZ3(z3::context& c,
                const LinearExpression& expr) {
    z3::expr e = c.int_val(expr.getCoeff());
    for (auto v : expr.getVars()) {
      e = e + v.second*c.int_const(v.first.c_str());
    }

    return e;
  }
  
  z3::expr toZ3(z3::context& c,
                const LinearConstraint& constraint) {

    auto e = toZ3(c, constraint.expr);
    
    if (constraint.cond == CMP_GTEZ) {
      return e >= 0;
    } else if (constraint.cond == CMP_LTEZ) {
      return e <= 0;
    } else if (constraint.cond == CMP_EQZ) {
      return e == 0;      
    } else if (constraint.cond == CMP_LTZ) {
      return e < 0;
    } else if (constraint.cond == CMP_GTZ) {
      return e > 0;      
    } else {
      assert(false);
    }
  }

  SchedulingProblem
  createSchedulingProblem(llvm::Function* f,
                          HardwareConstraints& hdc,
                          std::set<BasicBlock*>& toPipeline) {
    SchedulingProblem p(hdc);

    for (auto& bb : f->getBasicBlockList()) {
      p.addBasicBlock(&bb);
    }

    int i = 0;
    for (auto bb : toPipeline) {
      string iiName = string("II_") + to_string(i);

      p.IInames.insert({bb, iiName});

      auto ii = p.getII(bb);
      p.addConstraint(0 < ii);
      
      i++;
    }
    
    // Connect the control edges
    std::deque<BasicBlock*> toVisit{&(f->getEntryBlock())};
    std::set<BasicBlock*> alreadyVisited;

    std::map<BasicBlock*, vector<BasicBlock*> > controlPredecessors;
    while (toVisit.size() > 0) {
      BasicBlock* next = toVisit.front();
      toVisit.pop_front();
      alreadyVisited.insert(next);

      Instruction* term = next->getTerminator();

      // TODO: Is this case even needed? Can I assume successors is empty for ret?
      if (ReturnInst::classof(term)) {
      } else {
        assert(BranchInst::classof(term));

        for (auto* nextBB : dyn_cast<TerminatorInst>(term)->successors()) {
          if (!elem(nextBB, alreadyVisited)) {

            //p.s.add(p.blockSink(next) < p.blockSource(nextBB));
            p.addConstraint(p.blockEnd(next) < p.blockStart(nextBB));

            // next is a predecessor of nextBB
            map_insert(controlPredecessors, nextBB, next);
            toVisit.push_back(nextBB);
          }
        }
      }
      
    }
    std::vector<BasicBlock*> sortedBlocks =
      topologicalSortOfBlocks(f, controlPredecessors);
    
    for (int i = 0; i < (int) sortedBlocks.size() - 1; i++) {
      auto next = sortedBlocks[i];
      auto nextBB = sortedBlocks[i + 1];
      p.addConstraint(p.blockEnd(next) < p.blockStart(nextBB));
    }


    ExecutionConstraints exe;
    addDataConstraints(f, exe);
    exe.addConstraints(p, f);

    return p;
  }

  // Solution to binding: Assume always unique, then modify program later
  // to reflect resource constraints?

  // I also need to think about how to convert the readport, writeport APIxo
  // description in a function in to sequential code snippets that can be
  // used to drive a simulated model of a program.
  void
  addMemoryConstraints(llvm::Function* f,
                       HardwareConstraints& hdc,
                       std::set<BasicBlock*>& toPipeline,
                       AAResults& aliasAnalysis,
                       ScalarEvolution& sc,
                       SchedulingProblem& p) {

    ExecutionConstraints exe;
    // Instructions must finish before their dependencies
    for (auto& bb : f->getBasicBlockList()) {

      int instrInd = 0;

      for (auto& instr : bb) {
        //Instruction* iptr = &instr;
      
        int otherInd = 0;
        for (auto& otherInstr : bb) {
          if (otherInd > instrInd && (&otherInstr != &instr)) {


            // Check FIFO dependences

            // TODO: Check that Im reading / writing the same port
            // Check WAW dependence
            if (isBuiltinPortWrite(&instr) && isBuiltinPortWrite(&otherInstr)) {
              Value* store0 = instr.getOperand(0);
              Value* store1 = otherInstr.getOperand(0);
              
              AliasResult aliasRes = aliasAnalysis.alias(store0, store1);
              if (aliasRes != NoAlias) {

                auto p0 = getPortName(&instr);
                auto p1 = getPortName(&otherInstr);
                if (p0 == p1) {
                  exe.addConstraint(instrEnd(&instr) < instrStart(&otherInstr));
                }
              }
            }

            // Check RAR
            if (isBuiltinPortRead(&instr) && isBuiltinPortRead(&otherInstr)) {
              Value* store0 = instr.getOperand(0);
              Value* store1 = otherInstr.getOperand(0);
              
              AliasResult aliasRes = aliasAnalysis.alias(store0, store1);
              if (aliasRes != NoAlias) {

                auto p0 = getPortName(&instr);
                auto p1 = getPortName(&otherInstr);
                if (p0 == p1) {
                  exe.addConstraint(instrEnd(&instr) < instrStart(&otherInstr));
                }
              }
            }
            
            // Check dependences between RAM operations
            // Check RAW dependence
            if (StoreInst::classof(&instr) && LoadInst::classof(&otherInstr)) {

              Value* storeLoc = instr.getOperand(1);
              Value* loadLoc = otherInstr.getOperand(0);
              
              AliasResult aliasRes = aliasAnalysis.alias(storeLoc, loadLoc);
              if (aliasRes != NoAlias) {
                //p.addConstraint(p.instrEnd(&instr) <= p.instrStart(&otherInstr));
                exe.addConstraint(instrEnd(&instr) <= instrStart(&otherInstr));
              }
            }

            // Check WAW dependence
            if (StoreInst::classof(&instr) && StoreInst::classof(&otherInstr)) {
              Value* storeLoc = instr.getOperand(1);
              Value* otherStoreLoc = otherInstr.getOperand(1);

              // TODO: Add SCEV analysis
              AliasResult aliasRes = aliasAnalysis.alias(storeLoc, otherStoreLoc);
              if (aliasRes != NoAlias) {
                //p.addConstraint(p.instrEnd(&instr) < p.instrEnd(&otherInstr));
                exe.addConstraint(instrEnd(&instr) < instrEnd(&otherInstr));
              }
            }

            // Check WAR dependence
            if (LoadInst::classof(&instr) && StoreInst::classof(&otherInstr)) {
              Value* loadLoc = instr.getOperand(0);
              Value* storeLoc = otherInstr.getOperand(1);

              // TODO: Add SCEV analysis
              AliasResult aliasRes = aliasAnalysis.alias(storeLoc, loadLoc);
              if (aliasRes != NoAlias) {
                //p.addConstraint(p.instrStart(&instr) <= p.instrStart(&otherInstr));
                exe.addConstraint(instrStart(&instr) <= instrStart(&otherInstr));
              }
            }
            

          }

          otherInd++;
        }

        instrInd++;
      }
    }

    // Add partial order constraints to respect resource constraints
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& op : allOps()) {

        int opCount = countOperations(op, &bb);
        if (opCount > hdc.getCount(op)) {
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

          if (instrs.size() > 0) {
            iGroups.push_back(instrs);
          }

          cout << "iGroups = " << iGroups.size() << endl;
          for (auto gp : iGroups) {
            cout << "\tGroup" << endl;
            for (auto i : gp) {
              cout << "\t\t" << instructionString(i) << endl;
            }

            assert(gp.size() > 0);
          }
          
          for (int i = 0; i < (int) iGroups.size() - 1; i++) {
            auto gp = iGroups[i];
            auto next = iGroups[i + 1];
            for (auto preI : gp) {
              for (auto nextI : next) {
                // Change to p.instrStart(preI) + II_unit
                //p.addConstraint(p.instrStart(preI) + 1 <= p.instrStart(nextI));
                exe.addConstraint(instrStart(preI) + 1 <= instrStart(nextI));
              }
            }
          }

          // If all instructions fit in 1 group there is no resource conflict
          assert(iGroups.size() > 1);

          // Make sure subsequent pipelined loop iterations obey
          // the resource partial order
          if (elem(&bb, toPipeline)) {
            auto II = p.getII(&bb);

            assert(iGroups.front().size() > 0);
            assert(iGroups.at(iGroups.size() - 1).size() > 0);

            for (auto firstI : iGroups.front()) {
              for (auto lastI : iGroups.back()) {
                p.addConstraint(p.instrEnd(lastI) < II + p.instrStart(firstI));
              }
            }

          }

        }
      }
    }

    DominatorTree domTree(*f);
    for (auto& bb : f->getBasicBlockList()) {
      if (elem(&bb, toPipeline)) {
        LinearExpression II = p.getII(&bb);

        for (Instruction& instrA : bb) {
          for (Instruction& instrB : bb) {
            int rawDD = rawOperandDD(&instrA, &instrB, domTree);
            if (rawDD > 0) {
              p.addConstraint(p.instrEnd(&instrA) < II*rawDD + p.instrStart(&instrB));
              //exe.addConstraint(new ILPConstraint(instrEnd(&instrA) < II*rawDD + instrStart(&instrB)));
            }

            if (StoreInst::classof(&instrA) &&
                LoadInst::classof(&instrB)) {
              int memRawDD = rawMemoryDD(dyn_cast<StoreInst>(&instrA),
                                         dyn_cast<LoadInst>(&instrB),
                                         aliasAnalysis,
                                         sc);
              if (memRawDD > 0) {
                p.addConstraint(p.instrEnd(&instrA) < II*memRawDD + p.instrStart(&instrB));
                //exe.addConstraint(instrEnd(&instrA) < II*memRawDD + instrStart(&instrB));
              }
            }
          }
        }
      }
    }

    exe.addConstraints(p, f);

  }
  
  SchedulingProblem
  createSchedulingProblem(llvm::Function* f,
                          HardwareConstraints& hdc,
                          std::set<BasicBlock*>& toPipeline,
                          AAResults& aliasAnalysis,
                          ScalarEvolution& sc) {
    auto p = createSchedulingProblem(f, hdc, toPipeline);
    addMemoryConstraints(f, hdc, toPipeline, aliasAnalysis, sc, p);

    return p;
  }
  
  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<BasicBlock*>& toPipeline,
                            AAResults& aliasAnalysis,
                            ScalarEvolution& sc) {

    // Remove builtin calls and replace them with sequences of calls
    // to port setting functions?

    SchedulingProblem p =
      createSchedulingProblem(f, hdc, toPipeline, aliasAnalysis, sc);

    return buildFromModel(p);
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

  STG buildSTG(Schedule& sched,
               BasicBlock* entryBlock,
               std::set<BasicBlock*>& blockList,
               std::function<void(Schedule&,
                                  STG&,
                                  StateId,
                                  llvm::ReturnInst*,
                                  Condition&)>& returnBehavior);

  
  // Maybe I should re-write this entire thing assuming that each state
  // contains exactly one basic block? That is the working assumption, and
  // it delegates the work of converting control edges to select instructions
  // and conditional loads / stores to the IR optimizations

  // Q: How would that algorithm work? I suppose it would work by finding the
  // transition conditions on the sole block in an STG and just adding those
  // conditions to the output of the block?

  //    I still dont see how the Zhang STG construction algorithm avoids the
  //    problem of re-executing instructions from the initial basic block
  //    if instructions from it are scheduled in the same state as a basic
  //    block inside a loop. Without any paths to it in the dominator tree it
  //    either never executes or always executes depending on how an empty
  //    path is interpreted.
  STG buildSTG(Schedule& sched,
               BasicBlock* entryBlock,
               std::set<BasicBlock*>& blockList) {

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      assert(!stg.hasTransition(st, st));

      if (!stg.hasTransition(st, st)) {
        map_insert(stg.opTransitions, st, {st, cond});
      }
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);

    return buildSTG(sched, entryBlock, blockList, returnBehavior);
  }

  STG buildSTG(Schedule& sched,
               BasicBlock* entryBlock,
               std::set<BasicBlock*>& blockList,
               std::function<void(Schedule&,
                                  STG&,
                                  StateId,
                                  llvm::ReturnInst*,
                                  Condition&)>& returnBehavior) {
               
    STG g(sched);

    map<BasicBlock*, vector<vector<Atom> > > blockGuards;

    // NOTE: One possible problem is that I only compute
    // path conditions from the entry and not pairwise between
    // blocks, but that should include all possible (non-looped)
    // paths
    for (auto bbR : blockList) {
      BasicBlock* target = bbR;
      blockGuards[target] = {{}};
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
        //BasicBlock* containerBB = var.first->getParent();
        map_insert(g.opStates, state, var.first);
              //Condition(map_find(containerBB, blockGuards))});
      }
    }

    // Add no instruction states to schedule
    StateId minState = 0;
    StateId maxState = minState;
    for (auto st : g.opStates) {
      if (st.first > maxState) {
        maxState = st.first;
      }
    }

    // Add no instruction states to transitions
    for (StateId i = minState; i < maxState; i++) {
      if (!contains_key(i, g.opStates)) {
        g.opStates[i] = {};
        Condition t;
        assert(t.isTrue());
        g.opTransitions[i] = {{i + 1, t}};
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
      map<BasicBlock*, vector<Instruction*> > endingInstructions;
      map<BasicBlock*, vector<Instruction*> > inProgressInstructions;
      std::set<BasicBlock*> blocksInState;
      
      for (auto instrG : st.second) {

        Instruction* instr = instrG; //instruction;
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
            if (TerminatorInst::classof(ist)) { //.instruction)) {
              terminatorFinishing = true;
              instr = ist; //.instruction;
              cond = Condition(); //ist.cond;
            }
          }
        }

        // If terminator is finishing no instructions are still in progress
        if (terminatorFinishing) {
          assert(!contains_key(bb, inProgressInstructions));

          if (ReturnInst::classof(instr)) {

            returnBehavior(sched, g, st.first, dyn_cast<ReturnInst>(instr), cond);

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

            //GuardedInstruction instrG = endingInBlock.back();
            map_insert(g.opTransitions, st.first, {st.first + 1, Condition()});

          } else {
            // No terminator, but some instructions are in progress, need to
            // go to the numerically next state
            cout << "Some instructions are not finished " << endl;
            cout << "inserting transition from " << st.first << " to " << st.first + 1 << endl;

            auto inProgressInBlock = map_find(bb, inProgressInstructions);    
            assert(inProgressInBlock.size() > 0);

            //GuardedInstruction instrG = inProgressInBlock.back();xo
            //map_insert(g.opTransitions, st.first, {st.first + 1, instrG.cond});
            map_insert(g.opTransitions, st.first, {st.first + 1, Condition()});
              
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


  STG buildSTG(Schedule& sched,
               llvm::Function* const f,
               std::function<void(Schedule&,
                                  STG&,
                                  StateId,
                                  llvm::ReturnInst*,
                                  Condition&)>& returnBehavior) {

    BasicBlock* entryBlock = &(f->getEntryBlock());
    SymbolTableList<BasicBlock>& blockList = f->getBasicBlockList();
    std::set<BasicBlock*> blockSet;
    for (auto& bb : blockList) {
      blockSet.insert(&bb);
    }

    return buildSTG(sched, entryBlock, blockSet, returnBehavior);
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

  Type* readOutputType(llvm::Function* readFifo) {
    if (readFifo->getReturnType() == Type::getVoidTy(getGlobalLLVMContext())) {
      auto zArg = getArg(readFifo, 0);
      assert(PointerType::classof(zArg->getType()));
      return dyn_cast<PointerType>(zArg->getType())->getElementType();
    }

    return readFifo->getReturnType();
  }

  Value* readFifoVal(llvm::Function* readFifo) {
    if (readFifo->getReturnType() == Type::getVoidTy(getGlobalLLVMContext())) {
      return getArg(readFifo, 1);
    }

    return getArg(readFifo, 0);
  }


  // Case 1: Null constructor, can be optimized away
  // Maybe instead of getting the bit width of the type I should get
  // the entire type signature (all fields of the type?) and then
  // Note: Maybe I also need the packed vs. unpacked distinction?
  // the fifo can only hold objects whose C++ type is representable
  // as a single entry in a RAM? I suppose the FIFO can represent
  // any combination of states in each entry, it does not have to
  // be a RAM

  // Note: The fifo itself is a black box, so we do
  // not need to represent the copy action internally, we just
  // need to represent connecting the module pointed to by the
  // receiver argument to the module.
  // Note: The connections themselves have the scheduling property
  // that they may need to endure for more than 1 cycle. For a complex
  // copy it may be important that the codes stay copied for several
  // cycles, or for an undetermined number of cycles?

  // Q: Can read and write be phrased as connects?
  // A: Read is connect to a temp wire for 1 cycle
  //    Write is connect to a temp wire for 1 cycle
  // Q: What about representing wires + read / write latencies?
  //    If I rephrase read and write this way they will take
  //    pointers as inputs, but that will be interpreted as a register
  //    read / write?

  // Basically the op here is:
  // wait for ready == 1
  // { connect valid port with constant 1
  // { for each mport in result modulespec (needed for copy?): connect mport to fifo mport
  // wait for copy constructor duration, and connect valid with 0
  // done

  // TODO: Build a separate prototype of this connect calling convention
  // for FIFOs?

  // Q: Can stalls be phrased as connects + data dependencies?
  // A: Phrase stall on ready as: connect wire to ready and then
  //    make that wire a dependency of other codes?
  void implementRVFifoRead(llvm::Function* readFifo, ExecutionConstraints& exec) {
    auto out = readFifoVal(readFifo);
    //getArg(readFifo, 0);

    auto tp = out->getType();

    cout << "readFifoVal = " << valueString(out) << endl;
    cout << "tp          = " << typeString(tp) << endl;
    cout << "type read   = " << typeString(readOutputType(readFifo)) << endl;
    int width = getTypeBitWidth(readOutputType(readFifo));
    //readFifo->getReturnType());

    cout << "type width = " << width << endl;
      
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

    addDataConstraints(readFifo, exec);
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

  void implementRVFifoWriteRef(llvm::Function* writeFifo,
                               ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", writeFifo);
    IRBuilder<> b(eb);

    auto out = getArg(writeFifo, 0);
    auto dataPtr = getArg(writeFifo, 1);

    assert(PointerType::classof(dataPtr->getType()));

    auto dataPtrTp = dyn_cast<PointerType>(dataPtr->getType());

    auto tp = out->getType();
    
    int width = getTypeBitWidth(dataPtrTp->getElementType()); //getValueBitWidth(getArg(writeFifo, 1));

    cout << "Data width of " << typeString(dataPtrTp) << " = " << width << endl;

    auto writeDataF = writePort("in_data", width, tp);
    auto readReadyF = readPort("write_ready", 1, tp);

    auto setValidF = writePort("write_valid", 1, tp);
    auto stallF = stallFunction();

    //auto readOutF = readPort("out", width, dataPtrTp);

    auto readReady = b.CreateCall(readReadyF, {out});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {out, mkInt(0, 1)});
    //auto data = b.CreateCall(readOutF, {dataPtr});
    auto data = b.CreateLoad(dataPtr);
    auto writeValue = b.CreateCall(writeDataF, {out, data});
      
    b.CreateRet(nullptr);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrStart(setValid1) == instrStart(writeValue));
    exec.addConstraint(instrEnd(data) == instrStart(data));
    exec.addConstraint(instrEnd(data) == instrStart(writeValue));    
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));
    addDataConstraints(writeFifo, exec);
  }
  
  void implementRVFifoWriteTemplate(llvm::Function* writeFifo,
                                    ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", writeFifo);
    IRBuilder<> b(eb);

    auto out = getArg(writeFifo, 0);
    auto data = getArg(writeFifo, 1);

    auto tp = out->getType();
    int width = getValueBitWidth(getArg(writeFifo, 1));

    auto writeDataF = writePort("in_data", width, tp);
    auto readReadyF = readPort("write_ready", 1, tp);

    auto setValidF = writePort("write_valid", 1, tp);
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {out});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {out, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {out, mkInt(0, 1)});
    auto writeValue = b.CreateCall(writeDataF, {out, data});
      
    b.CreateRet(nullptr);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrStart(setValid1) == instrStart(writeValue));
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));
  }

  Value* valueReplacement(Value* opI,
                          map<Value*, Value*>& argsToValues,
                          map<Instruction*, Instruction*>& oldInstrsToClones) {
    if (contains_key(opI, argsToValues)) {
      return map_find(opI, argsToValues);
    } else if (Instruction::classof(opI)) {
      auto opII = dyn_cast<Instruction>(opI);
      if (contains_key(opII, oldInstrsToClones)) {
        return map_find(opII, oldInstrsToClones);
      } else {
        return opI;
      }
    }

    return opI;

  }
  
  void replaceValues(map<Value*, Value*>& argsToValues,
                     map<Instruction*, Instruction*>& oldInstrsToClones,
                     Instruction* const clone) {
    for (int i = 0; i < (int) clone->getNumOperands(); i++) {
      Value* opI = clone->getOperand(i);
      Value* newOpI = valueReplacement(opI, argsToValues, oldInstrsToClones);
      clone->setOperand(i, newOpI);
    }
  }

  ExecutionAction
  findReplacement(//Instruction* instr,
                  ExecutionAction& toReplace,
                  std::map<Instruction*, Instruction*>& oldInstrsToClones,
                  std::map<BasicBlock*, BasicBlock*>& oldBlocksToClones,
                  ExecutionAction& functionAction) {
    if (toReplace.type() == EXECUTION_ACTION_INSTRUCTION) {
      auto instr = toReplace.getInstruction();
      if (ReturnInst::classof(instr)) {
        return functionAction;
      }

      return map_find(instr, oldInstrsToClones);
    } else if (toReplace.type() == EXECUTION_ACTION_BASIC_BLOCK) {
      return map_find(toReplace.getBasicBlock(), oldBlocksToClones);
    } else if (toReplace.type() == EXECUTION_ACTION_TAG) {
      return ExecutionAction(toReplace.getName() + "_il");
    } else {
      cout << "Unsupported ExecutionAction " << toReplace << endl;
      assert(false);
    }
  }

  // TODO: Unique naming for inlined markers
  void replaceActionBefore(Ordered* oc,
                           map<Instruction*, Instruction*>& oldInstrsToClones,
                           map<BasicBlock*, BasicBlock*>& oldBlocksToClones,
                           ExecutionAction& inlineMarkerAction) {
    ExecutionAction bRep = findReplacement(oc->before.action, oldInstrsToClones, oldBlocksToClones, inlineMarkerAction);
    if (oc->before.action.isInstruction()) {
      auto beforeInstr = oc->before.getInstr();
      
      if (ReturnInst::classof(beforeInstr)) {
        if (oc->before.isStart()) {
          oc->before.isEnd = true;
        }
      }
    }
    
    oc->before.replaceAction(oc->before.action, bRep);
  }

  void replaceActionAfter(Ordered* oc,
                          map<Instruction*, Instruction*>& oldInstrsToClones,
                          map<BasicBlock*, BasicBlock*>& oldBlocksToClones,
                          ExecutionAction& inlineMarkerAction) {
    ExecutionAction bRep = findReplacement(oc->after.action, oldInstrsToClones, oldBlocksToClones, inlineMarkerAction);
    if (oc->after.action.isInstruction()) {
      auto afterInstr = oc->after.getInstr();
      
      if (ReturnInst::classof(afterInstr)) {
        if (oc->after.isStart()) {
          oc->after.isEnd = true;
        }
      }
    }
    
    oc->after.replaceAction(oc->after.action, bRep);
  }
  
  // Note: There is really no need for a ret instruction either, it
  // can be interpreted however we want using functional units.
  // The last question is about branch instructions. Should they
  // still be allowed to exist, or should they also be changed to
  // some sort of distinguished control path instruction?
  // Perhaps branches should be implemented as operations on the
  // module for the control path, but the control path module
  // itself should be synthesized from specifications generated
  // from earlier analysis passes? Maybe the scheduling problem should
  // be generalized to decision variables about when control path
  // variables have certain values?
  // How does this control path versatility mix with optimizations
  // like pipelining that change the structure of the datapath?
  // The scheduler needs to know something about how data is passed between
  // functional units. One way to do this is to allow the user to explicitly
  // instantiate wires and storage data structures that pass data, another
  // is to allow the HLS tool itself to determine a mapping from abstract data
  // objects on to storage. Perhaps the idea of a "store" which can receive
  // input data is essential as a builtin in order to express this concept?

  // Maybe *conditioned* wire reads and writes are the basic abstraction, where
  // the conditions are outputs of the control path? and writes can also
  // be to inputs of the control path?

  // Currently the scheduler only knows about task parallelism, but perhaps in
  // order to do pipelining and task splitting correctly the scheduler also
  // needs to know about storage elements like FIFOs and RAMs? Or at least
  // it needs to know something about what is being produced by functional units?

  // Is it the same to say "this output wire needs to be connected to this input
  // wire at this time" and "this output value needs to get to this input wire
  // eventually?" ?? Can difference logic schedulers convey this distinction
  // or is it implicit in the FSM construcion done after the finite state machine
  // is created?
  void inlineFunctionWithConstraints(Function* const f,
                                     ExecutionConstraints& exec,
                                     CallInst* const toInline,
                                     ExecutionConstraints& constraintsToInline) {

    cout << "Inlining " << valueString(toInline) << endl;
    cout << "# of operands = " << toInline->getNumOperands() << endl;

    map<Value*, Value*> argsToValues;
    Function* called = toInline->getCalledFunction();

    cout << "Function def " << valueString(called) << endl;    
    
    for (int i = 0; i < (int) toInline->getNumOperands() - 1; i++) {
      cout << "i = " << i << endl;
      cout << "Operand " << i << " = " << valueString(toInline->getOperand(i)) << endl;
      argsToValues[getArg(called, i)] = toInline->getOperand(i);
    }

    cout << "# of basic blocks = " << called->getBasicBlockList().size() << endl;

    //assert(called->getBasicBlockList().size() == 1);

    cout << "Built value list" << endl;

    map<BasicBlock*, BasicBlock*> oldBlocksToClones;

    bool oneBlock = called->getBasicBlockList().size() == 1;
    BasicBlock* preCall = nullptr;
    BasicBlock* atCall = nullptr;
    if (oneBlock) {
      // Just inline in to a new block
      oldBlocksToClones[&(*begin(called->getBasicBlockList()))] =
        toInline->getParent();
    } else {
      preCall = toInline->getParent();
      atCall = toInline->getParent()->splitBasicBlock(toInline);
      for (auto& bb : called->getBasicBlockList()) {
        auto newBB = mkBB(string(bb.getName()) + "_il", f);
        oldBlocksToClones[&bb] = newBB;
      }
    }

    map<Instruction*, Instruction*> oldInstrsToClones;
    vector<Instruction*> inlinedInstrs;
    // Inline the constraints
    Value* finalRetVal = nullptr;

    // cout << "Function called is" << endl;
    // cout << valueString(called) << endl;

    // What changes need to be made?
    // 2. We need to support copying basic blocks in to the new structure
    // 3. We need to support replacing all referenced values (already do?)
    // 4. We need to support iterating over all new phi instructions
    //    and replacing their edges
    for (auto& bb : called->getBasicBlockList()) {
      BasicBlock* replacementBlock = map_find(&bb, oldBlocksToClones);
      
      for (auto& instr : bb) {
        if (!ReturnInst::classof(&instr)) {
          Instruction* clone = instr.clone();
          oldInstrsToClones[&instr] = clone;
          replaceValues(argsToValues, oldInstrsToClones, clone);

          if (oneBlock) {
            clone->insertBefore(toInline);
          } else {
            replacementBlock->getInstList().push_back(clone);
          }

          inlinedInstrs.push_back(clone);

        } else {

          if (!oneBlock) {
            IRBuilder<> brB(replacementBlock);
            brB.CreateBr(atCall);

            // cout << "New replacement return block" << endl;
            // cout << valueString(replacementBlock) << endl;
          }
          if (instr.getNumOperands() > 0) {
            assert(instr.getNumOperands() == 1);

            Value* retVal = instr.getOperand(0);

            if (Instruction::classof(retVal)) {
              finalRetVal =
                map_find(dyn_cast<Instruction>(retVal), oldInstrsToClones);
            } else {
              finalRetVal = retVal;
            }
          }
        }
      }
    }

    // cout << "After instruction inlining, before branch changes" << endl;
    // cout << valueString(f) << endl;
    
    // TODO: Add new constraint edges (replace destinations of branches)
    // Q: What edges need to be added?
    // A: 1. Edge from original basic block containing toInline to
    //       the entry of the inlined function
    //    2. Edge from every inlined block that contains a return instruction
    //       to the split block from the inlined call?
    if (!oneBlock) {
      auto preCallTerm = preCall->getTerminator();
      assert(BranchInst::classof(preCallTerm));
      auto preBr = dyn_cast<BranchInst>(preCallTerm);
      assert(!preBr->isConditional());

      preBr->setSuccessor(0, map_find(&(called->getEntryBlock()), oldBlocksToClones));
      
      for (auto& bb : f->getBasicBlockList()) {
        cout << "setting successors for " << valueString(&bb) << endl;
        auto term = bb.getTerminator();
        assert(term != nullptr);
        if (BranchInst::classof(term)) {
          BranchInst* br = dyn_cast<BranchInst>(term);
          for (int i = 0; i < (int) br->getNumSuccessors(); i++) {
            BasicBlock* successor = br->getSuccessor(i);
            if (contains_key(successor, oldBlocksToClones)) {
              BasicBlock* newSuccessor = map_find(successor, oldBlocksToClones);
              br->setSuccessor(i, newSuccessor);
            }
          }
        }

        cout << "done" << endl;
      }
    }

    // cout << "After instruction inlining, before phi changes" << endl;
    // cout << valueString(f) << endl;
    
    // Set phi instruction successors
    if (!oneBlock) {
      for (auto bbs : oldBlocksToClones) {
        BasicBlock* inlinedBlock = bbs.second;
        for (auto& instrR : *inlinedBlock) {
          if (PHINode::classof(&instrR)) {
            auto phi = dyn_cast<PHINode>(&instrR);
            for (int i = 0; i < (int) phi->getNumIncomingValues(); i++) {
              BasicBlock* incoming = phi->getIncomingBlock(i);
              BasicBlock* newIncoming =
                map_find(incoming, oldBlocksToClones);

              phi->setIncomingBlock(i, newIncoming);

              Value* oldValue = phi->getIncomingValue(i);
              Value* newValue = valueReplacement(oldValue, argsToValues, oldInstrsToClones);
              phi->setIncomingValue(i, newValue);
            }
          }
        }
      }
    }


    // cout << "After instruction inlining, before constraint inlining" << endl;
    // cout << valueString(f) << endl;

    // Replace the inline start and end times with marker action noops
    ExecutionAction inlineAction(toInline);
    ExecutionAction inlineMarkerAction(sanitizeFormatForVerilogId(valueString(toInline)));

    // Need to fit the basic block start and end time in to the execution
    // constraints
    //BasicBlock* bb = toInline->getParent();
    BasicBlock* entry = map_find(&(called->getEntryBlock()), oldBlocksToClones);
    exec.add(start(entry) <= actionStart(inlineMarkerAction));

    for (auto& bb : called->getBasicBlockList()) {
      if (ReturnInst::classof(bb.getTerminator())) {
        BasicBlock* exit = map_find(&bb, oldBlocksToClones);
        exec.add(actionEnd(inlineMarkerAction) <= end(exit));
      }
    }

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

    //cout << "Iterating over constraints, # of constraints = " << constraintsToInline.constraints.size() << endl;
    
    for (auto c : constraintsToInline.constraints) {

      //cout << tab(1) << "Inlining " << *c << endl;
      if (c->type() == CONSTRAINT_TYPE_ORDERED) {
        Ordered* oc = static_cast<Ordered*>(c->clone());

        // cout << "Before = " << oc->before << endl;
        // cout << "After  = " << oc->after << endl;        

        // start(inline_ret) -> end(inlineMarker)
        // end(inline_ret) -> end(inlineMarker)
        // Assumption is start(inline_ret) == end(inline_ret), since ret
        // takes no time
        replaceActionBefore(oc, oldInstrsToClones, oldBlocksToClones, inlineMarkerAction);
        replaceActionAfter(oc, oldInstrsToClones, oldBlocksToClones, inlineMarkerAction);
        exec.addConstraint(oc);
      } else {
        assert(false);
      }
    }

    //cout << "Done inlining" << endl;
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
            } else if (canDemangle(inlineFunc->getName())) {
              cout << "Can demangle" << endl;
              string dmName =
                demangledFuncName(demangle(inlineFunc->getName()));
              if (contains_key(dmName, interfaces.functionTemplates)) {
                if (!interfaces.containsFunction(inlineFunc)) {
                  inlineFunc->deleteBody();
                  interfaces.addFunction(inlineFunc);
                  auto implFunc = map_find(dmName, interfaces.functionTemplates);
                  implFunc(inlineFunc, interfaces.getConstraints(inlineFunc));
                }

                inlineFunctionWithConstraints(f, exec, call, interfaces.getConstraints(inlineFunc));
                replaced = true;
                break;
              }
            }
          }
        }

        if (replaced) {
          break;
        }
      }
    }

  }

  ModuleSpec fifoSpec(int width, int depth) {
    map<string, Port> fifoPorts = {
      {"in_data", inputPort(width, "in_data")},
      {"read_valid", inputPort(1, "read_valid")},
      {"write_valid", inputPort(1, "write_valid")},
      {"rst", inputPort(1, "rst")},

      {"out_data", outputPort(width, "out_data")},
      {"read_ready", outputPort(1, "read_ready")},
      {"write_ready", outputPort(1, "write_ready")}
    };

    map<string, int> defaults;
    defaults.insert({"read_valid", 0});
    defaults.insert({"write_valid", 0});    
    //defaults.insert({"in_data", 0});

    set<string> insensitivePorts{"in_data"};
    ModuleSpec modSpec = {{{"WIDTH", to_string(width)}, {"DEPTH", to_string(depth)}}, "fifo", fifoPorts, defaults, insensitivePorts};
    modSpec.hasClock = true;
    modSpec.hasRst = true;
    return modSpec;
  }


  ModuleSpec wireSpec(int width) {
    map<string, Port> wirePorts = {
      {"in_data", inputPort(width, "in_data")},
      {"out_data", outputPort(width, "out_data")}};

    map<string, int> defaults;
    set<string> insensitive{"in_data"};
    ModuleSpec mspec = {{{"WIDTH", to_string(width)}}, "hls_wire", wirePorts, defaults, insensitive};
    mspec.hasClock = false;
    mspec.hasRst = false;

    return mspec;
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

  void implementBusGet(llvm::Function* busGet,
                       ExecutionConstraints& exec,
                       const HardwareConstraints& hcs) {
    
    auto eb = mkBB("entry_block", busGet);
    IRBuilder<> b(eb);
    int width = 32;
    auto val = mkInt(10, width);
    b.CreateRet(val);

  }

  void implementRVCompoundRead(llvm::Function* readFifo,
                               ExecutionConstraints& exec,
                               const HardwareConstraints& hcs) {
    auto eb = mkBB("entry_block", readFifo);
    IRBuilder<> b(eb);
    b.CreateRet(nullptr);
  }

  void implementRVCompoundWrite(llvm::Function* readFifo,
                                ExecutionConstraints& exec,
                                const HardwareConstraints& hcs) {
    auto eb = mkBB("entry_block", readFifo);
    IRBuilder<> b(eb);
    b.CreateRet(nullptr);
  }

  void implementAXIRead(llvm::Function* axiRead,
                        ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", axiRead);
    IRBuilder<> b(eb);

    auto readMod = getArg(axiRead, 0);

    auto outType = axiRead->getReturnType();
    int width = getTypeBitWidth(outType);

    cout << "axi read width = " << width << endl;

    auto readDataF = readPort("read_data", width, outType);
    auto writeRaddrF = writePort("read_addr", 5, readMod->getType());
    auto writeStartReadF = writePort("start_read", 1, readMod->getType());

    auto readValidF = readPort("valid", 1, readMod->getType());    
    auto readReadyF = readPort("ready", 1, readMod->getType());
    
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {readMod});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});

    auto setStartRead = b.CreateCall(writeStartReadF, {readMod, mkInt(1, 1)});
    auto writeAddr = b.CreateCall(writeRaddrF, {readMod, getArg(axiRead, 1)});

    auto readValid = b.CreateCall(readValidF, {readMod});
    auto stallUntilValid = b.CreateCall(stallF, {readValid});
    
    auto dataValue = b.CreateCall(readDataF, {readMod});
    b.CreateRet(dataValue);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));

    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setStartRead));
    exec.addConstraint(instrStart(setStartRead) == instrStart(writeAddr));

    exec.addConstraint(instrEnd(setStartRead) + 1 == instrStart(stallUntilValid));
    exec.addConstraint(instrStart(readValid) == instrStart(stallUntilValid));
    exec.addConstraint(instrStart(dataValue) == instrStart(stallUntilValid));

    addDataConstraints(axiRead, exec);
  }

  void implementAXIWrite(llvm::Function* axiWrite,
                         ExecutionConstraints& exec) {

    auto eb = mkBB("entry_block", axiWrite);
    IRBuilder<> b(eb);

    //auto data = getArg(axiWrite, 2);

    auto waddr = getArg(axiWrite, 1);
    auto wdata = getArg(axiWrite, 2);

    auto inType = wdata->getType();
    int width = getTypeBitWidth(inType);

    cout << "axi read width = " << width << endl;

    auto writeMod = getArg(axiWrite, 0);

    auto writeDataF = writePort("write_data", width, inType);
    auto writeAddrF = writePort("write_addr", 5, writeMod->getType());
    auto setStartWriteF = writePort("start_write", 1, writeMod->getType());

    auto readValidF = readPort("valid", 1, writeMod->getType());
    auto readReadyF = readPort("ready", 1, writeMod->getType());
    
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {writeMod});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});

    auto setStartWrite = b.CreateCall(setStartWriteF, {writeMod, mkInt(1, 1)});
    auto setWriteAddr = b.CreateCall(writeAddrF, {writeMod, waddr});
    auto setWriteData = b.CreateCall(writeDataF, {writeMod, wdata});

    auto readValid = b.CreateCall(readValidF, {writeMod});
    auto stallUntilValid = b.CreateCall(stallF, {readValid});
    
    b.CreateRet(nullptr);

    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));

    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setStartWrite));
    exec.addConstraint(instrStart(setStartWrite) == instrStart(setWriteAddr));
    exec.addConstraint(instrStart(setStartWrite) == instrStart(setWriteData));
    
    exec.addConstraint(instrEnd(setStartWrite) + 1 == instrStart(stallUntilValid));
    exec.addConstraint(instrStart(readValid) == instrStart(stallUntilValid));
    
    addDataConstraints(axiWrite, exec);
  }

  Instruction* stallOnPort(IRBuilder<>& b,
                           Value* const readMod,
                           const int width,
                           const std::string portName,
                           ExecutionConstraints& exec) {
    auto modType = getPointedToType(readMod->getType());
    auto stallF = stallFunction();
    auto readAReadyF = readPort(portName, width, modType);
    
    auto readAddrReady = b.CreateCall(readAReadyF, {readMod});
    auto stallUntilReadAddrReady = b.CreateCall(stallF, readAddrReady);
    exec.add(instrStart(readAddrReady) == instrStart(stallUntilReadAddrReady));
    return stallUntilReadAddrReady;
  }

  Instruction* writePort(IRBuilder<>& b,
                         Value* const writeMod,
                         const int width,
                         const std::string name,
                         Value* const toWrite) {
    auto writeF = writePort(name, width, getPointedToType(writeMod->getType()));
    auto writeInstr = b.CreateCall(writeF, {writeMod, toWrite});
    return writeInstr;
  }

  Instruction* readPort(IRBuilder<>& b,
                        Value* const readMod,
                        const int width,
                        const std::string name) {
    auto readF = readPort(name, width, getPointedToType(readMod->getType()));
    auto readInstr = b.CreateCall(readF, {readMod});
    return readInstr;
  }
  
  // TODO: Implement address shifting / strobe?
  void implementRawAXIWrite(llvm::Function* axiWrite,
                            ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", axiWrite);
    IRBuilder<> b(eb);

    auto readMod = getArg(axiWrite, 0);
    cout << "ReadMod = " << valueString(readMod) << endl;
    
    auto inType = getArg(axiWrite, 2)->getType();
    int dataWidth = getTypeBitWidth(inType);
    int addrWidth = 32;
    int strbWidth = dataWidth / 8;

    auto inAddr = getArg(axiWrite, 1);
    auto addrValShifted = b.CreateShl(inAddr, mkInt(2, 32));    
    auto inData = getArg(axiWrite, 2);    

    // We are ready to accept a response
    auto wBready1 = writePort(b, readMod, 1, "s_axil_bready", mkInt(1, 1));

    // Set the address we want to write
    auto wAddr = writePort(b, readMod, addrWidth, "s_axil_awaddr", addrValShifted);
    auto wAWValid = writePort(b, readMod, 1, "s_axil_awvalid", mkInt(1, 1));
    auto wDataValid0 = writePort(b, readMod, 1, "s_axil_wvalid", mkInt(1, 1));
    auto wData0 = writePort(b, readMod, dataWidth, "s_axil_wdata", inData);
    auto wStrb = writePort(b, readMod, strbWidth, "s_axil_wstrb", mkInt(15, strbWidth));

    auto stallOnWriteDataReady = stallOnPort(b, readMod, 1, "s_axil_wready", exec);
    auto stallOnAWValid = stallOnPort(b, readMod, 1, "s_axil_awready", exec);

    exec.addConstraint(instrStart(wAddr) < instrStart(stallOnAWValid));
    
    exec.addConstraint(instrStart(wAddr) == instrStart(wAWValid));
    exec.addConstraint(instrStart(wAddr) == instrStart(wData0));
    exec.addConstraint(instrStart(wAddr) == instrStart(wStrb));        

    exec.addConstraint(instrStart(wDataValid0) == instrStart(wAWValid));
    exec.addConstraint(instrStart(wDataValid0) == instrStart(wData0));        
    exec.addConstraint(instrStart(stallOnWriteDataReady) > instrEnd(wAWValid));

    auto wAWValid0 = writePort(b, readMod, 1, "s_axil_awvalid", mkInt(1, 1));
    auto wData = writePort(b, readMod, dataWidth, "s_axil_wdata", inData);
    auto wDataValid = writePort(b, readMod, 1, "s_axil_wvalid", mkInt(1, 1));
    exec.addConstraint(instrEnd(stallOnWriteDataReady) == instrStart(wData));
    exec.addConstraint(instrEnd(stallOnWriteDataReady) == instrStart(wDataValid));
    exec.addConstraint(instrEnd(stallOnWriteDataReady) == instrStart(wAWValid0));

    auto stallOnBValid = stallOnPort(b, readMod, 1, "s_axil_bvalid", exec);

    exec.addConstraint(instrEnd(stallOnWriteDataReady) == instrStart(stallOnBValid));
    exec.addConstraint(instrStart(wBready1) == instrStart(wAWValid));

    //exec.addConstraint(instrStart(wBready1) == instrStart(stallOnBValid));
    //exec.addConstraint(instrEnd(stallOnWriteDataReady) < instrStart(stallOnBValid));

    auto ret = b.CreateRet(nullptr);

    exec.addConstraint(instrEnd(stallOnBValid) + 1 == instrStart(ret));

    cout << "# of user defined constraints on AXI write = " << exec.constraints.size() << endl;

    addDataConstraints(axiWrite, exec);

    cout << "Total # of constraints on AXI write = " << exec.constraints.size() << endl;
    cout << "axilRawRead = " << endl;
    cout << valueString(axiWrite) << endl;

  }

  void implementRawAXIRead(llvm::Function* axiRead,
                           ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", axiRead);
    IRBuilder<> b(eb);

    auto readMod = getArg(axiRead, 0);
    cout << "ReadMod = " << valueString(readMod) << endl;
    
    auto axiTp = getPointedToType(readMod->getType());

    auto outType = axiRead->getReturnType();
    int dataWidth = getTypeBitWidth(outType);
    int addrWidth = 32;

    cout << "axi read width = " << dataWidth << endl;

    auto readDataF = readPort("s_axil_rdata", dataWidth, axiTp);
    auto writeAddrF = writePort("s_axil_araddr", addrWidth, axiTp);

    auto arValidF = writePort("s_axil_arvalid", 1, axiTp);

    cout << "Creating rawAXIRead definition" << endl;

    // Set address data and wait for slave to be ready for read address
    auto addrVal = getArg(axiRead, 1);

    // State placeholder, replace with start of basic block?
    auto rdStart = b.CreateCall(readDataF, {readMod});

    auto addrValShifted = b.CreateShl(addrVal, mkInt(2, 32));
    auto setAddr = b.CreateCall(writeAddrF, {readMod, addrValShifted});
    auto setAddrValid = b.CreateCall(arValidF, {readMod, mkInt(1, 1)});
    exec.add(instrStart(setAddr) == instrStart(setAddrValid));
    exec.add(instrStart(setAddr) == instrEnd(rdStart) + 1);
    
    auto stallUntilReadAddrReady =
      stallOnPort(b, readMod, 1, "s_axil_arready", exec);
    exec.add(instrEnd(stallUntilReadAddrReady) > instrStart(setAddr));

    auto setReadReady = writePort(b, readMod, 1, "s_axil_rready", mkInt(1, 1));
    exec.add(instrEnd(stallUntilReadAddrReady) == instrStart(setReadReady));

    auto stallUntilReadRespReady =
      stallOnPort(b, readMod, 1, "s_axil_rvalid", exec);
    exec.add(instrStart(stallUntilReadRespReady) == instrStart(stallUntilReadAddrReady));
    
    auto dataValue = b.CreateCall(readDataF, {readMod});
    exec.add(instrStart(dataValue) == instrEnd(stallUntilReadRespReady));
    b.CreateRet(dataValue);

    cout << "# of user defined constraints on AXI read = " << exec.constraints.size() << endl;

    addDataConstraints(axiRead, exec);

    cout << "Total # of constraints on AXI read = " << exec.constraints.size() << endl;
    cout << "axilRawRead = " << endl;
    cout << valueString(axiRead) << endl;

  }
  
  std::ostream& operator<<(std::ostream& out, const ModuleSpec& m) {
    out << "module_spec " << m.name << endl;
    out << tab(1) << "ports" << endl;
    for (auto pt : m.ports) {
      out << tab(2) << pt.first << " -> " << pt.second.name << endl;
    }

    out << tab(1) << "defaults" << endl;
    for (auto pt : m.defaultValues) {
      out << tab(2) << pt.first << " -> " << pt.second << endl;
    }


    out << tab(1) << "insensitive ports" << endl;
    for (auto pt : m.insensitivePorts) {
      out << tab(2) << pt << endl;
    }
    

    return out;
  }

  // Q: Should the bus specification be an interface to Values of type
  //    T, or values of type T*? Should you read by value from a bus?
  // Q: What cases do I want to think about?
  // A: 1. Register banks
  //    2. Banked memories
  //    3. 
  ModuleSpec busSpec(llvm::StructType* tp) {
    ModuleSpec modSpec;
    //Type* innerArrayType();
    modSpec.name = "bus_of_some_random_type";
    return modSpec;
  }

  ModuleSpec streamAxiPackedStencilSpec(const int valueWidth, const int nRows, const int nCols) {
    ModuleSpec modSpec;
    modSpec.name = "HLS_stream";
    modSpec.hasClock = true;
    modSpec.hasRst = true;

    int dataBusWidth = valueWidth*nRows*nCols;
    int lastBusWidth = 1;

    // Unpacked data outputs
    modSpec.ports.insert({"data_bus", outputPort(dataBusWidth, "data_bus")});
    modSpec.ports.insert({"last_bus", outputPort(lastBusWidth, "last_bus")});

    modSpec.ports.insert({"in_data_bus", inputPort(dataBusWidth, "in_data_bus")});
    modSpec.ports.insert({"in_last_bus", inputPort(lastBusWidth, "in_last_bus")});
    
    // Control ports
    modSpec.ports.insert({"write_valid", inputPort(1, "write_valid")});
    modSpec.ports.insert({"write_ready", outputPort(1, "write_ready")});
    modSpec.ports.insert({"read_valid", inputPort(1, "read_valid")});
    modSpec.ports.insert({"read_ready", outputPort(1, "read_ready")});

    modSpec.params.insert({"VALUE_WIDTH", to_string(valueWidth)});
    modSpec.params.insert({"NROWS", to_string(nRows)});
    modSpec.params.insert({"NCOLS", to_string(nCols)});

    modSpec.defaultValues["write_valid"] = 0;
    modSpec.defaultValues["read_valid"] = 0;
    return modSpec;
  }

  ModuleSpec packedStencilSpec(const int valueWidth, const int nRows, const int nCols) {
    ModuleSpec modSpec;
    modSpec.name = "PackedStencil";
    modSpec.hasClock = true;    
    return modSpec;
  }

  ModuleSpec axiPackedStencilSpec(const int valueWidth, const int nRows, const int nCols) {
    ModuleSpec modSpec;
    modSpec.name = "AxiPackedStencil";
    modSpec.hasClock = true;

    // TODO: Compute this
    int width = 16;
    modSpec.ports["in_data_bus"] = inputPort(width, "in_data_bus");
    modSpec.ports["in_last_bus"] = inputPort(1, "in_last_bus");
    modSpec.ports["set_data"] = inputPort(1, "set_data");
    modSpec.ports["data_bus"] = outputPort(width, "data_bus");
    modSpec.ports["last_bus"] = outputPort(1, "last_bus");

    modSpec.ports["get_value"] = outputPort(width, "get_value");
    modSpec.ports["get_row"] = inputPort(clog2(width), "get_row");    
    modSpec.ports["get_col"] = inputPort(clog2(width), "get_col");    

    modSpec.ports["set_value"] = inputPort(width, "set_value");
    modSpec.ports["set_row"] = inputPort(clog2(width), "set_row");    
    modSpec.ports["set_col"] = inputPort(clog2(width), "set_col");    
    modSpec.ports["set_en"] = inputPort(1, "set_en");        

    modSpec.ports["set_last_en"] = inputPort(1, "set_last_en");
    modSpec.ports["set_last_value"] = inputPort(1, "set_last_value");

    modSpec.defaultValues["set_data"] = 0;
    modSpec.defaultValues["set_en"] = 0;    
    modSpec.defaultValues["set_last_en"] = 0;    
    return modSpec;
  }

  ModuleSpec stencilSpec(const int valueWidth, const int nRows, const int nCols) {
    ModuleSpec modSpec;
    modSpec.name = "Stencil";
    modSpec.hasClock = true;
    return modSpec;
  }

  // Next step: Write a unit test that just reads a stencil from an AxiStream,
  // writes it to a temporary, and then writes that temporary to a different
  // stream
  void implementStencilCall(llvm::Function* stencilCall,
                            ExecutionConstraints& exec) {
    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);
    b.CreateRet(mkInt(5, 16));
  }

  void implementStencilWrite(llvm::Function* stencilCall,
                             ExecutionConstraints& exec) {
    assert(stencilCall->getReturnType() == voidType());

    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);

    auto stream = getArg(stencilCall, 0);
    auto inDataPtr = getArg(stencilCall, 1);

    assert(PointerType::classof(stream->getType()));    
    assert(PointerType::classof(inDataPtr->getType()));

    auto streamTp = dyn_cast<PointerType>(stream->getType())->getElementType();
    auto dataTp = dyn_cast<PointerType>(inDataPtr->getType())->getElementType();

    // TODO: Compute this from the input type
    int width = 16;

    auto writeDataF = writePort("in_data_bus", width, streamTp);
    auto writeLastF = writePort("in_last_bus", 1, streamTp);    

    auto readReadyF = readPort("write_ready", 1, streamTp);
    auto setValidF = writePort("write_valid", 1, streamTp);
    auto stallF = stallFunction();

    auto readStencilDataF = readPort("data_bus", width, dataTp);
    auto readStencilLastF = readPort("last_bus", 1, dataTp);    

    auto readReady = b.CreateCall(readReadyF, {stream});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {stream, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {stream, mkInt(0, 1)});

    auto readStencilLast = b.CreateCall(readStencilLastF, {inDataPtr});
    auto readStencilData = b.CreateCall(readStencilDataF, {inDataPtr});    

    auto writeData = b.CreateCall(writeDataF, {stream, readStencilData});
    auto writeLast = b.CreateCall(writeLastF, {stream, readStencilLast});    
    //auto data = b.CreateLoad(dataPtr);
    //auto writeValue = b.CreateCall(writeDataF, {out, data});
      
    b.CreateRet(nullptr);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrStart(setValid1) == instrStart(writeData));
    exec.addConstraint(instrStart(setValid1) == instrStart(writeLast));

    exec.addConstraint(instrStart(setValid1) == instrStart(readStencilData));
    exec.addConstraint(instrStart(setValid1) == instrStart(readStencilLast));    
    
    // exec.addConstraint(instrEnd(data) == instrStart(data));
    // exec.addConstraint(instrEnd(data) == instrStart(writeValue));    
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));
    addDataConstraints(stencilCall, exec);
  }

  void implementStencilRead(llvm::Function* stencilCall,
                            ExecutionConstraints& exec) {
    assert(stencilCall->getReturnType() == voidType());

    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);

    auto stream = getArg(stencilCall, 1);
    auto inDataPtr = getArg(stencilCall, 0);

    assert(PointerType::classof(stream->getType()));    
    assert(PointerType::classof(inDataPtr->getType()));

    auto streamTp = dyn_cast<PointerType>(stream->getType())->getElementType();
    auto dataTp = dyn_cast<PointerType>(inDataPtr->getType())->getElementType();

    // TODO: Compute this from the input type
    int width = 16;

    auto readDataF = readPort("data_bus", width, streamTp);
    auto readLastF = readPort("last_bus", 1, streamTp);

    auto writeDataToStencilF = writePort("in_data_bus", width, dataTp);
    auto writeLastToStencilF = writePort("in_last_bus", 1, dataTp);
    auto setStencilF = writePort("set_data", 1, dataTp);        
    
    auto readReadyF = readPort("read_ready", 1, streamTp);
    auto setValidF = writePort("read_valid", 1, streamTp);
    auto stallF = stallFunction();

    auto readReady = b.CreateCall(readReadyF, {stream});
    auto stallUntilReady = b.CreateCall(stallF, {readReady});
    auto setValid1 = b.CreateCall(setValidF, {stream, mkInt(1, 1)});
    auto setValid0 = b.CreateCall(setValidF, {stream, mkInt(0, 1)});

    // Data read process:
    // 1. Read data out of ready-valid channel ports
    // 2. Write it to the target stencil
    auto readData = b.CreateCall(readDataF, {stream});
    auto readLast = b.CreateCall(readLastF, {stream});
    auto writeDataToStencil = b.CreateCall(writeDataToStencilF, {inDataPtr, readData});
    auto writeLastToStencil = b.CreateCall(writeLastToStencilF, {inDataPtr, readLast});
    auto setStencil = b.CreateCall(setStencilF, {inDataPtr, mkInt(1, 1)});
      
    b.CreateRet(nullptr);
    
    exec.addConstraint(instrStart(readReady) == instrStart(stallUntilReady));
    exec.addConstraint(instrEnd(stallUntilReady) < instrStart(setValid1));
    exec.addConstraint(instrEnd(setValid1) + 1 == instrStart(setValid0));

    exec.add(instrStart(setValid0) == instrStart(readData));
    exec.add(instrStart(setValid0) == instrStart(readLast));    

    exec.add(instrStart(setValid0) == instrStart(writeDataToStencil));
    exec.add(instrStart(setValid0) == instrStart(writeLastToStencil));
    exec.add(instrStart(setValid0) == instrStart(setStencil));        

    addDataConstraints(stencilCall, exec);
    
    b.CreateRet(nullptr);
  }

  void implementStencilSetLast(llvm::Function* stencilCall,
                               ExecutionConstraints& exec) {
    assert(stencilCall->getReturnType() == voidType());    
    assert(stencilCall->arg_size() == 2);

    auto stencil = getArg(stencilCall, 0);
    auto value = getArg(stencilCall, 1);

    assert(PointerType::classof(stencil->getType()));    

    auto stencilTp = dyn_cast<PointerType>(stencil->getType())->getElementType();
    
    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);
    auto setValueF = writePort("set_last_value", 1, stencilTp);
    auto setEnF = writePort("set_last_en", 1, stencilTp);

    auto setEn = b.CreateCall(setEnF, {stencil, mkInt(1, 1)});    
    auto setValue = b.CreateCall(setValueF, {stencil, value});

    auto ret = b.CreateRet(nullptr);
    
    exec.add(instrStart(setValue) == instrStart(setEn));
    exec.add(instrEnd(ret) == instrStart(setValue) + 1);

    addDataConstraints(stencilCall, exec);
  }
  
  void implementStencilSet(llvm::Function* stencilCall,
                           ExecutionConstraints& exec) {
    assert(stencilCall->getReturnType() == voidType());    
    assert(stencilCall->arg_size() == 5);

    auto stencil = getArg(stencilCall, 0);
    auto value = getArg(stencilCall, 1);
    auto ind0 = getArg(stencilCall, 2);
    auto ind1 = getArg(stencilCall, 3);
    //auto ind2 = getArg(stencilCall, 4);

    assert(PointerType::classof(stencil->getType()));    

    auto stencilTp = dyn_cast<PointerType>(stencil->getType())->getElementType();
    
    int dataWidth = getValueBitWidth(value);

    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);
    auto writeValueF = writePort("set_value", dataWidth, stencilTp);
    auto setRowF = writePort("set_row", clog2(dataWidth), stencilTp);
    auto setColF = writePort("set_col", clog2(dataWidth), stencilTp);
    auto setEnF = writePort("set_en", 1, stencilTp);

    auto setRow = b.CreateCall(setRowF, {stencil, ind0});
    auto setCol = b.CreateCall(setColF, {stencil, ind1});
    auto setEn = b.CreateCall(setEnF, {stencil, mkInt(1, 1)});    
    auto setValue = b.CreateCall(writeValueF, {stencil, value});

    auto ret = b.CreateRet(nullptr);
    
    exec.add(instrStart(setCol) == instrStart(setRow));
    exec.add(instrStart(setCol) == instrStart(setEn));    
    exec.add(instrEnd(setCol) == instrStart(setValue));
    exec.add(instrEnd(ret) == instrStart(setValue) + 1);

    addDataConstraints(stencilCall, exec);
  }

  void implementStencilGet(llvm::Function* stencilCall,
                           ExecutionConstraints& exec) {
    assert(stencilCall->arg_size() == 4);

    auto stencil = getArg(stencilCall, 0);
    auto ind0 = getArg(stencilCall, 1);
    auto ind1 = getArg(stencilCall, 2);
    //auto ind2 = getArg(stencilCall, 3);

    assert(PointerType::classof(stencil->getType()));    

    auto stencilTp = dyn_cast<PointerType>(stencil->getType())->getElementType();
    
    int dataWidth = 16;

    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);
    auto readValueF = readPort("get_value", dataWidth, stencilTp);
    auto setRowF = writePort("get_row", clog2(dataWidth), stencilTp);
    auto setColF = writePort("get_col", clog2(dataWidth), stencilTp);

    auto setRow = b.CreateCall(setRowF, {stencil, ind0});
    auto setCol = b.CreateCall(setColF, {stencil, ind1});
    auto readValue = b.CreateCall(readValueF, {stencil});

    auto ret = b.CreateRet(readValue);
    
    exec.add(instrStart(setCol) == instrStart(setRow));
    exec.add(instrEnd(ret) == instrStart(readValue));
    exec.add(instrEnd(ret) == instrStart(setRow));
    addDataConstraints(stencilCall, exec);
  }

  void implementStencilConstructor(llvm::Function* stencilCall,
                                   ExecutionConstraints& exec) {
    assert(stencilCall->getReturnType() == voidType());

    if (stencilCall->arg_size() == 1) {
      auto eb = mkBB("entry_block", stencilCall);
      IRBuilder<> b(eb);
      b.CreateRet(nullptr);
      return;
    }

    cout << "# of args = " << stencilCall->arg_size() << " to " << valueString(stencilCall) << endl;
    assert(stencilCall->arg_size() == 2);

    auto eb = mkBB("entry_block", stencilCall);
    IRBuilder<> b(eb);

    auto target = getArg(stencilCall, 0);
    auto source = getArg(stencilCall, 1);

    assert(PointerType::classof(target->getType()));    
    assert(PointerType::classof(source->getType()));

    auto targetTp = dyn_cast<PointerType>(target->getType())->getElementType();
    auto sourceTp = dyn_cast<PointerType>(source->getType())->getElementType();

    assert(targetTp == sourceTp);

    // TODO: Compute this from the input type
    int width = 16;

    auto readDataF = readPort("data_bus", width, sourceTp);
    auto readLastF = readPort("last_bus", 1, sourceTp);

    auto writeDataToStencilF = writePort("in_data_bus", width, targetTp);
    auto writeLastToStencilF = writePort("in_last_bus", 1, targetTp);
    auto setStencilF = writePort("set_data", 1, targetTp);        
    
    // Data read process:
    // 1. Read data out of ready-valid channel ports
    // 2. Write it to the target stencil
    auto readData = b.CreateCall(readDataF, {source});
    auto readLast = b.CreateCall(readLastF, {source});

    auto writeDataToStencil = b.CreateCall(writeDataToStencilF, {target, readData});
    auto writeLastToStencil = b.CreateCall(writeLastToStencilF, {target, readLast});
    auto setStencil = b.CreateCall(setStencilF, {target, mkInt(1, 1)});    
      
    b.CreateRet(nullptr);
    
    exec.add(instrStart(setStencil) == instrStart(readData));
    exec.add(instrStart(setStencil) == instrStart(readLast));    

    exec.add(instrStart(setStencil) == instrStart(writeDataToStencil));
    exec.add(instrStart(setStencil) == instrStart(writeLastToStencil));

    addDataConstraints(stencilCall, exec);
    
    b.CreateRet(nullptr);
  }
  
  ModuleSpec ramSpec(const int width, const int depth, const int numReadPorts, const int numWritePorts) {

    int addrWidth = clog2(depth);

    map<string, int> defaults;

    set<string> insensitive;
    
    map<string, Port> ramPorts = {
      {"rst", inputPort(1, "rst")}
    };

    for (int i = 0; i < numReadPorts; i++) {
      auto iStr = to_string(i);
      ramPorts["raddr_" + iStr] = inputPort(addrWidth, "raddr_" + iStr);
      ramPorts["rdata_" + iStr] = outputPort(width, "rdata_" + iStr);
      //defaults.insert({"raddr_" + iStr, 0});
      insensitive.insert("raddr_" + iStr);
    }

    for (int i = 0; i < numWritePorts; i++) {
      auto iStr = to_string(i);
      ramPorts["waddr_" + iStr] = inputPort(addrWidth, "waddr_" + iStr);
      ramPorts["wdata_" + iStr] = inputPort(width, "wdata_" + iStr);
      ramPorts["wen_" + iStr] = inputPort(1, "wen_" + iStr);

      insensitive.insert("waddr_" + iStr); //{"waddr_" + iStr, 0});
      insensitive.insert("wdata_" + iStr); //{"wdata_" + iStr, 0});
      defaults.insert({"wen_" + iStr, 0});            
    }

    ramPorts["debug_addr"] = inputPort(addrWidth, "debug_addr");
    ramPorts["debug_data"] = outputPort(width, "debug_data");

    ramPorts["debug_write_addr"] = inputPort(addrWidth, "debug_write_addr");
    ramPorts["debug_write_en"] = inputPort(1, "debug_write_en");
    ramPorts["debug_write_data"] = inputPort(width, "debug_write_data");    

    string name = "RAM";
    assert(numWritePorts == 1);
    if (numReadPorts > 1) {
      name += to_string(numReadPorts);
    }


    ModuleSpec mSpec = {{{"WIDTH", to_string(width)}, {"DEPTH", to_string(depth)}}, name, ramPorts, defaults, insensitive};

    mSpec.hasClock = true;
    return mSpec;
  }
  
  ModuleSpec ramSpec(const int width, const int depth) {
    return ramSpec(width, depth, 1, 1);
  }

  ModuleSpec registerModSpec(const int width) {
    map<string, string> modParams{{"WIDTH", to_string(width)}};
    
    map<string, Port> ports;
    addOutputPort(ports, width, "rdata");
    addInputPort(ports, width, "raddr");    

    addInputPort(ports, width, "wdata");
    addInputPort(ports, width, "waddr");    
    addInputPort(ports, 1, "wen");

    map<string, int> defaults{{"wen", 0}};

    set<string> insensitivePorts = {"raddr", "waddr", "wdata"};
    
    ModuleSpec mSpec = {modParams, "register", ports, defaults, insensitivePorts};
    mSpec.hasClock = true;
    mSpec.hasRst = true;
    return mSpec;
  }

  void implementRAMRead(Function* ramRead1, ExecutionConstraints& exec, const int portNo) {
    int addrWidth = getValueBitWidth(getArg(ramRead1, 1));
    int width = getTypeBitWidth(ramRead1->getReturnType());
    auto sramTp = getArg(ramRead1, 0)->getType();

    string iStr = to_string(portNo);
    auto waddr0F = writePort("raddr_" + iStr, addrWidth, sramTp);
    auto rdata0F = readPort("rdata_" + iStr, width, sramTp);

    auto sram = getArg(ramRead1, 0);
    auto addr = getArg(ramRead1, 1);

    auto bb = mkBB("entry_block", ramRead1);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto readData = eb.CreateCall(rdata0F, {sram});
    eb.CreateRet(readData);

    exec.add(instrStart(setAddr) + 1 == instrStart(readData));

    addDataConstraints(ramRead1, exec);
  }
  
  void implementRAMRead0(Function* ramRead0, ExecutionConstraints& exec) {
    return implementRAMRead(ramRead0, exec, 0);
  }

  void implementRAMRead1(Function* ramRead1, ExecutionConstraints& exec) {
    return implementRAMRead(ramRead1, exec, 1);    
  }

  void implementRAMRead2(Function* ramRead1, ExecutionConstraints& exec) {
    return implementRAMRead(ramRead1, exec, 2);
  }

  void implementRAMWrite0(Function* ramWrite0, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramWrite0, 1));
    int width = getValueBitWidth(getArg(ramWrite0, 2));
    auto sramTp = ramWrite0->getReturnType();

    //ExecutionConstraints& exec = interfaces.getConstraints(ramWrite0);
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
    // auto setEn0 = eb.CreateCall(wen0F, {sram, mkInt(0, 1)});
    auto ret = eb.CreateRet(nullptr);

    exec.add(instrStart(setAddr) == instrStart(setData));
    exec.add(instrStart(setAddr) == instrStart(setEn1));

    // TODO: Replace start(ret) with end(inlineMarker)?
    exec.add(instrStart(setAddr) + 3 == instrStart(ret));

    addDataConstraints(ramWrite0, exec);

  }

  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces,
                             std::set<BasicBlock*>& toPipeline,
                             ExecutionConstraints& exec);
  
  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces,
                             std::set<BasicBlock*>& toPipeline) {
    ExecutionConstraints exec;
    return scheduleInterface(f, hcs, interfaces, toPipeline, exec);
  }
  
  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces,
                             std::set<BasicBlock*>& toPipeline,
                             ExecutionConstraints& exec) {

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    addDataConstraints(f, exec);
    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // cout << "Constraints after inlining" << endl;
    // for (auto c : exec.constraints) {
    //   cout << tab(1) << *c << endl;
    // }
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    return s;
  }

  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces) {
    set<BasicBlock*> toPipeline;
    return scheduleInterface(f, hcs, interfaces, toPipeline);
  }

  void addInputPort(map<string, Port>& ports,
                    const int width,
                    const std::string name) {
    ports.insert({name, inputPort(width, name)});
  }

  void addOutputPort(map<string, Port>& ports,
                     const int width,
                     const std::string name) {
   ports.insert({name, outputPort(width, name)});
  }
  
  ModuleSpec axiRamSpec(llvm::StructType* tp) {
    int addrWidth = 16;
    int dataWidth = 32;    
    int strbWidth = 32 / 8;
    
    map<string, string> modParams{{"ADDR_WIDTH", to_string(addrWidth)},
        {"DATA_WIDTH", to_string(dataWidth)}};
    
    map<string, Port> ports;
    addInputPort(ports, addrWidth, "s_axil_awaddr");
    addInputPort(ports, 3, "s_axil_awprot");
    addInputPort(ports, 1, "s_axil_awvalid");

    addOutputPort(ports, 1, "s_axil_awready");    

    addInputPort(ports, dataWidth, "s_axil_wdata");            
    addInputPort(ports, strbWidth, "s_axil_wstrb");
    addInputPort(ports, 1, "s_axil_wvalid");

    addOutputPort(ports, 1, "s_axil_wready");
    addOutputPort(ports, 2, "s_axil_bresp");                
    addOutputPort(ports, 1, "s_axil_bvalid");

    addInputPort(ports, 1, "s_axil_bready");

    addInputPort(ports, addrWidth, "s_axil_araddr");
    addInputPort(ports, 3, "s_axil_arprot");
    addInputPort(ports, 1, "s_axil_arvalid");

    addOutputPort(ports, 1, "s_axil_arready");
    addOutputPort(ports, dataWidth, "s_axil_rdata");
    addOutputPort(ports, 2, "s_axil_rresp");
    addOutputPort(ports, 1, "s_axil_rvalid");

    addInputPort(ports, 1, "s_axil_rready");

    addOutputPort(ports, dataWidth, "debug_data");        
    addInputPort(ports, addrWidth, "debug_addr");    
    addInputPort(ports, 1, "debug_wr_en");
    addInputPort(ports, addrWidth, "debug_wr_addr");
    addInputPort(ports, dataWidth, "debug_wr_data");        

    map<string, int> defaults{{"s_axil_arvalid", 0},
        {"s_axil_awvalid", 0},
          {"s_axil_wvalid", 0},
            {"s_axil_wstrb", (1 << 5) - 1},          
              {"s_axil_rready", 1}};

    set<string> insensitivePorts{"s_axil_wdata",
        "s_axil_awaddr",
        "s_axil_awprot",
        "s_axil_araddr",
        "s_axil_arprot"};
    
    ModuleSpec mSpec = {modParams, "axil_ram", ports, defaults, insensitivePorts};
    mSpec.hasClock = true;
    mSpec.hasRst = true;
    return mSpec;
  }

  // Moved
  ModuleSpec fifoSpec32(StructType* tp) {
    return fifoSpec(32, 16);
  }

  ModuleSpec medianFilterSpec() {

    //int addrWidth = 16;
    int dataWidth = 32;
    int pixelDataWidth = 8;
    
    map<string, string> modParams;
    
    map<string, Port> ports;
    addInputPort(ports, dataWidth, "word0");
    addInputPort(ports, dataWidth, "word1");
    addInputPort(ports, dataWidth, "word2");        
    addInputPort(ports, 1, "rst_n");        

    addOutputPort(ports, 4*pixelDataWidth, "median_word");    
    
    map<string, int> defaults{};

    set<string> insensitive{"word0", "word1", "word2"};
    
    ModuleSpec mSpec = {modParams, "median", ports, defaults, insensitive};
    mSpec.hasClock = true;
    return mSpec;

  }

  void implementRunMedian(llvm::Function* f, ExecutionConstraints& exec) {
    auto bb = mkBB("entry_block", f);
    IRBuilder<> b(bb);

    // call implementRVFIFORead / write to get function implementations?

    // Q: What should the functionality be here?
    // A: Call reset and then loop over the design?
    //    How to implement the loop I guess as a phi?
    //    I can worry about details once I have a simple example working
    
    auto filterMod = getArg(f, 0);
    auto in1Fifo = getArg(f, 1);
    auto in2Fifo = getArg(f, 2);
    auto in3Fifo = getArg(f, 3);        
    auto outFifo = getArg(f, 4);

    auto filterTp = getPointedToType(filterMod->getType());
    auto channelType = getPointedToType(in1Fifo->getType());

    auto setRst1 = writePort(b, filterMod, 1, "rst_n", mkInt(1, 1));
    auto setRst0 = writePort(b, filterMod, 1, "rst_n", mkInt(0, 1));
    auto setRst1Last = writePort(b, filterMod, 1, "rst_n", mkInt(1, 1));    

    exec.add(instrEnd(setRst1) < instrStart(setRst0));
    exec.add(instrEnd(setRst0) < instrStart(setRst1Last));

    auto exitBB = mkBB("exit_block", f);
    IRBuilder<> eb(exitBB);
    eb.CreateRet(nullptr);

    // Create loop structure
    int imgWidth = 320;
    int imgHeight = 320;
    int numPixels = imgWidth * imgHeight;
    int channelWidth = 32;
    int numChannels = 3;
    int pixelWidth = 8;
    int pixelsPerCycle = (channelWidth * numChannels) / pixelWidth;
    int numReads = numPixels / pixelsPerCycle;

    InterfaceFunctions interfaces;
    Function* readChannel =
      mkFunc({channelType->getPointerTo()}, intType(32), "read_channel");
    interfaces.addFunction(readChannel);
    //implementRVFifoRead(readChannel, interfaces.getConstraints(readChannel));
    implementWireRead(readChannel); //, interfaces.getConstraints(readChannel));

    Function* writeChannel =
      mkFunc({intType(32), channelType->getPointerTo()}, voidType(), "write_channel");
    interfaces.addFunction(writeChannel);
    //implementRVFifoWriteRef(writeChannel, interfaces.getConstraints(writeChannel));
    //implementRVFifoWrite(writeChannel, interfaces.getConstraints(writeChannel));
    implementWireWrite(writeChannel); //, interfaces.getConstraints(writeChannel));

    auto readMedianOut = readPort("median_word", 32, filterTp);

    BasicBlock* loop =
      sivLoop(f, bb, exitBB, numReads, [writeChannel, filterMod, filterTp, readMedianOut, readChannel, in1Fifo, in2Fifo, in3Fifo, outFifo](IRBuilder<>& b, Value* i) {
          // Read from each channel
          auto r1 = b.CreateCall(readChannel, {in1Fifo});
          auto r2 = b.CreateCall(readChannel, {in2Fifo});
          auto r3 = b.CreateCall(readChannel, {in3Fifo});

          writePort(b, filterMod, 32, "word0", r1);
          writePort(b, filterMod, 32, "word1", r2);
          writePort(b, filterMod, 32, "word2", r3);                    

          auto output = b.CreateCall(readMedianOut, {filterMod});
          b.CreateCall(writeChannel, {output, outFifo});
        });

    b.CreateBr(loop);

    inlineWireCalls(f, exec, interfaces);
  }

  ModuleSpec ipReceiverSpec() {
    ModuleSpec m;
    m.name = "ip_eth_rx";
    m.hasClock = true;
    m.hasRst = true;
    
    return m;
  }

  ModuleSpec counterSpec() {
    ModuleSpec m;
    m.name = "register";
    addInputPort(m.ports, 1, "wen");
    addInputPort(m.ports, 32, "wdata");
    addInputPort(m.ports, 32, "waddr");
    addOutputPort(m.ports, 32, "rdata");
    m.hasClock = true;
    m.hasRst = true;
    return m;
  }

  void implementIncrement(llvm::Function* f, ExecutionConstraints& exec) {
    auto bb = mkBB("entry_block", f);
    IRBuilder<> b(bb);

    auto counterMod = getArg(f, 0);

    auto curVal = readPort(b, counterMod, 32, "rdata");
    auto setWen = writePort(b, counterMod, 1, "wen", mkInt(1, 1));
    auto setData = writePort(b, counterMod, 32, "wdata", b.CreateAdd(curVal, mkInt(1, 32)));

    b.CreateRet(nullptr);

    exec.add(instrStart(curVal) == instrStart(setWen));
    exec.add(instrStart(curVal) == instrStart(setData));
  }
  
  void implementGetAddrsRV(llvm::Function* f, ExecutionConstraints& exec) {
    auto bb = mkBB("entry_block", f);
    IRBuilder<> b(bb);
    
    b.CreateRet(mkInt(3, 64));
  }

  ModuleSpec ramSpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 1, 1);
  }

  ModuleSpec ram2SpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 2, 1);
  }

  ModuleSpec ram3SpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 3, 1);
  }

  void sequentialCalls(llvm::Function* f,
                       ExecutionConstraints& exec) {
    for (auto& bb : f->getBasicBlockList()) {
      Instruction* first = nullptr;
      Instruction* second = nullptr;
      for (auto& instrP : bb) {
        auto instr = &instrP;
        if (CallInst::classof(instr)) {
          first = second;
          second = instr;
          if ((second != nullptr) && (first != nullptr)) {
            exec.addConstraint(instrEnd(first) < instrStart(second));
          }
        }
      }
    }
  }
  
}
