`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 0; #1 clk = 1; #1 clk = 1;


module test();

   reg clk;
   reg rst;

   wire [31:0] raddr_0;
   wire [0:0]  ren_0;
   wire [31:0] rdata_0;
   wire [31:0] waddr_0;
   wire [31:0] wdata_0;
   wire [0:0]  wen_0;
   wire [31:0] rdata_store_0;
   wire [0:0]  valid;
   reg [4:0]   dbg_wr_addr;
   reg [31:0]  dbg_wr_data;
   reg [0:0]   dbg_wr_en;
   reg [4:0]   dbg_addr;
   wire [31:0] dbg_data;
   
   initial begin

      #1 rst = 1;

      `POSEDGE

        #1 rst = 0;
      

      // #1 `assert(write_ready0, 1'd1)
      // #1 `assert(read_ready0, 1'd0)

      // #1 in_data0 = 1;
      // #1 write_valid0 = 1;

      // `POSEDGE

      // write_valid0 = 0;

      // #1 `assert(write_ready0, 1'd0)
      // #1 `assert(read_ready0, 1'd1)
      
      // `POSEDGE

      //   read_valid0 = 1;

      // `POSEDGE

      //   read_valid0 = 0;

      // $display("out_data0 = %d", out_data0);
      
      // #1 `assert(out_data0, 1)
      // #1 `assert(write_ready0, 1'd1)
      // #1 `assert(read_ready0, 1'd0)

      #1 $display("Passed");

   end // initial begin


   dynamic_arch dut(.clk(clk), .raddr_0(raddr_0), .rdata_0(rdata_0), .ren_0(ren_0), .rst(rst), .valid(valid), .waddr_0(waddr_0), .wdata_0(wdata_0), .wen_0(wen_0));
   
endmodule
