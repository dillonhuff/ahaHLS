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

using namespace dbhc;
using namespace llvm;
using namespace std;
using namespace z3;

namespace DHLS {

  void
  addMemoryConstraints(llvm::Function* f,
                       HardwareConstraints& hdc,
                       std::set<BasicBlock*>& toPipeline,
                       AAResults& aliasAnalysis,
                       ScalarEvolution& sc,
                       SchedulingProblem& p);
  
  std::ostream& operator<<(std::ostream& out, const GuardedInstruction& t) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *(t.instruction);
    out << "\t\t" << ss.str() << " if " << t.cond << " in " << (t.instruction)->getParent()->getName().str() << std::endl;
    return out;
  }
  
  
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
    return hcs;
  }

  z3::expr toZ3(z3::context& c,
                const LinearConstraint& constraint);

  z3::expr toZ3(z3::context& c,
                const LinearExpression& expr);
  
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

      errs() << "Scheduling " << "\n" << valueString(&F) << "\n";
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
      if (contains_key(iptr, memoryMapping)) {
        Value* dest = map_find(iptr, memoryMapping);
        if (contains_key(dest, memSpecs)) {
          return map_find(dest, memSpecs).writeLatency;
        }
      }

      // If no spec is given use default
      latency = getLatency(STORE_OP);
    } else if (LoadInst::classof(iptr)) {

      if (contains_key(iptr, memoryMapping)) {
        Value* src = map_find(iptr, memoryMapping);
        if (contains_key(src, memSpecs)) {
          return map_find(src, memSpecs).readLatency;
        }
      }

      // If no spec for the memory being read, revert to default
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
      CallInst* call = dyn_cast<CallInst>(iptr);
      Function* called = call->getCalledFunction();

      //cout << "Called function = " << valueString(called) << endl;
      string name = called->getName();

      //cout << "Called name     = " << name << endl;

      if (hasPrefix(name, "builtin_read_fifo_")) {
        if (contains_key(call->getOperand(0), fifoSpecs)) {
          latency = map_find(call->getOperand(0), fifoSpecs).readDelay;
        } else {
          latency = 1;
        }
      } else if (hasPrefix(name, "builtin_write_fifo_")) {

        if (contains_key(call->getOperand(1), fifoSpecs)) {
          latency = map_find(call->getOperand(1), fifoSpecs).writeDelay;
        } else {
          latency = 1;
        }
      } else if (isBuiltinPortWrite(iptr)) {
        latency = 0;
      } else {
        // Value* func = call->getOperand(0);
        // cout << "Function name = " << valueString(func) << endl;
      
        // NOTE: For now the only call instructions are calls to lifetime start
        // and end calls that have no meaning in hardware
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

    cout << "Extracting model" << endl;
    for (auto& constraint : p.constraints) {
      cout << "Constraint = " << constraint << endl;
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

    cout << "Final model" << endl;
    cout << m << endl;
    
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

  // Very hard to know where to begin changing to a readport, writeport
  // formulation for channels. Id like to replace calls to read and write
  // FIFOs with calls to set ports, and Id like to change the code generation
  // API to output ports

  // Also: In the background of all this is the fact that the resource binding
  // code is still wrong in a subtle way that I dont understand, and that
  // the calling convention for readport and writeport functions needs to
  // take in a pointer to a resource, even though Im not sure which resource
  // will be bound to which call until after scheduling is finished.

  // Solution to binding: Assume always unique, then modify program later
  // to reflect resource constraints?

  // Maybe I should build the readport, writeport stuff using the FPU first
  // in a totally separate example, then figure out how to get preprocessing
  // (inlining?) code working to convert builtin fifo calls to readport,
  // and writeport code?

  // I also need to think about how to convert the readport, writeport API
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
            
            // Check RAR dependence
            if (isBuiltinFifoRead(&instr) && isBuiltinFifoRead(&otherInstr)) {

              Value* load0 = instr.getOperand(0);
              Value* load1 = otherInstr.getOperand(0);
              
              AliasResult aliasRes = aliasAnalysis.alias(load0, load1);
              if (aliasRes != NoAlias) {

                FifoInterface fifoTp = hdc.getFifoType(instr.getOperand(0));
                if (fifoTp == FIFO_RV) {
                  exe.addConstraint(instrEnd(&instr) <= instrStart(&otherInstr));
                  //p.addConstraint(p.instrEnd(&instr) <= p.instrStart(&otherInstr));
                } else {
                  assert(fifoTp == FIFO_TIMED);
                  //p.addConstraint(p.instrEnd(&instr) < p.instrStart(&otherInstr));
                  exe.addConstraint(instrEnd(&instr) < instrStart(&otherInstr));
                }
              }
            }

            // Check WAW dependence
            if (isBuiltinFifoWrite(&instr) && isBuiltinFifoWrite(&otherInstr)) {
              Value* store0 = instr.getOperand(1);
              Value* store1 = otherInstr.getOperand(1);
              
              AliasResult aliasRes = aliasAnalysis.alias(store0, store1);
              if (aliasRes != NoAlias) {

                FifoInterface fifoTp = hdc.getFifoType(instr.getOperand(1));
                if (fifoTp == FIFO_RV) {
                  //p.addConstraint(p.instrEnd(&instr) <= p.instrStart(&otherInstr));
                  exe.addConstraint(instrEnd(&instr) <= instrStart(&otherInstr));
                } else {
                  assert(fifoTp == FIFO_TIMED);
                  //p.addConstraint(p.instrEnd(&instr) < p.instrStart(&otherInstr));
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
              //exe.addConstraint(instrEnd(&instrA) < II*rawDD + instrStart(&instrB));
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

  // TODO: Add real compiler analysis to compute this
  int dependenceDistance(Instruction* const iptr,
                         Instruction* const jptr) {
    return 0;
  }

}
