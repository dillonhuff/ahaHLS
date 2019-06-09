#ifdef COREIR_BACKEND

#include "catch.hpp"

#include "coreir_backend.h"
#include "llvm_codegen.h"
#include "halide_arch.h"
#include "test_utils.h"

#include "coreir/simulator/interpreter.h"

// What?

using namespace CoreIR;
using namespace dbhc;
using namespace llvm;
using namespace std;

namespace ahaHLS {

  // TODO: Lower the microarchitecture so that registers are converted
  // in to functional units with port controllers, then emit
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

    Context* c = newContext();
    emitCoreIR("single_store", arch, c, c->getGlobal());

    CoreIR::Module* storeMod = c->getGlobal()->getModule("single_store");

    REQUIRE(storeMod != nullptr);


    cout << "Module is " << endl;
    storeMod->print();    

    c->runPasses({"rungenerators", "flatten", "flattentypes", "wireclocks-coreir", "fold-constants", "removeconstduplicates", "deletedeadinstances"});

    cout << "After preprocessing module is " << endl;
    storeMod->print();    
    

    SimulatorState sim(storeMod);
    sim.setValue("self.rst", BitVec(1, 0));

    sim.setClock("self.clk", 0, 1);
    sim.execute();

    sim.setValue("self.rst", BitVec(1, 1));

    sim.execute();

    sim.setValue("self.rst", BitVec(1, 0));

    cout << "a_wdata_0 = " << sim.getBitVec("self.a_wdata_0") << endl;

    REQUIRE(sim.getBitVec("self.valid") == BitVec(1, 0));    
    REQUIRE(sim.getBitVec("self.a_wdata_0") == BitVec(32, 5));
    REQUIRE(sim.getBitVec("self.a_wen_0") == BitVec(1, 1));            
    
    sim.execute();

    REQUIRE(sim.getBitVec("self.valid") == BitVec(1, 0));

    REQUIRE(sim.getBitVec("self.a_wen_0") == BitVec(1, 0));

    cout << "a_wdata_0 = " << sim.getBitVec("self.a_wdata_0") << endl;

    sim.execute();

    REQUIRE(sim.getBitVec("self.valid") == BitVec(1, 0));        

    cout << "a_wdata_0 = " << sim.getBitVec("self.a_wdata_0") << endl;        
    sim.execute();

    REQUIRE(sim.getBitVec("self.valid") == BitVec(1, 1));            

    sim.execute();
    sim.execute();
    sim.execute();        

    REQUIRE(sim.getBitVec("self.valid") == BitVec(1, 1));

    deleteContext(c);
  }

  TEST_CASE("Get stencil element 0 1") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<llvm::Module> Mod = loadCppModule(Context, Err, "halide_stencil_get_01");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    cout << "Origin function" << endl;
    cout << valueString(f) << endl;

    HalideArchSettings archSettings;
    archSettings.loopTasks = false;
    MicroArchitecture arch = halideArch(f, archSettings);

    CoreIR::Context* c = newContext();
    emitCoreIR("vhls_target", arch, c, c->getGlobal());

    CoreIR::Module* storeMod = c->getGlobal()->getModule("vhls_target");

    REQUIRE(storeMod != nullptr);


    cout << "Module is " << endl;
    storeMod->print();    

    c->runPasses({"rungenerators", "flatten", "flattentypes", "wireclocks-coreir", "fold-constants", "removeconstduplicates", "deletedeadinstances"});

    cout << "After preprocessing module is " << endl;
    storeMod->print();    

    SimulatorState sim(storeMod);
    sim.setValue("self.rst", BitVec(1, 0));
    sim.setValue("self.arg_0_read_ready", BitVec(1, 1));
    sim.setValue("self.arg_0_out_data", BitVec(32, 23 << 16));
    sim.setValue("self.arg_1_write_ready", BitVec(1, 1));

    sim.setClock("self.clk", 0, 1);

    sim.execute();

    cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    sim.setValue("self.rst", BitVec(1, 1));

    sim.execute();

    // Done reset

    cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;
    
    sim.setValue("self.rst", BitVec(1, 0));

    sim.execute();    

    cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    sim.execute();

    cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    REQUIRE(sim.getBitVec("self.arg_1_in_data") == BitVec(16, 23));

    deleteContext(c);
  }

  TEST_CASE("conv 2x1 with no fifos") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<llvm::Module> Mod = loadCppModule(Context, Err, "conv_2_1_manually_optimized");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    cout << "Origin function" << endl;
    cout << valueString(f) << endl;

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    MicroArchitecture arch = halideArch(f, archSettings);

    // CoreIR::Context* c = newContext();
    // emitCoreIR("conv_2_1_manual_coreir", arch, c, c->getGlobal());

    // CoreIR::Module* storeMod = c->getGlobal()->getModule("conv_2_1_manual_coreir");

    // REQUIRE(storeMod != nullptr);


    // cout << "Module is " << endl;
    // storeMod->print();    

    // c->runPasses({"rungenerators", "flatten", "flattentypes", "wireclocks-coreir", "fold-constants", "removeconstduplicates", "deletedeadinstances"});

    // cout << "After preprocessing module is " << endl;
    // storeMod->print();    

    // SimulatorState sim(storeMod);
    // sim.setValue("self.rst", BitVec(1, 0));
    // sim.setValue("self.arg_0_read_ready", BitVec(1, 1));
    // sim.setValue("self.arg_0_out_data", BitVec(32, (23 << 16) | (9)));
    // sim.setValue("self.arg_1_write_ready", BitVec(1, 1));

    // sim.setClock("self.clk", 0, 1);

    // sim.execute();

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    // sim.setValue("self.rst", BitVec(1, 1));

    // sim.execute();

    // // Done reset

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;
    
    // sim.setValue("self.rst", BitVec(1, 0));

    // sim.execute();    

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    // sim.execute();

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    // REQUIRE(sim.getBitVec("self.arg_1_in_data") == BitVec(16, 23 + 9));

    // deleteContext(c);
  }

  TEST_CASE("conv 2x1 from halide") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<llvm::Module> Mod =
      loadCppModule(Context, Err, "conv_2_1_source");
    setGlobalLLVMModule(Mod.get());

    llvm::Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    archSettings.pushFifos = true;
    archSettings.forToWhile = true;
    archSettings.optimizeFifos = true;
    archSettings.predicateFifoWrites = true;
    archSettings.removeLoopBounds = true;        
    MicroArchitecture arch = halideArch(f, archSettings);

    CoreIR::Context* c = newContext();
    emitCoreIR("conv_2_1_push_coreir", arch, c, c->getGlobal());

    CoreIR::Module* storeMod = c->getGlobal()->getModule("conv_2_1_push_coreir");

    REQUIRE(storeMod != nullptr);


    cout << "Module is " << endl;
    storeMod->print();    

    c->runPasses({"rungenerators", "flatten", "flattentypes", "wireclocks-coreir", "fold-constants", "removeconstduplicates", "deletedeadinstances"});

    cout << "After preprocessing module is " << endl;
    storeMod->print();    

    SimulatorState sim(storeMod);
    sim.setValue("self.rst", BitVec(1, 0));

    sim.setValue("self.arg_0_out_data", BitVec(16, 3));
    sim.setValue("self.arg_0_read_valid", BitVec(1, 1));
    
    sim.setClock("self.clk", 0, 1);

    sim.execute();

    cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    sim.setValue("self.rst", BitVec(1, 1));

    sim.execute();

    sim.setValue("self.rst", BitVec(1, 0));

    sim.execute();
    
    for (int i = 0; i < 30; i++) {
      cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;
      cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
      sim.execute();
    }
    // Done reset

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;
    
    // sim.setValue("self.rst", BitVec(1, 0));

    // sim.execute();    

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    // sim.execute();

    // cout << "arg_1_write_valid = " << sim.getBitVec("self.arg_1_write_valid") << endl;
    // cout << "arg_1_in_data = " << sim.getBitVec("self.arg_1_in_data") << endl;

    // REQUIRE(sim.getBitVec("self.arg_1_in_data") == BitVec(16, 23 + 9));

    deleteContext(c);
    
  }
  
}

#endif
