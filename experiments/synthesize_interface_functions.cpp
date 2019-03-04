#include <iostream>

#include "verilog_backend.h"
#include "llvm_codegen.h"

#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/IR/Module.h>

using namespace DHLS;
using namespace llvm;
using namespace std;

int main() {
  LLVMContext context;
  SMDiagnostic err;
  setGlobalLLVMContext(&context);

  auto mod = llvm::make_unique<Module>("ram_write", context);
  setGlobalLLVMModule(mod.get());

  HardwareConstraints hcs = standardConstraints();
  hcs.typeSpecs[string("SRAM_32_16")] =
    [](StructType* tp) { return ramSpec(32, 16); };
  InterfaceFunctions interfaces;
  
  Function* ramRead = ramLoadFunction(32, 16);
  interfaces.addFunction(ramRead);
  implementRAMRead0(ramRead,
                    interfaces.getConstraints(ramRead));

  Function* ramWrite = ramStoreFunction(32, 16);
  interfaces.addFunction(ramWrite);
  implementRAMWrite0(ramWrite,
                     interfaces.getConstraints(ramWrite));

  set<BasicBlock*> toPipeline;

  // Emit write
  {
    
    Schedule s = scheduleInterface(ramWrite, hcs, interfaces, toPipeline, interfaces.getConstraints(ramWrite));

    STG graph = buildSTG(s, ramWrite);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(ramWrite, graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("ram_write", graph, hcs, info);
  }
  
  // Emit read
  {
    Schedule s = scheduleInterface(ramRead, hcs, interfaces, toPipeline, interfaces.getConstraints(ramRead));

    STG graph = buildSTG(s, ramRead);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(ramRead, graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("ram_read", graph, hcs, info);
  }

  {

    int width = 32;
    auto iStr = to_string(width);
    
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

    hcs.typeSpecs["builtin_fifo_32"] = fifoSpec32;

    {
      Schedule s = scheduleInterface(readFifo, hcs, interfaces, toPipeline, interfaces.getConstraints(readFifo));

      STG graph = buildSTG(s, readFifo);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(readFifo, graph, layout, hcs);

      VerilogDebugInfo info;
      emitVerilog("fifo_read", graph, hcs, info);
    }

    {
      Schedule s = scheduleInterface(writeFifo, hcs, interfaces, toPipeline, interfaces.getConstraints(writeFifo));

      STG graph = buildSTG(s, writeFifo);

      cout << "STG Is" << endl;
      graph.print(cout);

      map<llvm::Value*, int> layout;
      auto arch = buildMicroArchitecture(writeFifo, graph, layout, hcs);

      VerilogDebugInfo info;
      emitVerilog("fifo_write", graph, hcs, info);
    }
    
  }

  {
    int width = 32;
    auto iStr = to_string(width);

    InterfaceFunctions interfaces;
    auto fpuType =
      llvm::StructType::create(getGlobalLLVMContext(),
                               "builtin_fadd");
    
    Function* fadd =
      mkFunc({fpuType->getPointerTo(), intType(width), intType(width)}, intType(width), "jd_fadd");
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

    HardwareConstraints hcs = standardConstraints();
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

    //
    //setAllAllocaMemTypes(hcs, f, registerSpec(width));
    hcs.typeSpecs[fpuType->getName()] =
      [adderPorts, defaults](StructType* fp) { return ModuleSpec({}, "adder", adderPorts, defaults); };
    hcs.typeSpecs["builtin_fifo_32"] =
      [width](StructType* tp) { return wireSpec(width); };
    
    Schedule s = scheduleInterface(fadd, hcs, interfaces, toPipeline, interfaces.getConstraints(fadd));
    STG graph = buildSTG(s, fadd);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<llvm::Value*, int> layout;
    auto arch = buildMicroArchitecture(fadd, graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("fpu_add", graph, hcs, info);
  }

  {

    std::string name = "class.axi_ram";
    llvm::StructType* tp = getGlobalLLVMModule().getTypeByName(name);
    if (tp == nullptr) {
      tp = llvm::StructType::create(getGlobalLLVMContext(), name);
    }

    HardwareConstraints hcs = standardConstraints();
    hcs.typeSpecs[tp->getName()] = axiRamSpec;
    
    InterfaceFunctions interfaces;
    Function* axiRead = mkFunc({tp->getPointerTo(), intType(32)}, intType(32), "axi_read");
    
    interfaces.addFunction(axiRead);
    implementRawAXIRead(axiRead, interfaces.getConstraints(axiRead));
    
    Schedule s = scheduleInterface(axiRead, hcs, interfaces, toPipeline, interfaces.getConstraints(axiRead));
    STG graph = buildSTG(s, axiRead);

    cout << "STG Is" << endl;
    graph.print(cout);

    map<Value*, int> layout;    
    auto arch = buildMicroArchitecture(axiRead, graph, layout, hcs);

    VerilogDebugInfo info;
    emitVerilog("axi_read", graph, hcs, info);


    
  }
  
}
