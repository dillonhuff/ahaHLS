#include "gen_classes.h"

void cascade_halide_ram_set_loop(
                                 hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
                                 hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1) {

 ram_int32_t_9 _kernela0;

 for (int _kernel_s0_y = 0; _kernel_s0_y < 0 + 3; _kernel_s0_y++) {

   int32_t _306 = _kernel_s0_y * 3;
   for (int _kernel_s0_x = 0; _kernel_s0_x < 0 + 3; _kernel_s0_x++) {

     int32_t _307 = _kernel_s0_x + _306;
     _kernela0.ram_write(_307, 0);
   }
 }

}


