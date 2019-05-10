#include "gen_classes.h"

void cascade_halide_first_lb(
                             hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
                             hls_stream_PackedStencil_uint16_t_3_3__ &_hw_input_stencil_stream) {

  // alias the arguments
  hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_input_stencil_update_stream = arg_0;


  linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_16_16 _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream;
  for (int i = 0; i < 35; i++) {
    _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
  }
  for (int i = 0; i < 221; i++) {
    if (_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.has_valid_data()) {
      _hw_input_stencil_stream.write(_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_read());
    } else {
    }
    _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
  }
} // kernel hls_target_vhls_target


