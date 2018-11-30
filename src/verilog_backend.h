#pragma once

#include <llvm/IR/Constants.h>
#include <llvm/IR/Instructions.h>

#include "scheduling.h"

namespace DHLS {

  class Wire {
  public:
    bool registered;
    int width;
    std::string name;

    Wire() {}
    Wire(const int width_, const std::string& name_) : 
      registered(false), width(width_), name(name_) {}

    Wire(const bool registered_, const int width_, const std::string& name_) : 
      registered(registered_), width(width_), name(name_) {}

    std::string toString() const {
      return std::string(registered ? "reg" : "wire") + " [" + std::to_string(width - 1) + ":0] " + name;
    }
  };

  std::ostream& operator<<(std::ostream& out, const Wire w);

  class AlwaysBlock {
  public:
    std::vector<std::string> triggers;
    std::string body;
  };

  static inline
  void print(std::ostream& out, int level, const AlwaysBlock& b) {
    assert(b.triggers.size() == 1);
    out << tab(level) << "always @(posedge " << b.triggers[0] << ") begin" << std::endl;
    out << tab(level + 1) << b.body << std::endl;
    out << tab(level) << "end" << std::endl;
  }

  class AlwaysDelayBlock {
  public:
    int delay;
    std::string body;
  };

  static inline
  void print(std::ostream& out, int level, const AlwaysDelayBlock& b) {
    out << tab(level) << "always #" << b.delay << " begin" << std::endl;
    out << tab(level + 1) << b.body << std::endl;
    out << tab(level) << "end" << std::endl;
  }

  class ModuleInstance {
  public:
    std::string modName;
    std::string instName;
    std::map<std::string, std::string> portConnections;
  };

  static inline
  void print(std::ostream& out, int level, const ModuleInstance& b) {

    std::vector<std::string> portStrings;
    for (auto pt : b.portConnections) {
      portStrings.push_back("." + pt.first + "(" + pt.second + ")");
    }

    out << tab(level) << b.modName << " " << b.instName << "(";
    out << commaListString(portStrings);
    out << ");" << std::endl;
  }
  
  class TestBenchSpec {
  public:
    std::map<std::string, std::vector<int> > memoryInit;
    std::map<std::string, std::vector<int> > memoryExpected;
    int runCycles;
    std::string name;
  };

  void emitVerilogTestBench(const TestBenchSpec& tb,
                            const std::map<std::string, int>& layout);
  
  class VerilogComponents {
  public:
    std::vector<Wire> wiresToWatch;
    std::vector<Wire> debugWires;
    std::vector<std::pair<std::string, std::string> > debugAssigns;
    std::vector<AlwaysBlock> blocks;
    std::vector<AlwaysDelayBlock> delayBlocks;
    std::vector<std::string> initStmts;
    std::vector<ModuleInstance> instances;    
  };

  typedef VerilogComponents VerilogDebugInfo;

  static inline void
  addAlwaysBlock(const std::vector<std::string>& triggers,
                 const std::string& body,
                 VerilogDebugInfo& info) {
    info.blocks.push_back({triggers, body});
  }

  static inline void
  addWirePrintoutIf(const std::string& condition,
                    const std::string& wireName,
                    VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, "if (" + condition + ") begin $display(\"" + wireName + " == %d\", " + wireName + "); end", info);
  }

  static inline void
  addWirePrintout(const std::string& wireName,
                  VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, "$display(\"" + wireName + " == %d\", " + wireName + ");", info);
  }

  static inline void
  addGlobalStateWirePrintout(const std::string& wireName,
                             VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, "$display(\"global_state == %d, " + wireName + " == %d\", global_state, " + wireName + ");", info);
  }
  
  static inline void
  addAssert(const std::string& condition,
            VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, "if (!(" + condition + ")) begin $display(\"assertion(" + condition + ")\"); $finish(); end", info);
  }

  class FunctionalUnit {
  public:
    std::string modName;
    std::string instName;

    std::map<std::string, Wire> portWires;
    std::map<std::string, Wire> outWires;

    std::string onlyOutputVar() const {
      assert(outWires.size() == 1);

      return (*begin(outWires)).second.name;
    }
  };

  class ElaboratedPipeline {
  public:
    Pipeline p;
    std::vector<Wire> valids;
    Wire inPipe;
    StateId stateId;

    std::vector<std::map<llvm::Instruction*, Wire> > pipelineRegisters;
    GuardedInstruction exitBranch;
    //std::vector<Wire> lastBBs;
    
    ElaboratedPipeline(const Pipeline& p_) : p(p_) {}

    llvm::Value* getExitCondition() const {
      llvm::Instruction* repeat = exitBranch.instruction;
      assert(llvm::BranchInst::classof(repeat));
      llvm::BranchInst* pipelineB = llvm::dyn_cast<llvm::BranchInst>(repeat);

      assert(pipelineB->isConditional());

      return pipelineB->getCondition();
    }

    int numStages() const {
      return p.getStates().size();
    }

    int stateIndex(const StateId id) const {
      for (int i = 0; i < p.getStates().size(); i++) {
        if (p.getStates().at(i) == id) {
          return i;
        }
      }

      return -1;
    }

    int stageForState(const StateId id) const {
      return stateIndex(id);
    }

  };

  class RAM {
    
  public:

    std::string name;
    int width;
    int depth;

    RAM(const std::string& name_,
        const int width_,
        const int depth_) : name(name_), width(width_), depth(depth_) {}
  };
  
  class MicroArchitecture {
  public:


    STG stg;
    std::map<llvm::Instruction*, FunctionalUnit> unitAssignment;
    std::map<std::string, int> memoryMap;
    std::map<llvm::Instruction*, Wire> names;
    std::map<llvm::BasicBlock*, int> basicBlockNos;
    std::vector<ElaboratedPipeline> pipelines;
    std::vector<RAM> rams;

    MicroArchitecture(
                      const STG& stg_,
                      const std::map<llvm::Instruction*, FunctionalUnit>& unitAssignment_,
                      const std::map<std::string, int>& memoryMap_,
                      const std::map<llvm::Instruction*, Wire>& names_,
                      const std::map<llvm::BasicBlock*, int>& basicBlockNos_,
                      const std::vector<ElaboratedPipeline>& pipelines_,
                      const std::vector<RAM>& rams_) :
      stg(stg_),
      unitAssignment(unitAssignment_),
      memoryMap(memoryMap_),
      names(names_),
      basicBlockNos(basicBlockNos_),
      pipelines(pipelines_),
      rams(rams_) {}
  };
  
  void emitVerilog(llvm::Function* f,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);
  
  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap);

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debufInfo);
  
  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap);

}
