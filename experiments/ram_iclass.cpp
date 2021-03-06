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

  hazard(write call0, read call1) {
    implies(call0.addr() == call1.addr(),
            end(call0) <= start(call1));
  }

  hazard(write call0, write call1) {
    implies(call0.addr() == call1.addr(),
            start(call0) < start(call1));
  }

  // hazard(read call0, write call1) {
  //   implies(call0.addr() == call1.addr(),
  //           start(call0) <= start(call1));
  // }
  
  // hazard(read call0, read call1) {
  //   false;
  // }

  void write(bit_5 addr, bit_32& data) {
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

  bit_32 read(bit_5 addr) {
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


void pipelined_independent_writes(RAM& mem) {

  bit_32 index;

  pipeline(1) {
    for (index = 0; index < 5; index = index + 1) {
      mem.write(index, index);
    }
  }
}

void pipelined_structural_hazard(RAM& mem) {

  bit_32 index;

  pipeline(2) {
    for (index = 0; index < 5; index = index + 1) {
      mem.write(2*index, 2*index);
      mem.write(2*index + 1, 2*index + 1);
    }
  }

  return;
}

void pipelined_memory_hazard(RAM& mem) {
  bit_32 index;

  pipeline(2) {
    for (index = 1; index < 10; index = index + 1) {
      bit_32 prev;
      prev = index - 1;

      bit_32 val;
      val = mem.read(prev);
      val = val + 1;
      
      mem.write(index, val);
    }
  }

  return;
}
