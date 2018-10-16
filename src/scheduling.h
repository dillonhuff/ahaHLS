#pragma once

#include "algorithm.h"

#include <llvm/IR/Module.h>
#include <llvm/Support/raw_ostream.h>

namespace DHLS {

  std::string instructionString(llvm::Instruction* const iptr);
  
  enum OperationType {
    STORE_OP,
    LOAD_OP,
    ADD_OP,
    SUB_OP,
    MUL_OP,
    DIV_OP,
    SDIV_OP,
    CMP_OP,
    BR_OP
  };

  class HardwareConstraints {

    std::map<OperationType, int> latencies;
    
  public:

    int getLatency(const OperationType op) const {
      return dbhc::map_find(op, latencies);
    }

    void setLatency(const OperationType op, const int latency) {
      latencies[op] = latency;
    }
    
  };

  class Schedule {

  public:    
    std::map<llvm::Instruction*, std::vector<int> > instrTimes;
    std::map<llvm::BasicBlock*, std::vector<int> > blockTimes;

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
  };

  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc);

  // Logical condition used in state transitions
  class Condition {
  public:

    llvm::Value* cond;
    bool negated;
    Condition() : cond(nullptr), negated(false) {}
    Condition(llvm::Value* const cond_) : cond(cond_), negated(false) {}
    Condition(llvm::Value* const cond_, const bool negated_) :
      cond(cond_), negated(negated_) {}    
  };

  static inline std::ostream& operator<<(std::ostream& out, const Condition& c) {
    if (c.cond != nullptr) {
      assert(llvm::Instruction::classof(c.cond));
      if (c.negated) {
        out << "!";
      }
      out << instructionString(static_cast<llvm::Instruction* const>(c.cond));
    } else {
      out << "True";
    }
    return out;
  }
  
  
  class GuardedInstruction {
  public:
    llvm::Instruction* instruction;
    Condition cond;
  };

  typedef int StateId;

  class StateTransition {
  public:
    StateId dest;
    Condition cond;
  };

  static inline std::ostream& operator<<(std::ostream& out, const StateTransition& t) {
    out << t.dest << " if " << t.cond << std::endl;
    return out;
  }
  
  class StateTransitionGraph {
  public:

    Schedule sched;
    std::map<StateId, std::vector<GuardedInstruction> > opStates;
    std::map<StateId, std::vector<StateTransition> > opTransitions;

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
          std::string str;
          llvm::raw_string_ostream ss(str);
          ss << *(instr.instruction);
          out << "\t\t" << ss.str() << std::endl;
        }
      }

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
