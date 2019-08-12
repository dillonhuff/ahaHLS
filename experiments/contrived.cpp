class HistRAM {

  input_8 debug_addr;
  output_32 debug_data;

  input_8 debug_write_addr;
  input_32 debug_write_data;
  input_1 debug_write_en;  

  input_32 wdata_0;
  input_8 waddr_0;
  input_1 wen_0;

  input_8 raddr_0;
  output_32 rdata_0;

  void defaults() {
    write_port(wen_0, 0);    
  }
  
  void hwrite(bit_8& addr, bit_32& data) {
  set_wen:
    set_port(wen_0, 1);
  set_wdata:
    set_port(wdata_0, data);
  set_waddr:
    set_port(waddr_0, addr);

  ret: return;

    add_constraint(start(set_wen) == start(set_wdata));
    add_constraint(start(set_wen) == start(set_waddr));
    add_constraint(start(set_wen) + 1 == end(ret));
  }

  bit_32 hread(bit_8& addr) {
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

void can_pipeline(HistRAM& a) {
  bit_32 i;
  bit_32 r;
  i = 0;
  do {
    r = a.hread(i) + 1;
    a.hwrite(i + 1, r);
    i = i + 1;
  } while (i < 10);

}
