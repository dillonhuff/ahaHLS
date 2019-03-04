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
  Schedule s = scheduleInterface(ramWrite, hcs, interfaces, toPipeline, interfaces.getConstraints(ramWrite));

  STG graph = buildSTG(s, ramWrite);

  cout << "STG Is" << endl;
  graph.print(cout);

  map<llvm::Value*, int> layout;
  auto arch = buildMicroArchitecture(ramWrite, graph, layout, hcs);

  VerilogDebugInfo info;
  emitVerilog("ram_write", graph, hcs, info);

}
