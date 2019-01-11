`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 0; #1 clk = 1; #1 clk = 1;


module test();

   reg clk;
   reg rst;

   reg read_valid0;
   wire  read_ready0;

   wire write_ready0;
   reg  write_valid0;

   reg [31 : 0]  in_data0;
   wire [31 : 0] out_data0;

   initial begin

      #1 rst = 1;

      `POSEDGE

        #1 rst = 0;
      

      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd0)

      #1 in_data0 = 1;
      #1 write_valid0 = 1;

      `POSEDGE

      write_valid0 = 0;

      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd1)
      
      `POSEDGE

        read_valid0 = 1;

      `POSEDGE

        read_valid0 = 0;

      $display("out_data0 = %d", out_data0);
      
      #1 `assert(out_data0, 1)
      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd0)

      #1 $display("Passed");

      `POSEDGE

        #1 write_valid0 = 1;
      #1 in_data0 = 10;

      `POSEDGE

        #1 write_valid0 = 1;
      #1 in_data0 = 8;


      `POSEDGE

        #1 write_valid0 = 1;
      #1 in_data0 = 7;

      #1 read_valid0 = 1;

      `POSEDGE

        `assert(read_ready0, 1'b1)
        `assert(write_ready0, 1'b1)
        `assert(out_data0, 10)

      #1 write_valid0 = 0;

      #1 read_valid0 = 1;

      `POSEDGE

        `assert(read_ready0, 1'b1)
        `assert(write_ready0, 1'b1)
        `assert(out_data0, 8)
        
      #1 read_valid0 = 1;

      `POSEDGE

        #1 read_valid0 = 0;
      
      #1 `assert(read_ready0, 1'b0)
      #1 `assert(write_ready0, 1'b1)
      
      #1 `assert(out_data0, 7)

      `POSEDGE
      
      #1 $display("Passed");

      
   end // initial begin

   fifo #(.WIDTH(32), .DEPTH(3)) in(.clk(clk), .rst(rst), .read_valid(read_valid0), .read_ready(read_ready0), .write_ready(write_ready0), .write_valid(write_valid0), .out_data(out_data0), .in_data(in_data0));
   
endmodule
