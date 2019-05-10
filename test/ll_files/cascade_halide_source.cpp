#include "vhls_target.h"

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

 ram_int32_t_9 _kernela0;
 // produce kernel
 for (int _kernel_s0_y = 0; _kernel_s0_y < 0 + 3; _kernel_s0_y++)
 {
  int32_t _306 = _kernel_s0_y * 3;
  for (int _kernel_s0_x = 0; _kernel_s0_x < 0 + 3; _kernel_s0_x++)
  {
#pragma HLS PIPELINE II=1
   int32_t _307 = _kernel_s0_x + _306;
   _kernela0.ram_write(_307, 0);
  } // for _kernel_s0_x
 } // for _kernel_s0_y
 _kernela0.ram_write(0, 1);
 _kernela0.ram_write(3, 2);
 _kernela0.ram_write(6, 1);
 _kernela0.ram_write(1, 2);
 _kernela0.ram_write(4, 4);
 _kernela0.ram_write(7, 2);
 _kernela0.ram_write(2, 1);
 _kernela0.ram_write(5, 2);
 _kernela0.ram_write(8, 1);
 // consume kernel
// realize stream hw_input.stencil.stream
 hls_stream_PackedStencil_uint16_t_3_3__ _hw_input_stencil_stream;
#pragma HLS STREAM variable=_hw_input_stencil_stream depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
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
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_hw_input_stencil_stream, 2, 3, 1, 16, 3, 1, 16, 1, "conv1", 0, 0, 16, 0, 16);
 hls_stream_PackedStencil_uint16_t_3_3__ _hw_input_stencil_stream_to_conv1;
#pragma HLS STREAM variable=_hw_input_stencil_stream_to_conv1 depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream_to_conv1 core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 13; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 13; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_uint16_t_3_3_ _tmp_stencil = _hw_input_stencil_stream.read();
  if (_dim_0 >= 0 && _dim_0 <= 13 && _dim_1 >= 0 && _dim_1 <= 13)
  {
   _hw_input_stencil_stream_to_conv1.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream conv1.stencil_update.stream
 hls_stream_PackedStencil_int32_t_1_1__ _conv1_stencil_update_stream;
#pragma HLS STREAM variable=_conv1_stencil_update_stream depth=1
#pragma HLS RESOURCE variable=_conv1_stencil_update_stream core=FIFO_SRL

 // produce conv1.stencil_update.stream
 for (int _conv1_y___scan_dim_1 = 0; _conv1_y___scan_dim_1 < 0 + 14; _conv1_y___scan_dim_1++)
 {
  for (int _conv1_x___scan_dim_0 = 0; _conv1_x___scan_dim_0 < 0 + 14; _conv1_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update hw_input.stencil
   Stencil_uint16_t_3_3_ _hw_input_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_input_stencil.value complete dim=0

_hw_input_stencil.set(0, 0, 0, 0);
   // produce hw_input.stencil
// reading stream hw_input.stencil.stream
   _hw_input_stencil.copy(_hw_input_stencil_stream_to_conv1.read());
   (void)0;
   // consume hw_input.stencil
// realize stencil or stencil update conv1.stencil
   Stencil_int32_t_1_1_ _conv1_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv1_stencil.value complete dim=0

_conv1_stencil.set(0, 0, 0, 0);
   // produce conv1.stencil
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(0, 0, 0);
   int32_t _308 = _conv1_stencil.get(0, 0);
   int32_t _309 = _kernela0.ram_read(0);
   uint16_t _310 = _hw_input_stencil.get(0, 0);
   int32_t _311 = (int32_t)(_310);
   int32_t _312 = _309 * _311;
   int32_t _313 = _308 + _312;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_313, 0, 0);
   int32_t _314 = _conv1_stencil.get(0, 0);
   int32_t _315 = _kernela0.ram_read(1);
   uint16_t _316 = _hw_input_stencil.get(1, 0);
   int32_t _317 = (int32_t)(_316);
   int32_t _318 = _315 * _317;
   int32_t _319 = _314 + _318;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_319, 0, 0);
   int32_t _320 = _conv1_stencil.get(0, 0);
   int32_t _321 = _kernela0.ram_read(2);
   uint16_t _322 = _hw_input_stencil.get(2, 0);
   int32_t _323 = (int32_t)(_322);
   int32_t _324 = _321 * _323;
   int32_t _325 = _320 + _324;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_325, 0, 0);
   int32_t _326 = _conv1_stencil.get(0, 0);
   int32_t _327 = _kernela0.ram_read(3);
   uint16_t _328 = _hw_input_stencil.get(0, 1);
   int32_t _329 = (int32_t)(_328);
   int32_t _330 = _327 * _329;
   int32_t _331 = _326 + _330;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_331, 0, 0);
   int32_t _332 = _conv1_stencil.get(0, 0);
   int32_t _333 = _kernela0.ram_read(4);
   uint16_t _334 = _hw_input_stencil.get(1, 1);
   int32_t _335 = (int32_t)(_334);
   int32_t _336 = _333 * _335;
   int32_t _337 = _332 + _336;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_337, 0, 0);
   int32_t _338 = _conv1_stencil.get(0, 0);
   int32_t _339 = _kernela0.ram_read(5);
   uint16_t _340 = _hw_input_stencil.get(2, 1);
   int32_t _341 = (int32_t)(_340);
   int32_t _342 = _339 * _341;
   int32_t _343 = _338 + _342;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_343, 0, 0);
   int32_t _344 = _conv1_stencil.get(0, 0);
   int32_t _345 = _kernela0.ram_read(6);
   uint16_t _346 = _hw_input_stencil.get(0, 2);
   int32_t _347 = (int32_t)(_346);
   int32_t _348 = _345 * _347;
   int32_t _349 = _344 + _348;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_349, 0, 0);
   int32_t _350 = _conv1_stencil.get(0, 0);
   int32_t _351 = _kernela0.ram_read(7);
   uint16_t _352 = _hw_input_stencil.get(1, 2);
   int32_t _353 = (int32_t)(_352);
   int32_t _354 = _351 * _353;
   int32_t _355 = _350 + _354;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_355, 0, 0);
   int32_t _356 = _conv1_stencil.get(0, 0);
   int32_t _357 = _kernela0.ram_read(8);
   uint16_t _358 = _hw_input_stencil.get(2, 2);
   int32_t _359 = (int32_t)(_358);
   int32_t _360 = _357 * _359;
   int32_t _361 = _356 + _360;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_361, 0, 0);
   // produce conv1.stencil
   // Normal write stream case
_conv1_stencil_update_stream.write(_conv1_stencil);
   (void)0;
  } // for _conv1_x___scan_dim_0
 } // for _conv1_y___scan_dim_1
 // consume conv1.stencil_update.stream
// realize stream conv1.stencil.stream
 hls_stream_PackedStencil_int32_t_3_3__ _conv1_stencil_stream;
#pragma HLS STREAM variable=_conv1_stencil_stream depth=1
#pragma HLS RESOURCE variable=_conv1_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_14_14 _lb__conv1_stencil_update_stream_to__conv1_stencil_stream;
	for (int i = 0; i < 31; i++) {
		_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.lb_write(_conv1_stencil_update_stream.read());
	}
	for (int i = 0; i < 165; i++) {
		if (_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.has_valid_data()) {
			_conv1_stencil_stream.write(_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.lb_read());
		} else {
		}
		_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.lb_write(_conv1_stencil_update_stream.read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_conv1_stencil_stream, 2, 3, 1, 14, 3, 1, 14, 1, "conv2", 0, 0, 14, 0, 14);
 hls_stream_PackedStencil_int32_t_3_3__ _conv1_stencil_stream_to_conv2;
#pragma HLS STREAM variable=_conv1_stencil_stream_to_conv2 depth=1
#pragma HLS RESOURCE variable=_conv1_stencil_stream_to_conv2 core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 11; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 11; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _conv1_stencil_stream.read();
  if (_dim_0 >= 0 && _dim_0 <= 11 && _dim_1 >= 0 && _dim_1 <= 11)
  {
   _conv1_stencil_stream_to_conv2.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream conv2.stencil.stream
 hls_stream_PackedStencil_int32_t_1_1__ _conv2_stencil_stream;
#pragma HLS STREAM variable=_conv2_stencil_stream depth=1
#pragma HLS RESOURCE variable=_conv2_stencil_stream core=FIFO_SRL

 // produce conv2.stencil.stream
 for (int _conv2_y___scan_dim_1 = 0; _conv2_y___scan_dim_1 < 0 + 12; _conv2_y___scan_dim_1++)
 {
  for (int _conv2_x___scan_dim_0 = 0; _conv2_x___scan_dim_0 < 0 + 12; _conv2_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update conv1.stencil
   Stencil_int32_t_3_3_ _conv1_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv1_stencil.value complete dim=0

_conv1_stencil.set(0, 0, 0, 0);
   // produce conv1.stencil
// reading stream conv1.stencil.stream
   _conv1_stencil.copy(_conv1_stencil_stream_to_conv2.read());
   (void)0;
   // consume conv1.stencil
// realize stencil or stencil update conv2.stencil
   Stencil_int32_t_1_1_ _conv2_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv2_stencil.value complete dim=0

_conv2_stencil.set(0, 0, 0, 0);
   // produce conv2.stencil
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(0, 0, 0);
   int32_t _362 = _conv2_stencil.get(0, 0);
   int32_t _363 = _conv1_stencil.get(0, 0);
   int32_t _364 = _kernela0.ram_read(0);
   int32_t _365 = _363 * _364;
   int32_t _366 = _362 + _365;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_366, 0, 0);
   int32_t _367 = _conv2_stencil.get(0, 0);
   int32_t _368 = _conv1_stencil.get(1, 0);
   int32_t _369 = _kernela0.ram_read(1);
   int32_t _370 = _368 * _369;
   int32_t _371 = _367 + _370;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_371, 0, 0);
   int32_t _372 = _conv2_stencil.get(0, 0);
   int32_t _373 = _conv1_stencil.get(2, 0);
   int32_t _374 = _kernela0.ram_read(2);
   int32_t _375 = _373 * _374;
   int32_t _376 = _372 + _375;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_376, 0, 0);
   int32_t _377 = _conv2_stencil.get(0, 0);
   int32_t _378 = _conv1_stencil.get(0, 1);
   int32_t _379 = _kernela0.ram_read(3);
   int32_t _380 = _378 * _379;
   int32_t _381 = _377 + _380;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_381, 0, 0);
   int32_t _382 = _conv2_stencil.get(0, 0);
   int32_t _383 = _conv1_stencil.get(1, 1);
   int32_t _384 = _kernela0.ram_read(4);
   int32_t _385 = _383 * _384;
   int32_t _386 = _382 + _385;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_386, 0, 0);
   int32_t _387 = _conv2_stencil.get(0, 0);
   int32_t _388 = _conv1_stencil.get(2, 1);
   int32_t _389 = _kernela0.ram_read(5);
   int32_t _390 = _388 * _389;
   int32_t _391 = _387 + _390;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_391, 0, 0);
   int32_t _392 = _conv2_stencil.get(0, 0);
   int32_t _393 = _conv1_stencil.get(0, 2);
   int32_t _394 = _kernela0.ram_read(6);
   int32_t _395 = _393 * _394;
   int32_t _396 = _392 + _395;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_396, 0, 0);
   int32_t _397 = _conv2_stencil.get(0, 0);
   int32_t _398 = _conv1_stencil.get(1, 2);
   int32_t _399 = _kernela0.ram_read(7);
   int32_t _400 = _398 * _399;
   int32_t _401 = _397 + _400;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_401, 0, 0);
   int32_t _402 = _conv2_stencil.get(0, 0);
   int32_t _403 = _conv1_stencil.get(2, 2);
   int32_t _404 = _kernela0.ram_read(8);
   int32_t _405 = _403 * _404;
   int32_t _406 = _402 + _405;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_406, 0, 0);
   // produce conv2.stencil
   // Normal write stream case
_conv2_stencil_stream.write(_conv2_stencil);
   (void)0;
  } // for _conv2_x___scan_dim_0
 } // for _conv2_y___scan_dim_1
 // consume conv2.stencil.stream
 // dispatch_stream(_conv2_stencil_stream, 2, 1, 1, 12, 1, 1, 12, 1, "hw_output", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int32_t_1_1__ _conv2_stencil_stream_to_hw_output;
#pragma HLS STREAM variable=_conv2_stencil_stream_to_hw_output depth=1
#pragma HLS RESOURCE variable=_conv2_stencil_stream_to_hw_output core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 11; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 11; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _conv2_stencil_stream.read();
  if (_dim_0 >= 0 && _dim_0 <= 11 && _dim_1 >= 0 && _dim_1 <= 11)
  {
   _conv2_stencil_stream_to_hw_output.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
 // produce hw_output.stencil.stream
 for (int _hw_output_y___scan_dim_1 = 0; _hw_output_y___scan_dim_1 < 0 + 12; _hw_output_y___scan_dim_1++)
 {
  for (int _hw_output_x___scan_dim_0 = 0; _hw_output_x___scan_dim_0 < 0 + 12; _hw_output_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update conv2.stencil
   Stencil_int32_t_1_1_ _conv2_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv2_stencil.value complete dim=0

_conv2_stencil.set(0, 0, 0, 0);
   // produce conv2.stencil
// reading stream conv2.stencil.stream
   _conv2_stencil.copy(_conv2_stencil_stream_to_hw_output.read());
   (void)0;
   // consume conv2.stencil
// realize stencil or stencil update hw_output.stencil
   Stencil_uint16_t_1_1_ _hw_output_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_output_stencil.value complete dim=0

_hw_output_stencil.set(0, 0, 0, 0);
   // produce hw_output.stencil
   int32_t _407 = _conv2_stencil.get(0, 0);
   uint16_t _408 = (uint16_t)(_407);
   // Providing stencil or stencil update hw_output.stencil
_hw_output_stencil.set(_408, 0, 0);
   // consume hw_output.stencil
   // Dag output kernel
AxiPackedStencil_uint16_t_1_1_ _hw_output_stencil_packed = _hw_output_stencil;
   if (_hw_output_x___scan_dim_0 == 11 && _hw_output_y___scan_dim_1 == 11) {
    _hw_output_stencil_packed.set_last(1);
   } else {
    _hw_output_stencil_packed.set_last(0);
   }
   _hw_output_stencil_stream.write(_hw_output_stencil_packed);
   (void)0;
  } // for _hw_output_x___scan_dim_0
 } // for _hw_output_y___scan_dim_1
} // kernel hls_target_vhls_target


