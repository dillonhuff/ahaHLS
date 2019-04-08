module wire_32(input clk,
               input rst,
               input [31:0]  in_wire,
               output [31:0] out_wire);

   assign out_wire = in_wire;
   
endmodule // wire_32

module wire_8(input clk,
              input        rst,
              input [7:0]  in_wire,
              output [7:0] out_wire);

   assign out_wire = in_wire;
   
endmodule
