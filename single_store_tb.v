module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   reg [4:0] raddr;
   reg [4:0] waddr;
   reg [31:0] wdata;
   reg [0:0] wen;
   
   wire [31:0] rdata;
   
   initial begin

      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;
      #1 raddr = 0;

      $display("rdata = %d", rdata);
      $display("wen   = %d", wen);
      $display("waddr = %d", waddr);
      $display("wdata = %d", wdata);            
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      $display("rdata = %d", rdata);      

      #1 clk = 0;
      #1 clk = 1;

      $display("rdata = %d", rdata);            
      $display("raddr = %d", rdata);

      #1 clk = 0;
      #1 clk = 1;

      $display("rdata = %d", rdata);      
      
      #1 clk = 0;
      #1 clk = 1;

      $display("rdata = %d", rdata);
      
      #1 clk = 0;
      #1 clk = 1;

      $display("rdata = %d", rdata);      
   end

   RAM mem(.clk(clk),
           .rst(rst),
           .raddr(raddr),
           .rdata(rdata),
           .wen(wen),
           .wdata(wdata),
           .waddr(waddr));
   
   single_store ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen));
   
endmodule
