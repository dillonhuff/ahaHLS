#pragma once

#include <llvm/IR/LLVMContext.h>
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/InstrTypes.h"
#include <llvm/Support/TargetSelect.h>

namespace DHLS {

  void setGlobalLLVMContext(llvm::LLVMContext* contextPtr);

  llvm::LLVMContext& getGlobalLLVMContext();

  static inline
  llvm::ConstantInt* mkInt(const std::string& decimalValueString, int bitWidth) {
    return llvm::ConstantInt::get(getGlobalLLVMContext(), llvm::APInt(bitWidth, llvm::StringRef(decimalValueString), 10));
  }

  static inline
  llvm::BasicBlock* mkBB(const std::string& name, llvm::Function* func) {
    return llvm::BasicBlock::Create(getGlobalLLVMContext(), name, func);
  }

  static inline
  llvm::Type* intType(const int width) {
    return llvm::Type::getIntNTy(getGlobalLLVMContext(), width);
  }
}
