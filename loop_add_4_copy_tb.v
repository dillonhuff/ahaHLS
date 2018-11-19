`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;

   wire [31:0] global_state_dbg;

   // Depth 16, width 32 RAM
   reg [4:0] dbg_addr;
   wire [31:0] dbg_data;

   reg [4:0] dbg_wr_addr;   
   reg [31:0] dbg_wr_data;
   reg dbg_wr_en;   

   reg [4:0] waddr;
   reg [31:0] wdata;
   reg [0:0] wen;

   reg [4:0] raddr0;
   reg [4:0] raddr1;
   
   wire [31:0] rdata0;
   wire [31:0] rdata1;

   reg [31:0] clocks;
   reg [31:0] max_clocks;

   initial begin
      #1 clk = 0;
      clocks = 0;
      max_clocks = 50;
      rst = 1;
      
   end // initial begin

   always @(posedge clk) begin
      $display("-- In tb, waddr_0 = %d", waddr);
      $display("-- In tb, wdata_0 = %d", wdata);
      $display("-- In tb, raddr_0 = %d", raddr0);
      $display("-- In tb, rdata_0 = %d", rdata0);
      $display("-- dbg_data       = %d", dbg_data);
      $display("-- dbg_addr       = %d", dbg_addr);
      $display("-- clocks         = %d", clocks);
      clocks <= clocks + 1;

      if (clocks == 0) begin
         rst <= 0;
      end

      if (clocks >= max_clocks) begin
         $display("FAILED!");
         $finish();
      end
      
   end

   always #3 clk = !clk;

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
   
   loop_add_4_copy ss(.clk(clk),
                      .rst(rst),
                      .valid(valid),
                      .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen),
                      .raddr_0(raddr0), .rdata_0(rdata0),
                      .global_state_dbg(global_state_dbg));
   
endmodule
