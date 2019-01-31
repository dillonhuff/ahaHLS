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

    return getTypeBitWidth(tp);
  }

  int getTypeBitWidth(Type* const tp) {
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

  bool isBuiltinPortWrite(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    if (hasPrefix(name, "builtin_write_port_")) {
      return true;
    }
    return false;
  }

  bool isBuiltinPortRead(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    if (hasPrefix(name, "builtin_read_port_")) {
      return true;
    }
    return false;
  }
  
  bool isBuiltinFifoWrite(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    if (called == nullptr) {
      return false;
    }
    
    if (!called->hasName()) {
      return false;
    }

    string name = called->getName();

    if (hasPrefix(name, "builtin_write_fifo_")) {
      return true;
    }
    return false;
  }

  bool isBuiltinFifoRead(llvm::Instruction* const iptr) {
    if (iptr == nullptr) {
      return false;
    }
    
    //cout << "Checking if " << valueString(iptr) << " is builtin read" << endl;
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    //cout << "Got called" << endl;
    if (called == nullptr) {
      return false;
    }

    //cout << "Called not null" << endl;    

    if (!called->hasName()) {
      return false;
    }

    //cout << "Has a name" << endl;
    
    string name = called->getName();

    if (hasPrefix(name, "builtin_read_fifo_")) {
      return true;
    }
    return false;
  }

  bool isBuiltinStallCall(llvm::Instruction* const iptr) {
    if (!CallInst::classof(iptr)) {
      return false;
    }

    CallInst* call = dyn_cast<CallInst>(iptr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    // Look for stall
    if (hasPrefix(name, "builtin_stall")) {
      return true;
    }
    return false;
  }

  std::string floatBits(const float f) {
    APFloat fpVal(f); // Create ap
    string fBits = fpVal.bitcastToAPInt().toString(2, false);
    return "32'b" + zeroExtend(fBits, 32);
  }

  std::string getPortName(llvm::Instruction* const instr) {
    assert(isBuiltinPortCall(instr));

    CallInst* call = dyn_cast<CallInst>(instr);
    Function* called = call->getCalledFunction();

    string name = called->getName();

    if (isBuiltinPortRead(instr)) {
      return name.substr(string("builtin_read_port_").size());
    } else {
      assert(isBuiltinPortWrite(instr));
      return name.substr(string("builtin_write_fifo_").size());
    }
  }

  
  
  
}
