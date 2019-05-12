class adder {

  input_1 rst;
  
  input_32     input_a;
  input_1     input_a_stb;
  output_1    input_a_ack;

  input_32     input_b;
  input_1     input_b_stb;
  output_1    input_b_ack;

  output_32    output_z;
  output_1    output_z_stb;
  input_1     output_z_ack;


  // call void @builtin_write_port_rst(%builtin_fadd %arg_0, i1 true)
  // call void @builtin_write_port_rst(%builtin_fadd %arg_0, i1 false)
  // call void @builtin_write_port_input_a(%builtin_fadd %arg_0, i32 %arg_1)
  // call void @builtin_write_port_input_a_stb(%builtin_fadd %arg_0, i1 true)
  // %0 = call i1 @builtin_read_port_input_a_ack(%builtin_fadd %arg_0)
  // call void @builtin_stall(i1 %0)
  // call void @builtin_write_port_input_a_stb(%builtin_fadd %arg_0, i1 false)
  // call void @builtin_write_port_input_b(%builtin_fadd %arg_0, i32 %arg_2)
  // call void @builtin_write_port_input_b_stb(%builtin_fadd %arg_0, i1 true)
  // %1 = call i1 @builtin_read_port_input_b_ack(%builtin_fadd %arg_0)
  // call void @builtin_stall(i1 %1)
  // call void @builtin_write_port_input_b_stb(%builtin_fadd %arg_0, i1 false)
  // %2 = call i1 @builtin_read_port_output_z_stb(%builtin_fadd %arg_0)
  // call void @builtin_stall(i1 %2)
  // %3 = call i32 @builtin_read_port_output_z(%builtin_fadd %arg_0)
  // ret i32 %3
  
  bit_32 add(bit_32 a, bit_32 b) {
  rst_1: write_port(rst, 1);
  rst_0: write_port(rst, 0);

    add_constraint(start(rst_1) + 1 == start(rst_0));

    // Input a
  write_a: write_port(input_a, a);
  write_a_stb: write_port(input_a_stb, 1);

    add_constraint(end(rst_0) < start(write_a));
    add_constraint(start(write_a) == start(write_a_stb));

  stall_a_ack: stall(read_port(input_a_ack));

    add_constraint(start(stall_a_ack) == start(write_a));

  write_a_stb_0: write_port(input_a_stb, 0);

    add_constraint(end(stall_a_ack) < start(write_a_stb_0));

    // Input b
  write_b: write_port(input_b, b);
  write_b_stb: write_port(input_b_stb, 1);

    add_constraint(end(stall_a_ack) < start(write_b));

    add_constraint(start(write_b) == start(write_b_stb));

    stall(read_port(input_b_ack));    

    write_port(input_b_stb, 0);

    // Read output
  stall_on_z: stall(read_port(output_z_stb));
    bit_32 sum;
  read_z: sum = read_port(output_z);

    add_constraint(start(stall_on_z) == start(read_z));

    
    return sum;
  }
};

bit_32 fadd_32(adder& fadder, bit_32 a, bit_32 b) {
  return fadder.add(a, b);
}
