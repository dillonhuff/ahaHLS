#include "llvm_codegen.h"

using namespace llvm;

namespace DHLS {

  static LLVMContext* context;

  void setGlobalLLVMContext(llvm::LLVMContext* contextPtr) {
    context = contextPtr;
  }

  llvm::LLVMContext& getGlobalLLVMContext() {
    return *context;
  }
}
