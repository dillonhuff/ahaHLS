module run_median_func(input [0:0] clk, input [0:0] rst, output [0:0] valid, input [7:0] arg_0_pixel1, input [7:0] arg_0_pixel2, input [7:0] arg_0_pixel3, input [7:0] arg_0_pixel4, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, output [31:0] arg_1_in_wire, input [31:0] arg_1_out_wire, output [31:0] arg_2_in_wire, input [31:0] arg_2_out_wire, output [31:0] arg_3_in_wire, input [31:0] arg_3_out_wire, output [7:0] arg_4_in_wire, input [7:0] arg_4_out_wire, output [7:0] arg_5_in_wire, input [7:0] arg_5_out_wire, output [7:0] arg_6_in_wire, input [7:0] arg_6_out_wire, output [7:0] arg_7_in_wire, input [7:0] arg_7_out_wire);

	reg [0:0] valid_reg;
	reg [0:0] arg_0_rst_n_reg;
	reg [31:0] arg_0_word0_reg;
	reg [31:0] arg_0_word1_reg;
	reg [31:0] arg_0_word2_reg;
	reg [31:0] arg_1_in_wire_reg;
	reg [31:0] arg_2_in_wire_reg;
	reg [31:0] arg_3_in_wire_reg;
	reg [7:0] arg_4_in_wire_reg;
	reg [7:0] arg_5_in_wire_reg;
	reg [7:0] arg_6_in_wire_reg;
	reg [7:0] arg_7_in_wire_reg;

	assign valid = valid_reg;
	assign arg_0_rst_n = arg_0_rst_n_reg;
	assign arg_0_word0 = arg_0_word0_reg;
	assign arg_0_word1 = arg_0_word1_reg;
	assign arg_0_word2 = arg_0_word2_reg;
	assign arg_1_in_wire = arg_1_in_wire_reg;
	assign arg_2_in_wire = arg_2_in_wire_reg;
	assign arg_3_in_wire = arg_3_in_wire_reg;
	assign arg_4_in_wire = arg_4_in_wire_reg;
	assign arg_5_in_wire = arg_5_in_wire_reg;
	assign arg_6_in_wire = arg_6_in_wire_reg;
	assign arg_7_in_wire = arg_7_in_wire_reg;

	// Start debug wires and ports

	initial begin
	end



	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_60_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_8_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_16_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_8_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_16_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_60_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_60_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_8_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_16_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_8_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_16_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_60_out !== 1))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_58_out === 1) || andOp_62_out !== 1))) begin $display("assertion((!(andOp_58_out === 1) || andOp_62_out !== 1)) failed: Overlapping state active transition for state 1"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_62_out === 1) || andOp_58_out !== 1))) begin $display("assertion((!(andOp_62_out === 1) || andOp_58_out !== 1)) failed: Overlapping state active transition for state 1"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_59_out === 1) || andOp_64_out !== 1))) begin $display("assertion((!(andOp_59_out === 1) || andOp_64_out !== 1)) failed: Overlapping state active transition for state 2"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_64_out === 1) || andOp_59_out !== 1))) begin $display("assertion((!(andOp_64_out === 1) || andOp_59_out !== 1)) failed: Overlapping state active transition for state 2"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_60_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_70_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_70_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_16_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_16_out === 1) || andOp_8_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_16_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_70_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_70_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_60_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_60_out === 1) || andOp_8_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_70_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_70_out === 1) || andOp_16_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_70_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_70_out === 1) || andOp_60_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_70_out === 1) || andOp_8_out !== 1))) begin $display("assertion((!(andOp_70_out === 1) || andOp_8_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_16_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_16_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_60_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_60_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_8_out === 1) || andOp_70_out !== 1))) begin $display("assertion((!(andOp_8_out === 1) || andOp_70_out !== 1)) failed: Overlapping state active transition for state 3"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_3_is_active) || !(1'd0)))) begin $display("assertion((!(state_3_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_0_is_active) || !(1'd0)))) begin $display("assertion((!(state_0_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_1_is_active) || !(1'd0)))) begin $display("assertion((!(state_1_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_2_is_active) || !(1'd0)))) begin $display("assertion((!(state_2_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_0_is_active) || !(1'd0)))) begin $display("assertion((!(state_0_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_1_is_active) || !(1'd0)))) begin $display("assertion((!(state_1_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(state_2_is_active) || !(1'd0)))) begin $display("assertion((!(state_2_is_active) || !(1'd0)))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_79_out) || trunc_trunc21_out !== 20'dx))) begin $display("assertion((!(andOp_79_out) || trunc_trunc21_out !== 20'dx))"); $finish(); end
	end

	always @(posedge clk) begin
		if (!(!(andOp_80_out) || add_add20_in0 !== 32'dx)) begin $display("assertion(!(andOp_80_out) || add_add20_in0 !== 32'dx)"); $finish(); end
	end

	always @(posedge clk) begin
		if (!(!(andOp_80_out) || add_add20_in1 !== 32'dx)) begin $display("assertion(!(andOp_80_out) || add_add20_in1 !== 32'dx)"); $finish(); end
	end

	always @(posedge clk) begin
		if (!((!(andOp_81_out) || phi_phi16_out !== 'dx))) begin $display("assertion((!(andOp_81_out) || phi_phi16_out !== 'dx))"); $finish(); end
	end




	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	wire [31:0] sext_sext11_in;
	wire [63:0] sext_sext11_out;
	sext sext_sext11(.in(sext_sext11_in), .out(sext_sext11_out));

	wire [31:0] icmp_icmp12_in0;
	wire [31:0] icmp_icmp12_in1;
	wire [0:0] icmp_icmp12_out;
	slt #(.WIDTH(32)) icmp_icmp12(.in0(icmp_icmp12_in0), .in1(icmp_icmp12_in1), .out(icmp_icmp12_out));

	wire [39:0] phi_phi16_in;
	wire [31:0] phi_phi16_last_block;
	wire [63:0] phi_phi16_s;
	wire [31:0] phi_phi16_out;
	phi #(.NB_PAIR(2), .WIDTH(20)) phi_phi16(.in(phi_phi16_in), .last_block(phi_phi16_last_block), .out(phi_phi16_out), .s(phi_phi16_s));

	wire [31:0] sext_sext19_in;
	wire [63:0] sext_sext19_out;
	sext sext_sext19(.in(sext_sext19_in), .out(sext_sext19_out));

	wire [31:0] add_add20_in0;
	wire [31:0] add_add20_in1;
	wire [31:0] add_add20_out;
	add #(.WIDTH(32)) add_add20(.in0(add_add20_in0), .in1(add_add20_in1), .out(add_add20_out));

	wire [31:0] trunc_trunc21_in;
	wire [19:0] trunc_trunc21_out;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(20)) trunc_trunc21(.in(trunc_trunc21_in), .out(trunc_trunc21_out));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] bb_0_active_in_state_1_in_data;
	wire [0:0] bb_0_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_1(.in_data(bb_0_active_in_state_1_in_data), .out_data(bb_0_active_in_state_1_out_data));

	reg [31:0] bb_0_predecessor_in_state_1_in_data;
	wire [31:0] bb_0_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_1(.in_data(bb_0_predecessor_in_state_1_in_data), .out_data(bb_0_predecessor_in_state_1_out_data));

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	reg [0:0] bb_0_active_in_state_2_in_data;
	wire [0:0] bb_0_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_2(.in_data(bb_0_active_in_state_2_in_data), .out_data(bb_0_active_in_state_2_out_data));

	reg [31:0] bb_0_predecessor_in_state_2_in_data;
	wire [31:0] bb_0_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_2(.in_data(bb_0_predecessor_in_state_2_in_data), .out_data(bb_0_predecessor_in_state_2_out_data));

	reg [0:0] br_0_happened_in_state_2_in_data;
	wire [0:0] br_0_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_2(.in_data(br_0_happened_in_state_2_in_data), .out_data(br_0_happened_in_state_2_out_data));

	reg [0:0] bb_2_active_in_state_3_in_data;
	wire [0:0] bb_2_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_3(.in_data(bb_2_active_in_state_3_in_data), .out_data(bb_2_active_in_state_3_out_data));

	reg [31:0] bb_2_predecessor_in_state_3_in_data;
	wire [31:0] bb_2_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_3(.in_data(bb_2_predecessor_in_state_3_in_data), .out_data(bb_2_predecessor_in_state_3_out_data));

	reg [0:0] bb_1_active_in_state_3_in_data;
	wire [0:0] bb_1_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_3(.in_data(bb_1_active_in_state_3_in_data), .out_data(bb_1_active_in_state_3_out_data));

	reg [31:0] bb_1_predecessor_in_state_3_in_data;
	wire [31:0] bb_1_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_3(.in_data(bb_1_predecessor_in_state_3_in_data), .out_data(bb_1_predecessor_in_state_3_out_data));

	reg [0:0] br_1_happened_in_state_3_in_data;
	wire [0:0] br_1_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_3(.in_data(br_1_happened_in_state_3_in_data), .out_data(br_1_happened_in_state_3_out_data));

	reg [19:0] data_in_0_1_in_data;
	wire [19:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(20)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [19:0] data_in_1_3_in_data;
	wire [19:0] data_in_1_3_out_data;
	hls_wire #(.WIDTH(20)) data_in_1_3(.in_data(data_in_1_3_in_data), .out_data(data_in_1_3_out_data));

	reg [19:0] data_in_2_5_in_data;
	wire [19:0] data_in_2_5_out_data;
	hls_wire #(.WIDTH(20)) data_in_2_5(.in_data(data_in_2_5_in_data), .out_data(data_in_2_5_out_data));

	reg [19:0] data_in_3_7_in_data;
	wire [19:0] data_in_3_7_out_data;
	hls_wire #(.WIDTH(20)) data_in_3_7(.in_data(data_in_3_7_in_data), .out_data(data_in_3_7_out_data));

	wire [0:0] andOp_8_in0;
	wire [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	wire [0:0] notOp_9_in0;
	wire [0:0] notOp_9_out;
	notOp #(.WIDTH(1)) notOp_9(.in(notOp_9_in0), .out(notOp_9_out));

	wire [0:0] andOp_10_in0;
	wire [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	wire [0:0] notOp_11_in0;
	wire [0:0] notOp_11_out;
	notOp #(.WIDTH(1)) notOp_11(.in(notOp_11_in0), .out(notOp_11_out));

	wire [0:0] andOp_12_in0;
	wire [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	wire [0:0] notOp_13_in0;
	wire [0:0] notOp_13_out;
	notOp #(.WIDTH(1)) notOp_13(.in(notOp_13_in0), .out(notOp_13_out));

	wire [0:0] andOp_14_in0;
	wire [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	wire [0:0] notOp_15_in0;
	wire [0:0] notOp_15_out;
	notOp #(.WIDTH(1)) notOp_15(.in(notOp_15_in0), .out(notOp_15_out));

	wire [0:0] andOp_16_in0;
	wire [0:0] andOp_16_in1;
	wire [0:0] andOp_16_out;
	andOp #(.WIDTH(1)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

	wire [0:0] notOp_17_in0;
	wire [0:0] notOp_17_out;
	notOp #(.WIDTH(1)) notOp_17(.in(notOp_17_in0), .out(notOp_17_out));

	wire [0:0] andOp_18_in0;
	wire [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	wire [31:0] eq_19_in0;
	wire [31:0] eq_19_in1;
	wire [0:0] eq_19_out;
	eq #(.WIDTH(32)) eq_19(.in0(eq_19_in0), .in1(eq_19_in1), .out(eq_19_out));

	wire [31:0] eq_20_in0;
	wire [31:0] eq_20_in1;
	wire [0:0] eq_20_out;
	eq #(.WIDTH(32)) eq_20(.in0(eq_20_in0), .in1(eq_20_in1), .out(eq_20_out));

	wire [31:0] eq_21_in0;
	wire [31:0] eq_21_in1;
	wire [0:0] eq_21_out;
	eq #(.WIDTH(32)) eq_21(.in0(eq_21_in0), .in1(eq_21_in1), .out(eq_21_out));

	wire [31:0] eq_22_in0;
	wire [31:0] eq_22_in1;
	wire [0:0] eq_22_out;
	eq #(.WIDTH(32)) eq_22(.in0(eq_22_in0), .in1(eq_22_in1), .out(eq_22_out));

	wire [0:0] orOp_23_in0;
	wire [0:0] orOp_23_in1;
	wire [0:0] orOp_23_out;
	orOp #(.WIDTH(1)) orOp_23(.in0(orOp_23_in0), .in1(orOp_23_in1), .out(orOp_23_out));

	wire [31:0] eq_24_in0;
	wire [31:0] eq_24_in1;
	wire [0:0] eq_24_out;
	eq #(.WIDTH(32)) eq_24(.in0(eq_24_in0), .in1(eq_24_in1), .out(eq_24_out));

	wire [31:0] eq_25_in0;
	wire [31:0] eq_25_in1;
	wire [0:0] eq_25_out;
	eq #(.WIDTH(32)) eq_25(.in0(eq_25_in0), .in1(eq_25_in1), .out(eq_25_out));

	wire [31:0] eq_26_in0;
	wire [31:0] eq_26_in1;
	wire [0:0] eq_26_out;
	eq #(.WIDTH(32)) eq_26(.in0(eq_26_in0), .in1(eq_26_in1), .out(eq_26_out));

	wire [31:0] eq_27_in0;
	wire [31:0] eq_27_in1;
	wire [0:0] eq_27_out;
	eq #(.WIDTH(32)) eq_27(.in0(eq_27_in0), .in1(eq_27_in1), .out(eq_27_out));

	wire [31:0] eq_28_in0;
	wire [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

	wire [0:0] notOp_29_in0;
	wire [0:0] notOp_29_out;
	notOp #(.WIDTH(1)) notOp_29(.in(notOp_29_in0), .out(notOp_29_out));

	wire [0:0] andOp_30_in0;
	wire [0:0] andOp_30_in1;
	wire [0:0] andOp_30_out;
	andOp #(.WIDTH(1)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

	wire [31:0] eq_31_in0;
	wire [31:0] eq_31_in1;
	wire [0:0] eq_31_out;
	eq #(.WIDTH(32)) eq_31(.in0(eq_31_in0), .in1(eq_31_in1), .out(eq_31_out));

	wire [0:0] andOp_32_in0;
	wire [0:0] andOp_32_in1;
	wire [0:0] andOp_32_out;
	andOp #(.WIDTH(1)) andOp_32(.in0(andOp_32_in0), .in1(andOp_32_in1), .out(andOp_32_out));

	wire [0:0] andOp_33_in0;
	wire [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	wire [0:0] andOp_34_in0;
	wire [0:0] andOp_34_in1;
	wire [0:0] andOp_34_out;
	andOp #(.WIDTH(1)) andOp_34(.in0(andOp_34_in0), .in1(andOp_34_in1), .out(andOp_34_out));

	wire [0:0] andOp_35_in0;
	wire [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	wire [0:0] andOp_36_in0;
	wire [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	wire [0:0] andOp_37_in0;
	wire [0:0] andOp_37_in1;
	wire [0:0] andOp_37_out;
	andOp #(.WIDTH(1)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	wire [0:0] andOp_38_in0;
	wire [0:0] andOp_38_in1;
	wire [0:0] andOp_38_out;
	andOp #(.WIDTH(1)) andOp_38(.in0(andOp_38_in0), .in1(andOp_38_in1), .out(andOp_38_out));

	wire [0:0] andOp_39_in0;
	wire [0:0] andOp_39_in1;
	wire [0:0] andOp_39_out;
	andOp #(.WIDTH(1)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	wire [0:0] andOp_40_in0;
	wire [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	wire [0:0] andOp_41_in0;
	wire [0:0] andOp_41_in1;
	wire [0:0] andOp_41_out;
	andOp #(.WIDTH(1)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	wire [0:0] andOp_42_in0;
	wire [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	wire [0:0] andOp_43_in0;
	wire [0:0] andOp_43_in1;
	wire [0:0] andOp_43_out;
	andOp #(.WIDTH(1)) andOp_43(.in0(andOp_43_in0), .in1(andOp_43_in1), .out(andOp_43_out));

	wire [0:0] andOp_44_in0;
	wire [0:0] andOp_44_in1;
	wire [0:0] andOp_44_out;
	andOp #(.WIDTH(1)) andOp_44(.in0(andOp_44_in0), .in1(andOp_44_in1), .out(andOp_44_out));

	wire [0:0] andOp_45_in0;
	wire [0:0] andOp_45_in1;
	wire [0:0] andOp_45_out;
	andOp #(.WIDTH(1)) andOp_45(.in0(andOp_45_in0), .in1(andOp_45_in1), .out(andOp_45_out));

	wire [0:0] andOp_46_in0;
	wire [0:0] andOp_46_in1;
	wire [0:0] andOp_46_out;
	andOp #(.WIDTH(1)) andOp_46(.in0(andOp_46_in0), .in1(andOp_46_in1), .out(andOp_46_out));

	wire [0:0] andOp_47_in0;
	wire [0:0] andOp_47_in1;
	wire [0:0] andOp_47_out;
	andOp #(.WIDTH(1)) andOp_47(.in0(andOp_47_in0), .in1(andOp_47_in1), .out(andOp_47_out));

	wire [19:0] concat_48_in0;
	wire [19:0] concat_48_in1;
	wire [39:0] concat_48_out;
	concat #(.IN0_WIDTH(20), .IN1_WIDTH(20)) concat_48(.in0(concat_48_in0), .in1(concat_48_in1), .out(concat_48_out));

	wire [31:0] concat_49_in0;
	wire [31:0] concat_49_in1;
	wire [63:0] concat_49_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_49(.in0(concat_49_in0), .in1(concat_49_in1), .out(concat_49_out));

	wire [0:0] andOp_50_in0;
	wire [0:0] andOp_50_in1;
	wire [0:0] andOp_50_out;
	andOp #(.WIDTH(1)) andOp_50(.in0(andOp_50_in0), .in1(andOp_50_in1), .out(andOp_50_out));

	wire [0:0] andOp_51_in0;
	wire [0:0] andOp_51_in1;
	wire [0:0] andOp_51_out;
	andOp #(.WIDTH(1)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	wire [0:0] andOp_52_in0;
	wire [0:0] andOp_52_in1;
	wire [0:0] andOp_52_out;
	andOp #(.WIDTH(1)) andOp_52(.in0(andOp_52_in0), .in1(andOp_52_in1), .out(andOp_52_out));

	wire [0:0] andOp_53_in0;
	wire [0:0] andOp_53_in1;
	wire [0:0] andOp_53_out;
	andOp #(.WIDTH(1)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	wire [0:0] andOp_54_in0;
	wire [0:0] andOp_54_in1;
	wire [0:0] andOp_54_out;
	andOp #(.WIDTH(1)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	wire [0:0] andOp_55_in0;
	wire [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	wire [0:0] andOp_56_in0;
	wire [0:0] andOp_56_in1;
	wire [0:0] andOp_56_out;
	andOp #(.WIDTH(1)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

	wire [0:0] andOp_57_in0;
	wire [0:0] andOp_57_in1;
	wire [0:0] andOp_57_out;
	andOp #(.WIDTH(1)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

	wire [0:0] andOp_58_in0;
	wire [0:0] andOp_58_in1;
	wire [0:0] andOp_58_out;
	andOp #(.WIDTH(1)) andOp_58(.in0(andOp_58_in0), .in1(andOp_58_in1), .out(andOp_58_out));

	wire [0:0] andOp_59_in0;
	wire [0:0] andOp_59_in1;
	wire [0:0] andOp_59_out;
	andOp #(.WIDTH(1)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	wire [0:0] andOp_60_in0;
	wire [0:0] andOp_60_in1;
	wire [0:0] andOp_60_out;
	andOp #(.WIDTH(1)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	wire [0:0] notOp_61_in0;
	wire [0:0] notOp_61_out;
	notOp #(.WIDTH(1)) notOp_61(.in(notOp_61_in0), .out(notOp_61_out));

	wire [0:0] andOp_62_in0;
	wire [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	wire [0:0] notOp_63_in0;
	wire [0:0] notOp_63_out;
	notOp #(.WIDTH(1)) notOp_63(.in(notOp_63_in0), .out(notOp_63_out));

	wire [0:0] andOp_64_in0;
	wire [0:0] andOp_64_in1;
	wire [0:0] andOp_64_out;
	andOp #(.WIDTH(1)) andOp_64(.in0(andOp_64_in0), .in1(andOp_64_in1), .out(andOp_64_out));

	wire [0:0] notOp_65_in0;
	wire [0:0] notOp_65_out;
	notOp #(.WIDTH(1)) notOp_65(.in(notOp_65_in0), .out(notOp_65_out));

	wire [0:0] andOp_66_in0;
	wire [0:0] andOp_66_in1;
	wire [0:0] andOp_66_out;
	andOp #(.WIDTH(1)) andOp_66(.in0(andOp_66_in0), .in1(andOp_66_in1), .out(andOp_66_out));

	wire [0:0] notOp_67_in0;
	wire [0:0] notOp_67_out;
	notOp #(.WIDTH(1)) notOp_67(.in(notOp_67_in0), .out(notOp_67_out));

	wire [0:0] andOp_68_in0;
	wire [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	wire [0:0] notOp_69_in0;
	wire [0:0] notOp_69_out;
	notOp #(.WIDTH(1)) notOp_69(.in(notOp_69_in0), .out(notOp_69_out));

	wire [0:0] andOp_70_in0;
	wire [0:0] andOp_70_in1;
	wire [0:0] andOp_70_out;
	andOp #(.WIDTH(1)) andOp_70(.in0(andOp_70_in0), .in1(andOp_70_in1), .out(andOp_70_out));

	wire [31:0] eq_71_in0;
	wire [31:0] eq_71_in1;
	wire [0:0] eq_71_out;
	eq #(.WIDTH(32)) eq_71(.in0(eq_71_in0), .in1(eq_71_in1), .out(eq_71_out));

	wire [31:0] eq_72_in0;
	wire [31:0] eq_72_in1;
	wire [0:0] eq_72_out;
	eq #(.WIDTH(32)) eq_72(.in0(eq_72_in0), .in1(eq_72_in1), .out(eq_72_out));

	wire [31:0] eq_73_in0;
	wire [31:0] eq_73_in1;
	wire [0:0] eq_73_out;
	eq #(.WIDTH(32)) eq_73(.in0(eq_73_in0), .in1(eq_73_in1), .out(eq_73_out));

	wire [31:0] eq_74_in0;
	wire [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	wire [31:0] eq_75_in0;
	wire [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

	wire [31:0] eq_76_in0;
	wire [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	wire [31:0] eq_77_in0;
	wire [31:0] eq_77_in1;
	wire [0:0] eq_77_out;
	eq #(.WIDTH(32)) eq_77(.in0(eq_77_in0), .in1(eq_77_in1), .out(eq_77_out));

	wire [0:0] andOp_78_in0;
	wire [0:0] andOp_78_in1;
	wire [0:0] andOp_78_out;
	andOp #(.WIDTH(1)) andOp_78(.in0(andOp_78_in0), .in1(andOp_78_in1), .out(andOp_78_out));

	wire [0:0] andOp_79_in0;
	wire [0:0] andOp_79_in1;
	wire [0:0] andOp_79_out;
	andOp #(.WIDTH(1)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	wire [0:0] andOp_80_in0;
	wire [0:0] andOp_80_in1;
	wire [0:0] andOp_80_out;
	andOp #(.WIDTH(1)) andOp_80(.in0(andOp_80_in0), .in1(andOp_80_in1), .out(andOp_80_out));

	wire [0:0] andOp_81_in0;
	wire [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	// End Functional Units

	reg [19:0] data_store_0_0;
	reg [19:0] data_store_1_2;
	reg [19:0] data_store_2_4;
	reg [19:0] data_store_3_6;
	reg [31:0] global_state;
	reg [31:0] state_0_entry_BB_reg;
	reg [0:0] state_0_is_active;
	reg [31:0] state_0_last_BB_reg;
	reg [31:0] state_0_last_state;
	reg [31:0] state_1_entry_BB_reg;
	reg [0:0] state_1_is_active;
	reg [31:0] state_1_last_BB_reg;
	reg [31:0] state_1_last_state;
	reg [31:0] state_2_entry_BB_reg;
	reg [0:0] state_2_is_active;
	reg [31:0] state_2_last_BB_reg;
	reg [31:0] state_2_last_state;
	reg [31:0] state_3_entry_BB_reg;
	reg [0:0] state_3_is_active;
	reg [31:0] state_3_last_BB_reg;
	reg [31:0] state_3_last_state;

	// controller for add_add20.add_add20_in0
	// controller for add_add20.add_add20_in1
	// Insensitive connections
	assign add_add20_in0 = sext_sext19_out;
	assign add_add20_in1 = 32'd1;
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	assign andOp_10_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_10_in1 = state_2_is_active;
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	assign andOp_12_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_12_in1 = state_2_is_active;
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	assign andOp_14_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_14_in1 = state_3_is_active;
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	assign andOp_16_in0 = andOp_14_out;
	assign andOp_16_in1 = icmp_icmp12_out;
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	assign andOp_18_in0 = andOp_14_out;
	assign andOp_18_in1 = notOp_17_out;
	// controller for andOp_30.andOp_30_in0
	// controller for andOp_30.andOp_30_in1
	// Insensitive connections
	assign andOp_30_in0 = notOp_29_out;
	assign andOp_30_in1 = andOp_18_out;
	// controller for andOp_32.andOp_32_in0
	// controller for andOp_32.andOp_32_in1
	// Insensitive connections
	assign andOp_32_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_32_in1 = state_0_is_active;
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	assign andOp_33_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_33_in1 = state_1_is_active;
	// controller for andOp_34.andOp_34_in0
	// controller for andOp_34.andOp_34_in1
	// Insensitive connections
	assign andOp_34_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_34_in1 = state_2_is_active;
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	assign andOp_35_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_35_in1 = state_3_is_active;
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	assign andOp_36_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_36_in1 = state_3_is_active;
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	assign andOp_37_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_37_in1 = state_3_is_active;
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	assign andOp_38_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_38_in1 = state_3_is_active;
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	assign andOp_39_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_39_in1 = state_3_is_active;
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	assign andOp_40_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_40_in1 = state_3_is_active;
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	assign andOp_41_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_41_in1 = state_3_is_active;
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	assign andOp_42_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_42_in1 = state_3_is_active;
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	assign andOp_43_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_43_in1 = state_3_is_active;
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	assign andOp_44_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_44_in1 = state_3_is_active;
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	assign andOp_45_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_45_in1 = state_3_is_active;
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	assign andOp_46_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_46_in1 = state_3_is_active;
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	assign andOp_47_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_47_in1 = state_3_is_active;
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	assign andOp_50_in0 = bb_2_active_in_state_3_out_data;
	assign andOp_50_in1 = state_3_is_active;
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	assign andOp_51_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_51_in1 = state_3_is_active;
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	assign andOp_52_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_52_in1 = state_3_is_active;
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	assign andOp_53_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_53_in1 = state_3_is_active;
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	assign andOp_54_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_54_in1 = state_3_is_active;
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	assign andOp_55_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_55_in1 = state_3_is_active;
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	assign andOp_56_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_56_in1 = state_3_is_active;
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	assign andOp_57_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_57_in1 = state_3_is_active;
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	assign andOp_58_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_58_in1 = state_0_is_active;
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	assign andOp_59_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_59_in1 = state_1_is_active;
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	assign andOp_60_in0 = bb_2_active_in_state_3_out_data;
	assign andOp_60_in1 = state_3_is_active;
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	assign andOp_62_in0 = notOp_61_out;
	assign andOp_62_in1 = 1'd1;
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	assign andOp_64_in0 = notOp_63_out;
	assign andOp_64_in1 = 1'd1;
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	assign andOp_66_in0 = notOp_65_out;
	assign andOp_66_in1 = 1'd1;
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	assign andOp_68_in0 = notOp_67_out;
	assign andOp_68_in1 = andOp_66_out;
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	assign andOp_70_in0 = notOp_69_out;
	assign andOp_70_in1 = andOp_68_out;
	// controller for andOp_78.andOp_78_in0
	// controller for andOp_78.andOp_78_in1
	// Insensitive connections
	assign andOp_78_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_78_in1 = state_3_is_active;
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	assign andOp_79_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_79_in1 = state_3_is_active;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_8_in1 = state_2_is_active;
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	assign andOp_80_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_80_in1 = state_3_is_active;
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	assign andOp_81_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_81_in1 = state_3_is_active;
	// controller for arg_0.arg_0_rst_n_reg
	always @(*) begin
		if (andOp_32_out) begin 
			arg_0_rst_n_reg = 32'd1;
		end else if (andOp_33_out) begin 
			arg_0_rst_n_reg = 32'd0;
		end else if (andOp_34_out) begin 
			arg_0_rst_n_reg = 32'd1;
		end else begin
			arg_0_rst_n_reg = 1;
		end
	end
	// controller for arg_0.arg_0_word0_reg
	always @(*) begin
		if (andOp_37_out) begin 
			arg_0_word0_reg = arg_1_out_wire;
		end else begin
			arg_0_word0_reg = 0;
		end
	end
	// controller for arg_0.arg_0_word1_reg
	always @(*) begin
		if (andOp_39_out) begin 
			arg_0_word1_reg = arg_2_out_wire;
		end else begin
			arg_0_word1_reg = 0;
		end
	end
	// controller for arg_0.arg_0_word2_reg
	always @(*) begin
		if (andOp_35_out) begin 
			arg_0_word2_reg = arg_3_out_wire;
		end else begin
			arg_0_word2_reg = 0;
		end
	end
	// controller for arg_4.arg_4_in_wire_reg
	always @(*) begin
		if (andOp_56_out) begin 
			arg_4_in_wire_reg = arg_0_pixel1;
		end else begin
			arg_4_in_wire_reg = 0;
		end
	end
	// controller for arg_5.arg_5_in_wire_reg
	always @(*) begin
		if (andOp_55_out) begin 
			arg_5_in_wire_reg = arg_0_pixel2;
		end else begin
			arg_5_in_wire_reg = 0;
		end
	end
	// controller for arg_6.arg_6_in_wire_reg
	always @(*) begin
		if (andOp_45_out) begin 
			arg_6_in_wire_reg = arg_0_pixel3;
		end else begin
			arg_6_in_wire_reg = 0;
		end
	end
	// controller for arg_7.arg_7_in_wire_reg
	always @(*) begin
		if (andOp_54_out) begin 
			arg_7_in_wire_reg = arg_0_pixel4;
		end else begin
			arg_7_in_wire_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_19_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_20_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_2.bb_0_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_2_in_data = eq_21_out;
		end else begin
			bb_0_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_25_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_26_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_2.bb_0_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_27_out) begin 
			bb_0_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_3.bb_1_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_3_in_data = eq_24_out;
		end else begin
			bb_1_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_3.bb_1_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_31_out) begin 
			bb_1_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_3.bb_2_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_3_in_data = orOp_23_out;
		end else begin
			bb_2_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_3.bb_2_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_30_out) begin 
			bb_2_predecessor_in_state_3_in_data = 32'd1;
		end else if (eq_28_out) begin 
			bb_2_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_8_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_9_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_10_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_11_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_2.br_0_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_0_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_13_out) begin 
			br_0_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_3.br_1_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_14_out) begin 
			br_1_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_15_out) begin 
			br_1_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_3_in_data = 0;
		end
	end
	// controller for concat_48.concat_48_in0
	// controller for concat_48.concat_48_in1
	// Insensitive connections
	assign concat_48_in0 = 20'd0;
	assign concat_48_in1 = data_in_3_7_out_data;
	// controller for concat_49.concat_49_in0
	// controller for concat_49.concat_49_in1
	// Insensitive connections
	assign concat_49_in0 = 32'd0;
	assign concat_49_in1 = 32'd1;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_71_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_3.data_in_1_3_in_data
	always @(*) begin
		if (eq_72_out) begin 
			data_in_1_3_in_data = data_store_0_0;
		end else if (eq_73_out) begin 
			data_in_1_3_in_data = data_store_1_2;
		end else begin
			data_in_1_3_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_74_out) begin 
			data_in_2_5_in_data = data_store_1_2;
		end else if (eq_75_out) begin 
			data_in_2_5_in_data = data_store_2_4;
		end else begin
			data_in_2_5_in_data = 0;
		end
	end
	// controller for data_in_3_7.data_in_3_7_in_data
	always @(*) begin
		if (eq_76_out) begin 
			data_in_3_7_in_data = data_store_2_4;
		end else if (eq_77_out) begin 
			data_in_3_7_in_data = data_store_3_6;
		end else begin
			data_in_3_7_in_data = 0;
		end
	end
	// controller for eq_19.eq_19_in0
	// controller for eq_19.eq_19_in1
	// Insensitive connections
	assign eq_19_in0 = 32'd0;
	assign eq_19_in1 = state_0_entry_BB_reg;
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	assign eq_20_in0 = 32'd0;
	assign eq_20_in1 = state_1_entry_BB_reg;
	// controller for eq_21.eq_21_in0
	// controller for eq_21.eq_21_in1
	// Insensitive connections
	assign eq_21_in0 = 32'd0;
	assign eq_21_in1 = state_2_entry_BB_reg;
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	assign eq_22_in0 = 32'd2;
	assign eq_22_in1 = state_3_entry_BB_reg;
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	assign eq_24_in0 = 32'd1;
	assign eq_24_in1 = state_3_entry_BB_reg;
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	assign eq_25_in0 = 32'd0;
	assign eq_25_in1 = state_0_entry_BB_reg;
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	assign eq_26_in0 = 32'd0;
	assign eq_26_in1 = state_1_entry_BB_reg;
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	assign eq_27_in0 = 32'd0;
	assign eq_27_in1 = state_2_entry_BB_reg;
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	assign eq_28_in0 = 32'd2;
	assign eq_28_in1 = state_3_entry_BB_reg;
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	assign eq_31_in0 = 32'd1;
	assign eq_31_in1 = state_3_entry_BB_reg;
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	assign eq_71_in0 = 32'd0;
	assign eq_71_in1 = state_0_last_state;
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	assign eq_72_in0 = 32'd0;
	assign eq_72_in1 = state_1_last_state;
	// controller for eq_73.eq_73_in0
	// controller for eq_73.eq_73_in1
	// Insensitive connections
	assign eq_73_in0 = 32'd1;
	assign eq_73_in1 = state_1_last_state;
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	assign eq_74_in0 = 32'd1;
	assign eq_74_in1 = state_2_last_state;
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	assign eq_75_in0 = 32'd2;
	assign eq_75_in1 = state_2_last_state;
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	assign eq_76_in0 = 32'd2;
	assign eq_76_in1 = state_3_last_state;
	// controller for eq_77.eq_77_in0
	// controller for eq_77.eq_77_in1
	// Insensitive connections
	assign eq_77_in0 = 32'd3;
	assign eq_77_in1 = state_3_last_state;
	// controller for icmp_icmp12.icmp_icmp12_in0
	// controller for icmp_icmp12.icmp_icmp12_in1
	// Insensitive connections
	assign icmp_icmp12_in0 = sext_sext11_out;
	assign icmp_icmp12_in1 = 32'd101125;
	// controller for notOp_11.notOp_11_in0
	// Insensitive connections
	assign notOp_11_in0 = andOp_10_out;
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	assign notOp_13_in0 = andOp_12_out;
	// controller for notOp_15.notOp_15_in0
	// Insensitive connections
	assign notOp_15_in0 = andOp_14_out;
	// controller for notOp_17.notOp_17_in0
	// Insensitive connections
	assign notOp_17_in0 = icmp_icmp12_out;
	// controller for notOp_29.notOp_29_in0
	// Insensitive connections
	assign notOp_29_in0 = eq_28_out;
	// controller for notOp_61.notOp_61_in0
	// Insensitive connections
	assign notOp_61_in0 = andOp_58_out;
	// controller for notOp_63.notOp_63_in0
	// Insensitive connections
	assign notOp_63_in0 = andOp_59_out;
	// controller for notOp_65.notOp_65_in0
	// Insensitive connections
	assign notOp_65_in0 = andOp_16_out;
	// controller for notOp_67.notOp_67_in0
	// Insensitive connections
	assign notOp_67_in0 = andOp_60_out;
	// controller for notOp_69.notOp_69_in0
	// Insensitive connections
	assign notOp_69_in0 = andOp_8_out;
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	assign notOp_9_in0 = andOp_8_out;
	// controller for orOp_23.orOp_23_in0
	// controller for orOp_23.orOp_23_in1
	// Insensitive connections
	assign orOp_23_in0 = eq_22_out;
	assign orOp_23_in1 = andOp_18_out;
	// controller for phi_phi16.phi_phi16_in
	// controller for phi_phi16.phi_phi16_last_block
	// controller for phi_phi16.phi_phi16_s
	// Insensitive connections
	assign phi_phi16_in = concat_48_out;
	assign phi_phi16_last_block = bb_1_predecessor_in_state_3_out_data;
	assign phi_phi16_s = concat_49_out;
	// controller for ret17.valid_reg
	always @(*) begin
		if (andOp_50_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for sext_sext11.sext_sext11_in
	// Insensitive connections
	assign sext_sext11_in = trunc_trunc21_out;
	// controller for sext_sext19.sext_sext19_in
	// Insensitive connections
	assign sext_sext19_in = phi_phi16_out;
	// controller for trunc_trunc21.trunc_trunc21_in
	// Insensitive connections
	assign trunc_trunc21_in = add_add20_out;
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			data_store_0_0 <= 0;
		end else begin
			if (state_0_is_active) begin
				data_store_0_0 <= data_in_0_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_2 <= 0;
		end else begin
			if (state_1_is_active) begin
				data_store_1_2 <= data_in_1_3_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_4 <= 0;
		end else begin
			if (state_2_is_active) begin
				data_store_2_4 <= data_in_2_5_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_6 <= 0;
		end else begin
			if (andOp_78_out) begin
				data_store_3_6 <= trunc_trunc21_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_16_out) begin
				global_state <= 32'd3;
			end
			if (andOp_58_out) begin
				global_state <= 32'd1;
			end
			if (andOp_59_out) begin
				global_state <= 32'd2;
			end
			if (andOp_60_out) begin
				global_state <= 32'd3;
			end
			if (andOp_8_out) begin
				global_state <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_entry_BB_reg <= 0;
		end else begin
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_is_active <= 1;
		end else begin
			if (1'd1) begin
				state_0_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_last_BB_reg <= 0;
		end else begin
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_last_state <= 0;
		end else begin
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_entry_BB_reg <= 0;
		end else begin
			if (andOp_58_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_58_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_62_out) begin
				state_1_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_58_out) begin
				state_1_last_BB_reg <= bb_0_predecessor_in_state_0_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_58_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_59_out) begin
				state_2_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_59_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_64_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_59_out) begin
				state_2_last_BB_reg <= bb_0_predecessor_in_state_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_59_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_16_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
			if (andOp_60_out) begin
				state_3_entry_BB_reg <= 32'd2;
			end
			if (andOp_8_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_16_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_60_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_70_out) begin
				state_3_is_active <= 1'd0;
			end
			if (andOp_8_out) begin
				state_3_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_16_out) begin
				state_3_last_BB_reg <= 32'd1;
			end
			if (andOp_60_out) begin
				state_3_last_BB_reg <= bb_2_predecessor_in_state_3_out_data;
			end
			if (andOp_8_out) begin
				state_3_last_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_16_out) begin
				state_3_last_state <= 32'd3;
			end
			if (andOp_60_out) begin
				state_3_last_state <= 32'd3;
			end
			if (andOp_8_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

endmodule

