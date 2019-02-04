
`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 0; #1 clk = 1; #1 clk = 1;

module RAM_1_3_32_32(input [0:0] clk, input [0:0] rst, output [31:0] rdata_0, input [4:0] raddr_0, input [0:0] ren_0, input [31:0] wdata_0, input [4:0] waddr_0, input [0:0] wen_0, input [4:0] debug_addr, output [31:0] debug_data, input [4:0] debug_write_addr, input [31:0] debug_write_data, input [0:0] debug_write_en);
	reg [31:0] rdata0_reg;
	wire [4:0] waddr_del;
	wire [31:0] wdata_del;
	wire [0:0] wen_del;

	initial begin
	end

	reg [31 : 0] data[31: 0];

	assign debug_data = data[debug_addr];
	assign rdata_0 = rdata0_reg;

	always @(posedge clk) begin
		if (wen_del) begin data[waddr_del] <= wdata_del; end if (debug_write_en) begin data[debug_write_addr] <= debug_write_data; end rdata0_reg <= data[raddr_0];
	end



	delay #(.WIDTH(1)) wen_delay(.clk(clk), .in(wen_0), .out(wen_del));

	delay #(.WIDTH(32)) wdata_delay(.clk(clk), .in(wdata_0), .out(wdata_del));

	delay #(.WIDTH(5)) waddr_delay(.clk(clk), .in(waddr_0), .out(waddr_del));

endmodule

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

      #1 dbg_addr = 0;
      #1 dbg_wr_addr = 0;
      #1 dbg_wr_data = 12;
      #1 dbg_wr_en = 1;
      
      `POSEDGE

      #1 rst = 0;        

      #1 dbg_wr_en = 0;        

      `POSEDGE

        // Load finished
        // Store start

      `POSEDGE
        
      `POSEDGE
        
      `POSEDGE

        `assert(dbg_data, 12 + 5)
        `assert(valid, 1'b1)
        
      `POSEDGE
      `POSEDGE
      `POSEDGE        
        `assert(dbg_data, 12 + 5)
        `assert(valid, 1'b1)
      `POSEDGE

      #1 $display("Passed");

   end // initial begin

   always @(posedge clk) begin
      $display("rdata_0 = %d", rdata_0);
      $display("raddr_0 = %d", raddr_0);
      $display("ren_0   = %d", ren_0);            
      $display("waddr_0 = %d", waddr_0);
      $display("wdata_0 = %d", wdata_0);
      $display("wen_0   = %d", wen_0);            
      $display("valid   = %d", valid);
      $display("dbg_data = %d", dbg_data);
      
   end

	RAM_1_3_32_32 ram(.clk(clk), .debug_addr(dbg_addr), .debug_data(dbg_data), .debug_write_addr(dbg_wr_addr), .debug_write_data(dbg_wr_data), .debug_write_en(dbg_wr_en), .raddr_0(raddr_0), .rdata_0(rdata_0), .rst(rst), .waddr_0(waddr_0), .wdata_0(wdata_0), .wen_0(wen_0));


   dynamic_arch_sram_class dut(.clk(clk), .arg_0_raddr_0(raddr_0), .arg_0_rdata_0(rdata_0), .rst(rst), .valid(valid), .arg_0_waddr_0(waddr_0), .arg_0_wdata_0(wdata_0), .arg_0_wen_0(wen_0));
   
endmodule
