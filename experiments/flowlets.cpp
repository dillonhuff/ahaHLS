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

bit_32[NUM_FLOWLETS] last_time = 0;
bit_32[NUM_FLOWLETS] saved_hop = 0;

bit_32 hash3(bit_32& a, bit_32& b, bit_32& c) {
  return 234;
}

bit_32 hash2(bit_32& a, bit_32& b, bit_32& c) {
  return 19;
}

void flowlet(Packet& in, Packet& out) {
  out.new_hop = hash3(in.sport,
                      in.dport,
                      in.arrival)
                % NUM_HOPS;

  out.id  = hash2(in.sport,
                  in.dport)
            % NUM_FLOWLETS;

  bit_32 last_id;
  last_id = last_time.rd(out.id);
  last_time.wr(out.id, in.arrival);  

  if (in.arrival -
      last_id >
      THRESHOLD) {
    saved_hop.wr(out.id, out.new_hop);
  }


  out.next_hop = saved_hop.rd(out.id);
}
