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

  // write0[0] == write1[0] -> start(write0) < start(write1)
  // write0[0] == read0[0] -> end(write0) <= start(read0)

  // Q: How do you say that reads are independent?
  // A: Really reads cannot start in the same cycle
  // T -> start(read0) != end(read0)

  void write(bit_5& addr, bit_32& data) {
  set_wen:
    set_port(wen_0, 1);
  set_wdata:
    set_port(wdata_0, data);
  set_waddr:
    set_port(waddr_0, addr);

  ret: return;

    add_constraint(start(set_wen) == start(set_wdata));
    add_constraint(start(set_wen) == start(set_waddr));
    add_constraint(start(set_wen) + 3 == end(ret));
  }

  bit_32 read(bit_5& addr) {
  set_addr:
    set_port(raddr_0, addr);

    bit_32 res;

  read_data:
    res = read_port(rdata_0);

    return res;

    add_constraint(end(set_addr) + 1 == start(read_data));
    add_constraint(start(read_data) == start(ret));
  }

};

void filter_ram(RAM& mem) {
  mem.write(10, mem.read(0) + mem.read(1));
}

void independent_writes(RAM& mem) {

  bit_32 index;

  for (index = 0; index < 5; index = index + 1) {
    mem.write(index, index);
  }
}
