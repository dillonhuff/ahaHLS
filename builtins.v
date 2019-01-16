`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module load();
endmodule // load

module store();
endmodule // store

module ne(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 != in1;
endmodule

module sext(input [31:0]  in, output [63:0] out);
   
   assign out = {32'b0, in};
endmodule

module add(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 + in1;
endmodule

module sub(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 - in1;
endmodule

module mul(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 * in1;
endmodule

module getelementptr_1(input [31:0]  base_addr, input [31:0] in1, output [31:0] out);
   assign out = base_addr + in1;
endmodule

module getelementptr_2(input [31:0]  base_addr, input [31:0] in1, input [31:0] in2, output [31:0] out);
   assign out = base_addr + in1 + in2;
endmodule

module eq(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 == in1;
endmodule

module sgt(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   assign out = $signed(in0) > $signed(in1);
endmodule

module slt(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = $signed(in0) < $signed(in1);
endmodule

module ult(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = $unsigned(in0) < $unsigned(in1);
endmodule

module ret();
endmodule

// module phi_2(input [31:0] last_block,
//              input [31:0] s0,
//              input [31:0] s1,             
//              input [31:0] in0,
//              input [31:0] in1,
//              output [31:0] out);

//    reg [31:0]              out_reg;
   

//     always @(*) begin
//        //$display("In phi: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
//       if (last_block == s0) begin
//          out_reg = in0;
//       end else if (last_block == s1) begin
//          out_reg = in1;
//       end else begin
//          $display("Error: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
//       end

      
//       // else begin
//       //    $display("Error: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
//       //    $finish();
//       // end

//    end

//    assign out = out_reg;
   
   
// endmodule

// module phi_3(input [31:0] last_block,
//              input [31:0]  s0,
//              input [31:0]  s1,
//              input [31:0]  s2, 
//              input [31:0]  in0,
//              input [31:0]  in1,
//              input [31:0]  in2,             
//              output [31:0] out);

//    reg [31:0]              out_reg;
   

//     always @(*) begin

//       if (last_block == s0) begin
//          out_reg = in0;
//       end else if (last_block == s1) begin
//          out_reg = in1;
//       end else if (last_block == s2) begin
//          out_reg = in2;
//       end else begin
//          $display("Error: last_block == %d, but s0 == %d, and s1 == %d, and s2== %d", last_block, s0, s1, s2);
//       end

//    end

//    assign out = out_reg;
   
   
// endmodule

module br_dummy();
endmodule

module select(input sel, input [WIDTH - 1:0] in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = sel ? in1 : in0;
endmodule


module axi_write_handler(input clk,
                         input                           rst,

                         // User facing API
                         input [DATA_WIDTH - 1 : 0]      write_data,
                         input [ADDR_WIDTH - 1 : 0]      write_addr,
                         input                           start_write,

                         output                          ready,
                         output                          valid,

                         // AXI module API
                         output reg                      s_axil_awvalid,
                         output reg                      s_axil_wvalid,

                         output reg [DATA_WIDTH - 1 : 0] s_axil_wdata,
                         output reg [ADDR_WIDTH - 1 : 0] s_axil_awaddr,

                         input                           s_axil_bvalid,
                         input [1:0]                     s_axil_bresp,

                         output [STRB_WIDTH-1:0]         s_axil_wstrb,
                         output                          s_axil_bready
                        );

   parameter DATA_WIDTH = 32;
   parameter ADDR_WIDTH = 5;
   parameter STRB_WIDTH = (DATA_WIDTH/8);

   reg                         ready_reg;
   reg                         valid_reg;
   
   assign ready = ready_reg;
   assign valid = valid_reg;
   
   assign s_axil_bready = 1'b1;
   assign s_axil_wstrb = 5'b11111;
   
   always @(posedge clk) begin
      if (rst) begin
         ready_reg <= 1;
         valid_reg <= 0;

         s_axil_wvalid <= 0;
         s_axil_awvalid <= 0;

         $display("Reset");
         
      end else if (start_write) begin

         s_axil_wvalid <= 1;
         s_axil_awvalid <= 1;

         s_axil_wdata <= write_data;
         s_axil_awaddr <= {write_addr, 2'b0};

         ready_reg <= 0;
         valid_reg <= 0;

      end else if (s_axil_bvalid && (!s_axil_bresp)) begin
         $display("s_axil_bvalid = %d", s_axil_bvalid);
         
         ready_reg <= 1;
         valid_reg <= 1;

         s_axil_wvalid <= 0;
         s_axil_awvalid <= 0;
      end
   end

endmodule // axi_write_handler

module axi_read_handler(input clk,
                        input                           rst,

                        // User facing API
                        output reg [DATA_WIDTH - 1 : 0] read_data,
                        input [ADDR_WIDTH - 1 : 0]      read_addr,
                        input                           start_read,

                        output reg                      ready,
                        output reg                      valid,
                        
                        // AXI facing API
                        output reg                      s_axil_rready,
                        output reg                      s_axil_arvalid,
                        output reg [ADDR_WIDTH - 1 : 0] s_axil_araddr,

                        input                           s_axil_rvalid,
                        input [1:0]                     s_axil_rresp,
                        input                           s_axil_arready,
                        input [DATA_WIDTH - 1 : 0]      s_axil_rdata);
   
   parameter DATA_WIDTH = 32;
   parameter ADDR_WIDTH = 5;
   parameter STRB_WIDTH = (DATA_WIDTH/8);

   always @(posedge clk) begin
      $display("&&&&&&");
      $display("s_axil_rvalid   === %d", s_axil_rvalid);
      $display("s_axil_rresp    === %d", s_axil_rresp);
      $display("s_axil_arready  === %d", s_axil_arready);      
      $display("======");

      if (rst) begin
         ready <= 1;
         valid <= 0;
         s_axil_arvalid <= 0;
         s_axil_rready <= 0;
         
      end else if (start_read) begin
         valid <= 0;
         ready <= 0;

         s_axil_rready <= 1;
         s_axil_arvalid <= 1;
         s_axil_araddr <= {read_addr, 2'b0};
         
      end else if (s_axil_arready && s_axil_rvalid && (s_axil_rresp == 0)) begin
         $display("Setting read output valid, data = %d", s_axil_rdata);
         
         read_data <= s_axil_rdata;
         valid <= 1;
      end else begin
         valid <= 0;
         s_axil_arvalid <= 0;
      end
   end

endmodule // axi_read_handler

module axi_stall_manager(input clk,
                         input  rst,
                         
                         input  start_read,
                         input  start_write,

                         input  read_finished,
                         input  write_finished,

                         output should_stall);

   reg                          reading;
   reg                          writing;

   always @(posedge clk) begin
      if (rst) begin
         reading <= 0;
         writing <= 0;
      end else begin

         $display("start write  = %d", start_write);
         $display("writing      = %d", writing);         
         $display("should stall = %d", should_stall);         
         if (start_read) begin
            reading <= 1;
         end

         if (start_write) begin
            $display("writing...");
            writing <= 1;
         end

         if (read_finished) begin
            reading <= 0;
         end
         
         if (write_finished) begin
            $display("write finished");

            writing <= 0;
         end

      end
   end // always @ (posedge clk)

   assign should_stall = reading | writing;
   
endmodule // axi_stall_manager

module register(input clk, input rst, input [31:0] raddr, input [31:0] waddr, input wen, input ren, input [31:0] wdata, output [31:0] rdata);

   reg [31:0] data;

   always @(posedge clk) begin
      if (wen) begin
         data <= wdata;
         //$display("writing %d to register", wdata);
      end

      //$display("on clock data = %d", data);      
   end
   
   assign rdata = data;
   
endmodule

module fifo(input clk,
            input                  rst,

            input                  read_valid,
            output                 read_ready,

            input                  write_valid,
            output                 write_ready,
            
            input [WIDTH - 1 : 0]  in_data,
            output [WIDTH - 1 : 0] out_data);
   
   parameter WIDTH = 32;
   parameter DEPTH = 16;

   reg [WIDTH - 1 : 0]               ram [DEPTH - 1 : 0];

   reg                               empty;

   reg [$clog2(DEPTH) - 1 : 0]                write_addr;
   reg [$clog2(DEPTH) - 1 : 0]                read_addr;
   wire [$clog2(DEPTH) - 1 : 0]                next_read_addr;
   wire [$clog2(DEPTH) - 1 : 0]                next_write_addr;

   always @(posedge clk) begin
      if (!rst) begin
         if (write_valid) begin
            `assert(write_ready, 1'd1)

            ram[write_addr] <= in_data;
            write_addr <= next_write_addr;

            empty <= 0;
         end
      end
   end

   assign next_read_addr = (DEPTH == (read_addr + 1)) ? 0 : read_addr + 1;
   assign next_write_addr = (DEPTH == (write_addr + 1)) ? 0 : write_addr + 1;   

   always @(posedge clk) begin
      if (!rst) begin
         if (read_valid) begin
            `assert(read_ready, 1'd1)

            // Wraparound
            read_addr <= next_read_addr;

            if (!empty && (next_read_addr == write_addr) && !write_valid) begin
               empty <= 1;
            end
         end
      end
   end

   reg [WIDTH - 1 : 0] out_data_reg;

   always @(posedge clk) begin
      if (read_valid) begin
         out_data_reg <= ram[read_addr];
      end
   end

   assign out_data = out_data_reg;
   
   assign full = !empty && (write_addr == read_addr);
   assign write_ready = !full;

   // always @(posedge clk) begin
   //    $display("empty = %d", empty);
   //    $display("full  = %d", full);      
   // end

   assign read_ready = !empty;

   always @(posedge clk) begin
      if (rst) begin
         empty <= 1;

         write_addr <= 0;
         read_addr <= 0;

      end
   end
   
endmodule

module phi( last_block, s, in, out);

  parameter integer WIDTH = 32;
  parameter integer NB_PAIR = 2;

   // last block storage variable is always 32 bits  
  input [31:0] last_block; 
  input [32*NB_PAIR-1:0] s; 
  input [WIDTH*NB_PAIR-1:0] in; 
  output [WIDTH-1:0] out; 

  reg [WIDTH-1:0] out_reg;

 integer i;
 integer found;
  always @(*) begin
    found = 0;
    for (i = 0 ; i < NB_PAIR; i=i+1) begin
      if (last_block == s[32*i +: 32]) begin
        out_reg <= in[i*WIDTH +: WIDTH];
        found = 1;
      end
    end
    if (found == 0) begin
      $display("Error: last_block: %b not in s : %b",last_block, s);
      out_reg <= {{WIDTH}{1'bx}};
    end
  end

  assign out = out_reg;
  
endmodule

//IEEE 754 Single Precision ALU
module fpu(clk, A, B, opcode, O);
	input clk;
	input [31:0] A, B;
	input [1:0] opcode;
	output [31:0] O;

	wire [31:0] O;
	wire [7:0] a_exponent;
	wire [23:0] a_mantissa;
	wire [7:0] b_exponent;
	wire [23:0] b_mantissa;

	reg        o_sign;
	reg [7:0]  o_exponent;
	reg [24:0] o_mantissa;


	reg [31:0] adder_a_in;
	reg [31:0] adder_b_in;
	wire [31:0] adder_out;

	reg [31:0] multiplier_a_in;
	reg [31:0] multiplier_b_in;
	wire [31:0] multiplier_out;

	reg [31:0] divider_a_in;
	reg [31:0] divider_b_in;
	wire [31:0] divider_out;

	assign O[31] = o_sign;
	assign O[30:23] = o_exponent;
	assign O[22:0] = o_mantissa[22:0];

	assign a_sign = A[31];
	assign a_exponent[7:0] = A[30:23];
	assign a_mantissa[23:0] = {1'b1, A[22:0]};

	assign b_sign = B[31];
	assign b_exponent[7:0] = B[30:23];
	assign b_mantissa[23:0] = {1'b1, B[22:0]};

	assign ADD = !opcode[1] & !opcode[0];
	assign SUB = !opcode[1] & opcode[0];
	assign DIV = opcode[1] & !opcode[0];
	assign MUL = opcode[1] & opcode[0];

	adder A1
	(
		.a(adder_a_in),
		.b(adder_b_in),
		.out(adder_out)
	);

	multiplier M1
	(
		.a(multiplier_a_in),
		.b(multiplier_b_in),
		.out(multiplier_out)
	);

	divider D1
	(
		.a(divider_a_in),
		.b(divider_b_in),
		.out(divider_out)
	);

	always @ (posedge clk) begin
		if (ADD) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = B;
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end else if (SUB) begin
			//If a is NaN or b is zero return a
			if ((a_exponent == 255 && a_mantissa != 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign;
				o_exponent = a_exponent;
				o_mantissa = a_mantissa;
			//If b is NaN or a is zero return b
			end else if ((b_exponent == 255 && b_mantissa != 0) || (a_exponent == 0) && (a_mantissa == 0)) begin
				o_sign = b_sign;
				o_exponent = b_exponent;
				o_mantissa = b_mantissa;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				adder_a_in = A;
				adder_b_in = {~B[31], B[30:0]};
				o_sign = adder_out[31];
				o_exponent = adder_out[30:23];
				o_mantissa = adder_out[22:0];
			end
		end else if (DIV) begin
			divider_a_in = A;
			divider_b_in = B;
			o_sign = divider_out[31];
			o_exponent = divider_out[30:23];
			o_mantissa = divider_out[22:0];
		end else begin //Multiplication
			//If a is NaN return NaN
			if (a_exponent == 255 && a_mantissa != 0) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = a_mantissa;
			//If b is NaN return NaN
			end else if (b_exponent == 255 && b_mantissa != 0) begin
				o_sign = b_sign;
				o_exponent = 255;
				o_mantissa = b_mantissa;
			//If a or b is 0 return 0
			end else if ((a_exponent == 0) && (a_mantissa == 0) || (b_exponent == 0) && (b_mantissa == 0)) begin
				o_sign = a_sign ^ b_sign;
				o_exponent = 0;
				o_mantissa = 0;
			//if a or b is inf return inf
			end else if ((a_exponent == 255) || (b_exponent == 255)) begin
				o_sign = a_sign;
				o_exponent = 255;
				o_mantissa = 0;
			end else begin // Passed all corner cases
				multiplier_a_in = A;
				multiplier_b_in = B;
				o_sign = multiplier_out[31];
				o_exponent = multiplier_out[30:23];
				o_mantissa = multiplier_out[22:0];
			end
		end
	end
endmodule


module adder(a, b, out);
  input  [31:0] a, b;
  output [31:0] out;

  wire [31:0] out;
	reg a_sign;
	reg [7:0] a_exponent;
	reg [23:0] a_mantissa;
	reg b_sign;
	reg [7:0] b_exponent;
	reg [23:0] b_mantissa;

  reg o_sign;
  reg [7:0] o_exponent;
  reg [24:0] o_mantissa;

  reg [7:0] diff;
  reg [23:0] tmp_mantissa;
  reg [7:0] tmp_exponent;


  reg  [7:0] i_e;
  reg  [24:0] i_m;
  wire [7:0] o_e;
  wire [24:0] o_m;

  addition_normaliser norm1
  (
    .in_e(i_e),
    .in_m(i_m),
    .out_e(o_e),
    .out_m(o_m)
  );

  assign out[31] = o_sign;
  assign out[30:23] = o_exponent;
  assign out[22:0] = o_mantissa[22:0];

  always @ ( * ) begin
		a_sign = a[31];
		if(a[30:23] == 0) begin
			a_exponent = 8'b00000001;
			a_mantissa = {1'b0, a[22:0]};
		end else begin
			a_exponent = a[30:23];
			a_mantissa = {1'b1, a[22:0]};
		end
		b_sign = b[31];
		if(b[30:23] == 0) begin
			b_exponent = 8'b00000001;
			b_mantissa = {1'b0, b[22:0]};
		end else begin
			b_exponent = b[30:23];
			b_mantissa = {1'b1, b[22:0]};
		end
    if (a_exponent == b_exponent) begin // Equal exponents
      o_exponent = a_exponent;
      if (a_sign == b_sign) begin // Equal signs = add
        o_mantissa = a_mantissa + b_mantissa;
        //Signify to shift
        o_mantissa[24] = 1;
        o_sign = a_sign;
      end else begin // Opposite signs = subtract
        if(a_mantissa > b_mantissa) begin
          o_mantissa = a_mantissa - b_mantissa;
          o_sign = a_sign;
        end else begin
          o_mantissa = b_mantissa - a_mantissa;
          o_sign = b_sign;
        end
      end
    end else begin //Unequal exponents
      if (a_exponent > b_exponent) begin // A is bigger
        o_exponent = a_exponent;
        o_sign = a_sign;
				diff = a_exponent - b_exponent;
        tmp_mantissa = b_mantissa >> diff;
        if (a_sign == b_sign)
          o_mantissa = a_mantissa + tmp_mantissa;
        else
          	o_mantissa = a_mantissa - tmp_mantissa;
      end else if (a_exponent < b_exponent) begin // B is bigger
        o_exponent = b_exponent;
        o_sign = b_sign;
        diff = b_exponent - a_exponent;
        tmp_mantissa = a_mantissa >> diff;
        if (a_sign == b_sign) begin
          o_mantissa = b_mantissa + tmp_mantissa;
        end else begin
					o_mantissa = b_mantissa - tmp_mantissa;
        end
      end
    end
    if(o_mantissa[24] == 1) begin
      o_exponent = o_exponent + 1;
      o_mantissa = o_mantissa >> 1;
    end else if((o_mantissa[23] != 1) && (o_exponent != 0)) begin
      i_e = o_exponent;
      i_m = o_mantissa;
      o_exponent = o_e;
      o_mantissa = o_m;
    end
  end
endmodule

module multiplier(a, b, out);
  input  [31:0] a, b;
  output [31:0] out;

  wire [31:0] out;
	reg a_sign;
  reg [7:0] a_exponent;
  reg [23:0] a_mantissa;
	reg b_sign;
  reg [7:0] b_exponent;
  reg [23:0] b_mantissa;

  reg o_sign;
  reg [7:0] o_exponent;
  reg [24:0] o_mantissa;

	reg [47:0] product;

  assign out[31] = o_sign;
  assign out[30:23] = o_exponent;
  assign out[22:0] = o_mantissa[22:0];

	reg  [7:0] i_e;
	reg  [47:0] i_m;
	wire [7:0] o_e;
	wire [47:0] o_m;

	multiplication_normaliser norm1
	(
		.in_e(i_e),
		.in_m(i_m),
		.out_e(o_e),
		.out_m(o_m)
	);


  always @ ( * ) begin
		a_sign = a[31];
		if(a[30:23] == 0) begin
			a_exponent = 8'b00000001;
			a_mantissa = {1'b0, a[22:0]};
		end else begin
			a_exponent = a[30:23];
			a_mantissa = {1'b1, a[22:0]};
		end
		b_sign = b[31];
		if(b[30:23] == 0) begin
			b_exponent = 8'b00000001;
			b_mantissa = {1'b0, b[22:0]};
		end else begin
			b_exponent = b[30:23];
			b_mantissa = {1'b1, b[22:0]};
		end
    o_sign = a_sign ^ b_sign;
    o_exponent = a_exponent + b_exponent - 127;
    product = a_mantissa * b_mantissa;
		// Normalization
    if(product[47] == 1) begin
      o_exponent = o_exponent + 1;
      product = product >> 1;
    end else if((product[46] != 1) && (o_exponent != 0)) begin
      i_e = o_exponent;
      i_m = product;
      o_exponent = o_e;
      product = o_m;
    end
		o_mantissa = product[46:23];
	end
endmodule

module addition_normaliser(in_e, in_m, out_e, out_m);
  input [7:0] in_e;
  input [24:0] in_m;
  output [7:0] out_e;
  output [24:0] out_m;

  wire [7:0] in_e;
  wire [24:0] in_m;
  reg [7:0] out_e;
  reg [24:0] out_m;

  always @ ( * ) begin
		if (in_m[23:3] == 21'b000000000000000000001) begin
			out_e = in_e - 20;
			out_m = in_m << 20;
		end else if (in_m[23:4] == 20'b00000000000000000001) begin
			out_e = in_e - 19;
			out_m = in_m << 19;
		end else if (in_m[23:5] == 19'b0000000000000000001) begin
			out_e = in_e - 18;
			out_m = in_m << 18;
		end else if (in_m[23:6] == 18'b000000000000000001) begin
			out_e = in_e - 17;
			out_m = in_m << 17;
		end else if (in_m[23:7] == 17'b00000000000000001) begin
			out_e = in_e - 16;
			out_m = in_m << 16;
		end else if (in_m[23:8] == 16'b0000000000000001) begin
			out_e = in_e - 15;
			out_m = in_m << 15;
		end else if (in_m[23:9] == 15'b000000000000001) begin
			out_e = in_e - 14;
			out_m = in_m << 14;
		end else if (in_m[23:10] == 14'b00000000000001) begin
			out_e = in_e - 13;
			out_m = in_m << 13;
		end else if (in_m[23:11] == 13'b0000000000001) begin
			out_e = in_e - 12;
			out_m = in_m << 12;
		end else if (in_m[23:12] == 12'b000000000001) begin
			out_e = in_e - 11;
			out_m = in_m << 11;
		end else if (in_m[23:13] == 11'b00000000001) begin
			out_e = in_e - 10;
			out_m = in_m << 10;
		end else if (in_m[23:14] == 10'b0000000001) begin
			out_e = in_e - 9;
			out_m = in_m << 9;
		end else if (in_m[23:15] == 9'b000000001) begin
			out_e = in_e - 8;
			out_m = in_m << 8;
		end else if (in_m[23:16] == 8'b00000001) begin
			out_e = in_e - 7;
			out_m = in_m << 7;
		end else if (in_m[23:17] == 7'b0000001) begin
			out_e = in_e - 6;
			out_m = in_m << 6;
		end else if (in_m[23:18] == 6'b000001) begin
			out_e = in_e - 5;
			out_m = in_m << 5;
		end else if (in_m[23:19] == 5'b00001) begin
			out_e = in_e - 4;
			out_m = in_m << 4;
		end else if (in_m[23:20] == 4'b0001) begin
			out_e = in_e - 3;
			out_m = in_m << 3;
		end else if (in_m[23:21] == 3'b001) begin
			out_e = in_e - 2;
			out_m = in_m << 2;
		end else if (in_m[23:22] == 2'b01) begin
			out_e = in_e - 1;
			out_m = in_m << 1;
		end
  end
endmodule

module multiplication_normaliser(in_e, in_m, out_e, out_m);
  input [7:0] in_e;
  input [47:0] in_m;
  output [7:0] out_e;
  output [47:0] out_m;

  wire [7:0] in_e;
  wire [47:0] in_m;
  reg [7:0] out_e;
  reg [47:0] out_m;

  always @ ( * ) begin
	  if (in_m[46:41] == 6'b000001) begin
			out_e = in_e - 5;
			out_m = in_m << 5;
		end else if (in_m[46:42] == 5'b00001) begin
			out_e = in_e - 4;
			out_m = in_m << 4;
		end else if (in_m[46:43] == 4'b0001) begin
			out_e = in_e - 3;
			out_m = in_m << 3;
		end else if (in_m[46:44] == 3'b001) begin
			out_e = in_e - 2;
			out_m = in_m << 2;
		end else if (in_m[46:45] == 2'b01) begin
			out_e = in_e - 1;
			out_m = in_m << 1;
		end
  end
endmodule

module divider (a, b, out);
	input [31:0] a;
	input [31:0] b;
	output [31:0] out;

	wire [31:0] b_reciprocal;

	reciprocal recip
	(
		.in(b),
		.out(b_reciprocal)
	);

	multiplier mult
	(
		.a(a),
		.b(b_reciprocal),
		.out(out)
	);

endmodule

module reciprocal (in, out);
	input [31:0] in;

	output [31:0] out;

	assign out[31] = in[31];
	assign out[22:0] = N2[22:0];
	assign out[30:23] = (D==9'b100000000)? 9'h102 - in[30:23] : 9'h101 - in[30:23];

	wire [31:0] D;
	assign D = {1'b0, 8'h80, in[22:0]};

	wire [31:0] C1; //C1 = 48/17
	assign C1 = 32'h4034B4B5;
	wire [31:0] C2; //C2 = 32/17
	assign C2 = 32'h3FF0F0F1;
	wire [31:0] C3; //C3 = 2.0
	assign C3 = 32'h40000000;

	wire [31:0] N0;
	wire [31:0] N1;
	wire [31:0] N2;

	//Temporary connection wires
	wire [31:0] S0_2D_out;
	wire [31:0] S1_DN0_out;
	wire [31:0] S1_2min_DN0_out;
	wire [31:0] S2_DN1_out;
	wire [31:0] S2_2minDN1_out;

	wire [31:0] S0_N0_in;

	assign S0_N0_in = {~S0_2D_out[31], S0_2D_out[30:0]};

	//S0
	multiplier S0_2D
	(
		.a(C2),
		.b(D),
		.out(S0_2D_out)
	);

	adder S0_N0
	(
		.a(C1),
		.b(S0_N0_in),
		.out(N0)
	);

	//S1
	multiplier S1_DN0
	(
		.a(D),
		.b(N0),
		.out(S1_DN0_out)
	);

	adder S1_2minDN0
	(
		.a(C3),
		.b({~S1_DN0_out[31], S1_DN0_out[30:0]}),
		.out(S1_2min_DN0_out)
	);

	multiplier S1_N1
	(
		.a(N0),
		.b(S1_2min_DN0_out),
		.out(N1)
	);

	//S2
	multiplier S2_DN1
	(
		.a(D),
		.b(N1),
		.out(S2_DN1_out)
	);

	adder S2_2minDN1
	(
		.a(C3),
		.b({~S2_DN1_out[31], S2_DN1_out[30:0]}),
		.out(S2_2minDN1_out)
	);

	multiplier S2_N2
	(
		.a(N1),
		.b(S2_2minDN1_out),
		.out(N2)
	);

endmodule
