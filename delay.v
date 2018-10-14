module delay(input clk, input [WIDTH - 1 : 0] in, output [WIDTH - 1 : 0] out);

   parameter WIDTH=1;

   reg [WIDTH - 1 : 0] reg0;
   reg [WIDTH - 1 : 0] reg1;

   always @(posedge clk) begin
      reg0 <= in;
      reg1 <= reg0;
   end

   assign out = reg1;
   
endmodule
