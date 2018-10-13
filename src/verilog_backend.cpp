#include "verilog_backend.h"

#include <fstream>

using namespace llvm;
using namespace std;

namespace DHLS {

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
    ofstream out(fn + ".v");
    out << "module " << fn << "();" << endl;
    out << "endmodule" << endl;

    out.close();
  }

}
