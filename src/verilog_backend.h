#pragma once

#include "scheduling.h"

namespace DHLS {

  void emitVerilog(llvm::Function* f, const STG& stg, std::map<std::string, int>& memoryMap);

  void synthesizeVerilog(llvm::Function* f,
                         HardwareConstraints& hdc,
                         std::map<std::string, int>& memoryMap);

}
