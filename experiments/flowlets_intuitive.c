int NUM_FLOWLETS = 8000;
int THRESHOLD = 5;
int NUM_HOPS = 10;

struct Packet {
  int sport;
  int dport;
  int new_hop;
  int arrival;
  int next_hop;
  int id; // array index
};

int last_time [NUM_FLOWLETS] = {0};
int saved_hop [NUM_FLOWLETS] = {0};

void flowlet(Packet& pkt, Packet& out) {
  // Compute packet id
  out.id  = hash2(pkt.sport,
                  pkt.dport)
            % NUM_FLOWLETS;

  if (pkt.arrival -
      last_time[pkt.id] >
      THRESHOLD) {
    // Load balance if we exceeded IPG
    out.next_hop = hash3(pkt.sport,
                        pkt.dport,
                        pkt.arrival)
                   % NUM_HOPS;
    // Save load balancing decision
    saved_hop[pkt.id] = pkt.next_hop;
  } else {
    // otherwise, leave it as before
    out.next_hop = saved_hop[pkt.id];
  }

  // Update last_time always
  last_time[pkt.id] = pkt.arrival;
}
