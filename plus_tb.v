`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   reg [4:0] raddr0;
   reg [4:0] waddr;
   reg [31:0] wdata;
   reg [0:0] wen;
   
   wire [31:0] rdata0;
   
   initial begin

      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;

      //$display("rdata = %d", rdata);
      // $display("wen   = %d", wen);
      // $display("waddr = %d", waddr);
      // $display("wdata = %d", wdata);            
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(rdata0, 32'hxxxxxxxx);

      #1 clk = 0;
      #1 clk = 1;

//      $display("rdata = %d", rdata);      
      
      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(rdata0, 32'd5);

      $display("Passed");

//      $display("rdata = %d", rdata);
      
      #1 clk = 0;
      #1 clk = 1;

//      $display("rdata = %d", rdata);      
   end

   RAM2 mem(.clk(clk),
            .rst(rst),
            .raddr0(raddr0),
            .rdata0(rdata0),
            .wen(wen),
            .wdata(wdata),
            .waddr(waddr));
   
   plus ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen), .raddr_0(raddr0), .rdata_0(rdata0));
   
endmodule
