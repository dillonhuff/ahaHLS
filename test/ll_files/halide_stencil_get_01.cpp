#include "gen_classes.h"

void vhls_target( hls_stream_AxiPackedStencil_uint16_t_1_2__ &arg_0, hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1) {
  PackedStencil_uint16_t_1_2_ input = arg_0.read();

  PackedStencil_uint16_t_1_1_ output;
  output.set(input.get(0, 1), 0, 0);
  arg_1.write(output);
}


