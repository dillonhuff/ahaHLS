#pragma once

#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>

#include <llvm/IR/Module.h>

namespace DHLS {

  int createLLFile(const std::string& moduleName);

  std::unique_ptr<llvm::Module> loadLLFile(llvm::LLVMContext& Context,
                                           llvm::SMDiagnostic& Err,
                                           const std::string& name);

  std::unique_ptr<llvm::Module> loadModule(llvm::LLVMContext& Context,
                                           llvm::SMDiagnostic& Err,
                                           const std::string& name);

  bool runCmd(const std::string& cmd);

  bool runIVerilogTB(const std::string& moduleName);

  bool runIVerilogTest(const std::string& mainName,
                       const std::string& exeName);

}
