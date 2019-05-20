bit_32 NUM_FLOWLETS = 8000;
bit_32 THRESHOLD =    5;
bit_32 NUM_HOPS = 10;

class Packet {
  bit_32 sport;
  bit_32 dport;
  bit_32 new_hop;
  bit_32 arrival;
  bit_32 next_hop;
  bit_32 id; // array index
};

bit_32 last_time [NUM_FLOWLETS] = 0;
bit_32 saved_hop [NUM_FLOWLETS] = 0;

bit_32 hash3(bit_32& a, bit_32& b, bit_32& c) {
  return 0;
}

bit_32 hash2(bit_32& a, bit_32& b, bit_32& c) {
  return 0;
}

void flowlet(Packet& in, Packet& out) {
  out.new_hop = hash3(in.sport,
                      in.dport,
                      in.arrival)
                % NUM_HOPS;

  out.id  = hash2(in.sport,
                  in.dport)
            % NUM_FLOWLETS;

  if (in.arrival -
      last_time.at(out.id) >
      THRESHOLD) {
    saved_hop.at(out.id) = out.new_hop;
  }

  last_time.at(out.id) = in.arrival;
  out.next_hop = saved_hop.at(out.id);
}
