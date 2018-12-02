`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end


// Significant problem in indenpendent testing of stalls: If the module issues
// a memory operation to the external mem that takes 3 cycles and then stalls
// for 5 cycles the memory operation will complete, passing data back to the
// module, but the module itself will not save the result of the completed operation
// because it is stalled
module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   wire [4:0] raddr;
   wire [4:0] waddr;
   wire [31:0] wdata;
   wire [0:0] wen;

   reg [4:0] debug_addr;
   wire [31:0] debug_data;

   reg [4:0]  debug_write_addr;
   
   reg [31:0] debug_write_data;
   
   reg        debug_write_en;
   
   wire [31:0] rdata;

   reg         global_stall;
   
   
   initial begin

      #1 debug_addr = 0;
      #1 global_stall = 0;
      #1 debug_write_addr = 1;
      #1 debug_write_data = 10;
      #1 debug_write_en = 1;

      #1 rst = 1;      

      #1 clk = 0;
      #1 clk = 1;

      // GS == 0

      #1 debug_write_en = 0;

      #1 `assert(debug_data, 32'hxxxxxxxx);
      #1 `assert(valid, 1'd0);
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      // GS == 1      

      #1 clk = 0;
      #1 clk = 1;

      // GS == 2

      #1 global_stall = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd0);
      
      #1 clk = 0;
      #1 clk = 1;

      #1 global_stall = 0;
      
      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd0);
      
      #1 clk = 0;
      #1 clk = 1;
      
      $display("debug_data = %d", debug_data);
      
      // In global state 3, we should be done, but reads have a delay of one
      #1 `assert(valid, 1'd0);      

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd20);            

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
           .debug_data(debug_data),

           .debug_write_addr(debug_write_addr),
           .debug_write_data(debug_write_data),
           .debug_write_en(debug_write_en));
   
   stalled_single_store ss(.clk(clk), .rst(rst), .valid(valid), .waddr_0(waddr), .wdata_0(wdata), .wen_0(wen), .raddr_0(raddr), .rdata_0(rdata));

endmodule
