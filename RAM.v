// TODO: Add delay by 3
module RAM(input clk,
           input                  rst,
           input                  wen,
           input [WIDTH - 1 : 0]  wdata,
           input [ADDR_WIDTH : 0] raddr,
           input [ADDR_WIDTH : 0] waddr,
           output [WIDTH - 1 : 0] rdata);

   parameter WIDTH=32;
   parameter DEPTH=16;
   parameter ADDR_WIDTH = $clog2(DEPTH);

   reg [WIDTH - 1 : 0]            rdata_reg;

   reg [WIDTH - 1 : 0]            data [DEPTH - 1 : 0];
   
   always @(posedge clk) begin
      if (wen) begin
         data[waddr] <= wdata;
      end

      rdata_reg <= data[raddr];
   end

   assign rdata = rdata_reg;

endmodule
