class ram {

  input_32 wdata;
  input_5 waddr;
  input_1 wen;

  void write(bit_5 addr, bit_32 data) {
  set_wen:
    set_port(wen, 1);
  set_wdata:
    set_port(wdata, data);
  set_waddr:
    set_port(waddr, addr);

    add_constraint(start(set_wen) == start(set_wdata));
    add_constraint(start(set_wen) == start(set_waddr));
    add_constraint(start(set_wdata) + 3 == end(set_waddr));
  }

};
