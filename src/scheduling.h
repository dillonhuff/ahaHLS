#pragma once

#include "algorithm.h"
#include "utils.h"

//#include <polly/Canonicalization.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Instructions.h>
#include <llvm/Support/raw_ostream.h>

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
    bool addressable;
    ModuleSpec modSpec;
  };

  static inline MemorySpec registerSpec(const int width) {
    return {0, 1, 1, 1, false, {{{"width", std::to_string(width)}}, "register"}};
  }

  static inline MemorySpec ramSpec(const int readLat,
                                   const int writeLat,
                                   const int nReadPorts,
                                   const int nWritePorts) {
    return {readLat, writeLat, nReadPorts, nWritePorts, true, {{{"width", std::to_string(32)}}, "RAM"}};
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
        SEXT_OP
        };

  }

  OperationType opType(llvm::Instruction* const iptr);
  
  class HardwareConstraints {

    std::map<OperationType, int> latencies;
    std::map<OperationType, int> counts;
    
  public:

    std::map<llvm::Value*, MemorySpec> memSpecs;
    std::map<llvm::Instruction*, llvm::Value*> memoryMapping;
    
    int getLatency(const OperationType op) const {
      return dbhc::map_find(op, latencies);
    }

    int getLatency(llvm::Instruction* iptr) const;

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

  static inline
  std::ostream& operator<<(std::ostream& out, const GuardedInstruction& t) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *(t.instruction);
    out << "\t\t" << ss.str() << " if " << t.cond << " in " << (t.instruction)->getParent()->getName().str() << std::endl;
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

  
}
