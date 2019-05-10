module mvmul_tb();
	reg [31:0] num_clocks_after_reset;
	reg [31:0] total_cycles;
	reg [31:0] max_cycles;
	reg [0:0] clk_reg;
	reg [0:0] rst_reg;
	wire [0:0] clk;
	wire [0:0] rst;
	reg [4:0] ram_debug_addr;
	wire [31:0] ram_debug_data;
	reg [4:0] ram_debug_write_addr;
	reg [31:0] ram_debug_write_data;
	reg [0:0] ram_debug_write_en;
	wire [4:0] ram_raddr_0;
	wire [4:0] ram_raddr_1;
	wire [4:0] ram_raddr_2;
	wire [31:0] ram_rdata_0;
	wire [31:0] ram_rdata_1;
	wire [31:0] ram_rdata_2;
	wire [4:0] ram_waddr_0;
	wire [31:0] ram_wdata_0;
	wire [0:0] ram_wen_0;

	initial begin
		#1 clk_reg = 0;
		#1 rst_reg = 1;
		#1 total_cycles = 0;
		#1 max_cycles = 400;
		#1 num_clocks_after_reset = 0;
	end

	assign clk = clk_reg;
	assign rst = rst_reg;

	always @(posedge clk) begin
		if (1 == total_cycles) begin ram_debug_write_addr <= 0; end
	end

	always @(posedge clk) begin
		if (1 == total_cycles) begin ram_debug_write_data <= 6; end
	end

	always @(posedge clk) begin
		if (1 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (2 == total_cycles) begin ram_debug_write_addr <= 1; end
	end

	always @(posedge clk) begin
		if (2 == total_cycles) begin ram_debug_write_data <= 1; end
	end

	always @(posedge clk) begin
		if (2 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (3 == total_cycles) begin ram_debug_write_addr <= 2; end
	end

	always @(posedge clk) begin
		if (3 == total_cycles) begin ram_debug_write_data <= 2; end
	end

	always @(posedge clk) begin
		if (3 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (4 == total_cycles) begin ram_debug_write_addr <= 3; end
	end

	always @(posedge clk) begin
		if (4 == total_cycles) begin ram_debug_write_data <= 3; end
	end

	always @(posedge clk) begin
		if (4 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (5 == total_cycles) begin ram_debug_write_addr <= 4; end
	end

	always @(posedge clk) begin
		if (5 == total_cycles) begin ram_debug_write_data <= 7; end
	end

	always @(posedge clk) begin
		if (5 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (6 == total_cycles) begin ram_debug_write_addr <= 5; end
	end

	always @(posedge clk) begin
		if (6 == total_cycles) begin ram_debug_write_data <= 5; end
	end

	always @(posedge clk) begin
		if (6 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (7 == total_cycles) begin ram_debug_write_addr <= 6; end
	end

	always @(posedge clk) begin
		if (7 == total_cycles) begin ram_debug_write_data <= 5; end
	end

	always @(posedge clk) begin
		if (7 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (8 == total_cycles) begin ram_debug_write_addr <= 7; end
	end

	always @(posedge clk) begin
		if (8 == total_cycles) begin ram_debug_write_data <= 2; end
	end

	always @(posedge clk) begin
		if (8 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (9 == total_cycles) begin ram_debug_write_addr <= 8; end
	end

	always @(posedge clk) begin
		if (9 == total_cycles) begin ram_debug_write_data <= 9; end
	end

	always @(posedge clk) begin
		if (9 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (10 == total_cycles) begin ram_debug_write_addr <= 9; end
	end

	always @(posedge clk) begin
		if (10 == total_cycles) begin ram_debug_write_data <= 9; end
	end

	always @(posedge clk) begin
		if (10 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (11 == total_cycles) begin ram_debug_write_addr <= 10; end
	end

	always @(posedge clk) begin
		if (11 == total_cycles) begin ram_debug_write_data <= 3; end
	end

	always @(posedge clk) begin
		if (11 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (12 == total_cycles) begin ram_debug_write_addr <= 11; end
	end

	always @(posedge clk) begin
		if (12 == total_cycles) begin ram_debug_write_data <= 7; end
	end

	always @(posedge clk) begin
		if (12 == total_cycles) begin ram_debug_write_en <= 1; end
	end

	always @(posedge clk) begin
		if (13 == total_cycles) begin ram_debug_write_en <= 0; end
	end

	always @(*) begin
		if (11 == total_cycles) begin rst_reg = 1; end
	end

	always @(*) begin
		if (12 == total_cycles) begin rst_reg = 0; end
	end

	always @(*) begin
		if (150 == total_cycles) begin ram_debug_addr = 12; end
	end

	always @(*) begin
		if (150 == total_cycles) begin if (!(ram_debug_data === 71)) begin $display("assertion(ram_debug_data === 71)"); $finish(); end end
	end

	always @(*) begin
		if (151 == total_cycles) begin ram_debug_addr = 13; end
	end

	always @(*) begin
		if (151 == total_cycles) begin if (!(ram_debug_data === 83)) begin $display("assertion(ram_debug_data === 83)"); $finish(); end end
	end

	always @(*) begin
		if (152 == total_cycles) begin ram_debug_addr = 14; end
	end

	always @(*) begin
		if (152 == total_cycles) begin if (!(ram_debug_data === 114)) begin $display("assertion(ram_debug_data === 114)"); $finish(); end end
	end

	always @(posedge clk) begin
		total_cycles <= total_cycles + 1;
	end

	always @(posedge clk) begin
		if (total_cycles >= max_cycles) begin $display("Passed"); $finish(); end
	end


	always #3 begin
		clk_reg = !clk_reg;
	end


	RAM3 #(.DEPTH(32), .WIDTH(32)) ram(.clk(clk), .debug_addr(ram_debug_addr), .debug_data(ram_debug_data), .debug_write_addr(ram_debug_write_addr), .debug_write_data(ram_debug_write_data), .debug_write_en(ram_debug_write_en), .raddr_0(ram_raddr_0), .raddr_1(ram_raddr_1), .raddr_2(ram_raddr_2), .rdata_0(ram_rdata_0), .rdata_1(ram_rdata_1), .rdata_2(ram_rdata_2), .rst(rst), .waddr_0(ram_waddr_0), .wdata_0(ram_wdata_0), .wen_0(ram_wen_0));

	mvmul dut(.clk(clk), .ram_debug_data(ram_debug_data), .ram_raddr_0(ram_raddr_0), .ram_raddr_1(ram_raddr_1), .ram_raddr_2(ram_raddr_2), .ram_rdata_0(ram_rdata_0), .ram_rdata_1(ram_rdata_1), .ram_rdata_2(ram_rdata_2), .ram_rst(ram_rst), .ram_waddr_0(ram_waddr_0), .ram_wdata_0(ram_wdata_0), .ram_wen_0(ram_wen_0), .rst(rst), .valid(valid));

endmodule
