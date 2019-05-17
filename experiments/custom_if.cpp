void custom_if(bit_32& val, bit_1& c, bit_32& a, bit_32& b) {
  bit_32 v_tmp;
  if (c) {
    v_tmp = a;
  } else {
    v_tmp = b;
  }

  val = v_tmp;
}
