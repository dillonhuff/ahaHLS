#pragma once

#include <llvm/IR/Constants.h>
#include <llvm/IR/Instructions.h>

#include "scheduling.h"

namespace DHLS {

  class Memory {
  public:
    int width;
    std::string name;
    int depth;
  };

  class Port {
  public:
    bool isInput;
    int width;
    std::string name;
    bool isDebug;

    std::string toString() {
      return std::string(isInput ? "input" : "output") + " [" + std::to_string(width - 1) + ":0] " + name;
    }
  };

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
  void print(std::ostream& out, int level, const Memory& b) {
    out << tab(level) << "reg [" + std::to_string(b.width - 1) << " : 0] "
        << b.name << "[" << std::to_string(b.depth - 1) << ": 0];" << std::endl;
  }
  
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
    std::map<std::string, std::string> params;
    std::string instName;
    std::map<std::string, std::string> portConnections;

    ModuleInstance(const std::string modName_,
                   const std::string instName_,
                   const std::map<std::string, std::string> portConnections_) :
      modName(modName_), params({}), instName(instName_), portConnections(portConnections_) {}

    ModuleInstance(const std::string modName_,
                   const std::map<std::string, std::string> params_,
                   const std::string instName_,
                   const std::map<std::string, std::string> portConnections_) :
      modName(modName_), params(params_), instName(instName_), portConnections(portConnections_) {}
    
  };

  static inline
  void print(std::ostream& out, int level, const ModuleInstance& b) {

    std::vector<std::string> portStrings;
    for (auto pt : b.portConnections) {
      portStrings.push_back("." + pt.first + "(" + pt.second + ")");
    }

    std::vector<std::string> paramStrs;
    for (auto pt : b.params) {
      paramStrs.push_back("." + pt.first + "(" + pt.second + ")");
    }
    
    out << tab(level) << b.modName << " #(" << commaListString(paramStrs) << ") " << b.instName << "(";
    out << commaListString(portStrings);
    out << ");" << std::endl;
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

  enum MemInterface {
    MEM_INTERFACE_DIRECT,
    MEM_INTERFACE_AXI4_LITE,
  };

  class ArchOptions {
  public:
    bool globalStall;
    MemInterface memInterface;

    ArchOptions() : globalStall(false), memInterface(MEM_INTERFACE_DIRECT) {}

    void setMemInterface(const MemInterface fresh) {
      memInterface = fresh;
      if (memInterface != MEM_INTERFACE_DIRECT) {
        globalStall = true;
      }
    }
  };
  
  class MicroArchitecture {
  public:
    ArchOptions archOptions;
    STG stg;
    std::map<llvm::Instruction*, FunctionalUnit> unitAssignment;
    std::map<std::string, int> memoryMap;
    std::map<llvm::Instruction*, Wire> names;
    std::map<llvm::BasicBlock*, int> basicBlockNos;
    std::vector<ElaboratedPipeline> pipelines;
    std::vector<RAM> rams;
    std::vector<Wire> globalStall;

    MicroArchitecture(const ArchOptions& archOptions_,
                      const STG& stg_,
                      const std::map<llvm::Instruction*, FunctionalUnit>& unitAssignment_,
                      const std::map<std::string, int>& memoryMap_,
                      const std::map<llvm::Instruction*, Wire>& names_,
                      const std::map<llvm::BasicBlock*, int>& basicBlockNos_,
                      const std::vector<ElaboratedPipeline>& pipelines_,
                      const std::vector<RAM>& rams_) :
      archOptions(archOptions_),
      stg(stg_),
      unitAssignment(unitAssignment_),
      memoryMap(memoryMap_),
      names(names_),
      basicBlockNos(basicBlockNos_),
      pipelines(pipelines_),
      rams(rams_) {}

    bool hasGlobalStall() const {
      assert(globalStall.size() <= 1);
      return globalStall.size() == 1;
    }

    int numFUsWithName(const std::string& name) const {
      int n = 0;
      std::set<std::string> alreadyAdded;
      for (auto ua : unitAssignment) {
        if (!dbhc::elem(ua.second.instName, alreadyAdded) && (ua.second.modName == name)) {
          n++;
        }
        alreadyAdded.insert(ua.second.instName);
      }
      return n;
    }

    int numReadPorts() const {
      return numFUsWithName("load");
    }
  };
  
  class TestBenchSpec {
  public:
    std::map<std::string, std::vector<int> > memoryInit;
    std::map<std::string, std::vector<int> > memoryExpected;
    int runCycles;
    std::string name;
  };

  void emitVerilogTestBench(const TestBenchSpec& tb,
                            MicroArchitecture& arch,
                            const std::map<std::string, int>& layout);

  class VerilogComponents {
  public:
    std::vector<Wire> wiresToWatch;
    std::vector<Memory> memories;
    std::vector<Wire> debugWires;
    std::vector<std::pair<std::string, std::string> > debugAssigns;
    std::vector<AlwaysBlock> blocks;
    std::vector<AlwaysDelayBlock> delayBlocks;
    std::vector<std::string> initStmts;
    std::vector<ModuleInstance> instances;    
  };

  typedef VerilogComponents VerilogDebugInfo;

  void emitModule(std::ostream& out,
                  const std::string& name,
                  std::vector<Port>& ports,
                  VerilogComponents& comps);
  
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

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap);

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         const ArchOptions& options);
  
  void noPhiOutputsXWhenUsed(const MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo);

  void noAddsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  void noMulsTakeXInputs(const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  void noLoadedValuesXWhenUsed(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo);

  void noLoadAddressesXWhenUsed(const MicroArchitecture& arch,
                                VerilogDebugInfo& debugInfo);
  
  void noStoredValuesXWhenUsed(const MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo);
  
}
