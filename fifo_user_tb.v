`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;

   wire read_valid0;
   wire  read_ready0;

   wire write_ready0;
   reg  write_valid0;

   reg [31 : 0]  in_data0;
   wire [31 : 0] out_data0;

   wire read_valid1;
   wire  read_ready1;

   wire write_ready1;
   wire  write_valid1;

   reg [31 : 0]  in_data1;
   wire [31 : 0] out_data1;
   
   initial begin

      #1 rst = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 rst = 0;

      #1 `assert(valid, 1'd0)
      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd0)

      #1 `assert(read_ready1, 1'd0)

      in_data0 = 791;
      write_valid0 = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 write_valid0 = 0;

      
      #1 `assert(valid, 1'd0)
      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd1)

      #1 `assert(read_ready1, 1'd0)
      
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

      #1 `assert(read_ready1, 1'd1)
      #1 `assert(valid, 1'd1)
      
      #1 clk = 0;
      #1 clk = 1;
      
      
      #1 $display("Passed");

   end // initial begin

   fifo #(.WIDTH(32), .DEPTH(16)) in(.clk(clk), .rst(rst), .read_valid(read_valid0), .read_ready(read_ready0), .write_ready(write_ready0), .write_valid(write_valid0));

   fifo #(.WIDTH(32), .DEPTH(16)) out(.clk(clk), .rst(rst), .read_valid(read_valid1), .read_ready(read_ready1), .write_ready(write_ready1), .write_valid(write_valid1));

   fifo_user ss(.clk(clk), .rst(rst), .valid(valid), .fifo_1_write_valid(write_valid1));
   
endmodule
