class Packet {
  bit_32 sport;
  bit_32 dport;
  bit_32 new_hop;
  bit_32 arrival;
  bit_32 next_hop;
  bit_32 id;
};

void packet_example(Packet& in, Packet& out) {
  out.sport = in.sport;
}

void packet_mixed_assign(Packet& in, Packet& out) {
  out.new_hop = in.next_hop;
}

void flowlets(Packet& in, Packet& out) {
  bit_32 NUM_FLOWLETS;
  NUM_FLOWLETS = 8000;

  bit_32 THRESHOLD;
  THRESHOLD = 5;

  //out.id = hash2(pkt.sport, pkt.dport) % NUM_FLOWLETS;

  if (in.arrival > THRESHOLD) {
    out.next_hop = 0;
  } else {
    out.next_hop = 10;
  }
}
