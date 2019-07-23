#include "algorithm.h"

#include "verilog_backend.h"
#include "llvm_codegen.h"
#include "test_utils.h"

#include "args.hxx"

using namespace ahaHLS;
using namespace llvm;
using namespace std;

// The main file for the ahaHLS exe
int main(int argc, char** argv) {

  args::ArgumentParser parser("This is a simple open source high level synthesis program.", "Please file an issue on github if any errors are discovered.");
  args::HelpFlag help(parser, "help", "Usage: aha-HLS -top-function foo -target-file file.cpp", {'h', "help"});
  args::ValueFlag<string> topFunctionOption(parser, "top-function", "The top function to be synthesized", {'t', "top-function"});
  args::ValueFlag<string> targetFileOption(parser, "target-file", "The file to be synthesized", {'p', "target-file"});  
  
  args::CompletionFlag completion(parser, {"complete"});
  try
    {
      parser.ParseCLI(argc, argv);
    }
  catch (const args::Completion& e)
    {
      std::cout << e.what();
      return 0;
    }
  catch (const args::Help&)
    {
      std::cout << parser;
      return 0;
    }
  catch (const args::ParseError& e)
    {
      std::cerr << e.what() << std::endl;
      std::cerr << parser;
      return 1;
    } 

  string targetFile = args::get(targetFileOption);
  string topFunction = args::get(topFunctionOption);

  cout << "TargetFile  = " << targetFile << endl;
  cout << "TopFunction = " << topFunction << endl;
  
  SMDiagnostic Err;
  LLVMContext Context;
  setGlobalLLVMContext(&Context);
    
  std::unique_ptr<Module> Mod = loadCppMod(Context, Err, string(targetFile)); 
  setGlobalLLVMModule(Mod.get());

  Function* f = getFunctionByDemangledName(Mod.get(), topFunction);
  deleteLLVMLifetimeCalls(f);

  cout << "Original function" << endl;
  cout << valueString(f) << endl;

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
  hcs.memoryMapping = memoryOpLocations(f);
  // Set registers
  setAllAllocaMemTypes(hcs, f, registerSpec(width));
  hcs.typeSpecs["class.ahaHLS::Fifo"] =
    [width](StructType* tp) { return fifoSpec(width, 128); };
    
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
  // ArchOptions options;
  auto arch = buildMicroArchitecture(graph, layout, hcs);

  VerilogDebugInfo info;
  addNoXChecks(arch, info);

  emitVerilog(topFunction, arch, info);
  
  cout << "Done." << endl;
}
