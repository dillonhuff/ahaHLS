#pragma once

#include <llvm/IR/LLVMContext.h>

namespace DHLS {

  void setGlobalLLVMContext(llvm::LLVMContext* contextPtr);

  llvm::LLVMContext& getGlobalLLVMContext();
}
