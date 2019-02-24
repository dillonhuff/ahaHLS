#define a 0
#define b 1

class axi_reader {
  int addr;
  int data;
  
public:
  void write(const int addr, const int data);
};

class axi_writer {
  int addr;
  int data;
  
public:
  int read(const int addr);
};
//int* __restrict a, int* __restrict b) {
void stalled_single_store_axi(axi_reader* reader,
                              axi_writer* writer) {
  int b0 = reader->read(b); //b[0];
  int r = 0;
  while (r < 20) {
    r += b0;
  }

  writer->write(a, r);
  //a[0] = r;
}
