#pragma once

#include "scheduling.h"

namespace DHLS {

  void emitVerilog(llvm::Function* f, const STG& stg, std::map<std::string, int>& memoryMap);  
  //void emitVerilog(llvm::Function* f, const STG& stg);

}
