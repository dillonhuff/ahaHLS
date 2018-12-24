`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   reg [4:0] dbg_addr;
   wire [31:0] dbg_data;

   reg [4:0] dbg_wr_addr;   
   reg [31:0] dbg_wr_data;
   reg dbg_wr_en;   

   wire [4:0] waddr;
   wire [31:0] wdata;
   wire [0:0] wen;

   wire [4:0] raddr0;
   wire [4:0] raddr1;
   
   wire [31:0] rdata0;
   wire [31:0] rdata1;   

   initial begin

      #1 dbg_wr_addr = 4;
      #1 dbg_wr_data = 3;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_wr_addr = 3;
      #1 dbg_wr_data = 23;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_wr_en = 0;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_addr = 0;
      
      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;

      `assert(dbg_data, 32'hxxxxxxxx)
      `assert(valid, 1'd0)
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      `assert(valid, 1'd0)

      #1 clk = 0;
      #1 clk = 1;

      `assert(valid, 1'd0)

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 $display("Should overwrite value");
      
      `assert(dbg_data, 32'd23)
      `assert(valid, 1'd1)


      // Now reset and write new value with c[0] ]!= 3
      #1 dbg_wr_addr = 4;
      #1 dbg_wr_data = 2;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_wr_addr = 3;
      #1 dbg_wr_data = 18;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_wr_en = 0;
      $display("dbg_data = %d", dbg_data);            
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      $display("dbg_data = %d", dbg_data);            
      #1 clk = 0;
      #1 clk = 1;
      #1 rst = 1;
      
      #1 dbg_addr = 0;
      $display("dbg_data = %d", dbg_data);            
      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;
      $display("dbg_data = %d", dbg_data);      
      #1 rst = 0;

      `assert(dbg_data, 32'd23)
      `assert(valid, 1'd0)
      $display("dbg_data = %d", dbg_data);            
      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;
      $display("dbg_data = %d", dbg_data);      
      #1 clk = 0;
      #1 clk = 1;
      $display("dbg_data = %d", dbg_data);      
      #1 clk = 0;
      #1 clk = 1;

      #1 $display("Should not overwrite value");
      $display("dbg_data = %d", dbg_data);      
      `assert(dbg_data, 32'd23)
      `assert(valid, 1'd1)
      
      #1 $display("Passed");

   end

   RAM2 mem(.clk(clk),
            .rst(rst),

            .raddr0(raddr0),
            .rdata0(rdata0),

            .raddr1(raddr1),
            .rdata1(rdata1),

            .debug_write_addr(dbg_wr_addr),
            .debug_write_data(dbg_wr_data),
            .debug_write_en(dbg_wr_en),
            
            .debug_addr(dbg_addr),
            .debug_data(dbg_data),
            
            .wen(wen),
            .wdata(wdata),
            .waddr(waddr));
   
   if_else ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen), .raddr_0(raddr0), .rdata_0(rdata0));
   
endmodule
