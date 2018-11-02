#pragma once

#include "algorithm.h"

#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>

namespace DHLS {

  std::string typeString(llvm::Type* const tptr);
  std::string instructionString(llvm::Instruction* const iptr);
  
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
    SELECT_OP
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
        SELECT_OP
        };

  }

  OperationType opType(llvm::Instruction* const iptr);
  
  class HardwareConstraints {

    std::map<OperationType, int> latencies;
    std::map<OperationType, int> counts;
    
  public:

    int getLatency(const OperationType op) const {
      return dbhc::map_find(op, latencies);
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

  class Schedule {

  public:
    std::map<llvm::Instruction*, std::vector<int> > instrTimes;
    std::map<llvm::BasicBlock*, std::vector<int> > blockTimes;
    std::map<llvm::BasicBlock*, Schedule> pipelineSchedules;

    int II;
    
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

  };

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
      assert(llvm::Instruction::classof(c.cond));
      if (c.negated) {
        out << "!(";
      }
      out << instructionString(static_cast<llvm::Instruction* const>(c.cond));

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

    for (auto cl : c.clauses) {
      out << "(";
      for (auto atom : cl) {
        out << atom << " ^ ";
      }
      out << ") v ";
    }

    return out;
  }

  class GuardedInstruction {
  public:
    llvm::Instruction* instruction;
    Condition cond;
  };

  static inline
  std::ostream& operator<<(std::ostream& out, const GuardedInstruction& t) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *(t.instruction);
    out << "\t\t" << ss.str() << " if " << t.cond << std::endl;
    return out;
  }
  
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
  
  class StateTransitionGraph {
  public:

    Schedule sched;
    std::map<StateId, std::vector<GuardedInstruction> > opStates;
    std::map<StateId, std::vector<StateTransition> > opTransitions;
    std::map<StateId, StateTransitionGraph> pipelineSuperStates;

    StateTransitionGraph() {}
    
    StateTransitionGraph(const StateTransitionGraph& other) {
      assert(false);
    }

    StateTransitionGraph(Schedule& sched_) : sched(sched_) {}

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
}
