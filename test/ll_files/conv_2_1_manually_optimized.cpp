#include "gen_classes.h"

void vhls_target(
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1)
{

 // alias the arguments
 hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_input_stencil_update_stream = arg_0;
 hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_output_stencil_stream = arg_1;

// realize stream hw_input.stencil.stream
 hls_stream_PackedStencil_uint16_t_1_2__ _hw_input_stencil_stream;

// Now outputting a linebuffer
 linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_1_2___bnds_8_8 lb;

 for (int i = 0; i < 8*8; i++) {
   lb.lb_write(arg_0.read());
 }

 for (int i = 0; i < 8*7; i++) {
   _hw_input_stencil_stream.write(lb.lb_read());
 }

 for (int i = 0; i < 8*7; i++) {
   auto in_stencil = _hw_input_stencil_stream.read();
   uint16_t a = in_stencil.get(0, 0);
   uint16_t b = in_stencil.get(0, 1);
   uint16_t res = a + b;

   Stencil_uint16_t_1_1_ output;
   output.set(res, 0, 0);
   arg_1.write(output);
 }
 
//  //for (int i = 0; i < 9; i++) {
//  for (int i = 0; i < 10; i++) {
// 		_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
// 	}
//  //for (int i = 0; i < 55; i++) {
//  for (int i = 0; i < 54; i++) {
// 		_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());   
// 		if (_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.has_valid_data()) {
// 			_hw_input_stencil_stream.write(_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_read());
// 		} else {
// 		}

// 	}
// // Steady state for loop to write and read (void)0;
//  // dispatch_stream(_hw_input_stencil_stream, 2, 1, 1, 8, 2, 1, 8, 1, "conv", 0, 0, 8, 0, 8);
//  hls_stream_PackedStencil_uint16_t_1_2__ _hw_input_stencil_stream_to_conv;


//  for (int _dim_1 = 0; _dim_1 <= 6; _dim_1 += 1)
//  for (int _dim_0 = 0; _dim_0 <= 7; _dim_0 += 1)
//  {
//   PackedStencil_uint16_t_1_2_ _tmp_stencil = _hw_input_stencil_stream.read();
//   if (_dim_0 >= 0 && _dim_0 <= 7 && _dim_1 >= 0 && _dim_1 <= 6)
//   {
//    _hw_input_stencil_stream_to_conv.write(_tmp_stencil);
//   }
//  }
// // -- End of dispatch

// // realize stream conv.stencil.stream
//  hls_stream_PackedStencil_int32_t_1_1__ _conv_stencil_stream;

//  // produce conv.stencil.stream
//  for (int _conv_y___scan_dim_1 = 0; _conv_y___scan_dim_1 < 0 + 7; _conv_y___scan_dim_1++)
//  {
//   for (int _conv_x___scan_dim_0 = 0; _conv_x___scan_dim_0 < 0 + 8; _conv_x___scan_dim_0++)
//   {
// // realize stencil or stencil update hw_input.stencil
//    Stencil_uint16_t_1_2_ _hw_input_stencil;

// _hw_input_stencil.set(0, 0, 0, 0);
//    // produce hw_input.stencil
// // reading stream hw_input.stencil.stream
//    _hw_input_stencil.copy(_hw_input_stencil_stream_to_conv.read());

//    // consume hw_input.stencil
// // realize stencil or stencil update conv.stencil
//    Stencil_int32_t_1_1_ _conv_stencil;

// _conv_stencil.set(0, 0, 0, 0);
//    // produce conv.stencil
//    // Providing stencil or stencil update conv.stencil
// _conv_stencil.set(0, 0, 0);
//    ram_int32_t_2 _kernela0;
//    // produce kernel
//    _kernela0.ram_write(0, 0);
//    _kernela0.ram_write(0, 1);
//    _kernela0.ram_write(1, 1);
//    // consume kernel
//    int32_t _290 = _conv_stencil.get(0, 0);
//    int32_t _291 = _kernela0.ram_read(0);
//    uint16_t _292 = _hw_input_stencil.get(0, 0);
//    int32_t _293 = (int32_t)(_292);
//    int32_t _294 = _291 * _293;
//    int32_t _295 = _290 + _294;
//    // Providing stencil or stencil update conv.stencil
// _conv_stencil.set(_295, 0, 0);
//    ram_int32_t_2 _kernela1;
//    // produce kernel
//    _kernela1.ram_write(1, 0);
//    _kernela1.ram_write(0, 1);
//    _kernela1.ram_write(1, 1);
//    // consume kernel
//    int32_t _296 = _conv_stencil.get(0, 0);
//    int32_t _297 = _kernela1.ram_read(1);
//    uint16_t _298 = _hw_input_stencil.get(0, 1);
//    int32_t _299 = (int32_t)(_298);
//    int32_t _300 = _297 * _299;
//    int32_t _301 = _296 + _300;
//    // Providing stencil or stencil update conv.stencil
// _conv_stencil.set(_301, 0, 0);
//    // produce conv.stencil
//    // Normal write stream case
// _conv_stencil_stream.write(_conv_stencil);

//   } // for _conv_x___scan_dim_0
//  } // for _conv_y___scan_dim_1
//  // consume conv.stencil.stream
//  // dispatch_stream(_conv_stencil_stream, 2, 1, 1, 8, 1, 1, 7, 1, "hw_output", 0, 0, 8, 0, 7);
//  hls_stream_PackedStencil_int32_t_1_1__ _conv_stencil_stream_to_hw_output;

//  for (int _dim_1 = 0; _dim_1 <= 6; _dim_1 += 1)
//  for (int _dim_0 = 0; _dim_0 <= 7; _dim_0 += 1)
//  {
//   PackedStencil_int32_t_1_1_ _tmp_stencil = _conv_stencil_stream.read();
//   if (_dim_0 >= 0 && _dim_0 <= 7 && _dim_1 >= 0 && _dim_1 <= 6)
//   {
//    _conv_stencil_stream_to_hw_output.write(_tmp_stencil);
//   }
//  }
// // -- End of dispatch

//  // produce hw_output.stencil.stream
//  for (int _hw_output_y___scan_dim_1 = 0; _hw_output_y___scan_dim_1 < 0 + 7; _hw_output_y___scan_dim_1++)
//  {
//   for (int _hw_output_x___scan_dim_0 = 0; _hw_output_x___scan_dim_0 < 0 + 8; _hw_output_x___scan_dim_0++)
//   {

// // realize stencil or stencil update conv.stencil
//    Stencil_int32_t_1_1_ _conv_stencil;

// _conv_stencil.set(0, 0, 0, 0);
//    // produce conv.stencil
// // reading stream conv.stencil.stream
//    _conv_stencil.copy(_conv_stencil_stream_to_hw_output.read());
//    // consume conv.stencil
// // realize stencil or stencil update hw_output.stencil
//    Stencil_uint16_t_1_1_ _hw_output_stencil;

// _hw_output_stencil.set(0, 0, 0, 0);
//    // produce hw_output.stencil
//    int32_t _302 = _conv_stencil.get(0, 0);
//    uint16_t _303 = (uint16_t)(_302);
//    // Providing stencil or stencil update hw_output.stencil
// _hw_output_stencil.set(_303, 0, 0);
//    // consume hw_output.stencil
//    // Dag output kernel
// AxiPackedStencil_uint16_t_1_1_ _hw_output_stencil_packed = _hw_output_stencil;
//    if (_hw_output_x___scan_dim_0 == 7 && _hw_output_y___scan_dim_1 == 6) {
//     _hw_output_stencil_packed.set_last(1);
//    } else {
//     _hw_output_stencil_packed.set_last(0);
//    }
//    _hw_output_stencil_stream.write(_hw_output_stencil_packed);

//   } // for _hw_output_x___scan_dim_0
//  } // for _hw_output_y___scan_dim_1
} // kernel hls_target_vhls_target


