`define assert(signal, value)

//if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

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

module zext(input [IN_WIDTH - 1:0]  in, output [OUT_WIDTH - 1:0] out);

   parameter IN_WIDTH = 32;
   parameter OUT_WIDTH = 64;
   assign out = {{(OUT_WIDTH-IN_WIDTH){1'b0}},in};
endmodule

module shlOp(input [WIDTH - 1:0]  in0, input [$clog2(WIDTH) - 1 : 0] in1, output [WIDTH - 1:0] out);

   parameter WIDTH = 32;
   assign out = in0 << in1;
endmodule

module trunc(input [IN_WIDTH - 1:0]  in, output [OUT_WIDTH - 1:0] out);

   parameter IN_WIDTH = 32;
   parameter OUT_WIDTH = 32;   

   assign out = in[OUT_WIDTH - 1 : 0];
   
endmodule

module notOp(input [WIDTH - 1:0]  in, output [WIDTH - 1:0] out);

   parameter WIDTH = 32;

   assign out = ~in;
   
endmodule

module add(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 + in1;
endmodule

module andOp(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 & in1;
endmodule

module orOp(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [WIDTH - 1:0] out);
   parameter WIDTH = 1;
   
   assign out = in0 | in1;
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

   always @(*) begin
      $display("sgt: in0 = %b, in1 = %b, out = %b", in0, in1, out);
   end
   assign out = $signed(in0) > $signed(in1);
endmodule

module slt(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = $signed(in0) < $signed(in1);
endmodule

module ult(input [WIDTH - 1:0]  in0, input [WIDTH - 1:0] in1, output [0:0] out);
   parameter WIDTH = 1;
   
   assign out = $unsigned(in0) < $unsigned(in1);
endmodule // ult

module sremOp(input [WIDTH - 1 : 0] in0, input [WIDTH - 1 : 0] in1, output [WIDTH - 1 : 0] out);
   assign out = $signed(in0) % $signed(in1);
endmodule

module sliceOp(input [IN_WIDTH - 1 : 0] in, output [OUT_WIDTH - 1 : 0] out);
   parameter IN_WIDTH = 32;
   parameter OUT_WIDTH = 32;
   parameter OFFSET = 0;

   assign out = in[OFFSET + OUT_WIDTH - 1 : OFFSET];
endmodule // sliceOp

module mixOp(input [IN0_WIDTH - 1 : 0] main,
             input [IN1_WIDTH - 1 : 0] inner,
             output [IN0_WIDTH - 1 : 0] out);

   parameter IN0_WIDTH = 32;
   parameter IN1_WIDTH = 1;
   parameter MAIN_OFFSET = 10;
   
   //assign out = {main[IN0_WIDTH - 1 : IN1_WIDTH + MAIN_OFFSET], inner, main[MAIN_OFFSET -  1 : 0]};
   generate
      if (MAIN_OFFSET == 0)
        assign out = {main[IN0_WIDTH - 1 : IN1_WIDTH + MAIN_OFFSET], inner};
      else
        assign out = {main[IN0_WIDTH - 1 : IN1_WIDTH + MAIN_OFFSET], inner, main[MAIN_OFFSET -  1 : 0]};
   endgenerate
   
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

         //$display("Reset");
         
      end else if (start_write) begin

         //$display("starting write to %d", write_addr);
         
         s_axil_wvalid <= 1;
         s_axil_awvalid <= 1;

         s_axil_wdata <= write_data;
         s_axil_awaddr <= {write_addr, 2'b0};

         ready_reg <= 0;
         valid_reg <= 0;

      end else if (s_axil_bvalid && (!s_axil_bresp)) begin
         //$display("s_axil_bvalid = %d", s_axil_bvalid);
         //$display("write is done and valid");
         
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
      // $display("&&&&&&");
      // $display("s_axil_rvalid   === %d", s_axil_rvalid);
      // $display("s_axil_rresp    === %d", s_axil_rresp);
      // $display("s_axil_arready  === %d", s_axil_arready);      
      // $display("======");

      if (rst) begin
         ready <= 1;
         valid <= 0;
         s_axil_arvalid <= 0;
         s_axil_rready <= 0;
         
      end else if (start_read) begin
         //$display("starting read to %d", read_addr);
         
         valid <= 0;
         ready <= 0;

         s_axil_rready <= 1;
         s_axil_arvalid <= 1;
         s_axil_araddr <= {read_addr, 2'b0};
         
      end else if (s_axil_arready && s_axil_rvalid && (s_axil_rresp == 0)) begin
         //$display("Setting read output valid, data = %d", s_axil_rdata);
         
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

         // $display("start write  = %d", start_write);
         // $display("writing      = %d", writing);         
         // $display("should stall = %d", should_stall);         
         if (start_read) begin
            reading <= 1;
         end

         if (start_write) begin
//            $display("writing...");
            writing <= 1;
         end

         if (read_finished) begin
            reading <= 0;
         end
         
         if (write_finished) begin
//            $display("write finished");

            writing <= 0;
         end

      end
   end // always @ (posedge clk)

   assign should_stall = reading | writing;
   
endmodule // axi_stall_manager

module register(input clk, input rst, input [WIDTH - 1:0] raddr, input [WIDTH - 1:0] waddr, input wen, input ren, input [WIDTH - 1:0] wdata, output [WIDTH - 1:0] rdata);

   parameter WIDTH = 32;

   reg [WIDTH - 1:0] data;

   always @(posedge clk) begin
      if (wen) begin
         data <= wdata;
         //$display("writing %d to register", wdata);
      end

      //$display("on clock data = %d", data);      
   end
   
   assign rdata = data;
   
endmodule // register

module coreir_reg(input clk,
                  input rst,
                  input                  en,
                  input [WIDTH - 1 : 0]  in,
                  output [WIDTH - 1 : 0] out);
   parameter WIDTH = 32;
   parameter RESET_VALUE = 0;
   reg [31:0] data;

   always @(posedge clk) begin
      if (rst) begin
         data <= RESET_VALUE;
      end else begin
         if (en) begin
            data <= in;
         end
      end
   end
   
   assign out = data;

endmodule

module reg_passthrough(input clk, input rst, input [WIDTH - 1:0] raddr, input [WIDTH - 1:0] waddr, input wen, input ren, input [WIDTH - 1:0] wdata, output [WIDTH - 1:0] rdata);

   parameter WIDTH = 32;

   reg [31:0] data;

   always @(posedge clk) begin
      if (wen) begin
         data <= wdata;
         //$display("writing %d to register", wdata);
      end

      //$display("on clock data = %d", data);      
   end
   
   assign rdata = wen ? wdata : data;
   
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
         if (write_valid && write_ready) begin

            $display("writing %d to address %d", in_data, write_addr);
//            $display("write_addr = %b, next_write_addr = %b, depth = %b", write_addr, next_write_addr, DEPTH);            
            
            `assert(write_ready, 1'd1)

            ram[write_addr] <= in_data;
            write_addr <= next_write_addr;

            empty <= 0;
         end
      end
   end


   
   assign next_read_addr = (DEPTH == (read_addr + 1)) ? 0 : read_addr + 1;
   assign next_write_addr = (DEPTH == (write_addr + 1)) ? 0 : write_addr + 1;

   always @(*) begin
      $display("READ data is %d, at address 0", ram[0]);
   end

   always @(posedge clk) begin
      `assert(read_ready && read_valid && write_ready && write_valid, 1'd0)      
   end   

   always @(posedge clk) begin
      if (!rst) begin
         if (read_valid) begin
            `assert(read_ready, 1'd1)

            // Wraparound
            read_addr <= next_read_addr;

            if (!empty && (next_read_addr == write_addr) && !write_valid) begin
//               $display("FIFO empty: next_read_addr = %d, write_addr = %d", next_read_addr, write_addr);
               empty <= 1;
            end
         end
      end
   end

   reg [WIDTH - 1 : 0] out_data_reg;

   always @(posedge clk) begin
      if (read_valid && read_ready) begin
         //$display("reading from address %d", read_addr);
         $display("reading %d, from address %d", ram[read_addr], read_addr);
         
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

//         $display("reseting");
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
        out_reg = in[i*WIDTH +: WIDTH];
        found = 1;
      end
    end
    if (found == 0) begin
      $display("Error: last_block: %b not in s : %b",last_block, s);
      out_reg = {{WIDTH}{1'bx}};
    end
  end

  assign out = out_reg;
  
endmodule

module adder(
        input_a,
        input_b,
        input_a_stb,
        input_b_stb,
        output_z_ack,
        clk,
        rst,
        output_z,
        output_z_stb,
        input_a_ack,
        input_b_ack);

  input     clk;
  input     rst;

  input     [31:0] input_a;
  input     input_a_stb;
  output    input_a_ack;

  input     [31:0] input_b;
  input     input_b_stb;
  output    input_b_ack;

  output    [31:0] output_z;
  output    output_z_stb;
  input     output_z_ack;

  reg       s_output_z_stb;
  reg       [31:0] s_output_z;
  reg       s_input_a_ack;
  reg       s_input_b_ack;

  reg       [3:0] state;
  parameter get_a         = 4'd0,
            get_b         = 4'd1,
            unpack        = 4'd2,
            special_cases = 4'd3,
            align         = 4'd4,
            add_0         = 4'd5,
            add_1         = 4'd6,
            normalise_1   = 4'd7,
            normalise_2   = 4'd8,
            round         = 4'd9,
            pack          = 4'd10,
            put_z         = 4'd11;

  reg       [31:0] a, b, z;
  reg       [26:0] a_m, b_m;
  reg       [23:0] z_m;
  reg       [9:0] a_e, b_e, z_e;
  reg       a_s, b_s, z_s;
  reg       guard, round_bit, sticky;
  reg       [27:0] sum;

   always @(posedge clk) begin
      // $display("state          = %d", state);
      // $display("input_a_stb    = %d", input_a_stb);
      // $display("input_a_ack    = %d", input_a_ack);      
      // $display("input_b_stb    = %d", input_b_stb);
      // $display("input_b_ack    = %d", input_b_ack);
      // $display("output_z_stb   = %d", output_z_stb);
      // $display("output_z       = %d", output_z);                  
      // $display("rst            = %d", rst);            
   end

  always @(posedge clk)
  begin

    case(state)

      get_a:
      begin
        s_input_a_ack <= 1;
        if (s_input_a_ack && input_a_stb) begin
          a <= input_a;
          s_input_a_ack <= 0;
          state <= get_b;
        end
      end

      get_b:
      begin
        s_input_b_ack <= 1;
        if (s_input_b_ack && input_b_stb) begin
          b <= input_b;
          s_input_b_ack <= 0;
          state <= unpack;
        end
      end

      unpack:
      begin
        a_m <= {a[22 : 0], 3'd0};
        b_m <= {b[22 : 0], 3'd0};
        a_e <= a[30 : 23] - 127;
        b_e <= b[30 : 23] - 127;
        a_s <= a[31];
        b_s <= b[31];
        state <= special_cases;
      end

      special_cases:
      begin
        //if a is NaN or b is NaN return NaN 
        if ((a_e == 128 && a_m != 0) || (b_e == 128 && b_m != 0)) begin
          z[31] <= 1;
          z[30:23] <= 255;
          z[22] <= 1;
          z[21:0] <= 0;
          state <= put_z;
        //if a is inf return inf
        end else if (a_e == 128) begin
          z[31] <= a_s;
          z[30:23] <= 255;
          z[22:0] <= 0;
          //if a is inf and signs don't match return nan
          if ((b_e == 128) && (a_s != b_s)) begin
              z[31] <= b_s;
              z[30:23] <= 255;
              z[22] <= 1;
              z[21:0] <= 0;
          end
          state <= put_z;
        //if b is inf return inf
        end else if (b_e == 128) begin
          z[31] <= b_s;
          z[30:23] <= 255;
          z[22:0] <= 0;
          state <= put_z;
        //if a is zero return b
        end else if ((($signed(a_e) == -127) && (a_m == 0)) && (($signed(b_e) == -127) && (b_m == 0))) begin
          z[31] <= a_s & b_s;
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if a is zero return b
        end else if (($signed(a_e) == -127) && (a_m == 0)) begin
          z[31] <= b_s;
          z[30:23] <= b_e[7:0] + 127;
          z[22:0] <= b_m[26:3];
          state <= put_z;
        //if b is zero return a
        end else if (($signed(b_e) == -127) && (b_m == 0)) begin
          z[31] <= a_s;
          z[30:23] <= a_e[7:0] + 127;
          z[22:0] <= a_m[26:3];
          state <= put_z;
        end else begin
          //Denormalised Number
          if ($signed(a_e) == -127) begin
            a_e <= -126;
          end else begin
            a_m[26] <= 1;
          end
          //Denormalised Number
          if ($signed(b_e) == -127) begin
            b_e <= -126;
          end else begin
            b_m[26] <= 1;
          end
          state <= align;
        end
      end

      align:
      begin
        if ($signed(a_e) > $signed(b_e)) begin
          b_e <= b_e + 1;
          b_m <= b_m >> 1;
          b_m[0] <= b_m[0] | b_m[1];
        end else if ($signed(a_e) < $signed(b_e)) begin
          a_e <= a_e + 1;
          a_m <= a_m >> 1;
          a_m[0] <= a_m[0] | a_m[1];
        end else begin
          state <= add_0;
        end
      end

      add_0:
      begin
        z_e <= a_e;
        if (a_s == b_s) begin
          sum <= a_m + b_m;
          z_s <= a_s;
        end else begin
          if (a_m >= b_m) begin
            sum <= a_m - b_m;
            z_s <= a_s;
          end else begin
            sum <= b_m - a_m;
            z_s <= b_s;
          end
        end
        state <= add_1;
      end

      add_1:
      begin
        if (sum[27]) begin
          z_m <= sum[27:4];
          guard <= sum[3];
          round_bit <= sum[2];
          sticky <= sum[1] | sum[0];
          z_e <= z_e + 1;
        end else begin
          z_m <= sum[26:3];
          guard <= sum[2];
          round_bit <= sum[1];
          sticky <= sum[0];
        end
        state <= normalise_1;
      end

      normalise_1:
      begin
        if (z_m[23] == 0 && $signed(z_e) > -126) begin
          z_e <= z_e - 1;
          z_m <= z_m << 1;
          z_m[0] <= guard;
          guard <= round_bit;
          round_bit <= 0;
        end else begin
          state <= normalise_2;
        end
      end

      normalise_2:
      begin
        if ($signed(z_e) < -126) begin
          z_e <= z_e + 1;
          z_m <= z_m >> 1;
          guard <= z_m[0];
          round_bit <= guard;
          sticky <= sticky | round_bit;
        end else begin
          state <= round;
        end
      end

      round:
      begin
        if (guard && (round_bit | sticky | z_m[0])) begin
          z_m <= z_m + 1;
          if (z_m == 24'hffffff) begin
            z_e <=z_e + 1;
          end
        end
        state <= pack;
      end

      pack:
      begin
        z[22 : 0] <= z_m[22:0];
        z[30 : 23] <= z_e[7:0] + 127;
        z[31] <= z_s;
        if ($signed(z_e) == -126 && z_m[23] == 0) begin
          z[30 : 23] <= 0;
        end
        //if overflow occurs, return inf
        if ($signed(z_e) > 127) begin
          z[22 : 0] <= 0;
          z[30 : 23] <= 255;
          z[31] <= z_s;
        end
        state <= put_z;
      end

      put_z:
      begin
        s_output_z_stb <= 1;
        s_output_z <= z;
        if (s_output_z_stb && output_z_ack) begin
          s_output_z_stb <= 0;
          state <= get_a;
        end
      end

    endcase

    if (rst == 1) begin
      state <= get_a;
      s_input_a_ack <= 0;
      s_input_b_ack <= 0;
      s_output_z_stb <= 0;
    end

  end
  assign input_a_ack = s_input_a_ack;
  assign input_b_ack = s_input_b_ack;
  assign output_z_stb = s_output_z_stb;
  assign output_z = s_output_z;

endmodule

module fadd(
            input           clk,
            input           en,
            input [31 : 0]  in0,
            input [31 : 0]  in1,
            output [31 : 0] out);


   reg                    a_stb;
   reg                    b_stb;

   wire                    a_ack;
   wire                    b_ack;

   reg                    out_ack;

   wire                    out_stb;

   reg [1:0]               state;
   
   parameter setting_a = 2'd0;
   parameter setting_b = 2'd1;
   parameter waiting = 2'd2;

   reg [31 : 0]            in0_stored;
   reg [31 : 0]            in1_stored;
   
   reg [31 : 0]            in0_r;
   reg [31 : 0]            in1_r;

   always @(posedge clk) begin
      if (en) begin
         in0_stored = in0;
         in1_stored = in1;         
      end
   end

   always @(posedge clk) begin
      // $display("ST      = %b", state);
      // $display("out     = %b", out);
      // $display("a_ack   = %b", a_ack);
      // $display("b_ack   = %b", b_ack);
      // $display("in0     = %b", in0);
      // $display("in1     = %b", in1);
      // $display("in0_s     = %b", in0_stored);
      // $display("in1_s     = %b", in1_stored);

   end

   always @(posedge clk) begin

      if (en) begin
         state <= setting_a;
         a_stb <= 1;
         b_stb <= 0;
         out_ack <= 0;
      end else begin
         if (out_stb == 1) begin
            state <= setting_a;
            out_ack <= 1;
         end else if (a_ack) begin
            b_stb <= 1;
            state <= setting_b;
            out_ack <= 0;
         end else if (b_ack) begin
            state <= waiting;
         end
      end
   end

   always @(*) begin
      if ((state == setting_a) || (state == setting_b)) begin
         a_stb <= 1;
         b_stb <= 0;
      end

      if ((state == setting_b)) begin
         b_stb <= 1;
         a_stb <= 0;
      end

   end
   
   adder fadd(
              .input_a(in0_stored),
              .input_b(in1_stored),
              .input_a_stb(a_stb),
              .input_b_stb(b_stb),
              .output_z_ack(out_ack),
              .clk(clk),
              .rst(en),
              .output_z(out),
              .output_z_stb(out_stb),
              .input_a_ack(a_ack),
              .input_b_ack(b_ack));
   
endmodule

module PackedStencil(input clk);
endmodule // PackedStencil

module AxiPackedStencil(input clk,
                        output [DATA_WIDTH - 1 : 0]        data_bus,
                        output                             last_bus,

                        input [DATA_WIDTH - 1 : 0]         in_data_bus,
                        input                              in_last_bus,

                        input                              set_data,

                        input                              set_last_en,
                        input                              set_last_value,

                        input [VALUE_WIDTH - 1 : 0]        set_value,
                        input [$clog2(DATA_WIDTH) - 1 : 0] set_row,
                        input [$clog2(DATA_WIDTH) - 1 : 0] set_col,
                        input                              set_en,

                        output reg [VALUE_WIDTH - 1 : 0]   get_value,
                        input [$clog2(DATA_WIDTH) - 1 : 0] get_row,
                        input [$clog2(DATA_WIDTH) - 1 : 0] get_col);

   parameter VALUE_WIDTH = 16;
   parameter NROWS = 2;
   parameter NCOLS = 2;
   parameter DATA_WIDTH = VALUE_WIDTH*NROWS*NCOLS;

   reg [DATA_WIDTH + 1 - 1 : 0]                     data;

   always @(posedge clk) begin
      if (set_last_en) begin
         data[0] <= set_last_value;
      end
   end

   always @(posedge clk) begin
      if (set_en) begin
         $display("set_row   = %d", get_row);      
         $display("set_col   = %d", set_col);
         $display("set_val   = %d", set_value);         
         data[VALUE_WIDTH + 1 - 1 : 1] <= set_value;
      end
   end

   integer                                          i;
   integer                                          found;
   // TODO: Fix this indexing problem. Should be a proper variable select
   // and eventually should probably be another module
   always @(*) begin
      get_value = data[VALUE_WIDTH + 1 - 1 : 1];
//      $display("get_value = %d", get_value);
      
      
      // for (i = 0 ; i < NROWS*NCOLS; i=i+1) begin
      //    if ((i == get_row)) begin
      //       get_value = data[i*VALUE_WIDTH + 1 +: VALUE_WIDTH + 1];
      //    end
      // end
   end

   
   always @(posedge clk) begin
      //$display("data_bus = %d", data_bus);
      
      if (set_data == 1) begin
         `assert(set_en, 1'b0)
         
         $display("Set AxiPackedStencil %d, %d to data", in_data_bus, in_last_bus);
         data <= {in_data_bus, in_last_bus};
      end
   end

   // assign last_bus = set_data ? in_last_bus : (set_last_en ? set_last_value : data[0]);
   //assign data_bus = set_data ? in_data_bus : data[DATA_WIDTH + 1 - 1 : 1];

   assign last_bus = data[0];
   assign data_bus = data[DATA_WIDTH + 1 - 1 : 1];
   
endmodule // AxiPackedStencil

module Stencil(input clk);
endmodule

module HLS_stream(input clk, input rst,
                  output [DATA_WIDTH - 1 : 0] data_bus,
                  output                      last_bus,

                  input [DATA_WIDTH - 1 : 0] in_data_bus,
                  input                      in_last_bus,
                  
                  input                       read_valid,
                  output                      read_ready,
                  
                  input                       write_valid,
                  output                      write_ready);

   parameter VALUE_WIDTH = 16;
   parameter NROWS = 2;
   parameter NCOLS = 2;
   parameter DATA_WIDTH = VALUE_WIDTH*NROWS*NCOLS;

   always @(posedge clk) begin
      if (write_valid) begin
         $display("Writing %d", {in_data_bus, in_last_bus});
         $display("in_data_bus == %d", in_data_bus);
         $display("in_last_bus == %d", in_last_bus);         
      end
   end   

   // always @(posedge clk) begin
   //    // $display("read ready ? %d, read valid %d", read_ready, read_valid);
   //    // $display("Read data = %d", data_out);
      
   //    if (read_valid && read_ready) begin
   //       $display("Reading %d from %d", mem[read_addr], read_addr);
   //    end
   // end   
   
   // always @(posedge clk) begin
   //    $display("read ready = %d", read_ready);
   // end   
   
   wire [DATA_WIDTH + 1 - 1 : 0]              data_out;

   assign last_bus = data_out[0];
   assign data_bus = data_out[DATA_WIDTH + 1 - 1 : 1];
   // Holds 
   fifo #(.WIDTH(DATA_WIDTH + 1), .DEPTH(320))
   stencil_stream(.clk(clk),
                  .rst(rst),
                  .read_ready(read_ready),
                  .read_valid(read_valid),
                  .write_ready(write_ready),
                  .write_valid(write_valid),
                  .in_data({in_data_bus, in_last_bus}),
                  .out_data(data_out));

            // input [WIDTH - 1 : 0]  in_data,
            // output [WIDTH - 1 : 0] out_data);
   
endmodule

module Linebuffer_2_1(input clk,
                      input                        rst,

                      input [DATA_WIDTH - 1 : 0]   in_data,
                      input                        write_valid,
                      output reg                       write_ready,
                      

                      input [2*DATA_WIDTH - 1 : 0] out_data,
                      output                       read_ready
                      );

   parameter DATA_WIDTH = 32;
   
   reg [DATA_WIDTH - 1 : 0]                      d0;
   reg [DATA_WIDTH - 1 : 0]                      d1;

   reg                                           d0_valid;
   reg                                           d1_valid;
   

   // More recently input items are higher further along in the stream
   assign out_data = {d0, d1};
   assign read_ready = d0_valid & d1_valid;

   always @(posedge clk) begin
      if (rst) begin
         d0_valid <= 0;
         d1_valid <= 0;
         
         write_ready <= 1;
         // read_ready <= 0;
         
      end else begin
         if (write_valid) begin
            d0 <= in_data;
            d0_valid <= 1;
            
            d1 <= d0;
            d1_valid <= d0;            

         end
      end
   end

endmodule

module hls_wire(input [WIDTH - 1 : 0] in_data,
                output [WIDTH - 1 : 0] out_data);

   parameter WIDTH = 16;
   
   assign out_data = in_data;
endmodule

module concat(input [IN0_WIDTH - 1 : 0] in0,
              input [IN1_WIDTH - 1 : 0] in1,
              output [OUT_WIDTH - 1 : 0] out);
   
   parameter IN0_WIDTH = 32;
   parameter IN1_WIDTH = 32;
   parameter OUT_WIDTH = IN0_WIDTH + IN1_WIDTH;

   assign out = {in1, in0};
   
endmodule

module linebuffer_model(input clk,
                        input                                        rst,

                        input [IN_BUS_SIZE - 1 : 0]                  in_data,
                        input                                        in_valid,

                        output [OUT_ROWS*OUT_COLS*DATA_SIZE - 1 : 0] out_window,
                        output                                       out_data_valid,
                        input                                        out_data_ready);

   parameter DATA_SIZE = 32 + 1;

   parameter IN_BUS_SIZE = IN_ROWS*IN_COLS*DATA_SIZE;
   
   parameter NROWS = 64;
   parameter NCOLS = 64;

   parameter IN_ROWS = 1;
   parameter IN_COLS = 1;

   parameter OUT_ROWS = 3;
   parameter OUT_COLS = 3;

   reg [IN_BUS_SIZE - 1 : 0] data [NROWS*NCOLS - 1 : 0];

   reg [OUT_ROWS*OUT_COLS*DATA_SIZE - 1 : 0] out_window_data;
   
   reg [31:0]          next_write_loc;
   reg [31:0]          next_read_loc;
   
   reg [31:0]          window_center;
   reg                 window_valid;
   

   wire [31:0]         rw_difference;

   assign rw_difference = next_write_loc - next_read_loc;
   
   assign out_data_valid = rw_difference >= ((OUT_ROWS - 1)*NCOLS + OUT_COLS);

   always @(posedge clk) begin
      if (rst) begin
         window_valid <= 0;
         next_write_loc <= 0;
         next_read_loc <= 0;
      end else begin

         if (out_data_valid & out_data_ready) begin
            $display("lb reading = %b", data[next_read_loc]);

            next_read_loc <= next_read_loc + 1;
            out_window_data <= data[next_read_loc];
         end

         if (in_valid) begin
            $display("next_write_loc update = %d", next_write_loc);
            next_write_loc <= next_write_loc + 1;
            data[next_write_loc] <= in_data;
         end
      end
   end

   assign out_window = out_window_data;
   
   
endmodule
