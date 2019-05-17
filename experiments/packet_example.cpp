class Packet {
  int sport;
  int dport;
  int new_hop;
  int arrival;
  int next_hop;
  int id;
};

void packet_example(Packet& in, Packet& out) {
  out.dport = in.dport;
}
