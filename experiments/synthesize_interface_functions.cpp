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
  
}
