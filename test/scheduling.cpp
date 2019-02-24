#define CATCH_CONFIG_MAIN

#include "catch.hpp"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include <llvm/Transforms/Utils/BasicBlockUtils.h>

using namespace dbhc;
using namespace llvm;
using namespace std;

namespace DHLS {


  // TODO: Replace with a real parser
  std::string extractFunctionName(const std::string& name) {
    string funcName = "";
    int i = 0;
    while (i < (int) name.size()) {
      if (name[i] == '(') {
        break;
      }
      funcName += name[i];
      i++;
    }
    return funcName;
  }
  
  llvm::Function*
  getFunctionByDemangledName(llvm::Module* mod, const std::string& name) {
    for (auto& f : mod->functions()) {
      if (canDemangle(f.getName())) {
        cout << demangle(f.getName()) << endl;
        if (extractFunctionName(demangle(f.getName())) == name) {
          return &f;
        }
      }
    }

    assert(false);
  }

  std::string demangledClassName(const std::string& demangledName) {
    cout << "Getting class from = " << demangledName << endl;
    string nextNamespace = takeUntil("::", demangledName);
    cout << "namespace = " << nextNamespace << endl;
    string remainder = drop("::", demangledName);
    cout << "remainder = " << remainder << endl;

    string funcDecl = drop("::", remainder);
    string funcName = takeUntil("(", funcDecl);
    cout << "FuncName = " << funcName << endl;
    assert(false);
  }

  ModuleSpec ramSpec(const int width, const int depth, const int numReadPorts, const int numWritePorts) {

    int addrWidth = clog2(depth);

    map<string, Port> ramPorts = {
      {"rst", inputPort(1, "rst")}
    };

    for (int i = 0; i < numReadPorts; i++) {
      auto iStr = to_string(i);
      ramPorts["raddr_" + iStr] = inputPort(addrWidth, "raddr_" + iStr);
      ramPorts["rdata_" + iStr] = outputPort(width, "rdata_" + iStr);
    }

    for (int i = 0; i < numWritePorts; i++) {
      auto iStr = to_string(i);
      ramPorts["waddr_" + iStr] = inputPort(addrWidth, "waddr_" + iStr);
      ramPorts["wdata_" + iStr] = inputPort(width, "wdata_" + iStr);
      ramPorts["wen_" + iStr] = inputPort(1, "wen_" + iStr);      
    }

    ramPorts["debug_addr"] = inputPort(addrWidth, "debug_addr");
    ramPorts["debug_data"] = outputPort(width, "debug_data");

    ramPorts["debug_write_addr"] = inputPort(addrWidth, "debug_write_addr");
    ramPorts["debug_write_en"] = inputPort(1, "debug_write_en");
    ramPorts["debug_write_data"] = inputPort(width, "debug_write_data");    

    string name = "RAM";
    assert(numWritePorts == 1);
    if (numReadPorts > 1) {
      name += to_string(numReadPorts);
    }
    return {{{"WIDTH", to_string(width)}, {"DEPTH", to_string(depth)}}, name, ramPorts};
  }
  
  ModuleSpec ramSpec(const int width, const int depth) {
    return ramSpec(width, depth, 1, 1);
  }


  void implementRAMRead0(Function* ramRead0, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramRead0, 1));
    int width = getTypeBitWidth(ramRead0->getReturnType());
    auto sramTp = getArg(ramRead0, 0)->getType();

    auto waddr0F = writePort("raddr_0", addrWidth, sramTp);
    auto rdata0F = readPort("rdata_0", width, sramTp);

    auto sram = getArg(ramRead0, 0);
    auto addr = getArg(ramRead0, 1);

    auto bb = mkBB("entry_block", ramRead0);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto readData = eb.CreateCall(rdata0F, {sram});
    eb.CreateRet(readData);

    exec.add(instrStart(setAddr) + 1 == instrStart(readData));

    addDataConstraints(ramRead0, exec);
    
    cout << "-- # of constraints on read function = " << exec.constraints.size() << endl;
    for (auto c : exec.constraints) {
      cout << tab(1) << *c << endl;
    }

  }

  void implementRAMRead1(Function* ramRead1, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramRead1, 1));
    int width = getTypeBitWidth(ramRead1->getReturnType());
    auto sramTp = getArg(ramRead1, 0)->getType();

    auto waddr0F = writePort("raddr_1", addrWidth, sramTp);
    auto rdata0F = readPort("rdata_1", width, sramTp);

    auto sram = getArg(ramRead1, 0);
    auto addr = getArg(ramRead1, 1);

    auto bb = mkBB("entry_block", ramRead1);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto readData = eb.CreateCall(rdata0F, {sram});
    eb.CreateRet(readData);

    exec.add(instrStart(setAddr) + 1 == instrStart(readData));

    addDataConstraints(ramRead1, exec);
  }

  void implementRAMRead2(Function* ramRead1, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramRead1, 1));
    int width = getTypeBitWidth(ramRead1->getReturnType());
    auto sramTp = getArg(ramRead1, 0)->getType();

    auto waddr0F = writePort("raddr_2", addrWidth, sramTp);
    auto rdata0F = readPort("rdata_2", width, sramTp);

    auto sram = getArg(ramRead1, 0);
    auto addr = getArg(ramRead1, 1);

    auto bb = mkBB("entry_block", ramRead1);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto readData = eb.CreateCall(rdata0F, {sram});
    eb.CreateRet(readData);

    exec.add(instrStart(setAddr) + 1 == instrStart(readData));

    addDataConstraints(ramRead1, exec);
  }
  
  void implementRAMWrite0(Function* ramWrite0, ExecutionConstraints& exec) {
    int addrWidth = getValueBitWidth(getArg(ramWrite0, 1));
    int width = getValueBitWidth(getArg(ramWrite0, 2));
    auto sramTp = ramWrite0->getReturnType();

    //ExecutionConstraints& exec = interfaces.getConstraints(ramWrite0);
    auto waddr0F = writePort("waddr_0", addrWidth, sramTp);
    auto wdata0F = writePort("wdata_0", width, sramTp);
    auto wen0F = writePort("wen_0", 1, sramTp);

    auto sram = getArg(ramWrite0, 0);
    auto addr = getArg(ramWrite0, 1);
    auto data = getArg(ramWrite0, 2);

    auto bb = mkBB("entry_block", ramWrite0);
    IRBuilder<> eb(bb);
    auto setAddr = eb.CreateCall(waddr0F, {sram, addr});
    auto setData = eb.CreateCall(wdata0F, {sram, data});
    auto setEn1 = eb.CreateCall(wen0F, {sram, mkInt(1, 1)});
    // auto setEn0 = eb.CreateCall(wen0F, {sram, mkInt(0, 1)});
    auto ret = eb.CreateRet(nullptr);

    exec.add(instrStart(setAddr) == instrStart(setData));
    exec.add(instrStart(setAddr) == instrStart(setEn1));

    //exec.add(instrEnd(setEn1) + 1 == instrStart(setEn0));

    // TODO: Replace start(ret) with end(inlineMarker)?
    exec.add(instrStart(setAddr) + 3 == instrStart(ret));

    addDataConstraints(ramWrite0, exec);

    // cout << "-- Constraints on write function" << endl;
    // for (auto c : exec.constraints) {
    //   cout << tab(1) << *c << endl;
    // }
  }

  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces,
                             std::set<BasicBlock*>& toPipeline) {
    ExecutionConstraints exec;

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    addDataConstraints(f, exec);
    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    return s;
  }

  Schedule scheduleInterface(llvm::Function* f,
                             HardwareConstraints& hcs,
                             InterfaceFunctions& interfaces) {
    set<BasicBlock*> toPipeline;
    return scheduleInterface(f, hcs, interfaces, toPipeline);
  }
  
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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    return arch;
  }

  ModuleSpec ramSpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 1, 1);
  }

  ModuleSpec ram2SpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 2, 1);
  }

  ModuleSpec ram3SpecFunc(llvm::StructType* tp) {
    auto elems = tp->elements();
    assert(elems.size() == 1);

    Type* internalArray = elems[0];
    assert(ArrayType::classof(internalArray));

    ArrayType* arrTp = dyn_cast<ArrayType>(internalArray);
    return ramSpec(getTypeBitWidth(arrTp->getElementType()), arrTp->getNumElements(), 3, 1);
  }
  
  // Q: System TODOs:
  // A: Remove useless address fields from registers (allow custom memory interfaces)
  //    Move test layout into testbenchspec
  //    Incorporate fifoSpecs in to scheduling constraints automatically instead of
  //      of setting them in HardwareConstraints?
  //    Add some simple examples to the README
  //    Convert ptr to builtin codes to RAM templates
  //    Shrink registers to reduce area costs
  //    Remove modspecs
  //    Remove internal RAM code
  //    Rework the AXI examples

  // NOTE: The code for testbenches is getting really complicated. Some of that
  // is automatic testbench generation, but some of it is just the hodgepodge of
  // different data structures for scheduling, verilog code generation, and
  // constraint generation. These really need to be fixed up.
  // Ideas?
  //  1. Merge schedule and STG creation in to one function when the schedule
  //     does not need to be checked
  //  2. Remove or wrap the function -> SchedulingConstraints map

  // Q: What test cases do I need?
  // A: Test case that merges basic blocks that execute different numbers of times
  //    Test case with outer loop pipelining
  //    Test case that pipelines inner loop surrounded by outer loop
  //    Test case using a ready-valid interface together with pipelining
  //    Test case that builds a linebuffer from LLVM
  //    Test case with struct (compound type) passed via channel (or used by value)
  //    Test case with many instances of a template class
  TEST_CASE("Schedule a single store operation") {
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
    
    REQUIRE(s.numStates() == 4);

    auto& retInstr = f->getBasicBlockList().back().back();
    REQUIRE(s.startTime(&retInstr) == 3);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 4);

    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    emitVerilog("single_store", f, arch, info);
    //emitVerilog(f, graph, layout);

    REQUIRE(runIVerilogTB("single_store"));
  }

  TEST_CASE("Adding two numbers and storing them back") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "plus");
    setGlobalLLVMModule(Mod.get());
    
    Function* f = getFunctionByDemangledName(Mod.get(), "plus");
    getArg(f, 0)->setName("mem");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;    
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    
    Schedule s = scheduleInterface(f, hcs, interfaces);

    REQUIRE(s.numStates() == 5);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.numControlStates() == 5);

    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    emitVerilog("plus", f, arch, info);
    
    REQUIRE(runIVerilogTB("plus"));
  }

  TEST_CASE("A simple if") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "if_else");
    setGlobalLLVMModule(Mod.get());
    
    Function* f = getFunctionByDemangledName(Mod.get(), "if_else");
    getArg(f, 0)->setName("mem");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    emitVerilog("if_else", f, arch, info);
    
    REQUIRE(runIVerilogTB("if_else"));
  }

  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs,
                   VerilogDebugInfo& info) {
    auto f = graph.getFunction();
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    //addNoXChecks(arch, info);
    emitVerilog(name, f, arch, info);
  }

  void emitVerilog(const std::string& name,
                   STG& graph,
                   HardwareConstraints& hcs) {
    VerilogDebugInfo info;
    emitVerilog(name, graph, hcs, info);
  }
  
  TEST_CASE("Accessing a memory address that requires address calculation") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "read_2"); // Cpp
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "read_2");
    getArg(f, 0)->setName("mem");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("read_2", graph, hcs);
    
    REQUIRE(runIVerilogTB("read_2"));
    
  }

  TEST_CASE("Histogram of image colors") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "histogram");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "histogram");
    getArg(f, 0)->setName("ram");
    
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

    // emitVerilog("histogram", graph, hcs);

    // REQUIRE(runIVerilogTB("histogram"));
  }

  TEST_CASE("Looping over an array doing a[i] + 7") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    //std::unique_ptr<Module> Mod = loadModule(Context, Err, "loop_add_7");
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_7");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_7");
    getArg(f, 0)->setName("ram");
    
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

    emitVerilog("loop_add_7", graph, hcs);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Adding numbers with resource limits") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "many_adds");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "many_adds");
    getArg(f, 0)->setName("ram");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("read_2")] = implementRAMRead2;        
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;

    // Limits number of adders
    hcs.setCount(ADD_OP, 1);

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    for (auto st : graph.opStates) {
      map<OperationType, int> opCounts;
      for (auto instrG : st.second) {
        Instruction* instr = instrG.instruction;
        OperationType tp = opType(instr);
        if (contains_key(tp, opCounts)) {
          opCounts[tp] = opCounts[tp] + 1;
        } else {
          opCounts[tp] = 1;
        }
      }

      for (auto op : opCounts) {
        REQUIRE(op.second <= hcs.getCount(op.first));
      }
    }

    emitVerilog("many_adds", graph, hcs);
    
    REQUIRE(runIVerilogTB("many_adds"));
  }

  TEST_CASE("Greater than") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "cmp_gt");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "cmp_gt");
    getArg(f, 0)->setName("ram");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("read_2")] = implementRAMRead2;        
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(!graph.hasTransition(1, 1));

    emitVerilog("cmp_gt", graph, hcs);

    REQUIRE(runIVerilogTB("cmp_gt"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 7") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_7");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_7");
    getArg(f, 0)->setName("ram");

    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              // Now need to compute two things:
              //   1. The internal schedule that will be used within iterations
              //      of the loop
              //   2. The initiation interval

              // To incorporate this into real code we will also need
              // a way to express which blocks are pipelined to the whole
              // system scheduler. This scheduler will then have to isolate
              // those blocks from the rest of the system

              blocksToPipeline.insert(&bb);

            }
          }
        }
      }
    }

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    emitVerilog("loop_add_7", graph, hcs);

    REQUIRE(runIVerilogTB("loop_add_7"));
  }

  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations small enough to never fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_4");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4");
    getArg(f, 0)->setName("ram");

    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              blocksToPipeline.insert(&bb);
            }
          }
        }
      }
    }

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    

    Schedule s = scheduleInterface(f, hcs, interfaces, blocksToPipeline);

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);
    
    VerilogDebugInfo info;

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    emitVerilog("loop_add_4", graph, hcs, info);

    REQUIRE(runIVerilogTB("loop_add_4"));
  }

  // Issue: How do we express the need to set defaults on ports? We need to be
  // able to express that the wen == 0 at the end of a RAM write is only a default
  // value and should not be considered essential
  TEST_CASE("Pipelining an array doing a[i] + 4, and exiting the pipeline in the TB, with a number of iterations large enough to fill the pipeline") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "loop_add_4_6_iters");
    setGlobalLLVMModule(Mod.get());

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;    
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4_6_iters");
    getArg(f, 0)->setName("ram");

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);

    
    std::set<BasicBlock*> blocksToPipeline;
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();
      if (BranchInst::classof(term)) {
        BranchInst* branch = dyn_cast<BranchInst>(term);
        if (branch->isConditional()) {
          for (auto succ : branch->successors()) {
            if (succ == &bb) {
              cout << "Found looped basic block" << endl;
              blocksToPipeline.insert(&bb);
            }
          }
        }
      }
    }

    // Pipelined
    ExecutionConstraints exec;

    addDataConstraints(f, exec);
    inlineWireCalls(f, exec, interfaces);

    SchedulingProblem p = createSchedulingProblem(f, hcs, blocksToPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline, constraints);
    // Pipelined

    REQUIRE(s.numStates() == 7);
    REQUIRE(map_find(*begin(blocksToPipeline), s.pipelineSchedules) == 1);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].depth() == 5);
    REQUIRE(graph.pipelines[0].II() == 1);

    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    emitVerilog("loop_add_4_6_iters", f, arch, info);

    REQUIRE(runIVerilogTB("loop_add_4_6_iters"));
  }
  
  TEST_CASE("Using temporary memory") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);

    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "loop_add_4_copy");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "loop_add_4_copy");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");

    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead0;  
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    // Arch debug
    VerilogDebugInfo info;
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});

    emitVerilog("loop_add_4_copy", graph, hcs, info);
    
    // runCmd("cat loop_add_4_copy.v");
    // runCmd("cat RAM2.v");
    // runCmd("cat loop_add_4_copy_tb.v");

    REQUIRE(runIVerilogTB("loop_add_4_copy"));
  }

  TestBenchSpec buildTB(std::string name,
                        map<string, vector<int> >& memoryInit,
                        map<string, vector<int> >& memoryExpected,
                        map<string, int>& testLayout) {
    TestBenchSpec tb;
    tb.useModSpecs = true;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 200;
    tb.name = name; //"blur_no_lb";

    tb.settableWires.insert("ram_debug_addr");
    tb.settableWires.insert("ram_debug_write_addr");
    tb.settableWires.insert("ram_debug_write_data");
    tb.settableWires.insert("ram_debug_write_en");

    int startSetMemCycle = 1;
    for (auto exp : memoryInit) {
      int offset = map_find(exp.first, testLayout);
      for (int i = 0; i < (int) exp.second.size(); i++) {
        int val = exp.second[i];

        map_insert(tb.actionsOnCycles, startSetMemCycle, "ram_debug_write_addr <= " + to_string(offset) + ";");
        map_insert(tb.actionsOnCycles, startSetMemCycle, "ram_debug_write_data <= " + to_string(val) + ";");
        map_insert(tb.actionsOnCycles, startSetMemCycle, string("ram_debug_write_en <= 1;"));

        offset++;
        startSetMemCycle++;
      }
    }

    map_insert(tb.actionsOnCycles, startSetMemCycle, string("ram_debug_write_en <= 0;"));

    int startRunCycle = startSetMemCycle + 10; 
    map_insert(tb.actionsInCycles, startRunCycle, string("rst_reg = 1;"));
    map_insert(tb.actionsInCycles, startRunCycle + 1, string("rst_reg = 0;"));

    int checkMemCycle = 150;
    for (auto exp : memoryExpected) {
      int offset = map_find(exp.first, testLayout);
      for (int i = 0; i < (int) exp.second.size(); i++) {
        int val = exp.second[i];
        map_insert(tb.actionsInCycles, checkMemCycle, "ram_debug_addr = " + to_string(offset) + ";");
        map_insert(tb.actionsInCycles, checkMemCycle, assertString("ram_debug_data === " + to_string(val)));
        offset++;
        checkMemCycle++;
      }
    }

    return tb;
  }

  TEST_CASE("Blur without linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod =
      loadCppModule(Context, Err, "blur_no_lb");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "blur_no_lb");
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("read_2")] = implementRAMRead2;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);

    VerilogDebugInfo info;
    emitVerilog("blur_no_lb", graph, hcs);
    
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}}; //, {getArg(f, 1), 8}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<string, vector<int> > memoryInit{{"a", {0, 1, 2, 3, 7, 5, 5, 2}}};
    map<string, vector<int> > memoryExpected{{"b", {}}};

    auto ma = map_find(string("a"), memoryInit);
    for (int i = 1; i < 8 - 1; i++) {
      map_insert(memoryExpected, string("b"), (ma[i - 1] + ma[i] + ma[i + 1]));
    }

    cout << "Expected values" << endl;
    for (auto val : map_find(string("b"), memoryExpected)) {
      cout << "\t" << val << endl;
    }

    TestBenchSpec tb = buildTB("blur_no_lb", memoryInit, memoryExpected, testLayout);
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("blur_no_lb"));
  }

  TEST_CASE("Blur with linebuffering") {

    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "blur_lb");
    setGlobalLLVMModule(Mod.get());

    // HardwareConstraints hcs;
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);
    // HardwareConstraints hcs = standardConstraints();

    Function* f = getFunctionByDemangledName(Mod.get(), "blur_lb"); //Mod->getFunction("blur_lb");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    Schedule s = scheduleInterface(f, hcs, interfaces);

    // Schedule s = scheduleInter
    //Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 8}};
    map<llvm::Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);
    //auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);

    noStoredValuesXWhenUsed(arch, info);

    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.wiresToWatch.push_back({false, 32, "wdata_temp_reg_dbg"});

    info.debugAssigns.push_back({"global_state_dbg", "global_state"});

    info.debugWires.push_back({true, 32, "num_clocks_after_reset"});

    addAlwaysBlock({"clk"}, "if (rst) begin num_clocks_after_reset <= 0; end else begin num_clocks_after_reset <= num_clocks_after_reset + 1; end", info);

    //emitVerilog(f, arch, info);
    emitVerilog("blur_lb", graph, hcs); //, arch, info);

    // Testbench specification

    map<string, int> testLayout = {{"a", 0}, {"b", 8}};
    map<string, vector<int> > memoryInit{{"a", {0, 1, 2, 3, 7, 5, 5, 2}}};
    map<string, vector<int> > memoryExpected{{"b", {}}};

    auto ma = map_find(string("a"), memoryInit);
    for (int i = 1; i < 8 - 1; i++) {
      map_insert(memoryExpected, string("b"), (ma[i - 1] + ma[i] + ma[i + 1]));
    }

    TestBenchSpec tb = buildTB("blur_lb", memoryInit, memoryExpected, testLayout);
    tb.useModSpecs = true;

    // TestBenchSpec tb;
    // tb.memoryInit = memoryInit;
    // tb.memoryExpected = memoryExpected;
    // tb.runCycles = 40;
    // tb.name = "blur_lb";
    
    // cout << "Expected values" << endl;
    // for (auto val : map_find(string("b"), memoryExpected)) {
    //   cout << "\t" << val << endl;
    // }

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("blur_lb"));
  }

  TEST_CASE("Matrix vector multiply") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "mvmul");
    setGlobalLLVMModule(Mod.get());

    // HardwareConstraints hcs;
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);
    // hcs.setLatency(MUL_OP, 0);

    // Function* f = Mod->getFunction("mvmul");
    // assert(f != nullptr);
    
    // Schedule s = scheduleFunction(f, hcs);

    Function* f = getFunctionByDemangledName(Mod.get(), "mvmul");
    assert(f != nullptr);
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read_0")] = implementRAMRead0;
    interfaces.functionTemplates[string("read_1")] = implementRAMRead1;
    interfaces.functionTemplates[string("read_2")] = implementRAMRead2;
    interfaces.functionTemplates[string("write_0")] = implementRAMWrite0;
    
    // interfaces.functionTemplates[string("read")] = implementRAMRead0;
    // interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;
    hcs.typeSpecs["class.RAM_3"] = ram3SpecFunc;    

    Schedule s = scheduleInterface(f, hcs, interfaces);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("mvmul", graph, hcs);

    // 3 x 3
    map<string, int> testLayout = {{"a", 0}, {"b", 9}, {"c", 12}};
    map<llvm::Value*, int> layout; // = //{{getArg(f, 0), 0}, {getArg(f, 1), 9}, {getArg(f, 2), 12}};
      //auto arch = buildMicroArchitecture(f, graph, layout);

      //map<llvm::Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    //emitVerilog(f, arch, info);

    map<string, vector<int> > memoryInit{{"a", {6, 1, 2, 3, 7, 5, 5, 2, 9}},
        {"b", {9, 3, 7}}};
    map<string, vector<int> > memoryExpected{{"c", {}}};

    auto ma = map_find(string("a"), memoryInit);
    auto mb = map_find(string("b"), memoryInit);
    for (int i = 0; i < 3; i++) {
      int val = 0;
      for (int j = 0; j < 3; j++) {
        val += ma[i*3 + j] * mb[j];
      }
      map_insert(memoryExpected, string("c"), val);
    }

    cout << "Expected values" << endl;
    for (auto val : map_find(string("c"), memoryExpected)) {
      cout << "\t" << val << endl;
    }
    
    TestBenchSpec tb = buildTB("mvmul", memoryInit, memoryExpected, testLayout);
    tb.useModSpecs = true;
    // TestBenchSpec tb;
    // tb.memoryInit = memoryInit;
    // tb.memoryExpected = memoryExpected;
    // tb.runCycles = 100;
    // tb.name = "mvmul";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mvmul"));
  }

  TEST_CASE("Single store with stall") {
    
    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod = loadModule(Context, Err, "stalled_single_store");

    Function* f = Mod->getFunction("stalled_single_store");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    hcs.setCount(ADD_OP, 1);
    
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}};
    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    ArchOptions options;
    options.globalStall = true;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("stalled_single_store"));
  }

  TEST_CASE("AXI based memory transfer") {

    SMDiagnostic Err;
    LLVMContext Context;
    std::unique_ptr<Module> Mod =
      loadModule(Context, Err, "stalled_single_store_axi");

    Function* f = Mod->getFunction("stalled_single_store_axi");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);

    hcs.setCount(ADD_OP, 1);
    
    //map<string, int> layout = {{"a", 0}, {"b", 1}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}};

    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    ArchOptions options;
    options.globalStall = true;
    options.setMemInterface(MEM_INTERFACE_AXI4_LITE);

    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("stalled_single_store_axi"));
    
    // SMDiagnostic Err;
    // LLVMContext Context;
    // std::unique_ptr<Module> Mod =
    //   loadModule(Context, Err, "stalled_single_store_axi");

    // Function* f = Mod->getFunction("stalled_single_store_axi");

    // HardwareConstraints hcs;
    // hcs.setLatency(STORE_OP, 3);
    // hcs.setLatency(LOAD_OP, 1);
    // hcs.setLatency(CMP_OP, 0);
    // hcs.setLatency(BR_OP, 0);
    // hcs.setLatency(ADD_OP, 0);

    // hcs.setCount(ADD_OP, 1);
    
    // //map<string, int> layout = {{"a", 0}, {"b", 1}};
    // map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 1}};

    // Schedule s = scheduleFunction(f, hcs);
    // STG graph = buildSTG(s, f);

    // cout << "STG Is" << endl;
    // graph.print(cout);

    // ArchOptions options;
    // options.globalStall = true;
    // options.setMemInterface(MEM_INTERFACE_AXI4_LITE);

    // auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    // VerilogDebugInfo info;
    // noAddsTakeXInputs(arch, info);
    // noMulsTakeXInputs(arch, info);
    // noPhiOutputsXWhenUsed(arch, info);
    // noStoredValuesXWhenUsed(arch, info);

    // emitVerilog(f, arch, info);

    // REQUIRE(runIVerilogTB("stalled_single_store_axi"));
  }

  // Random Thought: Test if an access pattern maps onto a cache type
  // by checking whether the recurrence that describes the loop pattern
  // is equivalent to the recurrence that describes the cache access pattern
  TEST_CASE("Schedule 1D Halide App (Brighter)") {
    SMDiagnostic Err;
    LLVMContext Context;
    //std::unique_ptr<Module> Mod = loadModule(Context, Err, "brighter");
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "brighter");

    HardwareConstraints hcs;
    hcs.setLatency(STORE_OP, 3);
    hcs.setLatency(LOAD_OP, 1);
    hcs.setLatency(CMP_OP, 0);
    hcs.setLatency(BR_OP, 0);
    hcs.setLatency(ADD_OP, 0);
    hcs.setLatency(SUB_OP, 0);    
    hcs.setLatency(MUL_OP, 0);
    hcs.setLatency(SEXT_OP, 0);

    Function* f = Mod->getFunction("brighter");
    assert(f != nullptr);
    
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    bool noDuplicates = true;
    for (auto st : graph.opStates) {
      std::set<Instruction*> alreadyDone;
      for (auto instrG : st.second) {
        auto instr = instrG.instruction;
        if (elem(instr, alreadyDone)) {
          cout << "Duplicate instruction " << instructionString(instr)
               << " in state " << st.first << endl;
          noDuplicates = false;
        } else {
          alreadyDone.insert(instr);
        }
      }
    }

    REQUIRE(noDuplicates);

    // 3 x 3
    map<string, int> testLayout = {{"input", 0}, {"input1", 10}, {"brighter", 20}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 10}, {getArg(f, 2), 20}};    

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    noAddsTakeXInputs(arch, info);
    noMulsTakeXInputs(arch, info);
    noPhiOutputsXWhenUsed(arch, info);
    noLoadedValuesXWhenUsed(arch, info);
    noLoadAddressesXWhenUsed(arch, info);    
    noStoredValuesXWhenUsed(arch, info);

    emitVerilog(f, arch, info);

    map<string, vector<int> > memoryInit{{"input", {6, 1, 2, 3, 7, 5, 5, 2, 9, 3}},
        {"input1", {129, 34, 13, 5, 5, 9, 51, 49, 46, 95}}};
    map<string, vector<int> > memoryExpected{{"brighter", {}}};

    auto input = map_find(string("input"), memoryInit);
    auto input0 = map_find(string("input1"), memoryInit);
    for (int i = 0; i < 10; i++) {
      int res = input[i] + input0[i];
      map_insert(memoryExpected, string("brighter"), res);
    }


    cout << "Expected values" << endl;
    for (auto val : map_find(string("brighter"), memoryExpected)) {
      cout << "\t" << val << endl;
    }

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 60;
    tb.name = "brighter";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("brighter"));
    
  }

  TEST_CASE("Building a simple function directly in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("shift register test", context);

    std::vector<Type *> inputs{Type::getInt32Ty(context)->getPointerTo(),
        Type::getInt32Ty(context)->getPointerTo()};
    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "using_shift_register", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* zero = mkInt("0", 32);
    ConstantInt* five = mkInt("5", 32);        
    IRBuilder<> builder(entryBlock);
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);
    auto plus = builder.CreateAdd(ldA, five);
    storeVal(builder, getArg(srUser, 1), zero, plus);
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 1}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 1}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {11}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "using_shift_register";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("using_shift_register"));
  }

  // Next test case: Need to do a stenciled loop where I fill
  // and then use a shift register for the loop computation
  TEST_CASE("Building a simple loop in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM accumulate loop", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "accum_loop", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto ldA = builder.CreateLoad(dyn_cast<Value>(srUser->arg_begin()));

    builder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto sumPhi = loopBuilder.CreatePHI(intType(32), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);
    auto nextSum = loopBuilder.CreateAdd(sumPhi, ldA);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(zero, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    sumPhi->addIncoming(zero, entryBlock);
    sumPhi->addIncoming(nextSum, loopBlock);
    
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateStore(nextSum, dyn_cast<Value>(srUser->arg_begin() + 1));
    exitBuilder.CreateRet(nullptr);

    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 15}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*5}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "accum_loop";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("accum_loop"));
  }

  TEST_CASE("1D stencil without shift register in LLVM") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("simple LLVM 1D stencil", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "one_d_stencil", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);
    auto loopBlock = mkBB("loop_block", srUser);
    auto exitBlock = mkBB("exit_block", srUser);        

    ConstantInt* loopBound = mkInt("6", 32);
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    builder.CreateBr(loopBlock);

    IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(intType(32), 2);

    auto indPhiP1 = loopBuilder.CreateAdd(indPhi, one);
    auto indPhiM1 = loopBuilder.CreateSub(indPhi, one);

    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, loopBound);

    indPhi->addIncoming(one, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);

    auto ai = loadVal(loopBuilder, getArg(srUser, 0), indPhi);
    auto aip1 = loadVal(loopBuilder, getArg(srUser, 0), indPhiP1);
    auto aim1 = loadVal(loopBuilder, getArg(srUser, 0), indPhiM1);
    
    auto inputSum = loopBuilder.CreateAdd(aim1, loopBuilder.CreateAdd(ai, aip1), "stencil_accum");

    storeVal(loopBuilder,
             getArg(srUser, 1),
             loopBuilder.CreateSub(indPhi, one),
             inputSum);

    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    auto arch = buildMicroArchitecture(srUser, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 5, 1, 2, 9, 8, 4}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6 + 5 + 1, 5 + 1 + 2, 1 + 2 + 9, 2 + 9 + 8, 9 + 8 + 4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.name = "one_d_stencil";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("one_d_stencil"));
  }

  TEST_CASE("LLVM program that uses a register") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("program that uses a register", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "one_register", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);

    ConstantInt* zero = mkInt("0", 32);    

    IRBuilder<> builder(entryBlock);
    auto reg = builder.CreateAlloca(intType(32), nullptr, "dhsreg");
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);

    auto gpr = builder.CreateGEP(reg, zero);

    builder.CreateStore(ldA, gpr);
    
    auto v = builder.CreateLoad(gpr);
    storeVal(builder, getArg(srUser, 1), zero, v);
    builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(srUser);
    //setAllAllocaMemTypes(hcs, srUser, registerSpec(32));

    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6}}};

    TestBenchSpec tb;
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};    
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.name = "one_register";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("one_register"));
  }
  
  class ShiftRegister {
  public:
    int width;
    int depth;

    std::vector<llvm::Value*> registers;
    std::map<llvm::Value*, MemorySpec> regTypes;

    ShiftRegister(const int w, const int d) : width(w), depth(d) {}

    void init(IRBuilder<>& builder) {
      for (int i = 0; i < depth; i++) {
        auto reg = builder.CreateAlloca(intType(width), nullptr, "sr_" + to_string(i));
        registers.push_back(reg);
        regTypes[reg] = registerSpec(width);
      }

      assert(((int) registers.size()) == depth);
    }

    void shift(IRBuilder<>& builder) {
      for (int i = 0; i < depth - 1; i++) {
        auto ldVal = loadVal(builder,registers[i + 1], mkInt("0", 32));
        storeVal(builder, registers[i], mkInt("0", 32), ldVal);
      }
    }

  };

  TEST_CASE("Shifting a value through a shift register") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    cout << "1d stencil via shift register" << endl;
    
    auto mod =
      llvm::make_unique<Module>("shift registered LLVM 1D stencil", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* srUser = mkFunc(inputs, "shift_register_1", mod.get());

    auto entryBlock = mkBB("entry_block", srUser);

    ConstantInt* zero = mkInt("0", 32);    

    IRBuilder<> builder(entryBlock);

    ShiftRegister sr(32, 3);
    auto inVal = loadVal(builder, getArg(srUser, 0), zero);
    sr.init(builder);

    for (int i = 0; i < sr.depth; i++) {
      sr.shift(builder);
      storeVal(builder, sr.registers[sr.depth - 1], zero, inVal);
    }

    auto lastVal = loadVal(builder, sr.registers[0], zero);
    storeVal(builder,
             getArg(srUser, 1),
             zero,
             lastVal);

    builder.CreateRet(nullptr);
    
    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    HardwareConstraints hcs = standardConstraints();
    addMemInfo(hcs, sr.regTypes);
    hcs.memoryMapping = memoryOpLocations(srUser);
    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    //map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 10}};

    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {19}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {19}}};
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 10}};
    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.name = "shift_register_1";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("shift_register_1"));
  }

  TEST_CASE("Scheduling a basic block diamond") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("BB diamond", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);
    auto tBlock = mkBB("true_block", f);    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    

    IRBuilder<> builder(entryBlock);
    auto condVal = loadVal(builder, getArg(f, 0), zero);
    builder.CreateCondBr(condVal, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    fBuilder.CreateBr(exitBlock);

    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateBr(exitBlock);


    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(32), 2);
    valPhi->addIncoming(one, tBlock);
    valPhi->addIncoming(zero, fBlock);

    storeVal(exitBuilder,
             getArg(f, 1),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    SECTION("Taking true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond"));
    }

    SECTION("Taking false path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {0}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond"));
    }

  }

  TEST_CASE("Scheduling a basic block diamond with sub-diamond") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("BB diamond 2", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond_2", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);

    auto ffBlock = mkBB("false_false_block", f);
    auto ftBlock = mkBB("false_true_block", f);        
    auto tBlock = mkBB("true_block", f);    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", 32);    
    ConstantInt* one = mkInt("1", 32);    
    ConstantInt* two = mkInt("2", 32);    

    IRBuilder<> builder(entryBlock);
    auto condVal = loadVal(builder, getArg(f, 0), zero);
    builder.CreateCondBr(condVal, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    auto cond1Val = loadVal(fBuilder, getArg(f, 1), zero);
    fBuilder.CreateCondBr(cond1Val, ftBlock, ffBlock);

    IRBuilder<> ffBuilder(ffBlock);
    ffBuilder.CreateBr(exitBlock);

    IRBuilder<> ftBuilder(ftBlock);
    ftBuilder.CreateBr(exitBlock);
    
    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateBr(exitBlock);


    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(32), 3);
    valPhi->addIncoming(one, tBlock);
    valPhi->addIncoming(zero, ffBlock);
    valPhi->addIncoming(two, ftBlock);
    
    storeVal(exitBuilder,
             getArg(f, 2),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}, {"arg_2", 15}};

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    SECTION("Taking false, true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}, {"arg_1", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_2", {2}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_2";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_2"));
    }

    SECTION("Taking false path") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}, {"arg_1", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_2", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_2";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_2"));
    }

  }

  TEST_CASE("Using 16 bit external memory instead of 32 bit external memory") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("16 bit mem test", context);

    std::vector<Type *> inputs{Type::getInt16Ty(context)->getPointerTo(),
        Type::getInt16Ty(context)->getPointerTo()};
    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "mem_16_test", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

    int ramWidth = 16;
    int ramDepth = 8;
    
    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* zero = mkInt("0", ramWidth);
    ConstantInt* five = mkInt("5", ramWidth);

    cout << "five bit width = " << getValueBitWidth(five) << endl;

    REQUIRE(getValueBitWidth(five) == ramWidth);
    
    IRBuilder<> builder(entryBlock);
    auto ldA = loadVal(builder, getArg(srUser, 0), zero);
    auto plus = builder.CreateAdd(ldA, five);
    storeVal(builder, getArg(srUser, 1), zero, plus);
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    setMemSpec(getArg(srUser, 0), hcs, ramSpec(1, 3, 2, 1, ramWidth, ramDepth));
    setMemSpec(getArg(srUser, 1), hcs, ramSpec(1, 3, 2, 1, ramWidth, ramDepth));

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    Schedule s = scheduleFunction(srUser, hcs);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    // 3 x 3
    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 1}};
    map<llvm::Value*, int> layout = {{getArg(srUser, 0), 0}, {getArg(srUser, 1), 1}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(srUser, arch, info);

    map<string, vector<int> > memoryInit{{"arg_0", {(1 << 16) - 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 10;
    tb.name = "mem_16_test";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_16_test"));
  }

  TEST_CASE("Pipeline with resource constraints") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with resource constraints", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "constrained_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto z = builder.CreateMul(v, v);
      auto r = builder.CreateMul(z, v);
      storeVal(builder, getArg(f, 1), i, r);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*6*6, 4*4*4, 5*5*5, 2*2*2, 1*1*1}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "constrained_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("constrained_pipe"));
  }

  TEST_CASE("Pipeline that needs temporary storage") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with temp storage", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "temp_storage_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    auto bodyF = [f](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto three = mkInt("3", 32);
      auto seven = mkInt("7", 32);      

      auto z = builder.CreateMul(v, three);
      auto r = builder.CreateMul(v, seven);
      auto c = builder.CreateAdd(z, r);
      storeVal(builder, getArg(f, 1), i, c);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);

    REQUIRE(s.pipelineSchedules.size() == 1);
    REQUIRE(begin(s.pipelineSchedules)->second == 2);
    
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*3 + 6*7, 4*3 + 4*7, 5*3 + 5*7, 2*3 + 2*7, 1*3 + 1*7}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "temp_storage_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("temp_storage_pipe"));
  }

  TEST_CASE("Reading a stored value from outside a pipeline inside a pipeline") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with external read", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "outer_read_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* zero = mkInt("0", 32);

    IRBuilder<> entryBuilder(entryBlock);    
    auto q = loadVal(entryBuilder, getArg(f, 0), zero);
    auto bodyF = [f, q](IRBuilder<>& builder, Value* i) {
      auto v = loadVal(builder, getArg(f, 0), i);
      auto three = mkInt("3", 32);
      auto seven = mkInt("7", 32);      

      auto z = builder.CreateMul(v, three);
      auto r = builder.CreateMul(v, seven);
      auto c = builder.CreateAdd(z, r);
      auto final = builder.CreateAdd(c, q);
      storeVal(builder, getArg(f, 1), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, loopBound, bodyF);

    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}, {"arg_1", 15}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 15}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_1", {6*3 + 6*7 + 6, 4*3 + 4*7 + 6, 5*3 + 5*7 + 6, 2*3 + 2*7 + 6, 1*3 + 1*7 + 6}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "outer_read_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("outer_read_pipe"));
  }

  TEST_CASE("Loop pipeline II increased by memory dependence") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with memory dependence", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);        

    ConstantInt* loopBound = mkInt("5", 32);
    ConstantInt* one = mkInt("1", 32);

    IRBuilder<> entryBuilder(entryBlock);    
    auto bodyF = [f, one](IRBuilder<>& builder, Value* i) {
      auto ind = builder.CreateSub(i, one);
      
      auto v = loadVal(builder, getArg(f, 0), ind);
      auto final = builder.CreateAdd(v, one);

      storeVal(builder, getArg(f, 0), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, one, loopBound, bodyF);

    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"arg_0", 0}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 6 + 1, 6 + 2, 6 + 3, 6 + 4}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 30;
    tb.maxCycles = 42;
    tb.name = "mem_dep_pipe";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe"));
  }

  TEST_CASE("Loop pipeline II == 1 with long memory dependence") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("pipeline with long memory dependence", context);

    std::vector<Type *> inputs{intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "mem_dep_pipe_long", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* loopBound = mkInt("10", 32);
    ConstantInt* one = mkInt("1", 32);
    ConstantInt* three = mkInt("3", 32);
    IRBuilder<> entryBuilder(entryBlock);    
    auto bodyF = [f, one, three](IRBuilder<>& builder, Value* i) {
      auto ind = builder.CreateSub(i, three);
      
      auto v = loadVal(builder, getArg(f, 0), ind);
      auto final = builder.CreateAdd(v, one);

      storeVal(builder, getArg(f, 0), i, final);
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, three, loopBound, bodyF);

    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(MUL_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    blocksToPipeline.insert(loopBlock);    
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.pipelines.size() == 1);
    REQUIRE(graph.pipelines[0].II() == 2);
    
    map<string, int> testLayout = {{"arg_0", 0}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"arg_0", {6, 4, 5, 2, 1, 8, 0, 2, 9, 6}}};
    map<string, vector<int> > memoryExpected{{"arg_0", {6, 4, 5, 6 + 1, 4 + 1, 5 + 1, 7 + 1, 5 + 1, 5 + 2, 7 + 2}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 20;
    tb.maxCycles = 43;
    tb.name = "mem_dep_pipe_long";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("mem_dep_pipe_long"));
  }

  TEST_CASE("1 x 2 systolic array") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    auto mod = llvm::make_unique<Module>("1 x 2 systolic array", context);

    int width = 32;
    std::vector<Type *> inputs{intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo(),
        intType(32)->getPointerTo()};
    Function* f = mkFunc(inputs, "sys_array_1_2", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    IRBuilder<> entryBuilder(entryBlock);

    auto aRow0 = getArg(f, 0);

    auto bCol0 = getArg(f, 1);
    auto bCol1 = getArg(f, 2);

    auto cRow0 = getArg(f, 3);

    vector<Value*> rightRegisters;
    for (int i = 0; i < 1; i++) {
      auto reg =
        entryBuilder.CreateAlloca(intType(width), nullptr, "right_" + to_string(i));
      storeReg(entryBuilder, reg, mkInt(0, 32));
      rightRegisters.push_back(reg);
    }

    vector<Value*> accumRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        entryBuilder.CreateAlloca(intType(width), nullptr, "accum_" + to_string(i));
      storeReg(entryBuilder, reg, mkInt(0, 32));
      accumRegisters.push_back(reg);
    }

    for (int i = 0; i < 3; i++) {
      cout << "i = " << i << endl;

      auto ind = mkInt(i, 32);

      auto iStr = to_string(i);
      auto aRow0V = loadVal(entryBuilder, aRow0, ind, "aRow0_" + iStr);
      auto left0 = loadVal(entryBuilder, rightRegisters[0], mkInt(0, 32), "left0_" + iStr);
      auto bCol0V = loadVal(entryBuilder, bCol0, ind, "bCol0_" + iStr);
      auto bCol1V = loadVal(entryBuilder, bCol1, ind, "bCol1_" + iStr);

      cout << "Storing computed values" << endl;
      
      // Store to new down / left registers
      auto newAccum0 =
        entryBuilder.CreateAdd(loadReg(entryBuilder, accumRegisters[0]),
                               entryBuilder.CreateMul(aRow0V, bCol0V));

      auto newAccum1 =
        entryBuilder.CreateAdd(loadReg(entryBuilder, accumRegisters[1]),
                               entryBuilder.CreateMul(left0, bCol1V));

      cout << "Storing regs" << endl;

      storeReg(entryBuilder, accumRegisters[0], newAccum0);
      storeReg(entryBuilder, accumRegisters[1], newAccum1);

      // Transfer left to right
      storeReg(entryBuilder, rightRegisters[0], aRow0V);

    }

    // Store out final results
    storeVal(entryBuilder, cRow0, mkInt(0, 32), loadReg(entryBuilder, accumRegisters[0]));
    storeVal(entryBuilder, cRow0, mkInt(1, 32), loadReg(entryBuilder, accumRegisters[1]));

    entryBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);

    setAllAllocaMemTypes(hcs, f, registerSpec(32));

    hcs.setCount(MUL_OP, 2);

    Schedule s = scheduleFunction(f, hcs);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    // TODO: Build layout and test layout from one data structure so they must
    // match
    // TODO: Pass hardware constraints through the whole flow
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0},
                                     {getArg(f, 1), 3},
                                     {getArg(f, 2), 6},
                                     {getArg(f, 3), 10}};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, int> testLayout =
      {{"aRow0", 0}, {"bCol0", 3}, {"bCol1", 6}, {"cRow0", 10}};
    map<string, vector<int> > memoryInit{{"aRow0", {1, 2, 0}}, {"bCol0", {4, 6, 0}}, {"bCol1", {0, 5, 7}}};
    map<string, vector<int> > memoryExpected{{"cRow0", {16, 19}}};
    
    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 20;
    tb.maxCycles = 41;
    tb.name = "sys_array_1_2";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("sys_array_1_2"));
  }

  ModuleSpec fifoSpec32(StructType* tp) {
    return fifoSpec(32, 16);
  }

  TEST_CASE("Builtin FIFO as argument to function") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use", context);
    setGlobalLLVMModule(mod.get());
    
    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    InterfaceFunctions interfaces;
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    vector<Type*> writeArgs = {tp->getPointerTo(), intType(32)};
    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_user", mod.get());
    auto blk = mkBB("entry_block", f);
    
    IRBuilder<> builder(blk);
    auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
    auto writeVal = builder.CreateCall(writeFifo, {val, getArg(f, 1)});
    builder.CreateRet(nullptr);

    ExecutionConstraints exec;
    exec.addConstraint(instrEnd(val) < instrStart(writeVal));
    
    inlineWireCalls(f, exec, interfaces);

    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_user"));
  }

  TEST_CASE("Delay between reading from FIFO and using the result") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);
    cout << "type name = " << typeString(tp) << endl;

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_read_delay", mod.get());
    auto blk = mkBB("entry_block", f);
    
    IRBuilder<> builder(blk);
    auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
    auto p0 = builder.CreateAdd(mkInt(2, width), val);
    auto prod = builder.CreateAdd(p0, val);
    builder.CreateCall(writeFifo, {prod, getArg(f, 1)});
    builder.CreateRet(nullptr);

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };
    
    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    
    STG graph = buildSTG(s, f);

    cout << "STG is " << endl;
    graph.print(cout);
    
    map<llvm::Value*, int> layout = {};
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_read_delay"));
  }

  TEST_CASE("2 x 2 systolic array with FIFOs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use with a delay", context);
    setGlobalLLVMModule(mod.get());

    InterfaceFunctions interfaces;
    StructType* tp = fifoType(width);
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    cout << "Read fifo func" << endl;
    cout << valueString(readFifo) << endl;

    Function* writeFifo = fifoWrite(width, mod.get());
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

    cout << "Write fifo func" << endl;
    cout << valueString(writeFifo) << endl;

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "sys_array_2x2", mod.get());

    auto blk = mkBB("entry_block", f);

    IRBuilder<> b(blk);
    
    auto aRow0 = getArg(f, 0);
    auto aRow1 = getArg(f, 1);
    vector<llvm::Value*> aRows{aRow0, aRow1};

    auto bCol0 = getArg(f, 2);
    auto bCol1 = getArg(f, 3);
    vector<llvm::Value*> bCols{bCol0, bCol1};    

    auto cRow0 = getArg(f, 4);
    auto cRow1 = getArg(f, 5);
    vector<llvm::Value*> cCols{cRow0, cRow1};
    
    vector<Value*> rightRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        b.CreateAlloca(intType(width), nullptr, "right_" + to_string(i));
      storeReg(b, reg, mkInt(0, width));
      rightRegisters.push_back(reg);
    }

    vector<Value*> downRegisters;
    for (int i = 0; i < 2; i++) {
      auto reg =
        b.CreateAlloca(intType(width), nullptr, "down_" + to_string(i));
      storeReg(b, reg, mkInt(0, width));
      downRegisters.push_back(reg);
    }
    
    vector<Value*> accumRegisters;
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        auto reg =
          b.CreateAlloca(intType(width), nullptr, "accum_" + to_string(i) + "_" + to_string(j));
        storeReg(b, reg, mkInt(0, width));
        accumRegisters.push_back(reg);
      }
    }

    for (int i = 0; i < 4; i++) {
      cout << "i = " << i << endl;
      
      vector<Value*> aRowVals;
      for (int i = 0; i < 2; i++) {
        aRowVals.push_back(b.CreateCall(readFifo, aRows[i]));
      }

      vector<Value*> bColVals;
      for (int i = 0; i < 2; i++) {
        bColVals.push_back(b.CreateCall(readFifo, bCols[i]));
      }

      for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 2; col++) {
          Value* aVal = nullptr;

          if (col == 0) {
            aVal = aRowVals[row];
          } else {
            aVal = loadReg(b, rightRegisters[row]);
          }

          Value* bVal = nullptr;
          if (row == 0) {
            bVal = bColVals[col];
          } else {
            bVal = loadReg(b, downRegisters[col]);
          }
          
          auto accumReg = accumRegisters[2*row + col];
          auto newAccum =
            b.CreateAdd(loadReg(b, accumReg), b.CreateMul(aVal, bVal));

          storeReg(b, accumReg, newAccum);

        }
      }

      // Update register values
      for (int col = 0; col < 2; col++) {
        storeReg(b, downRegisters[col], bColVals[col]);
      }

      for (int row = 0; row < 2; row++) {
        storeReg(b, rightRegisters[row], aRowVals[row]);
      }
      
    }

    // Store out final results
    for (int j = 0; j < 2; j++) {
      auto cCol = cCols[j];
      for (int i = 0; i < 2; i++) {
        b.CreateCall(writeFifo, {loadReg(b, accumRegisters[2*i + j]), cCol});
      }
    }

    b.CreateRet(nullptr);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };
    
    // More constraints
    
    // HardwareConstraints hcs = standardConstraints();

    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);

    // cout << "Memory mapping" << endl;
    // for (auto mm : hcs.memoryMapping) {
    //   cout << "\t" << valueString(mm.first) << " -> " << valueString(mm.second) << endl;
    // }
    setAllAllocaMemTypes(hcs, f, registerSpec(width));

    hcs.setCount(MUL_OP, 4);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));
    // Add gep restriction
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrR : bb) {
        auto instr = &instrR;
        int numUsers = instr->getNumUses();

        if (!BinaryOperator::classof(instr) && (numUsers == 1)) {
          auto& user = *(instr->uses().begin());
          assert(Instruction::classof(user));
          auto userInstr = dyn_cast<Instruction>(user.getUser());
          p.addConstraint(p.instrEnd(instr) == p.instrStart(userInstr));
        }
      }
    }
    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    //REQUIRE(graph.numControlStates() == 8);

    for (auto& st : graph.opStates) {
      int numReads = 0;
      int numWrites = 0;
      int numMuls = 0;
      int numAdds = 0;
      int numLoads = 0;
      int numStores = 0;

      for (auto instrG : graph.instructionsStartingAt(st.first)) {
        Instruction* instr = instrG.instruction;
        if (isBuiltinFifoRead(instr)) {
          numReads++;
        }

        if (isBuiltinFifoWrite(instr)) {
          numWrites++;
        }

        if (instr->getOpcode() == Instruction::Mul) {
          numMuls++;
        }

        if (instr->getOpcode() == Instruction::Add) {
          numAdds++;
        }

        if (LoadInst::classof(instr)) {
          numLoads++;
        }

        if (StoreInst::classof(instr)) {
          numStores++;
        }
        
      }

      // Looks like a register cannot be loaded from and stored to
      // 
      cout << "At state " << st.first << endl;
      cout << tab(1) << " numReads     == " << numReads << endl;
      cout << tab(1) << " numWrites    == " << numWrites << endl;
      cout << tab(1) << " numMuls      == " << numMuls << endl;
      cout << tab(1) << " numAdds      == " << numAdds << endl;
      cout << tab(1) << " numLoads     == " << numLoads << endl;
      cout << tab(1) << " numStores    == " << numStores << endl;

      bool res = (numReads == 0) || (numReads == 4);
      REQUIRE(res);
    }

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("sys_array_2x2"));
  }

  TEST_CASE("Phi node with 4 inputs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;

    auto mod = llvm::make_unique<Module>("BB diamond 4", context);
    setGlobalLLVMModule(mod.get());
    
    std::vector<Type *> inputs{intType(width)->getPointerTo(),
        intType(width)->getPointerTo()};
    Function* f = mkFunc(inputs, "bb_diamond_4", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto fBlock = mkBB("false_block", f);
    auto tBlock = mkBB("true_block", f);
    
    auto ffBlock = mkBB("false_false_block", f);
    auto ftBlock = mkBB("false_true_block", f);        

    auto tfBlock = mkBB("true_false_block", f);
    auto ttBlock = mkBB("true_true_block", f);
    
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* zero = mkInt("0", width);
    ConstantInt* one = mkInt("1", width);
    ConstantInt* two = mkInt("2", width);    
    ConstantInt* three = mkInt("3", width);    

    IRBuilder<> builder(entryBlock);
    auto condVal = loadVal(builder, getArg(f, 0), zero);
    auto lt2 = builder.CreateICmpULT(condVal, two);
    auto lt1 = builder.CreateICmpULT(condVal, one);
    auto lt3 = builder.CreateICmpULT(condVal, three);
    builder.CreateCondBr(lt2, tBlock, fBlock);

    IRBuilder<> fBuilder(fBlock);
    fBuilder.CreateCondBr(lt3, ftBlock, ffBlock);

    IRBuilder<> ffBuilder(ffBlock);
    ffBuilder.CreateBr(exitBlock);

    IRBuilder<> ftBuilder(ftBlock);
    ftBuilder.CreateBr(exitBlock);
    
    IRBuilder<> tBuilder(tBlock);
    tBuilder.CreateCondBr(lt1, ttBlock, tfBlock);

    IRBuilder<> tfBuilder(tfBlock);
    tfBuilder.CreateBr(exitBlock);

    IRBuilder<> ttBuilder(ttBlock);
    ttBuilder.CreateBr(exitBlock);

    IRBuilder<> exitBuilder(exitBlock);
    auto valPhi = exitBuilder.CreatePHI(intType(width), 3);
    valPhi->addIncoming(three, ffBlock);
    valPhi->addIncoming(two, ftBlock);
    valPhi->addIncoming(one, tfBlock);
    valPhi->addIncoming(zero, ttBlock);    
    
    storeVal(exitBuilder,
             getArg(f, 1),
             zero,
             valPhi);
    
    exitBuilder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    Schedule s = scheduleFunction(f, hcs);

    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> layout = {{"arg_0", 0}, {"arg_1", 10}};

    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    SECTION("Taking true, true path") {
      map<string, vector<int> > memoryInit{{"arg_0", {0}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {0}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking true, false") {
      map<string, vector<int> > memoryInit{{"arg_0", {1}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {1}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking false, true") {
      map<string, vector<int> > memoryInit{{"arg_0", {2}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {2}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }

    SECTION("Taking false, false") {
      map<string, vector<int> > memoryInit{{"arg_0", {3}}};
      map<string, vector<int> > memoryExpected{{"arg_1", {3}}};

      TestBenchSpec tb;
      tb.memoryInit = memoryInit;
      tb.memoryExpected = memoryExpected;
      tb.runCycles = 30;
      tb.name = "bb_diamond_4";
      emitVerilogTestBench(tb, arch, layout);

      REQUIRE(runIVerilogTB("bb_diamond_4"));
    }
    
  }

  TEST_CASE("Running verilog fifo tests") {

    string mainName = "fifo.v";
    string exeName = "fifo";
    REQUIRE(runIVerilogTest(mainName, exeName));

    string mName = "fifo_3.v";
    string eName = "fifo_3";
    REQUIRE(runIVerilogTest(mName, eName));
    
  }

  TEST_CASE("Reading and writing FIFOs") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("fifo use in a loop", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = StructType::create(context, "builtin_fifo_" + iStr);

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));
    
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "fifo_in_loop", mod.get());

    auto entryBlock = mkBB("entry_block", f);
    auto exitBlock = mkBB("exit_block", f);

    ConstantInt* three = mkInt("3", width);
    ConstantInt* zero = mkInt("0", width);

    auto bodyF = [f, readFifo, writeFifo, width](IRBuilder<>& builder, Value* i) {
      auto val = builder.CreateCall(readFifo, {getArg(f, 0)});
      auto p0 = builder.CreateAdd(mkInt(2, width), val);
      auto sum = builder.CreateAdd(p0, val);
      builder.CreateCall(writeFifo, {sum, getArg(f, 1)});
    };
    auto loopBlock = sivLoop(f, entryBlock, exitBlock, zero, three, bodyF);

    IRBuilder<> entryBuilder(entryBlock);
    entryBuilder.CreateBr(loopBlock);

    IRBuilder<> exitBuilder(exitBlock);
    exitBuilder.CreateRet(nullptr);
    
    cout << "LLVM function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return fifoSpec(width, 16); };

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);
    
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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("fifo_in_loop"));
  }

  TEST_CASE("Reduce loop") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadModule(context, err, "add_reduce_15");
    setGlobalLLVMModule(mod.get());
    
    Function* f = mod->getFunction("add_reduce_15");

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    hcs.setCount(ADD_OP, 1);

    set<BasicBlock*> blocksToPipeline;
    Schedule s = scheduleFunction(f, hcs, blocksToPipeline);
    STG graph = buildSTG(s, f);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<string, int> testLayout = {{"in", 0}, {"out", 17}};
    map<llvm::Value*, int> layout = {{getArg(f, 0), 0}, {getArg(f, 1), 17}};
    auto arch = buildMicroArchitecture(f, graph, layout);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog(f, arch, info);

    // Create testing infrastructure
    map<string, vector<int> > memoryInit{{"in", {4, 8, 6, 12, 3, 1, 3, 1, 5, 2, 5, 2, 5, 2, 7}}};
    map<string, vector<int> > memoryExpected{{"out", {4 + 8 + 6 + 12 + 3 + 1 + 3 + 1 + 5 + 2 + 5 + 2 + 5 + 2 + 7}}};

    TestBenchSpec tb;
    tb.memoryInit = memoryInit;
    tb.memoryExpected = memoryExpected;
    tb.runCycles = 100;
    tb.maxCycles = 200;
    tb.name = "add_reduce_15";
    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("add_reduce_15"));
  }

  TEST_CASE("Timed wire reduction") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 16;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("Add-reduce with timed wires", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_reduce", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in = getArg(f, 0);
    Value* val = mkInt(0, width);
    for (int i = 0; i < 4; i++) {
      auto nextVal = b.CreateCall(readFifo, {in});
      val = b.CreateAdd(val, nextVal);
    }

    auto out = getArg(f, 1);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(readFifo) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs[tp->getName()] =
      [width](StructType* tp) { return wireSpec(width); };

    // TODO: Add relative timing constraints on wires
    
    hcs.setCount(ADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    REQUIRE(runIVerilogTB("timed_wire_reduce"));
  }

  TEST_CASE("One floating point add") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("One float add", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);

    InterfaceFunctions interfaces;    
    vector<Type*> readArgs = {tp->getPointerTo()};
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_fp_add", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in0 = getArg(f, 0);
    auto in1 = getArg(f, 1);
    auto a = b.CreateCall(readFifo, {in0});
    auto b0 = b.CreateCall(readFifo, {in1});
    auto val = b.CreateFAdd(a, b0);
    auto out = getArg(f, 2);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };

    // TODO: Set latency of fadd to 15?
    hcs.setCount(FADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    float af = 3.0;
    float bf = 4.0;
    float cf = af + bf;

    cout << "Sum bits = " << floatBits(cf) << endl;
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "timed_wire_fp_add";
    tb.settableWires.insert("arg_0_out_data");
    tb.settableWires.insert("arg_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 21, assertString("arg_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 21, string("$display(\"arg_2_in_data = %d\", arg_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_fp_add"));
  }
  
  TEST_CASE("Floating point reduce with timed wires") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("floating point reduce with timed wires", context);
    setGlobalLLVMModule(mod.get());    

    StructType* tp = fifoType(width);
    vector<Type*> readArgs = {tp->getPointerTo()};

    InterfaceFunctions interfaces;        
    Function* readFifo = fifoRead(width, mod.get());
    implementWireRead(readFifo);
    interfaces.addFunction(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    implementWireWrite(writeFifo);
    interfaces.addFunction(writeFifo);

    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo()};
    
    Function* f = mkFunc(inputs, "timed_wire_reduce_fp", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto in = getArg(f, 0);
    Value* val = mkFloat(0);
    for (int i = 0; i < 4; i++) {
      auto nextVal = b.CreateCall(readFifo, {in});
      val = b.CreateFAdd(val, nextVal);
    }

    auto out = getArg(f, 1);
    b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };
    
    hcs.setCount(FADD_OP, 1);

    ExecutionConstraints exec;
    inlineWireCalls(f, exec, interfaces);

    // TODO: Fix the fadd instantiation problem: 2 fadds but scheduled like
    // there is only 1?
    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    exec.addConstraints(p, f);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 10;
    tb.maxCycles = 100;
    tb.name = "timed_wire_reduce_fp";
    tb.settableWires.insert("arg_0_out_data");
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 81, assertString("arg_1_in_data === (1 + 2 + 3 + 4)"));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = 1;"));
    map_insert(tb.actionsInCycles, 2, string("arg_0_out_data_reg = 2;"));
    map_insert(tb.actionsInCycles, 3, string("arg_0_out_data_reg = 3;"));    
    map_insert(tb.actionsInCycles, 4, string("arg_0_out_data_reg = 4;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("timed_wire_reduce_fp"));
  }

  // Some problems with this prototype:
  // 2. Writing out constraints like these is tedious and error prone
  // 3. I want to be able to express loop related constraints as well
  //    (constraints on execution order of instances of an action)
  // 5. Eventually I want a constraint API that is good enough to write a paper
  //    about. Ideally using C/C++ as a frontend
  // 6. Not only is writing these constraints tedious, writing LLVM code for
  //    reads and writes to ports is also tedious. Id like to encapsulate
  //    these reads and writes and the accompanying scheduling constraints
  //    in a data structure.
  TEST_CASE("One floating point add via readport and writeport") {
    LLVMContext context;
    setGlobalLLVMContext(&context);

    int width = 32;
    auto iStr = to_string(width);

    auto mod = llvm::make_unique<Module>("One float add via port API", context);
    setGlobalLLVMModule(mod.get());

    StructType* tp = fifoType(width);
    
    vector<Type*> readArgs = {tp->getPointerTo()};

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width, mod.get());
    interfaces.addFunction(readFifo);
    implementWireRead(readFifo);
    Function* writeFifo = fifoWrite(width, mod.get());
    interfaces.addFunction(writeFifo);
    implementWireWrite(writeFifo);

    auto fpuType =
      llvm::StructType::create(getGlobalLLVMContext(),
                               "builtin_fadd");
    
    Function* fadd =
      mkFunc({fpuType, intType(width), intType(width)}, intType(width), "jd_fadd");
    interfaces.addFunction(fadd);
    {
      ExecutionConstraints& exec = interfaces.getConstraints(fadd);
      auto entryBlock = mkBB("entry_block", fadd);
      IRBuilder<> b(entryBlock);
      auto f = fadd;

      auto fpu = getArg(f, 0);
      auto a = getArg(f, 1);
      auto b0 = getArg(f, 2);

      // Interface with floating point adder
      auto writeRst = writePort("rst", 1, fpuType);
      auto writeA = writePort("input_a", 32, fpuType);
      auto writeAStb = writePort("input_a_stb", 1, fpuType);

      auto writeB = writePort("input_b", 32, fpuType);
      auto writeBStb = writePort("input_b_stb", 1, fpuType);
      auto stall = stallFunction();

      auto readAAck = readPort("input_a_ack", 1, fpuType);
      auto readBAck = readPort("input_b_ack", 1, fpuType);
      auto readZStb = readPort("output_z_stb", 1, fpuType);

      auto rst0 = b.CreateCall(writeRst, {fpu, mkInt(1, 1)});
      // Wait until next cycle
      auto rst1 = b.CreateCall(writeRst, {fpu, mkInt(0, 1)});

      exec.endsBeforeStarts(rst0, rst1);

      auto wA = b.CreateCall(writeA, {fpu, a});
      auto wAStb = b.CreateCall(writeAStb, {fpu, mkInt(1, 1)});

      exec.add(instrEnd(rst1) < instrStart(wA));
      //exec.startSameTime(rst1, wA);    
      exec.startSameTime(wA, wAStb);    

      // Wait for input_a_ack == 1, and then wait 1 more cycle
      auto aAck = b.CreateCall(readAAck, {fpu});
      auto stallUntilAAck = b.CreateCall(stall, {aAck});

      auto wAStb0 = b.CreateCall(writeAStb, {fpu, mkInt(0, 1)});
      auto wB = b.CreateCall(writeB, {fpu, b0});
      auto wBStb = b.CreateCall(writeBStb, {fpu, mkInt(1, 1)});

      auto bAck = b.CreateCall(readBAck, {fpu});
      auto stallUntilBAck = b.CreateCall(stall, {bAck});
    
      // Wait one or two cycles?
      auto wBStb0 = b.CreateCall(writeBStb, {fpu, mkInt(0, 1)});

      // Wait at least one cycle after input_b_stb == 1, for output_z_stb == 1
      auto zStb = b.CreateCall(readZStb, {fpu});
      auto stallUntilZStb = b.CreateCall(stall, {zStb});
      auto val = b.CreateCall(readPort("output_z", 32, fpuType), {fpu});

      b.CreateRet(val);
      
      // A / B stall
      exec.addConstraint(instrStart(aAck) == instrEnd(wAStb));
      exec.startsBeforeStarts(aAck, wAStb0);
      exec.addConstraint(instrStart(stallUntilAAck) == instrEnd(aAck));

      
      exec.startSameTime(wA, wAStb);

      exec.addConstraint(instrStart(bAck) == instrEnd(wBStb));
      exec.endsBeforeStarts(bAck, wBStb0);
      exec.addConstraint(instrStart(stallUntilBAck) == instrEnd(bAck));
      exec.startSameTime(wB, wBStb);    

      // Wait for A to be written before writing b
      exec.addConstraint(instrEnd(aAck) < instrStart(wB));

      // Wait for b to be acknowledged before reading Z
      exec.addConstraint(instrEnd(bAck) < instrStart(val));

      exec.startSameTime(val, zStb);
      exec.startSameTime(stallUntilZStb, zStb);

      addDataConstraints(fadd, exec);
    }

    ExecutionConstraints exeConstraints;
    std::vector<Type *> inputs{tp->getPointerTo(),
        tp->getPointerTo(),
        tp->getPointerTo()};
    Function* f = mkFunc(inputs, "direct_port_fp_add", mod.get());

    auto blk = mkBB("entry_block", f);
    IRBuilder<> b(blk);

    auto fpu = b.CreateAlloca(fpuType, nullptr, "fpu_0");
    
    auto in0 = getArg(f, 0);
    auto in1 = getArg(f, 1);

    auto a0 = b.CreateCall(readFifo, {in0});
    auto b0 = b.CreateCall(readFifo, {in1});
    auto val = b.CreateCall(fadd, {fpu, a0, b0});
    auto out = getArg(f, 2);

    auto writeZ = b.CreateCall(writeFifo, {val, out});
    b.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(f) << endl;

    HardwareConstraints hcs = standardConstraints();
    // TODO: Do this by default
    hcs.memoryMapping = memoryOpLocations(f);
    map<string, Port> adderPorts = {
      {"input_a", inputPort(width, "input_a")},
      {"input_a_stb", inputPort(1, "input_a_stb")},
      {"input_b", inputPort(width, "input_b")},
      {"input_b_stb", inputPort(1, "input_b_stb")},
      {"rst", inputPort(1, "rst")},

      {"output_z", outputPort(width, "output_z")},
      {"input_a_ack", outputPort(1, "input_a_ack")},
      {"input_b_ack", outputPort(1, "input_b_ack")},
      {"output_z_stb", outputPort(1, "output_z_stb")}
    };

    map<string, int> defaults = {
      {"input_a", 0},
      {"input_a_stb", 0},
      {"input_b", 0},
      {"input_b_stb", 0},
      {"rst", 0}
    };
    
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs[fpuType->getName()] =
      [adderPorts, defaults](StructType* fp) { return ModuleSpec({}, "adder", adderPorts, defaults); };
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };
    
    exeConstraints.addConstraint(instrEnd(val) < instrStart(writeZ));

    inlineWireCalls(f, exeConstraints, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;
    
    // Note: It is also a pain that I cannot run-the getOrAddFunction
    // method of llvm::Module and get back a function each time. Being able
    // to do that would be awesome.

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(f, hcs, toPipeline);
    p.setObjective(p.blockEnd(blk) - p.blockStart(blk));

    exeConstraints.addConstraints(p, f);

    map<Function*, SchedulingProblem> constraints{{f, p}};
    Schedule s = scheduleFunction(f, hcs, toPipeline, constraints);

    auto retB = [](Schedule& sched, STG& stg, const StateId st, ReturnInst* instr, Condition& cond) {
      map_insert(stg.opTransitions, st, {0, cond});
    };
    
    std::function<void(Schedule&, STG&, StateId, llvm::ReturnInst*, Condition& cond)> returnBehavior(retB);
    
    STG graph = buildSTG(s, f, returnBehavior);

    cout << "STG Is" << endl;
    graph.print(cout);

    //emitVerilatorBinding(graph);
    
    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(f,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);
    info.wiresToWatch.push_back({false, 32, "global_state_dbg"});
    info.debugAssigns.push_back({"global_state_dbg", "global_state"});
    
    emitVerilog(f, arch, info);

    float af = 3.0;
    float bf = 4.0;
    float cf = af + bf;

    cout << "Sum bits = " << floatBits(cf) << endl;
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "direct_port_fp_add";
    tb.settableWires.insert("arg_0_out_data");
    tb.settableWires.insert("arg_1_out_data");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));
    map_insert(tb.actionsOnCycles, 18, assertString("arg_2_in_data == " + floatBits(cf)));

    map_insert(tb.actionsInCycles, 1, string("arg_0_out_data_reg = " + floatBits(af) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 1, string("arg_1_out_data_reg = " + floatBits(bf) + ";"));
    map_insert(tb.actionsInCycles, 8, string("$display(\"arg_2_in_data = %d\", arg_2_in_data);"));
    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("direct_port_fp_add"));
  }
  
  TEST_CASE("Creating memory interface functions") {
    LLVMContext context;
    setGlobalLLVMContext(&context);
    
    auto mod = llvm::make_unique<Module>("dynamic arch", context);
    setGlobalLLVMModule(mod.get());

    int width = 32;
    int depth = 128;
    int addrWidth = clog2(depth);
    StructType* sramTp = sramType(width, depth);
    
    std::vector<Type *> inputs{sramTp->getPointerTo()};

    InterfaceFunctions interfaces;
    Function* ramRead0 =
      mkFunc({sramTp, intType(addrWidth)}, intType(width), "read0");
    interfaces.addFunction(ramRead0);
    implementRAMRead0(ramRead0, interfaces.getConstraints(ramRead0));

    Function* ramWrite0 = mkFunc({sramTp, intType(addrWidth), intType(width)}, voidType(), "write0");
    interfaces.addFunction(ramWrite0);
    implementRAMWrite0(ramWrite0, interfaces.getConstraints(ramWrite0));
  

    FunctionType *tp =
      FunctionType::get(Type::getVoidTy(context), inputs, false);
    Function *srUser =
      Function::Create(tp, Function::ExternalLinkage, "dynamic_arch_sram_class", mod.get());

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + to_string(argId));
      argId++;
    }

    auto entryBlock = BasicBlock::Create(context, "entry_block", srUser);
    ConstantInt* five = mkInt("5", width);
    ConstantInt* zero = mkInt("0", addrWidth);    

    IRBuilder<> builder(entryBlock);
    auto ldA = builder.CreateCall(ramRead0, {getArg(srUser, 0), zero});
    auto plus = builder.CreateAdd(ldA, five);
    auto st = builder.CreateCall(ramWrite0, {getArg(srUser, 0), zero, plus});
    auto ret = builder.CreateRet(nullptr);

    cout << "LLVM Function" << endl;
    cout << valueString(srUser) << endl;

    ExecutionConstraints exec;

    // Control time dependencies
    exec.add(instrStart(ldA) + 1 == instrEnd(ldA));
    exec.add(instrStart(plus) == instrEnd(plus));
    exec.add(instrStart(st) + 3 == instrEnd(st));
    exec.add(instrStart(ret) == instrEnd(ret));

    inlineWireCalls(srUser, exec, interfaces);
    addDataConstraints(srUser, exec);

    cout << "LLVM Function after inlining" << endl;
    cout << valueString(srUser) << endl;

    // cout << "Constraints after inlining" << endl;
    // for (auto c : exec.constraints) {
    //   cout << tab(1) << *c << endl;
    // }

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[sramTp->getName()] =
      [width, depth](StructType* tp) { return ramSpec(width, depth); };

    set<BasicBlock*> toPipeline;
    SchedulingProblem p = createSchedulingProblem(srUser, hcs, toPipeline);
    exec.addConstraints(p, srUser);

    map<Function*, SchedulingProblem> constraints{{srUser, p}};
    Schedule s = scheduleFunction(srUser, hcs, toPipeline, constraints);

    STG graph = buildSTG(s, srUser);

    cout << "STG Is" << endl;
    graph.print(cout);

    REQUIRE(graph.opStates.size() == 5);

    map<Value*, int> layout;
    ArchOptions options;
    auto arch = buildMicroArchitecture(srUser,
                                       graph,
                                       layout,
                                       options,
                                       hcs);

    VerilogDebugInfo info;
    // addNoXChecks(arch, info);
    emitVerilog(srUser, arch, info);
    
    REQUIRE(runIVerilogTB("dynamic_arch_sram_class"));
  }

  TEST_CASE("Reduce 4 with FIFOs") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadModule(context, err, "reduce_4");
    setGlobalLLVMModule(mod.get());

    int width = 32;

    InterfaceFunctions interfaces;
    Function* readFifo = fifoRead(width);
    interfaces.addFunction(readFifo);
    implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

    Function* writeFifo = fifoWrite(width);
    interfaces.addFunction(writeFifo);
    implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

    auto f = mod->getFunction("reduce_4");

    HardwareConstraints hcs = standardConstraints();
    // NOTE: Its a little annoying to have to put module specifications
    // in to the hardware constraints in one place, and then put
    // the interface function definition in another place.

    hcs.typeSpecs["struct.builtin_fifo_32"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
    
    auto arch = synthesizeVerilog(f, interfaces, hcs);

    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "reduce_4";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 1 + 4 + 7 + 9"));
    //to_string(1 + 3 + 5 + 19)));
    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 1, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 1, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 2, string(in0Name + "_in_data = 4;"));
    map_insert(tb.actionsInCycles, 2, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 5, string(in0Name + "_in_data = 7;"));
    map_insert(tb.actionsInCycles, 5, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 6, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 9, string(in0Name + "_in_data = 9;"));
    map_insert(tb.actionsInCycles, 9, string(in0Name + "_write_valid = 1;"));    

    map_insert(tb.actionsInCycles, 10, string(in0Name + "_write_valid = 0;")); 
    map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));    

    map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("reduce_4"));
  }
  
  TEST_CASE("Templatized FIFO") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "add_10_template");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "add_10_template");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteTemplate;

    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs["class.DHLS::Fifo"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    

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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("add_10_template", f, arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "add_10_template";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 1 + 10"));

    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));    

    map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("add_10_template"));
  }


  // Now I can make channels work with a pass-by-value write. Could
  // I do it with pass-by-reference write? What would that even mean?

  // I suppose it would mean that I was creating a register that contained
  // an integer and connecting the output of the register to the data input
  // of the underlying FIFO?

  // Idea: Use some sort of register elimination optimization after inlining
  // and scheduling to turn this in to a pass-by-value operation?

  // Note: I really need to convert the old c examples using pointers as arbitrary
  // width memories into examples that use SRAMs. Then I can re-purpose pointers
  // to a built-in type to mean "registers of that type". Note also: Distinction
  // between a types width (the sum of the widths of all of its state), and the
  // types hardware interface.
  TEST_CASE("Templatized channel") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "add_10_channel");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "add_10_channel");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;

    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    // Set registers
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("add_10_channel", f, arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    // Idea: Spin one sequential test in to many timed tests?
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "add_10_channel";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 1 + 10"));

    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 1;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));        

    map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));    

    map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);
    
    REQUIRE(runIVerilogTB("add_10_channel"));
  }

  TEST_CASE("Templatized channel add") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "channel_add");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "channel_add");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;

    addDataConstraints(f, exec);

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    addDataConstraints(f, exec);    
    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };
    
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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    addNoXChecks(arch, info);

    emitVerilog("channel_add", f, arch, info);

    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string in1Name =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();
    
    string outName =
      getArg(f, 2)->getName() == "" ? "arg_2" : getArg(f, 2)->getName();

    auto in0 = dyn_cast<Argument>(getArg(f, 0));
    auto in1 = dyn_cast<Argument>(getArg(f, 1));
    auto out = dyn_cast<Argument>(getArg(f, 2));
    
    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 30;
    tb.maxCycles = 50;
    tb.name = "channel_add";
    tb.useModSpecs = true;
    tb.settablePort(in0, "in_data");
    tb.settablePort(in0, "write_valid");    
    tb.settablePort(in1, "in_data");
    tb.settablePort(in1, "write_valid");    
    tb.settablePort(out, "read_valid");    

    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 25, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 21, assertString(outName + "_out_data === 2 + 14"));
    
    SECTION("Writing to both inputs in the same cycle") {

      tb.setArgPort(in0, "write_valid", 0, "0");
      tb.setArgPort(in1, "write_valid", 0, "0");

      tb.setArgPort(in0, "in_data", 3, "2");
      tb.setArgPort(in0, "write_valid", 3, "1");      

      tb.setArgPort(in1, "in_data", 3, "14");
      tb.setArgPort(in1, "write_valid", 3, "1");

      tb.setArgPort(in0, "write_valid", 4, 0);
      tb.setArgPort(in1, "write_valid", 4, 0);      

      tb.setArgPort(in1, "write_valid", 8, 0);

      tb.setArgPort(out, "read_valid", 20, 1);
      tb.setArgPort(out, "read_valid", 21, 0);

      emitVerilogTestBench(tb, arch, testLayout);
    
      REQUIRE(runIVerilogTB("channel_add"));
    }

    SECTION("Waiting between writes to in0 and in1") {
      
      map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
      map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));
      map_insert(tb.actionsInCycles, 0, string(in1Name + "_write_valid = 0;"));

      map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 2;"));
      map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

      map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));

      map_insert(tb.actionsInCycles, 7, string(in1Name + "_in_data = 14;"));
      map_insert(tb.actionsInCycles, 7, string(in1Name + "_write_valid = 1;"));

      map_insert(tb.actionsInCycles, 8, string(in1Name + "_write_valid = 0;"));
    
      map_insert(tb.actionsInCycles, 20, string(outName + "_read_valid = 1;"));
      map_insert(tb.actionsInCycles, 21, string(outName + "_read_valid = 0;"));

      emitVerilogTestBench(tb, arch, testLayout);
    
      REQUIRE(runIVerilogTB("channel_add"));

    }
  }

  TEST_CASE("Reduce 4 channels") {
    LLVMContext context;
    SMDiagnostic err;
    setGlobalLLVMContext(&context);

    auto mod = loadCppModule(context, err, "channel_reduce_4");
    setGlobalLLVMModule(mod.get());

    auto f = getFunctionByDemangledName(mod.get(), "channel_reduce_4");

    REQUIRE(f != nullptr);

    ExecutionConstraints exec;
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;

    addDataConstraints(f, exec);

    cout << "Before inlining" << endl;
    cout << valueString(f) << endl;

    addDataConstraints(f, exec);    
    inlineWireCalls(f, exec, interfaces);

    cout << "After inlining" << endl;
    cout << valueString(f) << endl;

    // TODO: How do I extract the hardware mapping from argument types
    // to module specs?
    int width = 32;
    HardwareConstraints hcs = standardConstraints();
    hcs.memoryMapping = memoryOpLocations(f);
    setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs["class.ac_channel"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };

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
    ArchOptions options;
    auto arch = buildMicroArchitecture(f, graph, layout, options, hcs);

    VerilogDebugInfo info;
    //addNoXChecks(arch, info);

    emitVerilog("channel_reduce_4", f, arch, info);
    
    string in0Name =
      getArg(f, 0)->getName() == "" ? "arg_0" : getArg(f, 0)->getName();
    string outName =
      getArg(f, 1)->getName() == "" ? "arg_1" : getArg(f, 1)->getName();

    TestBenchSpec tb;
    map<string, int> testLayout = {};
    tb.memoryInit = {};
    tb.memoryExpected = {};
    tb.runCycles = 40;
    tb.maxCycles = 50;
    tb.name = "channel_reduce_4";
    tb.useModSpecs = true;
    tb.settableWires.insert(in0Name + "_in_data");
    tb.settableWires.insert(in0Name + "_write_valid");
    tb.settableWires.insert(outName + "_read_valid");    
    map_insert(tb.actionsOnCycles, 0, string("rst_reg <= 0;"));

    map_insert(tb.actionsOnCycles, 37, assertString("valid === 1"));
    map_insert(tb.actionsOnCycles, 36, assertString(outName + "_out_data === 2 + 5 + 9 + 7"));
    
    map_insert(tb.actionsInCycles, 0, string(outName + "_read_valid = 0;"));
    map_insert(tb.actionsInCycles, 0, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 3, string(in0Name + "_in_data = 2;"));
    map_insert(tb.actionsInCycles, 3, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 4, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 8, string(in0Name + "_in_data = 5;"));
    map_insert(tb.actionsInCycles, 8, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 9, string(in0Name + "_write_valid = 0;"));

    map_insert(tb.actionsInCycles, 12, string(in0Name + "_in_data = 9;"));
    map_insert(tb.actionsInCycles, 12, string(in0Name + "_write_valid = 1;"));

    map_insert(tb.actionsInCycles, 13, string(in0Name + "_write_valid = 0;"));    

    map_insert(tb.actionsInCycles, 16, string(in0Name + "_in_data = 7;"));
    map_insert(tb.actionsInCycles, 16, string(in0Name + "_write_valid = 1;"));
    
    map_insert(tb.actionsInCycles, 17, string(in0Name + "_write_valid = 0;"));
    
    map_insert(tb.actionsInCycles, 35, string(outName + "_read_valid = 1;"));

    map_insert(tb.actionsInCycles, 36, string(outName + "_read_valid = 0;"));

    emitVerilogTestBench(tb, arch, testLayout);

    REQUIRE(runIVerilogTB("channel_reduce_4"));
  }

  TEST_CASE("Complex number type") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "complex_num");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "complex_num");
    getArg(f, 0)->setName("ram");
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] = implementRAMRead0;
    interfaces.functionTemplates[string("write")] = implementRAMWrite0;
    
    HardwareConstraints hcs = standardConstraints();
    // TODO: Make pointers to primitives registers of their width by default
    hcs.memoryMapping = memoryOpLocations(f);
    // int width = 64;
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    
    hcs.typeSpecs["class.RAM"] = ramSpecFunc;
    hcs.typeSpecs["class.RAM_2"] = ram2SpecFunc;

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("complex_num", graph, hcs);

    REQUIRE(runIVerilogTB("complex_num"));
  }

  void deleteLLVMLifetimeCalls(llvm::Function* f) {
    std::set<Instruction*> toDel;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrV : bb) {
        auto instrP = &instrV;
        if (matchesCall("llvm.lifetime.start", instrP) ||
            matchesCall("llvm.lifetime.end", instrP)) {
          toDel.insert(instrP);
        }
      }
    }

    cout << "Calls to delete = " << toDel.size() << endl;

    for (auto instr : toDel) {
      instr->eraseFromParent();
    }

    toDel = {};
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrV : bb) {
        auto instrP = &instrV;
        if (instrP->use_empty() &&
            (GetElementPtrInst::classof(instrP) ||
             BitCastInst::classof(instrP))) {
          toDel.insert(instrP);
        }
      }
    }

    cout << "Unused instructions = " << toDel.size() << endl;
    for (auto instrP : toDel) {
      cout << "No uses for " << valueString(instrP) << endl;
      instrP->eraseFromParent();
    }
    
    cout << "llvm after lifetime deletes" << endl;
    cout << valueString(f) << endl;
  }

  TEST_CASE("Using a FIFO with compound type as argument") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    std::unique_ptr<Module> Mod = loadCppModule(Context, Err, "compound_fifo");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "compound_fifo");
    getArg(f, 0)->setName("in");
    getArg(f, 1)->setName("out");

    deleteLLVMLifetimeCalls(f);

    HardwareConstraints hcs = standardConstraints();
    // TODO: Make pointers to primitives registers of their width by default
    hcs.memoryMapping = memoryOpLocations(f);
    
    InterfaceFunctions interfaces;
    interfaces.functionTemplates[string("read")] =
      [hcs](llvm::Function* readFifo,
            ExecutionConstraints& exec) {
      implementRVCompoundRead(readFifo, exec, hcs);
    };
    interfaces.functionTemplates[string("write")] =
      [hcs](llvm::Function* writeFifo,
            ExecutionConstraints& exec) {
      implementRVCompoundWrite(writeFifo, exec, hcs);
    };
    interfaces.functionTemplates[string("get")] =
      [hcs](llvm::Function* busGet,
            ExecutionConstraints& exec) {
      implementBusGet(busGet, exec, hcs);
    };
    
    int width = 64;
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));

    // TODO: Change this!
    hcs.typeSpecs["class.Fifo"] =
      [width](StructType* tp) { return fifoSpec(width, 32); };

    Schedule s = scheduleInterface(f, hcs, interfaces);
    STG graph = buildSTG(s, f);
    
    cout << "STG Is" << endl;
    graph.print(cout);

    emitVerilog("compound_fifo", graph, hcs);

    //REQUIRE(runIVerilogTB("compound_fifo"));
  }

  // Now there is an issue with port accesses. The operator(x, y) function that I use
  // in the stencils to get and set values returns a pointer to one of its elements.
  // This corresponds to a bundle of fields that can be set. It is set by
  // reading the pointer to an i16 from an opaque function and then storing a value
  // to that pointer. What does that correspond to in hardware?

  // Case 1: Suppose the stencil is a bunch of registers under the surface. The
  // operator(i) takes in 2 constants and corresponds to wiring the write port
  // of the ith register in the stencil to the value %25

  // So in this interpretation a pointer to a type represents "some way to write
  // to a value of that type?" or more generally: "some way to perform any
  // action in this types API?"

  // Q: What if you dont need to perform any action on that type?
  // Q: Why does that matter? Just dont use the wires that you got?
  // Q: Id like for the dereference to be implemented as a slice that
  //    just returns one wire?

  // Stencil module: stencil(v0i, v1i, v2i, v3i, v0o, v1o, v2o, v3o)
  // Deref module:   deref(stencil_v0i, stencil_v1i, stencil_v2i, stencil_v3i,
  //                       stencil_v0o, stencil_v1o, stencil_v2o, stencil_v3o,
  //                       index0, index1, index2,
  //                       output_value_input, output_value_output)

  // So then what are temporary values? Temps of primitive types are busses
  // Temp values of compound types? Maybe just ban them?

  // This seems like a reasonable start. I think the next step is actually
  // to comment back to passing tests and then clean up the memory related
  // code. Check that pointers are only produced by:
  //   1. alloca
  //   2. return values of functions
  //   3. arguments to the function?

  // Note: Should the pre-scheduling assignment of ports have a distinction
  // between wires and registers?
  // Q: What about pointers to temporary objects? What do I mean temporary?
  // A: I guess an object that gets optimized in to a wire?
  //    So if I create an object, then start referencing it through pointers
  //    the module itself has to have all of its internal state saved in
  //    registers or memory.
  //    You have cycle-scoping?

  // problem:
  // Stencil& a = channel.read();
  // Stencil& b = channel.read();
  // a.do_something();
  // b.do_something();
  // a still needs to refer to the original stored value in channel, but
  // if passing by pointer just means connecting to ports that refer to the
  // channel state, then the values will change when the channel is read again
  TEST_CASE("2 x 2 pointwise multiply from Halide") {
    SMDiagnostic Err;
    LLVMContext Context;
    setGlobalLLVMContext(&Context);
    
    std::unique_ptr<Module> Mod = loadLLFile(Context, Err, "vhls_target");
    setGlobalLLVMModule(Mod.get());

    Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
    //getArg(f, 0)->setName("ram");

    cout << "llvm function" << endl;
    cout << valueString(f) << endl;


    // assert(false);
    
    // InterfaceFunctions interfaces;
    // interfaces.functionTemplates[string("read")] = implementRVFifoRead;
    // interfaces.functionTemplates[string("write")] = implementRVFifoWriteRef;
    
    // HardwareConstraints hcs = standardConstraints();
    // // TODO: Make pointers to primitives registers of their width by default
    // hcs.memoryMapping = memoryOpLocations(f);
    // int width = 64;
    // setAllAllocaMemTypes(hcs, f, registerSpec(width));

    // // TODO: Change this!
    // hcs.typeSpecs["class.ac_channel"] =
    //   [width](StructType* tp) { return fifoSpec(width, 32); };

    // Schedule s = scheduleInterface(f, hcs, interfaces);
    // STG graph = buildSTG(s, f);
    
    // cout << "STG Is" << endl;
    // graph.print(cout);

    // emitVerilog("vhls_target", graph, hcs);

    // REQUIRE(runIVerilogTB("vhls_target")); // Run tb
  }

}
