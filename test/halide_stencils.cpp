#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  TEST_CASE("Rewrite stencils as int computation") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "vhls_target");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    cout << "Got function" << endl;
  }
  
}
