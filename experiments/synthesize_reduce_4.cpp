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

  string moduleName ="./experiments/reduce_4";
  system(("clang -D__SYNTHESIS__ -O1 -c -S -emit-llvm " + moduleName + ".c -o " + moduleName + ".ll").c_str());  

  SMDiagnostic Err;
  LLVMContext Context;

  string modFile = "./experiments/reduce_4.ll";

  std::unique_ptr<Module> mod(parseIRFile(modFile, Err, Context));
  if (!mod) {
    outs() << "Error: No mod\n";
    assert(false);
  }

  setGlobalLLVMModule(mod.get());

  int width = 32;
  auto iStr = to_string(width);

  InterfaceFunctions interfaces;
  Function* readFifo = fifoRead(width);
  interfaces.addFunction(readFifo);
  implementRVFifoRead(readFifo, interfaces.getConstraints(readFifo));

  Function* writeFifo = fifoWrite(width);
  interfaces.addFunction(writeFifo);
  implementRVFifoWrite(writeFifo, interfaces.getConstraints(writeFifo));

  auto f = mod->getFunction("reduce_4");
  cout << "LLVM function" << endl;
  cout << valueString(f) << endl;
  
  HardwareConstraints hcs = standardConstraints();
  hcs.modSpecs[getArg(f, 0)] = fifoSpec(width, 32);
  hcs.modSpecs[getArg(f, 1)] = fifoSpec(width, 32);
    
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
}
