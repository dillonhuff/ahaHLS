class eth_axi_tx {

public:
  input<1> s_eth_hdr_valid;
  output<1> s_eth_hdr_ready;
  input<48> s_eth_dest_mac;
  input<48> s_eth_src_mac;
  input<16> s_eth_type;

  input<8> s_eth_payload_axis_tdata;
  input<1> s_eth_payload_tvalid;
  output<1> s_eth_payload_tready;
  input<1> s_eth_payload_tlast;
  input<1> s_eth_payload_tuser;

  output<1> busy;

  void write_header(bit<48> dest_mac,
                    bit<48> src_mac,
                    bit<16> type) {
  read_ready: bit<1> is_ready = read_port(s_eth_hdr_ready);
  stall_on_ready: stall(is_ready);

    add_constraint(start(read_ready) == start(stall_on_ready));

  write_valid: write_port(s_eth_hdr_valid, 1);
  write_src: write_port(s_eth_hdr_dest_mac, dest_mac);
  write_dest: write_port(s_eth_hdr_src_mac, src_mac);
  write_type: write_port(s_eth_hdr_type, type);

    add_constraint(end(stall_on_ready) < start(write_valid));

    add_constraint(start(write_valid) == start(write_src));
    add_constraint(start(write_valid) == start(write_dest));
    add_constraint(start(write_valid) == start(write_src));
    add_constraint(start(write_valid) == start(write_type));
  }

  void write_byte(bit<8> data,
                  bit<1> last) {
  read_ready: bit<1> is_ready = read_port(s_eth_hdr_ready);
  stall_on_ready: stall(is_ready);

    add_constraint(start(read_ready) == start(stall_on_ready));

  write_valid: write_port(s_eth_payload_tvalid, 1);
  write_last: write_port(s_eth_payload_tlast, last);
  write_data: write_port(s_eth_payload_tdata, data);

    add_constraint(end(stall_on_ready) < start(write_valid));

    add_constraint(start(write_valid) == start(write_last));
    add_constraint(start(write_valid) == start(write_data));
  }

};

void write_packet(bit<48> dest_mac,
                  bit<48> src_mac,
                  bit<16> type,
                  fifo* payload,
                  sint<32> payload_size,
                  eth_axis_tx* transmitter) {
  transmitter->write_header(dest_mac, src_mac, type);
  for (sint<32> i = 0; i < payload_size; i++) {
    bit<1> is_last = i == (payload_size - 1);
    transmitter->write_byte(payload->read(), is_last);
  }
}
