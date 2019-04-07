class wire_32 {
  input_32 in_wire;
  output_32 out_wire;
  
public:

  bit_32 read_wire_32() {
    return read_port(in_wire);
  }

  void write_wire_32(bit_32& value) {
    write_port(in_wire, value);
  }

};

class wire_8 {
  input_8 in_wire;
  output_8 out_wire;
  
public:

  bit_8 read_wire_8() {
    return read_port(in_wire);
  }

  void write_wire_8(bit_8& value) {
    write_port(in_wire, value);
  }

};

class median {
  input_32 word0;
  input_32 word1;
  input_32 word2;

  output_8 pixel1;
  output_8 pixel2;
  output_8 pixel3;
  output_8 pixel4;

  input_1 rst_n;
  
public:

  void defaults() {
    write_port(rst_n, 1);
  }

  void run_on_image(wire_32& in_word0,
                    wire_32& in_word1,
                    wire_32& in_word2,

                    wire_8& out_pixel1,
                    wire_8& out_pixel2,
                    wire_8& out_pixel3,
                    wire_8& out_pixel4) {
    write_port(rst_n, 1);
    write_port(rst_n, 0);
    write_port(rst_n, 1);

    write_port(word0, in_word0.read_wire_32());    

    bit_32 i;
    i = 0;
    do {
      //write_port(word0, in_word0.read_wire_32());
      // write_port(word1, in_word1.read_wire_32());
      // write_port(word2, in_word2.read_wire_32());      

      // out_pixel1.write_wire_8(read_port(pixel1));
      // out_pixel2.write_wire_8(read_port(pixel2));
      // out_pixel3.write_wire_8(read_port(pixel3));
      // out_pixel4.write_wire_8(read_port(pixel4));      

      i = i + 1;
    } while (i < 320*320);
  }
};

void run_median_func(median& filter,
                     wire_32& word0,
                     wire_32& word1,
                     wire_32& word2,

                     wire_8& pixel1,
                     wire_8& pixel2,
                     wire_8& pixel3,
                     wire_8& pixel4) {

  // filter.run_on_image(word0, word1, word2,
  //                     pixel1, pixel2, pixel3, pixel4);
}
