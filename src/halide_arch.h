#pragma once

#include "microarchitecture.h"

namespace ahaHLS {

  class HalideArchSettings {
  public:
    bool loopTasks;
    bool pushFifos;
    bool forToWhile;
    bool optimizeFifos;
    bool predicateFifoWrites;
    bool removeLoopBounds;

    HalideArchSettings() : loopTasks(true),
                           pushFifos(false),
                           forToWhile(false),
                           optimizeFifos(false),
                           predicateFifoWrites(false),
                           removeLoopBounds(false) {}
  };

  MicroArchitecture halideArch(Function* f, HalideArchSettings settings);

}
