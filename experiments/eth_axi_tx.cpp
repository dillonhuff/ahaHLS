class eth_axis_tx {

public:
  input_1 s_eth_hdr_valid;
  output_1 s_eth_hdr_ready;
  input_48 s_eth_dest_mac;
  input_48 s_eth_src_mac;
  input_16 s_eth_type;

  input_8 s_eth_payload_axis_tdata;
  input_1 s_eth_payload_axis_tvalid;
  output_1 s_eth_payload_axis_tready;
  input_1 s_eth_payload_axis_tlast;
  input_1 s_eth_payload_axis_tuser;

  output_1 busy;

  input_1  m_axis_tready;

  void defaults() {
    write_port(s_eth_hdr_valid, 0);
    write_port(s_eth_dest_mac, 0);
    write_port(s_eth_src_mac, 0);
    write_port(s_eth_type, 0);            
    write_port(s_eth_payload_axis_tvalid, 0);
    write_port(s_eth_payload_axis_tdata, 0);    
    write_port(s_eth_payload_axis_tlast, 0);
    write_port(s_eth_payload_axis_tuser, 0);        
  }

  void write_header(bit_48 dest_mac,
                    bit_48 src_mac,
                    bit_16 type) {
  stall_on_ready: stall(read_port(s_eth_hdr_ready));

  write_valid: write_port(s_eth_hdr_valid, 1);
  write_src: write_port(s_eth_dest_mac, dest_mac);
  write_dest: write_port(s_eth_src_mac, src_mac);
  write_type: write_port(s_eth_type, type);

    add_constraint(end(stall_on_ready) < start(write_valid));

    add_constraint(start(write_valid) == start(write_src));
    add_constraint(start(write_valid) == start(write_dest));
    add_constraint(start(write_valid) == start(write_type));
  }

  void write_byte(bit_8 data,
                  bit_1 last) {

  stall_on_ready: stall(read_port(s_eth_payload_axis_tready));
  write_valid: write_port(s_eth_payload_axis_tvalid, 1);
  write_last: write_port(s_eth_payload_axis_tlast, last);
  write_data: write_port(s_eth_payload_axis_tdata, data);

    add_constraint(end(stall_on_ready) < start(write_valid));

    add_constraint(start(write_valid) == start(write_last));
    add_constraint(start(write_valid) == start(write_data));
  }

};

void write_header_func(bit_48 dest_mac,
                       bit_48 src_mac,
                       bit_16 type,
                       eth_axis_tx& transmitter) {
  transmitter.write_header(dest_mac, src_mac, type);
}

void write_byte_func(bit_8 data,
                     bit_1 last,
                     eth_axis_tx& transmitter) {
  transmitter.write_byte(data, last);
}

void write_one_byte_packet(bit_48 dest_mac,
                           bit_48 src_mac,
                           bit_16 type,
                           bit_8 payload,
                           eth_axis_tx& transmitter) {
  transmitter.write_header(dest_mac, src_mac, type);
  transmitter.write_byte(payload, 1);
}

void write_packet(bit_48 dest_mac,
                  bit_48 src_mac,
                  bit_16 type,
                  fifo& payload,
                  sint_32 payload_size,
                  eth_axis_tx& transmitter) {
  transmitter->write_header(dest_mac, src_mac, type);

  sint_32 i;
  for (i = 0; i < payload_size; i = i + 1) {
    bit_1 is_last;
    is_last = i == (payload_size - 1);
    transmitter->write_byte(payload->read(), is_last);
  }
}
