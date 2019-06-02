#include "verilog_backend.h"

#include "utils.h"

#include <llvm/IR/CFG.h>

#include <llvm/Analysis/OrderedBasicBlock.h>

#include <fstream>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Pull zip file for z3 via travis? https://github.com/Z3Prover/z3/releases/download/z3-4.8.4/z3-4.8.4.d6df51951f4c-x64-ubuntu-14.04.zip

// What to do next?
//   1. CoreIR backend
//   2. Pipelined code cleanup / outer loops
//   3. CGRA linebuffer mapping
//   4. Refactor the state code to use data structures from STG
//   5. Start thinking about task parallel optimizations

// I think a CoreIR backend should precede the other CGRA mapping
// stuff. Better to fill out the pipeline then get things working.
// Also: The loop task parallelism will be a critical optimization
// so getting scheduling working for multiple, independent sections of
// the CDFG will be important

namespace ahaHLS {

  std::string assertString(const std::string& condition) {
    return "if (!(" + condition + ")) begin $display(\"assertion(" + condition + ")\"); $finish(); end";
  }

  std::string assertString(const std::string& condition,
                           const std::string& extraMsg) {
    return "if (!(" + condition + ")) begin $display(\"assertion(" + condition + ") failed: " + extraMsg + "\"); $finish(); end";
  }
  
  void
  addAssert(const std::string& condition,
            VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, assertString(condition), info); 
  }

  void
  addAssert(const std::string& condition,
            const std::string& extraMsg,
            VerilogDebugInfo& info) {
    addAlwaysBlock({"clk"}, assertString(condition, extraMsg), info); 
  }
  
  void emitVerilogForWireAssigns(std::ostream& out,
                                 MicroArchitecture& arch,
                                 const std::string& port,
                                 PortController& portController) {

    auto& portValues = portController.inputControllers[port];
    
    // Check that legacy data structure is not used here.
    // TOOD: Eventually remove portAssignments altogether
    //assert(portValues.portAssignments.size() == 0);

    int numAssigns = portValues.portVals.size();
    
    out << tab(1) << "always @(*) begin" << endl;
    int i = 0;
    for (auto condAndVal : portValues.portVals) {
      Wire cond = condAndVal.first;
      Wire value = condAndVal.second;
      if (i == 0) {
        out << tab(2) << ifStr(cond.valueString()) << " begin " << endl;

        out << tab(3) << port << " = " << value.valueString() << ";" << endl;
        if (i == (numAssigns - 1)) {
          out << tab(2) << "end else begin" << endl;
        } else {
          out << tab(2) << "end else ";
        }
          
      } else if (i == (numAssigns - 1)) {

        out << ifStr(cond.valueString()) << " begin " << endl;
        out << tab(3) << port << " = " << value.valueString() << ";" << endl;
        out << tab(2) << "end else begin" << endl;
          
      } else {

        out << ifStr(cond.valueString()) << " begin " << endl;
        out << tab(3) << port << " = " << value.valueString() << ";" << endl;        
        out << tab(2) << "end else ";
      }

      i++;
    }

    if (portController.hasDefault(port)) {
      out << tab(3) << port << " = " << portController.defaultValue(port) << ";" << endl;
      out << tab(2) << "end" << endl;
    } else {
      out << tab(3) << port << " = " << "0" << ";" << endl;
      out << tab(2) << "end" << endl;
          
    }
    
    out << tab(1) << "end" << endl;
  }

  bool statelessConnection(PortValues& vals,
                           const std::string& port,
                           PortController& portController) {
    set<string> values;
    for (auto val : vals.portVals) {
      values.insert(val.second.valueString());
    }
    bool allAssignsTheSame = values.size() == 1;    
    return allAssignsTheSame &&
      (stateless(portController.unitController.unit) ||
       isInsensitive(port, portController));
    
  }

  set<string> statelessWires(MicroArchitecture& arch) {
    set<string> stateless;
    for (auto& pc : arch.portControllers) {
      for (auto& ic : pc.second.inputControllers) {
        PortValues portVals = ic.second;
        if (statelessConnection(portVals, ic.first, pc.second)) {
          stateless.insert(ic.first);
        }
      }
    }

    return stateless;
  }
  // The same value problem is striking again...
  // The simplified wires really ought to be connected through assigns,
  // but I cannot get that to work without
  void emitVerilogForController(std::ostream& out,
                                MicroArchitecture& arch,
                                PortController& portController) {

    UnitController controller = portController.unitController;

    vector<pair<string, string> > statelessConns;
    for (auto portAndValues : portController.inputControllers) {
      string port = portAndValues.first;
      PortValues vals = portAndValues.second;

      // assert((vals.portAssignments.size() == 0) ||
      //        (vals.portVals.size() == 0));

      if (vals.portVals.size() == 0) {
        assert(false);
      } else {

        int numAssigns = vals.portVals.size();
        bool allAssignsTheSame = numAssigns == 1;
        string assigns = "";

        set<string> values;
        for (auto val : vals.portVals) {
          values.insert(val.second.valueString());
        }
        allAssignsTheSame = values.size() == 1;
      
        out << tab(1) << "// controller for " << portController.unitController.unit.instName << "." << port << endl;

        if (statelessConnection(vals, port, portController)) {
        // if (allAssignsTheSame &&
        //     (stateless(portController.unitController.unit) ||
        //      isInsensitive(port, portController))) {

          //auto stateCondVal = *(begin(vals.portVals));
          auto stateCondVal = *(begin(vals.portVals));
          string portValue = stateCondVal.second.valueString();
          statelessConns.push_back({port, portValue});        
        } else {
          emitVerilogForWireAssigns(out, arch, port, portController);
        }
      }
    }

    // TODO: Replace with assigns
    if (statelessConns.size() > 0) {
      out << tab(1) << "// Insensitive connections" << endl;
      //out << tab(1) << "always @(*) begin" << endl;
      for (auto sc : statelessConns) {
        //out << tab(2) << sc.first << " = " << "clk ? " << sc.second << " : " << sc.second << ";" << endl;
        out << tab(1) << "assign " << sc.first << " = " << sc.second << ";" << endl;
      }
      //out << tab(1) << "end" << endl;
    }
  }
  
  void emitVerilogForControllers(std::ostream& out,
                                 MicroArchitecture& arch) {
    auto& controllers = arch.portControllers;
    for (auto portController : controllers) {
      //cout << "Controller " << portController.first << " for " << portController.second.functionalUnit().instName << endl;
      emitVerilogForController(out, arch, portController.second);
    }
    
  }

  void emitPorts(std::ostream& out,
                 const vector<Port>& allPorts) {

    for (auto pt : allPorts) {
      if (!pt.isInput) {
        out << "\treg [" << to_string(pt.width - 1) << ":0] " << pt.name << "_reg;" << endl;
      }
    }

    out << endl;

    for (auto pt : allPorts) {
      if (!pt.isInput && !pt.isDebug) {
        out << "\tassign " << pt.name << " = " << pt.name << "_reg;" << endl;
      }
    }

  }
  
  void emitFunctionalUnits(std::ostream& out,
                           MicroArchitecture& arch) {
    //map<Instruction*, FunctionalUnit>& unitAssignment) {

    // The issue of how to create builtins also comes up here. Should I have
    // parametric modules I can use for each one?
    // A: I dont need parameters yet, so lets delay that. For now just output
    //    32 bit functional units
    out << endl << "\t// Start Functional Units" << endl;
    std::set<std::string> alreadyEmitted;

    //cout << "# of functional units = " << arch.functionalUnits.size() << endl;
    set<string> noStateWires = statelessWires(arch);
    
    for (auto unit : arch.functionalUnits) {
      //auto unit = iUnit.second;

      //cout << "Emitting unit " << unit.instName << endl;
      
      if (elem(unit.instName, alreadyEmitted)) {
        //cout << "Unit " << unit.instName << " already output" << endl;
        continue;
      }

      alreadyEmitted.insert(unit.instName);

      // These are external functional units
      if (unit.isExternal()) {
        continue;
      }

      map<string, string> wireConns;

      for (auto w : unit.portWires) {
        if (elem(w.second.valueString(), noStateWires)) {
          w.second.registered = false;
          out << "\t" << w.second << ";" << endl;
        } else {
          out << "\t" << w.second << ";" << endl;
        }
        wireConns.insert({w.first, w.second.name});        
      }

      // TODO: Put sequential vs combinational distincion in module description
      if ((unit.getModName() == "RAM") ||
          (unit.getModName() == "register") ||
          (unit.getModName() == "adder") ||
          (unit.getModName() == "reg_passthrough")) {
        wireConns.insert({"clk", "clk"});
        wireConns.insert({"rst", "rst"});
      }

      if (unit.getModName() == "fadd") {
        wireConns.insert({"clk", "clk"});
      }

      if (unit.module.isSequential()) {
        wireConns.insert({"clk", "clk"});
      }

      if (unit.module.hasReset()) {
        cout << "Adding reset field for unit" << unit.instName << endl;
        wireConns.insert({"rst", "rst"});
      }
      
      string modName = unit.getModName();
      auto params = unit.getParams();
      string instName = unit.instName;

      for (auto w : unit.outWires) {

        out << "\twire [" << w.second.width - 1 << ":0] " << w.second.name << ";" << endl;
          
        wireConns.insert({w.first, w.second.name});
      }

      print(out, 1, {modName, params, instName, wireConns});
      out << endl;
    }
    out << "\t// End Functional Units" << endl;
    out << endl;
  }

  void emitRegisterStorage(std::ostream& out,
                           MicroArchitecture& arch) {

    for (auto& rc : arch.regControllers) {
      out << tab(1) << rc.second.reg << ";" << endl;
    }
  }

  void emitComponents(std::ostream& out,
                      const VerilogComponents& debugInfo) {

    for (auto w : debugInfo.debugWires) {
      out << tab(1) << w << ";" << endl;
    }

    out << endl;

    out << tab(1) << "initial begin" << endl;
    for (auto stmt : debugInfo.initStmts) {
      out << tab(2) << stmt << endl;
    }
    out << tab(1) << "end" << endl;

    out << endl;

    for (auto mem : debugInfo.memories) {
      print(out, 1, mem);
      out << endl;
    }
    
    for (auto asg : debugInfo.debugAssigns) {
      out << tab(1) << "assign " << asg.first << " = " << asg.second << ";" << endl;
    }

    out << endl;

    for (auto blk : debugInfo.blocks) {
      print(out, 1, blk);
      out << endl;
    }

    out << endl;

    for (auto blk : debugInfo.delayBlocks) {
      print(out, 1, blk);
      out << endl;
    }

    out << endl;

    for (auto mod : debugInfo.instances) {
      print(out, 1, mod);
      out << endl;
    }
    
  }


  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs,
                   VerilogDebugInfo& info) {
    map<llvm::Value*, int> layout = {};
    // ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    //addNoXChecks(arch, info);
    emitVerilog(name, arch, info);
  }

  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs) {
    VerilogDebugInfo info;
    emitVerilog(name, graph, hcs, info);
  }
  
  void emitVerilog(const STG& stg,
                   std::map<std::string, int>& memoryMap) {
    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog(stg, memoryMap, info);
  }

  void emitVerilog(const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap) {
    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog(stg, memoryMap, info);
  }

  void emitVerilog(const STG& stg,
                   std::map<std::string, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo) {
    auto arch = buildMicroArchitecture(stg, memoryMap);
    emitVerilog(arch, debugInfo);
  }

  void emitVerilog(const STG& stg,
                   std::map<llvm::Value*, int>& memoryMap,
                   const VerilogDebugInfo& debugInfo) {
    auto arch = buildMicroArchitecture(stg, memoryMap);
    emitVerilog(arch, debugInfo);
  }
  
  void emitVerilog(MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo) {

    auto f = arch.stg.getFunction();
    cout << "Emitting verilog for" << endl;
    cout << valueString(f) << endl;
    
    string fn = f->getName();
    emitVerilog(fn, arch, debugInfo);
  }

  // Now: I want register controllers to include the register
  // width as well as name, turn the name field in to a wire field?
  // Once that is done what will be left to do in simplification?
  // I guess the big thing that will be left will be to convert
  // condition variable strings in to data structures that can be
  // emitted as functional units?
  void emitVerilog(const std::string& fn,
                   MicroArchitecture& arch,
                   const VerilogDebugInfo& debugInfo) {

    auto f = arch.stg.getFunction();

    cout << "Emitting verilog for" << endl;
    cout << valueString(f) << endl;
    
    // This is a very flawed way to handle memory ports. For a few reasons
    //   1. It does not know anything about read / write port widths
    //   2. It does not know anything about read / write port resource limits
    vector<Port> allPorts = getPorts(arch);
    for (auto w : debugInfo.wiresToWatch) {
      allPorts.push_back(outputDebugPort(w.width, w.name));
    }
    
    vector<string> portStrings;
    for (auto pt : allPorts) {
      portStrings.push_back(pt.toString());
    }

    ofstream out(fn + ".v");

    string fnInner = fn;

    // Emit inner module
    out << "module " << fnInner << "(" + commaListString(portStrings) + ");" << endl;

    out << endl;

    emitPorts(out, allPorts);

    out << endl << tab(1) << "// Start debug wires and ports" << endl;
    emitComponents(out, debugInfo);
    out << endl << tab(1) << "// End debug wires and ports" << endl;
    
    emitFunctionalUnits(out, arch);
    emitRegisterStorage(out, arch);

    out << endl;
    // for (auto p : arch.pipelines) {
    //   out << "\tassign " << p.inPipe.name << " = global_state == " << p.stateId << ";"<< endl;
    // }

    emitVerilogForControllers(out, arch);    

    out << tab(1) << "// Register controllers" << endl;
    for (auto& rc : arch.regControllers) {
      out << rc.second << endl;
    }
    
    out << "endmodule" << endl << endl;

    out.close();
  }

  // Timeout?
  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap) {
    Schedule s = scheduleFunction(f, hdc);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog(graph, memoryMap);
  }

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<llvm::Value*, int>& memoryMap) {
    Schedule s = scheduleFunction(f, hdc);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog(graph, memoryMap);
  }

  std::string emitTestRAM(std::ostream& out,
                          const TestBenchSpec& tb,
                          MicroArchitecture& arch,
                          const std::map<std::string, int>& layout) {
    // TODO: Do not hardcode these values, read them from hardware constraints
    int readDelay = 1;
    int writeDelay = 3;
    int depth = 32;
    int width = 32;
    int addrWidth = 5;

    VerilogComponents ramComps;

    string memUpdate = "if (wen_del) begin data[waddr_del] <= wdata_del; end if (debug_write_en) begin data[debug_write_addr] <= debug_write_data; end ";
    for (int i = 0; i < arch.numReadPorts(); i++) {
      string iStr = to_string(i);
      memUpdate += "rdata" + iStr + "_reg <= data[raddr_" + iStr + "];";
    }

    addAlwaysBlock({"clk"}, memUpdate, ramComps);

    string ramName = "RAM_" + to_string(readDelay) + "_" + to_string(writeDelay) + "_" + to_string(depth) + "_" + to_string(width);

    vector<Port> ports;
    ports.push_back(inputPort(1, "clk"));
    ports.push_back(inputPort(1, "rst"));

    ramComps.memories.push_back({width, "data", depth});
    ramComps.debugAssigns.push_back({"debug_data", "data[debug_addr]"});
    
    for (int i = 0; i < arch.numReadPorts(); i++) {
      auto iStr = to_string(i);
      ramComps.debugWires.push_back({true, width, "rdata" + iStr + "_reg"});
      
      ports.push_back(outputPort(width, "rdata_" + iStr));
      ports.push_back(inputPort(addrWidth, "raddr_" + iStr));
      ports.push_back(inputPort(1, "ren_" + iStr));

      ramComps.debugAssigns.push_back({"rdata_" + iStr, "rdata" + iStr + "_reg"});
    }

    for (int i = 0; i < arch.numWritePorts(); i++) {
      auto iStr = to_string(i);
      ports.push_back(inputPort(width, "wdata_" + iStr));
      ports.push_back(inputPort(addrWidth, "waddr_" + iStr));
      ports.push_back(inputPort(1, "wen_" + iStr));
    }

    ports.push_back(inputPort(addrWidth, "debug_addr"));
    ports.push_back(outputPort(width, "debug_data"));

    ports.push_back(inputPort(addrWidth, "debug_write_addr"));
    ports.push_back(inputPort(width, "debug_write_data"));
    ports.push_back(inputPort(1, "debug_write_en"));        

    ramComps.debugWires.push_back({false, addrWidth, "waddr_del"});
    ramComps.debugWires.push_back({false, width, "wdata_del"});    
    ramComps.debugWires.push_back({false, 1, "wen_del"});


    // TODO: Generalize to arbitrary numbers of writes
    map<string, string> wenConns{{"clk", "clk"}, {"in", "wen_0"}, {"out", "wen_del"}};
    map<string, string> wenParams{{"WIDTH", "1"}};
    ramComps.instances.push_back({"delay", wenParams, "wen_delay", wenConns});

    map<string, string> wdataConns{{"clk", "clk"}, {"in", "wdata_0"}, {"out", "wdata_del"}};
    map<string, string> wdataParams{{"WIDTH", "32"}};
    ramComps.instances.push_back({"delay", wdataParams, "wdata_delay", wdataConns});

    map<string, string> waddrConns{{"clk", "clk"}, {"in", "waddr_0"}, {"out", "waddr_del"}};
    map<string, string> waddrParams{{"WIDTH", "5"}};
    ramComps.instances.push_back({"delay", waddrParams, "waddr_delay", waddrConns});
    
    emitModule(out, ramName, ports, ramComps);

    return ramName;
  }

  // What is the problem I'm having? blur_no_lb_tb auto generated RAM
  // has no ports for reads and writes. I need to actually instantiate
  // the module that corresponds to 
  void emitVerilogTestBench(const TestBenchSpec& tb,
                            MicroArchitecture& arch,
                            const std::map<std::string, int>& layout) {
    string modName = tb.name + "_tb";
    ofstream out(modName + ".v");

    bool hasRAM = layout.size() > 0;

    string ramName = "noRam";

    VerilogComponents comps;
    for (auto action : tb.actionsOnConditions) {
      //cout << "Adding action " << action << endl;
      addAlwaysBlock({"clk"}, action, comps);
    }

    comps.debugWires.push_back({true, 32, "num_clocks_after_reset"});
    comps.debugWires.push_back({true, 32, "total_cycles"});
    comps.debugWires.push_back({true, 32, "max_cycles"});

    if (!tb.useModSpecs) {    
      for (auto pt : getPorts(arch)) {
        comps.debugWires.push_back({false, pt.width, pt.name});

        if (elem(pt.name, tb.settableWires)) {
          comps.debugWires.push_back({true, pt.width, pt.name + "_reg"});
          comps.debugAssigns.push_back({pt.name, pt.name + "_reg"});
        }
      }
    }


    comps.delayBlocks.push_back({3, "clk_reg = !clk_reg;"});

    for (auto actionList : tb.actionsOnCycles) {
      int cycleNo = actionList.first;
      for (auto action : actionList.second) {
        addAlwaysBlock({"clk"}, "if (" + to_string(cycleNo) + " == total_cycles) begin " + action + " end", comps);
      }
    }

    for (auto actionList : tb.actionsInCycles) {
      int cycleNo = actionList.first;
      for (auto action : actionList.second) {
        addAlwaysBlock({}, "if (" + to_string(cycleNo) + " == total_cycles) begin " + action + " end", comps);
      }
    }
    
    addAlwaysBlock({"clk"}, "total_cycles <= total_cycles + 1;", comps);

    comps.initStmts.push_back("#1 clk_reg = 0;");
    comps.initStmts.push_back("#1 rst_reg = 1;");
    comps.initStmts.push_back("#1 total_cycles = 0;");
    comps.initStmts.push_back("#1 max_cycles = " + to_string(tb.maxCycles) + ";");
    comps.initStmts.push_back("#1 num_clocks_after_reset = 0;");
    
    if (hasRAM && !tb.useModSpecs) {

      ramName = emitTestRAM(out, tb, arch, layout);
      
      comps.debugWires.push_back({true, 1, "in_set_mem_phase"});
      comps.debugWires.push_back({true, 1, "in_run_phase"});
      comps.debugWires.push_back({true, 1, "in_check_mem_phase"});

      comps.debugWires.push_back({true, 32, "clocks_in_set_mem_phase"});
      comps.debugWires.push_back({true, 32, "clocks_in_run_phase"});
      comps.debugWires.push_back({true, 32, "clocks_in_check_mem_phase"});
      
      comps.debugWires.push_back({true, 5, "dbg_wr_addr"});
      comps.debugWires.push_back({true, 32, "dbg_wr_data"});
      comps.debugWires.push_back({true, 1, "dbg_wr_en"});

      comps.debugWires.push_back({true, 5, "dbg_addr"});    
      comps.debugWires.push_back({false, 32, "dbg_data"});

      addAlwaysBlock({"clk"}, "if (total_cycles >= max_cycles) begin if (valid == 1 && in_check_mem_phase) begin $display(\"Passed\"); $finish(); end else begin $display(\"valid == %d. Ran out of cycles, finishing.\", valid); $finish(); end end", comps);
      addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", comps);

      addAlwaysBlock({"clk"}, "if (in_set_mem_phase) begin clocks_in_set_mem_phase <= clocks_in_set_mem_phase + 1; end ", comps);

      comps.initStmts.push_back("#1 in_set_mem_phase = 1;");
      comps.initStmts.push_back("#1 in_check_mem_phase = 0;");
      comps.initStmts.push_back("#1 in_run_phase = 0;");

      comps.initStmts.push_back("#1 clocks_in_set_mem_phase = 0;");
      comps.initStmts.push_back("#1 clocks_in_run_phase = 0;");        
      comps.initStmts.push_back("#1 clocks_in_check_mem_phase = 0;");

      map<string, string> ramConnections{{"clk", "clk"}, {"rst", "rst"}, {"debug_addr", "dbg_addr"}, {"debug_data", "dbg_data"}, {"debug_write_addr", "dbg_wr_addr"}, {"debug_write_data", "dbg_wr_data"}, {"debug_write_en", "dbg_wr_en"}};    
      for (int i = 0; i < arch.numReadPorts(); i++) {
        auto iStr = to_string(i);
        ramConnections.insert({"raddr_" + iStr, "raddr_" + to_string(i)});
        ramConnections.insert({"rdata_" + iStr, "rdata_" + to_string(i)});
      }

      for (int i = 0; i < arch.numWritePorts(); i++) {
        auto iStr = to_string(i);
        ramConnections.insert({"waddr_" + iStr, "waddr_" + to_string(i)});
        ramConnections.insert({"wdata_" + iStr, "wdata_" + to_string(i)});
        ramConnections.insert({"wen_" + iStr, "wen_" + to_string(i)});
      }
    
      comps.instances.push_back({ramName, "ram", ramConnections});
      // }
    
      // if (hasRAM && !tb.useModSpecs) {
      int cyclesInRun = tb.runCycles;

      addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin if (!valid) begin $display(\"Failed: Checking memory, but the module is not done running\"); $finish(); end end", comps);

      addAlwaysBlock({"clk"}, "if (clocks_in_run_phase == (" + to_string(cyclesInRun - 1) + ")) begin in_check_mem_phase <= 1; in_run_phase <= 0; end ", comps);

      addAlwaysBlock({"clk"}, "if (in_run_phase) begin clocks_in_run_phase <= clocks_in_run_phase + 1; end", comps);

      addAlwaysBlock({"clk"}, "if (in_check_mem_phase) begin clocks_in_check_mem_phase <= clocks_in_check_mem_phase + 1; end", comps);    

      int setNum = 0;
      for (auto memName : tb.memoryInit) {
        for (int i = 0; i < (int) memName.second.size(); i++) {
          // TODO: Add memory layout info
          assert(contains_key(memName.first, layout));

          addAlwaysBlock({"clk"}, "if (in_set_mem_phase && clocks_in_set_mem_phase == " + to_string(setNum) + ") begin dbg_wr_en <= 1; dbg_wr_addr <= " + to_string(map_find(memName.first, layout) + i) + "; dbg_wr_data <= " + to_string(memName.second[i]) + "; end", comps);

          setNum++;
        
        }
      }

      int cyclesInSetMem = setNum;
      addAlwaysBlock({"clk"}, "if (clocks_in_set_mem_phase == (" + to_string(cyclesInSetMem) + ")) begin in_run_phase <= 1; rst_reg <= 0; dbg_wr_en <= 0; in_set_mem_phase <= 0; end", comps);

      addAlwaysBlock({"clk"}, "if (!in_set_mem_phase) begin dbg_wr_en <= 0; end", comps);
    
      int checkNum = 0;
      int lastNum = -1;
    
      for (auto memName : tb.memoryExpected) {
        for (int i = 0; i < (int) memName.second.size(); i++) {
          // TODO: Add memory layout info
          assert(contains_key(memName.first, layout));

          addAlwaysBlock({"clk"}, "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin dbg_addr <= " + to_string(map_find(memName.first, layout) + i) + "; end", comps);

          string str = "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin ";
          if (lastNum >= 0) {
            str += "$display(\"mem[%d] == %d\", dbg_addr, dbg_data);";

            str += "  if (dbg_data == " + to_string(memName.second[lastNum]) + ") begin $display(\"Correct.\"); end else begin $display(\"Assert failed\"); $finish(); end ";
          }
          str += "end";

          addAlwaysBlock({"clk"}, str, comps);

          lastNum = checkNum;
          checkNum++;
        }

        // Final code to check last value
        string str = "if (in_check_mem_phase && clocks_in_check_mem_phase == " + to_string(checkNum) + ") begin ";
        str += "$display(\"mem[%d] == %d\", dbg_addr, dbg_data);";

        str += "  if (dbg_data == " + to_string(memName.second[lastNum]) + ") begin $display(\"Correct.\"); end else begin $display(\"Assert failed\"); $finish(); end ";
        str += "end";
        addAlwaysBlock({"clk"}, str, comps);
      }
      
    } else {
      addAlwaysBlock({"clk"}, "if (total_cycles >= max_cycles) begin $display(\"Passed\"); $finish(); end", comps);
    }

    // Add module instances for arguments to function
    if (tb.useModSpecs) {
      auto f = arch.stg.getFunction();

      comps.debugWires.push_back({true, 1, "clk_reg"});
      comps.debugWires.push_back({true, 1, "rst_reg"});

      comps.debugWires.push_back({false, 1, "clk"});
      comps.debugWires.push_back({false, 1, "rst"});      

      comps.debugAssigns.push_back({"clk", "clk_reg"});
      comps.debugAssigns.push_back({"rst", "rst_reg"});      

      for (int i = 0; i < (int) f->arg_size(); i++) {

        if (arch.hcs.hasArgumentSpec(getArg(f, i)) ||
            contains_key(getArg(f, i), arch.hcs.modSpecs)) {
          cout << valueString(getArg(f, i)) << "is modspeced" << endl;

          ModuleSpec s;
          if (arch.hcs.hasArgumentSpec(getArg(f, i))) {
            s = arch.hcs.getArgumentSpec(getArg(f, i));
          } else {
            s = map_find(getArg(f, i), arch.hcs.modSpecs);
          }

          cout << "spec is " << s << endl;

          string instName = getArg(f, i)->getName();
          if (instName == "") {
            instName = "arg_" + to_string(i);
          }
          map<string, string> conns;
          for (auto p : s.ports) {
            if (p.first != "rst") {
              Wire w;
              string wireName = instName + "_" + p.second.name;
              if (!elem(wireName, tb.settableWires)) {
                w = wire(p.second.width, wireName);
                comps.debugWires.push_back(w);
              } else {
                //cout << "Settable wire " << p.first << endl;
                w = reg(p.second.width, wireName);
                comps.debugWires.push_back(w);
              }
              conns[p.first] = w.name;
            } else {
              conns[p.first] = "rst";
            }
          }

          if (s.isSequential()) {
            conns.insert({"clk", "clk"});
          }
          if (s.hasReset()) {
            conns.insert({"rst", "rst"});
          }
          ModuleInstance arg{s.name, s.params, instName, conns};
          comps.instances.push_back(arg);
        } else if (IntegerType::classof(getArg(f, i)->getType())) {
          string modName = "hls_wire";
          string instName = "arg_" + to_string(i);
          
          map<string, string> conns;
          int width = getValueBitWidth(getArg(f, i));
          map<string, Port> ports{{"in_data", inputPort(width, "in_data")}, {"out_data", outputPort(width, "out_data")}};
          for (auto p : ports) {
            if (p.first != "rst") {
              Wire w;
              string wireName = instName + "_" + p.second.name;
              if (!elem(wireName, tb.settableWires)) {
                w = wire(p.second.width, wireName);
                comps.debugWires.push_back(w);
              } else {
                //cout << "Settable wire " << p.first << endl;
                w = reg(p.second.width, wireName);
                comps.debugWires.push_back(w);
              }
              conns[p.first] = w.name;
            } else {
              conns[p.first] = "rst";
            }
          }
          
          ModuleInstance arg(modName, {{"WIDTH", to_string(getValueBitWidth(getArg(f, i)))}}, instName, conns);
          comps.instances.push_back(arg);
        }
      }
    }

    map<string, string > dutConns;
    ModuleInstance dut{tb.name, "dut", dutConns};
    for (auto pt : getPorts(arch)) {
      //cout << "port = " << pt.name << endl;
      if (!tb.useModSpecs || (!elem(pt.name, tb.settableWires) || (pt.name == "clk") || (pt.name == "rst"))) {
        //cout << "not settable = " << pt.name << endl;        
        dut.portConnections.insert({pt.name, pt.name});
      }
    }

    comps.instances.push_back(dut);
    
    vector<Port> pts;
    emitModule(out, modName, pts, comps);

    out.close();
  }

  void noStoredValuesXWhenUsed(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (StoreInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("wdata"), unit.portWires).name;
          addAssert(notAtState(activeState, arch) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }

  void noLoadedValuesXWhenUsed(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (LoadInst::classof(instr)) {

          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          printInstrAtState(instr, activeState, arch, debugInfo); 

          string wireName = map_find(string("rdata"), unit.outWires).name;
          //addAssert(notAtState(activeState, arch) + " || " +
          addAssert(notStr(blockActiveInState(activeState, instr->getParent(), arch).valueString()) + " || " +
                    wireName + " !== 'dx",
                    debugInfo);
        }
      }
    }

  }

  void noLoadAddressesXWhenUsed(MicroArchitecture& arch,
                                VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (LoadInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string wireName = map_find(string("raddr"), unit.portWires).name;
          string valCheck = wireName + " !== 'dx";
          
          string activeStr =
            blockActiveInState(activeState, instr->getParent(), arch).valueString();
          
          addAssert(implies(activeStr, valCheck), debugInfo);
          
          // addAssert(notAtState(activeState, arch) + " || " +
          //           wireName + " !== 'dx",
          //           debugInfo);
        }
      }
    }

  }

  void addDisplay(const std::string& cond,
                  const std::string& condStr,
                  const std::vector<std::string>& vars,
                  VerilogDebugInfo& debugInfo) {
    addAlwaysBlock({"clk"}, "if (" + cond + ") begin $display(\"" + condStr + "\", " + commaListString(vars) + "); end", debugInfo);
  }
  
  void printInstrAtState(Instruction* instr,
                         StateId st,
                         MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    auto iStr = sanitizeFormatForVerilog(instructionString(instr));

    if (hasOutput(instr)) {
      auto unitOutput = dataOutput(instr, arch);
      addAlwaysBlock({"clk"}, "if(" + blockActiveInState(st, instr->getParent(), arch).valueString() + ") begin $display(\"" + iStr + " == %d\", " + unitOutput + "); end", debugInfo);      
    } else {
      addAlwaysBlock({"clk"}, "if(" + blockActiveInState(st, instr->getParent(), arch).valueString() + ") begin $display(\"" + iStr + "\"); end", debugInfo);      
    }
  }

  std::string atState(const StateId state, MicroArchitecture& arch) {
    return atStateWire(state, arch).name;
  }

  std::string notAtState(const StateId state, MicroArchitecture& arch) {
    return checkNotWire(atStateWire(state, arch), arch).name;
  }

  Wire notActiveWire(const StateId state,
                            Instruction* instr,
                            MicroArchitecture& arch) {
    return checkNotWire(blockActiveInState(state, instr->getParent(), arch), arch);
  }
  
  void noPhiOutputsXWhenUsed(MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (PHINode::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          StateId activeState = st.first;

          string iStr = instructionString(instr);
          printInstrAtState(instr, activeState, arch, debugInfo);
          
          string wireName = unit.onlyOutputVar();

          string valCheck = wireName + " !== 'dx";

          string activeStr =
            blockActiveInState(activeState, instr->getParent(), arch).valueString();
          addAssert(implies(activeStr, valCheck), debugInfo);
          // string notActive = notActiveWire(activeState, instr, arch).valueString();
          // addAssert(notActive + " || " + valCheck, debugInfo);
        }
      }
    }
  }

  void noFifoReadsX(MicroArchitecture& arch,
                    VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (isBuiltinFifoRead(instr)) {
          StateId activeState = st.first;
          string iStr = instructionString(instr);

          printInstrAtState(instr, activeState, arch, debugInfo);
          
          string wireName = dataOutput(instr, arch);

          string valCheck = wireName + " !== 'dx";
          string active = atState(st.first, arch);

          addAssert(notStr(active) + " || " + valCheck, debugInfo);
          
        }
      }
    }
  }

  void noFifoWritesX(MicroArchitecture& arch,
                     VerilogDebugInfo& debugInfo) {
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (isBuiltinFifoWrite(instr)) {
          StateId activeState = st.first;
          string iStr = instructionString(instr);

          printInstrAtState(instr, activeState, arch, debugInfo);

          FunctionalUnit unit = map_find(instr, arch.unitAssignment);   
          string in0Name = map_find(string("in_data"), unit.portWires).name;

          string valCheck = in0Name + " !== " + to_string(getValueBitWidth(instr->getOperand(0))) + "'dx";
          string active = atState(st.first, arch);

          addAssert(notStr(active) + " || " + valCheck, debugInfo);
        }
      }
    }
  }

  void addSetStencilChecks(MicroArchitecture& arch,
                           VerilogDebugInfo& info) {
    for (auto& bb : arch.stg.getFunction()->getBasicBlockList()) {
      for (auto& instrRef : bb) {
        auto instr = &instrRef;
        if (isBuiltinPortWrite(instr)) {
          string portName = getPortName(instr);
          if (portName == "set_data") {
            printInstrAtState(instr, arch.stg.instructionStartState(instr), arch, info);
          }

          if (portName == "in_data_bus") {

            StateId state = arch.stg.instructionStartState(instr);
            auto iStr = sanitizeFormatForVerilog(instructionString(instr));

            string active =
              blockActiveInState(state, instr->getParent(), arch).valueString();
            vector<string> argValues;
            ControlFlowPosition pos = position(state, instr, arch);
            string argString = "";
            for (int i = 1; i < (int) instr->getNumOperands() - 1; i++) {
              cout << "argument " << i << " = " << valueString(instr->getOperand(i)) << endl;
              argValues.push_back(outputName(instr->getOperand(i), pos, arch));
              //argValues.push_back("dummy");
              argString += "\\targ " + to_string(i) + " = %d\\n";
            }
            addDisplay(active, argString, argValues, info);
            
            //printInstrAtState(instr, arch.stg.instructionStartState(instr), arch, info);
          }

        }

      }
    }
  }
  
  void noBinopsTakeXInputs(MicroArchitecture& arch,
                           VerilogDebugInfo& debugInfo,
                           const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsStartingAt(st.first)) {
        auto instr = instrG;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;

            string notAtSt =
              notStr(blockActiveInState(st.first, instr->getParent(), arch).valueString());
            addAssert(notAtSt + " || " +
                      in0Name + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);
            
            addAssert(notAtSt + " || " +
                      in1Name + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }  

  void noPortXWrites(const std::string& portName,
                     MicroArchitecture& arch,
                     VerilogDebugInfo& info) {
    for (auto st : arch.stg.opStates) {
      for (auto instr : arch.stg.instructionsFinishingAt(st.first)) {
        if (isBuiltinPortWrite(instr)) {
          if (getPortName(instr) == portName) {
            FunctionalUnit unit = map_find(instr, arch.unitAssignment);

            StateId activeState = st.first;
            BasicBlock* blk = instr->getParent();

            Wire active = blockActiveInState(activeState, blk, arch);

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, info);

            cout << "Operand 1 to " << portName << " = " << valueString(instr->getOperand(1)) << endl;
            auto pos = position(activeState, instr, arch);
            string in0Name = outputName(instr->getOperand(1),
                                        pos,
                                        arch);

            addAssert(implies(active.valueString(),
                              in0Name + " !== " + to_string(getValueBitWidth(instr->getOperand(1))) + "'dx"),
                      info);
          }
        }
      }
    }
    
  }
  
  void noPortXWhenRead(const std::string& portName,
                       MicroArchitecture& arch,
                       VerilogDebugInfo& info) {
    for (auto st : arch.stg.opStates) {
      for (auto instr : arch.stg.instructionsFinishingAt(st.first)) {
        if (isBuiltinPortRead(instr)) {
          if (getPortName(instr) == portName) {
            FunctionalUnit unit = map_find(instr, arch.unitAssignment);

            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, info);

            string outName = map_find(portName, unit.outWires).name;
            addAssert(notAtState(activeState, arch) + " || " +
                      outName + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      info);
          }
        }
      }
    }
           
  }

  void noOutputXWhenProduced(MicroArchitecture& arch,
                             VerilogDebugInfo& debugInfo,
                             const std::string& moduleTypeName,
                             const std::string& outputWireName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        FunctionalUnit unit = map_find(instr, arch.unitAssignment);
        if (unit.getModName() == moduleTypeName) {
          StateId activeState = st.first;

          string iStr = instructionString(instr);
          printInstrAtState(instr, activeState, arch, debugInfo);

          Wire active = blockActiveInState(activeState, instr->getParent(), arch);

          string outName = map_find(string(outputWireName), unit.outWires).name;
          addAssert(implies(active.valueString(),
                            outName + " !== " + to_string(getValueBitWidth(instr)) + "'dx"),
                    debugInfo);

        }
      }
    }
    
  }
  
  void noBinopsProduceXOutputs(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo,
                               const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (BinaryOperator::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);

            string outName = map_find(string("out"), unit.outWires).name;
            addAssert(notAtState(activeState, arch) + " || " +
                      outName + " !== " + to_string(getValueBitWidth(instr)) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }  
  
  void noCompareOpsTakeXInputs(MicroArchitecture& arch,
                               VerilogDebugInfo& debugInfo,
                               const std::string& opName) {
    
    for (auto st : arch.stg.opStates) {
      for (auto instrG : arch.stg.instructionsFinishingAt(st.first)) {
        auto instr = instrG;
        if (CmpInst::classof(instr)) {
          FunctionalUnit unit = map_find(instr, arch.unitAssignment);
          if (unit.getModName() == opName) {
            StateId activeState = st.first;

            string iStr = instructionString(instr);
            printInstrAtState(instr, activeState, arch, debugInfo);
          
            string in0Name = map_find(string("in0"), unit.portWires).name;
            string in1Name = map_find(string("in1"), unit.portWires).name;

            addAssert(notAtState(activeState, arch) + " || " +
                      in0Name + " !== " + to_string(getValueBitWidth(instr->getOperand(0))) + "'dx",
                      debugInfo);

            addAssert(notAtState(activeState, arch) + " || " +
                      in1Name + " !== " + to_string(getValueBitWidth(instr->getOperand(1))) + "'dx",
                      debugInfo);
            
          }
        }
      }
    }

  }

  std::string implies(const std::string& a, const std::string& b) {
    return parens(notStr(a) + " || " + b);
  }

  // void noOverlappingLastBlockTransitions(MicroArchitecture& arch,
  //                                        VerilogDebugInfo& info) {
  //   RegController& rc = arch.getController(arch.cs.getLastBB());
  //   string inPipe = inAnyPipeline(arch).valueString();
  //   //for (pair<string, string> condAndVal0 : rc.values) {
  //   for (auto condAndVal0 : rc.values) {
  //     //string cond0 = condAndVal0.first;
  //     Wire cond0 = condAndVal0.first;
  //     //for (pair<string, string> condAndVal1 : rc.values) {
  //     for (auto condAndVal1 : rc.values) {
  //       //string cond1 = condAndVal1.first;
  //       Wire cond1 = condAndVal1.first;

  //       if (cond0.valueString() != cond1.valueString()) {
  //         addAssert(implies(andStr(notStr(inPipe), cond0.valueString() + " === 1"),
  //                           cond1.valueString() + " !== 1"),
  //                   info);
  //       }
  //     }
      
  //   }
    
  // }
  
  void noOverlappingStateTransitions(MicroArchitecture& arch,
                                     VerilogDebugInfo& info) {

    
    //RegController& rc = arch.getController(arch.cs.getGlobalState());

    for (auto st : arch.stg.opStates) {
      RegController& rc = arch.getController(stateActiveReg(st.first, arch));
      //string inPipe = inAnyPipeline(arch).valueString();
      for (auto condAndVal0 : rc.values) {
        string cond0 = condAndVal0.first.valueString();
        for (auto condAndVal1 : rc.values) {
          string cond1 = condAndVal1.first.valueString();

          if (cond0 != cond1) {

            addAssert(implies(cond0 + " === 1",
                              cond1 + " !== 1"),
                      "Overlapping state active transition for state " + to_string(st.first),
                      info);

          }
        }
      
      }
    }
  }

  void noOverlappingBlockTransitions(MicroArchitecture& arch,
                                     VerilogDebugInfo& info) {

    for (auto st : arch.stg.opStates) {
      RegController& rc = arch.getController(nextBBReg(st.first, arch));
    
      for (auto condAndVal0 : rc.values) {
        string cond0 = condAndVal0.first.valueString();
        for (auto condAndVal1 : rc.values) {
          string cond1 = condAndVal1.first.valueString();

          if (cond0 != cond1) {
            addAssert(implies(cond0 + " === 1",
                              cond1 + " !== 1"),
                      info);

          }
        }
      
      }
    }
  }

  void noOverlappingLastBlockTransitions(MicroArchitecture& arch,
                                         VerilogDebugInfo& info) {
    for (auto st : arch.stg.opStates) {
      RegController& rc = arch.getController(lastBBReg(st.first, arch));
    
      for (auto condAndVal0 : rc.values) {
        string cond0 = condAndVal0.first.valueString();
        for (auto condAndVal1 : rc.values) {
          string cond1 = condAndVal1.first.valueString();

          if (cond0 != cond1) {

            addAssert(implies(cond0 + " === 1",
                              cond1 + " !== 1"),
                      info);

          }
        }
      
      }
    }
  }
  
  
  void noAddsTakeXInputs(MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    noBinopsTakeXInputs(arch, debugInfo, "add");
  }

  void noMulsTakeXInputs(MicroArchitecture& arch,
                         VerilogDebugInfo& debugInfo) {
    noBinopsTakeXInputs(arch, debugInfo, "mul");
  }

  void emitModule(std::ostream& out,
                  const std::string& name,
                  std::vector<Port>& ports,
                  VerilogComponents& comps) {
    vector<string> portStrings;
    for (auto pt : ports) {
      portStrings.push_back(pt.toString());
    }
    out << "module " << name << "(" << commaListString(portStrings) << ");" << endl;
    emitComponents(out, comps);
    out << "endmodule" << endl;
  }

  void atLeastOneValidPhiInput(MicroArchitecture& arch,
                               VerilogDebugInfo& info) {
    // What do I want to check here?
    // For each phi
    //   if it is active, at least one of its container blocks preds
    //   is the nextActiveBlock, or was taken in this cycle
  }

  void
  noBlocksActiveInStatesWhereTheyAreNotScheduled(MicroArchitecture& arch,
                                                 VerilogDebugInfo& info) {
    Function* f = arch.stg.getFunction();
    for (auto& blkV : f->getBasicBlockList()) {
      BasicBlock* blk = &blkV;

      StateId blkMin = arch.stg.blockStartState(blk);
      StateId blkMax = arch.stg.blockEndState(blk);      

      for (auto& st : arch.stg.opStates) {
        StateId state = st.first;
        if (state < blkMin) {
          addAssert(implies(atState(state, arch),
                            notStr(arch.isActiveBlockVar(state, blk).valueString())),
                    info);
        }

        if (blkMax < state) {
          addAssert(implies(atState(state, arch),
                            notStr(arch.isActiveBlockVar(state, blk).valueString())),
                    info);
        }
        
      }
    }
  }

  void printAllActiveStates(MicroArchitecture& arch,
                            VerilogDebugInfo& info) {

    vector<string> vars;
    string str = "state active flags: ";
    for (auto st : arch.stg.opStates) {
      StateId state = st.first;

      str += "\\n" + tab(1) + "State: " + to_string(state) + " = %d, ";
      vars.push_back(stateActiveReg(state, arch).valueString());

      vector<string> blkVars;
      string blkStr = "\\n" + tab(2) + "blks: ";
      for (auto blk : blocksInState(state, arch.stg)) {
        blkStr += to_string(arch.cs.getBasicBlockNo(blk)) + " = %d, ";
        blkVars.push_back(arch.isActiveBlockVar(state, blk).valueString());
      }
      concat(vars, blkVars);
      str += blkStr;
    }

    addDisplay("1", str, vars, info);
  }

  void printEdgeTakenWires(MicroArchitecture& arch,
                           VerilogDebugInfo& info) {
    addDisplay("1", "valid_reg = %d", {"valid_reg"}, info);
    for (auto w : arch.edgeTakenWires) {
      addDisplay("1", w.second.valueString() + " = %d", {w.second.valueString()}, info);
    }
  }

  void
  noPipelinesWithMultipleActiveOutOfStateBranches(MicroArchitecture& arch,
                                                  VerilogDebugInfo& info) {
    for (auto p : arch.pipelines) {
      for (StateId state0 : p.p.getStates()) {
        for (StateId state1 : p.p.getStates()) {
          if (state0 != state1) {
            bool state0OutBranch =
              getOutOfStateTransitions(state0, arch.stg).size() > 0;

            bool state1OutBranch =
              getOutOfStateTransitions(state1, arch.stg).size() > 0;

            if (state0OutBranch && state1OutBranch) {
              addAssert(implies(stateActiveReg(state0, arch).valueString(),
                                notStr(stateActiveReg(state1, arch).valueString())),
                        info);
            }
            
          }
        }
      }
    }
  }

  void noOverlappingSetsOnPort(const std::string& portName,
                               MicroArchitecture& arch,
                               VerilogDebugInfo& info) {
    for (auto portController : arch.portControllers) {
      PortController& c = portController.second;
      FunctionalUnit unit = c.functionalUnit();
      
      if (contains_key(portName, unit.portWires)) {

        string valName = unit.inputWire(portName);

        cout << "valname = " << valName << endl;

        if (contains_key(valName, c.inputControllers)) {
          PortValues pv = map_find(valName, c.inputControllers);
          cout << "Found port " << portName << endl;

          for (auto condAndVal0 : pv.portVals) {
            Wire cond0 = condAndVal0.first;
            for (auto condAndVal1 : pv.portVals) {
              Wire cond1 = condAndVal1.first;

              if (cond0.valueString() != cond1.valueString()) {
                addAssert(implies(cond0.valueString(),
                                  notStr(cond1.valueString())),
                          info);
              }
            }
          }
        }
      }
    }
  }
  
  // Thoughts: Tricky to generate complex printouts in synthesizable
  // verilog. Maybe I should look in to using unsynthesizable constructs?
  void addControlSanityChecks(MicroArchitecture& arch,
                              VerilogDebugInfo& info) {
    noOverlappingLastBlockTransitions(arch, info);
    noOverlappingBlockTransitions(arch, info);
    noOverlappingStateTransitions(arch, info);

    noPipelinesWithMultipleActiveOutOfStateBranches(arch, info);

    noOverlappingSetsOnPort("wen_0", arch, info);

    // TODO: Check that there is no port controller overlap? This will be
    // so expensive that maybe it should be saved for special datapath
    // sanity check?

    noBlocksActiveInStatesWhereTheyAreNotScheduled(arch, info);
    atLeastOneValidPhiInput(arch, info);

    
    
    //printEdgeTakenWires(arch, info);
    //printAllActiveStates(arch, info);
  }

  void printActiveBlocks(MicroArchitecture& arch, VerilogDebugInfo& info) {
    for (auto& bbR : *(arch.stg.getFunction())) {
      BasicBlock* bb = &bbR;
      //int num = arch.cs.getBasicBlockNo(bb);
      for (auto st : arch.stg.opStates) {
        StateId stateId = st.first;
        addDisplay(blockActiveInState(stateId, bb, arch).valueString(), "block: " + sanitizeFormatForVerilogId(blkNameString(bb)) + " is active in state " + to_string(stateId), {}, info);
      }
    }
  }
  
  void addNoXChecks(MicroArchitecture& arch,
                    VerilogDebugInfo& info) {
    addControlSanityChecks(arch, info);
    noBinopsTakeXInputs(arch, info, "fadd");
    noBinopsTakeXInputs(arch, info, "lshrOp");
    noBinopsTakeXInputs(arch, info, "ashrOp");

    noOutputXWhenProduced(arch, info, "lshrOp", "out");
    noOutputXWhenProduced(arch, info, "trunc", "out");
    noBinopsProduceXOutputs(arch, info, "fadd");
    noFifoReadsX(arch, info);
    noFifoWritesX(arch, info);    
    noCompareOpsTakeXInputs(arch, info, "ne");
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noLoadedValuesXWhenUsed(arch, info);
    noLoadAddressesXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    //noPortXWhenRead("out_data", arch, info);
    noPortXWrites("waddr_0", arch, info);
    noPortXWrites("wdata_0", arch, info);    
  }

  std::string argName(llvm::Argument* arg) {
    Function* f = arg->getParent();
    bool found = false;
    int argNum = 0;
    for (auto& a : f->args()) {
      if (&a == arg) {
        found = true;
        break;
      }
      argNum++;
    }

    assert(found);
    
    return (arg->getName() == "") ? ("arg_" + to_string(argNum)) : string(arg->getName());
  }

  void TestBenchSpec::setArgPort(llvm::Argument* arg, std::string port, int cycleNo, std::string value) {
    auto argN = argName(arg) + "_" + port;
    map_insert(actionsInCycles, cycleNo, argN + " = " + value + ";");
  }

  void TestBenchSpec::setArgPort(llvm::Argument* arg, std::string port, int cycleNo, const int value) {
    setArgPort(arg, port, cycleNo, to_string(value));
  }

  void TestBenchSpec::settablePort(llvm::Argument* arg, std::string port) {
    settableWires.insert(argName(arg) + "_" + port);
  }

  // Maybe: Create scheduling problem from execution constraints as a method
  // of the execution constraints problem?
  // Do I ever manually create a SchedulingProblem and populate it with constraints?
  // I guess I do add an objective function, but that could be put in to
  // ExecConstraints
  MicroArchitecture synthesizeVerilog(llvm::Function* f,
                                      InterfaceFunctions& interfaces,
                                      HardwareConstraints& hcs) {
    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);
    addDataConstraints(f, exec);

    cout << "LLVM function after inlining reads" << endl;
    cout << valueString(f) << endl;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    //ArchOptions options;
    auto arch = buildMicroArchitecture(graph, layout, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog(arch, info);

    return arch;
  }


  void setRAM(TestBenchSpec& tb,
              int startSetMemCycle,
              const std::string name,
              std::map<string, vector<int> >& memoryInit,
              std::map<string, int>& testLayout) {

    if (memoryInit.size() == 0) {
      return;
    }

    tb.settableWires.insert(name + "_debug_write_addr");
    tb.settableWires.insert(name + "_debug_write_data");
    tb.settableWires.insert(name + "_debug_write_en");
    
    for (auto exp : memoryInit) {
      int offset = map_find(exp.first, testLayout);
      for (int i = 0; i < (int) exp.second.size(); i++) {
        int val = exp.second[i];

        map_insert(tb.actionsOnCycles, startSetMemCycle, name + "_debug_write_addr <= " + to_string(offset) + ";");
        map_insert(tb.actionsOnCycles, startSetMemCycle, name + "_debug_write_data <= " + to_string(val) + ";");
        map_insert(tb.actionsOnCycles, startSetMemCycle, name + string("_debug_write_en <= 1;"));

        offset++;
        startSetMemCycle++;
      }
    }

    map_insert(tb.actionsOnCycles, startSetMemCycle, name + string("_debug_write_en <= 0;"));
  }

  void
  checkRVChannel(TestBenchSpec& tb,
                 const std::string& fifoName,
                 const std::vector<std::pair<int, std::string> >& readTimesAndValues) {

    tb.settableWires.insert(fifoName + "_read_valid");
    
    for (int i = 0; i < (int) readTimesAndValues.size(); i++) {
      int time = readTimesAndValues[i].first;
      string expectedVal = readTimesAndValues[i].second;

      map_insert(tb.actionsOnCycles, time, fifoName + "_read_valid <= 1'b1;");
      map_insert(tb.actionsOnCycles, time + 1, assertString(fifoName + "_data_bus === " + expectedVal));
      map_insert(tb.actionsOnCycles, time + 1, fifoName + "_read_valid <= 1'b0;");
    }    

  }  

  void
  checkRVFifo(TestBenchSpec& tb,
                 const std::string& fifoName,
                 const std::vector<std::pair<int, std::string> >& readTimesAndValues) {

    tb.settableWires.insert(fifoName + "_read_valid");
    
    for (int i = 0; i < (int) readTimesAndValues.size(); i++) {
      int time = readTimesAndValues[i].first;
      string expectedVal = readTimesAndValues[i].second;

      map_insert(tb.actionsInCycles, time, fifoName + "_read_valid = 1'b1;");
      map_insert(tb.actionsInCycles, time + 1, assertString(fifoName + "_out_data === " + expectedVal));
      map_insert(tb.actionsInCycles, time + 1, fifoName + "_read_valid = 1'b0;");
    }    

  }  
  
  void setRVChannel(TestBenchSpec& tb,
                    const std::string fifoName,
                    const vector<pair<int, int> >& writeTimesAndValues) {
    tb.settableWires.insert(fifoName + "_write_valid");
    tb.settableWires.insert(fifoName + "_in_data_bus");
    tb.settableWires.insert(fifoName + "_in_last_bus");
    
    for (int i = 0; i < (int) writeTimesAndValues.size(); i++) {
      int time = writeTimesAndValues[i].first;
      int val = writeTimesAndValues[i].second;

      map_insert(tb.actionsOnCycles, time, fifoName + "_write_valid <= 1'b1;");
      map_insert(tb.actionsOnCycles, time, fifoName + "_in_data_bus <= " + to_string(val) + ";");
      map_insert(tb.actionsOnCycles, time, fifoName + "_in_last_bus <= 0;");            
      map_insert(tb.actionsOnCycles, time + 1, fifoName + "_write_valid <= 1'b0;");
    }    
  }

  void setRVFifo(TestBenchSpec& tb,
                 const std::string fifoName,
                 const vector<pair<int, std::string> >& writeTimesAndValues) {
    tb.settableWires.insert(fifoName + "_write_valid");
    tb.settableWires.insert(fifoName + "_in_data");
    
    for (int i = 0; i < (int) writeTimesAndValues.size(); i++) {
      int time = writeTimesAndValues[i].first;
      string val = writeTimesAndValues[i].second;

      map_insert(tb.actionsOnCycles, time, fifoName + "_write_valid <= 1'b1;");
      map_insert(tb.actionsOnCycles, time, fifoName + "_in_data <= " + val + ";");
      map_insert(tb.actionsOnCycles, time + 1, fifoName + "_write_valid <= 1'b0;");
    }    
  }  

  void setRVFifo(TestBenchSpec& tb,
                 const std::string fifoName,
                 const vector<pair<int, int> >& writeTimesAndValues) {
    tb.settableWires.insert(fifoName + "_write_valid");
    tb.settableWires.insert(fifoName + "_in_data");
    
    for (int i = 0; i < (int) writeTimesAndValues.size(); i++) {
      int time = writeTimesAndValues[i].first;
      int val = writeTimesAndValues[i].second;

      map_insert(tb.actionsOnCycles, time, fifoName + "_write_valid <= 1'b1;");
      map_insert(tb.actionsOnCycles, time, fifoName + "_in_data <= " + to_string(val) + ";");
      map_insert(tb.actionsOnCycles, time + 1, fifoName + "_write_valid <= 1'b0;");
    }    
  }
  
  void setRAMContents(TestBenchSpec& tb,
                      int setMemCycle,
                      const std::string ramName,
                      const vector<int>& memoryValues) {
    tb.settableWires.insert(ramName + "_debug_write_en");
    tb.settableWires.insert(ramName + "_debug_write_addr");
    tb.settableWires.insert(ramName + "_debug_write_data");    
    
    for (int i = 0; i < (int) memoryValues.size(); i++) {
      int val = memoryValues[i];
      map_insert(tb.actionsOnCycles, setMemCycle, ramName + "_debug_write_addr <= " + to_string(i) + ";");
      map_insert(tb.actionsOnCycles, setMemCycle, ramName + "_debug_write_data <= " + to_string(val) + ";");
      map_insert(tb.actionsOnCycles, setMemCycle, ramName + "_debug_write_en <= " + to_string(1) + ";");      
      setMemCycle++;
    }

    map_insert(tb.actionsOnCycles, setMemCycle, ramName + "_debug_write_en <= " + to_string(0) + ";");
  }
  
  void checkRAMContents(TestBenchSpec& tb,
                        int checkMemCycle,
                        const std::string ramName,
                        const vector<int>& memoryExpected) {
    tb.settableWires.insert(ramName + "_debug_addr");
        
    for (int i = 0; i < (int) memoryExpected.size(); i++) {
      int val = memoryExpected[i];
      map_insert(tb.actionsOnCycles, checkMemCycle, ramName + "_debug_addr <= " + to_string(i) + ";");
      map_insert(tb.actionsOnCycles, checkMemCycle + 1, assertString(ramName + "_debug_data === " + to_string(val)));
      checkMemCycle++;
    }
  }
  
  void checkRAM(TestBenchSpec& tb,
                int checkMemCycle,
                const std::string name,
                std::map<string, vector<int> >& memoryExpected,
                std::map<string, int>& testLayout) {

    if (memoryExpected.size() == 0) {
      return;
    }

    tb.settableWires.insert(name + "_debug_addr");
        
    for (auto exp : memoryExpected) {
      int offset = map_find(exp.first, testLayout);
      for (int i = 0; i < (int) exp.second.size(); i++) {
        int val = exp.second[i];
        map_insert(tb.actionsInCycles, checkMemCycle, name + "_debug_addr = " + to_string(offset) + ";");
        map_insert(tb.actionsInCycles, checkMemCycle, assertString(name + "_debug_data === " + to_string(val)));
        offset++;
        checkMemCycle++;
      }
    }
  }

  void checkSignal(TestBenchSpec& tb,
                   const std::string& signalName,
                   const std::map<int, int>& valuesAtCycles) {
    for (auto cycleValPair : valuesAtCycles) {
      int cycle = cycleValPair.first;
      int expectedValue = cycleValPair.second;

      string cond = signalName + " === " + to_string(expectedValue);
      string errMsg = " on cycle " + to_string(cycle);
      map_insert(tb.actionsOnCycles, cycle, assertString(cond, errMsg));
    }
  }
  
}
