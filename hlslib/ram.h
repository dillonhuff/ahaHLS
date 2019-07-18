#pragma once

#include "hls_macros.h"

namespace ahaHLSLib {
  
  template<typename DataType, typename AddressType, int depth, int numReadPorts, int numWritePorts>
  class ram {

    DataType mem[depth];
    
  public:

    AHAHLS_SYNTH_BUILTIN
    DataType read(const AddressType addr) {
      return mem[addr];
    }

    AHAHLS_SYNTH_BUILTIN
    void write(const AddressType addr, const DataType data) {
      mem[addr] = data;
    }
    
  };

}
