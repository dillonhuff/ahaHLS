#pragma once

#define AHAHLS_SYNTH_BUILTIN   __attribute__((optnone,noinline))

namespace ahaHLSLib {
  
  template<typename DataType, typename AddressType, int depth>
  class ram {

  public:
    
    DataType read(const AddressType addr) {
      return 0;
    }

  };

}
