#pragma once

#define AHAHLS_SYNTH_BUILTIN __attribute__((optnone,noinline))

namespace ahaHLSLib {
  
  template<typename DataType, typename AddressType, int depth, int numReadPorts, int numWritePorts>
  class ram {

  public:

    AHAHLS_SYNTH_BUILTIN
    DataType read(const AddressType addr) {
      return 0;
    }

  };

}
