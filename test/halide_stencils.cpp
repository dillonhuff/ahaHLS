#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  Type* halideType(Type* tp) {
    if (PointerType::classof(tp)) {
      return tp;
    } else {
      return tp;
    }
  }

  Function* rewriteHalideStencils(Function* orig) {
    vector<Type*> inputTypes;
    for (int i = 0; i < orig->arg_size(); i++) {
      Type* rwTp = halideType(getArg(orig, i)->getType());
      inputTypes.push_back(rwTp);
    }
    Function* f = mkFunc(inputTypes, string(orig->getName()) + "_rewritten", &(getGlobalLLVMModule()));
    return f;
  }

  TEST_CASE("Rewrite stencils as int computation") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "vhls_target");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);
    
    cout << "Origin function" << endl;
    cout << valueString(f) << endl;

    Function* rewritten =
      rewriteHalideStencils(f);

    cout << "Rewritten function" << endl;
    cout << valueString(rewritten) << endl;
    
  }
  
}
