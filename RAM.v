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


endmodule
           // .raddr(raddr),
           // .rdata(rdata),
           // .wen(wen),
           // .wdata(wdata),
           // .waddr(waddr));
