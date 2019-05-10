module run_median_func(input [0:0] clk, input [0:0] rst, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [7:0] arg_0_pixel1, input [7:0] arg_0_pixel2, input [7:0] arg_0_pixel3, input [7:0] arg_0_pixel4, output [0:0] valid, output [31:0] arg_1_in_wire, input [31:0] arg_1_out_wire, output [31:0] arg_2_in_wire, input [31:0] arg_2_out_wire, output [31:0] arg_3_in_wire, input [31:0] arg_3_out_wire, output [7:0] arg_4_in_wire, input [7:0] arg_4_out_wire, output [7:0] arg_5_in_wire, input [7:0] arg_5_out_wire, output [7:0] arg_6_in_wire, input [7:0] arg_6_out_wire, output [7:0] arg_7_in_wire, input [7:0] arg_7_out_wire);

	reg [0:0] arg_0_rst_n_reg;
	reg [31:0] arg_0_word0_reg;
	reg [31:0] arg_0_word1_reg;
	reg [31:0] arg_0_word2_reg;
	reg [0:0] valid_reg;
	reg [31:0] arg_1_in_wire_reg;
	reg [31:0] arg_2_in_wire_reg;
	reg [31:0] arg_3_in_wire_reg;
	reg [7:0] arg_4_in_wire_reg;
	reg [7:0] arg_5_in_wire_reg;
	reg [7:0] arg_6_in_wire_reg;
	reg [7:0] arg_7_in_wire_reg;

	assign arg_0_rst_n = arg_0_rst_n_reg;
	assign arg_0_word0 = arg_0_word0_reg;
	assign arg_0_word1 = arg_0_word1_reg;
	assign arg_0_word2 = arg_0_word2_reg;
	assign valid = valid_reg;
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





	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	wire [31:0] sgt_in0_sext_11;
	wire [63:0] sgt_out_sext_11;
	sext sext_11(.in(sgt_in0_sext_11), .out(sgt_out_sext_11));

	wire [31:0] sgt_in0_sext_13;
	wire [63:0] sgt_out_sext_13;
	sext sext_13(.in(sgt_in0_sext_13), .out(sgt_out_sext_13));

	wire [31:0] add_in0_add_14;
	wire [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	wire [31:0] trunc_in_trunc_15;
	wire [19:0] trunc_out_trunc_15;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(20)) trunc_15(.in(trunc_in_trunc_15), .out(trunc_out_trunc_15));

	wire [31:0] cmp_in0_icmp_16;
	wire [31:0] cmp_in1_icmp_16;
	wire [0:0] cmp_out_icmp_16;
	slt #(.WIDTH(32)) icmp_16(.in0(cmp_in0_icmp_16), .in1(cmp_in1_icmp_16), .out(cmp_out_icmp_16));

	wire [39:0] phi_in_phi_25;
	wire [31:0] phi_last_block_phi_25;
	wire [63:0] phi_s_phi_25;
	wire [31:0] phi_out_phi_25;
	phi #(.NB_PAIR(2), .WIDTH(20)) phi_25(.in(phi_in_phi_25), .last_block(phi_last_block_phi_25), .out(phi_out_phi_25), .s(phi_s_phi_25));

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

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] bb_0_active_in_state_1_in_data;
	wire [0:0] bb_0_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_1(.in_data(bb_0_active_in_state_1_in_data), .out_data(bb_0_active_in_state_1_out_data));

	reg [31:0] bb_0_predecessor_in_state_1_in_data;
	wire [31:0] bb_0_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_1(.in_data(bb_0_predecessor_in_state_1_in_data), .out_data(bb_0_predecessor_in_state_1_out_data));

	reg [0:0] bb_0_active_in_state_2_in_data;
	wire [0:0] bb_0_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_2(.in_data(bb_0_active_in_state_2_in_data), .out_data(bb_0_active_in_state_2_out_data));

	reg [31:0] bb_0_predecessor_in_state_2_in_data;
	wire [31:0] bb_0_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_2(.in_data(bb_0_predecessor_in_state_2_in_data), .out_data(bb_0_predecessor_in_state_2_out_data));

	reg [0:0] bb_1_active_in_state_3_in_data;
	wire [0:0] bb_1_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_3(.in_data(bb_1_active_in_state_3_in_data), .out_data(bb_1_active_in_state_3_out_data));

	reg [31:0] bb_1_predecessor_in_state_3_in_data;
	wire [31:0] bb_1_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_3(.in_data(bb_1_predecessor_in_state_3_in_data), .out_data(bb_1_predecessor_in_state_3_out_data));

	reg [0:0] bb_2_active_in_state_3_in_data;
	wire [0:0] bb_2_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_3(.in_data(bb_2_active_in_state_3_in_data), .out_data(bb_2_active_in_state_3_out_data));

	reg [31:0] bb_2_predecessor_in_state_3_in_data;
	wire [31:0] bb_2_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_3(.in_data(bb_2_predecessor_in_state_3_in_data), .out_data(bb_2_predecessor_in_state_3_out_data));

	wire [0:0] andOp_8_in0;
	wire [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	wire [0:0] andOp_9_in0;
	wire [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	wire [0:0] notOp_10_in0;
	wire [0:0] notOp_10_out;
	notOp #(.WIDTH(1)) notOp_10(.in(notOp_10_in0), .out(notOp_10_out));

	wire [0:0] andOp_11_in0;
	wire [0:0] andOp_11_in1;
	wire [0:0] andOp_11_out;
	andOp #(.WIDTH(1)) andOp_11(.in0(andOp_11_in0), .in1(andOp_11_in1), .out(andOp_11_out));

	wire [0:0] andOp_12_in0;
	wire [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	wire [0:0] notOp_13_in0;
	wire [0:0] notOp_13_out;
	notOp #(.WIDTH(1)) notOp_13(.in(notOp_13_in0), .out(notOp_13_out));

	wire [0:0] andOp_14_in0;
	wire [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	wire [0:0] andOp_15_in0;
	wire [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [0:0] br_0_happened_in_state_2_in_data;
	wire [0:0] br_0_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_2(.in_data(br_0_happened_in_state_2_in_data), .out_data(br_0_happened_in_state_2_out_data));

	wire [0:0] notOp_16_in0;
	wire [0:0] notOp_16_out;
	notOp #(.WIDTH(1)) notOp_16(.in(notOp_16_in0), .out(notOp_16_out));

	wire [0:0] andOp_17_in0;
	wire [0:0] andOp_17_in1;
	wire [0:0] andOp_17_out;
	andOp #(.WIDTH(1)) andOp_17(.in0(andOp_17_in0), .in1(andOp_17_in1), .out(andOp_17_out));

	wire [0:0] andOp_18_in0;
	wire [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [0:0] br_1_happened_in_state_3_in_data;
	wire [0:0] br_1_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_3(.in_data(br_1_happened_in_state_3_in_data), .out_data(br_1_happened_in_state_3_out_data));

	wire [0:0] notOp_19_in0;
	wire [0:0] notOp_19_out;
	notOp #(.WIDTH(1)) notOp_19(.in(notOp_19_in0), .out(notOp_19_out));

	wire [0:0] andOp_20_in0;
	wire [0:0] andOp_20_in1;
	wire [0:0] andOp_20_out;
	andOp #(.WIDTH(1)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	wire [0:0] notOp_21_in0;
	wire [0:0] notOp_21_out;
	notOp #(.WIDTH(1)) notOp_21(.in(notOp_21_in0), .out(notOp_21_out));

	wire [0:0] andOp_22_in0;
	wire [0:0] andOp_22_in1;
	wire [0:0] andOp_22_out;
	andOp #(.WIDTH(1)) andOp_22(.in0(andOp_22_in0), .in1(andOp_22_in1), .out(andOp_22_out));

	wire [31:0] eq_23_in0;
	wire [31:0] eq_23_in1;
	wire [0:0] eq_23_out;
	eq #(.WIDTH(32)) eq_23(.in0(eq_23_in0), .in1(eq_23_in1), .out(eq_23_out));

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

	wire [0:0] orOp_28_in0;
	wire [0:0] orOp_28_in1;
	wire [0:0] orOp_28_out;
	orOp #(.WIDTH(1)) orOp_28(.in0(orOp_28_in0), .in1(orOp_28_in1), .out(orOp_28_out));

	wire [31:0] eq_29_in0;
	wire [31:0] eq_29_in1;
	wire [0:0] eq_29_out;
	eq #(.WIDTH(32)) eq_29(.in0(eq_29_in0), .in1(eq_29_in1), .out(eq_29_out));

	wire [31:0] eq_30_in0;
	wire [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	wire [31:0] eq_31_in0;
	wire [31:0] eq_31_in1;
	wire [0:0] eq_31_out;
	eq #(.WIDTH(32)) eq_31(.in0(eq_31_in0), .in1(eq_31_in1), .out(eq_31_out));

	wire [31:0] eq_32_in0;
	wire [31:0] eq_32_in1;
	wire [0:0] eq_32_out;
	eq #(.WIDTH(32)) eq_32(.in0(eq_32_in0), .in1(eq_32_in1), .out(eq_32_out));

	wire [31:0] eq_33_in0;
	wire [31:0] eq_33_in1;
	wire [0:0] eq_33_out;
	eq #(.WIDTH(32)) eq_33(.in0(eq_33_in0), .in1(eq_33_in1), .out(eq_33_out));

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

	wire [0:0] andOp_48_in0;
	wire [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	wire [0:0] andOp_49_in0;
	wire [0:0] andOp_49_in1;
	wire [0:0] andOp_49_out;
	andOp #(.WIDTH(1)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

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

	wire [19:0] concat_60_in0;
	wire [19:0] concat_60_in1;
	wire [39:0] concat_60_out;
	concat #(.IN0_WIDTH(20), .IN1_WIDTH(20)) concat_60(.in0(concat_60_in0), .in1(concat_60_in1), .out(concat_60_out));

	wire [31:0] concat_61_in0;
	wire [31:0] concat_61_in1;
	wire [63:0] concat_61_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_61(.in0(concat_61_in0), .in1(concat_61_in1), .out(concat_61_out));

	wire [0:0] andOp_62_in0;
	wire [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	wire [0:0] andOp_63_in0;
	wire [0:0] andOp_63_in1;
	wire [0:0] andOp_63_out;
	andOp #(.WIDTH(1)) andOp_63(.in0(andOp_63_in0), .in1(andOp_63_in1), .out(andOp_63_out));

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

	wire [0:0] notOp_71_in0;
	wire [0:0] notOp_71_out;
	notOp #(.WIDTH(1)) notOp_71(.in(notOp_71_in0), .out(notOp_71_out));

	wire [0:0] andOp_72_in0;
	wire [0:0] andOp_72_in1;
	wire [0:0] andOp_72_out;
	andOp #(.WIDTH(1)) andOp_72(.in0(andOp_72_in0), .in1(andOp_72_in1), .out(andOp_72_out));

	wire [0:0] notOp_73_in0;
	wire [0:0] notOp_73_out;
	notOp #(.WIDTH(1)) notOp_73(.in(notOp_73_in0), .out(notOp_73_out));

	wire [0:0] andOp_74_in0;
	wire [0:0] andOp_74_in1;
	wire [0:0] andOp_74_out;
	andOp #(.WIDTH(1)) andOp_74(.in0(andOp_74_in0), .in1(andOp_74_in1), .out(andOp_74_out));

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

	wire [31:0] eq_78_in0;
	wire [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	wire [31:0] eq_79_in0;
	wire [31:0] eq_79_in1;
	wire [0:0] eq_79_out;
	eq #(.WIDTH(32)) eq_79(.in0(eq_79_in0), .in1(eq_79_in1), .out(eq_79_out));

	wire [31:0] eq_80_in0;
	wire [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

	wire [31:0] eq_81_in0;
	wire [31:0] eq_81_in1;
	wire [0:0] eq_81_out;
	eq #(.WIDTH(32)) eq_81(.in0(eq_81_in0), .in1(eq_81_in1), .out(eq_81_out));

	wire [0:0] andOp_82_in0;
	wire [0:0] andOp_82_in1;
	wire [0:0] andOp_82_out;
	andOp #(.WIDTH(1)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

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

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	assign add_in0_add_14 = sgt_out_sext_13;
	assign add_in1_add_14 = 32'd1;
	// controller for andOp_11.andOp_11_in0
	// controller for andOp_11.andOp_11_in1
	// Insensitive connections
	assign andOp_11_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_11_in1 = state_2_is_active;
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	assign andOp_12_in0 = andOp_11_out;
	assign andOp_12_in1 = 1'd1;
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	assign andOp_14_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_14_in1 = state_2_is_active;
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	assign andOp_15_in0 = andOp_14_out;
	assign andOp_15_in1 = 1'd1;
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	assign andOp_17_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_17_in1 = state_3_is_active;
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	assign andOp_18_in0 = andOp_17_out;
	assign andOp_18_in1 = 1'd1;
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	assign andOp_20_in0 = andOp_18_out;
	assign andOp_20_in1 = cmp_out_icmp_16;
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	assign andOp_22_in0 = andOp_18_out;
	assign andOp_22_in1 = notOp_21_out;
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	assign andOp_35_in0 = notOp_34_out;
	assign andOp_35_in1 = andOp_22_out;
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	assign andOp_36_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_36_in1 = state_0_is_active;
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	assign andOp_37_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_37_in1 = state_1_is_active;
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	assign andOp_38_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_38_in1 = state_2_is_active;
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
	assign andOp_46_in0 = bb_2_active_in_state_3_out_data;
	assign andOp_46_in1 = state_3_is_active;
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	assign andOp_47_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_47_in1 = state_3_is_active;
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	assign andOp_48_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_48_in1 = state_3_is_active;
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	assign andOp_49_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_49_in1 = state_3_is_active;
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	assign andOp_50_in0 = bb_1_active_in_state_3_out_data;
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
	assign andOp_58_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_58_in1 = state_3_is_active;
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	assign andOp_59_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_59_in1 = state_3_is_active;
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	assign andOp_62_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_62_in1 = state_0_is_active;
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	assign andOp_63_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_63_in1 = state_1_is_active;
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	assign andOp_64_in0 = bb_2_active_in_state_3_out_data;
	assign andOp_64_in1 = state_3_is_active;
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	assign andOp_66_in0 = notOp_65_out;
	assign andOp_66_in1 = 1'd1;
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	assign andOp_68_in0 = notOp_67_out;
	assign andOp_68_in1 = 1'd1;
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	assign andOp_70_in0 = notOp_69_out;
	assign andOp_70_in1 = 1'd1;
	// controller for andOp_72.andOp_72_in0
	// controller for andOp_72.andOp_72_in1
	// Insensitive connections
	assign andOp_72_in0 = notOp_71_out;
	assign andOp_72_in1 = andOp_70_out;
	// controller for andOp_74.andOp_74_in0
	// controller for andOp_74.andOp_74_in1
	// Insensitive connections
	assign andOp_74_in0 = notOp_73_out;
	assign andOp_74_in1 = andOp_72_out;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_8_in1 = state_2_is_active;
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	assign andOp_82_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_82_in1 = state_3_is_active;
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	assign andOp_9_in0 = andOp_8_out;
	assign andOp_9_in1 = 1'd1;
	// controller for arg_0.arg_0_rst_n_reg
	always @(*) begin
		if (andOp_36_out) begin 
			arg_0_rst_n_reg = 32'd1;
		end else if (andOp_37_out) begin 
			arg_0_rst_n_reg = 32'd0;
		end else if (andOp_38_out) begin 
			arg_0_rst_n_reg = 32'd1;
		end else begin
			arg_0_rst_n_reg = 1;
		end
	end
	// controller for arg_0.arg_0_word0_reg
	always @(*) begin
		if (andOp_39_out) begin 
			arg_0_word0_reg = arg_1_out_wire;
		end else begin
			arg_0_word0_reg = 0;
		end
	end
	// controller for arg_0.arg_0_word1_reg
	always @(*) begin
		if (andOp_41_out) begin 
			arg_0_word1_reg = arg_2_out_wire;
		end else begin
			arg_0_word1_reg = 0;
		end
	end
	// controller for arg_0.arg_0_word2_reg
	always @(*) begin
		if (andOp_42_out) begin 
			arg_0_word2_reg = arg_3_out_wire;
		end else begin
			arg_0_word2_reg = 0;
		end
	end
	// controller for arg_4.arg_4_in_wire_reg
	always @(*) begin
		if (andOp_55_out) begin 
			arg_4_in_wire_reg = arg_0_pixel1;
		end else begin
			arg_4_in_wire_reg = 0;
		end
	end
	// controller for arg_5.arg_5_in_wire_reg
	always @(*) begin
		if (andOp_56_out) begin 
			arg_5_in_wire_reg = arg_0_pixel2;
		end else begin
			arg_5_in_wire_reg = 0;
		end
	end
	// controller for arg_6.arg_6_in_wire_reg
	always @(*) begin
		if (andOp_57_out) begin 
			arg_6_in_wire_reg = arg_0_pixel3;
		end else begin
			arg_6_in_wire_reg = 0;
		end
	end
	// controller for arg_7.arg_7_in_wire_reg
	always @(*) begin
		if (andOp_58_out) begin 
			arg_7_in_wire_reg = arg_0_pixel4;
		end else begin
			arg_7_in_wire_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_23_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_24_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_2.bb_0_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_2_in_data = eq_25_out;
		end else begin
			bb_0_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_29_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_30_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_2.bb_0_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_31_out) begin 
			bb_0_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_3.bb_1_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_3_in_data = eq_26_out;
		end else begin
			bb_1_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_3.bb_1_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_32_out) begin 
			bb_1_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_3.bb_2_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_3_in_data = orOp_28_out;
		end else begin
			bb_2_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_3.bb_2_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_35_out) begin 
			bb_2_predecessor_in_state_3_in_data = 32'd1;
		end else if (eq_33_out) begin 
			bb_2_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_9_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_10_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_13_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_2.br_0_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_15_out) begin 
			br_0_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_16_out) begin 
			br_0_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_3.br_1_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_18_out) begin 
			br_1_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_19_out) begin 
			br_1_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_3_in_data = 0;
		end
	end
	// controller for concat_60.concat_60_in0
	// controller for concat_60.concat_60_in1
	// Insensitive connections
	assign concat_60_in0 = 20'd0;
	assign concat_60_in1 = data_in_3_7_out_data;
	// controller for concat_61.concat_61_in0
	// controller for concat_61.concat_61_in1
	// Insensitive connections
	assign concat_61_in0 = 32'd0;
	assign concat_61_in1 = 32'd1;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_75_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_3.data_in_1_3_in_data
	always @(*) begin
		if (eq_76_out) begin 
			data_in_1_3_in_data = data_store_0_0;
		end else if (eq_77_out) begin 
			data_in_1_3_in_data = data_store_1_2;
		end else begin
			data_in_1_3_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_78_out) begin 
			data_in_2_5_in_data = data_store_1_2;
		end else if (eq_79_out) begin 
			data_in_2_5_in_data = data_store_2_4;
		end else begin
			data_in_2_5_in_data = 0;
		end
	end
	// controller for data_in_3_7.data_in_3_7_in_data
	always @(*) begin
		if (eq_80_out) begin 
			data_in_3_7_in_data = data_store_2_4;
		end else if (eq_81_out) begin 
			data_in_3_7_in_data = data_store_3_6;
		end else begin
			data_in_3_7_in_data = 0;
		end
	end
	// controller for eq_23.eq_23_in0
	// controller for eq_23.eq_23_in1
	// Insensitive connections
	assign eq_23_in0 = 32'd0;
	assign eq_23_in1 = state_0_entry_BB_reg;
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	assign eq_24_in0 = 32'd0;
	assign eq_24_in1 = state_1_entry_BB_reg;
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	assign eq_25_in0 = 32'd0;
	assign eq_25_in1 = state_2_entry_BB_reg;
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	assign eq_26_in0 = 32'd1;
	assign eq_26_in1 = state_3_entry_BB_reg;
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	assign eq_27_in0 = 32'd2;
	assign eq_27_in1 = state_3_entry_BB_reg;
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	assign eq_29_in0 = 32'd0;
	assign eq_29_in1 = state_0_entry_BB_reg;
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	assign eq_30_in0 = 32'd0;
	assign eq_30_in1 = state_1_entry_BB_reg;
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	assign eq_31_in0 = 32'd0;
	assign eq_31_in1 = state_2_entry_BB_reg;
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	assign eq_32_in0 = 32'd1;
	assign eq_32_in1 = state_3_entry_BB_reg;
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	assign eq_33_in0 = 32'd2;
	assign eq_33_in1 = state_3_entry_BB_reg;
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	assign eq_75_in0 = 32'd0;
	assign eq_75_in1 = state_0_last_state;
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	assign eq_76_in0 = 32'd0;
	assign eq_76_in1 = state_1_last_state;
	// controller for eq_77.eq_77_in0
	// controller for eq_77.eq_77_in1
	// Insensitive connections
	assign eq_77_in0 = 32'd1;
	assign eq_77_in1 = state_1_last_state;
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	assign eq_78_in0 = 32'd1;
	assign eq_78_in1 = state_2_last_state;
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	assign eq_79_in0 = 32'd2;
	assign eq_79_in1 = state_2_last_state;
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	assign eq_80_in0 = 32'd2;
	assign eq_80_in1 = state_3_last_state;
	// controller for eq_81.eq_81_in0
	// controller for eq_81.eq_81_in1
	// Insensitive connections
	assign eq_81_in0 = 32'd3;
	assign eq_81_in1 = state_3_last_state;
	// controller for icmp_16.cmp_in0_icmp_16
	// controller for icmp_16.cmp_in1_icmp_16
	// Insensitive connections
	assign cmp_in0_icmp_16 = sgt_out_sext_11;
	assign cmp_in1_icmp_16 = 32'd101125;
	// controller for notOp_10.notOp_10_in0
	// Insensitive connections
	assign notOp_10_in0 = andOp_9_out;
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	assign notOp_13_in0 = andOp_12_out;
	// controller for notOp_16.notOp_16_in0
	// Insensitive connections
	assign notOp_16_in0 = andOp_15_out;
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	assign notOp_19_in0 = andOp_18_out;
	// controller for notOp_21.notOp_21_in0
	// Insensitive connections
	assign notOp_21_in0 = cmp_out_icmp_16;
	// controller for notOp_34.notOp_34_in0
	// Insensitive connections
	assign notOp_34_in0 = eq_33_out;
	// controller for notOp_65.notOp_65_in0
	// Insensitive connections
	assign notOp_65_in0 = andOp_62_out;
	// controller for notOp_67.notOp_67_in0
	// Insensitive connections
	assign notOp_67_in0 = andOp_63_out;
	// controller for notOp_69.notOp_69_in0
	// Insensitive connections
	assign notOp_69_in0 = andOp_20_out;
	// controller for notOp_71.notOp_71_in0
	// Insensitive connections
	assign notOp_71_in0 = andOp_64_out;
	// controller for notOp_73.notOp_73_in0
	// Insensitive connections
	assign notOp_73_in0 = andOp_9_out;
	// controller for orOp_28.orOp_28_in0
	// controller for orOp_28.orOp_28_in1
	// Insensitive connections
	assign orOp_28_in0 = eq_27_out;
	assign orOp_28_in1 = andOp_22_out;
	// controller for phi_25.phi_in_phi_25
	// controller for phi_25.phi_last_block_phi_25
	// controller for phi_25.phi_s_phi_25
	// Insensitive connections
	assign phi_in_phi_25 = concat_60_out;
	assign phi_last_block_phi_25 = bb_1_predecessor_in_state_3_out_data;
	assign phi_s_phi_25 = concat_61_out;
	// controller for ret_4.valid_reg
	always @(*) begin
		if (andOp_46_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for sext_11.sgt_in0_sext_11
	// Insensitive connections
	assign sgt_in0_sext_11 = trunc_out_trunc_15;
	// controller for sext_13.sgt_in0_sext_13
	// Insensitive connections
	assign sgt_in0_sext_13 = phi_out_phi_25;
	// controller for trunc_15.trunc_in_trunc_15
	// Insensitive connections
	assign trunc_in_trunc_15 = add_out_add_14;
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
			if (andOp_82_out) begin
				data_store_3_6 <= trunc_out_trunc_15;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_20_out) begin
				global_state <= 32'd3;
			end
			if (andOp_62_out) begin
				global_state <= 32'd1;
			end
			if (andOp_63_out) begin
				global_state <= 32'd2;
			end
			if (andOp_64_out) begin
				global_state <= 32'd3;
			end
			if (andOp_9_out) begin
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
			if (andOp_62_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_62_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_66_out) begin
				state_1_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_62_out) begin
				state_1_last_BB_reg <= bb_0_predecessor_in_state_0_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_62_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_63_out) begin
				state_2_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_63_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_68_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_63_out) begin
				state_2_last_BB_reg <= bb_0_predecessor_in_state_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_63_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_20_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
			if (andOp_64_out) begin
				state_3_entry_BB_reg <= 32'd2;
			end
			if (andOp_9_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_20_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_64_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_74_out) begin
				state_3_is_active <= 1'd0;
			end
			if (andOp_9_out) begin
				state_3_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_20_out) begin
				state_3_last_BB_reg <= 32'd1;
			end
			if (andOp_64_out) begin
				state_3_last_BB_reg <= bb_2_predecessor_in_state_3_out_data;
			end
			if (andOp_9_out) begin
				state_3_last_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_20_out) begin
				state_3_last_state <= 32'd3;
			end
			if (andOp_64_out) begin
				state_3_last_state <= 32'd3;
			end
			if (andOp_9_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

endmodule

