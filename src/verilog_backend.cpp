#include "verilog_backend.h"

#include <fstream>

using namespace llvm;
using namespace std;

namespace DHLS {

  class Port {
  public:
    bool isInput;
    int width;
    std::string name;
  };

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

    vector<string> portStrings = {"input clk", "input rst"};
    ofstream out(fn + ".v");
    out << "module " << fn << "(" + commaListString(portStrings) + ");" << endl;
    out << "endmodule" << endl;

    out.close();
  }

}
