`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 1; #1 clk = 0;

module test();

   reg clk;
   reg rst;
   reg wen;
   reg [15:0] wdata;

   wire [31:0] rdata;
   wire        valid;


   initial begin
      #1 rst = 0;

      `POSEDGE

      #1 rst = 1;

      `POSEDGE

      #1 rst = 0;

      `assert(valid, 0)

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 0;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 1;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 2;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 3;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 4;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 5;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 6;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 7;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 8;

        `assert(valid, 0)      

      `POSEDGE

        $display("On first valid rdata = %b, {%d, %d}", rdata, rdata[31:16], rdata[15:0]);
      
      `assert(valid, 1)
      `assert(rdata[15:0], 16'd0)
      `assert(rdata[31:16], 16'd8)

      #1 wen = 0;
      // #1 wdata = 9;

      `POSEDGE

      `assert(valid, 0)        

      `POSEDGE
      `POSEDGE
      `POSEDGE

      #1 wen = 1;
      #1 wdata = 9;

      `POSEDGE

      #1 wen = 1;
      #1 wdata = 10;
        
      `assert(valid, 1)
      `assert(rdata[15:0], 16'd1)
      `assert(rdata[31:16], 16'd9)

      `POSEDGE      
        
   end
   
   
   push_linebuf #(.IN_WIDTH(16), .OUT_WIDTH(32)) dut(.clk(clk), .rst(rst), .wen(wen), .valid(valid), .wdata(wdata), .rdata(rdata));
   
endmodule
