#pragma once

#include <llvm/IR/Constants.h>

#include "scheduling.h"

namespace DHLS {

  bool hasOutput(llvm::Instruction* instr);

  class Memory {
  public:
    int width;
    std::string name;
    int depth;
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

  static inline
  Wire wire(const int width, const std::string& name) {
    return {false, width, name};
  }

  static inline
  Wire reg(const int width, const std::string& name) {
    return {true, width, name};
  }
  
  Port wireToOutputPort(const Wire w);
  Port wireToInputPort(const Wire w);
  
  static inline
  bool operator<(const Wire a, const Wire b) {
    return a.name < b.name;
  }

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
    
    if (b.triggers.size() == 1) {
      out << tab(level) << "always @(posedge " << b.triggers[0] << ") begin" << std::endl;
      out << tab(level + 1) << b.body << std::endl;
      out << tab(level) << "end" << std::endl;
    } else {
      out << tab(level) << "always @(*) begin" << std::endl;
      out << tab(level + 1) << b.body << std::endl;
      out << tab(level) << "end" << std::endl;
      
    }
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

    out << tab(level) << b.modName;
    if (paramStrs.size() > 0) {
      out << " #(" << commaListString(paramStrs) << ")";
    }

    out << " ";
    out << b.instName << "(";
    out << commaListString(portStrings);
    out << ");" << std::endl;
  }

  class FunctionalUnit {
  public:

    ModuleSpec module;
    std::string instName;

    std::map<std::string, Wire> portWires;
    std::map<std::string, Wire> outWires;

    bool external;

    bool isExternal() const {
      return external;
    }

    std::string getModName() const {
      return module.name;
    }

    std::string inputWire(const std::string& name) const {
      auto n = dbhc::map_find(name, portWires).name;
      if (isExternal()) {
        return n + "_reg";
      }

      return n;
    }

    std::map<std::string, std::string> getParams() const {
      return module.params;
    }

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
    Instruction* exitBranch;
    
    ElaboratedPipeline(const Pipeline& p_) : p(p_) {}

    llvm::BranchInst* getExitBranch() const {
      llvm::Instruction* repeat = exitBranch;
      assert(llvm::BranchInst::classof(repeat));
      llvm::BranchInst* pipelineB = llvm::dyn_cast<llvm::BranchInst>(repeat);

      assert(pipelineB->isConditional());

      return pipelineB;
    }

    int II() const {
      return p.II();
    }

    llvm::BasicBlock* getEntryBlock() const {
      return (exitBranch)->getParent();
    }
    
    llvm::Value* getExitCondition() const {
      llvm::Instruction* repeat = exitBranch;
      assert(llvm::BranchInst::classof(repeat));
      llvm::BranchInst* pipelineB = llvm::dyn_cast<llvm::BranchInst>(repeat);

      assert(pipelineB->isConditional());

      return pipelineB->getCondition();
    }

    int numStages() const {
      return p.getStates().size();
    }

    int stateIndex(const StateId id) const {
      for (int i = 0; i < (int) p.getStates().size(); i++) {
        if (p.getStates().at(i) == id) {
          return i;
        }
      }

      return -1;
    }

    int stageForState(const StateId id) const {
      return stateIndex(id);
    }

    int stateForStage(const int stageNo) const {
      return p.getStates().at(stageNo);
    }
    
  };

  bool isPipelineState(const StateId id,
                       const std::vector<ElaboratedPipeline>& pipelines);

  ElaboratedPipeline getPipeline(const StateId id,
                                 const std::vector<ElaboratedPipeline>& pipelines);
  
  class RAM {
    
  public:

    std::string name;
    int width;
    int depth;

    RAM(const std::string& name_,
        const int width_,
        const int depth_) : name(name_), width(width_), depth(depth_) {}
  };

  // enum MemInterface {
  //   MEM_INTERFACE_DIRECT,
  //   MEM_INTERFACE_AXI4_LITE,
  // };

  // class ArchOptions {
  // public:
  //   bool globalStall;
  //   MemInterface memInterface;

  //   ArchOptions() : globalStall(false), memInterface(MEM_INTERFACE_DIRECT) {}

  //   void setMemInterface(const MemInterface fresh) {
  //     memInterface = fresh;
  //     if (memInterface != MEM_INTERFACE_DIRECT) {
  //       globalStall = true;
  //     }
  //   }
  // };

  class ControlState {
    Wire globalState;
    Wire lastBB;
    std::vector<Wire> globalStall;
    std::map<llvm::BasicBlock*, int> basicBlockNos;

  public:

    ControlState() {
      globalState = reg(32, "global_state");
      lastBB = reg(32, "last_BB_reg");
    }

    void setBasicBlockNo(BasicBlock* const bb, const int val) {
      basicBlockNos[bb] = val;
    }

    int getBasicBlockNo(BasicBlock* bb) const {
      return dbhc::map_find(bb, basicBlockNos);
    }

    void setGlobalStall(const Wire w) {
      globalStall.push_back(w);
    }

    Wire getGlobalState() const {
      return globalState;
    }

    Wire getGlobalStall() const {
      assert(hasGlobalStall());
      return globalStall[0];
    }

    bool hasGlobalStall() const {
      assert(globalStall.size() <= 1);
      return globalStall.size() > 0;
    }

    Wire getLastBB() const {
      return lastBB;
    }
  };
  
  class MicroArchitecture {
  public:
    ControlState cs;

    // TODO: Remove the need for global AXI stalls, just build that
    // example via interface functions
    //ArchOptions archOptions;
    STG stg;
    std::map<llvm::Instruction*, FunctionalUnit> unitAssignment;
    std::map<llvm::Value*, int> memoryMap;
    std::map<llvm::Instruction*, Wire> names;
    std::vector<ElaboratedPipeline> pipelines;

    std::map<Wire, std::string> resetValues;
    HardwareConstraints hcs;

    MicroArchitecture(const ControlState& cs_,
                      //const ArchOptions& archOptions_,
                      const STG& stg_,
                      const std::map<llvm::Instruction*, FunctionalUnit>& unitAssignment_,
                      const std::map<llvm::Value*, int>& memoryMap_,
                      const std::map<llvm::Instruction*, Wire>& names_,
                      const std::vector<ElaboratedPipeline>& pipelines_,
                      const HardwareConstraints& hcs_) :
      cs(cs_),
      //archOptions(archOptions_),
      stg(stg_),
      unitAssignment(unitAssignment_),
      memoryMap(memoryMap_),
      names(names_),
      pipelines(pipelines_),
      hcs(hcs_) {

      resetValues.insert({Wire(true, 32, "global_state"),
            std::to_string(cs.getBasicBlockNo(&(stg.getFunction()->getEntryBlock())))});
    }

    bool hasGlobalStall() const {
      return cs.hasGlobalStall();
    }

    ElaboratedPipeline getPipeline(const StateId state) const {
      assert(DHLS::isPipelineState(state, pipelines));
      return DHLS::getPipeline(state, pipelines);
    }

    int numFUsWithName(const std::string& name) const {
      int n = 0;
      std::set<std::string> alreadyAdded;
      for (auto ua : unitAssignment) {
        if (!dbhc::elem(ua.second.instName, alreadyAdded) && (ua.second.getModName() == name)) {
          n++;
        }
        alreadyAdded.insert(ua.second.instName);
      }
      return n;
    }

    int numReadPorts() const {
      return numFUsWithName("load");
    }

    int numWritePorts() const {
      return numFUsWithName("store");
    }
    
    bool isPipelineState(const StateId id) const {
      return DHLS::isPipelineState(id, pipelines);
    }

  };
  
  class TestBenchSpec {
  public:
    std::map<std::string, std::vector<int> > memoryInit;
    std::map<std::string, std::vector<int> > memoryExpected;
    int runCycles;
    int maxCycles;
    std::string name;

    std::map<int, std::vector<std::string> > actionsOnCycles;
    std::map<int, std::vector<std::string> > actionsInCycles;    
    std::set<std::string> settableWires;

    bool useModSpecs;

    TestBenchSpec() {
      maxCycles = 400;
      settableWires.insert("clk");
      settableWires.insert("rst");
      useModSpecs = false;
    }

    void setArgPort(llvm::Argument* arg, std::string port, int cycleNo, std::string value);
    void setArgPort(llvm::Argument* arg, std::string port, int cycleNo, const int value);
    void settablePort(llvm::Argument* arg, std::string port);
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

  static inline
  std::string assertString(const std::string& condition) {
    return "if (!(" + condition + ")) begin $display(\"assertion(" + condition + ")\"); $finish(); end";
  }
  
  static inline void
  addAssert(const std::string& condition,
            VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, assertString(condition), info); 
  }

  
  void emitVerilog(llvm::Function* f,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);
  
  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap);

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap);

  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo);
  
  void emitVerilog(llvm::Function* f,
                   const STG& stg,
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debufInfo);
  
  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap);

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<llvm::Value*, int>& memoryMap);
  
  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap);

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         HardwareConstraints& hcs);
  
  // MicroArchitecture
  // buildMicroArchitecture(llvm::Function* f,
  //                        const STG& stg,
  //                        std::map<std::string, int>& memoryMap,
  //                        HardwareConstraints& hcs);

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap,
                         HardwareConstraints& hcs);
  
  // MicroArchitecture
  // buildMicroArchitecture(llvm::Function* f,
  //                        const STG& stg,
  //                        std::map<std::string, int>& memoryMap);
  //                        //const ArchOptions& options);

  MicroArchitecture
  buildMicroArchitecture(llvm::Function* f,
                         const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap);
  
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

  void addNoXChecks(const MicroArchitecture& arch,
                    VerilogDebugInfo& debugInfo);

  // TODO: Move to separate memory analysis file, and eventually
  // to an LLVM dataflow pass
  std::map<llvm::Instruction*, llvm::Value*>
  memoryOpLocations(llvm::Function* f);

  std::string atState(const StateId state, const MicroArchitecture& arch);  
  std::string notAtState(const StateId state, const MicroArchitecture& arch);

  llvm::Instruction* lastInstructionInState(const StateId state,
                                            MicroArchitecture& arch);

  void printInstrAtState(llvm::Instruction* instr,
                         StateId st,
                         const MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  std::string floatBits(const float f);

  void emitVerilog(const std::string& fn,
                   llvm::Function* f,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);
  
}
