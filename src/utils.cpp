#include "utils.h"

#include <iostream>
#include <llvm/IR/LLVMContext.h>

using namespace llvm;
using namespace std;

namespace DHLS {


  std::string instructionString(Instruction* const iptr) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *iptr;

    return ss.str();
  }

  std::string valueString(Value* const iptr) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *iptr;

    return ss.str();
  }
  
  std::string typeString(Type* const tptr) {
    std::string str;
    llvm::raw_string_ostream ss(str);
    ss << *tptr;

    return ss.str();
  }

  int getValueBitWidth(Value* const instr) {
    Type* tp = instr->getType();

    //cout << "type = " << typeString(tp) << endl;
    int width;

    if (IntegerType::classof(tp)) {
      IntegerType* iTp = dyn_cast<IntegerType>(tp);
      width = iTp->getBitWidth();
    } else if (PointerType::classof(tp)) {
      PointerType* pTp = dyn_cast<PointerType>(tp);


      //cout << "Element type = " << typeString(pTp->getElementType()) << endl;

      assert(IntegerType::classof(pTp->getElementType()));

      IntegerType* iTp = dyn_cast<IntegerType>(pTp->getElementType());
      width = iTp->getBitWidth();

    } else if (tp->isFloatTy()) {
      // TODO: Make floating point width parametric
      return 32;
    } else {
      std::cout << "Type = " << typeString(tp) << std::endl;
      assert(ArrayType::classof(tp));
      Type* iTp = dyn_cast<ArrayType>(tp)->getElementType();
      assert(IntegerType::classof(iTp));
      width = dyn_cast<IntegerType>(iTp)->getBitWidth();
          
      //cout << "Array width = " << dyn_cast<ArrayType>(tp)->getElementType() << endl;
      //assert(false);
    }

    return width;

    // assert(IntegerType::classof(tp));

    // return dyn_cast<IntegerType>(tp)->getBitWidth();
  }

  bool isBuiltinFifoWrite(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    if (hasPrefix(name, "builtin_write_fifo_")) {
      return true;
    }
    return false;
  }

  bool isBuiltinFifoRead(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    if (hasPrefix(name, "builtin_read_fifo_")) {
      return true;
    }
    return false;
  }

  std::string floatBits(const float f) {
    APFloat fpVal(f); // Create ap
    string fBits = fpVal.bitcastToAPInt().toString(2, false);
    return "32'b" + zeroExtend(fBits, 32);
  }
  
  
}
