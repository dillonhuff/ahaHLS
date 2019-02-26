#include "gen_classes.h"

void stencil_mul_2(
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1) {
  // alias the arguments
  hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_input_stencil_stream = arg_0;
  hls_stream_AxiPackedStencil_uint16_t_1_1__ &_mult_stencil_stream = arg_1;

  // dispatch_stream(_hw_input_stencil_stream, 2, 1, 1, 2, 1, 1, 2, 1, "mult", 1, 0, 2, 0, 2);
  hls_stream_AxiPackedStencil_uint16_t_1_1__ _hw_input_stencil_stream_to_mult;

  for (int _dim_1 = 0; _dim_1 <= 1; _dim_1 += 1)
    for (int _dim_0 = 0; _dim_0 <= 1; _dim_0 += 1)
      {

        AxiPackedStencil_uint16_t_1_1_ _tmp_stencil = _hw_input_stencil_stream.read();
        if (_dim_0 >= 0 && _dim_0 <= 1 && _dim_1 >= 0 && _dim_1 <= 1)
          {
            _hw_input_stencil_stream_to_mult.write(_tmp_stencil);
          }
      }
  // -- End of dispatch

  // produce mult.stencil.stream
  for (int _mult_y___scan_dim_1 = 0; _mult_y___scan_dim_1 < 0 + 2; _mult_y___scan_dim_1++)
    {
      for (int _mult_x___scan_dim_0 = 0; _mult_x___scan_dim_0 < 0 + 2; _mult_x___scan_dim_0++)
        {

          // realize stencil or stencil update hw_input.stencil
          AxiPackedStencil_uint16_t_1_1_ _hw_input_stencil;


          _hw_input_stencil.set(0, 0, 0, 0);
          // produce hw_input.stencil
          // reading stream hw_input.stencil.stream
          _hw_input_stencil = _hw_input_stencil_stream_to_mult.read();

          // consume hw_input.stencil
          // realize stencil or stencil update mult.stencil
          AxiPackedStencil_uint16_t_1_1_ _mult_stencil;

          _mult_stencil.set(0, 0, 0, 0);
          // produce mult.stencil
          uint16_t _277 = _hw_input_stencil.get(0, 0, 0);
          uint16_t _278 = (uint16_t)(2);
          uint16_t _279 = _277 * _278;
          // Providing stencil or stencil update mult.stencil
          _mult_stencil.set(_279, 0, 0);
          // consume mult.stencil
          // Dag output kernel
          AxiPackedStencil_uint16_t_1_1_ _mult_stencil_packed = _mult_stencil;
          if (_mult_x___scan_dim_0 == 1 && _mult_y___scan_dim_1 == 1) {
            _mult_stencil_packed.set_last(1);
          } else {
            _mult_stencil_packed.set_last(0);
          }
          _mult_stencil_stream.write(_mult_stencil_packed);

        } // for _mult_x___scan_dim_0
    } // for _mult_y___scan_dim_1
} // kernel hls_target_vhls_target


