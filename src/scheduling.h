#pragma once

#include <llvm/IR/Module.h>

namespace DHLS {

  enum OperationType {
    STORE_OP,
    LOAD_OP,
    ADD_OP,
    SUB_OP,
    MUL_OP,
    DIV_OP,
    SDIV_OP
  };

  class HardwareConstraints {
  public:
    
    void setLatency(const OperationType op, const int latency) {
    }
    
  };

  class Schedule {
  public:
    int clockTicksToFinish() const {
      return 0;
    }
  };

  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc);
}
