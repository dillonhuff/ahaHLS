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
    bool pipelineLoops;

    HalideArchSettings() : loopTasks(true),
                           pushFifos(false),
                           forToWhile(false),
                           optimizeFifos(false),
                           predicateFifoWrites(false),
                           removeLoopBounds(false),
                           pipelineLoops(false) {}
  };

  MicroArchitecture halideArch(Function* f, HalideArchSettings settings);

}
