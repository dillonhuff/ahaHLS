#include "utils.h"

#include <llvm/IR/LLVMContext.h>

using namespace llvm;

namespace DHLS {

  int getValueBitWidth(Value* const instr) {
    Type* tp = instr->getType();
    assert(IntegerType::classof(tp));

    return dyn_cast<IntegerType>(tp)->getBitWidth();
  }


}
