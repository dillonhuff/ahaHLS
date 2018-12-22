`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   reg [4:0] raddr;
   wire [4:0] waddr;
   wire [31:0] wdata;
   wire [0:0] wen;

   reg [4:0] debug_addr;
   wire [31:0] debug_data;
   
   wire [31:0] rdata;
   
   initial begin

      #1 debug_addr = 0;

      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;
      #1 raddr = 0;

      // In global state 0
      #1 `assert(debug_data, 32'hxxxxxxxx)
      #1 `assert(valid, 1'd0)
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      // In global state 1
      #1 `assert(debug_data, 32'hxxxxxxxx)
      #1 `assert(valid, 1'd0)
      
      #1 clk = 0;
      #1 clk = 1;

      // In global state 2
      #1 `assert(debug_data, 32'hxxxxxxxx)
      #1 `assert(valid, 1'd0)

      #1 clk = 0;
      #1 clk = 1;

      // In global state 3, we should be done
      #1 `assert(debug_data, 32'd5)
      #1 `assert(valid, 1'd1)

      #1 clk = 0;
      #1 clk = 1;

      // In global state 3, we should be done, but reads have a delay of one
      #1 `assert(debug_data, 32'd5)
      #1 `assert(valid, 1'd1) 
      
      #1 $display("Passed");

   end

   RAM mem(.clk(clk),
           .rst(rst),
           .raddr(raddr),
           .rdata(rdata),
           .wen(wen),
           .wdata(wdata),
           .waddr(waddr),
           .debug_addr(debug_addr),
           .debug_data(debug_data));
   
   single_store ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen));
   
endmodule
