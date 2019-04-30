module median_filter(input [0:0] clk, input [0:0] rst, output [31:0] in2_in_data, input [31:0] in2_out_data, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data, output [31:0] out_in_data, input [31:0] out_out_data, output [0:0] valid);

	reg [31:0] in2_in_data_reg;
	reg [31:0] in0_in_data_reg;
	reg [31:0] in1_in_data_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] valid_reg;

	assign in2_in_data = in2_in_data_reg;
	assign in0_in_data = in0_in_data_reg;
	assign in1_in_data = in1_in_data_reg;
	assign out_in_data = out_in_data_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [63:0] phi_in_phi_5;
	reg [31:0] phi_last_block_phi_5;
	reg [63:0] phi_s_phi_5;
	wire [31:0] phi_out_phi_5;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_5(.in(phi_in_phi_5), .last_block(phi_last_block_phi_5), .out(phi_out_phi_5), .s(phi_s_phi_5));

	reg [0:0] m_rst_n;
	reg [31:0] m_word0;
	reg [31:0] m_word1;
	reg [31:0] m_word2;
	wire [31:0] m_median_word;
	median m(.clk(clk), .median_word(m_median_word), .rst_n(m_rst_n), .word0(m_word0), .word1(m_word1), .word2(m_word2));

	reg [31:0] cmp_in0_icmp_11;
	reg [31:0] cmp_in1_icmp_11;
	wire [0:0] cmp_out_icmp_11;
	ne #(.WIDTH(32)) icmp_11(.in0(cmp_in0_icmp_11), .in1(cmp_in1_icmp_11), .out(cmp_out_icmp_11));

	br_dummy br_unit();

	reg [31:0] add_in0_add_14;
	reg [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	reg [31:0] data_in_0_1_in_data;
	wire [31:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [31:0] data_in_1_3_in_data;
	wire [31:0] data_in_1_3_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_3(.in_data(data_in_1_3_in_data), .out_data(data_in_1_3_out_data));

	reg [31:0] data_in_2_5_in_data;
	wire [31:0] data_in_2_5_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_5(.in_data(data_in_2_5_in_data), .out_data(data_in_2_5_out_data));

	reg [0:0] bb_2_active_in_state_0_in_data;
	wire [0:0] bb_2_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_0(.in_data(bb_2_active_in_state_0_in_data), .out_data(bb_2_active_in_state_0_out_data));

	reg [31:0] bb_2_predecessor_in_state_0_in_data;
	wire [31:0] bb_2_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_0(.in_data(bb_2_predecessor_in_state_0_in_data), .out_data(bb_2_predecessor_in_state_0_out_data));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] bb_2_active_in_state_1_in_data;
	wire [0:0] bb_2_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_1(.in_data(bb_2_active_in_state_1_in_data), .out_data(bb_2_active_in_state_1_out_data));

	reg [31:0] bb_2_predecessor_in_state_1_in_data;
	wire [31:0] bb_2_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_1(.in_data(bb_2_predecessor_in_state_1_in_data), .out_data(bb_2_predecessor_in_state_1_out_data));

	reg [0:0] bb_4_active_in_state_2_in_data;
	wire [0:0] bb_4_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_2(.in_data(bb_4_active_in_state_2_in_data), .out_data(bb_4_active_in_state_2_out_data));

	reg [31:0] bb_4_predecessor_in_state_2_in_data;
	wire [31:0] bb_4_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_2(.in_data(bb_4_predecessor_in_state_2_in_data), .out_data(bb_4_predecessor_in_state_2_out_data));

	reg [0:0] bb_3_active_in_state_2_in_data;
	wire [0:0] bb_3_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active_in_state_2(.in_data(bb_3_active_in_state_2_in_data), .out_data(bb_3_active_in_state_2_out_data));

	reg [31:0] bb_3_predecessor_in_state_2_in_data;
	wire [31:0] bb_3_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_3_predecessor_in_state_2(.in_data(bb_3_predecessor_in_state_2_in_data), .out_data(bb_3_predecessor_in_state_2_out_data));

	reg [0:0] bb_1_active_in_state_2_in_data;
	wire [0:0] bb_1_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_2(.in_data(bb_1_active_in_state_2_in_data), .out_data(bb_1_active_in_state_2_out_data));

	reg [31:0] bb_1_predecessor_in_state_2_in_data;
	wire [31:0] bb_1_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_2(.in_data(bb_1_predecessor_in_state_2_in_data), .out_data(bb_1_predecessor_in_state_2_out_data));

	reg [0:0] bb_2_active_in_state_2_in_data;
	wire [0:0] bb_2_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_2(.in_data(bb_2_active_in_state_2_in_data), .out_data(bb_2_active_in_state_2_out_data));

	reg [31:0] bb_2_predecessor_in_state_2_in_data;
	wire [31:0] bb_2_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_2(.in_data(bb_2_predecessor_in_state_2_in_data), .out_data(bb_2_predecessor_in_state_2_out_data));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] andOp_7_in0;
	reg [0:0] andOp_7_in1;
	wire [0:0] andOp_7_out;
	andOp #(.WIDTH(1)) andOp_7(.in0(andOp_7_in0), .in1(andOp_7_in1), .out(andOp_7_out));

	reg [0:0] br_2_happened_in_state_0_in_data;
	wire [0:0] br_2_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened_in_state_0(.in_data(br_2_happened_in_state_0_in_data), .out_data(br_2_happened_in_state_0_out_data));

	reg [0:0] notOp_8_in0;
	wire [0:0] notOp_8_out;
	notOp #(.WIDTH(1)) notOp_8(.in(notOp_8_in0), .out(notOp_8_out));

	reg [0:0] andOp_9_in0;
	reg [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	reg [0:0] andOp_10_in0;
	reg [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] notOp_11_in0;
	wire [0:0] notOp_11_out;
	notOp #(.WIDTH(1)) notOp_11(.in(notOp_11_in0), .out(notOp_11_out));

	reg [0:0] andOp_12_in0;
	reg [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] andOp_13_in0;
	reg [0:0] andOp_13_in1;
	wire [0:0] andOp_13_out;
	andOp #(.WIDTH(1)) andOp_13(.in0(andOp_13_in0), .in1(andOp_13_in1), .out(andOp_13_out));

	reg [0:0] br_2_happened_in_state_1_in_data;
	wire [0:0] br_2_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened_in_state_1(.in_data(br_2_happened_in_state_1_in_data), .out_data(br_2_happened_in_state_1_out_data));

	reg [0:0] notOp_14_in0;
	wire [0:0] notOp_14_out;
	notOp #(.WIDTH(1)) notOp_14(.in(notOp_14_in0), .out(notOp_14_out));

	reg [0:0] andOp_15_in0;
	reg [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [0:0] andOp_16_in0;
	reg [0:0] andOp_16_in1;
	wire [0:0] andOp_16_out;
	andOp #(.WIDTH(1)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

	reg [0:0] br_4_happened_in_state_2_in_data;
	wire [0:0] br_4_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_2(.in_data(br_4_happened_in_state_2_in_data), .out_data(br_4_happened_in_state_2_out_data));

	reg [0:0] notOp_17_in0;
	wire [0:0] notOp_17_out;
	notOp #(.WIDTH(1)) notOp_17(.in(notOp_17_in0), .out(notOp_17_out));

	reg [0:0] andOp_18_in0;
	reg [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [0:0] notOp_19_in0;
	wire [0:0] notOp_19_out;
	notOp #(.WIDTH(1)) notOp_19(.in(notOp_19_in0), .out(notOp_19_out));

	reg [0:0] andOp_20_in0;
	reg [0:0] andOp_20_in1;
	wire [0:0] andOp_20_out;
	andOp #(.WIDTH(1)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	reg [0:0] andOp_21_in0;
	reg [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [0:0] andOp_22_in0;
	reg [0:0] andOp_22_in1;
	wire [0:0] andOp_22_out;
	andOp #(.WIDTH(1)) andOp_22(.in0(andOp_22_in0), .in1(andOp_22_in1), .out(andOp_22_out));

	reg [0:0] br_3_happened_in_state_2_in_data;
	wire [0:0] br_3_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_2(.in_data(br_3_happened_in_state_2_in_data), .out_data(br_3_happened_in_state_2_out_data));

	reg [0:0] notOp_23_in0;
	wire [0:0] notOp_23_out;
	notOp #(.WIDTH(1)) notOp_23(.in(notOp_23_in0), .out(notOp_23_out));

	reg [0:0] andOp_24_in0;
	reg [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

	reg [0:0] andOp_25_in0;
	reg [0:0] andOp_25_in1;
	wire [0:0] andOp_25_out;
	andOp #(.WIDTH(1)) andOp_25(.in0(andOp_25_in0), .in1(andOp_25_in1), .out(andOp_25_out));

	reg [0:0] br_2_happened_in_state_2_in_data;
	wire [0:0] br_2_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened_in_state_2(.in_data(br_2_happened_in_state_2_in_data), .out_data(br_2_happened_in_state_2_out_data));

	reg [0:0] notOp_26_in0;
	wire [0:0] notOp_26_out;
	notOp #(.WIDTH(1)) notOp_26(.in(notOp_26_in0), .out(notOp_26_out));

	reg [31:0] eq_27_in0;
	reg [31:0] eq_27_in1;
	wire [0:0] eq_27_out;
	eq #(.WIDTH(32)) eq_27(.in0(eq_27_in0), .in1(eq_27_in1), .out(eq_27_out));

	reg [0:0] orOp_28_in0;
	reg [0:0] orOp_28_in1;
	wire [0:0] orOp_28_out;
	orOp #(.WIDTH(1)) orOp_28(.in0(orOp_28_in0), .in1(orOp_28_in1), .out(orOp_28_out));

	reg [31:0] eq_29_in0;
	reg [31:0] eq_29_in1;
	wire [0:0] eq_29_out;
	eq #(.WIDTH(32)) eq_29(.in0(eq_29_in0), .in1(eq_29_in1), .out(eq_29_out));

	reg [31:0] eq_30_in0;
	reg [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	reg [31:0] eq_31_in0;
	reg [31:0] eq_31_in1;
	wire [0:0] eq_31_out;
	eq #(.WIDTH(32)) eq_31(.in0(eq_31_in0), .in1(eq_31_in1), .out(eq_31_out));

	reg [0:0] orOp_32_in0;
	reg [0:0] orOp_32_in1;
	wire [0:0] orOp_32_out;
	orOp #(.WIDTH(1)) orOp_32(.in0(orOp_32_in0), .in1(orOp_32_in1), .out(orOp_32_out));

	reg [31:0] eq_33_in0;
	reg [31:0] eq_33_in1;
	wire [0:0] eq_33_out;
	eq #(.WIDTH(32)) eq_33(.in0(eq_33_in0), .in1(eq_33_in1), .out(eq_33_out));

	reg [0:0] orOp_34_in0;
	reg [0:0] orOp_34_in1;
	wire [0:0] orOp_34_out;
	orOp #(.WIDTH(1)) orOp_34(.in0(orOp_34_in0), .in1(orOp_34_in1), .out(orOp_34_out));

	reg [31:0] eq_35_in0;
	reg [31:0] eq_35_in1;
	wire [0:0] eq_35_out;
	eq #(.WIDTH(32)) eq_35(.in0(eq_35_in0), .in1(eq_35_in1), .out(eq_35_out));

	reg [0:0] orOp_36_in0;
	reg [0:0] orOp_36_in1;
	wire [0:0] orOp_36_out;
	orOp #(.WIDTH(1)) orOp_36(.in0(orOp_36_in0), .in1(orOp_36_in1), .out(orOp_36_out));

	reg [31:0] eq_37_in0;
	reg [31:0] eq_37_in1;
	wire [0:0] eq_37_out;
	eq #(.WIDTH(32)) eq_37(.in0(eq_37_in0), .in1(eq_37_in1), .out(eq_37_out));

	reg [31:0] eq_38_in0;
	reg [31:0] eq_38_in1;
	wire [0:0] eq_38_out;
	eq #(.WIDTH(32)) eq_38(.in0(eq_38_in0), .in1(eq_38_in1), .out(eq_38_out));

	reg [0:0] notOp_39_in0;
	wire [0:0] notOp_39_out;
	notOp #(.WIDTH(1)) notOp_39(.in(notOp_39_in0), .out(notOp_39_out));

	reg [0:0] andOp_40_in0;
	reg [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	reg [31:0] eq_41_in0;
	reg [31:0] eq_41_in1;
	wire [0:0] eq_41_out;
	eq #(.WIDTH(32)) eq_41(.in0(eq_41_in0), .in1(eq_41_in1), .out(eq_41_out));

	reg [31:0] eq_42_in0;
	reg [31:0] eq_42_in1;
	wire [0:0] eq_42_out;
	eq #(.WIDTH(32)) eq_42(.in0(eq_42_in0), .in1(eq_42_in1), .out(eq_42_out));

	reg [31:0] eq_43_in0;
	reg [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	reg [0:0] notOp_44_in0;
	wire [0:0] notOp_44_out;
	notOp #(.WIDTH(1)) notOp_44(.in(notOp_44_in0), .out(notOp_44_out));

	reg [0:0] andOp_45_in0;
	reg [0:0] andOp_45_in1;
	wire [0:0] andOp_45_out;
	andOp #(.WIDTH(1)) andOp_45(.in0(andOp_45_in0), .in1(andOp_45_in1), .out(andOp_45_out));

	reg [31:0] eq_46_in0;
	reg [31:0] eq_46_in1;
	wire [0:0] eq_46_out;
	eq #(.WIDTH(32)) eq_46(.in0(eq_46_in0), .in1(eq_46_in1), .out(eq_46_out));

	reg [0:0] notOp_47_in0;
	wire [0:0] notOp_47_out;
	notOp #(.WIDTH(1)) notOp_47(.in(notOp_47_in0), .out(notOp_47_out));

	reg [0:0] andOp_48_in0;
	reg [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	reg [31:0] eq_49_in0;
	reg [31:0] eq_49_in1;
	wire [0:0] eq_49_out;
	eq #(.WIDTH(32)) eq_49(.in0(eq_49_in0), .in1(eq_49_in1), .out(eq_49_out));

	reg [0:0] notOp_50_in0;
	wire [0:0] notOp_50_out;
	notOp #(.WIDTH(1)) notOp_50(.in(notOp_50_in0), .out(notOp_50_out));

	reg [0:0] andOp_51_in0;
	reg [0:0] andOp_51_in1;
	wire [0:0] andOp_51_out;
	andOp #(.WIDTH(1)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	reg [31:0] eq_52_in0;
	reg [31:0] eq_52_in1;
	wire [0:0] eq_52_out;
	eq #(.WIDTH(32)) eq_52(.in0(eq_52_in0), .in1(eq_52_in1), .out(eq_52_out));

	reg [0:0] andOp_53_in0;
	reg [0:0] andOp_53_in1;
	wire [0:0] andOp_53_out;
	andOp #(.WIDTH(1)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	reg [0:0] andOp_54_in0;
	reg [0:0] andOp_54_in1;
	wire [0:0] andOp_54_out;
	andOp #(.WIDTH(1)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	reg [0:0] andOp_55_in0;
	reg [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	reg [0:0] andOp_56_in0;
	reg [0:0] andOp_56_in1;
	wire [0:0] andOp_56_out;
	andOp #(.WIDTH(1)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

	reg [0:0] andOp_57_in0;
	reg [0:0] andOp_57_in1;
	wire [0:0] andOp_57_out;
	andOp #(.WIDTH(1)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

	reg [0:0] andOp_58_in0;
	reg [0:0] andOp_58_in1;
	wire [0:0] andOp_58_out;
	andOp #(.WIDTH(1)) andOp_58(.in0(andOp_58_in0), .in1(andOp_58_in1), .out(andOp_58_out));

	reg [0:0] andOp_59_in0;
	reg [0:0] andOp_59_in1;
	wire [0:0] andOp_59_out;
	andOp #(.WIDTH(1)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	reg [0:0] andOp_60_in0;
	reg [0:0] andOp_60_in1;
	wire [0:0] andOp_60_out;
	andOp #(.WIDTH(1)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	reg [0:0] andOp_61_in0;
	reg [0:0] andOp_61_in1;
	wire [0:0] andOp_61_out;
	andOp #(.WIDTH(1)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

	reg [0:0] andOp_62_in0;
	reg [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	reg [31:0] concat_63_in0;
	reg [31:0] concat_63_in1;
	wire [63:0] concat_63_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_63(.in0(concat_63_in0), .in1(concat_63_in1), .out(concat_63_out));

	reg [31:0] concat_64_in0;
	reg [31:0] concat_64_in1;
	wire [63:0] concat_64_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_64(.in0(concat_64_in0), .in1(concat_64_in1), .out(concat_64_out));

	reg [0:0] andOp_65_in0;
	reg [0:0] andOp_65_in1;
	wire [0:0] andOp_65_out;
	andOp #(.WIDTH(1)) andOp_65(.in0(andOp_65_in0), .in1(andOp_65_in1), .out(andOp_65_out));

	reg [0:0] andOp_66_in0;
	reg [0:0] andOp_66_in1;
	wire [0:0] andOp_66_out;
	andOp #(.WIDTH(1)) andOp_66(.in0(andOp_66_in0), .in1(andOp_66_in1), .out(andOp_66_out));

	reg [0:0] andOp_67_in0;
	reg [0:0] andOp_67_in1;
	wire [0:0] andOp_67_out;
	andOp #(.WIDTH(1)) andOp_67(.in0(andOp_67_in0), .in1(andOp_67_in1), .out(andOp_67_out));

	reg [0:0] andOp_68_in0;
	reg [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	reg [0:0] andOp_69_in0;
	reg [0:0] andOp_69_in1;
	wire [0:0] andOp_69_out;
	andOp #(.WIDTH(1)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	reg [0:0] andOp_70_in0;
	reg [0:0] andOp_70_in1;
	wire [0:0] andOp_70_out;
	andOp #(.WIDTH(1)) andOp_70(.in0(andOp_70_in0), .in1(andOp_70_in1), .out(andOp_70_out));

	reg [0:0] andOp_71_in0;
	reg [0:0] andOp_71_in1;
	wire [0:0] andOp_71_out;
	andOp #(.WIDTH(1)) andOp_71(.in0(andOp_71_in0), .in1(andOp_71_in1), .out(andOp_71_out));

	reg [0:0] andOp_72_in0;
	reg [0:0] andOp_72_in1;
	wire [0:0] andOp_72_out;
	andOp #(.WIDTH(1)) andOp_72(.in0(andOp_72_in0), .in1(andOp_72_in1), .out(andOp_72_out));

	reg [0:0] andOp_73_in0;
	reg [0:0] andOp_73_in1;
	wire [0:0] andOp_73_out;
	andOp #(.WIDTH(1)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	reg [0:0] notOp_74_in0;
	wire [0:0] notOp_74_out;
	notOp #(.WIDTH(1)) notOp_74(.in(notOp_74_in0), .out(notOp_74_out));

	reg [0:0] andOp_75_in0;
	reg [0:0] andOp_75_in1;
	wire [0:0] andOp_75_out;
	andOp #(.WIDTH(1)) andOp_75(.in0(andOp_75_in0), .in1(andOp_75_in1), .out(andOp_75_out));

	reg [0:0] notOp_76_in0;
	wire [0:0] notOp_76_out;
	notOp #(.WIDTH(1)) notOp_76(.in(notOp_76_in0), .out(notOp_76_out));

	reg [0:0] andOp_77_in0;
	reg [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	reg [0:0] notOp_78_in0;
	wire [0:0] notOp_78_out;
	notOp #(.WIDTH(1)) notOp_78(.in(notOp_78_in0), .out(notOp_78_out));

	reg [0:0] andOp_79_in0;
	reg [0:0] andOp_79_in1;
	wire [0:0] andOp_79_out;
	andOp #(.WIDTH(1)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	reg [0:0] notOp_80_in0;
	wire [0:0] notOp_80_out;
	notOp #(.WIDTH(1)) notOp_80(.in(notOp_80_in0), .out(notOp_80_out));

	reg [0:0] andOp_81_in0;
	reg [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	reg [31:0] eq_82_in0;
	reg [31:0] eq_82_in1;
	wire [0:0] eq_82_out;
	eq #(.WIDTH(32)) eq_82(.in0(eq_82_in0), .in1(eq_82_in1), .out(eq_82_out));

	reg [0:0] andOp_83_in0;
	reg [0:0] andOp_83_in1;
	wire [0:0] andOp_83_out;
	andOp #(.WIDTH(1)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	reg [31:0] eq_84_in0;
	reg [31:0] eq_84_in1;
	wire [0:0] eq_84_out;
	eq #(.WIDTH(32)) eq_84(.in0(eq_84_in0), .in1(eq_84_in1), .out(eq_84_out));

	reg [0:0] andOp_85_in0;
	reg [0:0] andOp_85_in1;
	wire [0:0] andOp_85_out;
	andOp #(.WIDTH(1)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	reg [0:0] notOp_86_in0;
	wire [0:0] notOp_86_out;
	notOp #(.WIDTH(1)) notOp_86(.in(notOp_86_in0), .out(notOp_86_out));

	reg [0:0] andOp_87_in0;
	reg [0:0] andOp_87_in1;
	wire [0:0] andOp_87_out;
	andOp #(.WIDTH(1)) andOp_87(.in0(andOp_87_in0), .in1(andOp_87_in1), .out(andOp_87_out));

	reg [0:0] notOp_88_in0;
	wire [0:0] notOp_88_out;
	notOp #(.WIDTH(1)) notOp_88(.in(notOp_88_in0), .out(notOp_88_out));

	reg [0:0] andOp_89_in0;
	reg [0:0] andOp_89_in1;
	wire [0:0] andOp_89_out;
	andOp #(.WIDTH(1)) andOp_89(.in0(andOp_89_in0), .in1(andOp_89_in1), .out(andOp_89_out));

	reg [0:0] notOp_90_in0;
	wire [0:0] notOp_90_out;
	notOp #(.WIDTH(1)) notOp_90(.in(notOp_90_in0), .out(notOp_90_out));

	reg [0:0] andOp_91_in0;
	reg [0:0] andOp_91_in1;
	wire [0:0] andOp_91_out;
	andOp #(.WIDTH(1)) andOp_91(.in0(andOp_91_in0), .in1(andOp_91_in1), .out(andOp_91_out));

	reg [31:0] eq_92_in0;
	reg [31:0] eq_92_in1;
	wire [0:0] eq_92_out;
	eq #(.WIDTH(32)) eq_92(.in0(eq_92_in0), .in1(eq_92_in1), .out(eq_92_out));

	reg [31:0] eq_93_in0;
	reg [31:0] eq_93_in1;
	wire [0:0] eq_93_out;
	eq #(.WIDTH(32)) eq_93(.in0(eq_93_in0), .in1(eq_93_in1), .out(eq_93_out));

	reg [0:0] andOp_94_in0;
	reg [0:0] andOp_94_in1;
	wire [0:0] andOp_94_out;
	andOp #(.WIDTH(1)) andOp_94(.in0(andOp_94_in0), .in1(andOp_94_in1), .out(andOp_94_out));

	reg [31:0] eq_95_in0;
	reg [31:0] eq_95_in1;
	wire [0:0] eq_95_out;
	eq #(.WIDTH(32)) eq_95(.in0(eq_95_in0), .in1(eq_95_in1), .out(eq_95_out));

	reg [0:0] andOp_96_in0;
	reg [0:0] andOp_96_in1;
	wire [0:0] andOp_96_out;
	andOp #(.WIDTH(1)) andOp_96(.in0(andOp_96_in0), .in1(andOp_96_in1), .out(andOp_96_out));

	reg [0:0] notOp_97_in0;
	wire [0:0] notOp_97_out;
	notOp #(.WIDTH(1)) notOp_97(.in(notOp_97_in0), .out(notOp_97_out));

	reg [0:0] andOp_98_in0;
	reg [0:0] andOp_98_in1;
	wire [0:0] andOp_98_out;
	andOp #(.WIDTH(1)) andOp_98(.in0(andOp_98_in0), .in1(andOp_98_in1), .out(andOp_98_out));

	reg [0:0] notOp_99_in0;
	wire [0:0] notOp_99_out;
	notOp #(.WIDTH(1)) notOp_99(.in(notOp_99_in0), .out(notOp_99_out));

	reg [0:0] andOp_100_in0;
	reg [0:0] andOp_100_in1;
	wire [0:0] andOp_100_out;
	andOp #(.WIDTH(1)) andOp_100(.in0(andOp_100_in0), .in1(andOp_100_in1), .out(andOp_100_out));

	reg [0:0] notOp_101_in0;
	wire [0:0] notOp_101_out;
	notOp #(.WIDTH(1)) notOp_101(.in(notOp_101_in0), .out(notOp_101_out));

	reg [0:0] andOp_102_in0;
	reg [0:0] andOp_102_in1;
	wire [0:0] andOp_102_out;
	andOp #(.WIDTH(1)) andOp_102(.in0(andOp_102_in0), .in1(andOp_102_in1), .out(andOp_102_out));

	reg [31:0] eq_103_in0;
	reg [31:0] eq_103_in1;
	wire [0:0] eq_103_out;
	eq #(.WIDTH(32)) eq_103(.in0(eq_103_in0), .in1(eq_103_in1), .out(eq_103_out));

	reg [31:0] eq_104_in0;
	reg [31:0] eq_104_in1;
	wire [0:0] eq_104_out;
	eq #(.WIDTH(32)) eq_104(.in0(eq_104_in0), .in1(eq_104_in1), .out(eq_104_out));

	reg [0:0] andOp_105_in0;
	reg [0:0] andOp_105_in1;
	wire [0:0] andOp_105_out;
	andOp #(.WIDTH(1)) andOp_105(.in0(andOp_105_in0), .in1(andOp_105_in1), .out(andOp_105_out));

	reg [31:0] eq_106_in0;
	reg [31:0] eq_106_in1;
	wire [0:0] eq_106_out;
	eq #(.WIDTH(32)) eq_106(.in0(eq_106_in0), .in1(eq_106_in1), .out(eq_106_out));

	reg [0:0] andOp_107_in0;
	reg [0:0] andOp_107_in1;
	wire [0:0] andOp_107_out;
	andOp #(.WIDTH(1)) andOp_107(.in0(andOp_107_in0), .in1(andOp_107_in1), .out(andOp_107_out));

	reg [0:0] notOp_108_in0;
	wire [0:0] notOp_108_out;
	notOp #(.WIDTH(1)) notOp_108(.in(notOp_108_in0), .out(notOp_108_out));

	reg [0:0] andOp_109_in0;
	reg [0:0] andOp_109_in1;
	wire [0:0] andOp_109_out;
	andOp #(.WIDTH(1)) andOp_109(.in0(andOp_109_in0), .in1(andOp_109_in1), .out(andOp_109_out));

	reg [0:0] notOp_110_in0;
	wire [0:0] notOp_110_out;
	notOp #(.WIDTH(1)) notOp_110(.in(notOp_110_in0), .out(notOp_110_out));

	reg [0:0] andOp_111_in0;
	reg [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [0:0] notOp_112_in0;
	wire [0:0] notOp_112_out;
	notOp #(.WIDTH(1)) notOp_112(.in(notOp_112_in0), .out(notOp_112_out));

	reg [0:0] andOp_113_in0;
	reg [0:0] andOp_113_in1;
	wire [0:0] andOp_113_out;
	andOp #(.WIDTH(1)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	// End Functional Units

	reg [31:0] data_store_0_0;
	reg [31:0] data_store_1_2;
	reg [31:0] data_store_2_4;
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

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? phi_out_phi_5 : phi_out_phi_5;
		add_in1_add_14 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	always @(*) begin
		andOp_10_in0 = valid ? andOp_9_out : andOp_9_out;
		andOp_10_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_100.andOp_100_in0
	// controller for andOp_100.andOp_100_in1
	// Insensitive connections
	always @(*) begin
		andOp_100_in0 = valid ? state_1_is_active : state_1_is_active;
		andOp_100_in1 = valid ? notOp_99_out : notOp_99_out;
	end
	// controller for andOp_102.andOp_102_in0
	// controller for andOp_102.andOp_102_in1
	// Insensitive connections
	always @(*) begin
		andOp_102_in0 = valid ? state_1_is_active : state_1_is_active;
		andOp_102_in1 = valid ? notOp_101_out : notOp_101_out;
	end
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	always @(*) begin
		andOp_105_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_105_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	always @(*) begin
		andOp_107_in0 = valid ? andOp_105_out : andOp_105_out;
		andOp_107_in1 = valid ? eq_106_out : eq_106_out;
	end
	// controller for andOp_109.andOp_109_in0
	// controller for andOp_109.andOp_109_in1
	// Insensitive connections
	always @(*) begin
		andOp_109_in0 = valid ? andOp_105_out : andOp_105_out;
		andOp_109_in1 = valid ? notOp_108_out : notOp_108_out;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? state_2_is_active : state_2_is_active;
		andOp_111_in1 = valid ? notOp_110_out : notOp_110_out;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? state_2_is_active : state_2_is_active;
		andOp_113_in1 = valid ? notOp_112_out : notOp_112_out;
	end
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? bb_2_active_in_state_2_out_data : bb_2_active_in_state_2_out_data;
		andOp_12_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_13.andOp_13_in0
	// controller for andOp_13.andOp_13_in1
	// Insensitive connections
	always @(*) begin
		andOp_13_in0 = valid ? andOp_12_out : andOp_12_out;
		andOp_13_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	always @(*) begin
		andOp_15_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_15_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? andOp_15_out : andOp_15_out;
		andOp_16_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? andOp_16_out : andOp_16_out;
		andOp_18_in1 = valid ? cmp_out_icmp_11 : cmp_out_icmp_11;
	end
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	always @(*) begin
		andOp_20_in0 = valid ? andOp_16_out : andOp_16_out;
		andOp_20_in1 = valid ? notOp_19_out : notOp_19_out;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? bb_3_active_in_state_2_out_data : bb_3_active_in_state_2_out_data;
		andOp_21_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	always @(*) begin
		andOp_22_in0 = valid ? andOp_21_out : andOp_21_out;
		andOp_22_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_24.andOp_24_in0
	// controller for andOp_24.andOp_24_in1
	// Insensitive connections
	always @(*) begin
		andOp_24_in0 = valid ? bb_2_active_in_state_2_out_data : bb_2_active_in_state_2_out_data;
		andOp_24_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? andOp_24_out : andOp_24_out;
		andOp_25_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? notOp_39_out : notOp_39_out;
		andOp_40_in1 = valid ? andOp_10_out : andOp_10_out;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? notOp_44_out : notOp_44_out;
		andOp_45_in1 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? notOp_47_out : notOp_47_out;
		andOp_48_in1 = valid ? andOp_20_out : andOp_20_out;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? notOp_50_out : notOp_50_out;
		andOp_51_in1 = valid ? andOp_22_out : andOp_22_out;
	end
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	always @(*) begin
		andOp_53_in0 = valid ? bb_2_active_in_state_0_out_data : bb_2_active_in_state_0_out_data;
		andOp_53_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_54_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	always @(*) begin
		andOp_55_in0 = valid ? bb_2_active_in_state_1_out_data : bb_2_active_in_state_1_out_data;
		andOp_55_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_56_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	always @(*) begin
		andOp_57_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_57_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	always @(*) begin
		andOp_58_in0 = valid ? bb_2_active_in_state_2_out_data : bb_2_active_in_state_2_out_data;
		andOp_58_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_59_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? bb_2_active_in_state_2_out_data : bb_2_active_in_state_2_out_data;
		andOp_6_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_60_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	always @(*) begin
		andOp_61_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_61_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_62_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_65_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_66_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	always @(*) begin
		andOp_67_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_67_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	always @(*) begin
		andOp_68_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_68_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	always @(*) begin
		andOp_69_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
		andOp_69_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_7.andOp_7_in0
	// controller for andOp_7.andOp_7_in1
	// Insensitive connections
	always @(*) begin
		andOp_7_in0 = valid ? andOp_6_out : andOp_6_out;
		andOp_7_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	always @(*) begin
		andOp_70_in0 = valid ? bb_1_active_in_state_2_out_data : bb_1_active_in_state_2_out_data;
		andOp_70_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	always @(*) begin
		andOp_71_in0 = valid ? bb_2_active_in_state_0_out_data : bb_2_active_in_state_0_out_data;
		andOp_71_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_72.andOp_72_in0
	// controller for andOp_72.andOp_72_in1
	// Insensitive connections
	always @(*) begin
		andOp_72_in0 = valid ? bb_2_active_in_state_1_out_data : bb_2_active_in_state_1_out_data;
		andOp_72_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	always @(*) begin
		andOp_73_in0 = valid ? bb_1_active_in_state_2_out_data : bb_1_active_in_state_2_out_data;
		andOp_73_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	always @(*) begin
		andOp_75_in0 = valid ? notOp_74_out : notOp_74_out;
		andOp_75_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	always @(*) begin
		andOp_77_in0 = valid ? notOp_76_out : notOp_76_out;
		andOp_77_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	always @(*) begin
		andOp_79_in0 = valid ? notOp_78_out : notOp_78_out;
		andOp_79_in1 = valid ? andOp_77_out : andOp_77_out;
	end
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	always @(*) begin
		andOp_81_in0 = valid ? notOp_80_out : notOp_80_out;
		andOp_81_in1 = valid ? andOp_79_out : andOp_79_out;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? 1'd0 : 1'd0;
		andOp_83_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? andOp_83_out : andOp_83_out;
		andOp_85_in1 = valid ? eq_84_out : eq_84_out;
	end
	// controller for andOp_87.andOp_87_in0
	// controller for andOp_87.andOp_87_in1
	// Insensitive connections
	always @(*) begin
		andOp_87_in0 = valid ? andOp_83_out : andOp_83_out;
		andOp_87_in1 = valid ? notOp_86_out : notOp_86_out;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? state_0_is_active : state_0_is_active;
		andOp_89_in1 = valid ? notOp_88_out : notOp_88_out;
	end
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	always @(*) begin
		andOp_9_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_9_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_91.andOp_91_in0
	// controller for andOp_91.andOp_91_in1
	// Insensitive connections
	always @(*) begin
		andOp_91_in0 = valid ? state_0_is_active : state_0_is_active;
		andOp_91_in1 = valid ? notOp_90_out : notOp_90_out;
	end
	// controller for andOp_94.andOp_94_in0
	// controller for andOp_94.andOp_94_in1
	// Insensitive connections
	always @(*) begin
		andOp_94_in0 = valid ? 1'd0 : 1'd0;
		andOp_94_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_96.andOp_96_in0
	// controller for andOp_96.andOp_96_in1
	// Insensitive connections
	always @(*) begin
		andOp_96_in0 = valid ? andOp_94_out : andOp_94_out;
		andOp_96_in1 = valid ? eq_95_out : eq_95_out;
	end
	// controller for andOp_98.andOp_98_in0
	// controller for andOp_98.andOp_98_in1
	// Insensitive connections
	always @(*) begin
		andOp_98_in0 = valid ? andOp_94_out : andOp_94_out;
		andOp_98_in1 = valid ? notOp_97_out : notOp_97_out;
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_29_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_41_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_2.bb_1_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_2_in_data = orOp_36_out;
		end else begin
			bb_1_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_2.bb_1_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_51_out) begin 
			bb_1_predecessor_in_state_2_in_data = 32'd3;
		end else if (eq_49_out) begin 
			bb_1_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_0.bb_2_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_0_in_data = orOp_28_out;
		end else begin
			bb_2_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_1.bb_2_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_1_in_data = eq_30_out;
		end else begin
			bb_2_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_2.bb_2_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_2_in_data = eq_37_out;
		end else begin
			bb_2_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_0.bb_2_predecessor_in_state_0_in_data
	always @(*) begin
		if (andOp_40_out) begin 
			bb_2_predecessor_in_state_0_in_data = 32'd0;
		end else if (eq_38_out) begin 
			bb_2_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_1.bb_2_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_42_out) begin 
			bb_2_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_2.bb_2_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_52_out) begin 
			bb_2_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_2.bb_3_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_2_in_data = orOp_34_out;
		end else begin
			bb_3_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_2.bb_3_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_48_out) begin 
			bb_3_predecessor_in_state_2_in_data = 32'd4;
		end else if (eq_46_out) begin 
			bb_3_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_2.bb_4_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_2_in_data = orOp_32_out;
		end else begin
			bb_4_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_2.bb_4_predecessor_in_state_2_in_data
	always @(*) begin
		if (andOp_45_out) begin 
			bb_4_predecessor_in_state_2_in_data = 32'd2;
		end else if (eq_43_out) begin 
			bb_4_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_10_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_11_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_2_happened_in_state_0.br_2_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_7_out) begin 
			br_2_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_8_out) begin 
			br_2_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_2_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_2_happened_in_state_1.br_2_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_13_out) begin 
			br_2_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_14_out) begin 
			br_2_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_2_happened_in_state_1_in_data = 0;
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
		if (andOp_22_out) begin 
			br_3_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_23_out) begin 
			br_3_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_2.br_4_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_16_out) begin 
			br_4_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_17_out) begin 
			br_4_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_2_in_data = 0;
		end
	end
	// controller for concat_63.concat_63_in0
	// controller for concat_63.concat_63_in1
	// Insensitive connections
	always @(*) begin
		concat_63_in0 = valid ? data_in_2_5_out_data : data_in_2_5_out_data;
		concat_63_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_64.concat_64_in0
	// controller for concat_64.concat_64_in1
	// Insensitive connections
	always @(*) begin
		concat_64_in0 = valid ? 32'd4 : 32'd4;
		concat_64_in1 = valid ? 32'd2 : 32'd2;
	end
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_82_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_3.data_in_1_3_in_data
	always @(*) begin
		if (eq_92_out) begin 
			data_in_1_3_in_data = data_store_0_0;
		end else if (eq_93_out) begin 
			data_in_1_3_in_data = data_store_1_2;
		end else begin
			data_in_1_3_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_103_out) begin 
			data_in_2_5_in_data = data_store_1_2;
		end else if (eq_104_out) begin 
			data_in_2_5_in_data = data_store_2_4;
		end else begin
			data_in_2_5_in_data = 0;
		end
	end
	// controller for eq_103.eq_103_in0
	// controller for eq_103.eq_103_in1
	// Insensitive connections
	always @(*) begin
		eq_103_in0 = valid ? 32'd1 : 32'd1;
		eq_103_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	always @(*) begin
		eq_104_in0 = valid ? 32'd2 : 32'd2;
		eq_104_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_106.eq_106_in0
	// controller for eq_106.eq_106_in1
	// Insensitive connections
	always @(*) begin
		eq_106_in0 = valid ? 32'd2 : 32'd2;
		eq_106_in1 = valid ? 32'd2 : 32'd2;
	end
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	always @(*) begin
		eq_27_in0 = valid ? 32'd2 : 32'd2;
		eq_27_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	always @(*) begin
		eq_29_in0 = valid ? 32'd0 : 32'd0;
		eq_29_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd2 : 32'd2;
		eq_30_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	always @(*) begin
		eq_31_in0 = valid ? 32'd4 : 32'd4;
		eq_31_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	always @(*) begin
		eq_33_in0 = valid ? 32'd3 : 32'd3;
		eq_33_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_35.eq_35_in0
	// controller for eq_35.eq_35_in1
	// Insensitive connections
	always @(*) begin
		eq_35_in0 = valid ? 32'd1 : 32'd1;
		eq_35_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	always @(*) begin
		eq_37_in0 = valid ? 32'd2 : 32'd2;
		eq_37_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd2 : 32'd2;
		eq_38_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_41.eq_41_in0
	// controller for eq_41.eq_41_in1
	// Insensitive connections
	always @(*) begin
		eq_41_in0 = valid ? 32'd0 : 32'd0;
		eq_41_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_42.eq_42_in0
	// controller for eq_42.eq_42_in1
	// Insensitive connections
	always @(*) begin
		eq_42_in0 = valid ? 32'd2 : 32'd2;
		eq_42_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	always @(*) begin
		eq_43_in0 = valid ? 32'd4 : 32'd4;
		eq_43_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	always @(*) begin
		eq_46_in0 = valid ? 32'd3 : 32'd3;
		eq_46_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_49.eq_49_in0
	// controller for eq_49.eq_49_in1
	// Insensitive connections
	always @(*) begin
		eq_49_in0 = valid ? 32'd1 : 32'd1;
		eq_49_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_52.eq_52_in0
	// controller for eq_52.eq_52_in1
	// Insensitive connections
	always @(*) begin
		eq_52_in0 = valid ? 32'd2 : 32'd2;
		eq_52_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_82.eq_82_in0
	// controller for eq_82.eq_82_in1
	// Insensitive connections
	always @(*) begin
		eq_82_in0 = valid ? 32'd0 : 32'd0;
		eq_82_in1 = valid ? state_0_last_state : state_0_last_state;
	end
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	always @(*) begin
		eq_84_in0 = valid ? 32'd2 : 32'd2;
		eq_84_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for eq_92.eq_92_in0
	// controller for eq_92.eq_92_in1
	// Insensitive connections
	always @(*) begin
		eq_92_in0 = valid ? 32'd0 : 32'd0;
		eq_92_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_93.eq_93_in0
	// controller for eq_93.eq_93_in1
	// Insensitive connections
	always @(*) begin
		eq_93_in0 = valid ? 32'd1 : 32'd1;
		eq_93_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_95.eq_95_in0
	// controller for eq_95.eq_95_in1
	// Insensitive connections
	always @(*) begin
		eq_95_in0 = valid ? 32'd2 : 32'd2;
		eq_95_in1 = valid ? 32'd1 : 32'd1;
	end
	// controller for icmp_11.cmp_in0_icmp_11
	// controller for icmp_11.cmp_in1_icmp_11
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_11 = valid ? add_out_add_14 : add_out_add_14;
		cmp_in1_icmp_11 = valid ? 32'd8533 : 32'd8533;
	end
	// controller for m.m_rst_n
	always @(*) begin
		if (andOp_53_out) begin 
			m_rst_n = -(1'd1);
		end else if (andOp_55_out) begin 
			m_rst_n = 1'd0;
		end else if (andOp_58_out) begin 
			m_rst_n = -(1'd1);
		end else begin
			m_rst_n = 0;
		end
	end
	// controller for m.m_word0
	always @(*) begin
		if (andOp_56_out) begin 
			m_word0 = in0_out_data;
		end else begin
			m_word0 = 0;
		end
	end
	// controller for m.m_word1
	always @(*) begin
		if (andOp_57_out) begin 
			m_word1 = in1_out_data;
		end else begin
			m_word1 = 0;
		end
	end
	// controller for m.m_word2
	always @(*) begin
		if (andOp_59_out) begin 
			m_word2 = in2_out_data;
		end else begin
			m_word2 = 0;
		end
	end
	// controller for notOp_101.notOp_101_in0
	// Insensitive connections
	always @(*) begin
		notOp_101_in0 = valid ? andOp_96_out : andOp_96_out;
	end
	// controller for notOp_108.notOp_108_in0
	// Insensitive connections
	always @(*) begin
		notOp_108_in0 = valid ? eq_106_out : eq_106_out;
	end
	// controller for notOp_11.notOp_11_in0
	// Insensitive connections
	always @(*) begin
		notOp_11_in0 = valid ? andOp_10_out : andOp_10_out;
	end
	// controller for notOp_110.notOp_110_in0
	// Insensitive connections
	always @(*) begin
		notOp_110_in0 = valid ? bb_4_active_in_state_2_out_data : bb_4_active_in_state_2_out_data;
	end
	// controller for notOp_112.notOp_112_in0
	// Insensitive connections
	always @(*) begin
		notOp_112_in0 = valid ? andOp_107_out : andOp_107_out;
	end
	// controller for notOp_14.notOp_14_in0
	// Insensitive connections
	always @(*) begin
		notOp_14_in0 = valid ? andOp_13_out : andOp_13_out;
	end
	// controller for notOp_17.notOp_17_in0
	// Insensitive connections
	always @(*) begin
		notOp_17_in0 = valid ? andOp_16_out : andOp_16_out;
	end
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	always @(*) begin
		notOp_19_in0 = valid ? cmp_out_icmp_11 : cmp_out_icmp_11;
	end
	// controller for notOp_23.notOp_23_in0
	// Insensitive connections
	always @(*) begin
		notOp_23_in0 = valid ? andOp_22_out : andOp_22_out;
	end
	// controller for notOp_26.notOp_26_in0
	// Insensitive connections
	always @(*) begin
		notOp_26_in0 = valid ? andOp_25_out : andOp_25_out;
	end
	// controller for notOp_39.notOp_39_in0
	// Insensitive connections
	always @(*) begin
		notOp_39_in0 = valid ? eq_38_out : eq_38_out;
	end
	// controller for notOp_44.notOp_44_in0
	// Insensitive connections
	always @(*) begin
		notOp_44_in0 = valid ? eq_43_out : eq_43_out;
	end
	// controller for notOp_47.notOp_47_in0
	// Insensitive connections
	always @(*) begin
		notOp_47_in0 = valid ? eq_46_out : eq_46_out;
	end
	// controller for notOp_50.notOp_50_in0
	// Insensitive connections
	always @(*) begin
		notOp_50_in0 = valid ? eq_49_out : eq_49_out;
	end
	// controller for notOp_74.notOp_74_in0
	// Insensitive connections
	always @(*) begin
		notOp_74_in0 = valid ? andOp_71_out : andOp_71_out;
	end
	// controller for notOp_76.notOp_76_in0
	// Insensitive connections
	always @(*) begin
		notOp_76_in0 = valid ? andOp_18_out : andOp_18_out;
	end
	// controller for notOp_78.notOp_78_in0
	// Insensitive connections
	always @(*) begin
		notOp_78_in0 = valid ? andOp_72_out : andOp_72_out;
	end
	// controller for notOp_8.notOp_8_in0
	// Insensitive connections
	always @(*) begin
		notOp_8_in0 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for notOp_80.notOp_80_in0
	// Insensitive connections
	always @(*) begin
		notOp_80_in0 = valid ? andOp_73_out : andOp_73_out;
	end
	// controller for notOp_86.notOp_86_in0
	// Insensitive connections
	always @(*) begin
		notOp_86_in0 = valid ? eq_84_out : eq_84_out;
	end
	// controller for notOp_88.notOp_88_in0
	// Insensitive connections
	always @(*) begin
		notOp_88_in0 = valid ? 1'd0 : 1'd0;
	end
	// controller for notOp_90.notOp_90_in0
	// Insensitive connections
	always @(*) begin
		notOp_90_in0 = valid ? andOp_85_out : andOp_85_out;
	end
	// controller for notOp_97.notOp_97_in0
	// Insensitive connections
	always @(*) begin
		notOp_97_in0 = valid ? eq_95_out : eq_95_out;
	end
	// controller for notOp_99.notOp_99_in0
	// Insensitive connections
	always @(*) begin
		notOp_99_in0 = valid ? 1'd0 : 1'd0;
	end
	// controller for orOp_28.orOp_28_in0
	// controller for orOp_28.orOp_28_in1
	// Insensitive connections
	always @(*) begin
		orOp_28_in0 = valid ? eq_27_out : eq_27_out;
		orOp_28_in1 = valid ? andOp_10_out : andOp_10_out;
	end
	// controller for orOp_32.orOp_32_in0
	// controller for orOp_32.orOp_32_in1
	// Insensitive connections
	always @(*) begin
		orOp_32_in0 = valid ? eq_31_out : eq_31_out;
		orOp_32_in1 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for orOp_34.orOp_34_in0
	// controller for orOp_34.orOp_34_in1
	// Insensitive connections
	always @(*) begin
		orOp_34_in0 = valid ? eq_33_out : eq_33_out;
		orOp_34_in1 = valid ? andOp_20_out : andOp_20_out;
	end
	// controller for orOp_36.orOp_36_in0
	// controller for orOp_36.orOp_36_in1
	// Insensitive connections
	always @(*) begin
		orOp_36_in0 = valid ? eq_35_out : eq_35_out;
		orOp_36_in1 = valid ? andOp_22_out : andOp_22_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_69_out) begin 
			out_in_data_reg = m_median_word;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for phi_5.phi_in_phi_5
	// controller for phi_5.phi_last_block_phi_5
	// controller for phi_5.phi_s_phi_5
	// Insensitive connections
	always @(*) begin
		phi_in_phi_5 = valid ? concat_63_out : concat_63_out;
		phi_last_block_phi_5 = valid ? bb_4_predecessor_in_state_2_out_data : bb_4_predecessor_in_state_2_out_data;
		phi_s_phi_5 = valid ? concat_64_out : concat_64_out;
	end
	// controller for ret_19.valid_reg
	always @(*) begin
		if (andOp_70_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			data_store_0_0 <= 0;
		end else begin
			if (andOp_85_out) begin
				data_store_0_0 <= add_out_add_14;
			end
			if (andOp_91_out) begin
				data_store_0_0 <= data_in_0_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_2 <= 0;
		end else begin
			if (andOp_102_out) begin
				data_store_1_2 <= data_in_1_3_out_data;
			end
			if (andOp_96_out) begin
				data_store_1_2 <= add_out_add_14;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_4 <= 0;
		end else begin
			if (andOp_107_out) begin
				data_store_2_4 <= add_out_add_14;
			end
			if (andOp_113_out) begin
				data_store_2_4 <= data_in_2_5_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_18_out) begin
				global_state <= 32'd2;
			end
			if (andOp_71_out) begin
				global_state <= 32'd1;
			end
			if (andOp_72_out) begin
				global_state <= 32'd2;
			end
			if (andOp_73_out) begin
				global_state <= 32'd2;
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
			if (andOp_71_out) begin
				state_1_entry_BB_reg <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_71_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_75_out) begin
				state_1_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_71_out) begin
				state_1_last_BB_reg <= bb_2_predecessor_in_state_0_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_71_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_18_out) begin
				state_2_entry_BB_reg <= 32'd4;
			end
			if (andOp_72_out) begin
				state_2_entry_BB_reg <= 32'd2;
			end
			if (andOp_73_out) begin
				state_2_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_18_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_72_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_73_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_81_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_18_out) begin
				state_2_last_BB_reg <= 32'd4;
			end
			if (andOp_72_out) begin
				state_2_last_BB_reg <= bb_2_predecessor_in_state_1_out_data;
			end
			if (andOp_73_out) begin
				state_2_last_BB_reg <= bb_1_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_18_out) begin
				state_2_last_state <= 32'd2;
			end
			if (andOp_72_out) begin
				state_2_last_state <= 32'd1;
			end
			if (andOp_73_out) begin
				state_2_last_state <= 32'd2;
			end
		end
	end

endmodule

