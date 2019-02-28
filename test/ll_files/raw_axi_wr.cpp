#define a 0
#define b 1

class axi_ram {
  int addr;
  int data;
  
public:
  void write(const int addr, const int data);
  int read(const int addr);  
};

void raw_axi_wr(axi_ram* ram) {
  int b0 = ram->read(b);
  int r = 0;
  while (r < 20) {
    r += b0;
  }

  ram->write(a, r);
}
