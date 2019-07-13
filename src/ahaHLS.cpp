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
  args::ValueFlag<string> topFunctionOption(parser, "top-function", "The top function to be synthesized", {'t'});
  args::ValueFlag<string> targetFileOption(parser, "target-file", "The file to be synthesized", {'p'});  
  
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

  // cout << "# of args = " << argc << endl;
  // assert(argc == 2);
  // char* targetFile = argv[1];
  // cout << "Target file = " << targetFile << endl;

  string targetFile = args::get(targetFileOption);

  cout << "TargetFile = " << targetFile << endl;
  SMDiagnostic Err;
  LLVMContext Context;
  setGlobalLLVMContext(&Context);
    
  std::unique_ptr<Module> Mod = loadCppMod(Context, Err, string(targetFile)); 
  setGlobalLLVMModule(Mod.get());

  // Function* f = getFunctionByDemangledName(Mod.get(), "vhls_target");
  // deleteLLVMLifetimeCalls(f);

  // cout << "Origin function" << endl;
  // cout << valueString(f) << endl;
  
  cout << "Done." << endl;
}
