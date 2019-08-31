#pragma once

#include "scheduling.h"

namespace ahaHLS {

  void implementRAMWriteP0(Function* ramWrite0, const int latency, ExecutionConstraints& exec);

}
