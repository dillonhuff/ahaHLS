#pragma once

#include "scheduling.h"

namespace ahaHLS {


  ModuleSpec rvFifoSpec(const int width, const int depth);

  llvm::Function* rvFifoReadFunc(const int width, const int depth);
  llvm::Function* rvFifoWriteFunc(const int width, const int depth);

}
