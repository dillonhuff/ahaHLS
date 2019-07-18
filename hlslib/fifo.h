#pragma once

#include "hls_macros.h"

#include <deque>

namespace ahaHLSLib {

  template<typename DataType, int depth>
  class fifo {
    std::deque<DataType> data;
    
  public:

    AHAHLS_SYNTH_BUILTIN
    DataType pop() {
      DataType dtp = data.pop_back();
      return dtp;
    }

    AHAHLS_SYNTH_BUILTIN
    void push(DataType& data) {
      data.push_front(data);
    }
    
  };
  
}
