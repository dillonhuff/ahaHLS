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
    bit<1> is_ready = read_port(s_eth_hdr_ready);
    stall(is_ready);

    write_port(s_eth_hdr_valid, 1);
    write_port(s_eth_hdr_valid, 1);
    write_port(s_eth_hdr_dest_mac, dest_mac);
    write_port(s_eth_hdr_src_mac, src_mac);
    write_port(s_eth_hdr_type, type);
  }

  void write_bytes(bit<8> data,
                   bit<1> last) {
    bit<1> is_ready = read_port(s_eth_hdr_ready);
    stall(is_ready);

    write_port(s_eth_payload_tvalid, 1);
    write_port(s_eth_payload_tlast, last);
    write_port(s_eth_payload_tdata, data);        
  }

};
