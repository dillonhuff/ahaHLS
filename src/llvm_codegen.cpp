#include "llvm_codegen.h"

using namespace llvm;
using namespace std;

namespace ahaHLS {

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

  void deleteLLVMLifetimeCalls(llvm::Function* f) {
    std::set<Instruction*> toDel;
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrV : bb) {
        auto instrP = &instrV;
        if (matchesCall("llvm.lifetime.start", instrP) ||
            matchesCall("llvm.lifetime.end", instrP)) {
          toDel.insert(instrP);
        }
      }
    }

    cout << "Calls to delete = " << toDel.size() << endl;

    for (auto instr : toDel) {
      instr->eraseFromParent();
    }

    toDel = {};
    for (auto& bb : f->getBasicBlockList()) {
      for (auto& instrV : bb) {
        auto instrP = &instrV;
        if (instrP->use_empty() &&
            (GetElementPtrInst::classof(instrP) ||
             BitCastInst::classof(instrP))) {
          toDel.insert(instrP);
        }
      }
    }

    //cout << "Unused instructions = " << toDel.size() << endl;
    for (auto instrP : toDel) {
      //cout << "No uses for " << valueString(instrP) << endl;
      instrP->eraseFromParent();
    }
    
    //cout << "llvm after lifetime deletes" << endl;
    //cout << valueString(f) << endl;
  }

}
