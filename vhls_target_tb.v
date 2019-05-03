module vhls_target_tb();
	reg [31:0] num_clocks_after_reset;
	reg [31:0] total_cycles;
	reg [31:0] max_cycles;
	reg [0:0] clk_reg;
	reg [0:0] rst_reg;
	wire [0:0] clk;
	wire [0:0] rst;
	wire [15:0] arg_0_data_bus;
	reg [15:0] arg_0_in_data_bus;
	reg [0:0] arg_0_in_last_bus;
	wire [0:0] arg_0_last_bus;
	wire [0:0] arg_0_read_ready;
	wire [0:0] arg_0_read_valid;
	wire [0:0] arg_0_write_ready;
	reg [0:0] arg_0_write_valid;
	wire [15:0] arg_1_data_bus;
	wire [15:0] arg_1_in_data_bus;
	wire [0:0] arg_1_in_last_bus;
	wire [0:0] arg_1_last_bus;
	wire [0:0] arg_1_read_ready;
	reg [0:0] arg_1_read_valid;
	wire [0:0] arg_1_write_ready;
	wire [0:0] arg_1_write_valid;

	initial begin
		#1 clk_reg = 0;
		#1 rst_reg = 1;
		#1 total_cycles = 0;
		#1 max_cycles = 1000;
		#1 num_clocks_after_reset = 0;
	end

	assign clk = clk_reg;
	assign rst = rst_reg;

	always @(posedge clk) begin
		if (1 == total_cycles) begin rst_reg <= 0; end
	end

	always @(posedge clk) begin
		if (3 == total_cycles) begin if (!(arg_1_read_ready === 0)) begin $display("assertion(arg_1_read_ready === 0) failed:  on cycle 3"); $finish(); end end
	end

	always @(posedge clk) begin
		if (10 == total_cycles) begin if (!(arg_1_read_ready === 0)) begin $display("assertion(arg_1_read_ready === 0) failed:  on cycle 10"); $finish(); end end
	end

	always @(posedge clk) begin
		if (15 == total_cycles) begin if (!(arg_1_read_ready === 0)) begin $display("assertion(arg_1_read_ready === 0) failed:  on cycle 15"); $finish(); end end
	end

	always @(posedge clk) begin
		if (17 == total_cycles) begin if (!(arg_1_read_ready === 0)) begin $display("assertion(arg_1_read_ready === 0) failed:  on cycle 17"); $finish(); end end
	end

	always @(posedge clk) begin
		if (22 == total_cycles) begin if (!(arg_1_read_ready === 0)) begin $display("assertion(arg_1_read_ready === 0) failed:  on cycle 22"); $finish(); end end
	end

	always @(posedge clk) begin
		if (25 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 25"); $finish(); end end
	end

	always @(posedge clk) begin
		if (37 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 37"); $finish(); end end
	end

	always @(posedge clk) begin
		if (43 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 43"); $finish(); end end
	end

	always @(posedge clk) begin
		if (47 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 47"); $finish(); end end
	end

	always @(posedge clk) begin
		if (50 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 50"); $finish(); end end
	end

	always @(posedge clk) begin
		if (100 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 100"); $finish(); end end
	end

	always @(posedge clk) begin
		if (103 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 103"); $finish(); end end
	end

	always @(posedge clk) begin
		if (106 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 106"); $finish(); end end
	end

	always @(posedge clk) begin
		if (112 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 112"); $finish(); end end
	end

	always @(posedge clk) begin
		if (125 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 125"); $finish(); end end
	end

	always @(posedge clk) begin
		if (150 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 150"); $finish(); end end
	end

	always @(posedge clk) begin
		if (200 == total_cycles) begin if (!(arg_1_read_ready === 1)) begin $display("assertion(arg_1_read_ready === 1) failed:  on cycle 200"); $finish(); end end
	end

	always @(posedge clk) begin
		if (700 == total_cycles) begin if (!(valid === 1)) begin $display("assertion(valid === 1)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (703 == total_cycles) begin if (!(arg_1_data_bus === 16'd56)) begin $display("assertion(arg_1_data_bus === 16'd56)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (703 == total_cycles) begin if (!(arg_1_last_bus === 1'b0)) begin $display("assertion(arg_1_last_bus === 1'b0)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (705 == total_cycles) begin if (!(arg_1_data_bus === 16'd20)) begin $display("assertion(arg_1_data_bus === 16'd20)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (705 == total_cycles) begin if (!(arg_1_last_bus === 1'b0)) begin $display("assertion(arg_1_last_bus === 1'b0)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (707 == total_cycles) begin if (!(arg_1_data_bus === 16'd14)) begin $display("assertion(arg_1_data_bus === 16'd14)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (707 == total_cycles) begin if (!(arg_1_last_bus === 1'b0)) begin $display("assertion(arg_1_last_bus === 1'b0)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (709 == total_cycles) begin if (!(arg_1_data_bus === 16'd6)) begin $display("assertion(arg_1_data_bus === 16'd6)"); $finish(); end end
	end

	always @(posedge clk) begin
		if (709 == total_cycles) begin if (!(arg_1_last_bus === 1'b1)) begin $display("assertion(arg_1_last_bus === 1'b1)"); $finish(); end end
	end

	always @(*) begin
		if (0 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (0 == total_cycles) begin arg_0_write_valid = 1'b0; end
	end

	always @(*) begin
		if (2 == total_cycles) begin arg_0_in_data_bus = 16'd28; end
	end

	always @(*) begin
		if (2 == total_cycles) begin arg_0_in_last_bus = 1'b0; end
	end

	always @(*) begin
		if (2 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (3 == total_cycles) begin arg_0_in_data_bus = 16'd10; end
	end

	always @(*) begin
		if (3 == total_cycles) begin arg_0_in_last_bus = 1'b0; end
	end

	always @(*) begin
		if (3 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (4 == total_cycles) begin arg_0_in_data_bus = 16'd7; end
	end

	always @(*) begin
		if (4 == total_cycles) begin arg_0_in_last_bus = 1'b0; end
	end

	always @(*) begin
		if (4 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (5 == total_cycles) begin arg_0_in_data_bus = 16'd3; end
	end

	always @(*) begin
		if (5 == total_cycles) begin arg_0_in_last_bus = 1'b1; end
	end

	always @(*) begin
		if (5 == total_cycles) begin arg_0_write_valid = 1'b1; end
	end

	always @(*) begin
		if (6 == total_cycles) begin arg_0_write_valid = 1'b0; end
	end

	always @(*) begin
		if (702 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (703 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (704 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (705 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (706 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (707 == total_cycles) begin arg_1_read_valid = 1'b0; end
	end

	always @(*) begin
		if (708 == total_cycles) begin arg_1_read_valid = 1'b1; end
	end

	always @(*) begin
		if (709 == total_cycles) begin arg_1_read_valid = 1'b0; end
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


	HLS_stream arg_0(.clk(clk), .data_bus(arg_0_data_bus), .in_data_bus(arg_0_in_data_bus), .in_last_bus(arg_0_in_last_bus), .last_bus(arg_0_last_bus), .read_ready(arg_0_read_ready), .read_valid(arg_0_read_valid), .rst(rst), .write_ready(arg_0_write_ready), .write_valid(arg_0_write_valid));

	HLS_stream arg_1(.clk(clk), .data_bus(arg_1_data_bus), .in_data_bus(arg_1_in_data_bus), .in_last_bus(arg_1_in_last_bus), .last_bus(arg_1_last_bus), .read_ready(arg_1_read_ready), .read_valid(arg_1_read_valid), .rst(rst), .write_ready(arg_1_write_ready), .write_valid(arg_1_write_valid));

	vhls_target dut(.arg_0_data_bus(arg_0_data_bus), .arg_0_last_bus(arg_0_last_bus), .arg_0_read_ready(arg_0_read_ready), .arg_0_read_valid(arg_0_read_valid), .arg_0_write_ready(arg_0_write_ready), .arg_1_data_bus(arg_1_data_bus), .arg_1_in_data_bus(arg_1_in_data_bus), .arg_1_in_last_bus(arg_1_in_last_bus), .arg_1_last_bus(arg_1_last_bus), .arg_1_read_ready(arg_1_read_ready), .arg_1_write_ready(arg_1_write_ready), .arg_1_write_valid(arg_1_write_valid), .clk(clk), .rst(rst), .valid(valid));

endmodule
