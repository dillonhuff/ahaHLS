module load();
endmodule // load

module store();
endmodule

module add(input [31:0]  in0, input [31:0] in1, output [31:0] out);
   assign out = in0 + in1;
endmodule

module eq(input [31:0]  in0, input [31:0] in1, output [0:0] out);
   assign out = in0 == in1;
endmodule

module ret();
endmodule

module phi_2(input [31:0] last_block,
             input [31:0] s0,
             input [31:0] s1,             
             input [31:0] in0,
             input [31:0] in1,
             output [31:0] out);

   reg [31:0]              out_reg;

   always @(*) begin
      if (last_block == s0) begin
         out_reg = in0;
      end

      if (last_block == s1) begin
         out_reg = in1;
      end

   end

   assign out = out_reg;
   
   
endmodule

module br_dummy();
endmodule

module select(input sel, input [31:0] in0, input [31:0] in1, output [31:0] out);
   assign out = sel ? in1 : in0;
endmodule
