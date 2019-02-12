template<typename T, int depth>
class RAM {
  T elems[depth];
  
public:

  T read(int addr) {
    return elems[addr];
  }

  void write(const int addr, const T value) {
    elems[addr] = value;
  }
};

void single_store(RAM* a) {
  a.write(0, 5);
}
