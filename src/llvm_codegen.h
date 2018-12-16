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

  static inline
  llvm::Function* mkFunc(std::vector<llvm::Type*>& inputs,
                         const std::string& funcName,
                         llvm::Module* mod) {
    llvm::FunctionType *tp =
      llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalLLVMContext()), inputs, false);
    
    llvm::Function *srUser =
      llvm::Function::Create(tp, llvm::Function::ExternalLinkage, "accum_loop", mod);

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + std::to_string(argId));
      argId++;
    }

    return srUser;
  }
}
