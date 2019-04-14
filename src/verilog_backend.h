#pragma once

#include <llvm/IR/Constants.h>

#include "scheduling.h"

namespace ahaHLS {

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
    bool isConst;
    int constVal;

    Wire() : isConst(false) {}
    Wire(const int width_, const std::string& name_) : 
      registered(false), width(width_), name(name_), isConst(false) {}

    Wire(const int width_, const int value_) : 
      registered(false), width(width_), name(""), isConst(true), constVal(value_) {}
    
    Wire(const bool registered_, const int width_, const std::string& name_) : 
      registered(registered_), width(width_), name(name_), isConst(false) {}

    std::string valueString() const {
      if (isConst) {
        return std::to_string(width) + "'d" + std::to_string(constVal);
      } else {
        return name;
      }
    }

    std::string toString() const {
      assert(!isConst);
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

  static inline
  Wire constWire(const int width, const int value) {
    return {width, value};
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

    std::string outputWire(const std::string& name) const {
      if (!dbhc::contains_key(name, outWires)) {
        std::cout << "Error: No wire named " << name << std::endl;
        assert(false);
      }
      
      auto n = dbhc::map_find(name, outWires).name;
      return n;
    }

    Wire outputWire() const {
      assert(outWires.size() == 1);
      return (std::begin(outWires))->second;
    }
    
    std::string inputWire(const std::string& name) const {
      if (!dbhc::contains_key(name, portWires)) {
        std::cout << "Error: No wire named " << name << std::endl;
        assert(false);
      }
      
      auto n = dbhc::map_find(name, portWires).name;
      if (isExternal()) {
        return n + "_reg";
      }

      return n;
    }

    std::map<std::string, std::string> getParams() const {
      return module.params;
    }

    Wire onlyInput() const {
      assert(portWires.size() == 1);

      return (*begin(portWires)).second;
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

  FunctionalUnit functionalUnitForSpec(const std::string unitName,
                                       const ModuleSpec& mSpec);
  
  class RAM {
    
  public:

    std::string name;
    int width;
    int depth;

    RAM(const std::string& name_,
        const int width_,
        const int depth_) : name(name_), width(width_), depth(depth_) {}
  };

  class ControlState {
    Wire globalState;
    Wire lastBB;

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

    Wire getGlobalState() const {
      return globalState;
    }

    Wire getLastBB() const {
      return lastBB;
    }
  };

  class UnitController {
  public:
    FunctionalUnit unit;
    std::map<StateId, std::vector<Instruction*> > instructions;
  };

  typedef std::vector<std::string> StallConds;
  typedef std::map<std::string, std::string> PortAssignments;

  // Represents all possible values that can be assigned to
  // a port, and the cycles at which they are assigned
  class PortValues {
  public:
    // This map should include
    //  1. States where the port is assigned
    //  2. States where it is an unused value
    bool isInsensitive;
    map<StateId, pair<StallConds, string> > portAssignments;
    map<Wire, Wire> portVals;
    std::string defaultValue;
  };

  // Need to move to one map from ports to states and the values
  // they take in each state
  class PortController {
  public:
    UnitController unitController;
    map<StateId, vector<pair<StallConds, PortAssignments> > > portValues;

    // These are defaults for all 
    // map<StateId, PortAssignments> defaultValues;
    PortAssignments statelessDefaults;

    // TODO: This information should eventually be carried in the
    // functional unit itself.
    //map<string, bool> insensitivePorts;

    // This is the final form of the port controller for the unit.
    // Each input port on the functional unit has its own independent controller
    map<string, PortValues> inputControllers;

    void setCond(const std::string& port, const Wire& condition, const Wire& value);

    FunctionalUnit& functionalUnit() {
      return unitController.unit;
    }

    void setAlways(const std::string& portName, const Wire value) {
      inputControllers[functionalUnit().inputWire(portName)].portVals[constWire(1, 1)] = value;
    }

    Wire onlyInput() const {
      const FunctionalUnit& unit = unitController.unit;
      return unit.onlyInput();
    }

    bool isExternal() const { return unitController.unit.isExternal(); }

    string defaultValue(const std::string& port) {
      return dbhc::map_find(port, statelessDefaults);
    }

    bool hasDefault(const std::string& port) {
      return dbhc::contains_key(port, statelessDefaults);
    }

  };

  class RegController {
  public:
    Wire reg;
    std::string resetValue;
    std::map<string, string> values;
  };

  class MicroArchitecture {
  public:
    ControlState cs;

    STG stg;
    std::map<llvm::Instruction*, FunctionalUnit> unitAssignment;
    std::map<llvm::Value*, int> memoryMap;
    std::map<llvm::Instruction*, Wire> names;
    std::vector<ElaboratedPipeline> pipelines;

    std::map<Wire, std::string> resetValues;
    HardwareConstraints hcs;

    std::map<std::string, RegController> regControllers;
    std::map<std::string, PortController> portControllers;
    std::vector<FunctionalUnit> functionalUnits;

    int uniqueNum;

    Wire isActiveBlockVar(llvm::BasicBlock* bb);
    
    std::string uniqueName(const std::string& prefix) {
      std::string name = prefix + "_" + std::to_string(uniqueNum);
      uniqueNum++;
      return name;
    }

    FunctionalUnit& makeUnit(std::string name, ModuleSpec& mSpec) {
      functionalUnits.push_back(functionalUnitForSpec(name, mSpec));
      return functionalUnits.back();
    }

    PortController& addPortController(FunctionalUnit& unit) {
      int earlierSize = portControllers.size();
      PortController c;
      c.unitController.unit = unit;
      portControllers[unit.instName] = c;

      assert(portControllers.size() == (earlierSize + 1));

      return portControllers[unit.instName];
    }
    
    PortController& portController(const std::string& name) {
      assert(dbhc::contains_key(name, portControllers));
      return portControllers[name];
      // for (auto& c : portControllers) {
      //   if (c.unitController.unit.instName == name) {
      //     return c.second;
      //   }
      // }

      // cout << "Error: Could not find controller for " << name << endl;
      // assert(false);
    }
    
    void addController(const std::string& name, const int width) {
      RegController ctr;
      ctr.reg = reg(width, name);
      ctr.resetValue = "0";
      regControllers[name] = ctr;
    }

    RegController& getController(const std::string& name) {
      if (dbhc::contains_key(name, regControllers)) {
        return regControllers[name];
      } else {
        addController(name, 1);
        return regControllers[name];
      }
    }

    RegController& getController(const Wire& w) {
      auto name = w.name;
      if (dbhc::contains_key(name, regControllers)) {
        return regControllers[name];
      } else {
        addController(name, w.width);
        return regControllers[name];
      }
    }
    
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
      hcs(hcs_),
      uniqueNum(0) {

      resetValues.insert({Wire(true, 32, "global_state"),
            std::to_string(cs.getBasicBlockNo(&(stg.getFunction()->getEntryBlock())))});
    }

    // bool hasGlobalStall() const {
    //   return cs.hasGlobalStall();
    // }

    ElaboratedPipeline getPipeline(const StateId state) const {
      assert(ahaHLS::isPipelineState(state, pipelines));
      return ahaHLS::getPipeline(state, pipelines);
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
      return ahaHLS::isPipelineState(id, pipelines);
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

    std::vector<std::string> actionsOnConditions;

    std::set<std::string> settableWires;

    bool useModSpecs;

    TestBenchSpec() {
      maxCycles = 400;
      settableWires.insert("clk");
      settableWires.insert("rst");
      useModSpecs = false;
    }

    void actionOnCondition(const std::string& condition,
                           const std::string& action) {
      actionsOnConditions.push_back("if " + parens(condition) + " begin " + action + " end ");
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


  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs,
                   VerilogDebugInfo& info);

  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs);
  
  void emitVerilog(MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);
  
  void emitVerilog(const STG& stg,
                   std::map<std::string, int>& memoryMap);

  void emitVerilog(const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap);

  void emitVerilog(const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo);

  void emitVerilog(const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo);
  
  void emitVerilog(const STG& stg,
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debufInfo);
  
  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap);

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<llvm::Value*, int>& memoryMap);
  
  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<std::string, int>& memoryMap);

  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<std::string, int>& memoryMap,
                         HardwareConstraints& hcs);
  
  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap,
                         HardwareConstraints& hcs);
  
  MicroArchitecture
  buildMicroArchitecture(const STG& stg,
                         std::map<llvm::Value*, int>& memoryMap);
  
  void noPhiOutputsXWhenUsed(MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo);

  void noAddsTakeXInputs(MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  void noMulsTakeXInputs(MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  void noLoadedValuesXWhenUsed(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo);

  void noLoadAddressesXWhenUsed(MicroArchitecture& arch,
                                VerilogDebugInfo& debugInfo);
  
  void noStoredValuesXWhenUsed(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo);

  void addNoXChecks(MicroArchitecture& arch,
                    VerilogDebugInfo& debugInfo);

  // TODO: Move to separate memory analysis file, and eventually
  // to an LLVM dataflow pass
  std::map<llvm::Instruction*, llvm::Value*>
  memoryOpLocations(llvm::Function* f);

  std::string atState(const StateId state, MicroArchitecture& arch);  
  std::string notAtState(const StateId state, MicroArchitecture& arch);

  llvm::Instruction* lastInstructionInState(const StateId state,
                                            MicroArchitecture& arch);

  void printInstrAtState(llvm::Instruction* instr,
                         StateId st,
                         MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  std::string floatBits(const float f);

  void emitVerilog(const std::string& fn,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);

  MicroArchitecture synthesizeVerilog(llvm::Function* f,
                                      InterfaceFunctions& interfaces,
                                      HardwareConstraints& hcs);
  
}
