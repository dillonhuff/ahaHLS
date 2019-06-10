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

 ram_int32_t_9 _kernela0;
 // produce kernel
 for (int _kernel_s0_y = 0; _kernel_s0_y < 0 + 3; _kernel_s0_y++)
 {
  int32_t _290 = _kernel_s0_y * 3;
  for (int _kernel_s0_x = 0; _kernel_s0_x < 0 + 3; _kernel_s0_x++)
  {
#pragma HLS PIPELINE II=1
   int32_t _291 = _kernel_s0_x + _290;
   _kernela0.ram_write(_291, 0);
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
 linebuffer_hls_stream_AxiPackedStencil_uint16_t_1_1___to_hls_stream_PackedStencil_uint16_t_3_3___bnds_8_8 _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream;
	for (int i = 0; i < 64; i++) {
		_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
	}
	for (int i = 0; i < 46; i++) {
		_hw_input_stencil_stream.write(_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_hw_input_stencil_stream, 2, 3, 1, 8, 3, 1, 8, 1, "conv1", 0, 0, 8, 0, 8);
 hls_stream_PackedStencil_uint16_t_3_3__ _hw_input_stencil_stream_to_conv1;
#pragma HLS STREAM variable=_hw_input_stencil_stream_to_conv1 depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream_to_conv1 core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 5; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 5; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_uint16_t_3_3_ _tmp_stencil = _hw_input_stencil_stream.read();
  if (1)
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
 for (int _conv1_y___scan_dim_1 = 0; _conv1_y___scan_dim_1 < 0 + 6; _conv1_y___scan_dim_1++)
 {
  for (int _conv1_x___scan_dim_0 = 0; _conv1_x___scan_dim_0 < 0 + 6; _conv1_x___scan_dim_0++)
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
   int32_t _292 = _conv1_stencil.get(0, 0);
   int32_t _293 = _kernela0.ram_read(0);
   uint16_t _294 = _hw_input_stencil.get(0, 0);
   int32_t _295 = (int32_t)(_294);
   int32_t _296 = _293 * _295;
   int32_t _297 = _292 + _296;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_297, 0, 0);
   int32_t _298 = _conv1_stencil.get(0, 0);
   int32_t _299 = _kernela0.ram_read(1);
   uint16_t _300 = _hw_input_stencil.get(1, 0);
   int32_t _301 = (int32_t)(_300);
   int32_t _302 = _299 * _301;
   int32_t _303 = _298 + _302;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_303, 0, 0);
   int32_t _304 = _conv1_stencil.get(0, 0);
   int32_t _305 = _kernela0.ram_read(2);
   uint16_t _306 = _hw_input_stencil.get(2, 0);
   int32_t _307 = (int32_t)(_306);
   int32_t _308 = _305 * _307;
   int32_t _309 = _304 + _308;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_309, 0, 0);
   int32_t _310 = _conv1_stencil.get(0, 0);
   int32_t _311 = _kernela0.ram_read(3);
   uint16_t _312 = _hw_input_stencil.get(0, 1);
   int32_t _313 = (int32_t)(_312);
   int32_t _314 = _311 * _313;
   int32_t _315 = _310 + _314;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_315, 0, 0);
   int32_t _316 = _conv1_stencil.get(0, 0);
   int32_t _317 = _kernela0.ram_read(4);
   uint16_t _318 = _hw_input_stencil.get(1, 1);
   int32_t _319 = (int32_t)(_318);
   int32_t _320 = _317 * _319;
   int32_t _321 = _316 + _320;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_321, 0, 0);
   int32_t _322 = _conv1_stencil.get(0, 0);
   int32_t _323 = _kernela0.ram_read(5);
   uint16_t _324 = _hw_input_stencil.get(2, 1);
   int32_t _325 = (int32_t)(_324);
   int32_t _326 = _323 * _325;
   int32_t _327 = _322 + _326;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_327, 0, 0);
   int32_t _328 = _conv1_stencil.get(0, 0);
   int32_t _329 = _kernela0.ram_read(6);
   uint16_t _330 = _hw_input_stencil.get(0, 2);
   int32_t _331 = (int32_t)(_330);
   int32_t _332 = _329 * _331;
   int32_t _333 = _328 + _332;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_333, 0, 0);
   int32_t _334 = _conv1_stencil.get(0, 0);
   int32_t _335 = _kernela0.ram_read(7);
   uint16_t _336 = _hw_input_stencil.get(1, 2);
   int32_t _337 = (int32_t)(_336);
   int32_t _338 = _335 * _337;
   int32_t _339 = _334 + _338;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_339, 0, 0);
   int32_t _340 = _conv1_stencil.get(0, 0);
   int32_t _341 = _kernela0.ram_read(8);
   uint16_t _342 = _hw_input_stencil.get(2, 2);
   int32_t _343 = (int32_t)(_342);
   int32_t _344 = _341 * _343;
   int32_t _345 = _340 + _344;
   // Providing stencil or stencil update conv1.stencil
_conv1_stencil.set(_345, 0, 0);
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
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_6_6 _lb__conv1_stencil_update_stream_to__conv1_stencil_stream;
	for (int i = 0; i < 36; i++) {
		_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.lb_write(_conv1_stencil_update_stream.read());
	}
	for (int i = 0; i < 22; i++) {
		_conv1_stencil_stream.write(_lb__conv1_stencil_update_stream_to__conv1_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_conv1_stencil_stream, 2, 3, 1, 6, 3, 1, 6, 1, "conv2", 0, 0, 6, 0, 6);
 hls_stream_PackedStencil_int32_t_3_3__ _conv1_stencil_stream_to_conv2;
#pragma HLS STREAM variable=_conv1_stencil_stream_to_conv2 depth=1
#pragma HLS RESOURCE variable=_conv1_stencil_stream_to_conv2 core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 3; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 3; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _conv1_stencil_stream.read();
  if (1)
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
 for (int _conv2_y___scan_dim_1 = 0; _conv2_y___scan_dim_1 < 0 + 4; _conv2_y___scan_dim_1++)
 {
  for (int _conv2_x___scan_dim_0 = 0; _conv2_x___scan_dim_0 < 0 + 4; _conv2_x___scan_dim_0++)
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
   int32_t _346 = _conv2_stencil.get(0, 0);
   int32_t _347 = _conv1_stencil.get(0, 0);
   int32_t _348 = _kernela0.ram_read(0);
   int32_t _349 = _347 * _348;
   int32_t _350 = _346 + _349;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_350, 0, 0);
   int32_t _351 = _conv2_stencil.get(0, 0);
   int32_t _352 = _conv1_stencil.get(1, 0);
   int32_t _353 = _kernela0.ram_read(1);
   int32_t _354 = _352 * _353;
   int32_t _355 = _351 + _354;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_355, 0, 0);
   int32_t _356 = _conv2_stencil.get(0, 0);
   int32_t _357 = _conv1_stencil.get(2, 0);
   int32_t _358 = _kernela0.ram_read(2);
   int32_t _359 = _357 * _358;
   int32_t _360 = _356 + _359;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_360, 0, 0);
   int32_t _361 = _conv2_stencil.get(0, 0);
   int32_t _362 = _conv1_stencil.get(0, 1);
   int32_t _363 = _kernela0.ram_read(3);
   int32_t _364 = _362 * _363;
   int32_t _365 = _361 + _364;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_365, 0, 0);
   int32_t _366 = _conv2_stencil.get(0, 0);
   int32_t _367 = _conv1_stencil.get(1, 1);
   int32_t _368 = _kernela0.ram_read(4);
   int32_t _369 = _367 * _368;
   int32_t _370 = _366 + _369;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_370, 0, 0);
   int32_t _371 = _conv2_stencil.get(0, 0);
   int32_t _372 = _conv1_stencil.get(2, 1);
   int32_t _373 = _kernela0.ram_read(5);
   int32_t _374 = _372 * _373;
   int32_t _375 = _371 + _374;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_375, 0, 0);
   int32_t _376 = _conv2_stencil.get(0, 0);
   int32_t _377 = _conv1_stencil.get(0, 2);
   int32_t _378 = _kernela0.ram_read(6);
   int32_t _379 = _377 * _378;
   int32_t _380 = _376 + _379;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_380, 0, 0);
   int32_t _381 = _conv2_stencil.get(0, 0);
   int32_t _382 = _conv1_stencil.get(1, 2);
   int32_t _383 = _kernela0.ram_read(7);
   int32_t _384 = _382 * _383;
   int32_t _385 = _381 + _384;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_385, 0, 0);
   int32_t _386 = _conv2_stencil.get(0, 0);
   int32_t _387 = _conv1_stencil.get(2, 2);
   int32_t _388 = _kernela0.ram_read(8);
   int32_t _389 = _387 * _388;
   int32_t _390 = _386 + _389;
   // Providing stencil or stencil update conv2.stencil
_conv2_stencil.set(_390, 0, 0);
   // produce conv2.stencil
   // Normal write stream case
_conv2_stencil_stream.write(_conv2_stencil);
   (void)0;
  } // for _conv2_x___scan_dim_0
 } // for _conv2_y___scan_dim_1
 // consume conv2.stencil.stream
 // dispatch_stream(_conv2_stencil_stream, 2, 1, 1, 4, 1, 1, 4, 1, "hw_output", 0, 0, 4, 0, 4);
 hls_stream_PackedStencil_int32_t_1_1__ _conv2_stencil_stream_to_hw_output;
#pragma HLS STREAM variable=_conv2_stencil_stream_to_hw_output depth=1
#pragma HLS RESOURCE variable=_conv2_stencil_stream_to_hw_output core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 3; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 3; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _conv2_stencil_stream.read();
  if (1)
  {
   _conv2_stencil_stream_to_hw_output.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
 // produce hw_output.stencil.stream
 for (int _hw_output_y___scan_dim_1 = 0; _hw_output_y___scan_dim_1 < 0 + 4; _hw_output_y___scan_dim_1++)
 {
  for (int _hw_output_x___scan_dim_0 = 0; _hw_output_x___scan_dim_0 < 0 + 4; _hw_output_x___scan_dim_0++)
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
   int32_t _391 = _conv2_stencil.get(0, 0);
   uint16_t _392 = (uint16_t)(_391);
   // Providing stencil or stencil update hw_output.stencil
_hw_output_stencil.set(_392, 0, 0);
   // consume hw_output.stencil
   // Dag output kernel
AxiPackedStencil_uint16_t_1_1_ _hw_output_stencil_packed = _hw_output_stencil;
   if (_hw_output_x___scan_dim_0 == 3 && _hw_output_y___scan_dim_1 == 3) {
    _hw_output_stencil_packed.set_last(1);
   } else {
    _hw_output_stencil_packed.set_last(0);
   }
   _hw_output_stencil_stream.write(_hw_output_stencil_packed);
   (void)0;
  } // for _hw_output_x___scan_dim_0
 } // for _hw_output_y___scan_dim_1
} // kernel hls_target_vhls_target


