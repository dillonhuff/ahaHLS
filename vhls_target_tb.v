`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

module test();

   reg clk;
   reg rst;
   wire valid;

   initial begin
   end
   
   vhls_target dut(.clk(clk), .rst(rst), .valid(valid));
   
endmodule
