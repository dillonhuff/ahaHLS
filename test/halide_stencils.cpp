#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include "llvm_codegen.h"
#include "halide_arch.h"
#include "test_utils.h"

using namespace dbhc;

namespace ahaHLS {

  void
  checkValidChannel(MicroArchitecture& arch,
                    VerilogDebugInfo& info,
                    Value* targetChannel,
                    const std::string& validName,
                    const std::string& dataName,
                    const std::vector<std::string>& expectedWriteValues) {
    Instruction* channelWrite = nullptr;
    Instruction* channelValidCheck = nullptr;    

    for (auto instr : allInstrs(arch.stg.getFunction())) {
      if (isBuiltinPortWrite(instr)) {
        string portName = getPortName(instr);

        cout << "Checking port " << portName << " in instr " << valueString(instr) << endl;
        cout << tab(1) << "channel = " << valueString(instr->getOperand(0)) << endl;
        cout << tab(1) << "target  = " << valueString(targetChannel) << endl;        

        if ((portName == dataName) &&
            (instr->getOperand(0) == targetChannel)) {
          channelWrite = instr;
        }

        if ((portName == validName) &&
            (instr->getOperand(0) == targetChannel)) {
          channelValidCheck = instr;
        }
      }
    }
    
    assert(channelWrite != nullptr);
    assert(channelValidCheck != nullptr);    

    StateId writeValidCheckState = arch.stg.instructionStartState(channelValidCheck);
    StateId writeDataState = arch.stg.instructionStartState(channelWrite);

    assert(writeDataState == writeValidCheckState);

    Wire incrCond = blockActiveInState(writeValidCheckState, channelValidCheck->getParent(), arch);
    Wire ithValid = buildIncCounter(incrCond, 32, arch);
    for (int i = 0; i < (int) expectedWriteValues.size(); i++) {
      string expectedVal = expectedWriteValues[i];

      auto pos = position(writeValidCheckState, channelValidCheck, arch);
      string ev =
        andStr(parens(ithValid.valueString() + " === " + to_string(i)),
               incrCond.valueString());
      string writeIsExpectedVal =
        parens(outputName(channelWrite->getOperand(1), pos, arch) + " == " + expectedVal);
      addAssert(implies(ev, writeIsExpectedVal), info);
    }

  }  
  
  // TODO:
  //  Remove one-to-one fifos
  //  Use fifo definition that reads in same cycle that ready is high
  //  Do CFG simplification
  //  Do control signal simplification
  //  Get coreir backend running
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


    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    MicroArchitecture arch = halideArch(f, archSettings);
    
    {
      auto in = dyn_cast<Argument>(getArg(f, 0));
      auto out = dyn_cast<Argument>(getArg(f, 1));    

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.runCycles = 800;
      tb.maxCycles = 1000;
      tb.name = "vhls_target";
      tb.useModSpecs = true;
      tb.settablePort(in, "in_data");
      tb.settablePort(in, "write_valid");
      tb.settablePort(out, "read_valid");    

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

      tb.setArgPort(out, "read_valid", 0, "1'b0");
      tb.setArgPort(in, "write_valid", 0, "1'b0");
    
      tb.setArgPort(in, "in_data", 2, "16'd28");
      tb.setArgPort(in, "write_valid", 2, "1'b1");
      
      tb.setArgPort(in, "in_data", 3, "16'd10");
      tb.setArgPort(in, "write_valid", 3, "1'b1");

      tb.setArgPort(in, "in_data", 4, "16'd7");
      tb.setArgPort(in, "write_valid", 4, "1'b1");

      tb.setArgPort(in, "in_data", 5, "16'd3");
      tb.setArgPort(in, "write_valid", 5, "1'b1");    
      tb.setArgPort(in, "write_valid", 6, "1'b0");
      
      tb.setArgPort(in, "in_data", 7, "16'd9");
      tb.setArgPort(in, "write_valid", 7, "1'b1");
      tb.setArgPort(in, "write_valid", 8, "1'b0");

      int endCycle = 700;
      tb.setArgPort(out, "read_valid", endCycle + 2, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 3, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 3, assertString(string(out->getName()) + "_out_data === 16'd56"));

      tb.setArgPort(out, "read_valid", endCycle + 4, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 5, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 5, assertString(string(out->getName()) + "_out_data === 16'd20"));

      tb.setArgPort(out, "read_valid", endCycle + 6, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 7, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 7, assertString(string(out->getName()) + "_out_data === 16'd14"));

      tb.setArgPort(out, "read_valid", endCycle + 8, "1'b1");
      tb.setArgPort(out, "read_valid", endCycle + 9, "1'b0");
      map_insert(tb.actionsOnCycles, endCycle + 9, assertString(string(out->getName()) + "_out_data === 16'd6"));
    
      map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

      VerilogDebugInfo info;
      // addDisplay("1", "global state = %d", {"global_state"}, info);
      // addDisplay("1", "arg_0_read_ready = %d", {"arg_0_read_ready"}, info);
      // addDisplay("1", "arg_0_read_valid = %d", {"arg_0_read_valid"}, info);
      // addDisplay("1", "arg_0_out_data = %d", {"arg_0_out_data"}, info);
      // addDisplay("1", "arg_1_out_data = %d", {"arg_1_out_data"}, info);
      // addDisplay("1", "arg_1_write_ready = %d", {"arg_1_write_ready"}, info);      
      //printActiveBlocks(arch, info);
      addNoXChecks(arch, info);
      
      emitVerilog("vhls_target", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

      REQUIRE(runIVerilogTB("vhls_target"));      
    }
  }

  TEST_CASE("get element 0 1 from stencil") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "halide_stencil_get_01");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    cout << "Origin function" << endl;
    cout << valueString(f) << endl;

    HalideArchSettings archSettings;
    archSettings.loopTasks = false;
    MicroArchitecture arch = halideArch(f, archSettings);

    SECTION("Compiling as verilog") {
      auto in = dyn_cast<Argument>(getArg(f, 0));
      auto out = dyn_cast<Argument>(getArg(f, 1));    

      TestBenchSpec tb;
      map<string, int> testLayout = {};
      tb.memoryInit = {};
      tb.memoryExpected = {};
      tb.maxCycles = 100;
      tb.name = "halide_stencil_get_01";
      tb.useModSpecs = true;
      tb.settablePort(in, "in_data");
      tb.settablePort(in, "write_valid");
      tb.settablePort(out, "read_valid");

      tb.setArgPort(out, "read_valid", 0, "1'b0");
      tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
      vector<pair<int, string> > writeTimesAndValues{{10, "{16'd15, 16'd2}"}};
      setRVFifo(tb, "arg_0", writeTimesAndValues);

      vector<pair<int, string> > expectedValuesAndTimes{{30, "16'd15"}};
      checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));
      map_insert(tb.actionsOnCycles, 1, string("arg_0_write_valid <= 0;"));
      map_insert(tb.actionsOnCycles, 1, string("arg_1_read_valid <= 0;"));        

      VerilogDebugInfo info;
      addNoXChecks(arch, info);
    
      emitVerilog("halide_stencil_get_01", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);
    
      REQUIRE(runIVerilogTB("halide_stencil_get_01"));
    }

  }

  TEST_CASE("conv_2_1 manually optimized") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_manually_optimized");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    MicroArchitecture arch = halideArch(f, archSettings);

    auto in = dyn_cast<Argument>(getArg(f, 0));
    auto out = dyn_cast<Argument>(getArg(f, 1));

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 900;
    tb.maxCycles = 10000;
    tb.name = "conv_2_1_manually_optimized";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");
    tb.settablePort(out, "read_valid");

    tb.setArgPort(out, "read_valid", 0, "1'b0");
    tb.setArgPort(in, "write_valid", 0, "1'b0");
    
    vector<pair<int, int> > writeTimesAndValues;
    for (int i = 0; i < 8*8; i++) {
      writeTimesAndValues.push_back({2*i + 5, i});
    }
    setRVFifo(tb, "arg_0", writeTimesAndValues);

    vector<pair<int, string> > expectedValuesAndTimes;
    int offset = 300;
    for (int i = 0; i < 8*7; i++) {
      expectedValuesAndTimes.push_back({offset, to_string(i + (i + 8))});
      offset += 2;
    }
    checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
    map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

    //int endCycle = 20;
    //map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
    //addDisplay("1", "arg_1_read_ready = %d", {"arg_1_read_ready"}, info);
    
    emitVerilog("conv_2_1_manually_optimized", arch, info);
    emitVerilogTestBench(tb, arch, testLayout);

    
    REQUIRE(runIVerilogTB("conv_2_1_manually_optimized"));
    
  }
  
  // TODO:
  //  Add sliced stores
  TEST_CASE("conv_2_1 to verilog") {
  //   SMDiagnostic Err;
  //   LLVMContext Context;
  //   setGlobalLLVMContext(&Context);
    
  //   std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_source");
  //   setGlobalLLVMModule(Mod.get());

  //   Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
  //   deleteLLVMLifetimeCalls(f);

  //   HalideArchSettings archSettings;
  //   archSettings.loopTasks = true;
  //   archSettings.forToWhile = true;
  //   MicroArchitecture arch = halideArch(f, archSettings);

  //   auto in = dyn_cast<Argument>(getArg(f, 0));
  //   auto out = dyn_cast<Argument>(getArg(f, 1));    

  //   TestBenchSpec tb;
  //   map<string, int> testLayout = {};
  //   tb.memoryInit = {};
  //   tb.memoryExpected = {};
  //   tb.runCycles = 800;
  //   tb.maxCycles = 10000;
  //   tb.name = "conv_2_1";
  //   tb.useModSpecs = true;
  //   tb.settablePort(in, "in_data");
  //   tb.settablePort(in, "write_valid");
  //   tb.settablePort(out, "read_valid");

  //   tb.setArgPort(out, "read_valid", 0, "1'b0");
  //   tb.setArgPort(in, "write_valid", 0, "1'b0");        
    
  //   vector<pair<int, int> > writeTimesAndValues;
  //   for (int i = 0; i < 8*8; i++) {
  //     writeTimesAndValues.push_back({3*i + 5, i});
  //   }
  //   setRVFifo(tb, "arg_0", writeTimesAndValues);

  //   vector<pair<int, string> > expectedValuesAndTimes;
  //   int offset = 1000;
  //   for (int i = 0; i < 8*7; i++) {
  //     expectedValuesAndTimes.push_back({offset, to_string(i + (i + 8))});
  //     offset += 2;
  //   }
  //   checkRVFifo(tb, "arg_1", expectedValuesAndTimes);
    
  //   map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

  //   //int endCycle = 20;
  //   //map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

  //   VerilogDebugInfo info;
  //   addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
  //   addNoXChecks(arch, info);
    
  //   emitVerilog("conv_2_1", arch, info);
  //   emitVerilogTestBench(tb, arch, testLayout);

    
  //   REQUIRE(runIVerilogTB("conv_2_1"));
    
  }

  TEST_CASE("conv_2_1 push architecture to verilog") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "conv_2_1_source");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    deleteLLVMLifetimeCalls(f);

    HalideArchSettings archSettings;
    archSettings.loopTasks = true;
    archSettings.pushFifos = true;
    archSettings.forToWhile = true;
    archSettings.optimizeFifos = true;
    MicroArchitecture arch = halideArch(f, archSettings);

    auto in = dyn_cast<Argument>(getArg(arch.stg.getFunction(), 0));
    auto out = dyn_cast<Argument>(getArg(arch.stg.getFunction(), 1));    

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 800;
    tb.maxCycles = 145;
    tb.name = "conv_2_1_push";
    tb.useModSpecs = true;
    tb.settablePort(in, "in_data");
    tb.settablePort(in, "write_valid");

    tb.setArgPort(in, "write_valid", 0, "1'b0");


    vector<string> expectedValues;
    for (int i = 0; i < 8*7; i++) {
      expectedValues.push_back(to_string(i + (i + 8)));
    }
    VerilogDebugInfo info;
    checkValidChannel(arch, info, getArg(arch.stg.getFunction(), 1), "write_valid", "in_data", expectedValues);
    
    SECTION("Inputs at rate II == 2") {
      vector<pair<int, int> > writeTimesAndValues;
      int resetTime = 1;
      for (int i = resetTime; i < 8*8 + resetTime; i++) {
        writeTimesAndValues.push_back({2*i + 5, i - resetTime});
      }
      setRVFifo(tb, "arg_0", writeTimesAndValues);

      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 0;"));
    
      addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
      addNoXChecks(arch, info);
    
      emitVerilog("conv_2_1_push", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

    
      REQUIRE(runIVerilogTB("conv_2_1_push"));
    }

    SECTION("Inputs at rate II == 1") {
      vector<pair<int, int> > writeTimesAndValues;
      int resetTime = 1;
      for (int i = resetTime; i < 8*8 + resetTime; i++) {
        writeTimesAndValues.push_back({i + 5, i - resetTime});
      }
      setRVFifo(tb, "arg_0", writeTimesAndValues);
    
      map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 1;"));
      map_insert(tb.actionsOnCycles, 2, string("rst_reg <= 0;"));
    
      addDisplay("arg_1_write_valid", "accelerator writing %d to output", {"arg_1_in_data"}, info);
      addNoXChecks(arch, info);
    
      emitVerilog("conv_2_1_push", arch, info);
      emitVerilogTestBench(tb, arch, testLayout);

    
      REQUIRE(runIVerilogTB("conv_2_1_push"));
    }
    
  }
  
  // TEST_CASE("Stencil cascade") {
  //   SMDiagnostic Err;
  //   LLVMContext Context;
  //   setGlobalLLVMContext(&Context);
    
  //   std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "halide_cascade");
  //   setGlobalLLVMModule(Mod.get());

  //   Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
  //   deleteLLVMLifetimeCalls(f);

  //   MicroArchitecture arch = halideArch(f);

  //   auto in = dyn_cast<Argument>(getArg(f, 0));
  //   auto out = dyn_cast<Argument>(getArg(f, 1));    

  //   TestBenchSpec tb;
  //   map<string, int> testLayout = {};
  //   tb.memoryInit = {};
  //   tb.memoryExpected = {};
  //   tb.runCycles = 800;
  //   tb.maxCycles = 1000;
  //   tb.name = "vhls_target";
  //   tb.useModSpecs = true;
  //   tb.settablePort(in, "in_data");
  //   tb.settablePort(in, "write_valid");
  //   tb.settablePort(out, "read_valid");    

  //   map_insert(tb.actionsOnCycles, 1, string("rst_reg <= 0;"));

  //   int endCycle = 200;
  //   map_insert(tb.actionsOnCycles, endCycle, assertString("valid === 1"));

  //   VerilogDebugInfo info;
  //   // addDisplay("1", "global state = %d", {"global_state"}, info);
  //   // addDisplay("1", "arg_0_read_ready = %d", {"arg_0_read_ready"}, info);
  //   // addDisplay("1", "arg_0_read_valid = %d", {"arg_0_read_valid"}, info);
  //   // addDisplay("1", "arg_0_out_data = %d", {"arg_0_out_data"}, info);
  //   // addDisplay("1", "arg_1_out_data = %d", {"arg_1_out_data"}, info);
  //   // addDisplay("1", "arg_1_write_ready = %d", {"arg_1_write_ready"}, info);      
  //   //printActiveBlocks(arch, info);
  //   addNoXChecks(arch, info);
    
  //   emitVerilog("halide_cascade", arch, info);
  //   emitVerilogTestBench(tb, arch, testLayout);

    
  //   //REQUIRE(runIVerilogTB("halide_cascade"));      
    
  // }
}
