#pragma once

#include <llvm/IR/LLVMContext.h>
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include <llvm/Support/TargetSelect.h>

#include "utils.h"

#include <iostream>

namespace ahaHLS {

  llvm::Type* voidType();
  llvm::StructType* sramType(const int width, const int depth);

  void setGlobalLLVMContext(llvm::LLVMContext* contextPtr);
  llvm::LLVMContext& getGlobalLLVMContext();

  void setGlobalLLVMModule(llvm::Module* modulePtr);
  llvm::Module& getGlobalLLVMModule();
  
  static inline
  llvm::ConstantInt* mkInt(const std::string& decimalValueString, int bitWidth) {
    return llvm::ConstantInt::get(getGlobalLLVMContext(), llvm::APInt(bitWidth, llvm::StringRef(decimalValueString), 10));
  }

  static inline
  llvm::ConstantFP* mkFloat(const float value) {
    return llvm::ConstantFP::get(getGlobalLLVMContext(), llvm::APFloat(value));
  }
  
  static inline
  llvm::ConstantInt* mkInt(const int value, int bitWidth) {
    return llvm::ConstantInt::get(getGlobalLLVMContext(), llvm::APInt(bitWidth, llvm::StringRef(std::to_string(value)), 10));
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
                         llvm::Type* outputType,
                         const std::string& funcName,
                         llvm::Module* mod) {

    llvm::Function* resF = mod->getFunction(funcName);

    if (resF != nullptr) {
      return resF;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(outputType, inputs, false);

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
  llvm::Function* mkFunc(std::vector<llvm::Type*> inputs,
                         llvm::Type* outputType,
                         const std::string& funcName) {
    auto inCpy = inputs;
    return mkFunc(inCpy, outputType, funcName, &getGlobalLLVMModule());
  }  
  
  static inline
  llvm::Function* mkFunc(std::vector<llvm::Type*>& inputs,
                         const std::string& funcName,
                         llvm::Module* mod) {
    return mkFunc(inputs, llvm::Type::getVoidTy(getGlobalLLVMContext()), funcName, mod);
  }

  static inline
  llvm::Instruction* loadVal(llvm::IRBuilder<>& builder,
                       llvm::Value* buffer,
                       llvm::Value* offset,
                       const std::string name = "") {
    auto ind =
      builder.CreateGEP(buffer, offset);
    return builder.CreateLoad(ind, name);
  }

  static inline
  llvm::Function* ramLoadFunction(const int width, const int depth) {
    // TODO: Add tostring
    auto name = "ram.read.32.16";

    auto& m = getGlobalLLVMModule();
    llvm::Function* fifoRead = m.getFunction(name);

    if (fifoRead != nullptr) {
      return fifoRead;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(intType(width), {sramType(width, depth)->getPointerTo(), intType(width)}, false);

    auto c = m.getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
  }

  static inline
  llvm::Function* ramLoadFunction(llvm::Value* ram) {
    // TODO: Compute these values
    return ramLoadFunction(32, 16);
  }  

  static inline
  llvm::Function* ramStoreFunction(const int width, const int depth) {

    // TODO: Add tostring
    auto name = "ram.write.32.16";
        
    auto& m = getGlobalLLVMModule();
    llvm::Function* ramStore = m.getFunction(name);

    if (ramStore != nullptr) {
      return ramStore;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(voidType(), {sramType(width, depth)->getPointerTo(), intType(width), intType(width)}, false);

    auto c = m.getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
  }

  static inline
  llvm::Function* ramStoreFunction(llvm::Value* ram) {
    // TODO: Compute these values
    return ramStoreFunction(32, 16);
  }
  
  static inline
  llvm::Instruction* loadRAMVal(llvm::IRBuilder<>& builder,
                       llvm::Value* ram,
                       llvm::Value* addr,
                       const std::string name = "") {
    llvm::Function* ramLoadF = ramLoadFunction(ram);
    return builder.CreateCall(ramLoadF, {ram, addr});
  }

  static inline
  llvm::Instruction* storeRAMVal(llvm::IRBuilder<>& builder,
                                 llvm::Value* ram,
                                 llvm::Value* addr,
                                 llvm::Value* value) {
    auto ramStoreF = ramStoreFunction(ram);
    return builder.CreateCall(ramStoreF, {ram, addr, value});
  }
  
  static inline
  llvm::Instruction* storeVal(llvm::IRBuilder<>& builder,
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

  template<typename F>
  llvm::BasicBlock* sivLoop(llvm::Function* f,
                            llvm::BasicBlock* entryBlock,
                            llvm::BasicBlock* exitBlock,
                            int numIters,
                            F builderFunc) {

    auto startInd = mkInt(0, 32);
    auto endInd = mkInt(numIters, 32);    
    return sivLoop(f, entryBlock, exitBlock, startInd, endInd, builderFunc);
  }
  
  static inline
  llvm::Value* loadReg(llvm::IRBuilder<>& builder, llvm::Value* val) {
    assert(llvm::PointerType::classof(val->getType()));
    return builder.CreateLoad(val);
    //return loadVal(builder, val, mkInt(0, 32));
  }

  static inline
  llvm::Value* storeReg(llvm::IRBuilder<>& builder, llvm::Value* reg, llvm::Value* val) {
    return storeVal(builder, reg, mkInt(0, 32), val);
  }

  static inline
  llvm::StructType* fifoType(const int width) {
    std::string name = "builtin_fifo_" + std::to_string(width);
    llvm::StructType* tp = getGlobalLLVMModule().getTypeByName(name);
    if (tp == nullptr) {
      tp = llvm::StructType::create(getGlobalLLVMContext(), name);
    }
                               
    return tp;
  }

  static inline
  llvm::StructType* wireType(const int width) {
    llvm::StructType* tp =
      llvm::StructType::create(getGlobalLLVMContext(),
                               "builtin_wire_" + std::to_string(width));
    return tp;
  }
  
  static inline
  llvm::Function* fifoRead(const int width, llvm::Module* m) {

    auto name = "builtin_read_fifo_" + std::to_string(width);

    llvm::Function* fifoRead = m->getFunction(name);

    if (fifoRead != nullptr) {
      return fifoRead;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(intType(width), {fifoType(width)->getPointerTo()}, false);

    auto c = m->getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
    // if (llvm::Function::classof(c)) {
    //   return llvm::dyn_cast<llvm::Function>(c);
    // } else if (llvm::ConstantExpr::classof(c)) {
    //   std::cout << "Is constantexpr " << valueString(c) << std::endl;
    //   assert(false);
    // } else {
    //   assert(false);
    // }
  }

  static inline
  llvm::Function* fifoRead(const int width) {
    return fifoRead(width, &getGlobalLLVMModule());
  }  

  static inline
  llvm::Function* fifoWrite(const int width, llvm::Module* m) {
    auto name = "builtin_write_fifo_" + std::to_string(width);

    llvm::Function* writeF = m->getFunction(name);
    if (writeF != nullptr) {
      return writeF;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalLLVMContext()),
                              {intType(width), fifoType(width)->getPointerTo()},
                              false);

    auto c = m->getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
  }

  static inline
  llvm::Function* fifoWrite(const int width) {
    return fifoWrite(width, &getGlobalLLVMModule());
  }

  static inline llvm::StructType* structType(const std::string name) {
    auto n = getGlobalLLVMModule().getTypeByName(name);
    if (n == nullptr) {
      return llvm::StructType::create(getGlobalLLVMContext(), name);
    }

    return n;
  }
  
  static inline
  llvm::Function* writePort(const std::string& portName,
                            const int width,
                            llvm::Type* argType) {

    auto& m = getGlobalLLVMModule();
    // TODO: Add argType to name
    auto name = "builtin_write_port_" + portName;

    llvm::Function* fifoRead = m.getFunction(name);

    if (fifoRead != nullptr) {
      return fifoRead;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalLLVMContext()),
                              {argType,
                                  intType(width)},
                              false);
    
    auto c = m.getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
  }

  static inline
  llvm::Function* readPort(const std::string& portName,
                           const int width,
                           llvm::Type* argType) {

    // TODO: Add typestring to name
    auto name = "builtin_read_port_" + portName;

    auto& m = getGlobalLLVMModule();
    llvm::Function* fifoRead = m.getFunction(name);

    if (fifoRead != nullptr) {
      return fifoRead;
    }

    llvm::FunctionType *tp =
      llvm::FunctionType::get(intType(width),
                              {argType},
                              false);
    
    // llvm::FunctionType *tp =
    //   llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalLLVMContext()),
    //                           {argType,
    //                               intType(width)},
    //                           false);
    
    // llvm::FunctionType *tp =
    //   llvm::FunctionType::get(intType(width), {fifoType(width)->getPointerTo()}, false);

    auto c = m.getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);

    // llvm::FunctionType *tp =
    //   llvm::FunctionType::get(intType(width),
    //                           {argType},
    //                           false);

    // auto c = getGlobalLLVMModule().getOrInsertFunction(name, tp);

    // if (llvm::Function::classof(c)) {
    //   return llvm::dyn_cast<llvm::Function>(c);
    // } else if (llvm::ConstantExpr::classof(c)) {
    //   std::cout << valueString(c) << " is constantexpr" << std::endl;
    //   if (llvm::ConstantExpr::classof(c)) {
    //     std::cout << "Is unary" << std::endl;
    //     auto castC = llvm::dyn_cast<llvm::ConstantExpr>(c);
    //     std::cout << "is cast ? " << castC->isCast() << std::endl;
    //     auto f = castC->getOperand(0);
    //     std::cout << "Function = " << valueString(f) << std::endl;

    //     assert(llvm::Function::classof(c));

    //     return llvm::dyn_cast<llvm::Function>(f);
    //   } else {
    //     assert(false);
    //   }
    // } else {
    //   assert(false);
    // }
    
    // assert(llvm::Function::classof(c));

    // return llvm::dyn_cast<llvm::Function>(c);
  }
  
  static inline
  llvm::Function* stallFunction() {

    // TODO: Add typestring to name
    auto name = "builtin_stall";

    llvm::FunctionType *tp =
      llvm::FunctionType::get(llvm::Type::getVoidTy(getGlobalLLVMContext()),
                              {intType(1)},
                              false);

    auto c = getGlobalLLVMModule().getOrInsertFunction(name, tp);

    assert(llvm::Function::classof(c));

    return llvm::dyn_cast<llvm::Function>(c);
  }

  llvm::BasicBlock* exitBlock(llvm::Function* const f);
  
}
