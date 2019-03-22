module const_bit_32_0(input clk,
                      input rst,
                      output [31:0] out);

   assign out = 0;
   
endmodule
   
module const_bit_32_1(input clk,
                      input rst,
                      output [31:0] out);

   assign out = 1;
   
endmodule
   

module const_bit_32_10(input clk,
                      input rst,
                      output [31:0] out);

   assign out = 10;
   
endmodule
   
module reg_bit_32(input clk,
                  input rst,

                  input [31:0] in,
                  input en,
                  output [31:0] current);

   reg [31:0]                   data;
   always @(posedge clk) begin
      if (en) begin
         data <= in;
      end
   end
   
   assign current = data;
   
endmodule

module adder_bit_32(input clk,
                    input         rst,

                    input [31:0]  in0,
                    input [31:0]  in1,
                    output [31:0] out);

   assign out = in0 + in1;
   
endmodule

module reg_32(input clk,
              input         rst,

              input [31:0]  in,
              input         en,
              output [31:0] out);

   reg [31:0]                   data;
   always @(posedge clk) begin
      if (en) begin
         data <= in;
      end
   end
   
   assign out = data;
   
endmodule
