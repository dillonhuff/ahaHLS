#pragma once

#include "algorithm.h"

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
    std::map<llvm::Instruction*, std::vector<int> > instrTimes;
    std::map<llvm::BasicBlock*, std::vector<int> > blockTimes;

    int startTime(llvm::Instruction* const instr) const {
      return dbhc::map_find(instr, instrTimes).front();
    }

    int clockTicksToFinish() const {
      int maxFinishTime = 0;
      for (auto b : blockTimes) {
        if (b.second.back() > maxFinishTime) {
          maxFinishTime = b.second.back();
        }
      }
      return maxFinishTime;
    }
  };

  Schedule scheduleFunction(llvm::Function* f, HardwareConstraints& hdc);
}
