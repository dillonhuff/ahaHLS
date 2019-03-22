class reg_32 {
  input_32 in;
  input_1 en;

  output_32 out;

  bit_32 read() {
    return read_port(out);
  }

  void write(bit_32 data) {
  set_en: set_port(en, 1);
  set_in: set_port(in, data);

    add_constraint(start(set_en) == start(set_in));
  }
};


void store_to_reg(reg_32& reg) {
  reg.write(15);
}

