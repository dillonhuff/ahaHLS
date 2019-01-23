#include "llvm_codegen.h"

using namespace llvm;

namespace DHLS {

  static LLVMContext* context;
  static Module* globalMod;

  void setGlobalLLVMContext(llvm::LLVMContext* contextPtr) {
    context = contextPtr;
  }

  llvm::LLVMContext& getGlobalLLVMContext() {
    assert(context != nullptr);
    
    return *context;
  }

  void setGlobalLLVMModule(llvm::Module* modulePtr) {
    globalMod = modulePtr;
  }

  llvm::Module& getGlobalLLVMModule() {
    assert(globalMod != nullptr);
    
    return *globalMod;
  }

}
