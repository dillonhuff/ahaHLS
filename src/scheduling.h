#pragma once

#include "algorithm.h"
#include "utils.h"

#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>

namespace DHLS {

  std::string typeString(llvm::Type* const tptr);
  std::string instructionString(llvm::Instruction* const iptr);
  std::string valueString(llvm::Value* const iptr);

  static inline
  std::string valueString(llvm::Value& iptr) {
    return valueString(&iptr);
  }

  class ModuleSpec {
  public:
    std::map<std::string, std::string> params;
    std::string name;
  };

  class MemorySpec {
  public:
    int readLatency;
    int writeLatency;
    int numReadPorts;
    int numWritePorts;
    int width;
    int depth;
    bool addressable;
    ModuleSpec modSpec;
  };

  static inline MemorySpec registerSpec(const int width) {
    return {0, 1, 1, 1, width, 1, false, {{{"width", std::to_string(width)}}, "register"}};
  }

  static inline MemorySpec ramSpec(const int readLat,
                                   const int writeLat,
                                   const int nReadPorts,
                                   const int nWritePorts,
                                   const int width,
                                   const int depth) {
    return {readLat, writeLat, nReadPorts, nWritePorts, width, depth, true, {{{"width", std::to_string(32)}}, "RAM"}};
  }
  
  enum OperationType {
    RETURN_OP,
    PHI_OP,
    STORE_OP,
    LOAD_OP,
    ADD_OP,
    SUB_OP,
    MUL_OP,
    DIV_OP,
    SDIV_OP,
    CMP_OP,
    BR_OP,
    ZEXT_OP,
    SELECT_OP,
    NO_OP,
    SEXT_OP,
    CALL_OP,
  };

  static inline std::vector<OperationType> allOps() {
    return {
      RETURN_OP,
        PHI_OP,
        STORE_OP,
        LOAD_OP,
        ADD_OP,
        SUB_OP,
        MUL_OP,
        DIV_OP,
        SDIV_OP,
        CMP_OP,
        BR_OP,
        ZEXT_OP,
        SELECT_OP,
        NO_OP,
        SEXT_OP,
        CALL_OP
        };

  }

  OperationType opType(llvm::Instruction* const iptr);

  enum FifoInterface {
    FIFO_TIMED,
    FIFO_RV,
  };

  class FifoSpec {
  public:
    int readDelay;
    int writeDelay;
    FifoInterface interface;

    FifoSpec() : readDelay(0), writeDelay(0), interface(FIFO_RV) {}
    
    FifoSpec(const int rd_, const int wd_, const FifoInterface interface_) :
      readDelay(rd_), writeDelay(wd_), interface(interface_) {}
  };
  
  class HardwareConstraints {

    std::map<OperationType, int> latencies;
    std::map<OperationType, int> counts;
    
  public:

    std::map<llvm::Value*, MemorySpec> memSpecs;
    std::map<llvm::Instruction*, llvm::Value*> memoryMapping;

    std::map<llvm::Value*, FifoSpec> fifoSpecs;

    FifoInterface getFifoType(llvm::Value* const val) const {
      if (dbhc::contains_key(val, fifoSpecs)) {
        return dbhc::map_find(val, fifoSpecs).interface;
      }

      return FIFO_RV;
    }

    int getLatency(const OperationType op) const {
      return dbhc::map_find(op, latencies);
    }

    int getLatency(llvm::Instruction* iptr) const;

    bool isLimitedResource(const OperationType op) const {
      return dbhc::contains_key(op, counts);
    }

    int getCount(const OperationType op) const {
      // If not explicitly constrained we have an infinite number
      if (!dbhc::contains_key(op, counts)) {
        return 100000000;
      }

      return dbhc::map_find(op, counts);
    }
    
    void setLatency(const OperationType op, const int latency) {
      latencies[op] = latency;
    }

    void setCount(const OperationType op, const int count) {
      counts[op] = count;
    }
    
  };

  static inline
  void setMemSpec(const std::string& ramName,
                  HardwareConstraints& hcs,
                  llvm::Function* f,
                  MemorySpec spec) {
    bool found = false;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instr : bb) {
        if (llvm::AllocaInst::classof(&instr)) {
          if (instr.getName() == ramName) {
            hcs.memSpecs[llvm::dyn_cast<llvm::Value>(&instr)] = spec;
            found = true;
          }
        }
      }
    }

    assert(found);
  }

  static inline
  void setMemSpec(llvm::Value* const val,
                  HardwareConstraints& hcs,
                  MemorySpec spec) {
    hcs.memSpecs[val] = spec;
  }
  
  static inline
  void setAllAllocaMemTypes(HardwareConstraints& hcs,
                            llvm::Function* f,
                            MemorySpec spec) {
    //bool found = false;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instr : bb) {
        if (llvm::AllocaInst::classof(&instr)) {
          hcs.memSpecs[llvm::dyn_cast<llvm::Value>(&instr)] = spec;
          //found = true;
        }
      }
    }

    //assert(found);
  }
  
  static inline
  void addMemInfo(HardwareConstraints& hcs,
                  const std::map<llvm::Value*, MemorySpec>& mems) {
    for (auto m : mems) {
      assert(!dbhc::contains_key(m.first, hcs.memSpecs));
      hcs.memSpecs[m.first] = m.second;
      assert(dbhc::contains_key(m.first, hcs.memSpecs));
    }
  }

  class Schedule {

  public:
    std::map<llvm::Instruction*, std::vector<int> > instrTimes;
    std::map<llvm::BasicBlock*, std::vector<int> > blockTimes;
    std::map<llvm::BasicBlock*, int> pipelineSchedules;

    int startTime(llvm::Instruction* const instr) const {
      return dbhc::map_find(instr, instrTimes).front();
    }

    int clockTicksToFinish() const {
      int maxFinishTime = 0;
      for (auto b : blockTimes) {
        if (b.second.back() > maxFinishTime) {
          maxFinishTime = b.second.back();
        }
      }
      return maxFinishTime;
    }

    int numStates() const {
      return clockTicksToFinish() + 1;
    }

    void print(std::ostream& out) const {
      out << "Block times" << std::endl;
      for (auto i : blockTimes) {
        out << "\t" << i.first << " -> [";
        out << commaListString(i.second);
        out << "]" << std::endl;
      }

      out << "Instruction times" << std::endl;
      for (auto i : instrTimes) {
        out << "\t" << instructionString(i.first) << " -> [";
        out << commaListString(i.second);
        out << "]" << std::endl;
      }


    }

  };

  static inline std::ostream& operator<<(std::ostream& out, const Schedule& s) {
    s.print(out);
    return out;
  }
  
  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc);
  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<llvm::BasicBlock*>& toPipeline);
  
  Schedule schedulePipeline(llvm::BasicBlock* const bb, HardwareConstraints& hdc);

  // Logical condition used in state transitions

  class Atom {
  public:

    llvm::Value* cond;
    bool negated;
    Atom() : cond(nullptr), negated(false) {}
    Atom(llvm::Value* const cond_) : cond(cond_), negated(false) {}
    Atom(llvm::Value* const cond_, const bool negated_) :
      cond(cond_), negated(negated_) {}    
  };

  static inline std::ostream& operator<<(std::ostream& out, const Atom& c) {
    if (c.cond != nullptr) {

      if (c.negated) {
        out << "!(";
      }

      if (llvm::Instruction::classof(c.cond)) {
        out << instructionString(static_cast<llvm::Instruction* const>(c.cond));
      } else {
        out << valueString(c.cond);
      }

      if (c.negated) {
        out << ")";
      }

    } else {
      out << "True";
    }
    return out;
  }
  
  class Condition {
  public:

    std::vector<std::vector<Atom> > clauses;
    // llvm::Value* cond;
    // bool negated;
    Condition() : clauses({{}}) {}

    Condition(llvm::Value* const cond_) : clauses({{{cond_, false}}}) {}
    Condition(llvm::Value* const cond_, const bool negated_) :
      clauses({{{cond_, negated_}}}) {}      

    Condition(std::vector<std::vector<Atom > > cl) :
      clauses(cl) {}

    bool isTrue() const {
      return (clauses.size() == 1) && (clauses[0].size() == 0);
    }

  };

  static inline std::ostream& operator<<(std::ostream& out, const Condition& c) {
    if ((c.clauses.size() == 1) && (c.clauses[0].size() == 0)) {
      out << "True" << std::endl;
      return out;
    }

    int nCl = 0;
    for (auto cl : c.clauses) {

      int nAt = 0;

      out << "(";
      for (auto atom : cl) {
        out << atom;
        if (nAt < (int) (cl.size() - 1)) {
          out << " ^ ";
        }
        nAt++;
      }
      out << ")";

      if (nCl < (int) (c.clauses.size() - 1)) {
        out << " v ";
      }
      nCl++;
    }

    return out;
  }

  class GuardedInstruction {
  public:
    llvm::Instruction* instruction;
    Condition cond;
  };

  std::ostream& operator<<(std::ostream& out, const GuardedInstruction& t);

  typedef int StateId;

  class StateTransition {
  public:
    StateId dest;
    Condition cond;
  };

  static inline
  std::ostream&
  operator<<(std::ostream& out, const StateTransition& t) {
    out << t.dest << " if " << t.cond << std::endl;
    return out;
  }

  class Pipeline {
    int ii;
    int stateDepth;
    std::vector<StateId> states;    

  public:
    Pipeline(const int ii_,
             const int stateDepth_,
             const std::vector<StateId>& states_) :
      ii(ii_), stateDepth(stateDepth_), states(states_) {
      assert(II() >= 1);
      assert(depth() >= 1);
      assert(depth() == (int) states.size());
    }

    int II() const { return ii; }
    int depth() const { return stateDepth; }
    const std::vector<StateId>& getStates() const { return states; }
  };
  
  class StateTransitionGraph {
  public:

    Schedule sched;
    std::map<StateId, std::vector<GuardedInstruction> > opStates;
    std::map<StateId, std::vector<StateTransition> > opTransitions;
    std::vector<Pipeline> pipelines;

    StateTransitionGraph() {}

    llvm::Function* getFunction() const {
      auto& opSt = *(std::begin(opStates));
      return (opSt.second)[0].instruction->getParent()->getParent();
    }
    
    StateTransitionGraph(const StateTransitionGraph& other) {
      std::cout << "Calling stg const ref constructor" << std::endl;
      sched = other.sched;
      opStates = other.opStates;
      opTransitions = other.opTransitions;
      pipelines = other.pipelines;

      assert(sched.numStates() == other.sched.numStates());
      assert(opStates.size() == other.opStates.size());
      assert(opTransitions.size() == other.opTransitions.size());
      assert(pipelines.size() == other.pipelines.size());      
    }

    StateTransitionGraph(Schedule& sched_) : sched(sched_) {}

    StateId instructionStartState(llvm::Instruction* const instr) {
      return dbhc::map_find(instr, sched.instrTimes).front();
    }

    StateId instructionEndState(llvm::Instruction* const instr) {
      return dbhc::map_find(instr, sched.instrTimes).back();
    }
    
    std::vector<GuardedInstruction>
    instructionsFinishingAt(const StateId id) const {
      std::vector<GuardedInstruction> instrs;
      for (auto st : dbhc::map_find(id, opStates)) {
        llvm::Instruction* instr = st.instruction;
        if (id == dbhc::map_find(instr, sched.instrTimes).back()) {
          instrs.push_back(st);
        }
      }
      return instrs;
    }

    std::vector<GuardedInstruction>
    instructionsStartingAt(const StateId id) const {
      std::vector<GuardedInstruction> instrs;
      for (auto st : dbhc::map_find(id, opStates)) {
        llvm::Instruction* instr = st.instruction;
        if (id == dbhc::map_find(instr, sched.instrTimes).front()) {
          instrs.push_back(st);
        }
      }
      return instrs;
    }
    
    int numControlStates() const {
      return opStates.size();
    }

    bool hasTransition(const StateId a, const StateId b) const {
      if (!dbhc::contains_key(a, opTransitions)) {
        return false;
      }

      auto nextStates = dbhc::map_find(a, opTransitions);
      for (auto t : nextStates) {
        if (t.dest == b) {
          return true;
        }
      }

      return false;
    }
    void print(std::ostream& out) {
      out << "--- States" << std::endl;
      for (auto st : opStates) {
        out << "\t" << st.first << std::endl;
        for (auto instr : st.second) {
          out << instr << std::endl;
        }
      }

      out << "--- State Transistions" << std::endl;      
      for (auto tr : opTransitions) {
        out << "\t" << tr.first << std::endl;
        for (auto nextState : tr.second) {
          out << "\t\t -> " << nextState << std::endl;
        }
      }
    }

  };

  typedef StateTransitionGraph STG;

  STG buildSTG(Schedule& sched, llvm::Function* const f);

  STG buildSTG(Schedule& sched,
               llvm::BasicBlock* entryBlock,
               std::set<llvm::BasicBlock*>& blockList,
               std::function<void(Schedule&,
                                  STG&,
                                  StateId,
                                  llvm::ReturnInst*,
                                  Condition&)>& returnBehavior);
  
  HardwareConstraints standardConstraints();

  class LinearExpression {
    std::map<std::string, int> vars;
    int c;

  public:

    LinearExpression(const std::string var_) :
      vars({{var_, 1}}), c(0) {}

    LinearExpression(int c_) :
      vars({}), c(c_) {}
    
    LinearExpression(std::map<std::string, int>& vars_, const int c_) :
      vars(vars_), c(c_) {}

    LinearExpression() : vars({}), c(0) {}

    LinearExpression scalarMul(const int k) const {
      std::map<std::string, int> mulVars;
      for (auto v : vars) {
        mulVars.insert({v.first, k*v.second});
      }
      return {mulVars, k*getCoeff()};
    }
    
    LinearExpression sub(const LinearExpression& right) const {
      std::map<std::string, int> subVars;
      auto rightVars = right.getVars();
      for (auto v : vars) {
        if (dbhc::contains_key(v.first, rightVars)) {
          subVars.insert({v.first, v.second - dbhc::map_find(v.first, rightVars)});
        } else {
          subVars.insert(v);
        }
      }

      for (auto v : rightVars) {
        if (!dbhc::contains_key(v.first, vars)) {
          subVars.insert({v.first, -v.second});
        }
      }

      return {subVars, c - right.getCoeff()};
    }

    LinearExpression add(const LinearExpression& right) const {
      std::map<std::string, int> addVars;
      auto rightVars = right.getVars();
      for (auto v : vars) {
        if (dbhc::contains_key(v.first, rightVars)) {
          addVars.insert({v.first, v.second + dbhc::map_find(v.first, rightVars)});
        } else {
          addVars.insert(v);
        }
      }

      for (auto v : rightVars) {
        if (!dbhc::contains_key(v.first, vars)) {
          addVars.insert({v.first, v.second});
        }
      }

      return {addVars, c + right.getCoeff()};
    }
    
    int getCoeff() const {
      return c;
    }

    std::map<std::string, int> getVars() const {
      return vars;
    }

    int getValue(const std::string& var) {
      assert(dbhc::contains_key(var, vars));
      return dbhc::map_find(var, vars);
    }
  };

  enum ZCondition {
    CMP_LTZ,
    CMP_GTZ,
    CMP_LTEZ,
    CMP_GTEZ,
    CMP_EQZ
  };

  class LinearConstraint {
  public:
    LinearExpression expr;
    ZCondition cond;
  };

  class SchedulingProblem {
  public:
    int blockNo;
    
    std::map<llvm::Instruction*, std::vector<std::string> > schedVarNames;
    std::map<llvm::BasicBlock*, std::vector<std::string> > blockVarNames;
    std::map<llvm::BasicBlock*, std::string> IInames;

    std::vector<LinearConstraint> constraints;

    HardwareConstraints hdc;
    bool optimize;
    LinearExpression objectiveFunction;

    SchedulingProblem(const HardwareConstraints& hcs_) :
      blockNo(0), hdc(hcs_), optimize(false) {}

    SchedulingProblem() : optimize(false) {
      blockNo = 0;
    }

    void setObjective(const LinearExpression& expr) {
      objectiveFunction = expr;
      optimize = true;
    }

    std::string getIIName(llvm::BasicBlock* bb) const {
      std::string val = dbhc::map_find(bb, IInames);
      return val;
    }
    
    LinearExpression getII(llvm::BasicBlock* bb) const {
      std::string val = getIIName(bb);
      return LinearExpression(getIIName(bb));
    }
    
    int blockNumber() const {
      return blockNo;
    }

    LinearExpression blockStart(llvm::BasicBlock* bb) {
      return LinearExpression(dbhc::map_find(bb, blockVarNames).front());
    }

    LinearExpression blockEnd(llvm::BasicBlock* bb) {
      return LinearExpression(dbhc::map_find(bb, blockVarNames).back());
    }


    LinearExpression instrStart(llvm::Instruction* instr) {
      return LinearExpression(dbhc::map_find(instr, schedVarNames).front());
    }

    LinearExpression instrStage(llvm::Instruction* instr, const int i) {
      return LinearExpression(dbhc::map_find(instr, schedVarNames).at(i));
    }

    LinearExpression instrEnd(llvm::Instruction* instr) {
      return LinearExpression(dbhc::map_find(instr, schedVarNames).back());
    }

    int numStages(llvm::Instruction* instr) {
      return (int) dbhc::map_find(instr, schedVarNames).size();
    }
    
    void addBasicBlock(llvm::BasicBlock* const bb);

    void addConstraint(const LinearConstraint& constraint) {
      constraints.push_back(constraint);
    }
  };

  static inline
  std::ostream& operator<<(std::ostream& out, const LinearExpression expr) {
    auto vars = expr.getVars();
    for (auto v : vars) {
      out << v.second << "*" << v.first << " + ";
    }
    out << expr.getCoeff();

    return out;
  }

  static inline
  LinearExpression
  operator-(const LinearExpression left, const LinearExpression right) {
    return left.sub(right);
  }

  static inline
  LinearExpression
  operator+(const LinearExpression left, const LinearExpression right) {
    return left.add(right);
  }

  static inline
  LinearExpression
  operator*(const LinearExpression left, const int c) {
    return left.scalarMul(c);
  }
  
  static inline
  LinearConstraint
  operator>=(const LinearExpression left, const LinearExpression right) {
    return {left - right, CMP_GTEZ};
  }

  static inline
  LinearConstraint
  operator>=(const LinearExpression left, const int right) {
    return {left - LinearExpression(right), CMP_GTEZ};
  }

  static inline
  LinearConstraint
  operator>=(const int left, const LinearExpression right) {
    return {LinearExpression(left) - right, CMP_GTEZ};
  }

  static inline
  LinearConstraint
  operator<=(const LinearExpression left, const LinearExpression right) {
    return {left - right, CMP_LTEZ};
  }

  static inline
  LinearConstraint
  operator<=(const LinearExpression left, const int right) {
    return {left - LinearExpression(right), CMP_LTEZ};
  }

  static inline
  LinearConstraint
  operator<=(const int left, const LinearExpression right) {
    return {LinearExpression(left) - right, CMP_LTEZ};
  }

  static inline
  LinearConstraint
  operator==(const LinearExpression left, const LinearExpression right) {
    return {left - right, CMP_EQZ};
  }

  static inline
  LinearConstraint
  operator==(const LinearExpression left, const int right) {
    return {left - LinearExpression(right), CMP_EQZ};
  }

  static inline
  LinearConstraint
  operator==(const int left, const LinearExpression right) {
    return {LinearExpression(left) - right, CMP_EQZ};
  }

  // ---
  static inline
  LinearConstraint
  operator<(const LinearExpression left, const LinearExpression right) {
    return {left - right, CMP_LTZ};
  }

  static inline
  LinearConstraint
  operator<(const LinearExpression left, const int right) {
    return {left - LinearExpression(right), CMP_LTZ};
  }

  static inline
  LinearConstraint
  operator<(const int left, const LinearExpression right) {
    return {LinearExpression(left) - right, CMP_LTZ};
  }

  Schedule buildFromModel(SchedulingProblem& p);

  // TODO: Add incremental support for building scheduling constraints?
  Schedule scheduleFunction(llvm::Function* f,
                            HardwareConstraints& hdc,
                            std::set<llvm::BasicBlock*>& toPipeline,
                            std::map<llvm::Function*, SchedulingProblem>& constraints);

  SchedulingProblem
  createSchedulingProblem(llvm::Function* f,
                          HardwareConstraints& hdc,
                          std::set<llvm::BasicBlock*>& toPipeline);
  
  
}
