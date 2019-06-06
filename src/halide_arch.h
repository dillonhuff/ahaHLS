#pragma once

#include "microarchitecture.h"

namespace ahaHLS {

  class HalideArchSettings {
  public:
    bool loopTasks;
    bool pushFifos;
    bool forToWhile;
    bool optimizeFifos;

    HalideArchSettings() : loopTasks(true), pushFifos(false), forToWhile(false), optimizeFifos(false) {}
  };

  MicroArchitecture halideArch(Function* f, HalideArchSettings settings);

}
