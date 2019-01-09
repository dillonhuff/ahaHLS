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

module ret();
endmodule

module phi_2(input [31:0] last_block,
             input [31:0] s0,
             input [31:0] s1,             
             input [31:0] in0,
             input [31:0] in1,
             output [31:0] out);

   reg [31:0]              out_reg;
   

    always @(*) begin
       //$display("In phi: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
      if (last_block == s0) begin
         out_reg = in0;
      end else if (last_block == s1) begin
         out_reg = in1;
      end else begin
         $display("Error: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
      end

      
      // else begin
      //    $display("Error: last_block == %d, but s0 == %d, and s1 == %d", last_block, s0, s1);
      //    $finish();
      // end

   end

   assign out = out_reg;
   
   
endmodule

module phi_3(input [31:0] last_block,
             input [31:0]  s0,
             input [31:0]  s1,
             input [31:0]  s2, 
             input [31:0]  in0,
             input [31:0]  in1,
             input [31:0]  in2,             
             output [31:0] out);

   reg [31:0]              out_reg;
   

    always @(*) begin

      if (last_block == s0) begin
         out_reg = in0;
      end else if (last_block == s1) begin
         out_reg = in1;
      end else if (last_block == s2) begin
         out_reg = in2;
      end else begin
         $display("Error: last_block == %d, but s0 == %d, and s1 == %d, and s2== %d", last_block, s0, s1, s2);
      end

   end

   assign out = out_reg;
   
   
endmodule

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

   always @(posedge clk) begin
      if (!rst) begin
         if (write_valid) begin
            `assert(write_ready, 1'd1)

            ram[write_addr] <= in_data;

            // Wraparound
            write_addr <= DEPTH == write_addr ? 0 : write_addr + 1;

            empty <= 0;
         end
      end
   end

   assign next_read_addr = DEPTH == read_addr ? 0 : read_addr + 1;
   
   always @(posedge clk) begin
      if (!rst) begin
         if (read_valid) begin
            `assert(read_ready, 1'd1)

            // Wraparound
            read_addr <= next_read_addr;

            if (!empty && (next_read_addr == write_addr)) begin
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

   always @(posedge clk) begin
      $display("empty = %d", empty);
   end

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
  
  input [WIDTH-1:0] last_block; 
  input [WIDTH*NB_PAIR-1:0] s; 
  input [WIDTH*NB_PAIR-1:0] in; 
  output [WIDTH-1:0] out; 

  reg [WIDTH-1:0] out_reg;

 integer i;
 integer found;
  always @(*) begin
    found = 0;
    for (i = 0 ; i < NB_PAIR; i=i+1) begin
      if (last_block == s[WIDTH*i +: WIDTH]) begin
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
