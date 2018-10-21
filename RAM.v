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
   wire [WIDTH - 1 : 0]            rdata_reg_del;

   reg [WIDTH - 1 : 0]            data [DEPTH - 1 : 0];

   wire                            wen_del;
   wire [ADDR_WIDTH : 0]            waddr_del;
   wire [WIDTH - 1 : 0]            wdata_del;   

   always @(posedge clk) begin
      // $display("--- wen_del    = %d", wen_del);
      // $display("--- waddr_del  = %d", waddr_del);
      // $display("--- wdata_del  = %d", wdata_del);
      
      if (wen_del) begin
         data[waddr_del] <= wdata_del;
      end

      rdata_reg <= data[raddr];
   end

   //delay #(.WIDTH(32)) rdata_delay(.clk(clk), .in(rdata_reg), .out(rdata_reg_del));

   //delay #(.WIDTH(5)) raddr_delay(.clk(clk), .in(raddr), .out(raddr_del));   

   delay #(.WIDTH(1)) wen_delay(.clk(clk), .in(wen), .out(wen_del));   
   delay #(.WIDTH(32)) wdata_delay(.clk(clk), .in(wdata), .out(wdata_del));   
   delay #(.WIDTH(5)) waddr_delay(.clk(clk), .in(waddr), .out(waddr_del));   

   assign rdata = rdata_reg;

endmodule
