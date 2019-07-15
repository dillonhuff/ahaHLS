#pragma once

#include "expression.h"
#include "utils.h"

#include <llvm/IR/Module.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/Instructions.h>

using namespace llvm;
using namespace std;

namespace ahaHLS {

  class Wire {
  public:
    bool registered;
    int width;
    std::string name;
    bool isConst;
    int constVal;

    Wire() : isConst(false) {}
    Wire(const int width_, const std::string& name_) : 
      registered(false), width(width_), name(name_), isConst(false) {}

    Wire(const int width_, const int value_) : 
      registered(false), width(width_), name(""), isConst(true), constVal(value_) {}
    
    Wire(const bool registered_, const int width_, const std::string& name_) : 
      registered(registered_), width(width_), name(name_), isConst(false) {}

    bool isConstant() const { return isConst; }
    
    std::string valueString() const {
      if (isConst) {
        if (constVal >= 0) {
          return std::to_string(width) + "'d" + std::to_string(constVal);
        } else {
          return "-" + parens(std::to_string(width) + "'d" + std::to_string(-constVal));
        }
      } else {
        return name;
      }
    }

    std::string toString() const {
      assert(!isConst);
      return std::string(registered ? "reg" : "wire") + " [" + std::to_string(width - 1) + ":0] " + name;
    }
  };

  class PipelineSpec {
  public:
    bool staticII;
    std::set<llvm::BasicBlock*> blks;
  };

  class TaskSpec {
  public:
    std::set<llvm::BasicBlock*> blks;
  };
  
  bool operator<(const PipelineSpec& x, const PipelineSpec& y);
  bool operator<(const TaskSpec& x, const TaskSpec& y);  
  bool operator==(const TaskSpec& x, const TaskSpec& y);
  bool operator!=(const TaskSpec& x, const TaskSpec& y);  

  enum OperationType {
    RETURN_OP,
    PHI_OP,
    TRUNC_OP,
    STORE_OP,
    LOAD_OP,
    ADD_OP,
    FADD_OP,    
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
    AND_OP,
    OR_OP,
    SHL_OP,
    LSHR_OP,
    ASHR_OP,
    SREM_OP,
    FMUL_OP
  };

  static inline std::vector<OperationType> allOps() {
    return {
      RETURN_OP,
        PHI_OP,
        TRUNC_OP,
        STORE_OP,
        LOAD_OP,
        ADD_OP,
        FADD_OP,        
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
        AND_OP,
        OR_OP,
        SHL_OP,
        ASHR_OP,
        LSHR_OP,
        SREM_OP,
        FMUL_OP
        };

  }

  OperationType opType(llvm::Instruction* const iptr);

  enum ExecutionActionType {
    EXECUTION_ACTION_INSTRUCTION,
    EXECUTION_ACTION_TAG,
    EXECUTION_ACTION_BASIC_BLOCK
  };

  class ExecutionAction {
    llvm::Instruction* instr;
    std::string tag;
    llvm::BasicBlock* bb;
    ExecutionActionType tp;
    
  public:
    ExecutionAction(Instruction* const instr_) :
      instr(instr_), tag(""), bb(nullptr), tp(EXECUTION_ACTION_INSTRUCTION) {}

    ExecutionAction(const std::string& name) :
      instr(nullptr), tag(name), bb(nullptr), tp(EXECUTION_ACTION_TAG) {}

    ExecutionAction(llvm::BasicBlock* const bb_) :
      instr(nullptr), tag(""), bb(bb_), tp(EXECUTION_ACTION_BASIC_BLOCK) {}

    ExecutionActionType type() const { return tp; }
    
    bool isInstruction() const {
      return type() == EXECUTION_ACTION_INSTRUCTION;
    }

    bool isTag() const {
      return type() == EXECUTION_ACTION_TAG;
    }

    bool isBasicBlock() const {
      return type() == EXECUTION_ACTION_BASIC_BLOCK;
    }

    BasicBlock* getBasicBlock() const {
      assert(isBasicBlock());
      return bb;
    }
    
    std::string getName() const {
      assert(isTag());
      return tag;
    }

    void setInstruction(llvm::Instruction* newInstr) {
      instr = newInstr;
      tp = EXECUTION_ACTION_INSTRUCTION;
    }

    llvm::Instruction* getInstruction() const {
      assert(isInstruction());
      return instr;
    }
  };

  static inline
  std::ostream& operator<<(std::ostream& out, const ExecutionAction& action) {
    if (action.isInstruction()) {
      out << valueString(action.getInstruction());
    }  else if (action.isBasicBlock()) {
      out << valueString(action.getBasicBlock());      
    } else {
      assert(action.isTag());
      out << action.getName();
      
    }
    return out;
  }

  static inline
  bool operator==(const ExecutionAction& a, const ExecutionAction& b) {
    if (a.type() != b.type()) {
      return false;
    }

    if (a.isInstruction() && b.isInstruction()) {
      return a.getInstruction() == b.getInstruction();
    }

    if (a.isBasicBlock() && b.isBasicBlock()) {
      return a.getBasicBlock() == b.getBasicBlock();
    }

    assert(a.isTag() && b.isTag());
    
    return a.getName() == b.getName();
  }
  
  static inline
  bool operator<(const ExecutionAction& a, const ExecutionAction& b) {
    if (a.type() != b.type()) {
      return a.type() < b.type();
    }

    if (a.isInstruction() && b.isInstruction()) {
      return a.getInstruction() < b.getInstruction();
    }

    if (a.isBasicBlock() && b.isBasicBlock()) {
      return a.getBasicBlock() < b.getBasicBlock();
    }

    assert(a.isTag() && b.isTag());
    
    return a.getName() < b.getName();
    
  }
  
  class Port {
  public:
    // TODO: registered is currently ignored in code generation. Registered
    // ports have separate companion reg variables inside generated verilog.
    // maybe I should print out output reg and remove internal regs?
    bool registered;    
    bool isInput;
    int width;
    std::string name;
    bool isDebug;

    bool input() const {
      return isInput;
    }

    bool output() const {
      return !isInput;
    }

    std::string toString() {
      return std::string(isInput ? "input" : "output") + (registered ? " reg " : "") + " [" + std::to_string(width - 1) + ":0] " + name;
    }
  };

  Port inputPort(const int width, const std::string& name);
  Port outputPort(const int width, const std::string& name);
  Port outputRegPort(const int width, const std::string& name);
  Port outputDebugPort(const int width, const std::string& name);

  class HazardSpec {
  public:
    string sourceMethod;
    string sinkMethod;

    // What is the right data structure to represent the hazard condition?
    Expression* condition;
    Expression* exeConstraint;
  };
  
  class ModuleSpec {
  public:
    bool hasClock;
    bool hasRst;    
    std::map<std::string, std::string> params;
    std::string name;
    std::map<std::string, Port> ports;
    std::map<std::string, int> defaultValues;
    std::set<std::string> insensitivePorts;
    std::vector<HazardSpec> hazards;

    ModuleSpec() : hasClock(false), hasRst(false) {
    }

    ModuleSpec(const std::map<std::string, std::string>& params_,
               const std::string name_,
               const std::map<std::string, Port>& ports_,
               const std::map<std::string, int>& defaultValues_) :
      hasClock(false),
      hasRst(false),
      params(params_),
      name(name_),
      ports(ports_),
      defaultValues(defaultValues_) {

    }

    ModuleSpec(const std::map<std::string, std::string>& params_,
               const std::string name_,
               const std::map<std::string, Port>& ports_,
               const std::map<std::string, int>& defaultValues_,
               const std::set<std::string>& insensitive_) :
      hasClock(false),
      hasRst(false),
      params(params_),
      name(name_),
      ports(ports_),
      defaultValues(defaultValues_),
      insensitivePorts(insensitive_) {}
    
    ModuleSpec(const std::map<std::string, std::string>& params_,
               const std::string name_,
               const std::map<std::string, Port>& ports_) :
      hasClock(false),
      hasRst(false),
      params(params_),
      name(name_),
      ports(ports_),
      defaultValues({}) {}

    ModuleSpec(const std::map<std::string, std::string>& params_,
               const std::string name_) :
      hasClock(false),
      hasRst(false),
      params(params_),
      name(name_),
      ports({}),
      defaultValues({}) {}

    bool isSequential() const {
      return hasClock;
    }

    bool hasReset() const {
      return hasRst;
    }
    
  };

  std::ostream& operator<<(std::ostream& out, const ModuleSpec& m);

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

  class HardwareConstraints {

    std::map<OperationType, int> latencies;
    std::map<OperationType, int> counts;
    std::map<llvm::Value*, ModuleSpec> modSpecs;
    
  public:

    std::map<llvm::Value*, MemorySpec> memSpecs;
    std::map<llvm::Instruction*, llvm::Value*> memoryMapping;
    std::map<std::string, std::function<ModuleSpec(llvm::StructType*)> > typeSpecs;

    bool builtModSpec(llvm::Value* const val);

    void bindValue(llvm::Value* const val, const ModuleSpec& spec);
    
    bool hasModSpec(llvm::Value* const val);
    ModuleSpec getModSpec(llvm::Value* const val);
    
    int getLatency(const OperationType op) const {
      return dbhc::map_find(op, latencies);
    }

    bool hasTypeSpec(const std::string& typeName) {
      return dbhc::contains_key(typeName, typeSpecs);
    }
    
    bool hasArgumentSpec(llvm::Value* const arg) {
      llvm::Type* tp = arg->getType();
      if (llvm::PointerType::classof(tp)) {

        llvm::Type* etp = dyn_cast<llvm::PointerType>(tp)->getElementType();

        if (llvm::StructType::classof(etp)) {
          llvm::StructType* tp = dyn_cast<StructType>(etp);
          if (dbhc::contains_key(string(tp->getName()), typeSpecs)) {
            return true;
          }

          return false;
        }

        return false;
      }

      return false;
    }
    
    ModuleSpec getArgumentSpec(llvm::Value* const arg) {
      assert(hasArgumentSpec(arg));

      llvm::Type* tp = arg->getType();
      assert(llvm::PointerType::classof(tp));

      llvm::Type* etp = dyn_cast<llvm::PointerType>(tp)->getElementType();

      assert(llvm::StructType::classof(etp));
      llvm::StructType* stp = dyn_cast<StructType>(etp);
      assert(dbhc::contains_key(string(stp->getName()), typeSpecs));

      return dbhc::map_find(string(stp->getName()), typeSpecs)(stp);
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

  ModuleSpec buildModSpec(std::map<llvm::Value*, std::string>& memNames,
                          std::map<llvm::Instruction*, llvm::Value*>& memSrcs,
                          HardwareConstraints& hcs,
                          llvm::Instruction* instr);

  void bindUnits(llvm::Function* f, HardwareConstraints& hcs);   
}
