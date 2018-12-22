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

   wire [4:0] waddr;
   wire [31:0] wdata;
   wire [0:0] wen;

   wire [4:0] raddr0;
   wire [4:0] raddr1;
   
   wire [31:0] rdata0;
   wire [31:0] rdata1;   

   initial begin

      #1 rst = 1;
      
      #1 dbg_wr_addr = 10; // b[0]
      #1 dbg_wr_data = 10;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 $display("global state after first clk = %d", global_state_dbg);
      #1 `assert(global_state_dbg, 0)
      
      // gs == 0

      #1 dbg_wr_addr = 11; // b[1]
      #1 dbg_wr_data = 5;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 0

      #1 $display("global state after clk = %d", global_state_dbg);
      #1 `assert(global_state_dbg, 0)
      
       #1 dbg_wr_en = 0; // a[0]
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 0

      #1 $display("global state after clk = %d", global_state_dbg);
      #1 `assert(global_state_dbg, 0)
      
      #1 dbg_addr = 0;
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      // I cant actually tell if we are in the pipeline here, need to add
      // an assertion about internal state

      // gs == 1, in pipeline,
      // iter 0 -> s1

      #1 $display("global state after first non-rst clk = %d", global_state_dbg);
      #2 $display("-------");
      #2 $display("Now we are in the pipeline");
      #2 $display("-------");      

      #1 `assert(global_state_dbg, 200000) 

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline,
      // iter 0 -> s2
      // iter 1 -> s1

      `assert(valid, 1'd0)                  

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s3
      // iter 1 -> s2

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s4
      // iter 1 -> s3

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s5
      // iter 1 -> s4

      // #2 $display("-------");
      // #2 $display("First time all stages are occupied according to TB");
      // #2 $display("-------");

      `assert(valid, 1'd0)
      

      #1 clk = 0;
      #1 clk = 1;

      `assert(valid, 1'd0)      

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> s5

      #1 clk = 0;
      #1 clk = 1;

      `assert(valid, 1'd0)      
      
      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> finished

      #1 dbg_addr = 1;

      $display("dbg_data = %d", dbg_data);
      #1 `assert(global_state_dbg, 200000)       

      #1 `assert(valid, 1'd0)      
      #1 `assert(dbg_data, 32'd9)
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> finished
      // iter 2 -> finished      
      #1 `assert(valid, 1'd0)      
      #1 `assert(dbg_data, 32'd9)

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> finished
      // iter 2 -> finished      
      // iter 3 -> finished            

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> finished
      // iter 2 -> finished      
      // iter 3 -> finished            
      // iter 4 -> finished                  

      #1 `assert(valid, 1'd0)                        

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> finished
      // iter 2 -> finished      
      // iter 3 -> finished            
      // iter 4 -> finished                  
      // iter 5 -> finished                        

      #1 `assert(valid, 1'd1)                  

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd1)            
      
      #1 $display("Passed");

   end // initial begin

   always @(posedge clk) begin
      $display("-- In tb, waddr_0 = %d", waddr);
      $display("-- In tb, wdata_0 = %d", wdata);
      $display("-- In tb, raddr_0 = %d", raddr0);
      $display("-- In tb, rdata_0 = %d", rdata0);
      $display("-- dbg_data       = %d", dbg_data);
      $display("-- dbg_addr       = %d", dbg_addr);
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
   
   loop_add_4_6_iters ss(.clk(clk),
                         .rst(rst),
                         .valid(valid),
                         .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen),
                         .raddr_0(raddr0), .rdata_0(rdata0),
                         .global_state_dbg(global_state_dbg));
   
endmodule
