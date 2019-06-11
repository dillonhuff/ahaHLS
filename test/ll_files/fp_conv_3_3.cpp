#include "gen_classes.h"

void vhls_target(
hls_stream_AxiPackedStencil_float_1_1__ &arg_0,
hls_stream_AxiPackedStencil_uint16_t_1_1__ &arg_1)
{
#pragma HLS DATAFLOW
#pragma HLS INLINE region
#pragma HLS INTERFACE s_axilite port=return bundle=config
#pragma HLS INTERFACE axis register port=arg_0
#pragma HLS INTERFACE axis register port=arg_1

 // alias the arguments
 hls_stream_AxiPackedStencil_float_1_1__ &_hw_input_stencil_update_stream = arg_0;
 hls_stream_AxiPackedStencil_uint16_t_1_1__ &_hw_output_stencil_stream = arg_1;

// realize stream hw_input.stencil.stream
 hls_stream_PackedStencil_float_3_3__ _hw_input_stencil_stream;
#pragma HLS STREAM variable=_hw_input_stencil_stream depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream core=FIFO_SRL

// Now outputting a linebuffer
 linebuffer_hls_stream_AxiPackedStencil_float_1_1___to_hls_stream_PackedStencil_float_3_3___bnds_8_8 _lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream;
	for (int i = 0; i < 64; i++) {
		_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_write(_hw_input_stencil_update_stream.read());
	}
	for (int i = 0; i < 46; i++) {
		_hw_input_stencil_stream.write(_lb__hw_input_stencil_update_stream_to__hw_input_stencil_stream.lb_read());
	}
// Steady state for loop to write and read (void)0;
 // dispatch_stream(_hw_input_stencil_stream, 2, 3, 1, 8, 3, 1, 8, 1, "conv", 0, 0, 8, 0, 8);
 hls_stream_PackedStencil_float_3_3__ _hw_input_stencil_stream_to_conv;
#pragma HLS STREAM variable=_hw_input_stencil_stream_to_conv depth=1
#pragma HLS RESOURCE variable=_hw_input_stencil_stream_to_conv core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 5; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 5; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_float_3_3_ _tmp_stencil = _hw_input_stencil_stream.read();
  if (1)
  {
   _hw_input_stencil_stream_to_conv.write(_tmp_stencil);
  }
 }
// -- End of dispatch
 (void)0;
// realize stream conv.stencil.stream
 hls_stream_PackedStencil_float_1_1__ _conv_stencil_stream;
#pragma HLS STREAM variable=_conv_stencil_stream depth=1
#pragma HLS RESOURCE variable=_conv_stencil_stream core=FIFO_SRL

 // produce conv.stencil.stream
 for (int _conv_y___scan_dim_1 = 0; _conv_y___scan_dim_1 < 0 + 6; _conv_y___scan_dim_1++)
 {
  for (int _conv_x___scan_dim_0 = 0; _conv_x___scan_dim_0 < 0 + 6; _conv_x___scan_dim_0++)
  {
#pragma HLS PIPELINE II=1
// realize stencil or stencil update hw_input.stencil
   Stencil_float_3_3_ _hw_input_stencil;
#pragma HLS ARRAY_PARTITION variable=_hw_input_stencil.value complete dim=0

_hw_input_stencil.set(0, 0, 0, 0);
   // produce hw_input.stencil
// reading stream hw_input.stencil.stream
   _hw_input_stencil.copy(_hw_input_stencil_stream_to_conv.read());
   (void)0;
   // consume hw_input.stencil
// realize stencil or stencil update conv.stencil
   Stencil_float_1_1_ _conv_stencil;
#pragma HLS ARRAY_PARTITION variable=_conv_stencil.value complete dim=0

_conv_stencil.set(0, 0, 0, 0);
   // produce conv.stencil
   float _307 = float_from_bits(0 /* 0 */);
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_307, 0, 0);
   ram_float_9 _kernela0;
   // produce kernel
   float _308 = float_from_bits(0 /* 0 */);
   _kernela0.ram_write(0, _308);
   float _309 = float_from_bits(1093664768 /* 11 */);
   _kernela0.ram_write(0, _309);
   float _310 = float_from_bits(1094713344 /* 12 */);
   _kernela0.ram_write(3, _310);
   float _311 = float_from_bits(1095761920 /* 13 */);
   _kernela0.ram_write(6, _311);
   float _312 = float_from_bits(1096810496 /* 14 */);
   _kernela0.ram_write(1, _312);
   float _313 = float_from_bits(0 /* 0 */);
   _kernela0.ram_write(4, _313);
   float _314 = float_from_bits(1098907648 /* 16 */);
   _kernela0.ram_write(7, _314);
   float _315 = float_from_bits(1099431936 /* 17 */);
   _kernela0.ram_write(2, _315);
   float _316 = float_from_bits(1099956224 /* 18 */);
   _kernela0.ram_write(5, _316);
   float _317 = float_from_bits(1100480512 /* 19 */);
   _kernela0.ram_write(8, _317);
   // consume kernel
   float _318 = _conv_stencil.get(0, 0);
   float _319 = _hw_input_stencil.get(0, 0);
   float _320 = _kernela0.ram_read(0);
   float _321 = _319 * _320;
   float _322 = _318 + _321;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_322, 0, 0);
   ram_float_9 _kernela1;
   // produce kernel
   float _323 = float_from_bits(0 /* 0 */);
   _kernela1.ram_write(1, _323);
   float _324 = float_from_bits(1093664768 /* 11 */);
   _kernela1.ram_write(0, _324);
   float _325 = float_from_bits(1094713344 /* 12 */);
   _kernela1.ram_write(3, _325);
   float _326 = float_from_bits(1095761920 /* 13 */);
   _kernela1.ram_write(6, _326);
   float _327 = float_from_bits(1096810496 /* 14 */);
   _kernela1.ram_write(1, _327);
   float _328 = float_from_bits(0 /* 0 */);
   _kernela1.ram_write(4, _328);
   float _329 = float_from_bits(1098907648 /* 16 */);
   _kernela1.ram_write(7, _329);
   float _330 = float_from_bits(1099431936 /* 17 */);
   _kernela1.ram_write(2, _330);
   float _331 = float_from_bits(1099956224 /* 18 */);
   _kernela1.ram_write(5, _331);
   float _332 = float_from_bits(1100480512 /* 19 */);
   _kernela1.ram_write(8, _332);
   // consume kernel
   float _333 = _conv_stencil.get(0, 0);
   float _334 = _hw_input_stencil.get(1, 0);
   float _335 = _kernela1.ram_read(1);
   float _336 = _334 * _335;
   float _337 = _333 + _336;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_337, 0, 0);
   ram_float_9 _kernela2;
   // produce kernel
   float _338 = float_from_bits(0 /* 0 */);
   _kernela2.ram_write(2, _338);
   float _339 = float_from_bits(1093664768 /* 11 */);
   _kernela2.ram_write(0, _339);
   float _340 = float_from_bits(1094713344 /* 12 */);
   _kernela2.ram_write(3, _340);
   float _341 = float_from_bits(1095761920 /* 13 */);
   _kernela2.ram_write(6, _341);
   float _342 = float_from_bits(1096810496 /* 14 */);
   _kernela2.ram_write(1, _342);
   float _343 = float_from_bits(0 /* 0 */);
   _kernela2.ram_write(4, _343);
   float _344 = float_from_bits(1098907648 /* 16 */);
   _kernela2.ram_write(7, _344);
   float _345 = float_from_bits(1099431936 /* 17 */);
   _kernela2.ram_write(2, _345);
   float _346 = float_from_bits(1099956224 /* 18 */);
   _kernela2.ram_write(5, _346);
   float _347 = float_from_bits(1100480512 /* 19 */);
   _kernela2.ram_write(8, _347);
   // consume kernel
   float _348 = _conv_stencil.get(0, 0);
   float _349 = _hw_input_stencil.get(2, 0);
   float _350 = _kernela2.ram_read(2);
   float _351 = _349 * _350;
   float _352 = _348 + _351;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_352, 0, 0);
   ram_float_9 _kernela3;
   // produce kernel
   float _353 = float_from_bits(0 /* 0 */);
   _kernela3.ram_write(3, _353);
   float _354 = float_from_bits(1093664768 /* 11 */);
   _kernela3.ram_write(0, _354);
   float _355 = float_from_bits(1094713344 /* 12 */);
   _kernela3.ram_write(3, _355);
   float _356 = float_from_bits(1095761920 /* 13 */);
   _kernela3.ram_write(6, _356);
   float _357 = float_from_bits(1096810496 /* 14 */);
   _kernela3.ram_write(1, _357);
   float _358 = float_from_bits(0 /* 0 */);
   _kernela3.ram_write(4, _358);
   float _359 = float_from_bits(1098907648 /* 16 */);
   _kernela3.ram_write(7, _359);
   float _360 = float_from_bits(1099431936 /* 17 */);
   _kernela3.ram_write(2, _360);
   float _361 = float_from_bits(1099956224 /* 18 */);
   _kernela3.ram_write(5, _361);
   float _362 = float_from_bits(1100480512 /* 19 */);
   _kernela3.ram_write(8, _362);
   // consume kernel
   float _363 = _conv_stencil.get(0, 0);
   float _364 = _hw_input_stencil.get(0, 1);
   float _365 = _kernela3.ram_read(3);
   float _366 = _364 * _365;
   float _367 = _363 + _366;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_367, 0, 0);
   ram_float_9 _kernela4;
   // produce kernel
   float _368 = float_from_bits(0 /* 0 */);
   _kernela4.ram_write(4, _368);
   float _369 = float_from_bits(1093664768 /* 11 */);
   _kernela4.ram_write(0, _369);
   float _370 = float_from_bits(1094713344 /* 12 */);
   _kernela4.ram_write(3, _370);
   float _371 = float_from_bits(1095761920 /* 13 */);
   _kernela4.ram_write(6, _371);
   float _372 = float_from_bits(1096810496 /* 14 */);
   _kernela4.ram_write(1, _372);
   float _373 = float_from_bits(0 /* 0 */);
   _kernela4.ram_write(4, _373);
   float _374 = float_from_bits(1098907648 /* 16 */);
   _kernela4.ram_write(7, _374);
   float _375 = float_from_bits(1099431936 /* 17 */);
   _kernela4.ram_write(2, _375);
   float _376 = float_from_bits(1099956224 /* 18 */);
   _kernela4.ram_write(5, _376);
   float _377 = float_from_bits(1100480512 /* 19 */);
   _kernela4.ram_write(8, _377);
   // consume kernel
   float _378 = _conv_stencil.get(0, 0);
   float _379 = _hw_input_stencil.get(1, 1);
   float _380 = _kernela4.ram_read(4);
   float _381 = _379 * _380;
   float _382 = _378 + _381;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_382, 0, 0);
   ram_float_9 _kernela5;
   // produce kernel
   float _383 = float_from_bits(0 /* 0 */);
   _kernela5.ram_write(5, _383);
   float _384 = float_from_bits(1093664768 /* 11 */);
   _kernela5.ram_write(0, _384);
   float _385 = float_from_bits(1094713344 /* 12 */);
   _kernela5.ram_write(3, _385);
   float _386 = float_from_bits(1095761920 /* 13 */);
   _kernela5.ram_write(6, _386);
   float _387 = float_from_bits(1096810496 /* 14 */);
   _kernela5.ram_write(1, _387);
   float _388 = float_from_bits(0 /* 0 */);
   _kernela5.ram_write(4, _388);
   float _389 = float_from_bits(1098907648 /* 16 */);
   _kernela5.ram_write(7, _389);
   float _390 = float_from_bits(1099431936 /* 17 */);
   _kernela5.ram_write(2, _390);
   float _391 = float_from_bits(1099956224 /* 18 */);
   _kernela5.ram_write(5, _391);
   float _392 = float_from_bits(1100480512 /* 19 */);
   _kernela5.ram_write(8, _392);
   // consume kernel
   float _393 = _conv_stencil.get(0, 0);
   float _394 = _hw_input_stencil.get(2, 1);
   float _395 = _kernela5.ram_read(5);
   float _396 = _394 * _395;
   float _397 = _393 + _396;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_397, 0, 0);
   ram_float_9 _kernela6;
   // produce kernel
   float _398 = float_from_bits(0 /* 0 */);
   _kernela6.ram_write(6, _398);
   float _399 = float_from_bits(1093664768 /* 11 */);
   _kernela6.ram_write(0, _399);
   float _400 = float_from_bits(1094713344 /* 12 */);
   _kernela6.ram_write(3, _400);
   float _401 = float_from_bits(1095761920 /* 13 */);
   _kernela6.ram_write(6, _401);
   float _402 = float_from_bits(1096810496 /* 14 */);
   _kernela6.ram_write(1, _402);
   float _403 = float_from_bits(0 /* 0 */);
   _kernela6.ram_write(4, _403);
   float _404 = float_from_bits(1098907648 /* 16 */);
   _kernela6.ram_write(7, _404);
   float _405 = float_from_bits(1099431936 /* 17 */);
   _kernela6.ram_write(2, _405);
   float _406 = float_from_bits(1099956224 /* 18 */);
   _kernela6.ram_write(5, _406);
   float _407 = float_from_bits(1100480512 /* 19 */);
   _kernela6.ram_write(8, _407);
   // consume kernel
   float _408 = _conv_stencil.get(0, 0);
   float _409 = _hw_input_stencil.get(0, 2);
   float _410 = _kernela6.ram_read(6);
   float _411 = _409 * _410;
   float _412 = _408 + _411;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_412, 0, 0);
   ram_float_9 _kernela7;
   // produce kernel
   float _413 = float_from_bits(0 /* 0 */);
   _kernela7.ram_write(7, _413);
   float _414 = float_from_bits(1093664768 /* 11 */);
   _kernela7.ram_write(0, _414);
   float _415 = float_from_bits(1094713344 /* 12 */);
   _kernela7.ram_write(3, _415);
   float _416 = float_from_bits(1095761920 /* 13 */);
   _kernela7.ram_write(6, _416);
   float _417 = float_from_bits(1096810496 /* 14 */);
   _kernela7.ram_write(1, _417);
   float _418 = float_from_bits(0 /* 0 */);
   _kernela7.ram_write(4, _418);
   float _419 = float_from_bits(1098907648 /* 16 */);
   _kernela7.ram_write(7, _419);
   float _420 = float_from_bits(1099431936 /* 17 */);
   _kernela7.ram_write(2, _420);
   float _421 = float_from_bits(1099956224 /* 18 */);
   _kernela7.ram_write(5, _421);
   float _422 = float_from_bits(1100480512 /* 19 */);
   _kernela7.ram_write(8, _422);
   // consume kernel
   float _423 = _conv_stencil.get(0, 0);
   float _424 = _hw_input_stencil.get(1, 2);
   float _425 = _kernela7.ram_read(7);
   float _426 = _424 * _425;
   float _427 = _423 + _426;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_427, 0, 0);
   ram_float_9 _kernela8;
   // produce kernel
   float _428 = float_from_bits(0 /* 0 */);
   _kernela8.ram_write(8, _428);
   float _429 = float_from_bits(1093664768 /* 11 */);
   _kernela8.ram_write(0, _429);
   float _430 = float_from_bits(1094713344 /* 12 */);
   _kernela8.ram_write(3, _430);
   float _431 = float_from_bits(1095761920 /* 13 */);
   _kernela8.ram_write(6, _431);
   float _432 = float_from_bits(1096810496 /* 14 */);
   _kernela8.ram_write(1, _432);
   float _433 = float_from_bits(0 /* 0 */);
   _kernela8.ram_write(4, _433);
   float _434 = float_from_bits(1098907648 /* 16 */);
   _kernela8.ram_write(7, _434);
   float _435 = float_from_bits(1099431936 /* 17 */);
   _kernela8.ram_write(2, _435);
   float _436 = float_from_bits(1099956224 /* 18 */);
   _kernela8.ram_write(5, _436);
   float _437 = float_from_bits(1100480512 /* 19 */);
   _kernela8.ram_write(8, _437);
   // consume kernel
   float _438 = _conv_stencil.get(0, 0);
   float _439 = _hw_input_stencil.get(2, 2);
   float _440 = _kernela8.ram_read(8);
   float _441 = _439 * _440;
   float _442 = _438 + _441;
   // Providing stencil or stencil update conv.stencil
_conv_stencil.set(_442, 0, 0);
   // produce conv.stencil
   // Normal write stream case
_conv_stencil_stream.write(_conv_stencil);
   (void)0;
  } // for _conv_x___scan_dim_0
 } // for _conv_y___scan_dim_1
 // consume conv.stencil.stream
 // dispatch_stream(_conv_stencil_stream, 2, 1, 1, 6, 1, 1, 6, 1, "hw_output", 0, 0, 6, 0, 6);
 hls_stream_PackedStencil_float_1_1__ _conv_stencil_stream_to_hw_output;
#pragma HLS STREAM variable=_conv_stencil_stream_to_hw_output depth=1
#pragma HLS RESOURCE variable=_conv_stencil_stream_to_hw_output core=FIFO_SRL

 for (int _dim_1 = 0; _dim_1 <= 5; _dim_1 += 1)
 for (int _dim_0 = 0; _dim_0 <= 5; _dim_0 += 1)
 {
#pragma HLS PIPELINE
  PackedStencil_float_1_1_ _tmp_stencil = _conv_stencil_stream.read();
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
   Stencil_float_1_1_ _conv_stencil;
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
   float _443 = _conv_stencil.get(0, 0);
   uint16_t _444 = (uint16_t)(_443);
   // Providing stencil or stencil update hw_output.stencil
_hw_output_stencil.set(_444, 0, 0);
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


