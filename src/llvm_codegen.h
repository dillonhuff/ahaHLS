#pragma once

#include <llvm/IR/LLVMContext.h>
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include <llvm/Support/TargetSelect.h>

#include "utils.h"

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
      llvm::Function::Create(tp, llvm::Function::ExternalLinkage, funcName, mod);

    int argId = 0;
    for (auto &Arg : srUser->args()) {
      Arg.setName("arg_" + std::to_string(argId));
      srUser->addParamAttr(argId, llvm::Attribute::NoAlias);
      argId++;
    }

    return srUser;
  }

  static inline
  llvm::Value* getArg(llvm::Function* f, const int argNum) {
    assert(argNum < (int) f->arg_size());
    return llvm::dyn_cast<llvm::Value>(f->arg_begin() + argNum);
  }

  static inline
  llvm::Value* loadVal(llvm::IRBuilder<>& builder,
                       llvm::Value* buffer,
                       llvm::Value* offset) {
    auto ind =
      builder.CreateGEP(buffer, offset);
    return builder.CreateLoad(ind);
  }

  static inline
  llvm::Value* storeVal(llvm::IRBuilder<>& builder,
                        llvm::Value* buffer,
                        llvm::Value* offset,
                        llvm::Value* value) {
    auto ind =
      builder.CreateGEP(buffer, offset);
    return builder.CreateStore(value, ind);
  }

  template<typename F>
  llvm::BasicBlock* sivLoop(llvm::Function* f,
                            llvm::BasicBlock* entryBlock,
                            llvm::BasicBlock* exitBlock,
                            llvm::Value* startInd,
                            llvm::Value* endInd,
                            F builderFunc) {

    assert(getValueBitWidth(startInd) == getValueBitWidth(endInd));

    llvm::ConstantInt* one = mkInt("1", getValueBitWidth(startInd));
    
    auto loopBlock = mkBB("", f);
    llvm::IRBuilder<> loopBuilder(loopBlock);
    auto indPhi = loopBuilder.CreatePHI(startInd->getType(), 2);
    auto nextInd = loopBuilder.CreateAdd(indPhi, one);

    builderFunc(loopBuilder, indPhi);

    auto exitCond = loopBuilder.CreateICmpNE(nextInd, endInd);

    indPhi->addIncoming(startInd, entryBlock);
    indPhi->addIncoming(nextInd, loopBlock);
    
    loopBuilder.CreateCondBr(exitCond, loopBlock, exitBlock);

    return loopBlock;
  }

}
