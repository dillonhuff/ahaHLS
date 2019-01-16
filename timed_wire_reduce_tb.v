`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 0; #1 clk = 1; #1 clk = 1;


module test();

   reg clk;
   reg rst;

   reg [31 : 0]  in_data0;
   wire [31 : 0] out_data0;

   initial begin

      #1 rst = 1;

      `POSEDGE

        #1 rst = 0;
      

      #1 in_data0 = 1;

      `POSEDGE

        #1 in_data0 = 8;
        
      `POSEDGE

        #1 in_data0 = 7;
        
      `POSEDGE

        #1 in_data0 = 4;        

      $display("out_data0 = %d", out_data0);
      
      #1 `assert(out_data0, 1 + 8 + 7  + 4)

      `POSEDGE

      #1 $display("Passed");
      
   end // initial begin
   
   timed_wire_reduce dut(.clk(clk), .rst(rst), .valid(valid), .fifo_0_out_data(in_data0), .fifo_1_in_data(out_data0));
   
endmodule
