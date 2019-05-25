class int_add {

  input_32 in0;
  input_32 in1;
  output_32 out;

  void add(bit_32& a, bit_32& b, bit_32& c) {
  wa: write_port(in0, a);
  wb: write_port(in1, b);
  ret: c = read_port(out);

    add_constraint(start(wa) == start(wb));
    add_constraint(start(wa) == start(ret));
  }
};


void int_add_func(bit_32& in0, bit_32& in1, bit_32& out) {
  int_add ia;
  ia.add(in0, in1, out);
}
