#ifdef COREIR_BACKEND

#include "catch.hpp"

#include "microarchitecture.h"
#include "coreir_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/Transforms/Utils/BasicBlockUtils.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  TEST_CASE("Single store to CoreIR") {
    SMDiagnostic err;
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "single_store");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "single_store");
    getArg(f, 0)->setName("a");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout = {};
    auto arch = buildMicroArchitecture(graph, layout, hcs);
    
  }
  
}

#endif
