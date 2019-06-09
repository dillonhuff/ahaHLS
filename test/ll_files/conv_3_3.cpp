#include "gen_classes.h"

void vhls_target(
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_0,
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1)
{
#pragma HLS DATAFLOW
#pragma HLS INLINE region
#pragma HLS INTERFACE s_axilite port=return bundle=config
#pragma HLS INTERFACE axis register port=arg_0
#pragma HLS INTERFACE axis register port=arg_1

 // alias the arguments
 hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_input_stencil_update_stream = arg_0;
 hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_output_stencil_stream = arg_1;

// realize stream hw_input.stencil.stream
 hls_stream_PackedStencil_uint16_t_3_3__ _hw_input_stencil_stream;
#pragma HLS STREAM variable=_hw_input_stencil_stream depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_8_8 _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream;
	for (int i = 0; i < 64; i++) {
		_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
	}
	for (int i = 0; i < 46; i++) {
		_hw_input_stencil_stream.write(_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_hw_input_stencil_stream, 2, 3, 1, 8, 3, 1, 8, 1, "conv", 0, 0, 8, 0, 8);
 hls_stream_PackedStencil_uint16_t_3_3__ _hw_input_stencil_stream_to_conv;
#pragma HLS STREAM variable=_hw_input_stencil_stream_to_conv depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream_to_conv core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 5; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 5; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_uint16_t_3_3_ _tmp_stencil = _hw_input_stencil_stream.read();
  if (1)
  {
   _hw_input_stencil_stream_to_conv.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream conv.stencil.stream
 hls_stream_PackedStencil_int32_t_1_1__ _conv_stencil_stream;
#pragma HLS STREAM variable=_conv_stencil_stream depth=1
#pragma HLS RESOURCE variable=_conv_stencil_stream core=FIFO_SRL

 // produce conv.stencil.stream
 for (int _conv_y___scan_dim_1 = 0; _conv_y___scan_dim_1 < 0 + 6; _conv_y___scan_dim_1++)
 {
  for (int _conv_x___scan_dim_0 = 0; _conv_x___scan_dim_0 < 0 + 6; _conv_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update hw_input.stencil
   Stencil_uint16_t_3_3_ _hw_input_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_input_stencil.value complete dim=0

_hw_input_stencil.set(0, 0, 0, 0);
   // produce hw_input.stencil
// reading stream hw_input.stencil.stream
   _hw_input_stencil.copy(_hw_input_stencil_stream_to_conv.read());
   (void)0;
   // consume hw_input.stencil
// realize stencil or stencil update conv.stencil
   Stencil_int32_t_1_1_ _conv_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv_stencil.value complete dim=0

_conv_stencil.set(0, 0, 0, 0);
   // produce conv.stencil
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(0, 0, 0);
   ram_int32_t_9 _kernela0;
   // produce kernel
   _kernela0.ram_write(0, 0);
   _kernela0.ram_write(0, 11);
   _kernela0.ram_write(3, 12);
   _kernela0.ram_write(6, 13);
   _kernela0.ram_write(1, 14);
   _kernela0.ram_write(4, 0);
   _kernela0.ram_write(7, 16);
   _kernela0.ram_write(2, 17);
   _kernela0.ram_write(5, 18);
   _kernela0.ram_write(8, 19);
   // consume kernel
   int32_t _306 = _conv_stencil.get(0, 0);
   int32_t _307 = _kernela0.ram_read(0);
   uint16_t _308 = _hw_input_stencil.get(0, 0);
   int32_t _309 = (int32_t)(_308);
   int32_t _310 = _307 * _309;
   int32_t _311 = _306 + _310;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_311, 0, 0);
   ram_int32_t_9 _kernela1;
   // produce kernel
   _kernela1.ram_write(1, 0);
   _kernela1.ram_write(0, 11);
   _kernela1.ram_write(3, 12);
   _kernela1.ram_write(6, 13);
   _kernela1.ram_write(1, 14);
   _kernela1.ram_write(4, 0);
   _kernela1.ram_write(7, 16);
   _kernela1.ram_write(2, 17);
   _kernela1.ram_write(5, 18);
   _kernela1.ram_write(8, 19);
   // consume kernel
   int32_t _312 = _conv_stencil.get(0, 0);
   int32_t _313 = _kernela1.ram_read(1);
   uint16_t _314 = _hw_input_stencil.get(1, 0);
   int32_t _315 = (int32_t)(_314);
   int32_t _316 = _313 * _315;
   int32_t _317 = _312 + _316;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_317, 0, 0);
   ram_int32_t_9 _kernela2;
   // produce kernel
   _kernela2.ram_write(2, 0);
   _kernela2.ram_write(0, 11);
   _kernela2.ram_write(3, 12);
   _kernela2.ram_write(6, 13);
   _kernela2.ram_write(1, 14);
   _kernela2.ram_write(4, 0);
   _kernela2.ram_write(7, 16);
   _kernela2.ram_write(2, 17);
   _kernela2.ram_write(5, 18);
   _kernela2.ram_write(8, 19);
   // consume kernel
   int32_t _318 = _conv_stencil.get(0, 0);
   int32_t _319 = _kernela2.ram_read(2);
   uint16_t _320 = _hw_input_stencil.get(2, 0);
   int32_t _321 = (int32_t)(_320);
   int32_t _322 = _319 * _321;
   int32_t _323 = _318 + _322;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_323, 0, 0);
   ram_int32_t_9 _kernela3;
   // produce kernel
   _kernela3.ram_write(3, 0);
   _kernela3.ram_write(0, 11);
   _kernela3.ram_write(3, 12);
   _kernela3.ram_write(6, 13);
   _kernela3.ram_write(1, 14);
   _kernela3.ram_write(4, 0);
   _kernela3.ram_write(7, 16);
   _kernela3.ram_write(2, 17);
   _kernela3.ram_write(5, 18);
   _kernela3.ram_write(8, 19);
   // consume kernel
   int32_t _324 = _conv_stencil.get(0, 0);
   int32_t _325 = _kernela3.ram_read(3);
   uint16_t _326 = _hw_input_stencil.get(0, 1);
   int32_t _327 = (int32_t)(_326);
   int32_t _328 = _325 * _327;
   int32_t _329 = _324 + _328;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_329, 0, 0);
   ram_int32_t_9 _kernela4;
   // produce kernel
   _kernela4.ram_write(4, 0);
   _kernela4.ram_write(0, 11);
   _kernela4.ram_write(3, 12);
   _kernela4.ram_write(6, 13);
   _kernela4.ram_write(1, 14);
   _kernela4.ram_write(4, 0);
   _kernela4.ram_write(7, 16);
   _kernela4.ram_write(2, 17);
   _kernela4.ram_write(5, 18);
   _kernela4.ram_write(8, 19);
   // consume kernel
   int32_t _330 = _conv_stencil.get(0, 0);
   int32_t _331 = _kernela4.ram_read(4);
   uint16_t _332 = _hw_input_stencil.get(1, 1);
   int32_t _333 = (int32_t)(_332);
   int32_t _334 = _331 * _333;
   int32_t _335 = _330 + _334;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_335, 0, 0);
   ram_int32_t_9 _kernela5;
   // produce kernel
   _kernela5.ram_write(5, 0);
   _kernela5.ram_write(0, 11);
   _kernela5.ram_write(3, 12);
   _kernela5.ram_write(6, 13);
   _kernela5.ram_write(1, 14);
   _kernela5.ram_write(4, 0);
   _kernela5.ram_write(7, 16);
   _kernela5.ram_write(2, 17);
   _kernela5.ram_write(5, 18);
   _kernela5.ram_write(8, 19);
   // consume kernel
   int32_t _336 = _conv_stencil.get(0, 0);
   int32_t _337 = _kernela5.ram_read(5);
   uint16_t _338 = _hw_input_stencil.get(2, 1);
   int32_t _339 = (int32_t)(_338);
   int32_t _340 = _337 * _339;
   int32_t _341 = _336 + _340;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_341, 0, 0);
   ram_int32_t_9 _kernela6;
   // produce kernel
   _kernela6.ram_write(6, 0);
   _kernela6.ram_write(0, 11);
   _kernela6.ram_write(3, 12);
   _kernela6.ram_write(6, 13);
   _kernela6.ram_write(1, 14);
   _kernela6.ram_write(4, 0);
   _kernela6.ram_write(7, 16);
   _kernela6.ram_write(2, 17);
   _kernela6.ram_write(5, 18);
   _kernela6.ram_write(8, 19);
   // consume kernel
   int32_t _342 = _conv_stencil.get(0, 0);
   int32_t _343 = _kernela6.ram_read(6);
   uint16_t _344 = _hw_input_stencil.get(0, 2);
   int32_t _345 = (int32_t)(_344);
   int32_t _346 = _343 * _345;
   int32_t _347 = _342 + _346;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_347, 0, 0);
   ram_int32_t_9 _kernela7;
   // produce kernel
   _kernela7.ram_write(7, 0);
   _kernela7.ram_write(0, 11);
   _kernela7.ram_write(3, 12);
   _kernela7.ram_write(6, 13);
   _kernela7.ram_write(1, 14);
   _kernela7.ram_write(4, 0);
   _kernela7.ram_write(7, 16);
   _kernela7.ram_write(2, 17);
   _kernela7.ram_write(5, 18);
   _kernela7.ram_write(8, 19);
   // consume kernel
   int32_t _348 = _conv_stencil.get(0, 0);
   int32_t _349 = _kernela7.ram_read(7);
   uint16_t _350 = _hw_input_stencil.get(1, 2);
   int32_t _351 = (int32_t)(_350);
   int32_t _352 = _349 * _351;
   int32_t _353 = _348 + _352;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_353, 0, 0);
   ram_int32_t_9 _kernela8;
   // produce kernel
   _kernela8.ram_write(8, 0);
   _kernela8.ram_write(0, 11);
   _kernela8.ram_write(3, 12);
   _kernela8.ram_write(6, 13);
   _kernela8.ram_write(1, 14);
   _kernela8.ram_write(4, 0);
   _kernela8.ram_write(7, 16);
   _kernela8.ram_write(2, 17);
   _kernela8.ram_write(5, 18);
   _kernela8.ram_write(8, 19);
   // consume kernel
   int32_t _354 = _conv_stencil.get(0, 0);
   int32_t _355 = _kernela8.ram_read(8);
   uint16_t _356 = _hw_input_stencil.get(2, 2);
   int32_t _357 = (int32_t)(_356);
   int32_t _358 = _355 * _357;
   int32_t _359 = _354 + _358;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_359, 0, 0);
   // produce conv.stencil
   // Normal write stream case
_conv_stencil_stream.write(_conv_stencil);
   (void)0;
  } // for _conv_x___scan_dim_0
 } // for _conv_y___scan_dim_1
 // consume conv.stencil.stream
 // dispatch_stream(_conv_stencil_stream, 2, 1, 1, 6, 1, 1, 6, 1, "hw_output", 0, 0, 6, 0, 6);
 hls_stream_PackedStencil_int32_t_1_1__ _conv_stencil_stream_to_hw_output;
#pragma HLS STREAM variable=_conv_stencil_stream_to_hw_output depth=1
#pragma HLS RESOURCE variable=_conv_stencil_stream_to_hw_output core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 5; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 5; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _conv_stencil_stream.read();
  if (1)
  {
   _conv_stencil_stream_to_hw_output.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
 // produce hw_output.stencil.stream
 for (int _hw_output_y___scan_dim_1 = 0; _hw_output_y___scan_dim_1 < 0 + 6; _hw_output_y___scan_dim_1++)
 {
  for (int _hw_output_x___scan_dim_0 = 0; _hw_output_x___scan_dim_0 < 0 + 6; _hw_output_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update conv.stencil
   Stencil_int32_t_1_1_ _conv_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv_stencil.value complete dim=0

_conv_stencil.set(0, 0, 0, 0);
   // produce conv.stencil
// reading stream conv.stencil.stream
   _conv_stencil.copy(_conv_stencil_stream_to_hw_output.read());
   (void)0;
   // consume conv.stencil
// realize stencil or stencil update hw_output.stencil
   Stencil_uint16_t_1_1_ _hw_output_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_output_stencil.value complete dim=0

_hw_output_stencil.set(0, 0, 0, 0);
   // produce hw_output.stencil
   int32_t _360 = _conv_stencil.get(0, 0);
   uint16_t _361 = (uint16_t)(_360);
   // Providing stencil or stencil update hw_output.stencil
_hw_output_stencil.set(_361, 0, 0);
   // consume hw_output.stencil
   // Dag output kernel
AxiPackedStencil_uint16_t_1_1_ _hw_output_stencil_packed = _hw_output_stencil;
   if (_hw_output_x___scan_dim_0 == 5 && _hw_output_y___scan_dim_1 == 5) {
    _hw_output_stencil_packed.set_last(1);
   } else {
    _hw_output_stencil_packed.set_last(0);
   }
   _hw_output_stencil_stream.write(_hw_output_stencil_packed);
   (void)0;
  } // for _hw_output_x___scan_dim_0
 } // for _hw_output_y___scan_dim_1
} // kernel hls_target_vhls_target


