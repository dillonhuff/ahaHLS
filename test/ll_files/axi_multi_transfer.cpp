#define a 0
#define b 5

class axi_ram {
  int addr;
  int data;
  
public:
  void write(const int addr, const int data);
  int read(const int addr);  
};

void axi_multi_transfer(axi_ram* ram) {
  for (int i = 0; i < 5; i++) {
    int val = ram->read(a + i) + 34;
    ram->write(b + i, val);
  }
}
