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

  llvm::StructType* sramType(const int width, const int depth) {
    std::string name = "SRAM_" + std::to_string(width) + "_" + std::to_string(depth);
    llvm::StructType* tp = getGlobalLLVMModule().getTypeByName(name);
    if (tp == nullptr) {
      tp = llvm::StructType::create(getGlobalLLVMContext(), name);
    }
                               
    return tp;
  }
  

  llvm::Type* voidType() {
    return llvm::Type::getVoidTy(getGlobalLLVMContext());
  }

  llvm::BasicBlock* exitBlock(llvm::Function* const f) {
    for (auto& bb : f->getBasicBlockList()) {
      auto term = bb.getTerminator();

      if (ReturnInst::classof(term)) {
        return &bb;
      }
    }
    assert(false);
  }
  
}
