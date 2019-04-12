module median_filter(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [31:0] in2_in_data, input [31:0] in2_out_data, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data, output [31:0] out_in_data, input [31:0] out_out_data);

	reg [0:0] valid_reg;
	reg [31:0] in2_in_data_reg;
	reg [31:0] in0_in_data_reg;
	reg [31:0] in1_in_data_reg;
	reg [31:0] out_in_data_reg;

	assign valid = valid_reg;
	assign in2_in_data = in2_in_data_reg;
	assign in0_in_data = in0_in_data_reg;
	assign in1_in_data = in1_in_data_reg;
	assign out_in_data = out_in_data_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [0:0] m_rst_n;
	reg [31:0] m_word0;
	reg [31:0] m_word1;
	reg [31:0] m_word2;
	wire [31:0] m_median_word;
	median m(.clk(clk), .median_word(m_median_word), .rst_n(m_rst_n), .word0(m_word0), .word1(m_word1), .word2(m_word2));

	br_dummy br_unit();

	reg [63:0] phi_in_phi_7;
	reg [31:0] phi_last_block_phi_7;
	reg [63:0] phi_s_phi_7;
	wire [31:0] phi_out_phi_7;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_7(.in(phi_in_phi_7), .last_block(phi_last_block_phi_7), .out(phi_out_phi_7), .s(phi_s_phi_7));

	reg [31:0] add_in0_add_9;
	reg [31:0] add_in1_add_9;
	wire [31:0] add_out_add_9;
	add #(.WIDTH(32)) add_add_9(.in0(add_in0_add_9), .in1(add_in1_add_9), .out(add_out_add_9));

	reg [31:0] cmp_in0_icmp_14;
	reg [31:0] cmp_in1_icmp_14;
	wire [0:0] cmp_out_icmp_14;
	ne #(.WIDTH(32)) icmp_14(.in0(cmp_in0_icmp_14), .in1(cmp_in1_icmp_14), .out(cmp_out_icmp_14));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [31:0] eq_1_in0;
	reg [31:0] eq_1_in1;
	wire [0:0] eq_1_out;
	eq #(.WIDTH(32)) eq_1(.in0(eq_1_in0), .in1(eq_1_in1), .out(eq_1_out));

	reg [0:0] notOp_2_in0;
	wire [0:0] notOp_2_out;
	notOp #(.WIDTH(1)) notOp_2(.in(notOp_2_in0), .out(notOp_2_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_4_in0;
	reg [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	reg [0:0] br_2_happened_in_data;
	wire [0:0] br_2_happened_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened(.in_data(br_2_happened_in_data), .out_data(br_2_happened_out_data));

	reg [31:0] eq_5_in0;
	reg [31:0] eq_5_in1;
	wire [0:0] eq_5_out;
	eq #(.WIDTH(32)) eq_5(.in0(eq_5_in0), .in1(eq_5_in1), .out(eq_5_out));

	reg [0:0] notOp_6_in0;
	wire [0:0] notOp_6_out;
	notOp #(.WIDTH(1)) notOp_6(.in(notOp_6_in0), .out(notOp_6_out));

	reg [0:0] bb_3_active_in_data;
	wire [0:0] bb_3_active_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active(.in_data(bb_3_active_in_data), .out_data(bb_3_active_out_data));

	reg [31:0] eq_7_in0;
	reg [31:0] eq_7_in1;
	wire [0:0] eq_7_out;
	eq #(.WIDTH(32)) eq_7(.in0(eq_7_in0), .in1(eq_7_in1), .out(eq_7_out));

	reg [0:0] br_3_happened_in_data;
	wire [0:0] br_3_happened_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened(.in_data(br_3_happened_in_data), .out_data(br_3_happened_out_data));

	reg [31:0] eq_8_in0;
	reg [31:0] eq_8_in1;
	wire [0:0] eq_8_out;
	eq #(.WIDTH(32)) eq_8(.in0(eq_8_in0), .in1(eq_8_in1), .out(eq_8_out));

	reg [0:0] notOp_9_in0;
	wire [0:0] notOp_9_out;
	notOp #(.WIDTH(1)) notOp_9(.in(notOp_9_in0), .out(notOp_9_out));

	reg [0:0] bb_4_active_in_data;
	wire [0:0] bb_4_active_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active(.in_data(bb_4_active_in_data), .out_data(bb_4_active_out_data));

	reg [31:0] eq_10_in0;
	reg [31:0] eq_10_in1;
	wire [0:0] eq_10_out;
	eq #(.WIDTH(32)) eq_10(.in0(eq_10_in0), .in1(eq_10_in1), .out(eq_10_out));

	reg [0:0] br_4_happened_in_data;
	wire [0:0] br_4_happened_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened(.in_data(br_4_happened_in_data), .out_data(br_4_happened_out_data));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [0:0] notOp_12_in0;
	wire [0:0] notOp_12_out;
	notOp #(.WIDTH(1)) notOp_12(.in(notOp_12_in0), .out(notOp_12_out));

	reg [0:0] andOp_13_in0;
	reg [0:0] andOp_13_in1;
	wire [0:0] andOp_13_out;
	andOp #(.WIDTH(1)) andOp_13(.in0(andOp_13_in0), .in1(andOp_13_in1), .out(andOp_13_out));

	reg [0:0] notOp_14_in0;
	wire [0:0] notOp_14_out;
	notOp #(.WIDTH(1)) notOp_14(.in(notOp_14_in0), .out(notOp_14_out));

	reg [0:0] andOp_15_in0;
	reg [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [31:0] eq_16_in0;
	reg [31:0] eq_16_in1;
	wire [0:0] eq_16_out;
	eq #(.WIDTH(32)) eq_16(.in0(eq_16_in0), .in1(eq_16_in1), .out(eq_16_out));

	reg [31:0] andOp_17_in0;
	reg [31:0] andOp_17_in1;
	wire [31:0] andOp_17_out;
	andOp #(.WIDTH(32)) andOp_17(.in0(andOp_17_in0), .in1(andOp_17_in1), .out(andOp_17_out));

	reg [31:0] eq_18_in0;
	reg [31:0] eq_18_in1;
	wire [0:0] eq_18_out;
	eq #(.WIDTH(32)) eq_18(.in0(eq_18_in0), .in1(eq_18_in1), .out(eq_18_out));

	reg [31:0] andOp_19_in0;
	reg [31:0] andOp_19_in1;
	wire [31:0] andOp_19_out;
	andOp #(.WIDTH(32)) andOp_19(.in0(andOp_19_in0), .in1(andOp_19_in1), .out(andOp_19_out));

	reg [31:0] eq_20_in0;
	reg [31:0] eq_20_in1;
	wire [0:0] eq_20_out;
	eq #(.WIDTH(32)) eq_20(.in0(eq_20_in0), .in1(eq_20_in1), .out(eq_20_out));

	reg [31:0] andOp_21_in0;
	reg [31:0] andOp_21_in1;
	wire [31:0] andOp_21_out;
	andOp #(.WIDTH(32)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [31:0] eq_22_in0;
	reg [31:0] eq_22_in1;
	wire [0:0] eq_22_out;
	eq #(.WIDTH(32)) eq_22(.in0(eq_22_in0), .in1(eq_22_in1), .out(eq_22_out));

	reg [31:0] andOp_23_in0;
	reg [31:0] andOp_23_in1;
	wire [31:0] andOp_23_out;
	andOp #(.WIDTH(32)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	reg [31:0] eq_24_in0;
	reg [31:0] eq_24_in1;
	wire [0:0] eq_24_out;
	eq #(.WIDTH(32)) eq_24(.in0(eq_24_in0), .in1(eq_24_in1), .out(eq_24_out));

	reg [31:0] andOp_25_in0;
	reg [31:0] andOp_25_in1;
	wire [31:0] andOp_25_out;
	andOp #(.WIDTH(32)) andOp_25(.in0(andOp_25_in0), .in1(andOp_25_in1), .out(andOp_25_out));

	reg [31:0] eq_26_in0;
	reg [31:0] eq_26_in1;
	wire [0:0] eq_26_out;
	eq #(.WIDTH(32)) eq_26(.in0(eq_26_in0), .in1(eq_26_in1), .out(eq_26_out));

	reg [31:0] andOp_27_in0;
	reg [31:0] andOp_27_in1;
	wire [31:0] andOp_27_out;
	andOp #(.WIDTH(32)) andOp_27(.in0(andOp_27_in0), .in1(andOp_27_in1), .out(andOp_27_out));

	reg [31:0] eq_28_in0;
	reg [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

	reg [31:0] andOp_29_in0;
	reg [31:0] andOp_29_in1;
	wire [31:0] andOp_29_out;
	andOp #(.WIDTH(32)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	reg [31:0] eq_30_in0;
	reg [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	reg [31:0] andOp_31_in0;
	reg [31:0] andOp_31_in1;
	wire [31:0] andOp_31_out;
	andOp #(.WIDTH(32)) andOp_31(.in0(andOp_31_in0), .in1(andOp_31_in1), .out(andOp_31_out));

	reg [31:0] eq_32_in0;
	reg [31:0] eq_32_in1;
	wire [0:0] eq_32_out;
	eq #(.WIDTH(32)) eq_32(.in0(eq_32_in0), .in1(eq_32_in1), .out(eq_32_out));

	reg [31:0] andOp_33_in0;
	reg [31:0] andOp_33_in1;
	wire [31:0] andOp_33_out;
	andOp #(.WIDTH(32)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [31:0] eq_34_in0;
	reg [31:0] eq_34_in1;
	wire [0:0] eq_34_out;
	eq #(.WIDTH(32)) eq_34(.in0(eq_34_in0), .in1(eq_34_in1), .out(eq_34_out));

	reg [31:0] andOp_35_in0;
	reg [31:0] andOp_35_in1;
	wire [31:0] andOp_35_out;
	andOp #(.WIDTH(32)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	reg [31:0] eq_36_in0;
	reg [31:0] eq_36_in1;
	wire [0:0] eq_36_out;
	eq #(.WIDTH(32)) eq_36(.in0(eq_36_in0), .in1(eq_36_in1), .out(eq_36_out));

	reg [31:0] andOp_37_in0;
	reg [31:0] andOp_37_in1;
	wire [31:0] andOp_37_out;
	andOp #(.WIDTH(32)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	reg [31:0] eq_38_in0;
	reg [31:0] eq_38_in1;
	wire [0:0] eq_38_out;
	eq #(.WIDTH(32)) eq_38(.in0(eq_38_in0), .in1(eq_38_in1), .out(eq_38_out));

	reg [31:0] andOp_39_in0;
	reg [31:0] andOp_39_in1;
	wire [31:0] andOp_39_out;
	andOp #(.WIDTH(32)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	reg [31:0] eq_40_in0;
	reg [31:0] eq_40_in1;
	wire [0:0] eq_40_out;
	eq #(.WIDTH(32)) eq_40(.in0(eq_40_in0), .in1(eq_40_in1), .out(eq_40_out));

	reg [31:0] andOp_41_in0;
	reg [31:0] andOp_41_in1;
	wire [31:0] andOp_41_out;
	andOp #(.WIDTH(32)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	reg [31:0] eq_42_in0;
	reg [31:0] eq_42_in1;
	wire [0:0] eq_42_out;
	eq #(.WIDTH(32)) eq_42(.in0(eq_42_in0), .in1(eq_42_in1), .out(eq_42_out));

	reg [31:0] andOp_43_in0;
	reg [31:0] andOp_43_in1;
	wire [31:0] andOp_43_out;
	andOp #(.WIDTH(32)) andOp_43(.in0(andOp_43_in0), .in1(andOp_43_in1), .out(andOp_43_out));

	reg [31:0] eq_44_in0;
	reg [31:0] eq_44_in1;
	wire [0:0] eq_44_out;
	eq #(.WIDTH(32)) eq_44(.in0(eq_44_in0), .in1(eq_44_in1), .out(eq_44_out));

	reg [31:0] andOp_45_in0;
	reg [31:0] andOp_45_in1;
	wire [31:0] andOp_45_out;
	andOp #(.WIDTH(32)) andOp_45(.in0(andOp_45_in0), .in1(andOp_45_in1), .out(andOp_45_out));

	reg [31:0] eq_46_in0;
	reg [31:0] eq_46_in1;
	wire [0:0] eq_46_out;
	eq #(.WIDTH(32)) eq_46(.in0(eq_46_in0), .in1(eq_46_in1), .out(eq_46_out));

	reg [31:0] eq_47_in0;
	reg [31:0] eq_47_in1;
	wire [0:0] eq_47_out;
	eq #(.WIDTH(32)) eq_47(.in0(eq_47_in0), .in1(eq_47_in1), .out(eq_47_out));

	reg [31:0] eq_48_in0;
	reg [31:0] eq_48_in1;
	wire [0:0] eq_48_out;
	eq #(.WIDTH(32)) eq_48(.in0(eq_48_in0), .in1(eq_48_in1), .out(eq_48_out));

	reg [31:0] eq_49_in0;
	reg [31:0] eq_49_in1;
	wire [0:0] eq_49_out;
	eq #(.WIDTH(32)) eq_49(.in0(eq_49_in0), .in1(eq_49_in1), .out(eq_49_out));

	reg [31:0] eq_50_in0;
	reg [31:0] eq_50_in1;
	wire [0:0] eq_50_out;
	eq #(.WIDTH(32)) eq_50(.in0(eq_50_in0), .in1(eq_50_in1), .out(eq_50_out));

	reg [31:0] eq_51_in0;
	reg [31:0] eq_51_in1;
	wire [0:0] eq_51_out;
	eq #(.WIDTH(32)) eq_51(.in0(eq_51_in0), .in1(eq_51_in1), .out(eq_51_out));

	reg [31:0] andOp_52_in0;
	reg [31:0] andOp_52_in1;
	wire [31:0] andOp_52_out;
	andOp #(.WIDTH(32)) andOp_52(.in0(andOp_52_in0), .in1(andOp_52_in1), .out(andOp_52_out));

	reg [31:0] eq_53_in0;
	reg [31:0] eq_53_in1;
	wire [0:0] eq_53_out;
	eq #(.WIDTH(32)) eq_53(.in0(eq_53_in0), .in1(eq_53_in1), .out(eq_53_out));

	reg [31:0] andOp_54_in0;
	reg [31:0] andOp_54_in1;
	wire [31:0] andOp_54_out;
	andOp #(.WIDTH(32)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	reg [31:0] eq_55_in0;
	reg [31:0] eq_55_in1;
	wire [0:0] eq_55_out;
	eq #(.WIDTH(32)) eq_55(.in0(eq_55_in0), .in1(eq_55_in1), .out(eq_55_out));

	reg [31:0] andOp_56_in0;
	reg [31:0] andOp_56_in1;
	wire [31:0] andOp_56_out;
	andOp #(.WIDTH(32)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

	reg [31:0] eq_57_in0;
	reg [31:0] eq_57_in1;
	wire [0:0] eq_57_out;
	eq #(.WIDTH(32)) eq_57(.in0(eq_57_in0), .in1(eq_57_in1), .out(eq_57_out));

	reg [31:0] andOp_58_in0;
	reg [31:0] andOp_58_in1;
	wire [31:0] andOp_58_out;
	andOp #(.WIDTH(32)) andOp_58(.in0(andOp_58_in0), .in1(andOp_58_in1), .out(andOp_58_out));

	reg [31:0] eq_59_in0;
	reg [31:0] eq_59_in1;
	wire [0:0] eq_59_out;
	eq #(.WIDTH(32)) eq_59(.in0(eq_59_in0), .in1(eq_59_in1), .out(eq_59_out));

	reg [31:0] andOp_60_in0;
	reg [31:0] andOp_60_in1;
	wire [31:0] andOp_60_out;
	andOp #(.WIDTH(32)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	reg [31:0] andOp_61_in0;
	reg [31:0] andOp_61_in1;
	wire [31:0] andOp_61_out;
	andOp #(.WIDTH(32)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

	reg [31:0] eq_62_in0;
	reg [31:0] eq_62_in1;
	wire [0:0] eq_62_out;
	eq #(.WIDTH(32)) eq_62(.in0(eq_62_in0), .in1(eq_62_in1), .out(eq_62_out));

	reg [31:0] andOp_63_in0;
	reg [31:0] andOp_63_in1;
	wire [31:0] andOp_63_out;
	andOp #(.WIDTH(32)) andOp_63(.in0(andOp_63_in0), .in1(andOp_63_in1), .out(andOp_63_out));

	reg [31:0] eq_64_in0;
	reg [31:0] eq_64_in1;
	wire [0:0] eq_64_out;
	eq #(.WIDTH(32)) eq_64(.in0(eq_64_in0), .in1(eq_64_in1), .out(eq_64_out));

	reg [31:0] andOp_65_in0;
	reg [31:0] andOp_65_in1;
	wire [31:0] andOp_65_out;
	andOp #(.WIDTH(32)) andOp_65(.in0(andOp_65_in0), .in1(andOp_65_in1), .out(andOp_65_out));

	reg [31:0] eq_66_in0;
	reg [31:0] eq_66_in1;
	wire [0:0] eq_66_out;
	eq #(.WIDTH(32)) eq_66(.in0(eq_66_in0), .in1(eq_66_in1), .out(eq_66_out));

	reg [31:0] eq_67_in0;
	reg [31:0] eq_67_in1;
	wire [0:0] eq_67_out;
	eq #(.WIDTH(32)) eq_67(.in0(eq_67_in0), .in1(eq_67_in1), .out(eq_67_out));

	reg [31:0] eq_68_in0;
	reg [31:0] eq_68_in1;
	wire [0:0] eq_68_out;
	eq #(.WIDTH(32)) eq_68(.in0(eq_68_in0), .in1(eq_68_in1), .out(eq_68_out));

	reg [31:0] eq_69_in0;
	reg [31:0] eq_69_in1;
	wire [0:0] eq_69_out;
	eq #(.WIDTH(32)) eq_69(.in0(eq_69_in0), .in1(eq_69_in1), .out(eq_69_out));

	reg [31:0] eq_70_in0;
	reg [31:0] eq_70_in1;
	wire [0:0] eq_70_out;
	eq #(.WIDTH(32)) eq_70(.in0(eq_70_in0), .in1(eq_70_in1), .out(eq_70_out));

	reg [31:0] eq_71_in0;
	reg [31:0] eq_71_in1;
	wire [0:0] eq_71_out;
	eq #(.WIDTH(32)) eq_71(.in0(eq_71_in0), .in1(eq_71_in1), .out(eq_71_out));

	reg [31:0] andOp_72_in0;
	reg [31:0] andOp_72_in1;
	wire [31:0] andOp_72_out;
	andOp #(.WIDTH(32)) andOp_72(.in0(andOp_72_in0), .in1(andOp_72_in1), .out(andOp_72_out));

	reg [31:0] eq_73_in0;
	reg [31:0] eq_73_in1;
	wire [0:0] eq_73_out;
	eq #(.WIDTH(32)) eq_73(.in0(eq_73_in0), .in1(eq_73_in1), .out(eq_73_out));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	// End Functional Units

	reg [31:0] add_tmp_2;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [31:0] last_BB_reg;

	// controller for add_add_9.add_in0_add_9
	// controller for add_add_9.add_in1_add_9
	// Insensitive connections
	always @(*) begin
		add_in0_add_9 = valid ? phi_out_phi_7 : phi_out_phi_7;
		add_in1_add_9 = valid ? (32'd1) : (32'd1);
	end
	// controller for andOp_13.andOp_13_in0
	// controller for andOp_13.andOp_13_in1
	// Insensitive connections
	always @(*) begin
		andOp_13_in0 = valid ? eq_11_out : eq_11_out;
		andOp_13_in1 = valid ? cmp_out_icmp_14 : cmp_out_icmp_14;
	end
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	always @(*) begin
		andOp_15_in0 = valid ? eq_11_out : eq_11_out;
		andOp_15_in1 = valid ? notOp_14_out : notOp_14_out;
	end
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	always @(*) begin
		andOp_17_in0 = valid ? eq_16_out : eq_16_out;
		andOp_17_in1 = valid ? bb_2_active_out_data : bb_2_active_out_data;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? eq_18_out : eq_18_out;
		andOp_19_in1 = valid ? bb_2_active_out_data : bb_2_active_out_data;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? eq_20_out : eq_20_out;
		andOp_21_in1 = valid ? bb_2_active_out_data : bb_2_active_out_data;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? eq_22_out : eq_22_out;
		andOp_23_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? eq_24_out : eq_24_out;
		andOp_25_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? eq_26_out : eq_26_out;
		andOp_27_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? eq_28_out : eq_28_out;
		andOp_29_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	always @(*) begin
		andOp_31_in0 = valid ? eq_30_out : eq_30_out;
		andOp_31_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? eq_32_out : eq_32_out;
		andOp_33_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? eq_34_out : eq_34_out;
		andOp_35_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	always @(*) begin
		andOp_37_in0 = valid ? eq_36_out : eq_36_out;
		andOp_37_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? eq_38_out : eq_38_out;
		andOp_39_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	always @(*) begin
		andOp_41_in0 = valid ? eq_40_out : eq_40_out;
		andOp_41_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	always @(*) begin
		andOp_43_in0 = valid ? eq_42_out : eq_42_out;
		andOp_43_in1 = valid ? bb_4_active_out_data : bb_4_active_out_data;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? eq_44_out : eq_44_out;
		andOp_45_in1 = valid ? bb_1_active_out_data : bb_1_active_out_data;
	end
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	always @(*) begin
		andOp_52_in0 = valid ? eq_51_out : eq_51_out;
		andOp_52_in1 = valid ? 1 : 1;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? eq_53_out : eq_53_out;
		andOp_54_in1 = valid ? 1 : 1;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? eq_55_out : eq_55_out;
		andOp_56_in1 = valid ? 1 : 1;
	end
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	always @(*) begin
		andOp_58_in0 = valid ? eq_57_out : eq_57_out;
		andOp_58_in1 = valid ? 1 : 1;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? eq_59_out : eq_59_out;
		andOp_60_in1 = valid ? (cmp_out_icmp_14) : (cmp_out_icmp_14);
	end
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	always @(*) begin
		andOp_61_in0 = valid ? eq_59_out : eq_59_out;
		andOp_61_in1 = valid ? !(cmp_out_icmp_14) : !(cmp_out_icmp_14);
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? eq_62_out : eq_62_out;
		andOp_63_in1 = valid ? 1 : 1;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? eq_64_out : eq_64_out;
		andOp_65_in1 = valid ? 1 : 1;
	end
	// controller for andOp_72.andOp_72_in0
	// controller for andOp_72.andOp_72_in1
	// Insensitive connections
	always @(*) begin
		andOp_72_in0 = valid ? eq_70_out : eq_70_out;
		andOp_72_in1 = valid ? eq_71_out : eq_71_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_0_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_3_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_4_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for bb_3_active.bb_3_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_data = eq_7_out;
		end else begin
			bb_3_active_in_data = 0;
		end
	end
	// controller for bb_4_active.bb_4_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_data = eq_10_out;
		end else begin
			bb_4_active_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (eq_1_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_2_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_2_happened.br_2_happened_in_data
	always @(*) begin
		if (eq_5_out) begin 
			br_2_happened_in_data = 1'd1;
		end else if (notOp_6_out) begin 
			br_2_happened_in_data = 1'd0;
		end else begin
			br_2_happened_in_data = 0;
		end
	end
	// controller for br_3_happened.br_3_happened_in_data
	always @(*) begin
		if (eq_8_out) begin 
			br_3_happened_in_data = 1'd1;
		end else if (notOp_9_out) begin 
			br_3_happened_in_data = 1'd0;
		end else begin
			br_3_happened_in_data = 0;
		end
	end
	// controller for br_4_happened.br_4_happened_in_data
	always @(*) begin
		if (eq_11_out) begin 
			br_4_happened_in_data = 1'd1;
		end else if (notOp_12_out) begin 
			br_4_happened_in_data = 1'd0;
		end else begin
			br_4_happened_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd0 : 32'd0;
		eq_0_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	always @(*) begin
		eq_1_in0 = valid ? 32'd0 : 32'd0;
		eq_1_in1 = valid ? global_state : global_state;
	end
	// controller for eq_10.eq_10_in0
	// controller for eq_10.eq_10_in1
	// Insensitive connections
	always @(*) begin
		eq_10_in0 = valid ? 32'd4 : 32'd4;
		eq_10_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd4 : 32'd4;
		eq_11_in1 = valid ? global_state : global_state;
	end
	// controller for eq_16.eq_16_in0
	// controller for eq_16.eq_16_in1
	// Insensitive connections
	always @(*) begin
		eq_16_in0 = valid ? 32'd1 : 32'd1;
		eq_16_in1 = valid ? global_state : global_state;
	end
	// controller for eq_18.eq_18_in0
	// controller for eq_18.eq_18_in1
	// Insensitive connections
	always @(*) begin
		eq_18_in0 = valid ? 32'd2 : 32'd2;
		eq_18_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd3 : 32'd3;
		eq_20_in1 = valid ? global_state : global_state;
	end
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	always @(*) begin
		eq_22_in0 = valid ? 32'd4 : 32'd4;
		eq_22_in1 = valid ? global_state : global_state;
	end
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	always @(*) begin
		eq_24_in0 = valid ? 32'd4 : 32'd4;
		eq_24_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd4 : 32'd4;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd4 : 32'd4;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd1 : 32'd1;
		eq_3_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd4 : 32'd4;
		eq_30_in1 = valid ? global_state : global_state;
	end
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	always @(*) begin
		eq_32_in0 = valid ? 32'd4 : 32'd4;
		eq_32_in1 = valid ? global_state : global_state;
	end
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	always @(*) begin
		eq_34_in0 = valid ? 32'd4 : 32'd4;
		eq_34_in1 = valid ? global_state : global_state;
	end
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	always @(*) begin
		eq_36_in0 = valid ? 32'd4 : 32'd4;
		eq_36_in1 = valid ? global_state : global_state;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd4 : 32'd4;
		eq_38_in1 = valid ? global_state : global_state;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd2 : 32'd2;
		eq_4_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_40.eq_40_in0
	// controller for eq_40.eq_40_in1
	// Insensitive connections
	always @(*) begin
		eq_40_in0 = valid ? 32'd4 : 32'd4;
		eq_40_in1 = valid ? global_state : global_state;
	end
	// controller for eq_42.eq_42_in0
	// controller for eq_42.eq_42_in1
	// Insensitive connections
	always @(*) begin
		eq_42_in0 = valid ? 32'd4 : 32'd4;
		eq_42_in1 = valid ? global_state : global_state;
	end
	// controller for eq_44.eq_44_in0
	// controller for eq_44.eq_44_in1
	// Insensitive connections
	always @(*) begin
		eq_44_in0 = valid ? 32'd6 : 32'd6;
		eq_44_in1 = valid ? global_state : global_state;
	end
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	always @(*) begin
		eq_46_in0 = valid ? 32'd0 : 32'd0;
		eq_46_in1 = valid ? global_state : global_state;
	end
	// controller for eq_47.eq_47_in0
	// controller for eq_47.eq_47_in1
	// Insensitive connections
	always @(*) begin
		eq_47_in0 = valid ? 32'd3 : 32'd3;
		eq_47_in1 = valid ? global_state : global_state;
	end
	// controller for eq_48.eq_48_in0
	// controller for eq_48.eq_48_in1
	// Insensitive connections
	always @(*) begin
		eq_48_in0 = valid ? 32'd4 : 32'd4;
		eq_48_in1 = valid ? global_state : global_state;
	end
	// controller for eq_49.eq_49_in0
	// controller for eq_49.eq_49_in1
	// Insensitive connections
	always @(*) begin
		eq_49_in0 = valid ? 32'd5 : 32'd5;
		eq_49_in1 = valid ? global_state : global_state;
	end
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	always @(*) begin
		eq_5_in0 = valid ? 32'd2 : 32'd2;
		eq_5_in1 = valid ? global_state : global_state;
	end
	// controller for eq_50.eq_50_in0
	// controller for eq_50.eq_50_in1
	// Insensitive connections
	always @(*) begin
		eq_50_in0 = valid ? 32'd6 : 32'd6;
		eq_50_in1 = valid ? global_state : global_state;
	end
	// controller for eq_51.eq_51_in0
	// controller for eq_51.eq_51_in1
	// Insensitive connections
	always @(*) begin
		eq_51_in0 = valid ? 32'd0 : 32'd0;
		eq_51_in1 = valid ? global_state : global_state;
	end
	// controller for eq_53.eq_53_in0
	// controller for eq_53.eq_53_in1
	// Insensitive connections
	always @(*) begin
		eq_53_in0 = valid ? 32'd1 : 32'd1;
		eq_53_in1 = valid ? global_state : global_state;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd2 : 32'd2;
		eq_55_in1 = valid ? global_state : global_state;
	end
	// controller for eq_57.eq_57_in0
	// controller for eq_57.eq_57_in1
	// Insensitive connections
	always @(*) begin
		eq_57_in0 = valid ? 32'd3 : 32'd3;
		eq_57_in1 = valid ? global_state : global_state;
	end
	// controller for eq_59.eq_59_in0
	// controller for eq_59.eq_59_in1
	// Insensitive connections
	always @(*) begin
		eq_59_in0 = valid ? 32'd4 : 32'd4;
		eq_59_in1 = valid ? global_state : global_state;
	end
	// controller for eq_62.eq_62_in0
	// controller for eq_62.eq_62_in1
	// Insensitive connections
	always @(*) begin
		eq_62_in0 = valid ? 32'd5 : 32'd5;
		eq_62_in1 = valid ? global_state : global_state;
	end
	// controller for eq_64.eq_64_in0
	// controller for eq_64.eq_64_in1
	// Insensitive connections
	always @(*) begin
		eq_64_in0 = valid ? 32'd6 : 32'd6;
		eq_64_in1 = valid ? global_state : global_state;
	end
	// controller for eq_66.eq_66_in0
	// controller for eq_66.eq_66_in1
	// Insensitive connections
	always @(*) begin
		eq_66_in0 = valid ? 32'd0 : 32'd0;
		eq_66_in1 = valid ? global_state : global_state;
	end
	// controller for eq_67.eq_67_in0
	// controller for eq_67.eq_67_in1
	// Insensitive connections
	always @(*) begin
		eq_67_in0 = valid ? 32'd1 : 32'd1;
		eq_67_in1 = valid ? global_state : global_state;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd2 : 32'd2;
		eq_68_in1 = valid ? global_state : global_state;
	end
	// controller for eq_69.eq_69_in0
	// controller for eq_69.eq_69_in1
	// Insensitive connections
	always @(*) begin
		eq_69_in0 = valid ? 32'd3 : 32'd3;
		eq_69_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd3 : 32'd3;
		eq_7_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd4 : 32'd4;
		eq_70_in1 = valid ? global_state : global_state;
	end
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	always @(*) begin
		eq_71_in0 = valid ? 32'd4 : 32'd4;
		eq_71_in1 = valid ? global_state : global_state;
	end
	// controller for eq_73.eq_73_in0
	// controller for eq_73.eq_73_in1
	// Insensitive connections
	always @(*) begin
		eq_73_in0 = valid ? 32'd5 : 32'd5;
		eq_73_in1 = valid ? global_state : global_state;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd6 : 32'd6;
		eq_74_in1 = valid ? global_state : global_state;
	end
	// controller for eq_8.eq_8_in0
	// controller for eq_8.eq_8_in1
	// Insensitive connections
	always @(*) begin
		eq_8_in0 = valid ? 32'd3 : 32'd3;
		eq_8_in1 = valid ? global_state : global_state;
	end
	// controller for icmp_14.cmp_in0_icmp_14
	// controller for icmp_14.cmp_in1_icmp_14
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_14 = valid ? add_out_add_9 : add_out_add_9;
		cmp_in1_icmp_14 = valid ? (32'd8533) : (32'd8533);
	end
	// controller for m.m_rst_n
	always @(*) begin
		if (andOp_17_out) begin 
			m_rst_n = -(1'd1);
		end else if (andOp_19_out) begin 
			m_rst_n = (1'd0);
		end else if (andOp_21_out) begin 
			m_rst_n = -(1'd1);
		end else begin
			m_rst_n = 0;
		end
	end
	// controller for m.m_word0
	// controller for m.m_word1
	// controller for m.m_word2
	// Insensitive connections
	always @(*) begin
		m_word0 = valid ? in0_out_data : in0_out_data;
		m_word1 = valid ? in1_out_data : in1_out_data;
		m_word2 = valid ? in2_out_data : in2_out_data;
	end
	// controller for notOp_12.notOp_12_in0
	// Insensitive connections
	always @(*) begin
		notOp_12_in0 = valid ? eq_11_out : eq_11_out;
	end
	// controller for notOp_14.notOp_14_in0
	// Insensitive connections
	always @(*) begin
		notOp_14_in0 = valid ? cmp_out_icmp_14 : cmp_out_icmp_14;
	end
	// controller for notOp_2.notOp_2_in0
	// Insensitive connections
	always @(*) begin
		notOp_2_in0 = valid ? eq_1_out : eq_1_out;
	end
	// controller for notOp_6.notOp_6_in0
	// Insensitive connections
	always @(*) begin
		notOp_6_in0 = valid ? eq_5_out : eq_5_out;
	end
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	always @(*) begin
		notOp_9_in0 = valid ? eq_8_out : eq_8_out;
	end
	// controller for out.out_in_data_reg
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? m_median_word : m_median_word;
	end
	// controller for phi_7.phi_in_phi_7
	// controller for phi_7.phi_last_block_phi_7
	// controller for phi_7.phi_s_phi_7
	// Insensitive connections
	always @(*) begin
		phi_in_phi_7 = valid ? {(32'd0), add_tmp_2} : {(32'd0), add_tmp_2};
		phi_last_block_phi_7 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_7 = valid ? {32'd2, 32'd4} : {32'd2, 32'd4};
	end
	// controller for ret_19.valid_reg
	always @(*) begin
		if (andOp_45_out) begin 
			valid_reg = 1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_2 <= 0;
		end else begin
			if (andOp_72_out) begin
				add_tmp_2 <= add_out_add_9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (andOp_13_out) begin
				global_next_block <= 4;
			end
			if (andOp_15_out) begin
				global_next_block <= 3;
			end
			if (br_0_happened_out_data) begin
				global_next_block <= 2;
			end
			if (br_2_happened_out_data) begin
				global_next_block <= 4;
			end
			if (br_3_happened_out_data) begin
				global_next_block <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_52_out) begin
				global_state <= 1;
			end
			if (andOp_54_out) begin
				global_state <= 2;
			end
			if (andOp_56_out) begin
				global_state <= 3;
			end
			if (andOp_58_out) begin
				global_state <= 4;
			end
			if (andOp_60_out) begin
				global_state <= 4;
			end
			if (andOp_61_out) begin
				global_state <= 5;
			end
			if (andOp_63_out) begin
				global_state <= 6;
			end
			if (andOp_65_out) begin
				global_state <= 6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_46_out) begin
				last_BB_reg <= 0;
			end
			if (eq_47_out) begin
				last_BB_reg <= 2;
			end
			if (eq_48_out) begin
				last_BB_reg <= 4;
			end
			if (eq_49_out) begin
				last_BB_reg <= 3;
			end
			if (eq_50_out) begin
				last_BB_reg <= 1;
			end
		end
	end

endmodule

