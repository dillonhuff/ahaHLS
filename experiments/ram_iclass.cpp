class ram {

  input<32> wdata;
  input<5> waddr;
  input<1> wen;

  void write(bit<5> addr, bit<32> data) {
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
