class adder_bit_32 {
  input_32 in0;
  input_32 in1;
  output_32 out;

  bit_32 add(bit_32 x, bit_32 y) {
  set_x: set_port(in0, x);
  set_y: set_port(in1, y);

    bit_32 res;
    res = read_port(out);

  ret: return res;

    // This is combinational
    add_constraint(start(set_x) == start(set_y));
    add_constraint(start(set_x) == start(ret));
  }
};

class RAM {

  input_5 debug_addr;
  output_32 debug_data;

  input_5 debug_write_addr;
  input_32 debug_write_data;
  input_1 debug_write_en;  

  input_32 wdata_0;
  input_5 waddr_0;
  input_1 wen_0;

  input_5 raddr_0;
  output_32 rdata_0;

  void write(bit_5 addr, bit_32 data) {
  set_wen:
    set_port(wen_0, 1);
  set_wdata:
    set_port(wdata_0, data);
  set_waddr:
    set_port(waddr_0, addr);

  ret: return;

    add_constraint(start(set_wen) == start(set_wdata));
    add_constraint(start(set_wen) == start(set_waddr));
    add_constraint(start(set_wen) == start(ret));
  }

  bit_32 read(bit_5 addr) {
  set_addr:
    set_port(raddr_0, addr);

    bit_32 res;

  read_data:
    res = read_port(rdata_0);

    add_constraint(end(set_addr) + 1 == start(read_data));
  }

};

class reg_bit_32 {
  input_32 in;
  input_1 en;
  output_32 current;

  bit_32 read_reg() {
    bit_32 val;

  read_port: val = read_port(current);

  ret: return val;

    add_constraint(start(read_port) == start(ret));
  }

  void write_reg(bit_32 val) {
  set_en:set_port(en, 1);
  set_in:set_port(in, val);

  ret: return;

    add_constraint(start(set_en) == start(set_in));
    add_constraint(end(set_en) + 1 == start(ret));
  }
};

class const_bit_32_0 {
  output_32 out;

  bit_32 value_0() {
    return read_port(out);
  }
};

class const_bit_32_1 {
  output_32 out;

  bit_32 value_1() {
    return read_port(out);
  }
};

class const_bit_32_10 {
  output_32 out;

  bit_32 value_10() {
    return read_port(out);
  }
};

void filter_ram(RAM& mem) {
  const_bit_32_0 c0;
  const_bit_32_1 c1;
  const_bit_32_10 c10;

  reg_bit_32 a;
  adder_bit_32 adder;

  a.write_reg(adder.add(mem.read(c0.value_0()), mem.read(c1.value_1())));
  mem.write(c10.value_10(), a.read_reg());
}
