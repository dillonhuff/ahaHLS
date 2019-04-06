class fifo {
  input_1 read_valid;
  output_1 read_ready;
  input_32 in_data;

  input_1 write_valid;
  output_1 write_ready;
  output_32 out_data;

  void defaults() {
    write_port(read_valid, 0);
    write_port(write_valid, 0);    
  }

  bit_32 read_fifo() {
  stall_ready: stall(read_port(read_ready));
  set_valid: write_port(read_valid, 1);
  ret: return read_port(out_data);

    add_constraint(end(stall_ready) < start(set_valid));
    add_constraint(start(set_valid) == start(ret));
  }

  void write_fifo(bit_32& data) {
  stall_ready: stall(read_port(write_ready));
  set_valid: write_port(write_valid, 1);
  set_data: write_port(in_data, data);
  ret: return;

    add_constraint(end(stall_ready) < start(set_valid));
    add_constraint(start(set_valid) == start(set_data));
    add_constraint(end(set_data) + 1 == start(ret));
  }

};

class axi_ram {

  input_16 s_axi_awaddr;
  input_1 s_axi_awvalid;
  output_1 s_axi_awready;
  input_3 s_axi_awsize;
  input_2 s_axi_awburst;
  input_8 s_axi_awlen;

  input_16 s_axi_araddr;
  input_1 s_axi_arvalid;
  output_1 s_axi_arready;
  input_3 s_axi_arsize;
  input_2 s_axi_arburst;
  input_8 s_axi_arlen;
  
  output_1 s_axi_rvalid;
  input_1 s_axi_rready;
  output_32 s_axi_rdata;

  output_1 s_axi_wready;
  input_1 s_axi_wvalid;
  input_32 s_axi_wdata;
  input_4 s_axi_wstrb;

  input_1 s_axi_bready;

  void defaults() {
    write_port(s_axi_awvalid, 0);
    write_port(s_axi_wvalid, 0);    
    write_port(s_axi_arvalid, 0);
    write_port(s_axi_rready, 0);
    write_port(s_axi_bready, 1);    
  }

  void start_write_burst(bit_3& awsize,
                         bit_2& awburst,
                         bit_8& awlen,
                         bit_16& awaddr) {
    stall(read_port(s_axi_awready));

  set_v: write_port(s_axi_awvalid, 1);
  set_size: write_port(s_axi_awsize, awsize);    
  set_burst: write_port(s_axi_awburst, awburst);
  set_len: write_port(s_axi_awlen, awlen);
  set_addr: write_port(s_axi_awaddr, awaddr);
  set_wv: write_port(s_axi_wvalid, 1);

    add_constraint(start(set_v) == start(set_size));
    add_constraint(start(set_v) == start(set_burst));
    add_constraint(start(set_v) == start(set_len));
    add_constraint(start(set_v) == start(set_addr));
    add_constraint(start(set_v) == start(set_wv));
  }

  bit_32 read_next_beat() {
  stall_valid: stall(read_port(s_axi_rvalid));
  set_ready: write_port(s_axi_rready, 1);

    add_constraint(end(stall_valid) < start(set_ready));

    bit_32 data;
  read_data: data = read_port(s_axi_rdata);
  ret: return data;

    add_constraint(end(set_ready) == start(ret));
    add_constraint(start(read_data) == start(ret));    
  }

  void write_next_beat(bit_32& data, bit_4& strobe) {
  stall_valid_nb: stall(read_port(s_axi_wready));
  set_wvalid_nb: write_port(s_axi_wvalid, 1);

    add_constraint(end(stall_valid_nb) < start(set_wvalid_nb));

  set_data_nb: write_port(s_axi_wdata, data);
  set_strb_nb: write_port(s_axi_wstrb, strobe);

    add_constraint(start(set_wvalid_nb) == start(set_data_nb));
    add_constraint(start(set_wvalid_nb) == start(set_strb_nb));

  ret_nb: return;

    add_constraint(end(set_wvalid_nb) + 1 == start(ret_nb));
  }

  void finish_write_burst() {
  stall_valid_nb: stall(read_port(s_axi_wready));
  set_wvalid_nb: write_port(s_axi_wvalid, 1);

    add_constraint(end(stall_valid_nb) < start(set_wvalid_nb));

  set_data_nb: write_port(s_axi_wdata, 0);
  set_strb_nb: write_port(s_axi_wstrb, 0);

    add_constraint(start(set_wvalid_nb) == start(set_data_nb));
    add_constraint(start(set_wvalid_nb) == start(set_strb_nb));

  ret_nb: return;

    add_constraint(end(set_wvalid_nb) + 1 == start(ret_nb));
  }
  
  void start_read_burst(bit_3& arsize,
                        bit_2& arburst,
                        bit_8& arlen,
                        bit_16& araddr) {
    stall(read_port(s_axi_arready));

  set_v: write_port(s_axi_arvalid, 1);
  set_sz: write_port(s_axi_arsize, arsize);    
  set_burst: write_port(s_axi_arburst, arburst);
  set_arlen: write_port(s_axi_arlen, arlen);
  set_addr: write_port(s_axi_araddr, araddr);

    add_constraint(start(set_v) == start(set_sz));
    add_constraint(start(set_v) == start(set_burst));
    add_constraint(start(set_v) == start(set_arlen));
    add_constraint(start(set_v) == start(set_addr));            
  }
  

};

void axi_burst_multi(fifo& result,
                     axi_ram& ram) {
  ram.start_write_burst(5, 1, 4, 17);
  ram.write_next_beat(1, 31);
  ram.write_next_beat(2, 31);
  ram.write_next_beat(3, 31);
  ram.write_next_beat(4, 31);      
  ram.finish_write_burst();

  // Read the burst back
  ram.start_read_burst(5, 1, 4, 17);
  result.write_fifo(ram.read_next_beat());
  result.write_fifo(ram.read_next_beat());
  result.write_fifo(ram.read_next_beat());
  result.write_fifo(ram.read_next_beat());  
}

void axi_read_burst_func(fifo& result,
                         axi_ram& ram) {

  // Write burst
  ram.start_write_burst(5, 1, 1, 12);
  ram.write_next_beat(34, 31);
  ram.finish_write_burst();

  // Read the burst back
  ram.start_read_burst(5, 1, 1, 12);
  result.write_fifo(ram.read_next_beat());
}

void axi_write_burst(fifo& results,
                     fifo& inputs,
                     bit_8& burst_size,
                     bit_16& start_loc,
                     axi_ram& ram) {
  bit_32 burst_no;
  burst_no = 0;

  ram.start_write_burst(5, 1, burst_size, start_loc);
  do {
    ram.write_next_beat(fifo.read_fifo());
    burst_no = burst_no + 1;
  } while (burst_no < burst_size);
  ram.finish_write_burst();
}
