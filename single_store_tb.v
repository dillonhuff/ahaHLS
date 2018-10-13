module test();

   reg clk;
   reg rst;
   
   initial begin

      #1 

   end

   single_store(.clk(clk), .rst(rst));
   
endmodule
