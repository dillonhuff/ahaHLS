struct ip_addrs {
  int source;
  int dest;
};

void count_packets(ip_receiver* packet_stream,
                   counter* packet_count) {
  ip_addrs addrs = packet_stream.get_addrs();
  if ((addrs.source == SRC_ADDR) &&
      (addrs.dest == DEST_ADDR)){
    packet_count.increment();
  }
}
