module RAM(input clk,
           input                  rst,
           input                  wen_0,
           input [WIDTH - 1 : 0]  wdata_0,
           input [ADDR_WIDTH : 0] raddr_0,
           input [ADDR_WIDTH : 0] waddr_0,
           output [WIDTH - 1 : 0] rdata_0,

           input [ADDR_WIDTH : 0] debug_write_addr,
           input [WIDTH - 1 : 0]  debug_write_data,
           input                  debug_write_en,
           
           input [ADDR_WIDTH : 0] debug_addr,
           output [WIDTH - 1 : 0] debug_data);
           

   parameter WIDTH=32;
   parameter DEPTH=16;
   parameter ADDR_WIDTH = $clog2(DEPTH);

   reg [WIDTH - 1 : 0]            rdata_0_reg;
   wire [WIDTH - 1 : 0]            rdata_0_reg_del;

   reg [WIDTH - 1 : 0]            data [DEPTH - 1 : 0];

   wire                            wen_0_del;
   wire [ADDR_WIDTH : 0]            waddr_0_del;
   wire [WIDTH - 1 : 0]            wdata_0_del;   

   assign debug_data = data[debug_addr];
   
   always @(posedge clk) begin
      
      if (wen_0_del) begin
         data[waddr_0_del] <= wdata_0_del;
      end

      if (debug_write_en) begin
         data[debug_write_addr] <= debug_write_data;
      end
      
      rdata_0_reg <= data[raddr_0];
   end

   delay #(.WIDTH(1)) wen_0_delay(.clk(clk), .in(wen_0), .out(wen_0_del));   
   delay #(.WIDTH(WIDTH)) wdata_0_delay(.clk(clk), .in(wdata_0), .out(wdata_0_del));   
   delay #(.WIDTH($clog2(DEPTH))) waddr_0_delay(.clk(clk), .in(waddr_0), .out(waddr_0_del));   

   assign rdata_0 = rdata_0_reg;

endmodule
