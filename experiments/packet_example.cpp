class Packet {
  bit_32 sport;
  bit_32 dport;
  bit_32 new_hop;
  bit_32 arrival;
  bit_32 next_hop;
  bit_32 id;
};

void packet_example(Packet& in, Packet& out) {
  out.dport = in.dport;
}
