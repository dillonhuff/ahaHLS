#pragma once

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
  addAssert(const std::string& condition,
            VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, "if (!(" + condition + ")) begin $display(\"assertion(" + condition + ")\"); $finish(); end", info);
  }
  
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
