#pragma once

#include "scheduling.h"

namespace DHLS {

  void emitVerilog(llvm::Function* f, const STG& stg);

}
