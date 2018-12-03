module load();
endmodule // load

module store();
endmodule

module add(input [31:0]  in0, input [31:0] in1, output [31:0] out);
   assign out = in0 + in1;
endmodule

module mul(input [31:0]  in0, input [31:0] in1, output [31:0] out);
   assign out = in0 * in1;
endmodule

module getelementptr_1(input [31:0]  base_addr, input [31:0] in1, output [31:0] out);
   assign out = base_addr + in1;
endmodule

module getelementptr_2(input [31:0]  base_addr, input [31:0] in1, input [31:0] in2, output [31:0] out);
   assign out = base_addr + in1 + in2;
endmodule

module eq(input [31:0]  in0, input [31:0] in1, output [0:0] out);
   assign out = in0 == in1;
endmodule

module sgt(input [31:0]  in0, input [31:0] in1, output [0:0] out);
   assign out = $signed(in0) > $signed(in1);
endmodule

module slt(input [31:0]  in0, input [31:0] in1, output [0:0] out);
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

module br_dummy();
endmodule

module select(input sel, input [31:0] in0, input [31:0] in1, output [31:0] out);
   assign out = sel ? in1 : in0;
endmodule


module axi_write_handler(input clk,
                         input                           rst,

                         // User facing API
                         input [DATA_WIDTH - 1 : 0]      write_data,
                         input [ADDR_WIDTH - 1 : 0]      write_addr,
                         input                           start_write,

                         output                          ready,

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

   assign ready = ready_reg;

   assign s_axil_bready = 1'b1;
   assign s_axil_wstrb = 5'b11111;
   
   always @(posedge clk) begin
      if (rst) begin
         ready_reg <= 1;

         s_axil_wvalid <= 0;
         s_axil_awvalid <= 0;

         $display("Reset");
         
      end else if (start_write) begin

         s_axil_wvalid <= 1;
         s_axil_awvalid <= 1;

         s_axil_wdata <= write_data;
         s_axil_awaddr <= write_addr;

         ready_reg <= 0;

      end else if (s_axil_bvalid && (!s_axil_bresp)) begin
         ready_reg <= 1;

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
         valid <= 0;
         ready <= 0;

         s_axil_rready <= 1;
         s_axil_arvalid <= 1;
         s_axil_araddr <= read_addr;
         
      end else if (s_axil_arready && s_axil_rvalid && (s_axil_rresp == 0)) begin
         read_data <= s_axil_rdata;
         valid <= 1;
      end else begin
         valid <= 0;
         s_axil_arvalid <= 0;
      end
   end

endmodule // axi_read_handler
