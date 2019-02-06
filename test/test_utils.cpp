#include "test_utils.h"

#include <iostream>
#include <fstream>

using namespace std;
using namespace llvm;

namespace DHLS {


  int createLLFile(const std::string& moduleName) {
    return system(("clang -O1 -D__SYNTHESIS__ -c -S -emit-llvm " + moduleName + ".c -o " + moduleName + ".ll").c_str());
  }

  int createCppLLFile(const std::string& moduleName) {
    return system(("clang++ -O1 -D__SYNTHESIS__ -c -S -emit-llvm " + moduleName + ".cpp -o " + moduleName + ".ll").c_str());
  }
  
  std::unique_ptr<Module> loadLLFile(LLVMContext& Context,
                                     SMDiagnostic& Err,
                                     const std::string& name) {
    string modFile = "./test/ll_files/" + name + ".ll";
    cout << "Parsing ir file " << modFile << endl;
    std::unique_ptr<Module> Mod(parseIRFile(modFile, Err, Context));
    if (!Mod) {
      outs() << "Error: No mod\n";
      assert(false);
    }

    return Mod;
  }
  
  std::unique_ptr<Module> loadModule(LLVMContext& Context,
                                     SMDiagnostic& Err,
                                     const std::string& name) {
    int res = createLLFile("./test/ll_files/" + name);
    assert(res == 0);
    
    return loadLLFile(Context, Err, name);
  }

  std::unique_ptr<Module> loadCppModule(LLVMContext& Context,
                                        SMDiagnostic& Err,
                                        const std::string& name) {
    int res = createCppLLFile("./test/ll_files/" + name);
    assert(res == 0);
    
    return loadLLFile(Context, Err, name);
  }
  
  bool runCmd(const std::string& cmd) {
    cout << "Running command: " << cmd << endl;
    bool res = system(cmd.c_str());
    return res == 0;
  }

  bool runIVerilogTB(const std::string& moduleName) {
    string mainName = moduleName + "_tb.v";
    string modFile = moduleName + ".v";

    string genCmd = "iverilog -g2005 -o " + moduleName + " " + mainName + " " + modFile + " RAM.v RAM2.v RAM3.v axil_ram.v delay.v builtins.v";

    bool compiled = runCmd(genCmd);

    if (!compiled) {
      return false;
    }

    string resFile = moduleName + "_tb_result.txt";
    string exeCmd = "./" + moduleName + " > " + resFile;
    bool ran = runCmd(exeCmd);

    assert(ran);

    ifstream res(resFile);
    std::string str((std::istreambuf_iterator<char>(res)),
                    std::istreambuf_iterator<char>());

    cout << "str = " << str << endl;
    
    //runCmd("rm -f " + resFile);

    reverse(begin(str), end(str));
    string lastLine;

    for (int i = 1; i < (int) str.size(); i++) {
      if (str[i] == '\n') {
        break;
      }

      lastLine += str[i];
    }

    reverse(begin(lastLine), end(lastLine));

    cout << "Lastline = " << lastLine << endl;
    return lastLine == "Passed";
  }

  bool runIVerilogTest(const std::string& mainName,
                       const std::string& exeName) {

    string genCmd = "iverilog -g2005 -o " + exeName + " " + mainName + string(" ") + " RAM.v RAM2.v RAM3.v axil_ram.v delay.v builtins.v";

    bool compiled = runCmd(genCmd);

    assert(compiled);

    string resFile = exeName + "_tb_result.txt";
    string exeCmd = "./" + exeName + " > " + resFile;
    bool ran = runCmd(exeCmd);

    assert(ran);

    ifstream res(resFile);
    std::string str((std::istreambuf_iterator<char>(res)),
                    std::istreambuf_iterator<char>());

    cout << "str = " << str << endl;
    
    reverse(begin(str), end(str));
    string lastLine;

    for (int i = 1; i < (int) str.size(); i++) {
      if (str[i] == '\n') {
        break;
      }

      lastLine += str[i];
    }

    reverse(begin(lastLine), end(lastLine));

    cout << "Lastline = " << lastLine << endl;

    return lastLine == "Passed";
  }
  
}
