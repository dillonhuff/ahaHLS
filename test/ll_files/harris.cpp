#include "gen_classes.h"

void vhls_target(
hls_stream_AxiPackedStencil_int16_t_1_1__ &arg_0,
hls_stream_AxiPackedStencil_int16_t_1_1__ &arg_1)
{
#pragma HLS DATAFLOW
#pragma HLS INLINE region
#pragma HLS INTERFACE s_axilite port=return bundle=config
#pragma HLS INTERFACE axis register port=arg_0
#pragma HLS INTERFACE axis register port=arg_1

 // alias the arguments
 hls_stream_AxiPackedStencil_int16_t_1_1__ &_hw_output_stencil_stream = arg_0;
 hls_stream_AxiPackedStencil_int16_t_1_1__ &_padded16_stencil_update_stream = arg_1;

// realize stream padded16.stencil.stream
 hls_stream_PackedStencil_int16_t_3_3__ _padded16_stencil_stream;
#pragma HLS STREAM variable=_padded16_stencil_stream depth=1
#pragma HLS RESOURCE variable=_padded16_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_AxiPackedStencil_int16_t_1_1___to_hls_stream_PackedStencil_int16_t_3_3___bnds_14_14 _lb__padded16_stencil_update_stream_to__padded16_stencil_stream;
	for (int i = 0; i < 196; i++) {
		_lb__padded16_stencil_update_stream_to__padded16_stencil_stream.lb_write(_padded16_stencil_update_stream.read());
	}
	for (int i = 0; i < 166; i++) {
		_padded16_stencil_stream.write(_lb__padded16_stencil_update_stream_to__padded16_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_padded16_stencil_stream, 2, 3, 1, 14, 3, 1, 14, 2, "grad_x", 0, 0, 14, 0, 14, "grad_y", 0, 0, 14, 0, 14);
 hls_stream_PackedStencil_int16_t_3_3__ _padded16_stencil_stream_to_grad_x;
#pragma HLS STREAM variable=_padded16_stencil_stream_to_grad_x depth=1
#pragma HLS RESOURCE variable=_padded16_stencil_stream_to_grad_x core=FIFO_SRL

 hls_stream_PackedStencil_int16_t_3_3__ _padded16_stencil_stream_to_grad_y;
#pragma HLS STREAM variable=_padded16_stencil_stream_to_grad_y depth=1
#pragma HLS RESOURCE variable=_padded16_stencil_stream_to_grad_y core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 11; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 11; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int16_t_3_3_ _tmp_stencil = _padded16_stencil_stream.read();
  if (1)
  {
   _padded16_stencil_stream_to_grad_x.write(_tmp_stencil);
  }
  if (1)
  {
   _padded16_stencil_stream_to_grad_y.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream grad_x.stencil.stream
 hls_stream_PackedStencil_int16_t_1_1__ _grad_x_stencil_stream;
#pragma HLS STREAM variable=_grad_x_stencil_stream depth=1
#pragma HLS RESOURCE variable=_grad_x_stencil_stream core=FIFO_SRL

 // produce grad_x.stencil.stream
 for (int _grad_x_y___scan_dim_1 = 0; _grad_x_y___scan_dim_1 < 0 + 12; _grad_x_y___scan_dim_1++)
 {
  for (int _grad_x_x___scan_dim_0 = 0; _grad_x_x___scan_dim_0 < 0 + 12; _grad_x_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update padded16.stencil
   Stencil_int16_t_3_3_ _padded16_stencil;
#pragma HLS ARRAY_PARTITION variable=_padded16_stencil.value complete dim=0

_padded16_stencil.set(0, 0, 0, 0);
   // produce padded16.stencil
// reading stream padded16.stencil.stream
   _padded16_stencil.copy(_padded16_stencil_stream_to_grad_x.read());
   (void)0;
   // consume padded16.stencil
// realize stencil or stencil update grad_x.stencil
   Stencil_int16_t_1_1_ _grad_x_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_x_stencil.value complete dim=0

_grad_x_stencil.set(0, 0, 0, 0);
   // produce grad_x.stencil
   int16_t _299 = _padded16_stencil.get(2, 0);
   int16_t _300 = _padded16_stencil.get(2, 2);
   int16_t _301 = _padded16_stencil.get(2, 1);
   int16_t _302 = (int16_t)(2);
   int16_t _303 = _301 * _302;
   int16_t _304 = _300 + _303;
   int16_t _305 = _299 + _304;
   int16_t _306 = _padded16_stencil.get(0, 0);
   int16_t _307 = _305 - _306;
   int16_t _308 = _padded16_stencil.get(0, 1);
   int16_t _309 = _308 * _302;
   int16_t _310 = _307 - _309;
   int16_t _311 = _padded16_stencil.get(0, 2);
   int16_t _312 = _310 - _311;
   int16_t _313 = (int16_t)(255);
   int16_t _314 = ::halide_cpp_min(_312, _313);
   int16_t _315 = (int16_t)(-255);
   int16_t _316 = ::halide_cpp_max(_314, _315);
   // Providing stencil or stencil update grad_x.stencil
_grad_x_stencil.set(_316, 0, 0);
   // produce grad_x.stencil
   // Normal write stream case
_grad_x_stencil_stream.write(_grad_x_stencil);
   (void)0;
  } // for _grad_x_x___scan_dim_0
 } // for _grad_x_y___scan_dim_1
 // consume grad_x.stencil.stream
 // dispatch_stream(_grad_x_stencil_stream, 2, 1, 1, 12, 1, 1, 12, 2, "lxx", 0, 0, 12, 0, 12, "lxy", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int16_t_1_1__ _grad_x_stencil_stream_to_lxx;
#pragma HLS STREAM variable=_grad_x_stencil_stream_to_lxx depth=1
#pragma HLS RESOURCE variable=_grad_x_stencil_stream_to_lxx core=FIFO_SRL

 hls_stream_PackedStencil_int16_t_1_1__ _grad_x_stencil_stream_to_lxy;
#pragma HLS STREAM variable=_grad_x_stencil_stream_to_lxy depth=1
#pragma HLS RESOURCE variable=_grad_x_stencil_stream_to_lxy core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 11; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 11; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int16_t_1_1_ _tmp_stencil = _grad_x_stencil_stream.read();
  if (1)
  {
   _grad_x_stencil_stream_to_lxx.write(_tmp_stencil);
  }
  if (1)
  {
   _grad_x_stencil_stream_to_lxy.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lxx.stencil_update.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lxx_stencil_update_stream;
#pragma HLS STREAM variable=_lxx_stencil_update_stream depth=1
#pragma HLS RESOURCE variable=_lxx_stencil_update_stream core=FIFO_SRL

 // produce lxx.stencil_update.stream
 for (int _lxx_y___scan_dim_1 = 0; _lxx_y___scan_dim_1 < 0 + 12; _lxx_y___scan_dim_1++)
 {
  for (int _lxx_x___scan_dim_0 = 0; _lxx_x___scan_dim_0 < 0 + 12; _lxx_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update grad_x.stencil
   Stencil_int16_t_1_1_ _grad_x_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_x_stencil.value complete dim=0

_grad_x_stencil.set(0, 0, 0, 0);
   // produce grad_x.stencil
// reading stream grad_x.stencil.stream
   _grad_x_stencil.copy(_grad_x_stencil_stream_to_lxx.read());
   (void)0;
   // consume grad_x.stencil
// realize stencil or stencil update lxx.stencil
   Stencil_int32_t_1_1_ _lxx_stencil;
#pragma HLS ARRAY_PARTITION variable=_lxx_stencil.value complete dim=0

_lxx_stencil.set(0, 0, 0, 0);
   // produce lxx.stencil
   int16_t _317 = _grad_x_stencil.get(0, 0);
   int32_t _318 = (int32_t)(_317);
   int32_t _319 = _318 * _318;
   int32_t _320 = _319 >> 7;
   // Providing stencil or stencil update lxx.stencil
_lxx_stencil.set(_320, 0, 0);
   // produce lxx.stencil
   // Normal write stream case
_lxx_stencil_update_stream.write(_lxx_stencil);
   (void)0;
  } // for _lxx_x___scan_dim_0
 } // for _lxx_y___scan_dim_1
 // consume lxx.stencil_update.stream
// realize stream lxx.stencil.stream
 hls_stream_PackedStencil_int32_t_3_3__ _lxx_stencil_stream;
#pragma HLS STREAM variable=_lxx_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lxx_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_12_12 _lb__lxx_stencil_update_stream_to__lxx_stencil_stream;
	for (int i = 0; i < 144; i++) {
		_lb__lxx_stencil_update_stream_to__lxx_stencil_stream.lb_write(_lxx_stencil_update_stream.read());
	}
	for (int i = 0; i < 118; i++) {
		_lxx_stencil_stream.write(_lb__lxx_stencil_update_stream_to__lxx_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_lxx_stencil_stream, 2, 3, 1, 12, 3, 1, 12, 1, "lgxx", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int32_t_3_3__ _lxx_stencil_stream_to_lgxx;
#pragma HLS STREAM variable=_lxx_stencil_stream_to_lgxx depth=1
#pragma HLS RESOURCE variable=_lxx_stencil_stream_to_lgxx core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _lxx_stencil_stream.read();
  if (1)
  {
   _lxx_stencil_stream_to_lgxx.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lgxx.stencil.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lgxx_stencil_stream;
#pragma HLS STREAM variable=_lgxx_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lgxx_stencil_stream core=FIFO_SRL

 // produce lgxx.stencil.stream
 for (int _lgxx_y___scan_dim_1 = 0; _lgxx_y___scan_dim_1 < 0 + 10; _lgxx_y___scan_dim_1++)
 {
  for (int _lgxx_x___scan_dim_0 = 0; _lgxx_x___scan_dim_0 < 0 + 10; _lgxx_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update lxx.stencil
   Stencil_int32_t_3_3_ _lxx_stencil;
#pragma HLS ARRAY_PARTITION variable=_lxx_stencil.value complete dim=0

_lxx_stencil.set(0, 0, 0, 0);
   // produce lxx.stencil
// reading stream lxx.stencil.stream
   _lxx_stencil.copy(_lxx_stencil_stream_to_lgxx.read());
   (void)0;
   // consume lxx.stencil
// realize stencil or stencil update lgxx.stencil
   Stencil_int32_t_1_1_ _lgxx_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgxx_stencil.value complete dim=0

_lgxx_stencil.set(0, 0, 0, 0);
   // produce lgxx.stencil
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(0, 0, 0);
   int32_t _321 = _lgxx_stencil.get(0, 0);
   int32_t _322 = _lxx_stencil.get(0, 0);
   int32_t _323 = _321 + _322;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_323, 0, 0);
   int32_t _324 = _lgxx_stencil.get(0, 0);
   int32_t _325 = _lxx_stencil.get(1, 0);
   int32_t _326 = _324 + _325;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_326, 0, 0);
   int32_t _327 = _lgxx_stencil.get(0, 0);
   int32_t _328 = _lxx_stencil.get(2, 0);
   int32_t _329 = _327 + _328;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_329, 0, 0);
   int32_t _330 = _lgxx_stencil.get(0, 0);
   int32_t _331 = _lxx_stencil.get(0, 1);
   int32_t _332 = _330 + _331;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_332, 0, 0);
   int32_t _333 = _lgxx_stencil.get(0, 0);
   int32_t _334 = _lxx_stencil.get(1, 1);
   int32_t _335 = _333 + _334;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_335, 0, 0);
   int32_t _336 = _lgxx_stencil.get(0, 0);
   int32_t _337 = _lxx_stencil.get(2, 1);
   int32_t _338 = _336 + _337;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_338, 0, 0);
   int32_t _339 = _lgxx_stencil.get(0, 0);
   int32_t _340 = _lxx_stencil.get(0, 2);
   int32_t _341 = _339 + _340;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_341, 0, 0);
   int32_t _342 = _lgxx_stencil.get(0, 0);
   int32_t _343 = _lxx_stencil.get(1, 2);
   int32_t _344 = _342 + _343;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_344, 0, 0);
   int32_t _345 = _lgxx_stencil.get(0, 0);
   int32_t _346 = _lxx_stencil.get(2, 2);
   int32_t _347 = _345 + _346;
   // Providing stencil or stencil update lgxx.stencil
_lgxx_stencil.set(_347, 0, 0);
   // produce lgxx.stencil
   // Normal write stream case
_lgxx_stencil_stream.write(_lgxx_stencil);
   (void)0;
  } // for _lgxx_x___scan_dim_0
 } // for _lgxx_y___scan_dim_1
 // consume lgxx.stencil.stream
 // dispatch_stream(_lgxx_stencil_stream, 2, 1, 1, 10, 1, 1, 10, 1, "cim", 0, 0, 10, 0, 10);
 hls_stream_PackedStencil_int32_t_1_1__ _lgxx_stencil_stream_to_cim;
#pragma HLS STREAM variable=_lgxx_stencil_stream_to_cim depth=1
#pragma HLS RESOURCE variable=_lgxx_stencil_stream_to_cim core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _lgxx_stencil_stream.read();
  if (1)
  {
   _lgxx_stencil_stream_to_cim.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream grad_y.stencil.stream
 hls_stream_PackedStencil_int16_t_1_1__ _grad_y_stencil_stream;
#pragma HLS STREAM variable=_grad_y_stencil_stream depth=1
#pragma HLS RESOURCE variable=_grad_y_stencil_stream core=FIFO_SRL

 // produce grad_y.stencil.stream
 for (int _grad_y_y___scan_dim_1 = 0; _grad_y_y___scan_dim_1 < 0 + 12; _grad_y_y___scan_dim_1++)
 {
  for (int _grad_y_x___scan_dim_0 = 0; _grad_y_x___scan_dim_0 < 0 + 12; _grad_y_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update padded16.stencil
   Stencil_int16_t_3_3_ _padded16_stencil;
#pragma HLS ARRAY_PARTITION variable=_padded16_stencil.value complete dim=0

_padded16_stencil.set(0, 0, 0, 0);
   // produce padded16.stencil
// reading stream padded16.stencil.stream
   _padded16_stencil.copy(_padded16_stencil_stream_to_grad_y.read());
   (void)0;
   // consume padded16.stencil
// realize stencil or stencil update grad_y.stencil
   Stencil_int16_t_1_1_ _grad_y_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_y_stencil.value complete dim=0

_grad_y_stencil.set(0, 0, 0, 0);
   // produce grad_y.stencil
   int16_t _348 = _padded16_stencil.get(0, 2);
   int16_t _349 = _padded16_stencil.get(2, 2);
   int16_t _350 = _padded16_stencil.get(1, 2);
   int16_t _351 = (int16_t)(2);
   int16_t _352 = _350 * _351;
   int16_t _353 = _349 + _352;
   int16_t _354 = _348 + _353;
   int16_t _355 = _padded16_stencil.get(0, 0);
   int16_t _356 = _354 - _355;
   int16_t _357 = _padded16_stencil.get(1, 0);
   int16_t _358 = _357 * _351;
   int16_t _359 = _356 - _358;
   int16_t _360 = _padded16_stencil.get(2, 0);
   int16_t _361 = _359 - _360;
   int16_t _362 = (int16_t)(255);
   int16_t _363 = ::halide_cpp_min(_361, _362);
   int16_t _364 = (int16_t)(-255);
   int16_t _365 = ::halide_cpp_max(_363, _364);
   // Providing stencil or stencil update grad_y.stencil
_grad_y_stencil.set(_365, 0, 0);
   // produce grad_y.stencil
   // Normal write stream case
_grad_y_stencil_stream.write(_grad_y_stencil);
   (void)0;
  } // for _grad_y_x___scan_dim_0
 } // for _grad_y_y___scan_dim_1
 // consume grad_y.stencil.stream
 // dispatch_stream(_grad_y_stencil_stream, 2, 1, 1, 12, 1, 1, 12, 2, "lxy", 0, 0, 12, 0, 12, "lyy", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int16_t_1_1__ _grad_y_stencil_stream_to_lxy;
#pragma HLS STREAM variable=_grad_y_stencil_stream_to_lxy depth=1
#pragma HLS RESOURCE variable=_grad_y_stencil_stream_to_lxy core=FIFO_SRL

 hls_stream_PackedStencil_int16_t_1_1__ _grad_y_stencil_stream_to_lyy;
#pragma HLS STREAM variable=_grad_y_stencil_stream_to_lyy depth=1
#pragma HLS RESOURCE variable=_grad_y_stencil_stream_to_lyy core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 11; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 11; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int16_t_1_1_ _tmp_stencil = _grad_y_stencil_stream.read();
  if (1)
  {
   _grad_y_stencil_stream_to_lxy.write(_tmp_stencil);
  }
  if (1)
  {
   _grad_y_stencil_stream_to_lyy.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lxy.stencil_update.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lxy_stencil_update_stream;
#pragma HLS STREAM variable=_lxy_stencil_update_stream depth=1
#pragma HLS RESOURCE variable=_lxy_stencil_update_stream core=FIFO_SRL

 // produce lxy.stencil_update.stream
 for (int _lxy_y___scan_dim_1 = 0; _lxy_y___scan_dim_1 < 0 + 12; _lxy_y___scan_dim_1++)
 {
  for (int _lxy_x___scan_dim_0 = 0; _lxy_x___scan_dim_0 < 0 + 12; _lxy_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update grad_y.stencil
   Stencil_int16_t_1_1_ _grad_y_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_y_stencil.value complete dim=0

_grad_y_stencil.set(0, 0, 0, 0);
   // produce grad_y.stencil
// reading stream grad_y.stencil.stream
   _grad_y_stencil.copy(_grad_y_stencil_stream_to_lxy.read());
   (void)0;
   // consume grad_y.stencil
// realize stencil or stencil update grad_x.stencil
   Stencil_int16_t_1_1_ _grad_x_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_x_stencil.value complete dim=0

_grad_x_stencil.set(0, 0, 0, 0);
   // produce grad_x.stencil
// reading stream grad_x.stencil.stream
   _grad_x_stencil.copy(_grad_x_stencil_stream_to_lxy.read());
   (void)0;
   // consume grad_x.stencil
// realize stencil or stencil update lxy.stencil
   Stencil_int32_t_1_1_ _lxy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lxy_stencil.value complete dim=0

_lxy_stencil.set(0, 0, 0, 0);
   // produce lxy.stencil
   int16_t _366 = _grad_x_stencil.get(0, 0);
   int32_t _367 = (int32_t)(_366);
   int16_t _368 = _grad_y_stencil.get(0, 0);
   int32_t _369 = (int32_t)(_368);
   int32_t _370 = _367 * _369;
   int32_t _371 = _370 >> 7;
   // Providing stencil or stencil update lxy.stencil
_lxy_stencil.set(_371, 0, 0);
   // produce lxy.stencil
   // Normal write stream case
_lxy_stencil_update_stream.write(_lxy_stencil);
   (void)0;
  } // for _lxy_x___scan_dim_0
 } // for _lxy_y___scan_dim_1
 // consume lxy.stencil_update.stream
// realize stream lxy.stencil.stream
 hls_stream_PackedStencil_int32_t_3_3__ _lxy_stencil_stream;
#pragma HLS STREAM variable=_lxy_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lxy_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_12_12 _lb__lxy_stencil_update_stream_to__lxy_stencil_stream;
	for (int i = 0; i < 144; i++) {
		_lb__lxy_stencil_update_stream_to__lxy_stencil_stream.lb_write(_lxy_stencil_update_stream.read());
	}
	for (int i = 0; i < 118; i++) {
		_lxy_stencil_stream.write(_lb__lxy_stencil_update_stream_to__lxy_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_lxy_stencil_stream, 2, 3, 1, 12, 3, 1, 12, 1, "lgxy", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int32_t_3_3__ _lxy_stencil_stream_to_lgxy;
#pragma HLS STREAM variable=_lxy_stencil_stream_to_lgxy depth=1
#pragma HLS RESOURCE variable=_lxy_stencil_stream_to_lgxy core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _lxy_stencil_stream.read();
  if (1)
  {
   _lxy_stencil_stream_to_lgxy.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lgxy.stencil.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lgxy_stencil_stream;
#pragma HLS STREAM variable=_lgxy_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lgxy_stencil_stream core=FIFO_SRL

 // produce lgxy.stencil.stream
 for (int _lgxy_y___scan_dim_1 = 0; _lgxy_y___scan_dim_1 < 0 + 10; _lgxy_y___scan_dim_1++)
 {
  for (int _lgxy_x___scan_dim_0 = 0; _lgxy_x___scan_dim_0 < 0 + 10; _lgxy_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update lxy.stencil
   Stencil_int32_t_3_3_ _lxy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lxy_stencil.value complete dim=0

_lxy_stencil.set(0, 0, 0, 0);
   // produce lxy.stencil
// reading stream lxy.stencil.stream
   _lxy_stencil.copy(_lxy_stencil_stream_to_lgxy.read());
   (void)0;
   // consume lxy.stencil
// realize stencil or stencil update lgxy.stencil
   Stencil_int32_t_1_1_ _lgxy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgxy_stencil.value complete dim=0

_lgxy_stencil.set(0, 0, 0, 0);
   // produce lgxy.stencil
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(0, 0, 0);
   int32_t _372 = _lgxy_stencil.get(0, 0);
   int32_t _373 = _lxy_stencil.get(0, 0);
   int32_t _374 = _372 + _373;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_374, 0, 0);
   int32_t _375 = _lgxy_stencil.get(0, 0);
   int32_t _376 = _lxy_stencil.get(1, 0);
   int32_t _377 = _375 + _376;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_377, 0, 0);
   int32_t _378 = _lgxy_stencil.get(0, 0);
   int32_t _379 = _lxy_stencil.get(2, 0);
   int32_t _380 = _378 + _379;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_380, 0, 0);
   int32_t _381 = _lgxy_stencil.get(0, 0);
   int32_t _382 = _lxy_stencil.get(0, 1);
   int32_t _383 = _381 + _382;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_383, 0, 0);
   int32_t _384 = _lgxy_stencil.get(0, 0);
   int32_t _385 = _lxy_stencil.get(1, 1);
   int32_t _386 = _384 + _385;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_386, 0, 0);
   int32_t _387 = _lgxy_stencil.get(0, 0);
   int32_t _388 = _lxy_stencil.get(2, 1);
   int32_t _389 = _387 + _388;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_389, 0, 0);
   int32_t _390 = _lgxy_stencil.get(0, 0);
   int32_t _391 = _lxy_stencil.get(0, 2);
   int32_t _392 = _390 + _391;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_392, 0, 0);
   int32_t _393 = _lgxy_stencil.get(0, 0);
   int32_t _394 = _lxy_stencil.get(1, 2);
   int32_t _395 = _393 + _394;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_395, 0, 0);
   int32_t _396 = _lgxy_stencil.get(0, 0);
   int32_t _397 = _lxy_stencil.get(2, 2);
   int32_t _398 = _396 + _397;
   // Providing stencil or stencil update lgxy.stencil
_lgxy_stencil.set(_398, 0, 0);
   // produce lgxy.stencil
   // Normal write stream case
_lgxy_stencil_stream.write(_lgxy_stencil);
   (void)0;
  } // for _lgxy_x___scan_dim_0
 } // for _lgxy_y___scan_dim_1
 // consume lgxy.stencil.stream
 // dispatch_stream(_lgxy_stencil_stream, 2, 1, 1, 10, 1, 1, 10, 1, "cim", 0, 0, 10, 0, 10);
 hls_stream_PackedStencil_int32_t_1_1__ _lgxy_stencil_stream_to_cim;
#pragma HLS STREAM variable=_lgxy_stencil_stream_to_cim depth=1
#pragma HLS RESOURCE variable=_lgxy_stencil_stream_to_cim core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _lgxy_stencil_stream.read();
  if (1)
  {
   _lgxy_stencil_stream_to_cim.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lyy.stencil_update.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lyy_stencil_update_stream;
#pragma HLS STREAM variable=_lyy_stencil_update_stream depth=1
#pragma HLS RESOURCE variable=_lyy_stencil_update_stream core=FIFO_SRL

 // produce lyy.stencil_update.stream
 for (int _lyy_y___scan_dim_1 = 0; _lyy_y___scan_dim_1 < 0 + 12; _lyy_y___scan_dim_1++)
 {
  for (int _lyy_x___scan_dim_0 = 0; _lyy_x___scan_dim_0 < 0 + 12; _lyy_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update grad_y.stencil
   Stencil_int16_t_1_1_ _grad_y_stencil;
#pragma HLS ARRAY_PARTITION variable=_grad_y_stencil.value complete dim=0

_grad_y_stencil.set(0, 0, 0, 0);
   // produce grad_y.stencil
// reading stream grad_y.stencil.stream
   _grad_y_stencil.copy(_grad_y_stencil_stream_to_lyy.read());
   (void)0;
   // consume grad_y.stencil
// realize stencil or stencil update lyy.stencil
   Stencil_int32_t_1_1_ _lyy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lyy_stencil.value complete dim=0

_lyy_stencil.set(0, 0, 0, 0);
   // produce lyy.stencil
   int16_t _399 = _grad_y_stencil.get(0, 0);
   int32_t _400 = (int32_t)(_399);
   int32_t _401 = _400 * _400;
   int32_t _402 = _401 >> 7;
   // Providing stencil or stencil update lyy.stencil
_lyy_stencil.set(_402, 0, 0);
   // produce lyy.stencil
   // Normal write stream case
_lyy_stencil_update_stream.write(_lyy_stencil);
   (void)0;
  } // for _lyy_x___scan_dim_0
 } // for _lyy_y___scan_dim_1
 // consume lyy.stencil_update.stream
// realize stream lyy.stencil.stream
 hls_stream_PackedStencil_int32_t_3_3__ _lyy_stencil_stream;
#pragma HLS STREAM variable=_lyy_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lyy_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_12_12 _lb__lyy_stencil_update_stream_to__lyy_stencil_stream;
	for (int i = 0; i < 144; i++) {
		_lb__lyy_stencil_update_stream_to__lyy_stencil_stream.lb_write(_lyy_stencil_update_stream.read());
	}
	for (int i = 0; i < 118; i++) {
		_lyy_stencil_stream.write(_lb__lyy_stencil_update_stream_to__lyy_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_lyy_stencil_stream, 2, 3, 1, 12, 3, 1, 12, 1, "lgyy", 0, 0, 12, 0, 12);
 hls_stream_PackedStencil_int32_t_3_3__ _lyy_stencil_stream_to_lgyy;
#pragma HLS STREAM variable=_lyy_stencil_stream_to_lgyy depth=1
#pragma HLS RESOURCE variable=_lyy_stencil_stream_to_lgyy core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _lyy_stencil_stream.read();
  if (1)
  {
   _lyy_stencil_stream_to_lgyy.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream lgyy.stencil.stream
 hls_stream_PackedStencil_int32_t_1_1__ _lgyy_stencil_stream;
#pragma HLS STREAM variable=_lgyy_stencil_stream depth=1
#pragma HLS RESOURCE variable=_lgyy_stencil_stream core=FIFO_SRL

 // produce lgyy.stencil.stream
 for (int _lgyy_y___scan_dim_1 = 0; _lgyy_y___scan_dim_1 < 0 + 10; _lgyy_y___scan_dim_1++)
 {
  for (int _lgyy_x___scan_dim_0 = 0; _lgyy_x___scan_dim_0 < 0 + 10; _lgyy_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update lyy.stencil
   Stencil_int32_t_3_3_ _lyy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lyy_stencil.value complete dim=0

_lyy_stencil.set(0, 0, 0, 0);
   // produce lyy.stencil
// reading stream lyy.stencil.stream
   _lyy_stencil.copy(_lyy_stencil_stream_to_lgyy.read());
   (void)0;
   // consume lyy.stencil
// realize stencil or stencil update lgyy.stencil
   Stencil_int32_t_1_1_ _lgyy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgyy_stencil.value complete dim=0

_lgyy_stencil.set(0, 0, 0, 0);
   // produce lgyy.stencil
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(0, 0, 0);
   int32_t _403 = _lgyy_stencil.get(0, 0);
   int32_t _404 = _lyy_stencil.get(0, 0);
   int32_t _405 = _403 + _404;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_405, 0, 0);
   int32_t _406 = _lgyy_stencil.get(0, 0);
   int32_t _407 = _lyy_stencil.get(1, 0);
   int32_t _408 = _406 + _407;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_408, 0, 0);
   int32_t _409 = _lgyy_stencil.get(0, 0);
   int32_t _410 = _lyy_stencil.get(2, 0);
   int32_t _411 = _409 + _410;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_411, 0, 0);
   int32_t _412 = _lgyy_stencil.get(0, 0);
   int32_t _413 = _lyy_stencil.get(0, 1);
   int32_t _414 = _412 + _413;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_414, 0, 0);
   int32_t _415 = _lgyy_stencil.get(0, 0);
   int32_t _416 = _lyy_stencil.get(1, 1);
   int32_t _417 = _415 + _416;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_417, 0, 0);
   int32_t _418 = _lgyy_stencil.get(0, 0);
   int32_t _419 = _lyy_stencil.get(2, 1);
   int32_t _420 = _418 + _419;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_420, 0, 0);
   int32_t _421 = _lgyy_stencil.get(0, 0);
   int32_t _422 = _lyy_stencil.get(0, 2);
   int32_t _423 = _421 + _422;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_423, 0, 0);
   int32_t _424 = _lgyy_stencil.get(0, 0);
   int32_t _425 = _lyy_stencil.get(1, 2);
   int32_t _426 = _424 + _425;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_426, 0, 0);
   int32_t _427 = _lgyy_stencil.get(0, 0);
   int32_t _428 = _lyy_stencil.get(2, 2);
   int32_t _429 = _427 + _428;
   // Providing stencil or stencil update lgyy.stencil
_lgyy_stencil.set(_429, 0, 0);
   // produce lgyy.stencil
   // Normal write stream case
_lgyy_stencil_stream.write(_lgyy_stencil);
   (void)0;
  } // for _lgyy_x___scan_dim_0
 } // for _lgyy_y___scan_dim_1
 // consume lgyy.stencil.stream
 // dispatch_stream(_lgyy_stencil_stream, 2, 1, 1, 10, 1, 1, 10, 1, "cim", 0, 0, 10, 0, 10);
 hls_stream_PackedStencil_int32_t_1_1__ _lgyy_stencil_stream_to_cim;
#pragma HLS STREAM variable=_lgyy_stencil_stream_to_cim depth=1
#pragma HLS RESOURCE variable=_lgyy_stencil_stream_to_cim core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 9; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 9; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_1_1_ _tmp_stencil = _lgyy_stencil_stream.read();
  if (1)
  {
   _lgyy_stencil_stream_to_cim.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream cim.stencil_update.stream
 hls_stream_PackedStencil_int32_t_1_1__ _cim_stencil_update_stream;
#pragma HLS STREAM variable=_cim_stencil_update_stream depth=1
#pragma HLS RESOURCE variable=_cim_stencil_update_stream core=FIFO_SRL

 // produce cim.stencil_update.stream
 for (int _cim_y___scan_dim_1 = 0; _cim_y___scan_dim_1 < 0 + 10; _cim_y___scan_dim_1++)
 {
  for (int _cim_x___scan_dim_0 = 0; _cim_x___scan_dim_0 < 0 + 10; _cim_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update lgyy.stencil
   Stencil_int32_t_1_1_ _lgyy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgyy_stencil.value complete dim=0

_lgyy_stencil.set(0, 0, 0, 0);
   // produce lgyy.stencil
// reading stream lgyy.stencil.stream
   _lgyy_stencil.copy(_lgyy_stencil_stream_to_cim.read());
   (void)0;
   // consume lgyy.stencil
// realize stencil or stencil update lgxy.stencil
   Stencil_int32_t_1_1_ _lgxy_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgxy_stencil.value complete dim=0

_lgxy_stencil.set(0, 0, 0, 0);
   // produce lgxy.stencil
// reading stream lgxy.stencil.stream
   _lgxy_stencil.copy(_lgxy_stencil_stream_to_cim.read());
   (void)0;
   // consume lgxy.stencil
// realize stencil or stencil update lgxx.stencil
   Stencil_int32_t_1_1_ _lgxx_stencil;
#pragma HLS ARRAY_PARTITION variable=_lgxx_stencil.value complete dim=0

_lgxx_stencil.set(0, 0, 0, 0);
   // produce lgxx.stencil
// reading stream lgxx.stencil.stream
   _lgxx_stencil.copy(_lgxx_stencil_stream_to_cim.read());
   (void)0;
   // consume lgxx.stencil
// realize stencil or stencil update cim.stencil
   Stencil_int32_t_1_1_ _cim_stencil;
#pragma HLS ARRAY_PARTITION variable=_cim_stencil.value complete dim=0

_cim_stencil.set(0, 0, 0, 0);
   // produce cim.stencil
   int32_t _430 = _lgxx_stencil.get(0, 0);
   int32_t _431 = _430 >> 6;
   int32_t _432 = _lgyy_stencil.get(0, 0);
   int32_t _433 = _432 >> 6;
   int32_t _434 = _431 + _433;
   int32_t _435 = _431 * _433;
   int32_t _436 = _lgxy_stencil.get(0, 0);
   int32_t _437 = _436 >> 6;
   int32_t _438 = _437 * _437;
   int32_t _439 = _435 - _438;
   int32_t _440 = _434 * _434;
   int32_t _441 = _440 >> 4;
   int32_t _442 = _439 - _441;
   // Providing stencil or stencil update cim.stencil
_cim_stencil.set(_442, 0, 0);
   // produce cim.stencil
   // Normal write stream case
_cim_stencil_update_stream.write(_cim_stencil);
   (void)0;
  } // for _cim_x___scan_dim_0
 } // for _cim_y___scan_dim_1
 // consume cim.stencil_update.stream
// realize stream cim.stencil.stream
 hls_stream_PackedStencil_int32_t_3_3__ _cim_stencil_stream;
#pragma HLS STREAM variable=_cim_stencil_stream depth=1
#pragma HLS RESOURCE variable=_cim_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_PackedStencil_int32_t_1_1___to_hls_stream_PackedStencil_int32_t_3_3___bnds_10_10 _lb__cim_stencil_update_stream_to__cim_stencil_stream;
	for (int i = 0; i < 100; i++) {
		_lb__cim_stencil_update_stream_to__cim_stencil_stream.lb_write(_cim_stencil_update_stream.read());
	}
	for (int i = 0; i < 78; i++) {
		_cim_stencil_stream.write(_lb__cim_stencil_update_stream_to__cim_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_cim_stencil_stream, 2, 3, 1, 10, 3, 1, 10, 1, "hw_output", 0, 0, 10, 0, 10);
 hls_stream_PackedStencil_int32_t_3_3__ _cim_stencil_stream_to_hw_output;
#pragma HLS STREAM variable=_cim_stencil_stream_to_hw_output depth=1
#pragma HLS RESOURCE variable=_cim_stencil_stream_to_hw_output core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 7; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 7; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_int32_t_3_3_ _tmp_stencil = _cim_stencil_stream.read();
  if (1)
  {
   _cim_stencil_stream_to_hw_output.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
 // produce hw_output.stencil.stream
 for (int _hw_output_y___scan_dim_1 = 0; _hw_output_y___scan_dim_1 < 0 + 8; _hw_output_y___scan_dim_1++)
 {
  for (int _hw_output_x___scan_dim_0 = 0; _hw_output_x___scan_dim_0 < 0 + 8; _hw_output_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update cim.stencil
   Stencil_int32_t_3_3_ _cim_stencil;
#pragma HLS ARRAY_PARTITION variable=_cim_stencil.value complete dim=0

_cim_stencil.set(0, 0, 0, 0);
   // produce cim.stencil
// reading stream cim.stencil.stream
   _cim_stencil.copy(_cim_stencil_stream_to_hw_output.read());
   (void)0;
   // consume cim.stencil
// realize stencil or stencil update hw_output.stencil
   Stencil_int16_t_1_1_ _hw_output_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_output_stencil.value complete dim=0

_hw_output_stencil.set(0, 0, 0, 0);
   // produce hw_output.stencil
   int32_t _443 = _cim_stencil.get(0, 0);
   int32_t _444 = _cim_stencil.get(1, 1);
   bool _445 = _443 < _444;
   int32_t _446 = _cim_stencil.get(1, 0);
   bool _447 = _446 < _444;
   bool _448 = _445 && _447;
   int32_t _449 = _cim_stencil.get(2, 0);
   bool _450 = _449 < _444;
   bool _451 = _448 && _450;
   int32_t _452 = _cim_stencil.get(0, 1);
   bool _453 = _452 < _444;
   bool _454 = _451 && _453;
   int32_t _455 = _cim_stencil.get(2, 1);
   bool _456 = _455 < _444;
   bool _457 = _454 && _456;
   int32_t _458 = _cim_stencil.get(0, 2);
   bool _459 = _458 < _444;
   bool _460 = _457 && _459;
   int32_t _461 = _cim_stencil.get(1, 2);
   bool _462 = _461 < _444;
   bool _463 = _460 && _462;
   int32_t _464 = _cim_stencil.get(2, 2);
   bool _465 = _464 < _444;
   bool _466 = _463 && _465;
   bool _467 = 100 <= _444;
   bool _468 = _466 && _467;
   int32_t _469 = (int32_t)(_468 ? 255 : 0);
   int16_t _470 = (int16_t)(_469);
   // Providing stencil or stencil update hw_output.stencil
_hw_output_stencil.set(_470, 0, 0);
   // consume hw_output.stencil
   // Dag output kernel
AxiPackedStencil_int16_t_1_1_ _hw_output_stencil_packed = _hw_output_stencil;
   if (_hw_output_x___scan_dim_0 == 7 && _hw_output_y___scan_dim_1 == 7) {
    _hw_output_stencil_packed.set_last(1);
   } else {
    _hw_output_stencil_packed.set_last(0);
   }
   _hw_output_stencil_stream.write(_hw_output_stencil_packed);
   (void)0;
  } // for _hw_output_x___scan_dim_0
 } // for _hw_output_y___scan_dim_1
} // kernel hls_target_vhls_target


