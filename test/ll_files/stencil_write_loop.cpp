#include "gen_classes.h"

void stencil_write_loop(hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
                        hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1) {
  // alias the arguments
  hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_input_stencil_stream = arg_0;
  hls_stream_AxiPackedStencil_uint16_t_1_1__ &_mult_stencil_stream = arg_1;

  for (int _dim_1 = 0; _dim_1 <= 1; _dim_1 += 1) {
    for (int _dim_0 = 0; _dim_0 <= 1; _dim_0 += 1)
      {

        AxiPackedStencil_uint16_t_1_1_ _tmp_stencil;
        _tmp_stencil.copy(_hw_input_stencil_stream.read());
        if (_dim_1 >= 0 && _dim_0 <= 1 && _dim_1 >= 0 && _dim_1 <= 1)
          {
        _mult_stencil_stream.write(_tmp_stencil);
            //_hw_input_stencil_stream_to_mult.write(_hw_input_stencil_stream.read());
          }
      }
  }
}


