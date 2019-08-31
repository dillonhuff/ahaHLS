module smul_fifo(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [31:0] arg_0_in_data, input [31:0] arg_0_out_data, input [0:0] arg_0_read_ready, output [0:0] arg_0_read_valid, input [0:0] arg_0_write_ready, output [0:0] arg_0_write_valid, output [31:0] arg_1_in_data, input [31:0] arg_1_out_data, input [0:0] arg_1_read_ready, output [0:0] arg_1_read_valid, input [0:0] arg_1_write_ready, output [0:0] arg_1_write_valid);

	reg [0:0] valid_reg;
	reg [31:0] arg_0_in_data_reg;
	reg [0:0] arg_0_read_valid_reg;
	reg [0:0] arg_0_write_valid_reg;
	reg [31:0] arg_1_in_data_reg;
	reg [0:0] arg_1_read_valid_reg;
	reg [0:0] arg_1_write_valid_reg;

	assign valid = valid_reg;
	assign arg_0_in_data = arg_0_in_data_reg;
	assign arg_0_read_valid = arg_0_read_valid_reg;
	assign arg_0_write_valid = arg_0_write_valid_reg;
	assign arg_1_in_data = arg_1_in_data_reg;
	assign arg_1_read_valid = arg_1_read_valid_reg;
	assign arg_1_write_valid = arg_1_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end






	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	wire [63:0] phi_phi1_in;
	wire [31:0] phi_phi1_last_block;
	wire [63:0] phi_phi1_s;
	wire [31:0] phi_phi1_out;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_phi1(.in(phi_phi1_in), .last_block(phi_phi1_last_block), .out(phi_phi1_out), .s(phi_phi1_s));

	wire [31:0] mul_mul8_in0;
	wire [31:0] mul_mul8_in1;
	wire [31:0] mul_mul8_out;
	mul #(.WIDTH(32)) mul_mul8(.in0(mul_mul8_in0), .in1(mul_mul8_in1), .out(mul_mul8_out));

	wire [31:0] icmp_icmp9_in0;
	wire [31:0] icmp_icmp9_in1;
	wire [0:0] icmp_icmp9_out;
	ne #(.WIDTH(32)) icmp_icmp9(.in0(icmp_icmp9_in0), .in1(icmp_icmp9_in1), .out(icmp_icmp9_out));

	wire [31:0] add_add6_in0;
	wire [31:0] add_add6_in1;
	wire [31:0] add_add6_out;
	add #(.WIDTH(32)) add_add6(.in0(add_add6_in0), .in1(add_add6_in1), .out(add_add6_out));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] bb_5_active_in_state_0_in_data;
	wire [0:0] bb_5_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_5_active_in_state_0(.in_data(bb_5_active_in_state_0_in_data), .out_data(bb_5_active_in_state_0_out_data));

	reg [31:0] bb_5_predecessor_in_state_0_in_data;
	wire [31:0] bb_5_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_5_predecessor_in_state_0(.in_data(bb_5_predecessor_in_state_0_in_data), .out_data(bb_5_predecessor_in_state_0_out_data));

	reg [0:0] br_5_happened_in_state_0_in_data;
	wire [0:0] br_5_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened_in_state_0(.in_data(br_5_happened_in_state_0_in_data), .out_data(br_5_happened_in_state_0_out_data));

	reg [0:0] bb_6_active_in_state_0_in_data;
	wire [0:0] bb_6_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_6_active_in_state_0(.in_data(bb_6_active_in_state_0_in_data), .out_data(bb_6_active_in_state_0_out_data));

	reg [31:0] bb_6_predecessor_in_state_0_in_data;
	wire [31:0] bb_6_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_6_predecessor_in_state_0(.in_data(bb_6_predecessor_in_state_0_in_data), .out_data(bb_6_predecessor_in_state_0_out_data));

	reg [0:0] br_6_happened_in_state_0_in_data;
	wire [0:0] br_6_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened_in_state_0(.in_data(br_6_happened_in_state_0_in_data), .out_data(br_6_happened_in_state_0_out_data));

	reg [0:0] bb_1_active_in_state_0_in_data;
	wire [0:0] bb_1_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_0(.in_data(bb_1_active_in_state_0_in_data), .out_data(bb_1_active_in_state_0_out_data));

	reg [31:0] bb_1_predecessor_in_state_0_in_data;
	wire [31:0] bb_1_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_0(.in_data(bb_1_predecessor_in_state_0_in_data), .out_data(bb_1_predecessor_in_state_0_out_data));

	reg [0:0] br_1_happened_in_state_0_in_data;
	wire [0:0] br_1_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_0(.in_data(br_1_happened_in_state_0_in_data), .out_data(br_1_happened_in_state_0_out_data));

	reg [0:0] bb_7_active_in_state_1_in_data;
	wire [0:0] bb_7_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_7_active_in_state_1(.in_data(bb_7_active_in_state_1_in_data), .out_data(bb_7_active_in_state_1_out_data));

	reg [31:0] bb_7_predecessor_in_state_1_in_data;
	wire [31:0] bb_7_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_7_predecessor_in_state_1(.in_data(bb_7_predecessor_in_state_1_in_data), .out_data(bb_7_predecessor_in_state_1_out_data));

	reg [0:0] br_7_happened_in_state_1_in_data;
	wire [0:0] br_7_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_1(.in_data(br_7_happened_in_state_1_in_data), .out_data(br_7_happened_in_state_1_out_data));

	reg [0:0] bb_2_active_in_state_2_in_data;
	wire [0:0] bb_2_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_2(.in_data(bb_2_active_in_state_2_in_data), .out_data(bb_2_active_in_state_2_out_data));

	reg [31:0] bb_2_predecessor_in_state_2_in_data;
	wire [31:0] bb_2_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_2(.in_data(bb_2_predecessor_in_state_2_in_data), .out_data(bb_2_predecessor_in_state_2_out_data));

	reg [0:0] br_2_happened_in_state_2_in_data;
	wire [0:0] br_2_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened_in_state_2(.in_data(br_2_happened_in_state_2_in_data), .out_data(br_2_happened_in_state_2_out_data));

	reg [0:0] bb_7_active_in_state_2_in_data;
	wire [0:0] bb_7_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_7_active_in_state_2(.in_data(bb_7_active_in_state_2_in_data), .out_data(bb_7_active_in_state_2_out_data));

	reg [31:0] bb_7_predecessor_in_state_2_in_data;
	wire [31:0] bb_7_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_7_predecessor_in_state_2(.in_data(bb_7_predecessor_in_state_2_in_data), .out_data(bb_7_predecessor_in_state_2_out_data));

	reg [0:0] br_7_happened_in_state_2_in_data;
	wire [0:0] br_7_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_2(.in_data(br_7_happened_in_state_2_in_data), .out_data(br_7_happened_in_state_2_out_data));

	reg [0:0] bb_8_active_in_state_2_in_data;
	wire [0:0] bb_8_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_8_active_in_state_2(.in_data(bb_8_active_in_state_2_in_data), .out_data(bb_8_active_in_state_2_out_data));

	reg [31:0] bb_8_predecessor_in_state_2_in_data;
	wire [31:0] bb_8_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_8_predecessor_in_state_2(.in_data(bb_8_predecessor_in_state_2_in_data), .out_data(bb_8_predecessor_in_state_2_out_data));

	reg [0:0] br_8_happened_in_state_2_in_data;
	wire [0:0] br_8_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened_in_state_2(.in_data(br_8_happened_in_state_2_in_data), .out_data(br_8_happened_in_state_2_out_data));

	reg [0:0] bb_9_active_in_state_2_in_data;
	wire [0:0] bb_9_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_9_active_in_state_2(.in_data(bb_9_active_in_state_2_in_data), .out_data(bb_9_active_in_state_2_out_data));

	reg [31:0] bb_9_predecessor_in_state_2_in_data;
	wire [31:0] bb_9_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_9_predecessor_in_state_2(.in_data(bb_9_predecessor_in_state_2_in_data), .out_data(bb_9_predecessor_in_state_2_out_data));

	reg [0:0] br_9_happened_in_state_2_in_data;
	wire [0:0] br_9_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened_in_state_2(.in_data(br_9_happened_in_state_2_in_data), .out_data(br_9_happened_in_state_2_out_data));

	reg [0:0] bb_3_active_in_state_2_in_data;
	wire [0:0] bb_3_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active_in_state_2(.in_data(bb_3_active_in_state_2_in_data), .out_data(bb_3_active_in_state_2_out_data));

	reg [31:0] bb_3_predecessor_in_state_2_in_data;
	wire [31:0] bb_3_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_3_predecessor_in_state_2(.in_data(bb_3_predecessor_in_state_2_in_data), .out_data(bb_3_predecessor_in_state_2_out_data));

	reg [0:0] br_3_happened_in_state_2_in_data;
	wire [0:0] br_3_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_2(.in_data(br_3_happened_in_state_2_in_data), .out_data(br_3_happened_in_state_2_out_data));

	reg [0:0] bb_10_active_in_state_2_in_data;
	wire [0:0] bb_10_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active_in_state_2(.in_data(bb_10_active_in_state_2_in_data), .out_data(bb_10_active_in_state_2_out_data));

	reg [31:0] bb_10_predecessor_in_state_2_in_data;
	wire [31:0] bb_10_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor_in_state_2(.in_data(bb_10_predecessor_in_state_2_in_data), .out_data(bb_10_predecessor_in_state_2_out_data));

	reg [0:0] br_10_happened_in_state_2_in_data;
	wire [0:0] br_10_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_2(.in_data(br_10_happened_in_state_2_in_data), .out_data(br_10_happened_in_state_2_out_data));

	reg [0:0] bb_4_active_in_state_2_in_data;
	wire [0:0] bb_4_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_2(.in_data(bb_4_active_in_state_2_in_data), .out_data(bb_4_active_in_state_2_out_data));

	reg [31:0] bb_4_predecessor_in_state_2_in_data;
	wire [31:0] bb_4_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_2(.in_data(bb_4_predecessor_in_state_2_in_data), .out_data(bb_4_predecessor_in_state_2_out_data));

	reg [31:0] data_in_0_1_in_data;
	wire [31:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [31:0] data_in_0_3_in_data;
	wire [31:0] data_in_0_3_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_3(.in_data(data_in_0_3_in_data), .out_data(data_in_0_3_out_data));

	reg [31:0] data_in_1_5_in_data;
	wire [31:0] data_in_1_5_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_5(.in_data(data_in_1_5_in_data), .out_data(data_in_1_5_out_data));

	reg [31:0] data_in_1_7_in_data;
	wire [31:0] data_in_1_7_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_7(.in_data(data_in_1_7_in_data), .out_data(data_in_1_7_out_data));

	reg [31:0] data_in_2_9_in_data;
	wire [31:0] data_in_2_9_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_9(.in_data(data_in_2_9_in_data), .out_data(data_in_2_9_out_data));

	reg [31:0] data_in_2_11_in_data;
	wire [31:0] data_in_2_11_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_11(.in_data(data_in_2_11_in_data), .out_data(data_in_2_11_out_data));

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

	wire [0:0] notOp_19_in0;
	wire [0:0] notOp_19_out;
	notOp #(.WIDTH(1)) notOp_19(.in(notOp_19_in0), .out(notOp_19_out));

	wire [0:0] andOp_20_in0;
	wire [0:0] andOp_20_in1;
	wire [0:0] andOp_20_out;
	andOp #(.WIDTH(1)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	wire [0:0] andOp_21_in0;
	wire [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	wire [0:0] notOp_22_in0;
	wire [0:0] notOp_22_out;
	notOp #(.WIDTH(1)) notOp_22(.in(notOp_22_in0), .out(notOp_22_out));

	wire [0:0] andOp_23_in0;
	wire [0:0] andOp_23_in1;
	wire [0:0] andOp_23_out;
	andOp #(.WIDTH(1)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	wire [0:0] notOp_24_in0;
	wire [0:0] notOp_24_out;
	notOp #(.WIDTH(1)) notOp_24(.in(notOp_24_in0), .out(notOp_24_out));

	wire [0:0] andOp_25_in0;
	wire [0:0] andOp_25_in1;
	wire [0:0] andOp_25_out;
	andOp #(.WIDTH(1)) andOp_25(.in0(andOp_25_in0), .in1(andOp_25_in1), .out(andOp_25_out));

	wire [0:0] notOp_26_in0;
	wire [0:0] notOp_26_out;
	notOp #(.WIDTH(1)) notOp_26(.in(notOp_26_in0), .out(notOp_26_out));

	wire [0:0] andOp_27_in0;
	wire [0:0] andOp_27_in1;
	wire [0:0] andOp_27_out;
	andOp #(.WIDTH(1)) andOp_27(.in0(andOp_27_in0), .in1(andOp_27_in1), .out(andOp_27_out));

	wire [0:0] notOp_28_in0;
	wire [0:0] notOp_28_out;
	notOp #(.WIDTH(1)) notOp_28(.in(notOp_28_in0), .out(notOp_28_out));

	wire [0:0] andOp_29_in0;
	wire [0:0] andOp_29_in1;
	wire [0:0] andOp_29_out;
	andOp #(.WIDTH(1)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	wire [0:0] notOp_30_in0;
	wire [0:0] notOp_30_out;
	notOp #(.WIDTH(1)) notOp_30(.in(notOp_30_in0), .out(notOp_30_out));

	wire [0:0] andOp_31_in0;
	wire [0:0] andOp_31_in1;
	wire [0:0] andOp_31_out;
	andOp #(.WIDTH(1)) andOp_31(.in0(andOp_31_in0), .in1(andOp_31_in1), .out(andOp_31_out));

	wire [0:0] notOp_32_in0;
	wire [0:0] notOp_32_out;
	notOp #(.WIDTH(1)) notOp_32(.in(notOp_32_in0), .out(notOp_32_out));

	wire [0:0] andOp_33_in0;
	wire [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	wire [0:0] notOp_34_in0;
	wire [0:0] notOp_34_out;
	notOp #(.WIDTH(1)) notOp_34(.in(notOp_34_in0), .out(notOp_34_out));

	wire [0:0] andOp_35_in0;
	wire [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	wire [0:0] andOp_36_in0;
	wire [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	wire [0:0] notOp_37_in0;
	wire [0:0] notOp_37_out;
	notOp #(.WIDTH(1)) notOp_37(.in(notOp_37_in0), .out(notOp_37_out));

	wire [0:0] andOp_38_in0;
	wire [0:0] andOp_38_in1;
	wire [0:0] andOp_38_out;
	andOp #(.WIDTH(1)) andOp_38(.in0(andOp_38_in0), .in1(andOp_38_in1), .out(andOp_38_out));

	wire [0:0] notOp_39_in0;
	wire [0:0] notOp_39_out;
	notOp #(.WIDTH(1)) notOp_39(.in(notOp_39_in0), .out(notOp_39_out));

	wire [0:0] andOp_40_in0;
	wire [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	wire [0:0] andOp_41_in0;
	wire [0:0] andOp_41_in1;
	wire [0:0] andOp_41_out;
	andOp #(.WIDTH(1)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	wire [0:0] notOp_42_in0;
	wire [0:0] notOp_42_out;
	notOp #(.WIDTH(1)) notOp_42(.in(notOp_42_in0), .out(notOp_42_out));

	wire [31:0] eq_43_in0;
	wire [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	wire [31:0] eq_44_in0;
	wire [31:0] eq_44_in1;
	wire [0:0] eq_44_out;
	eq #(.WIDTH(32)) eq_44(.in0(eq_44_in0), .in1(eq_44_in1), .out(eq_44_out));

	wire [0:0] orOp_45_in0;
	wire [0:0] orOp_45_in1;
	wire [0:0] orOp_45_out;
	orOp #(.WIDTH(1)) orOp_45(.in0(orOp_45_in0), .in1(orOp_45_in1), .out(orOp_45_out));

	wire [31:0] eq_46_in0;
	wire [31:0] eq_46_in1;
	wire [0:0] eq_46_out;
	eq #(.WIDTH(32)) eq_46(.in0(eq_46_in0), .in1(eq_46_in1), .out(eq_46_out));

	wire [0:0] orOp_47_in0;
	wire [0:0] orOp_47_in1;
	wire [0:0] orOp_47_out;
	orOp #(.WIDTH(1)) orOp_47(.in0(orOp_47_in0), .in1(orOp_47_in1), .out(orOp_47_out));

	wire [31:0] eq_48_in0;
	wire [31:0] eq_48_in1;
	wire [0:0] eq_48_out;
	eq #(.WIDTH(32)) eq_48(.in0(eq_48_in0), .in1(eq_48_in1), .out(eq_48_out));

	wire [0:0] orOp_49_in0;
	wire [0:0] orOp_49_in1;
	wire [0:0] orOp_49_out;
	orOp #(.WIDTH(1)) orOp_49(.in0(orOp_49_in0), .in1(orOp_49_in1), .out(orOp_49_out));

	wire [31:0] eq_50_in0;
	wire [31:0] eq_50_in1;
	wire [0:0] eq_50_out;
	eq #(.WIDTH(32)) eq_50(.in0(eq_50_in0), .in1(eq_50_in1), .out(eq_50_out));

	wire [31:0] eq_51_in0;
	wire [31:0] eq_51_in1;
	wire [0:0] eq_51_out;
	eq #(.WIDTH(32)) eq_51(.in0(eq_51_in0), .in1(eq_51_in1), .out(eq_51_out));

	wire [0:0] orOp_52_in0;
	wire [0:0] orOp_52_in1;
	wire [0:0] orOp_52_out;
	orOp #(.WIDTH(1)) orOp_52(.in0(orOp_52_in0), .in1(orOp_52_in1), .out(orOp_52_out));

	wire [31:0] eq_53_in0;
	wire [31:0] eq_53_in1;
	wire [0:0] eq_53_out;
	eq #(.WIDTH(32)) eq_53(.in0(eq_53_in0), .in1(eq_53_in1), .out(eq_53_out));

	wire [31:0] eq_54_in0;
	wire [31:0] eq_54_in1;
	wire [0:0] eq_54_out;
	eq #(.WIDTH(32)) eq_54(.in0(eq_54_in0), .in1(eq_54_in1), .out(eq_54_out));

	wire [0:0] orOp_55_in0;
	wire [0:0] orOp_55_in1;
	wire [0:0] orOp_55_out;
	orOp #(.WIDTH(1)) orOp_55(.in0(orOp_55_in0), .in1(orOp_55_in1), .out(orOp_55_out));

	wire [31:0] eq_56_in0;
	wire [31:0] eq_56_in1;
	wire [0:0] eq_56_out;
	eq #(.WIDTH(32)) eq_56(.in0(eq_56_in0), .in1(eq_56_in1), .out(eq_56_out));

	wire [0:0] orOp_57_in0;
	wire [0:0] orOp_57_in1;
	wire [0:0] orOp_57_out;
	orOp #(.WIDTH(1)) orOp_57(.in0(orOp_57_in0), .in1(orOp_57_in1), .out(orOp_57_out));

	wire [31:0] eq_58_in0;
	wire [31:0] eq_58_in1;
	wire [0:0] eq_58_out;
	eq #(.WIDTH(32)) eq_58(.in0(eq_58_in0), .in1(eq_58_in1), .out(eq_58_out));

	wire [0:0] orOp_59_in0;
	wire [0:0] orOp_59_in1;
	wire [0:0] orOp_59_out;
	orOp #(.WIDTH(1)) orOp_59(.in0(orOp_59_in0), .in1(orOp_59_in1), .out(orOp_59_out));

	wire [31:0] eq_60_in0;
	wire [31:0] eq_60_in1;
	wire [0:0] eq_60_out;
	eq #(.WIDTH(32)) eq_60(.in0(eq_60_in0), .in1(eq_60_in1), .out(eq_60_out));

	wire [0:0] orOp_61_in0;
	wire [0:0] orOp_61_in1;
	wire [0:0] orOp_61_out;
	orOp #(.WIDTH(1)) orOp_61(.in0(orOp_61_in0), .in1(orOp_61_in1), .out(orOp_61_out));

	wire [31:0] eq_62_in0;
	wire [31:0] eq_62_in1;
	wire [0:0] eq_62_out;
	eq #(.WIDTH(32)) eq_62(.in0(eq_62_in0), .in1(eq_62_in1), .out(eq_62_out));

	wire [0:0] orOp_63_in0;
	wire [0:0] orOp_63_in1;
	wire [0:0] orOp_63_out;
	orOp #(.WIDTH(1)) orOp_63(.in0(orOp_63_in0), .in1(orOp_63_in1), .out(orOp_63_out));

	wire [31:0] eq_64_in0;
	wire [31:0] eq_64_in1;
	wire [0:0] eq_64_out;
	eq #(.WIDTH(32)) eq_64(.in0(eq_64_in0), .in1(eq_64_in1), .out(eq_64_out));

	wire [31:0] eq_65_in0;
	wire [31:0] eq_65_in1;
	wire [0:0] eq_65_out;
	eq #(.WIDTH(32)) eq_65(.in0(eq_65_in0), .in1(eq_65_in1), .out(eq_65_out));

	wire [0:0] notOp_66_in0;
	wire [0:0] notOp_66_out;
	notOp #(.WIDTH(1)) notOp_66(.in(notOp_66_in0), .out(notOp_66_out));

	wire [0:0] andOp_67_in0;
	wire [0:0] andOp_67_in1;
	wire [0:0] andOp_67_out;
	andOp #(.WIDTH(1)) andOp_67(.in0(andOp_67_in0), .in1(andOp_67_in1), .out(andOp_67_out));

	wire [31:0] eq_68_in0;
	wire [31:0] eq_68_in1;
	wire [0:0] eq_68_out;
	eq #(.WIDTH(32)) eq_68(.in0(eq_68_in0), .in1(eq_68_in1), .out(eq_68_out));

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

	wire [0:0] notOp_72_in0;
	wire [0:0] notOp_72_out;
	notOp #(.WIDTH(1)) notOp_72(.in(notOp_72_in0), .out(notOp_72_out));

	wire [0:0] andOp_73_in0;
	wire [0:0] andOp_73_in1;
	wire [0:0] andOp_73_out;
	andOp #(.WIDTH(1)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	wire [31:0] eq_74_in0;
	wire [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	wire [31:0] eq_75_in0;
	wire [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

	wire [0:0] notOp_76_in0;
	wire [0:0] notOp_76_out;
	notOp #(.WIDTH(1)) notOp_76(.in(notOp_76_in0), .out(notOp_76_out));

	wire [0:0] andOp_77_in0;
	wire [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	wire [31:0] eq_78_in0;
	wire [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	wire [31:0] eq_79_in0;
	wire [31:0] eq_79_in1;
	wire [0:0] eq_79_out;
	eq #(.WIDTH(32)) eq_79(.in0(eq_79_in0), .in1(eq_79_in1), .out(eq_79_out));

	wire [0:0] notOp_80_in0;
	wire [0:0] notOp_80_out;
	notOp #(.WIDTH(1)) notOp_80(.in(notOp_80_in0), .out(notOp_80_out));

	wire [0:0] andOp_81_in0;
	wire [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	wire [31:0] eq_82_in0;
	wire [31:0] eq_82_in1;
	wire [0:0] eq_82_out;
	eq #(.WIDTH(32)) eq_82(.in0(eq_82_in0), .in1(eq_82_in1), .out(eq_82_out));

	wire [0:0] notOp_83_in0;
	wire [0:0] notOp_83_out;
	notOp #(.WIDTH(1)) notOp_83(.in(notOp_83_in0), .out(notOp_83_out));

	wire [0:0] andOp_84_in0;
	wire [0:0] andOp_84_in1;
	wire [0:0] andOp_84_out;
	andOp #(.WIDTH(1)) andOp_84(.in0(andOp_84_in0), .in1(andOp_84_in1), .out(andOp_84_out));

	wire [31:0] eq_85_in0;
	wire [31:0] eq_85_in1;
	wire [0:0] eq_85_out;
	eq #(.WIDTH(32)) eq_85(.in0(eq_85_in0), .in1(eq_85_in1), .out(eq_85_out));

	wire [0:0] notOp_86_in0;
	wire [0:0] notOp_86_out;
	notOp #(.WIDTH(1)) notOp_86(.in(notOp_86_in0), .out(notOp_86_out));

	wire [0:0] andOp_87_in0;
	wire [0:0] andOp_87_in1;
	wire [0:0] andOp_87_out;
	andOp #(.WIDTH(1)) andOp_87(.in0(andOp_87_in0), .in1(andOp_87_in1), .out(andOp_87_out));

	wire [31:0] eq_88_in0;
	wire [31:0] eq_88_in1;
	wire [0:0] eq_88_out;
	eq #(.WIDTH(32)) eq_88(.in0(eq_88_in0), .in1(eq_88_in1), .out(eq_88_out));

	wire [0:0] notOp_89_in0;
	wire [0:0] notOp_89_out;
	notOp #(.WIDTH(1)) notOp_89(.in(notOp_89_in0), .out(notOp_89_out));

	wire [0:0] andOp_90_in0;
	wire [0:0] andOp_90_in1;
	wire [0:0] andOp_90_out;
	andOp #(.WIDTH(1)) andOp_90(.in0(andOp_90_in0), .in1(andOp_90_in1), .out(andOp_90_out));

	wire [31:0] eq_91_in0;
	wire [31:0] eq_91_in1;
	wire [0:0] eq_91_out;
	eq #(.WIDTH(32)) eq_91(.in0(eq_91_in0), .in1(eq_91_in1), .out(eq_91_out));

	wire [0:0] notOp_92_in0;
	wire [0:0] notOp_92_out;
	notOp #(.WIDTH(1)) notOp_92(.in(notOp_92_in0), .out(notOp_92_out));

	wire [0:0] andOp_93_in0;
	wire [0:0] andOp_93_in1;
	wire [0:0] andOp_93_out;
	andOp #(.WIDTH(1)) andOp_93(.in0(andOp_93_in0), .in1(andOp_93_in1), .out(andOp_93_out));

	wire [0:0] andOp_94_in0;
	wire [0:0] andOp_94_in1;
	wire [0:0] andOp_94_out;
	andOp #(.WIDTH(1)) andOp_94(.in0(andOp_94_in0), .in1(andOp_94_in1), .out(andOp_94_out));

	wire [31:0] concat_95_in0;
	wire [31:0] concat_95_in1;
	wire [63:0] concat_95_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_95(.in0(concat_95_in0), .in1(concat_95_in1), .out(concat_95_out));

	wire [31:0] concat_96_in0;
	wire [31:0] concat_96_in1;
	wire [63:0] concat_96_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_96(.in0(concat_96_in0), .in1(concat_96_in1), .out(concat_96_out));

	wire [0:0] andOp_97_in0;
	wire [0:0] andOp_97_in1;
	wire [0:0] andOp_97_out;
	andOp #(.WIDTH(1)) andOp_97(.in0(andOp_97_in0), .in1(andOp_97_in1), .out(andOp_97_out));

	wire [0:0] andOp_98_in0;
	wire [0:0] andOp_98_in1;
	wire [0:0] andOp_98_out;
	andOp #(.WIDTH(1)) andOp_98(.in0(andOp_98_in0), .in1(andOp_98_in1), .out(andOp_98_out));

	wire [0:0] andOp_99_in0;
	wire [0:0] andOp_99_in1;
	wire [0:0] andOp_99_out;
	andOp #(.WIDTH(1)) andOp_99(.in0(andOp_99_in0), .in1(andOp_99_in1), .out(andOp_99_out));

	wire [0:0] andOp_100_in0;
	wire [0:0] andOp_100_in1;
	wire [0:0] andOp_100_out;
	andOp #(.WIDTH(1)) andOp_100(.in0(andOp_100_in0), .in1(andOp_100_in1), .out(andOp_100_out));

	wire [0:0] andOp_101_in0;
	wire [0:0] andOp_101_in1;
	wire [0:0] andOp_101_out;
	andOp #(.WIDTH(1)) andOp_101(.in0(andOp_101_in0), .in1(andOp_101_in1), .out(andOp_101_out));

	reg [31:0] tmp_output_102_in_data;
	wire [31:0] tmp_output_102_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_102(.in_data(tmp_output_102_in_data), .out_data(tmp_output_102_out_data));

	wire [31:0] eq_103_in0;
	wire [31:0] eq_103_in1;
	wire [0:0] eq_103_out;
	eq #(.WIDTH(32)) eq_103(.in0(eq_103_in0), .in1(eq_103_in1), .out(eq_103_out));

	wire [31:0] eq_104_in0;
	wire [31:0] eq_104_in1;
	wire [0:0] eq_104_out;
	eq #(.WIDTH(32)) eq_104(.in0(eq_104_in0), .in1(eq_104_in1), .out(eq_104_out));

	wire [0:0] andOp_105_in0;
	wire [0:0] andOp_105_in1;
	wire [0:0] andOp_105_out;
	andOp #(.WIDTH(1)) andOp_105(.in0(andOp_105_in0), .in1(andOp_105_in1), .out(andOp_105_out));

	wire [0:0] andOp_106_in0;
	wire [0:0] andOp_106_in1;
	wire [0:0] andOp_106_out;
	andOp #(.WIDTH(1)) andOp_106(.in0(andOp_106_in0), .in1(andOp_106_in1), .out(andOp_106_out));

	wire [0:0] andOp_107_in0;
	wire [0:0] andOp_107_in1;
	wire [0:0] andOp_107_out;
	andOp #(.WIDTH(1)) andOp_107(.in0(andOp_107_in0), .in1(andOp_107_in1), .out(andOp_107_out));

	wire [0:0] andOp_108_in0;
	wire [0:0] andOp_108_in1;
	wire [0:0] andOp_108_out;
	andOp #(.WIDTH(1)) andOp_108(.in0(andOp_108_in0), .in1(andOp_108_in1), .out(andOp_108_out));

	reg [31:0] tmp_output_109_in_data;
	wire [31:0] tmp_output_109_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_109(.in_data(tmp_output_109_in_data), .out_data(tmp_output_109_out_data));

	wire [31:0] eq_110_in0;
	wire [31:0] eq_110_in1;
	wire [0:0] eq_110_out;
	eq #(.WIDTH(32)) eq_110(.in0(eq_110_in0), .in1(eq_110_in1), .out(eq_110_out));

	wire [31:0] eq_111_in0;
	wire [31:0] eq_111_in1;
	wire [0:0] eq_111_out;
	eq #(.WIDTH(32)) eq_111(.in0(eq_111_in0), .in1(eq_111_in1), .out(eq_111_out));

	wire [0:0] andOp_112_in0;
	wire [0:0] andOp_112_in1;
	wire [0:0] andOp_112_out;
	andOp #(.WIDTH(1)) andOp_112(.in0(andOp_112_in0), .in1(andOp_112_in1), .out(andOp_112_out));

	wire [0:0] andOp_113_in0;
	wire [0:0] andOp_113_in1;
	wire [0:0] andOp_113_out;
	andOp #(.WIDTH(1)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	wire [0:0] andOp_114_in0;
	wire [0:0] andOp_114_in1;
	wire [0:0] andOp_114_out;
	andOp #(.WIDTH(1)) andOp_114(.in0(andOp_114_in0), .in1(andOp_114_in1), .out(andOp_114_out));

	wire [0:0] notOp_115_in0;
	wire [0:0] notOp_115_out;
	notOp #(.WIDTH(1)) notOp_115(.in(notOp_115_in0), .out(notOp_115_out));

	wire [0:0] andOp_116_in0;
	wire [0:0] andOp_116_in1;
	wire [0:0] andOp_116_out;
	andOp #(.WIDTH(1)) andOp_116(.in0(andOp_116_in0), .in1(andOp_116_in1), .out(andOp_116_out));

	wire [0:0] notOp_117_in0;
	wire [0:0] notOp_117_out;
	notOp #(.WIDTH(1)) notOp_117(.in(notOp_117_in0), .out(notOp_117_out));

	wire [0:0] andOp_118_in0;
	wire [0:0] andOp_118_in1;
	wire [0:0] andOp_118_out;
	andOp #(.WIDTH(1)) andOp_118(.in0(andOp_118_in0), .in1(andOp_118_in1), .out(andOp_118_out));

	wire [0:0] notOp_119_in0;
	wire [0:0] notOp_119_out;
	notOp #(.WIDTH(1)) notOp_119(.in(notOp_119_in0), .out(notOp_119_out));

	wire [0:0] andOp_120_in0;
	wire [0:0] andOp_120_in1;
	wire [0:0] andOp_120_out;
	andOp #(.WIDTH(1)) andOp_120(.in0(andOp_120_in0), .in1(andOp_120_in1), .out(andOp_120_out));

	wire [0:0] notOp_121_in0;
	wire [0:0] notOp_121_out;
	notOp #(.WIDTH(1)) notOp_121(.in(notOp_121_in0), .out(notOp_121_out));

	wire [0:0] andOp_122_in0;
	wire [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	wire [0:0] notOp_123_in0;
	wire [0:0] notOp_123_out;
	notOp #(.WIDTH(1)) notOp_123(.in(notOp_123_in0), .out(notOp_123_out));

	wire [0:0] andOp_124_in0;
	wire [0:0] andOp_124_in1;
	wire [0:0] andOp_124_out;
	andOp #(.WIDTH(1)) andOp_124(.in0(andOp_124_in0), .in1(andOp_124_in1), .out(andOp_124_out));

	wire [0:0] notOp_125_in0;
	wire [0:0] notOp_125_out;
	notOp #(.WIDTH(1)) notOp_125(.in(notOp_125_in0), .out(notOp_125_out));

	wire [0:0] andOp_126_in0;
	wire [0:0] andOp_126_in1;
	wire [0:0] andOp_126_out;
	andOp #(.WIDTH(1)) andOp_126(.in0(andOp_126_in0), .in1(andOp_126_in1), .out(andOp_126_out));

	wire [31:0] eq_127_in0;
	wire [31:0] eq_127_in1;
	wire [0:0] eq_127_out;
	eq #(.WIDTH(32)) eq_127(.in0(eq_127_in0), .in1(eq_127_in1), .out(eq_127_out));

	wire [31:0] eq_128_in0;
	wire [31:0] eq_128_in1;
	wire [0:0] eq_128_out;
	eq #(.WIDTH(32)) eq_128(.in0(eq_128_in0), .in1(eq_128_in1), .out(eq_128_out));

	wire [0:0] andOp_129_in0;
	wire [0:0] andOp_129_in1;
	wire [0:0] andOp_129_out;
	andOp #(.WIDTH(1)) andOp_129(.in0(andOp_129_in0), .in1(andOp_129_in1), .out(andOp_129_out));

	wire [31:0] eq_130_in0;
	wire [31:0] eq_130_in1;
	wire [0:0] eq_130_out;
	eq #(.WIDTH(32)) eq_130(.in0(eq_130_in0), .in1(eq_130_in1), .out(eq_130_out));

	wire [31:0] eq_131_in0;
	wire [31:0] eq_131_in1;
	wire [0:0] eq_131_out;
	eq #(.WIDTH(32)) eq_131(.in0(eq_131_in0), .in1(eq_131_in1), .out(eq_131_out));

	wire [31:0] eq_132_in0;
	wire [31:0] eq_132_in1;
	wire [0:0] eq_132_out;
	eq #(.WIDTH(32)) eq_132(.in0(eq_132_in0), .in1(eq_132_in1), .out(eq_132_out));

	wire [31:0] eq_133_in0;
	wire [31:0] eq_133_in1;
	wire [0:0] eq_133_out;
	eq #(.WIDTH(32)) eq_133(.in0(eq_133_in0), .in1(eq_133_in1), .out(eq_133_out));

	wire [0:0] andOp_134_in0;
	wire [0:0] andOp_134_in1;
	wire [0:0] andOp_134_out;
	andOp #(.WIDTH(1)) andOp_134(.in0(andOp_134_in0), .in1(andOp_134_in1), .out(andOp_134_out));

	// End Functional Units

	reg [31:0] data_store_0_0;
	reg [31:0] data_store_0_2;
	reg [31:0] data_store_1_4;
	reg [31:0] data_store_1_6;
	reg [31:0] data_store_2_10;
	reg [31:0] data_store_2_8;
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

	// controller for add_add6.add_add6_in0
	// controller for add_add6.add_add6_in1
	// Insensitive connections
	assign add_add6_in0 = phi_phi1_out;
	assign add_add6_in1 = 32'd1;
	// controller for andOp_100.andOp_100_in0
	// controller for andOp_100.andOp_100_in1
	// Insensitive connections
	assign andOp_100_in0 = bb_1_active_in_state_0_out_data;
	assign andOp_100_in1 = state_0_is_active;
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	assign andOp_101_in0 = bb_2_active_in_state_2_out_data;
	assign andOp_101_in1 = state_2_is_active;
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	assign andOp_105_in0 = bb_3_active_in_state_2_out_data;
	assign andOp_105_in1 = state_2_is_active;
	// controller for andOp_106.andOp_106_in0
	// controller for andOp_106.andOp_106_in1
	// Insensitive connections
	assign andOp_106_in0 = bb_9_active_in_state_2_out_data;
	assign andOp_106_in1 = state_2_is_active;
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	assign andOp_107_in0 = bb_10_active_in_state_2_out_data;
	assign andOp_107_in1 = state_2_is_active;
	// controller for andOp_108.andOp_108_in0
	// controller for andOp_108.andOp_108_in1
	// Insensitive connections
	assign andOp_108_in0 = bb_10_active_in_state_2_out_data;
	assign andOp_108_in1 = state_2_is_active;
	// controller for andOp_112.andOp_112_in0
	// controller for andOp_112.andOp_112_in1
	// Insensitive connections
	assign andOp_112_in0 = bb_4_active_in_state_2_out_data;
	assign andOp_112_in1 = state_2_is_active;
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	assign andOp_113_in0 = bb_7_active_in_state_1_out_data;
	assign andOp_113_in1 = state_1_is_active;
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	assign andOp_114_in0 = bb_4_active_in_state_2_out_data;
	assign andOp_114_in1 = state_2_is_active;
	// controller for andOp_116.andOp_116_in0
	// controller for andOp_116.andOp_116_in1
	// Insensitive connections
	assign andOp_116_in0 = notOp_115_out;
	assign andOp_116_in1 = 1'd1;
	// controller for andOp_118.andOp_118_in0
	// controller for andOp_118.andOp_118_in1
	// Insensitive connections
	assign andOp_118_in0 = notOp_117_out;
	assign andOp_118_in1 = andOp_116_out;
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	assign andOp_12_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_12_in1 = state_0_is_active;
	// controller for andOp_120.andOp_120_in0
	// controller for andOp_120.andOp_120_in1
	// Insensitive connections
	assign andOp_120_in0 = notOp_119_out;
	assign andOp_120_in1 = 1'd1;
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	assign andOp_122_in0 = notOp_121_out;
	assign andOp_122_in1 = 1'd1;
	// controller for andOp_124.andOp_124_in0
	// controller for andOp_124.andOp_124_in1
	// Insensitive connections
	assign andOp_124_in0 = notOp_123_out;
	assign andOp_124_in1 = andOp_122_out;
	// controller for andOp_126.andOp_126_in0
	// controller for andOp_126.andOp_126_in1
	// Insensitive connections
	assign andOp_126_in0 = notOp_125_out;
	assign andOp_126_in1 = andOp_124_out;
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	assign andOp_129_in0 = bb_1_active_in_state_0_out_data;
	assign andOp_129_in1 = state_0_is_active;
	// controller for andOp_134.andOp_134_in0
	// controller for andOp_134.andOp_134_in1
	// Insensitive connections
	assign andOp_134_in0 = bb_2_active_in_state_2_out_data;
	assign andOp_134_in1 = state_2_is_active;
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	assign andOp_14_in0 = bb_5_active_in_state_0_out_data;
	assign andOp_14_in1 = state_0_is_active;
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	assign andOp_16_in0 = bb_6_active_in_state_0_out_data;
	assign andOp_16_in1 = state_0_is_active;
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	assign andOp_18_in0 = andOp_16_out;
	assign andOp_18_in1 = arg_0_read_ready;
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	assign andOp_20_in0 = andOp_16_out;
	assign andOp_20_in1 = notOp_19_out;
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	assign andOp_21_in0 = bb_1_active_in_state_0_out_data;
	assign andOp_21_in1 = state_0_is_active;
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	assign andOp_23_in0 = bb_7_active_in_state_2_out_data;
	assign andOp_23_in1 = state_2_is_active;
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	assign andOp_25_in0 = bb_2_active_in_state_2_out_data;
	assign andOp_25_in1 = state_2_is_active;
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	assign andOp_27_in0 = bb_7_active_in_state_2_out_data;
	assign andOp_27_in1 = state_2_is_active;
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	assign andOp_29_in0 = bb_8_active_in_state_2_out_data;
	assign andOp_29_in1 = state_2_is_active;
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	assign andOp_31_in0 = bb_9_active_in_state_2_out_data;
	assign andOp_31_in1 = state_2_is_active;
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	assign andOp_33_in0 = andOp_31_out;
	assign andOp_33_in1 = arg_1_write_ready;
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	assign andOp_35_in0 = andOp_31_out;
	assign andOp_35_in1 = notOp_34_out;
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	assign andOp_36_in0 = bb_3_active_in_state_2_out_data;
	assign andOp_36_in1 = state_2_is_active;
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	assign andOp_38_in0 = andOp_36_out;
	assign andOp_38_in1 = icmp_icmp9_out;
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	assign andOp_40_in0 = andOp_36_out;
	assign andOp_40_in1 = notOp_39_out;
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	assign andOp_41_in0 = bb_10_active_in_state_2_out_data;
	assign andOp_41_in1 = state_2_is_active;
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	assign andOp_67_in0 = notOp_66_out;
	assign andOp_67_in1 = andOp_21_out;
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	assign andOp_70_in0 = notOp_69_out;
	assign andOp_70_in1 = andOp_14_out;
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	assign andOp_73_in0 = notOp_72_out;
	assign andOp_73_in1 = andOp_12_out;
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	assign andOp_77_in0 = notOp_76_out;
	assign andOp_77_in1 = andOp_23_out;
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	assign andOp_81_in0 = notOp_80_out;
	assign andOp_81_in1 = andOp_25_out;
	// controller for andOp_84.andOp_84_in0
	// controller for andOp_84.andOp_84_in1
	// Insensitive connections
	assign andOp_84_in0 = notOp_83_out;
	assign andOp_84_in1 = andOp_29_out;
	// controller for andOp_87.andOp_87_in0
	// controller for andOp_87.andOp_87_in1
	// Insensitive connections
	assign andOp_87_in0 = notOp_86_out;
	assign andOp_87_in1 = andOp_41_out;
	// controller for andOp_90.andOp_90_in0
	// controller for andOp_90.andOp_90_in1
	// Insensitive connections
	assign andOp_90_in0 = notOp_89_out;
	assign andOp_90_in1 = andOp_33_out;
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	assign andOp_93_in0 = notOp_92_out;
	assign andOp_93_in1 = andOp_40_out;
	// controller for andOp_94.andOp_94_in0
	// controller for andOp_94.andOp_94_in1
	// Insensitive connections
	assign andOp_94_in0 = bb_1_active_in_state_0_out_data;
	assign andOp_94_in1 = state_0_is_active;
	// controller for andOp_97.andOp_97_in0
	// controller for andOp_97.andOp_97_in1
	// Insensitive connections
	assign andOp_97_in0 = bb_6_active_in_state_0_out_data;
	assign andOp_97_in1 = state_0_is_active;
	// controller for andOp_98.andOp_98_in0
	// controller for andOp_98.andOp_98_in1
	// Insensitive connections
	assign andOp_98_in0 = bb_7_active_in_state_1_out_data;
	assign andOp_98_in1 = state_1_is_active;
	// controller for andOp_99.andOp_99_in0
	// controller for andOp_99.andOp_99_in1
	// Insensitive connections
	assign andOp_99_in0 = bb_7_active_in_state_2_out_data;
	assign andOp_99_in1 = state_2_is_active;
	// controller for arg_0.arg_0_read_valid_reg
	always @(*) begin
		if (andOp_98_out) begin 
			arg_0_read_valid_reg = -(1'd1);
		end else begin
			arg_0_read_valid_reg = 0;
		end
	end
	// controller for arg_1.arg_1_in_data_reg
	always @(*) begin
		if (andOp_108_out) begin 
			arg_1_in_data_reg = tmp_output_109_out_data;
		end else begin
			arg_1_in_data_reg = 0;
		end
	end
	// controller for arg_1.arg_1_write_valid_reg
	always @(*) begin
		if (andOp_107_out) begin 
			arg_1_write_valid_reg = -(1'd1);
		end else begin
			arg_1_write_valid_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_43_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_64_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_2.bb_10_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_2_in_data = orOp_61_out;
		end else begin
			bb_10_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_2.bb_10_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_90_out) begin 
			bb_10_predecessor_in_state_2_in_data = 32'd9;
		end else if (eq_88_out) begin 
			bb_10_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_0.bb_1_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_0_in_data = orOp_49_out;
		end else begin
			bb_1_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_0.bb_1_predecessor_in_state_0_in_data
	always @(*) begin
		if (andOp_73_out) begin 
			bb_1_predecessor_in_state_0_in_data = 32'd0;
		end else if (eq_71_out) begin 
			bb_1_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_2.bb_2_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_2_in_data = orOp_52_out;
		end else begin
			bb_2_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_2.bb_2_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_77_out) begin 
			bb_2_predecessor_in_state_2_in_data = 32'd7;
		end else if (eq_75_out) begin 
			bb_2_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_2.bb_3_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_2_in_data = orOp_59_out;
		end else begin
			bb_3_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_2.bb_3_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_87_out) begin 
			bb_3_predecessor_in_state_2_in_data = 32'd10;
		end else if (eq_85_out) begin 
			bb_3_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_2.bb_4_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_2_in_data = orOp_63_out;
		end else begin
			bb_4_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_2.bb_4_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_93_out) begin 
			bb_4_predecessor_in_state_2_in_data = 32'd3;
		end else if (eq_91_out) begin 
			bb_4_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_5_active_in_state_0.bb_5_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_state_0_in_data = orOp_45_out;
		end else begin
			bb_5_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_5_predecessor_in_state_0.bb_5_predecessor_in_state_0_in_data
	always @(*) begin
		if (andOp_67_out) begin 
			bb_5_predecessor_in_state_0_in_data = 32'd1;
		end else if (eq_65_out) begin 
			bb_5_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_5_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_6_active_in_state_0.bb_6_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_state_0_in_data = orOp_47_out;
		end else begin
			bb_6_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_6_predecessor_in_state_0.bb_6_predecessor_in_state_0_in_data
	always @(*) begin
		if (andOp_70_out) begin 
			bb_6_predecessor_in_state_0_in_data = 32'd5;
		end else if (eq_68_out) begin 
			bb_6_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_6_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_1.bb_7_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_1_in_data = eq_50_out;
		end else begin
			bb_7_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_2.bb_7_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_2_in_data = eq_53_out;
		end else begin
			bb_7_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_7_predecessor_in_state_1.bb_7_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_74_out) begin 
			bb_7_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_7_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_7_predecessor_in_state_2.bb_7_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_78_out) begin 
			bb_7_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_7_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_8_active_in_state_2.bb_8_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_8_active_in_state_2_in_data = orOp_55_out;
		end else begin
			bb_8_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_8_predecessor_in_state_2.bb_8_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_81_out) begin 
			bb_8_predecessor_in_state_2_in_data = 32'd2;
		end else if (eq_79_out) begin 
			bb_8_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_8_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_9_active_in_state_2.bb_9_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_state_2_in_data = orOp_57_out;
		end else begin
			bb_9_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_9_predecessor_in_state_2.bb_9_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_84_out) begin 
			bb_9_predecessor_in_state_2_in_data = 32'd8;
		end else if (eq_82_out) begin 
			bb_9_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_9_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_13_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_2.br_10_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_41_out) begin 
			br_10_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_42_out) begin 
			br_10_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_0.br_1_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_21_out) begin 
			br_1_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_22_out) begin 
			br_1_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_2_happened_in_state_2.br_2_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_25_out) begin 
			br_2_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_26_out) begin 
			br_2_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_2_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_3_happened_in_state_2.br_3_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_36_out) begin 
			br_3_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_37_out) begin 
			br_3_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_5_happened_in_state_0.br_5_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_14_out) begin 
			br_5_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_15_out) begin 
			br_5_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_5_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_6_happened_in_state_0.br_6_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_16_out) begin 
			br_6_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_17_out) begin 
			br_6_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_6_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_1.br_7_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_23_out) begin 
			br_7_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_24_out) begin 
			br_7_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_2.br_7_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_27_out) begin 
			br_7_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_28_out) begin 
			br_7_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_8_happened_in_state_2.br_8_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_29_out) begin 
			br_8_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_30_out) begin 
			br_8_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_8_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_9_happened_in_state_2.br_9_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_31_out) begin 
			br_9_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_32_out) begin 
			br_9_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_9_happened_in_state_2_in_data = 0;
		end
	end
	// controller for concat_95.concat_95_in0
	// controller for concat_95.concat_95_in1
	// Insensitive connections
	assign concat_95_in0 = data_in_0_3_out_data;
	assign concat_95_in1 = 32'd0;
	// controller for concat_96.concat_96_in0
	// controller for concat_96.concat_96_in1
	// Insensitive connections
	assign concat_96_in0 = 32'd3;
	assign concat_96_in1 = 32'd0;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_127_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else if (eq_128_out) begin 
			data_in_0_1_in_data = data_store_2_8;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_0_3.data_in_0_3_in_data
	always @(*) begin
		if (eq_127_out) begin 
			data_in_0_3_in_data = data_store_0_2;
		end else if (eq_128_out) begin 
			data_in_0_3_in_data = data_store_2_10;
		end else begin
			data_in_0_3_in_data = 0;
		end
	end
	// controller for data_in_1_5.data_in_1_5_in_data
	always @(*) begin
		if (eq_130_out) begin 
			data_in_1_5_in_data = data_store_0_0;
		end else if (eq_131_out) begin 
			data_in_1_5_in_data = data_store_1_4;
		end else begin
			data_in_1_5_in_data = 0;
		end
	end
	// controller for data_in_1_7.data_in_1_7_in_data
	always @(*) begin
		if (eq_130_out) begin 
			data_in_1_7_in_data = data_store_0_2;
		end else if (eq_131_out) begin 
			data_in_1_7_in_data = data_store_1_6;
		end else begin
			data_in_1_7_in_data = 0;
		end
	end
	// controller for data_in_2_11.data_in_2_11_in_data
	always @(*) begin
		if (eq_132_out) begin 
			data_in_2_11_in_data = data_store_1_6;
		end else if (eq_133_out) begin 
			data_in_2_11_in_data = data_store_2_10;
		end else begin
			data_in_2_11_in_data = 0;
		end
	end
	// controller for data_in_2_9.data_in_2_9_in_data
	always @(*) begin
		if (eq_132_out) begin 
			data_in_2_9_in_data = data_store_1_4;
		end else if (eq_133_out) begin 
			data_in_2_9_in_data = data_store_2_8;
		end else begin
			data_in_2_9_in_data = 0;
		end
	end
	// controller for eq_103.eq_103_in0
	// controller for eq_103.eq_103_in1
	// Insensitive connections
	assign eq_103_in0 = 32'd7;
	assign eq_103_in1 = state_2_entry_BB_reg;
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	assign eq_104_in0 = 32'd9;
	assign eq_104_in1 = state_2_entry_BB_reg;
	// controller for eq_110.eq_110_in0
	// controller for eq_110.eq_110_in1
	// Insensitive connections
	assign eq_110_in0 = 32'd7;
	assign eq_110_in1 = state_2_entry_BB_reg;
	// controller for eq_111.eq_111_in0
	// controller for eq_111.eq_111_in1
	// Insensitive connections
	assign eq_111_in0 = 32'd9;
	assign eq_111_in1 = state_2_entry_BB_reg;
	// controller for eq_127.eq_127_in0
	// controller for eq_127.eq_127_in1
	// Insensitive connections
	assign eq_127_in0 = 32'd0;
	assign eq_127_in1 = state_0_last_state;
	// controller for eq_128.eq_128_in0
	// controller for eq_128.eq_128_in1
	// Insensitive connections
	assign eq_128_in0 = 32'd2;
	assign eq_128_in1 = state_0_last_state;
	// controller for eq_130.eq_130_in0
	// controller for eq_130.eq_130_in1
	// Insensitive connections
	assign eq_130_in0 = 32'd0;
	assign eq_130_in1 = state_1_last_state;
	// controller for eq_131.eq_131_in0
	// controller for eq_131.eq_131_in1
	// Insensitive connections
	assign eq_131_in0 = 32'd1;
	assign eq_131_in1 = state_1_last_state;
	// controller for eq_132.eq_132_in0
	// controller for eq_132.eq_132_in1
	// Insensitive connections
	assign eq_132_in0 = 32'd1;
	assign eq_132_in1 = state_2_last_state;
	// controller for eq_133.eq_133_in0
	// controller for eq_133.eq_133_in1
	// Insensitive connections
	assign eq_133_in0 = 32'd2;
	assign eq_133_in1 = state_2_last_state;
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	assign eq_43_in0 = 32'd0;
	assign eq_43_in1 = state_0_entry_BB_reg;
	// controller for eq_44.eq_44_in0
	// controller for eq_44.eq_44_in1
	// Insensitive connections
	assign eq_44_in0 = 32'd5;
	assign eq_44_in1 = state_0_entry_BB_reg;
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	assign eq_46_in0 = 32'd6;
	assign eq_46_in1 = state_0_entry_BB_reg;
	// controller for eq_48.eq_48_in0
	// controller for eq_48.eq_48_in1
	// Insensitive connections
	assign eq_48_in0 = 32'd1;
	assign eq_48_in1 = state_0_entry_BB_reg;
	// controller for eq_50.eq_50_in0
	// controller for eq_50.eq_50_in1
	// Insensitive connections
	assign eq_50_in0 = 32'd7;
	assign eq_50_in1 = state_1_entry_BB_reg;
	// controller for eq_51.eq_51_in0
	// controller for eq_51.eq_51_in1
	// Insensitive connections
	assign eq_51_in0 = 32'd2;
	assign eq_51_in1 = state_2_entry_BB_reg;
	// controller for eq_53.eq_53_in0
	// controller for eq_53.eq_53_in1
	// Insensitive connections
	assign eq_53_in0 = 32'd7;
	assign eq_53_in1 = state_2_entry_BB_reg;
	// controller for eq_54.eq_54_in0
	// controller for eq_54.eq_54_in1
	// Insensitive connections
	assign eq_54_in0 = 32'd8;
	assign eq_54_in1 = state_2_entry_BB_reg;
	// controller for eq_56.eq_56_in0
	// controller for eq_56.eq_56_in1
	// Insensitive connections
	assign eq_56_in0 = 32'd9;
	assign eq_56_in1 = state_2_entry_BB_reg;
	// controller for eq_58.eq_58_in0
	// controller for eq_58.eq_58_in1
	// Insensitive connections
	assign eq_58_in0 = 32'd3;
	assign eq_58_in1 = state_2_entry_BB_reg;
	// controller for eq_60.eq_60_in0
	// controller for eq_60.eq_60_in1
	// Insensitive connections
	assign eq_60_in0 = 32'd10;
	assign eq_60_in1 = state_2_entry_BB_reg;
	// controller for eq_62.eq_62_in0
	// controller for eq_62.eq_62_in1
	// Insensitive connections
	assign eq_62_in0 = 32'd4;
	assign eq_62_in1 = state_2_entry_BB_reg;
	// controller for eq_64.eq_64_in0
	// controller for eq_64.eq_64_in1
	// Insensitive connections
	assign eq_64_in0 = 32'd0;
	assign eq_64_in1 = state_0_entry_BB_reg;
	// controller for eq_65.eq_65_in0
	// controller for eq_65.eq_65_in1
	// Insensitive connections
	assign eq_65_in0 = 32'd5;
	assign eq_65_in1 = state_0_entry_BB_reg;
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	assign eq_68_in0 = 32'd6;
	assign eq_68_in1 = state_0_entry_BB_reg;
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	assign eq_71_in0 = 32'd1;
	assign eq_71_in1 = state_0_entry_BB_reg;
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	assign eq_74_in0 = 32'd7;
	assign eq_74_in1 = state_1_entry_BB_reg;
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	assign eq_75_in0 = 32'd2;
	assign eq_75_in1 = state_2_entry_BB_reg;
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	assign eq_78_in0 = 32'd7;
	assign eq_78_in1 = state_2_entry_BB_reg;
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	assign eq_79_in0 = 32'd8;
	assign eq_79_in1 = state_2_entry_BB_reg;
	// controller for eq_82.eq_82_in0
	// controller for eq_82.eq_82_in1
	// Insensitive connections
	assign eq_82_in0 = 32'd9;
	assign eq_82_in1 = state_2_entry_BB_reg;
	// controller for eq_85.eq_85_in0
	// controller for eq_85.eq_85_in1
	// Insensitive connections
	assign eq_85_in0 = 32'd3;
	assign eq_85_in1 = state_2_entry_BB_reg;
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	assign eq_88_in0 = 32'd10;
	assign eq_88_in1 = state_2_entry_BB_reg;
	// controller for eq_91.eq_91_in0
	// controller for eq_91.eq_91_in1
	// Insensitive connections
	assign eq_91_in0 = 32'd4;
	assign eq_91_in1 = state_2_entry_BB_reg;
	// controller for icmp_icmp9.icmp_icmp9_in0
	// controller for icmp_icmp9.icmp_icmp9_in1
	// Insensitive connections
	assign icmp_icmp9_in0 = data_in_2_11_out_data;
	assign icmp_icmp9_in1 = 32'd15;
	// controller for mul_mul8.mul_mul8_in0
	// controller for mul_mul8.mul_mul8_in1
	// Insensitive connections
	assign mul_mul8_in0 = 32'd2;
	assign mul_mul8_in1 = tmp_output_102_out_data;
	// controller for notOp_115.notOp_115_in0
	// Insensitive connections
	assign notOp_115_in0 = andOp_20_out;
	// controller for notOp_117.notOp_117_in0
	// Insensitive connections
	assign notOp_117_in0 = andOp_38_out;
	// controller for notOp_119.notOp_119_in0
	// Insensitive connections
	assign notOp_119_in0 = andOp_18_out;
	// controller for notOp_121.notOp_121_in0
	// Insensitive connections
	assign notOp_121_in0 = andOp_113_out;
	// controller for notOp_123.notOp_123_in0
	// Insensitive connections
	assign notOp_123_in0 = andOp_114_out;
	// controller for notOp_125.notOp_125_in0
	// Insensitive connections
	assign notOp_125_in0 = andOp_35_out;
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	assign notOp_13_in0 = andOp_12_out;
	// controller for notOp_15.notOp_15_in0
	// Insensitive connections
	assign notOp_15_in0 = andOp_14_out;
	// controller for notOp_17.notOp_17_in0
	// Insensitive connections
	assign notOp_17_in0 = andOp_16_out;
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	assign notOp_19_in0 = arg_0_read_ready;
	// controller for notOp_22.notOp_22_in0
	// Insensitive connections
	assign notOp_22_in0 = andOp_21_out;
	// controller for notOp_24.notOp_24_in0
	// Insensitive connections
	assign notOp_24_in0 = andOp_23_out;
	// controller for notOp_26.notOp_26_in0
	// Insensitive connections
	assign notOp_26_in0 = andOp_25_out;
	// controller for notOp_28.notOp_28_in0
	// Insensitive connections
	assign notOp_28_in0 = andOp_27_out;
	// controller for notOp_30.notOp_30_in0
	// Insensitive connections
	assign notOp_30_in0 = andOp_29_out;
	// controller for notOp_32.notOp_32_in0
	// Insensitive connections
	assign notOp_32_in0 = andOp_31_out;
	// controller for notOp_34.notOp_34_in0
	// Insensitive connections
	assign notOp_34_in0 = arg_1_write_ready;
	// controller for notOp_37.notOp_37_in0
	// Insensitive connections
	assign notOp_37_in0 = andOp_36_out;
	// controller for notOp_39.notOp_39_in0
	// Insensitive connections
	assign notOp_39_in0 = icmp_icmp9_out;
	// controller for notOp_42.notOp_42_in0
	// Insensitive connections
	assign notOp_42_in0 = andOp_41_out;
	// controller for notOp_66.notOp_66_in0
	// Insensitive connections
	assign notOp_66_in0 = eq_65_out;
	// controller for notOp_69.notOp_69_in0
	// Insensitive connections
	assign notOp_69_in0 = eq_68_out;
	// controller for notOp_72.notOp_72_in0
	// Insensitive connections
	assign notOp_72_in0 = eq_71_out;
	// controller for notOp_76.notOp_76_in0
	// Insensitive connections
	assign notOp_76_in0 = eq_75_out;
	// controller for notOp_80.notOp_80_in0
	// Insensitive connections
	assign notOp_80_in0 = eq_79_out;
	// controller for notOp_83.notOp_83_in0
	// Insensitive connections
	assign notOp_83_in0 = eq_82_out;
	// controller for notOp_86.notOp_86_in0
	// Insensitive connections
	assign notOp_86_in0 = eq_85_out;
	// controller for notOp_89.notOp_89_in0
	// Insensitive connections
	assign notOp_89_in0 = eq_88_out;
	// controller for notOp_92.notOp_92_in0
	// Insensitive connections
	assign notOp_92_in0 = eq_91_out;
	// controller for orOp_45.orOp_45_in0
	// controller for orOp_45.orOp_45_in1
	// Insensitive connections
	assign orOp_45_in0 = eq_44_out;
	assign orOp_45_in1 = andOp_21_out;
	// controller for orOp_47.orOp_47_in0
	// controller for orOp_47.orOp_47_in1
	// Insensitive connections
	assign orOp_47_in0 = eq_46_out;
	assign orOp_47_in1 = andOp_14_out;
	// controller for orOp_49.orOp_49_in0
	// controller for orOp_49.orOp_49_in1
	// Insensitive connections
	assign orOp_49_in0 = eq_48_out;
	assign orOp_49_in1 = andOp_12_out;
	// controller for orOp_52.orOp_52_in0
	// controller for orOp_52.orOp_52_in1
	// Insensitive connections
	assign orOp_52_in0 = eq_51_out;
	assign orOp_52_in1 = andOp_23_out;
	// controller for orOp_55.orOp_55_in0
	// controller for orOp_55.orOp_55_in1
	// Insensitive connections
	assign orOp_55_in0 = eq_54_out;
	assign orOp_55_in1 = andOp_25_out;
	// controller for orOp_57.orOp_57_in0
	// controller for orOp_57.orOp_57_in1
	// Insensitive connections
	assign orOp_57_in0 = eq_56_out;
	assign orOp_57_in1 = andOp_29_out;
	// controller for orOp_59.orOp_59_in0
	// controller for orOp_59.orOp_59_in1
	// Insensitive connections
	assign orOp_59_in0 = eq_58_out;
	assign orOp_59_in1 = andOp_41_out;
	// controller for orOp_61.orOp_61_in0
	// controller for orOp_61.orOp_61_in1
	// Insensitive connections
	assign orOp_61_in0 = eq_60_out;
	assign orOp_61_in1 = andOp_33_out;
	// controller for orOp_63.orOp_63_in0
	// controller for orOp_63.orOp_63_in1
	// Insensitive connections
	assign orOp_63_in0 = eq_62_out;
	assign orOp_63_in1 = andOp_40_out;
	// controller for phi_phi1.phi_phi1_in
	// controller for phi_phi1.phi_phi1_last_block
	// controller for phi_phi1.phi_phi1_s
	// Insensitive connections
	assign phi_phi1_in = concat_95_out;
	assign phi_phi1_last_block = bb_1_predecessor_in_state_0_out_data;
	assign phi_phi1_s = concat_96_out;
	// controller for ret20.valid_reg
	always @(*) begin
		if (andOp_112_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_102.tmp_output_102_in_data
	always @(*) begin
		if (eq_103_out) begin 
			tmp_output_102_in_data = arg_0_out_data;
		end else begin
			tmp_output_102_in_data = 0;
		end
	end
	// controller for tmp_output_109.tmp_output_109_in_data
	always @(*) begin
		if (eq_110_out) begin 
			tmp_output_109_in_data = mul_mul8_out;
		end else if (eq_111_out) begin 
			tmp_output_109_in_data = data_in_2_9_out_data;
		end else begin
			tmp_output_109_in_data = 0;
		end
	end
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
			data_store_0_2 <= 0;
		end else begin
			if (andOp_129_out) begin
				data_store_0_2 <= add_add6_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_4 <= 0;
		end else begin
			if (state_1_is_active) begin
				data_store_1_4 <= data_in_1_5_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_6 <= 0;
		end else begin
			if (state_1_is_active) begin
				data_store_1_6 <= data_in_1_7_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_10 <= 0;
		end else begin
			if (state_2_is_active) begin
				data_store_2_10 <= data_in_2_11_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_8 <= 0;
		end else begin
			if (andOp_134_out) begin
				data_store_2_8 <= mul_mul8_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_113_out) begin
				global_state <= 32'd2;
			end
			if (andOp_114_out) begin
				global_state <= 32'd2;
			end
			if (andOp_18_out) begin
				global_state <= 32'd1;
			end
			if (andOp_20_out) begin
				global_state <= 32'd0;
			end
			if (andOp_35_out) begin
				global_state <= 32'd2;
			end
			if (andOp_38_out) begin
				global_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_entry_BB_reg <= 0;
		end else begin
			if (andOp_20_out) begin
				state_0_entry_BB_reg <= 32'd6;
			end
			if (andOp_38_out) begin
				state_0_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_is_active <= 1;
		end else begin
			if (andOp_118_out) begin
				state_0_is_active <= 1'd0;
			end
			if (andOp_20_out) begin
				state_0_is_active <= 1'd1;
			end
			if (andOp_38_out) begin
				state_0_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_last_BB_reg <= 0;
		end else begin
			if (andOp_20_out) begin
				state_0_last_BB_reg <= 32'd6;
			end
			if (andOp_38_out) begin
				state_0_last_BB_reg <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_0_last_state <= 0;
		end else begin
			if (andOp_20_out) begin
				state_0_last_state <= 32'd0;
			end
			if (andOp_38_out) begin
				state_0_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_entry_BB_reg <= 0;
		end else begin
			if (andOp_18_out) begin
				state_1_entry_BB_reg <= 32'd7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_120_out) begin
				state_1_is_active <= 1'd0;
			end
			if (andOp_18_out) begin
				state_1_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_18_out) begin
				state_1_last_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_18_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_113_out) begin
				state_2_entry_BB_reg <= 32'd7;
			end
			if (andOp_114_out) begin
				state_2_entry_BB_reg <= 32'd4;
			end
			if (andOp_35_out) begin
				state_2_entry_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_113_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_114_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_126_out) begin
				state_2_is_active <= 1'd0;
			end
			if (andOp_35_out) begin
				state_2_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_113_out) begin
				state_2_last_BB_reg <= bb_7_predecessor_in_state_1_out_data;
			end
			if (andOp_114_out) begin
				state_2_last_BB_reg <= bb_4_predecessor_in_state_2_out_data;
			end
			if (andOp_35_out) begin
				state_2_last_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_113_out) begin
				state_2_last_state <= 32'd1;
			end
			if (andOp_114_out) begin
				state_2_last_state <= 32'd2;
			end
			if (andOp_35_out) begin
				state_2_last_state <= 32'd2;
			end
		end
	end

endmodule

