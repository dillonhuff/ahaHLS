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
