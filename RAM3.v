module RAM3(input clk,
           input                  rst,
           input                  wen,
           input [WIDTH - 1 : 0]  wdata,
           input [ADDR_WIDTH : 0] waddr,

           input [ADDR_WIDTH : 0] raddr_0,
           input [ADDR_WIDTH : 0] raddr_1,
           input [ADDR_WIDTH : 0] raddr_2,

           output [WIDTH - 1 : 0] rdata_0,
           output [WIDTH - 1 : 0] rdata_1,
           output [WIDTH - 1 : 0] rdata_2,
            
           input [ADDR_WIDTH : 0] debug_write_addr,
           input [WIDTH - 1 : 0]  debug_write_data,
           input                  debug_write_en,
            
           input [ADDR_WIDTH : 0] debug_addr,
           output [WIDTH - 1 : 0] debug_data);

   parameter WIDTH=32;
   parameter DEPTH=16;
   parameter ADDR_WIDTH = $clog2(DEPTH);

   reg [WIDTH - 1 : 0]            rdata_0_reg;
   reg [WIDTH - 1 : 0]            rdata_1_reg;   
   reg [WIDTH - 1 : 0]            rdata_2_reg;   

   wire [WIDTH - 1 : 0]            rdata_reg_del;

   reg [WIDTH - 1 : 0]            data [DEPTH - 1 : 0];

   wire                            wen_del;
   wire [ADDR_WIDTH : 0]            waddr_del;
   wire [WIDTH - 1 : 0]            wdata_del;

   assign debug_data = data[debug_addr];

   always @(posedge clk) begin
      if (wen_del) begin
         data[waddr_del] <= wdata_del;
      end

      if (debug_write_en) begin
         data[debug_write_addr] <= debug_write_data;
      end

      rdata_0_reg <= data[raddr_0];
      rdata_1_reg <= data[raddr_1];
      rdata_2_reg <= data[raddr_2];            
   end

   delay #(.WIDTH(1)) wen_delay(.clk(clk), .in(wen), .out(wen_del));   
   delay #(.WIDTH(32)) wdata_delay(.clk(clk), .in(wdata), .out(wdata_del));   
   delay #(.WIDTH(5)) waddr_delay(.clk(clk), .in(waddr), .out(waddr_del));   

   assign rdata_0 = rdata_0_reg;
   assign rdata_1 = rdata_1_reg;
   assign rdata_2 = rdata_2_reg;   
endmodule
