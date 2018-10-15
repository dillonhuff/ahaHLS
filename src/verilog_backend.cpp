#include "verilog_backend.h"

#include <fstream>
#include <llvm/IR/Constants.h>
#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

// Convolution as Toeplitz Matrix multiplication
namespace DHLS {

  std::string commaListString(const std::vector<std::string>& strings) {
    string res = "";
    for (int i = 0; i < (int) strings.size(); i++) {
      res += strings[i];
      if (i < strings.size() - 1) {
        res += ", ";
      }
    }
    return res;
  }

  int clog2(const int val) {
    return ceil(log2(val));
  }

  class FunctionalUnit {
  public:
    std::string modName;
    std::string instName;
    std::map<std::string, std::string> portWires;
    std::map<std::string, std::string> outWires;

    std::string onlyOutputVar() const {
      assert(outWires.size() == 1);

      return (*begin(outWires)).second;
    }
  };

  std::ostream& operator<<(std::ostream& out, const FunctionalUnit& unit) {
    out << unit.modName;
    out << " " << unit.instName << "(";
    vector<string> portStrs;
    for (auto pt : unit.portWires) {
      portStrs.push_back("." + pt.first + "(" + pt.second + ")");
    }

    for (auto pt : unit.outWires) {
      portStrs.push_back("." + pt.first + "(" + pt.second + ")");
    }

    out << commaListString(portStrs) << ")";

    return out;
  }

  class Port {
  public:
    bool isInput;
    int width;
    std::string name;

    std::string toString() {
      return string(isInput ? "input" : "output") + " [" + to_string(width - 1) + ":0] " + name;
    }
  };

  Port inputPort(const int width, const std::string& name) {
    return {true, width, name};
  }

  Port outputPort(const int width, const std::string& name) {
    return {false, width, name};
  }
  
  std::vector<Port> getPorts(const STG& stg) {
    vector<Port> pts = {inputPort(1, "clk"), inputPort(1, "rst"), outputPort(1, "valid")};
    int numReadPorts = 0;
    int numWritePorts = 0;

    for (auto state : stg.opStates) {
      int numReadsInState = 0;
      int numWritesInState = 0;
      for (auto gInstr : state.second) {
        Instruction* i = gInstr.instruction;

        if (StoreInst::classof(i)) {
          numWritesInState++;
        }

        if (LoadInst::classof(i)) {
          numReadsInState++;
        }

      }

      if (numReadsInState > numReadPorts) {
        numReadPorts = numReadsInState;
      }

      if (numWritesInState > numWritePorts) {
        numWritePorts = numWritesInState;
      }
    }


    // TODO: Accomodate different width reads / writes
    int width = 32;    
    for (int i = 0; i < numReadPorts; i++) {
      pts.push_back(inputPort(width, "rdata_" + to_string(i)));
      pts.push_back(outputPort(clog2(width), "raddr_" + to_string(i)));
    }

    for (int i = 0; i < numWritePorts; i++) {
      pts.push_back(outputPort(width, "wdata_" + to_string(i)));
      pts.push_back(outputPort(clog2(width), "waddr_" + to_string(i)));
      pts.push_back(outputPort(1, "wen_" + to_string(i)));
    }

    return pts;
  }

  std::map<Instruction*, FunctionalUnit> assignFunctionalUnits(const STG& stg) {
    std::map<Instruction*, FunctionalUnit> units;

    // For now create a different unit for every single operation
    int resSuffix = 0;
    for (auto state : stg.opStates) {
      for (auto instrG : state.second) {
        Instruction* instr = instrG.instruction;

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        if (state.first == schedVars.front()) {
          string unitName = string(instr->getOpcodeName()) + "_" +
            to_string(resSuffix);

          string modName = "add";

          map<string, string> wiring;
          map<string, string> outWires;
          
          if (StoreInst::classof(instr)) {
            modName = "store";
          } else if (LoadInst::classof(instr)) {
            modName = "load";

            wiring = {{"raddr", "raddr_0"}};
            outWires = {{"out", "rdata_0"}};

          } else if (BinaryOperator::classof(instr)) {
            assert(instr->getOpcode() == Instruction::Add);
            modName = "add";
            wiring = {{"in0", "add_in0"}, {"in1", "add_in1"}};
            outWires = {{"out", "add_out"}};
          } else if (ReturnInst::classof(instr)) {
            modName = "ret";
          } else {
            assert(false);
          }


          units[instr] = {modName, unitName, wiring, outWires};

          resSuffix++;
        }
      }
    }
    
    return units;
  }

  map<Instruction*, string> createInstrNames(const STG& stg) {
    map<Instruction*, string> resultNames;    

    int resSuffix = 0;
    for (auto state : stg.opStates) {
      for (auto instrG : state.second) {
        Instruction* instr = instrG.instruction;

        if (StoreInst::classof(instr) || ReturnInst::classof(instr)) {
          continue;
        }

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        if (state.first == schedVars.front()) {
          resultNames[instr] = string(instr->getOpcodeName()) + "_" + to_string(resSuffix);
          resSuffix++;
        }
      }
    }

    return resultNames;
  }

  // Im a little confused on what the next steps in getting this generated
  // verilog right are.

  // Q: What are the smallest concrete steps I could take?
  // A: Actually print out assignments to an addition for the add functional unit
  //    Print out storage to temporaries, but that is not actually needed for
  //    any of my applications since the stores are being done in the same state
  
  // What are the components of this verilog?
  // module declaration
  // numbers of read and write ports,
  // state transition logic
  // input trigger logic
  // storage trigger logic
  // functional units (including memories)
  void emitVerilog(llvm::Function* f, const STG& stg) {

    // For each state ID:
    //   set functional unit inputs

    string fn = f->getName();

    vector<Port> allPorts = getPorts(stg);

    vector<string> portStrings;
    for (auto pt : allPorts) {
      portStrings.push_back(pt.toString());
    }

    ofstream out(fn + ".v");
    out << "module " << fn << "(" + commaListString(portStrings) + ");" << endl;

    out << endl;

    for (auto pt : allPorts) {
      if (!pt.isInput) {
        out << "\treg [" << to_string(pt.width - 1) << ":0] " << pt.name << "_reg;" << endl;
      }
    }

    out << endl;

    for (auto pt : allPorts) {
      if (!pt.isInput) {
        out << "\tassign " << pt.name << " = " << pt.name << "_reg;" << endl;
      }
    }

    map<Instruction*, FunctionalUnit> unitAssignment =
      assignFunctionalUnits(stg);

    // The issue of how to create builtins also comes up here. Should I have
    // parametric modules I can use for each one?
    // A: I dont need parameters yet, so lets delay that. For now just output
    //    32 bit functional units
    out << endl << "\t// Start Functional Units" << endl;
    for (auto iUnit : unitAssignment) {
      auto unit = iUnit.second;

      // These are external functional units
      if ((unit.modName == "load") ||
          (unit.modName == "store") ||
          (unit.modName == "ret")) {
        continue;
      }

      vector<string> wireDecls;
      for (auto w : unit.portWires) {
        out << "\treg [31:0] " << w.second << ";" << endl;
        wireDecls.push_back("." + w.first + "(" + w.second + ")");
      }

      for (auto w : unit.outWires) {
        out << "\twire [31:0] " << w.second << ";" << endl;
        wireDecls.push_back("." + w.first + "(" + w.second + ")");
      }
      
      out << "\t" << unit.modName << " " << unit.instName << "(" << commaListString(wireDecls) << ");" << endl << endl;
    }
    out << "\t// End Functional Units" << endl;

    // Note: Result names also need widths if we are going to use them
    map<Instruction*, std::string> names = createInstrNames(stg);

    out << endl;
    out << "\treg [31:0] global_state;" << endl << endl;

    out << "\talways @(posedge clk) begin" << endl;
    //out << "\t\t$display(\"global_state = %d\", global_state);" << endl;
    //out << "\t\t$display(\"valid        = %d\", valid);" << endl;    

    // Insert state transition logic
    out << "\t\tif (rst) begin" << endl;
    out << "\t\t\tglobal_state <= 0;" << endl;
    out << "\t\t\tvalid_reg <= 0;" << endl;
    out << "\t\tend else begin" << endl;
      
    for (auto state : stg.opTransitions) {
      assert(state.second.size() == 1);
      out << "\t\t\tif (global_state == " + to_string(state.first) + ") begin" << endl;
      out << "\t\t\t\tglobal_state <= " + to_string(state.second.at(0).dest) + + ";" << endl;
      out << "\t\t\tend" << endl;
    }
      
    out << "\t\tend" << endl;
    out << "\tend" << endl;
    // Insert functional units

    out << endl << endl;

    out << "\talways @(*) begin" << endl;

    for (auto state : stg.opStates) {
      out << "\t\tif (global_state == " + to_string(state.first) + ") begin" << endl;
      for (auto instrG : state.second) {
        Instruction* instr = instrG.instruction;

        auto schedVars = map_find(instr, stg.sched.instrTimes);
        if (state.first == schedVars.front()) {
          // Now the issue is how do I change each write port value?
          // I guess conceptually we have a big mux with the state going in
          // to the select and then a bunch of logic saying what to do?
          // So maybe this block should be always @(*) ? Update any time a signal
          // changes?

          if (ReturnInst::classof(instr)) {
            out << "\t\t\tvalid_reg = 1;" << endl;
          } else if (StoreInst::classof(instr)) {
            out << "\t\t\twaddr_0_reg = 0;" << endl;
            out << "\t\t\twdata_0_reg = 5;" << endl;
            out << "\t\t\twen_0_reg = 1;" << endl;
          } else if (LoadInst::classof(instr)) {

            out << "\t\t\traddr_0_reg = 0;" << endl;
            
          } else if (BinaryOperator::classof(instr)) {
            //auto opcode = instr->getOpcode();

            auto arg0 = instr->getOperand(0);
            assert(Instruction::classof(arg0));

            auto arg1 = instr->getOperand(1);
            assert(Instruction::classof(arg0));

            // if (opcode == Instruction::Add) {
            //   cout << "Scheduling add" << endl;

            auto addUnit = map_find(instr, unitAssignment);
            auto unit0Src =
              map_find(dyn_cast<Instruction>(arg0), unitAssignment);
            assert(unit0Src.outWires.size() == 1);

            //cout << "Found unit 0 = " << unit0Src << endl;
            auto unit1Src =
              map_find(dyn_cast<Instruction>(arg1), unitAssignment);
            assert(unit1Src.outWires.size() == 1);

            //cout << "Found unit 1 = " << unit1Src << endl;
              
            out << "\t\t\t" << addUnit.portWires["in0"] << " = " << unit0Src.onlyOutputVar() << ";" << endl;
            out << "\t\t\t" << addUnit.portWires["in1"] << " = " << unit1Src.onlyOutputVar() << ";" << endl;

            // } else {
            //   assert(false);
            // }
          } else {

            std::string str;
            llvm::raw_string_ostream ss(str);
            ss << *(instr);

            cout << "Error: Scheduling unknown instruction " << ss.str() << std::endl;            
            assert(false);

          }
        }
        
      }
      //out << "\t\t\tglobal_state <= " + to_string(state.second.at(0).dest) + + ";" << endl;
      out << "\t\tend" << endl;
    }

    out << "\tend" << endl;

    // Insert unit control for each state

    out << "endmodule" << endl;

    out.close();
  }

}
