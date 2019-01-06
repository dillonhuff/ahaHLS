#include "utils.h"

#include <llvm/IR/LLVMContext.h>

using namespace llvm;
using namespace std;

namespace DHLS {

  int getValueBitWidth(Value* const instr) {
    Type* tp = instr->getType();
    assert(IntegerType::classof(tp));

    return dyn_cast<IntegerType>(tp)->getBitWidth();
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

}
