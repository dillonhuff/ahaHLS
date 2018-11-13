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

   reg [4:0] waddr;
   reg [31:0] wdata;
   reg [0:0] wen;

   reg [4:0] raddr0;
   reg [4:0] raddr1;
   
   wire [31:0] rdata0;
   wire [31:0] rdata1;   

   initial begin

      #1 rst = 1;
      
      #1 dbg_wr_addr = 10; // b[0]
      #1 dbg_wr_data = 10;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 0

      #1 dbg_wr_addr = 11; // b[1]
      #1 dbg_wr_data = 5;
      #1 dbg_wr_en = 1;
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 0

       #1 dbg_wr_en = 0; // a[0]
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 0

      #1 dbg_addr = 0;
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline,
      // iter 0 -> s1

      #2 $display("------ cycle bound");
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline,
      // iter 0 -> s2
      // iter 1 -> s1

      #2 $display("------ cycle bound");      
      // `assert(valid, 1'd0);                  

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s3
      // iter 1 -> s2
      // iter 2 -> s1      

      #2 $display("------ cycle bound");            

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s4
      // iter 1 -> s3
      // iter 2 -> s2
      // iter 3 -> s1      

      #2 $display("------ cycle bound");                  

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> s5
      // iter 1 -> s4
      // iter 2 -> s3
      // iter 3 -> s2
      // iter 4 -> s1

      #2 $display("------ cycle bound");
      
      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline
      // iter 0 -> finished
      // iter 1 -> s5
      // iter 2 -> s4
      // iter 3 -> s3
      // iter 4 -> s2
      // iter 5 -> s1

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline, iter 0 -> finished, iter 1 -> finished, iter 2 -> s5, iter 3 -> s4, iter 4 -> s3, iter 5 -> s2                        

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline, iter 0 -> finished, iter 1 -> finished, iter 2 -> finished, iter 3 -> s5, iter 4 -> s4, iter 5 -> s3                              

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline, iter 0 -> finished, iter 1 -> finished, iter 2 -> finished, iter 3 -> finished, iter 4 -> s5, iter 5 -> s4                                    

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline, iter 0 -> finished, iter 1 -> finished, iter 2 -> finished, iter 3 -> finished, iter 4 -> finished, iter 5 -> s5                                          
      $display("dbg_data = %d", dbg_data);
      
      `assert(valid, 1'd0);
      `assert(dbg_data, 32'd14);

      #1 clk = 0;
      #1 clk = 1;

      // gs == 1, in pipeline, iter 0 -> finished, iter 1 -> finished, iter 2 -> finished, iter 3 -> finished, iter 4 -> finished, iter 5 -> finished

      `assert(valid, 1'd1);      
      
      #1 clk = 0;
      #1 clk = 1;

      #1 dbg_addr = 1;

      $display("dbg_data = %d", dbg_data);
      
      `assert(valid, 1'd1);      
      `assert(dbg_data, 32'd9);
      
      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;
      
      $display("dbg_data = %d", dbg_data);
      
      `assert(valid, 1'd1);      
      `assert(dbg_data, 32'd9);

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
   
   loop_add_4 ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen), .raddr_0(raddr0), .rdata_0(rdata0));
   
endmodule
