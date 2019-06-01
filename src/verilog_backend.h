#pragma once

#include <llvm/IR/Constants.h>

#include "microarchitecture.h"

namespace ahaHLS {

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

  std::string assertString(const std::string& condition);
  
  void addAssert(const std::string& condition,
                 VerilogDebugInfo& info);

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

  void emitVerilog(const std::string& fn,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo);

  MicroArchitecture synthesizeVerilog(llvm::Function* f,
                                      InterfaceFunctions& interfaces,
                                      HardwareConstraints& hcs);

  void addControlSanityChecks(MicroArchitecture& arch,
                              VerilogDebugInfo& info);


  void addSetStencilChecks(MicroArchitecture& arch,
                           VerilogDebugInfo& info);

  void printInstrAtState(llvm::Instruction* instr,
                         StateId st,
                         MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo);

  void printActiveBlocks(MicroArchitecture& arch, VerilogDebugInfo& info);
  
  void addDisplay(const std::string& cond,
                  const std::string& condStr,
                  const std::vector<std::string>& vars,
                  VerilogDebugInfo& debugInfo);
  

  void checkRAM(TestBenchSpec& tb,
                int checkMemCycle,
                const std::string name,
                std::map<string, vector<int> >& memoryExpected,
                std::map<string, int>& testLayout);
  
  void setRAM(TestBenchSpec& tb,
              int startSetMemCycle,
              const std::string name,
              std::map<string, vector<int> >& memoryInit,
              std::map<string, int>& testLayout);

  void checkSignal(TestBenchSpec& tb,
                   const std::string& signalName,
                   const std::map<int, int>& valuesAtCycles);

  void checkRAMContents(TestBenchSpec& tb,
                        int checkMemCycle,
                        const std::string ramName,
                        const std::vector<int>& memoryExpected);

  // Set
  void setRAMContents(TestBenchSpec& tb,
                      int setMemCycle,
                      const std::string ramName,
                      const vector<int>& memoryValues);

  void setRVChannel(TestBenchSpec& tb,
                    const std::string fifoName,
                    const vector<pair<int, int> >& writeTimesAndValues);

  void checkRVChannel(TestBenchSpec& tb,
                      const std::string& fifoName,
                      const std::vector<std::pair<int, std::string> >& readTimesAndValues);

  void setRVFifo(TestBenchSpec& tb,
                 const std::string fifoName,
                 const vector<pair<int, int> >& writeTimesAndValues);
  
}
