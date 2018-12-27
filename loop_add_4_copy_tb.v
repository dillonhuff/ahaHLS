`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;

   wire [31:0] global_state_dbg;
   wire [31:0] wdata_temp_reg_dbg;
   
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

   reg [31:0] clocks;
   reg [31:0] max_clocks;
   reg        in_start;
   reg [31:0] mem_val;

   initial begin
      #1 clk = 0;
      clocks = 0;
      max_clocks = 50;
      rst = 1;
      in_start = 1;
      mem_val = 1;
      
      
   end // initial begin

   always @(posedge clk) begin
      $display("-- In tb, waddr_0 = %d", waddr);
      $display("-- In tb, wdata_0 = %d", wdata);
      $display("-- In tb, raddr_0 = %d", raddr0);
      $display("-- In tb, rdata_0 = %d", rdata0);
      $display("-- dbg_data       = %d", dbg_data);
      $display("-- dbg_addr       = %d", dbg_addr);
      $display("-- clocks         = %d", clocks);
      $display("-- wdata_temp_reg_dbg = %d", wdata_temp_reg_dbg);
      
      clocks <= clocks + 1;

      if (in_start) begin
         dbg_wr_addr <= mem_val - 1;
         dbg_wr_data <= mem_val;
         dbg_wr_en <= 1;
         mem_val <= mem_val + 1;         
      end else begin
         dbg_wr_en <= 0;
      end

      if (clocks == 10) begin
         mem_val <= mem_val + 1;
         rst <= 0;
         in_start <= 0;
         dbg_addr <= 10;
      end

      if (clocks >= max_clocks) begin
         $display("debug data at end = %d", dbg_data);
         `assert(dbg_data, 1 + 4 + 6)

         // 0 -> 1 + 4 + 6
         // 1 -> 2 + 4 + 6
         // 2 -> 3 + 4 + 6
         // 3 -> 1 + 4 + 12 + 6

         $display("Passed");
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
//,
//                      .wdata_temp_reg_dbg(wdata_temp_reg_dbg));
   
endmodule
