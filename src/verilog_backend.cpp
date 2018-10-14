#include "verilog_backend.h"

#include <fstream>
#include <llvm/IR/Instructions.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace DHLS {

  int clog2(const int val) {
    return ceil(log2(val));
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
            out << "\t\t\tvalid_reg <= 1;" << endl;
          } else if (StoreInst::classof(instr)) {
            out << "\t\t\twaddr_0_reg <= 0;" << endl;
            out << "\t\t\twdata_0_reg <= 5;" << endl;
            out << "\t\t\twen_0_reg <= 1;" << endl;
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
