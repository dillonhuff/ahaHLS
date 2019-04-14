module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [0:0] valid, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready);

	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [0:0] valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;

	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign valid = valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_18();

	add alloca_0();

	add bitcast_1();

	add call_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	br_dummy br_unit();

	add call_19();

	reg [63:0] phi_in_phi_5;
	reg [31:0] phi_last_block_phi_5;
	reg [63:0] phi_s_phi_5;
	wire [31:0] phi_out_phi_5;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_5(.in(phi_in_phi_5), .last_block(phi_last_block_phi_5), .out(phi_out_phi_5), .s(phi_s_phi_5));

	reg [31:0] add_in0_add_12;
	reg [31:0] add_in1_add_12;
	wire [31:0] add_out_add_12;
	add #(.WIDTH(32)) add_add_12(.in0(add_in0_add_12), .in1(add_in1_add_12), .out(add_out_add_12));

	reg [31:0] add_in0_add_7;
	reg [31:0] add_in1_add_7;
	wire [31:0] add_out_add_7;
	add #(.WIDTH(32)) add_add_7(.in0(add_in0_add_7), .in1(add_in1_add_7), .out(add_out_add_7));

	reg [31:0] cmp_in0_icmp_8;
	reg [31:0] cmp_in1_icmp_8;
	wire [0:0] cmp_out_icmp_8;
	eq #(.WIDTH(32)) icmp_8(.in0(cmp_in0_icmp_8), .in1(cmp_in1_icmp_8), .out(cmp_out_icmp_8));

	add call_10();

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [0:0] andOp_1_in0;
	reg [0:0] andOp_1_in1;
	wire [0:0] andOp_1_out;
	andOp #(.WIDTH(1)) andOp_1(.in0(andOp_1_in0), .in1(andOp_1_in1), .out(andOp_1_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [0:0] notOp_2_in0;
	wire [0:0] notOp_2_out;
	notOp #(.WIDTH(1)) notOp_2(.in(notOp_2_in0), .out(notOp_2_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [0:0] andOp_4_in0;
	reg [0:0] andOp_4_in1;
	wire [0:0] andOp_4_out;
	andOp #(.WIDTH(1)) andOp_4(.in0(andOp_4_in0), .in1(andOp_4_in1), .out(andOp_4_out));

	reg [0:0] br_2_happened_in_data;
	wire [0:0] br_2_happened_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened(.in_data(br_2_happened_in_data), .out_data(br_2_happened_out_data));

	reg [0:0] notOp_5_in0;
	wire [0:0] notOp_5_out;
	notOp #(.WIDTH(1)) notOp_5(.in(notOp_5_in0), .out(notOp_5_out));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] notOp_7_in0;
	wire [0:0] notOp_7_out;
	notOp #(.WIDTH(1)) notOp_7(.in(notOp_7_in0), .out(notOp_7_out));

	reg [0:0] andOp_8_in0;
	reg [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	reg [31:0] eq_9_in0;
	reg [31:0] eq_9_in1;
	wire [0:0] eq_9_out;
	eq #(.WIDTH(32)) eq_9(.in0(eq_9_in0), .in1(eq_9_in1), .out(eq_9_out));

	reg [31:0] eq_10_in0;
	reg [31:0] eq_10_in1;
	wire [0:0] eq_10_out;
	eq #(.WIDTH(32)) eq_10(.in0(eq_10_in0), .in1(eq_10_in1), .out(eq_10_out));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [31:0] eq_12_in0;
	reg [31:0] eq_12_in1;
	wire [0:0] eq_12_out;
	eq #(.WIDTH(32)) eq_12(.in0(eq_12_in0), .in1(eq_12_in1), .out(eq_12_out));

	reg [0:0] andOp_13_in0;
	reg [0:0] andOp_13_in1;
	wire [0:0] andOp_13_out;
	andOp #(.WIDTH(1)) andOp_13(.in0(andOp_13_in0), .in1(andOp_13_in1), .out(andOp_13_out));

	reg [31:0] eq_14_in0;
	reg [31:0] eq_14_in1;
	wire [0:0] eq_14_out;
	eq #(.WIDTH(32)) eq_14(.in0(eq_14_in0), .in1(eq_14_in1), .out(eq_14_out));

	reg [0:0] andOp_15_in0;
	reg [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [31:0] eq_16_in0;
	reg [31:0] eq_16_in1;
	wire [0:0] eq_16_out;
	eq #(.WIDTH(32)) eq_16(.in0(eq_16_in0), .in1(eq_16_in1), .out(eq_16_out));

	reg [0:0] andOp_17_in0;
	reg [0:0] andOp_17_in1;
	wire [0:0] andOp_17_out;
	andOp #(.WIDTH(1)) andOp_17(.in0(andOp_17_in0), .in1(andOp_17_in1), .out(andOp_17_out));

	reg [31:0] eq_18_in0;
	reg [31:0] eq_18_in1;
	wire [0:0] eq_18_out;
	eq #(.WIDTH(32)) eq_18(.in0(eq_18_in0), .in1(eq_18_in1), .out(eq_18_out));

	reg [0:0] andOp_19_in0;
	reg [0:0] andOp_19_in1;
	wire [0:0] andOp_19_out;
	andOp #(.WIDTH(1)) andOp_19(.in0(andOp_19_in0), .in1(andOp_19_in1), .out(andOp_19_out));

	reg [31:0] eq_20_in0;
	reg [31:0] eq_20_in1;
	wire [0:0] eq_20_out;
	eq #(.WIDTH(32)) eq_20(.in0(eq_20_in0), .in1(eq_20_in1), .out(eq_20_out));

	reg [0:0] andOp_21_in0;
	reg [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [31:0] eq_22_in0;
	reg [31:0] eq_22_in1;
	wire [0:0] eq_22_out;
	eq #(.WIDTH(32)) eq_22(.in0(eq_22_in0), .in1(eq_22_in1), .out(eq_22_out));

	reg [0:0] andOp_23_in0;
	reg [0:0] andOp_23_in1;
	wire [0:0] andOp_23_out;
	andOp #(.WIDTH(1)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	reg [31:0] eq_24_in0;
	reg [31:0] eq_24_in1;
	wire [0:0] eq_24_out;
	eq #(.WIDTH(32)) eq_24(.in0(eq_24_in0), .in1(eq_24_in1), .out(eq_24_out));

	reg [0:0] andOp_25_in0;
	reg [0:0] andOp_25_in1;
	wire [0:0] andOp_25_out;
	andOp #(.WIDTH(1)) andOp_25(.in0(andOp_25_in0), .in1(andOp_25_in1), .out(andOp_25_out));

	reg [31:0] eq_26_in0;
	reg [31:0] eq_26_in1;
	wire [0:0] eq_26_out;
	eq #(.WIDTH(32)) eq_26(.in0(eq_26_in0), .in1(eq_26_in1), .out(eq_26_out));

	reg [0:0] andOp_27_in0;
	reg [0:0] andOp_27_in1;
	wire [0:0] andOp_27_out;
	andOp #(.WIDTH(1)) andOp_27(.in0(andOp_27_in0), .in1(andOp_27_in1), .out(andOp_27_out));

	reg [31:0] eq_28_in0;
	reg [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

	reg [0:0] andOp_29_in0;
	reg [0:0] andOp_29_in1;
	wire [0:0] andOp_29_out;
	andOp #(.WIDTH(1)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	reg [31:0] eq_30_in0;
	reg [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	reg [0:0] andOp_31_in0;
	reg [0:0] andOp_31_in1;
	wire [0:0] andOp_31_out;
	andOp #(.WIDTH(1)) andOp_31(.in0(andOp_31_in0), .in1(andOp_31_in1), .out(andOp_31_out));

	reg [31:0] eq_32_in0;
	reg [31:0] eq_32_in1;
	wire [0:0] eq_32_out;
	eq #(.WIDTH(32)) eq_32(.in0(eq_32_in0), .in1(eq_32_in1), .out(eq_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [31:0] eq_34_in0;
	reg [31:0] eq_34_in1;
	wire [0:0] eq_34_out;
	eq #(.WIDTH(32)) eq_34(.in0(eq_34_in0), .in1(eq_34_in1), .out(eq_34_out));

	reg [0:0] andOp_35_in0;
	reg [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	reg [31:0] eq_36_in0;
	reg [31:0] eq_36_in1;
	wire [0:0] eq_36_out;
	eq #(.WIDTH(32)) eq_36(.in0(eq_36_in0), .in1(eq_36_in1), .out(eq_36_out));

	reg [0:0] andOp_37_in0;
	reg [0:0] andOp_37_in1;
	wire [0:0] andOp_37_out;
	andOp #(.WIDTH(1)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	reg [31:0] eq_38_in0;
	reg [31:0] eq_38_in1;
	wire [0:0] eq_38_out;
	eq #(.WIDTH(32)) eq_38(.in0(eq_38_in0), .in1(eq_38_in1), .out(eq_38_out));

	reg [31:0] andOp_39_in0;
	reg [31:0] andOp_39_in1;
	wire [31:0] andOp_39_out;
	andOp #(.WIDTH(32)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	reg [31:0] andOp_40_in0;
	reg [31:0] andOp_40_in1;
	wire [31:0] andOp_40_out;
	andOp #(.WIDTH(32)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	reg [31:0] eq_41_in0;
	reg [31:0] eq_41_in1;
	wire [0:0] eq_41_out;
	eq #(.WIDTH(32)) eq_41(.in0(eq_41_in0), .in1(eq_41_in1), .out(eq_41_out));

	reg [31:0] andOp_42_in0;
	reg [31:0] andOp_42_in1;
	wire [31:0] andOp_42_out;
	andOp #(.WIDTH(32)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [31:0] eq_43_in0;
	reg [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	reg [31:0] andOp_44_in0;
	reg [31:0] andOp_44_in1;
	wire [31:0] andOp_44_out;
	andOp #(.WIDTH(32)) andOp_44(.in0(andOp_44_in0), .in1(andOp_44_in1), .out(andOp_44_out));

	reg [31:0] eq_45_in0;
	reg [31:0] eq_45_in1;
	wire [0:0] eq_45_out;
	eq #(.WIDTH(32)) eq_45(.in0(eq_45_in0), .in1(eq_45_in1), .out(eq_45_out));

	reg [31:0] andOp_46_in0;
	reg [31:0] andOp_46_in1;
	wire [31:0] andOp_46_out;
	andOp #(.WIDTH(32)) andOp_46(.in0(andOp_46_in0), .in1(andOp_46_in1), .out(andOp_46_out));

	reg [31:0] eq_47_in0;
	reg [31:0] eq_47_in1;
	wire [0:0] eq_47_out;
	eq #(.WIDTH(32)) eq_47(.in0(eq_47_in0), .in1(eq_47_in1), .out(eq_47_out));

	reg [31:0] andOp_48_in0;
	reg [31:0] andOp_48_in1;
	wire [31:0] andOp_48_out;
	andOp #(.WIDTH(32)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	reg [31:0] eq_49_in0;
	reg [31:0] eq_49_in1;
	wire [0:0] eq_49_out;
	eq #(.WIDTH(32)) eq_49(.in0(eq_49_in0), .in1(eq_49_in1), .out(eq_49_out));

	reg [31:0] andOp_50_in0;
	reg [31:0] andOp_50_in1;
	wire [31:0] andOp_50_out;
	andOp #(.WIDTH(32)) andOp_50(.in0(andOp_50_in0), .in1(andOp_50_in1), .out(andOp_50_out));

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

	reg [0:0] andOp_56_in0;
	reg [0:0] andOp_56_in1;
	wire [0:0] andOp_56_out;
	andOp #(.WIDTH(1)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

	reg [31:0] eq_57_in0;
	reg [31:0] eq_57_in1;
	wire [0:0] eq_57_out;
	eq #(.WIDTH(32)) eq_57(.in0(eq_57_in0), .in1(eq_57_in1), .out(eq_57_out));

	reg [31:0] andOp_58_in0;
	reg [31:0] andOp_58_in1;
	wire [31:0] andOp_58_out;
	andOp #(.WIDTH(32)) andOp_58(.in0(andOp_58_in0), .in1(andOp_58_in1), .out(andOp_58_out));

	reg [31:0] andOp_59_in0;
	reg [31:0] andOp_59_in1;
	wire [31:0] andOp_59_out;
	andOp #(.WIDTH(32)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	reg [31:0] eq_60_in0;
	reg [31:0] eq_60_in1;
	wire [0:0] eq_60_out;
	eq #(.WIDTH(32)) eq_60(.in0(eq_60_in0), .in1(eq_60_in1), .out(eq_60_out));

	reg [31:0] andOp_61_in0;
	reg [31:0] andOp_61_in1;
	wire [31:0] andOp_61_out;
	andOp #(.WIDTH(32)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

	reg [31:0] andOp_62_in0;
	reg [31:0] andOp_62_in1;
	wire [31:0] andOp_62_out;
	andOp #(.WIDTH(32)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	reg [31:0] eq_63_in0;
	reg [31:0] eq_63_in1;
	wire [0:0] eq_63_out;
	eq #(.WIDTH(32)) eq_63(.in0(eq_63_in0), .in1(eq_63_in1), .out(eq_63_out));

	reg [31:0] andOp_64_in0;
	reg [31:0] andOp_64_in1;
	wire [31:0] andOp_64_out;
	andOp #(.WIDTH(32)) andOp_64(.in0(andOp_64_in0), .in1(andOp_64_in1), .out(andOp_64_out));

	reg [31:0] andOp_65_in0;
	reg [31:0] andOp_65_in1;
	wire [31:0] andOp_65_out;
	andOp #(.WIDTH(32)) andOp_65(.in0(andOp_65_in0), .in1(andOp_65_in1), .out(andOp_65_out));

	reg [31:0] eq_66_in0;
	reg [31:0] eq_66_in1;
	wire [0:0] eq_66_out;
	eq #(.WIDTH(32)) eq_66(.in0(eq_66_in0), .in1(eq_66_in1), .out(eq_66_out));

	reg [0:0] andOp_67_in0;
	reg [0:0] andOp_67_in1;
	wire [0:0] andOp_67_out;
	andOp #(.WIDTH(1)) andOp_67(.in0(andOp_67_in0), .in1(andOp_67_in1), .out(andOp_67_out));

	reg [31:0] eq_68_in0;
	reg [31:0] eq_68_in1;
	wire [0:0] eq_68_out;
	eq #(.WIDTH(32)) eq_68(.in0(eq_68_in0), .in1(eq_68_in1), .out(eq_68_out));

	reg [31:0] andOp_69_in0;
	reg [31:0] andOp_69_in1;
	wire [31:0] andOp_69_out;
	andOp #(.WIDTH(32)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	reg [31:0] andOp_70_in0;
	reg [31:0] andOp_70_in1;
	wire [31:0] andOp_70_out;
	andOp #(.WIDTH(32)) andOp_70(.in0(andOp_70_in0), .in1(andOp_70_in1), .out(andOp_70_out));

	reg [31:0] eq_71_in0;
	reg [31:0] eq_71_in1;
	wire [0:0] eq_71_out;
	eq #(.WIDTH(32)) eq_71(.in0(eq_71_in0), .in1(eq_71_in1), .out(eq_71_out));

	reg [31:0] andOp_72_in0;
	reg [31:0] andOp_72_in1;
	wire [31:0] andOp_72_out;
	andOp #(.WIDTH(32)) andOp_72(.in0(andOp_72_in0), .in1(andOp_72_in1), .out(andOp_72_out));

	reg [31:0] andOp_73_in0;
	reg [31:0] andOp_73_in1;
	wire [31:0] andOp_73_out;
	andOp #(.WIDTH(32)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	reg [0:0] andOp_75_in0;
	reg [0:0] andOp_75_in1;
	wire [0:0] andOp_75_out;
	andOp #(.WIDTH(1)) andOp_75(.in0(andOp_75_in0), .in1(andOp_75_in1), .out(andOp_75_out));

	reg [31:0] eq_76_in0;
	reg [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	reg [31:0] andOp_77_in0;
	reg [31:0] andOp_77_in1;
	wire [31:0] andOp_77_out;
	andOp #(.WIDTH(32)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	reg [31:0] andOp_78_in0;
	reg [31:0] andOp_78_in1;
	wire [31:0] andOp_78_out;
	andOp #(.WIDTH(32)) andOp_78(.in0(andOp_78_in0), .in1(andOp_78_in1), .out(andOp_78_out));

	reg [31:0] eq_79_in0;
	reg [31:0] eq_79_in1;
	wire [0:0] eq_79_out;
	eq #(.WIDTH(32)) eq_79(.in0(eq_79_in0), .in1(eq_79_in1), .out(eq_79_out));

	reg [31:0] andOp_80_in0;
	reg [31:0] andOp_80_in1;
	wire [31:0] andOp_80_out;
	andOp #(.WIDTH(32)) andOp_80(.in0(andOp_80_in0), .in1(andOp_80_in1), .out(andOp_80_out));

	reg [31:0] andOp_81_in0;
	reg [31:0] andOp_81_in1;
	wire [31:0] andOp_81_out;
	andOp #(.WIDTH(32)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

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

	reg [31:0] eq_86_in0;
	reg [31:0] eq_86_in1;
	wire [0:0] eq_86_out;
	eq #(.WIDTH(32)) eq_86(.in0(eq_86_in0), .in1(eq_86_in1), .out(eq_86_out));

	reg [0:0] andOp_87_in0;
	reg [0:0] andOp_87_in1;
	wire [0:0] andOp_87_out;
	andOp #(.WIDTH(1)) andOp_87(.in0(andOp_87_in0), .in1(andOp_87_in1), .out(andOp_87_out));

	reg [31:0] eq_88_in0;
	reg [31:0] eq_88_in1;
	wire [0:0] eq_88_out;
	eq #(.WIDTH(32)) eq_88(.in0(eq_88_in0), .in1(eq_88_in1), .out(eq_88_out));

	reg [0:0] andOp_89_in0;
	reg [0:0] andOp_89_in1;
	wire [0:0] andOp_89_out;
	andOp #(.WIDTH(1)) andOp_89(.in0(andOp_89_in0), .in1(andOp_89_in1), .out(andOp_89_out));

	reg [31:0] eq_90_in0;
	reg [31:0] eq_90_in1;
	wire [0:0] eq_90_out;
	eq #(.WIDTH(32)) eq_90(.in0(eq_90_in0), .in1(eq_90_in1), .out(eq_90_out));

	reg [31:0] andOp_91_in0;
	reg [31:0] andOp_91_in1;
	wire [31:0] andOp_91_out;
	andOp #(.WIDTH(32)) andOp_91(.in0(andOp_91_in0), .in1(andOp_91_in1), .out(andOp_91_out));

	reg [31:0] eq_92_in0;
	reg [31:0] eq_92_in1;
	wire [0:0] eq_92_out;
	eq #(.WIDTH(32)) eq_92(.in0(eq_92_in0), .in1(eq_92_in1), .out(eq_92_out));

	reg [31:0] andOp_93_in0;
	reg [31:0] andOp_93_in1;
	wire [31:0] andOp_93_out;
	andOp #(.WIDTH(32)) andOp_93(.in0(andOp_93_in0), .in1(andOp_93_in1), .out(andOp_93_out));

	reg [31:0] eq_94_in0;
	reg [31:0] eq_94_in1;
	wire [0:0] eq_94_out;
	eq #(.WIDTH(32)) eq_94(.in0(eq_94_in0), .in1(eq_94_in1), .out(eq_94_out));

	reg [0:0] andOp_95_in0;
	reg [0:0] andOp_95_in1;
	wire [0:0] andOp_95_out;
	andOp #(.WIDTH(1)) andOp_95(.in0(andOp_95_in0), .in1(andOp_95_in1), .out(andOp_95_out));

	reg [31:0] eq_96_in0;
	reg [31:0] eq_96_in1;
	wire [0:0] eq_96_out;
	eq #(.WIDTH(32)) eq_96(.in0(eq_96_in0), .in1(eq_96_in1), .out(eq_96_out));

	reg [0:0] andOp_97_in0;
	reg [0:0] andOp_97_in1;
	wire [0:0] andOp_97_out;
	andOp #(.WIDTH(1)) andOp_97(.in0(andOp_97_in0), .in1(andOp_97_in1), .out(andOp_97_out));

	reg [31:0] eq_98_in0;
	reg [31:0] eq_98_in1;
	wire [0:0] eq_98_out;
	eq #(.WIDTH(32)) eq_98(.in0(eq_98_in0), .in1(eq_98_in1), .out(eq_98_out));

	reg [31:0] andOp_99_in0;
	reg [31:0] andOp_99_in1;
	wire [31:0] andOp_99_out;
	andOp #(.WIDTH(32)) andOp_99(.in0(andOp_99_in0), .in1(andOp_99_in1), .out(andOp_99_out));

	reg [31:0] eq_100_in0;
	reg [31:0] eq_100_in1;
	wire [0:0] eq_100_out;
	eq #(.WIDTH(32)) eq_100(.in0(eq_100_in0), .in1(eq_100_in1), .out(eq_100_out));

	reg [31:0] andOp_101_in0;
	reg [31:0] andOp_101_in1;
	wire [31:0] andOp_101_out;
	andOp #(.WIDTH(32)) andOp_101(.in0(andOp_101_in0), .in1(andOp_101_in1), .out(andOp_101_out));

	reg [31:0] eq_102_in0;
	reg [31:0] eq_102_in1;
	wire [0:0] eq_102_out;
	eq #(.WIDTH(32)) eq_102(.in0(eq_102_in0), .in1(eq_102_in1), .out(eq_102_out));

	reg [0:0] andOp_103_in0;
	reg [0:0] andOp_103_in1;
	wire [0:0] andOp_103_out;
	andOp #(.WIDTH(1)) andOp_103(.in0(andOp_103_in0), .in1(andOp_103_in1), .out(andOp_103_out));

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

	reg [31:0] eq_108_in0;
	reg [31:0] eq_108_in1;
	wire [0:0] eq_108_out;
	eq #(.WIDTH(32)) eq_108(.in0(eq_108_in0), .in1(eq_108_in1), .out(eq_108_out));

	reg [0:0] andOp_109_in0;
	reg [0:0] andOp_109_in1;
	wire [0:0] andOp_109_out;
	andOp #(.WIDTH(1)) andOp_109(.in0(andOp_109_in0), .in1(andOp_109_in1), .out(andOp_109_out));

	reg [31:0] eq_110_in0;
	reg [31:0] eq_110_in1;
	wire [0:0] eq_110_out;
	eq #(.WIDTH(32)) eq_110(.in0(eq_110_in0), .in1(eq_110_in1), .out(eq_110_out));

	reg [31:0] andOp_111_in0;
	reg [31:0] andOp_111_in1;
	wire [31:0] andOp_111_out;
	andOp #(.WIDTH(32)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [31:0] eq_112_in0;
	reg [31:0] eq_112_in1;
	wire [0:0] eq_112_out;
	eq #(.WIDTH(32)) eq_112(.in0(eq_112_in0), .in1(eq_112_in1), .out(eq_112_out));

	reg [31:0] andOp_113_in0;
	reg [31:0] andOp_113_in1;
	wire [31:0] andOp_113_out;
	andOp #(.WIDTH(32)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	reg [31:0] eq_114_in0;
	reg [31:0] eq_114_in1;
	wire [0:0] eq_114_out;
	eq #(.WIDTH(32)) eq_114(.in0(eq_114_in0), .in1(eq_114_in1), .out(eq_114_out));

	reg [31:0] andOp_115_in0;
	reg [31:0] andOp_115_in1;
	wire [31:0] andOp_115_out;
	andOp #(.WIDTH(32)) andOp_115(.in0(andOp_115_in0), .in1(andOp_115_in1), .out(andOp_115_out));

	reg [31:0] eq_116_in0;
	reg [31:0] eq_116_in1;
	wire [0:0] eq_116_out;
	eq #(.WIDTH(32)) eq_116(.in0(eq_116_in0), .in1(eq_116_in1), .out(eq_116_out));

	reg [0:0] andOp_117_in0;
	reg [0:0] andOp_117_in1;
	wire [0:0] andOp_117_out;
	andOp #(.WIDTH(1)) andOp_117(.in0(andOp_117_in0), .in1(andOp_117_in1), .out(andOp_117_out));

	reg [31:0] eq_118_in0;
	reg [31:0] eq_118_in1;
	wire [0:0] eq_118_out;
	eq #(.WIDTH(32)) eq_118(.in0(eq_118_in0), .in1(eq_118_in1), .out(eq_118_out));

	reg [0:0] andOp_119_in0;
	reg [0:0] andOp_119_in1;
	wire [0:0] andOp_119_out;
	andOp #(.WIDTH(1)) andOp_119(.in0(andOp_119_in0), .in1(andOp_119_in1), .out(andOp_119_out));

	reg [31:0] eq_120_in0;
	reg [31:0] eq_120_in1;
	wire [0:0] eq_120_out;
	eq #(.WIDTH(32)) eq_120(.in0(eq_120_in0), .in1(eq_120_in1), .out(eq_120_out));

	reg [0:0] andOp_121_in0;
	reg [0:0] andOp_121_in1;
	wire [0:0] andOp_121_out;
	andOp #(.WIDTH(1)) andOp_121(.in0(andOp_121_in0), .in1(andOp_121_in1), .out(andOp_121_out));

	reg [31:0] eq_122_in0;
	reg [31:0] eq_122_in1;
	wire [0:0] eq_122_out;
	eq #(.WIDTH(32)) eq_122(.in0(eq_122_in0), .in1(eq_122_in1), .out(eq_122_out));

	reg [31:0] andOp_123_in0;
	reg [31:0] andOp_123_in1;
	wire [31:0] andOp_123_out;
	andOp #(.WIDTH(32)) andOp_123(.in0(andOp_123_in0), .in1(andOp_123_in1), .out(andOp_123_out));

	reg [31:0] eq_124_in0;
	reg [31:0] eq_124_in1;
	wire [0:0] eq_124_out;
	eq #(.WIDTH(32)) eq_124(.in0(eq_124_in0), .in1(eq_124_in1), .out(eq_124_out));

	reg [31:0] eq_125_in0;
	reg [31:0] eq_125_in1;
	wire [0:0] eq_125_out;
	eq #(.WIDTH(32)) eq_125(.in0(eq_125_in0), .in1(eq_125_in1), .out(eq_125_out));

	reg [31:0] eq_126_in0;
	reg [31:0] eq_126_in1;
	wire [0:0] eq_126_out;
	eq #(.WIDTH(32)) eq_126(.in0(eq_126_in0), .in1(eq_126_in1), .out(eq_126_out));

	reg [31:0] eq_127_in0;
	reg [31:0] eq_127_in1;
	wire [0:0] eq_127_out;
	eq #(.WIDTH(32)) eq_127(.in0(eq_127_in0), .in1(eq_127_in1), .out(eq_127_out));

	reg [31:0] andOp_128_in0;
	reg [31:0] andOp_128_in1;
	wire [31:0] andOp_128_out;
	andOp #(.WIDTH(32)) andOp_128(.in0(andOp_128_in0), .in1(andOp_128_in1), .out(andOp_128_out));

	reg [31:0] eq_129_in0;
	reg [31:0] eq_129_in1;
	wire [0:0] eq_129_out;
	eq #(.WIDTH(32)) eq_129(.in0(eq_129_in0), .in1(eq_129_in1), .out(eq_129_out));

	reg [31:0] andOp_130_in0;
	reg [31:0] andOp_130_in1;
	wire [31:0] andOp_130_out;
	andOp #(.WIDTH(32)) andOp_130(.in0(andOp_130_in0), .in1(andOp_130_in1), .out(andOp_130_out));

	reg [31:0] eq_131_in0;
	reg [31:0] eq_131_in1;
	wire [0:0] eq_131_out;
	eq #(.WIDTH(32)) eq_131(.in0(eq_131_in0), .in1(eq_131_in1), .out(eq_131_out));

	reg [31:0] andOp_132_in0;
	reg [31:0] andOp_132_in1;
	wire [31:0] andOp_132_out;
	andOp #(.WIDTH(32)) andOp_132(.in0(andOp_132_in0), .in1(andOp_132_in1), .out(andOp_132_out));

	reg [31:0] andOp_133_in0;
	reg [31:0] andOp_133_in1;
	wire [31:0] andOp_133_out;
	andOp #(.WIDTH(32)) andOp_133(.in0(andOp_133_in0), .in1(andOp_133_in1), .out(andOp_133_out));

	reg [31:0] eq_134_in0;
	reg [31:0] eq_134_in1;
	wire [0:0] eq_134_out;
	eq #(.WIDTH(32)) eq_134(.in0(eq_134_in0), .in1(eq_134_in1), .out(eq_134_out));

	reg [31:0] andOp_135_in0;
	reg [31:0] andOp_135_in1;
	wire [31:0] andOp_135_out;
	andOp #(.WIDTH(32)) andOp_135(.in0(andOp_135_in0), .in1(andOp_135_in1), .out(andOp_135_out));

	reg [31:0] eq_136_in0;
	reg [31:0] eq_136_in1;
	wire [0:0] eq_136_out;
	eq #(.WIDTH(32)) eq_136(.in0(eq_136_in0), .in1(eq_136_in1), .out(eq_136_out));

	reg [31:0] andOp_137_in0;
	reg [31:0] andOp_137_in1;
	wire [31:0] andOp_137_out;
	andOp #(.WIDTH(32)) andOp_137(.in0(andOp_137_in0), .in1(andOp_137_in1), .out(andOp_137_out));

	reg [31:0] eq_138_in0;
	reg [31:0] eq_138_in1;
	wire [0:0] eq_138_out;
	eq #(.WIDTH(32)) eq_138(.in0(eq_138_in0), .in1(eq_138_in1), .out(eq_138_out));

	reg [31:0] andOp_139_in0;
	reg [31:0] andOp_139_in1;
	wire [31:0] andOp_139_out;
	andOp #(.WIDTH(32)) andOp_139(.in0(andOp_139_in0), .in1(andOp_139_in1), .out(andOp_139_out));

	reg [0:0] notOp_140_in0;
	wire [0:0] notOp_140_out;
	notOp #(.WIDTH(1)) notOp_140(.in(notOp_140_in0), .out(notOp_140_out));

	reg [31:0] eq_141_in0;
	reg [31:0] eq_141_in1;
	wire [0:0] eq_141_out;
	eq #(.WIDTH(32)) eq_141(.in0(eq_141_in0), .in1(eq_141_in1), .out(eq_141_out));

	reg [31:0] andOp_142_in0;
	reg [31:0] andOp_142_in1;
	wire [31:0] andOp_142_out;
	andOp #(.WIDTH(32)) andOp_142(.in0(andOp_142_in0), .in1(andOp_142_in1), .out(andOp_142_out));

	reg [31:0] eq_143_in0;
	reg [31:0] eq_143_in1;
	wire [0:0] eq_143_out;
	eq #(.WIDTH(32)) eq_143(.in0(eq_143_in0), .in1(eq_143_in1), .out(eq_143_out));

	reg [31:0] andOp_144_in0;
	reg [31:0] andOp_144_in1;
	wire [31:0] andOp_144_out;
	andOp #(.WIDTH(32)) andOp_144(.in0(andOp_144_in0), .in1(andOp_144_in1), .out(andOp_144_out));

	reg [31:0] andOp_145_in0;
	reg [31:0] andOp_145_in1;
	wire [31:0] andOp_145_out;
	andOp #(.WIDTH(32)) andOp_145(.in0(andOp_145_in0), .in1(andOp_145_in1), .out(andOp_145_out));

	reg [31:0] eq_146_in0;
	reg [31:0] eq_146_in1;
	wire [0:0] eq_146_out;
	eq #(.WIDTH(32)) eq_146(.in0(eq_146_in0), .in1(eq_146_in1), .out(eq_146_out));

	reg [31:0] andOp_147_in0;
	reg [31:0] andOp_147_in1;
	wire [31:0] andOp_147_out;
	andOp #(.WIDTH(32)) andOp_147(.in0(andOp_147_in0), .in1(andOp_147_in1), .out(andOp_147_out));

	reg [31:0] eq_148_in0;
	reg [31:0] eq_148_in1;
	wire [0:0] eq_148_out;
	eq #(.WIDTH(32)) eq_148(.in0(eq_148_in0), .in1(eq_148_in1), .out(eq_148_out));

	reg [31:0] andOp_149_in0;
	reg [31:0] andOp_149_in1;
	wire [31:0] andOp_149_out;
	andOp #(.WIDTH(32)) andOp_149(.in0(andOp_149_in0), .in1(andOp_149_in1), .out(andOp_149_out));

	reg [31:0] eq_150_in0;
	reg [31:0] eq_150_in1;
	wire [0:0] eq_150_out;
	eq #(.WIDTH(32)) eq_150(.in0(eq_150_in0), .in1(eq_150_in1), .out(eq_150_out));

	reg [31:0] eq_151_in0;
	reg [31:0] eq_151_in1;
	wire [0:0] eq_151_out;
	eq #(.WIDTH(32)) eq_151(.in0(eq_151_in0), .in1(eq_151_in1), .out(eq_151_out));

	reg [31:0] eq_152_in0;
	reg [31:0] eq_152_in1;
	wire [0:0] eq_152_out;
	eq #(.WIDTH(32)) eq_152(.in0(eq_152_in0), .in1(eq_152_in1), .out(eq_152_out));

	reg [31:0] eq_153_in0;
	reg [31:0] eq_153_in1;
	wire [0:0] eq_153_out;
	eq #(.WIDTH(32)) eq_153(.in0(eq_153_in0), .in1(eq_153_in1), .out(eq_153_out));

	reg [31:0] andOp_154_in0;
	reg [31:0] andOp_154_in1;
	wire [31:0] andOp_154_out;
	andOp #(.WIDTH(32)) andOp_154(.in0(andOp_154_in0), .in1(andOp_154_in1), .out(andOp_154_out));

	reg [31:0] andOp_155_in0;
	reg [31:0] andOp_155_in1;
	wire [31:0] andOp_155_out;
	andOp #(.WIDTH(32)) andOp_155(.in0(andOp_155_in0), .in1(andOp_155_in1), .out(andOp_155_out));

	reg [31:0] eq_156_in0;
	reg [31:0] eq_156_in1;
	wire [0:0] eq_156_out;
	eq #(.WIDTH(32)) eq_156(.in0(eq_156_in0), .in1(eq_156_in1), .out(eq_156_out));

	reg [31:0] andOp_157_in0;
	reg [31:0] andOp_157_in1;
	wire [31:0] andOp_157_out;
	andOp #(.WIDTH(32)) andOp_157(.in0(andOp_157_in0), .in1(andOp_157_in1), .out(andOp_157_out));

	reg [31:0] andOp_158_in0;
	reg [31:0] andOp_158_in1;
	wire [31:0] andOp_158_out;
	andOp #(.WIDTH(32)) andOp_158(.in0(andOp_158_in0), .in1(andOp_158_in1), .out(andOp_158_out));

	reg [31:0] eq_159_in0;
	reg [31:0] eq_159_in1;
	wire [0:0] eq_159_out;
	eq #(.WIDTH(32)) eq_159(.in0(eq_159_in0), .in1(eq_159_in1), .out(eq_159_out));

	reg [31:0] andOp_160_in0;
	reg [31:0] andOp_160_in1;
	wire [31:0] andOp_160_out;
	andOp #(.WIDTH(32)) andOp_160(.in0(andOp_160_in0), .in1(andOp_160_in1), .out(andOp_160_out));

	reg [31:0] andOp_161_in0;
	reg [31:0] andOp_161_in1;
	wire [31:0] andOp_161_out;
	andOp #(.WIDTH(32)) andOp_161(.in0(andOp_161_in0), .in1(andOp_161_in1), .out(andOp_161_out));

	reg [31:0] eq_162_in0;
	reg [31:0] eq_162_in1;
	wire [0:0] eq_162_out;
	eq #(.WIDTH(32)) eq_162(.in0(eq_162_in0), .in1(eq_162_in1), .out(eq_162_out));

	reg [31:0] eq_163_in0;
	reg [31:0] eq_163_in1;
	wire [0:0] eq_163_out;
	eq #(.WIDTH(32)) eq_163(.in0(eq_163_in0), .in1(eq_163_in1), .out(eq_163_out));

	reg [31:0] eq_164_in0;
	reg [31:0] eq_164_in1;
	wire [0:0] eq_164_out;
	eq #(.WIDTH(32)) eq_164(.in0(eq_164_in0), .in1(eq_164_in1), .out(eq_164_out));

	reg [31:0] eq_165_in0;
	reg [31:0] eq_165_in1;
	wire [0:0] eq_165_out;
	eq #(.WIDTH(32)) eq_165(.in0(eq_165_in0), .in1(eq_165_in1), .out(eq_165_out));

	reg [31:0] eq_166_in0;
	reg [31:0] eq_166_in1;
	wire [0:0] eq_166_out;
	eq #(.WIDTH(32)) eq_166(.in0(eq_166_in0), .in1(eq_166_in1), .out(eq_166_out));

	reg [31:0] eq_167_in0;
	reg [31:0] eq_167_in1;
	wire [0:0] eq_167_out;
	eq #(.WIDTH(32)) eq_167(.in0(eq_167_in0), .in1(eq_167_in1), .out(eq_167_out));

	// End Functional Units

	reg [31:0] add_tmp_2;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_3;
	reg [31:0] last_BB_reg;
	reg [31:0] load_tmp_1;

	// controller for add_add_12.add_in0_add_12
	// controller for add_add_12.add_in1_add_12
	// Insensitive connections
	always @(*) begin
		add_in0_add_12 = valid ? load_tmp_1 : load_tmp_1;
		add_in1_add_12 = valid ? in_out_data : in_out_data;
	end
	// controller for add_add_7.add_in0_add_7
	// controller for add_add_7.add_in1_add_7
	// Insensitive connections
	always @(*) begin
		add_in0_add_7 = valid ? phi_out_phi_5 : phi_out_phi_5;
		add_in1_add_7 = valid ? (32'd1) : (32'd1);
	end
	// controller for andOp_1.andOp_1_in0
	// controller for andOp_1.andOp_1_in1
	// Insensitive connections
	always @(*) begin
		andOp_1_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_1_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	always @(*) begin
		andOp_101_in0 = valid ? eq_100_out : eq_100_out;
		andOp_101_in1 = valid ? andOp_97_out : andOp_97_out;
	end
	// controller for andOp_103.andOp_103_in0
	// controller for andOp_103.andOp_103_in1
	// Insensitive connections
	always @(*) begin
		andOp_103_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_103_in1 = valid ? eq_102_out : eq_102_out;
	end
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	always @(*) begin
		andOp_105_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_105_in1 = valid ? eq_104_out : eq_104_out;
	end
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	always @(*) begin
		andOp_107_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_107_in1 = valid ? eq_106_out : eq_106_out;
	end
	// controller for andOp_109.andOp_109_in0
	// controller for andOp_109.andOp_109_in1
	// Insensitive connections
	always @(*) begin
		andOp_109_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_109_in1 = valid ? eq_108_out : eq_108_out;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? eq_110_out : eq_110_out;
		andOp_111_in1 = valid ? andOp_107_out : andOp_107_out;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? eq_112_out : eq_112_out;
		andOp_113_in1 = valid ? andOp_105_out : andOp_105_out;
	end
	// controller for andOp_115.andOp_115_in0
	// controller for andOp_115.andOp_115_in1
	// Insensitive connections
	always @(*) begin
		andOp_115_in0 = valid ? eq_114_out : eq_114_out;
		andOp_115_in1 = valid ? andOp_109_out : andOp_109_out;
	end
	// controller for andOp_117.andOp_117_in0
	// controller for andOp_117.andOp_117_in1
	// Insensitive connections
	always @(*) begin
		andOp_117_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_117_in1 = valid ? eq_116_out : eq_116_out;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_119_in1 = valid ? eq_118_out : eq_118_out;
	end
	// controller for andOp_121.andOp_121_in0
	// controller for andOp_121.andOp_121_in1
	// Insensitive connections
	always @(*) begin
		andOp_121_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_121_in1 = valid ? eq_120_out : eq_120_out;
	end
	// controller for andOp_123.andOp_123_in0
	// controller for andOp_123.andOp_123_in1
	// Insensitive connections
	always @(*) begin
		andOp_123_in0 = valid ? eq_122_out : eq_122_out;
		andOp_123_in1 = valid ? andOp_121_out : andOp_121_out;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? eq_127_out : eq_127_out;
		andOp_128_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_13.andOp_13_in0
	// controller for andOp_13.andOp_13_in1
	// Insensitive connections
	always @(*) begin
		andOp_13_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_13_in1 = valid ? eq_12_out : eq_12_out;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? eq_129_out : eq_129_out;
		andOp_130_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_132.andOp_132_in0
	// controller for andOp_132.andOp_132_in1
	// Insensitive connections
	always @(*) begin
		andOp_132_in0 = valid ? eq_131_out : eq_131_out;
		andOp_132_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? andOp_132_out : andOp_132_out;
		andOp_133_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_135.andOp_135_in0
	// controller for andOp_135.andOp_135_in1
	// Insensitive connections
	always @(*) begin
		andOp_135_in0 = valid ? eq_134_out : eq_134_out;
		andOp_135_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_137.andOp_137_in0
	// controller for andOp_137.andOp_137_in1
	// Insensitive connections
	always @(*) begin
		andOp_137_in0 = valid ? eq_136_out : eq_136_out;
		andOp_137_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? eq_138_out : eq_138_out;
		andOp_139_in1 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? eq_141_out : eq_141_out;
		andOp_142_in1 = valid ? notOp_140_out : notOp_140_out;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? eq_143_out : eq_143_out;
		andOp_144_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? andOp_144_out : andOp_144_out;
		andOp_145_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_147.andOp_147_in0
	// controller for andOp_147.andOp_147_in1
	// Insensitive connections
	always @(*) begin
		andOp_147_in0 = valid ? eq_146_out : eq_146_out;
		andOp_147_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_149.andOp_149_in0
	// controller for andOp_149.andOp_149_in1
	// Insensitive connections
	always @(*) begin
		andOp_149_in0 = valid ? eq_148_out : eq_148_out;
		andOp_149_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	always @(*) begin
		andOp_15_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_15_in1 = valid ? eq_14_out : eq_14_out;
	end
	// controller for andOp_154.andOp_154_in0
	// controller for andOp_154.andOp_154_in1
	// Insensitive connections
	always @(*) begin
		andOp_154_in0 = valid ? eq_152_out : eq_152_out;
		andOp_154_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_155.andOp_155_in0
	// controller for andOp_155.andOp_155_in1
	// Insensitive connections
	always @(*) begin
		andOp_155_in0 = valid ? andOp_154_out : andOp_154_out;
		andOp_155_in1 = valid ? eq_153_out : eq_153_out;
	end
	// controller for andOp_157.andOp_157_in0
	// controller for andOp_157.andOp_157_in1
	// Insensitive connections
	always @(*) begin
		andOp_157_in0 = valid ? eq_152_out : eq_152_out;
		andOp_157_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_158.andOp_158_in0
	// controller for andOp_158.andOp_158_in1
	// Insensitive connections
	always @(*) begin
		andOp_158_in0 = valid ? andOp_157_out : andOp_157_out;
		andOp_158_in1 = valid ? eq_156_out : eq_156_out;
	end
	// controller for andOp_160.andOp_160_in0
	// controller for andOp_160.andOp_160_in1
	// Insensitive connections
	always @(*) begin
		andOp_160_in0 = valid ? eq_152_out : eq_152_out;
		andOp_160_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_161.andOp_161_in0
	// controller for andOp_161.andOp_161_in1
	// Insensitive connections
	always @(*) begin
		andOp_161_in0 = valid ? andOp_160_out : andOp_160_out;
		andOp_161_in1 = valid ? eq_159_out : eq_159_out;
	end
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	always @(*) begin
		andOp_17_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_17_in1 = valid ? eq_16_out : eq_16_out;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_19_in1 = valid ? eq_18_out : eq_18_out;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_21_in1 = valid ? eq_20_out : eq_20_out;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_23_in1 = valid ? eq_22_out : eq_22_out;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_25_in1 = valid ? eq_24_out : eq_24_out;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_27_in1 = valid ? eq_26_out : eq_26_out;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_29_in1 = valid ? eq_28_out : eq_28_out;
	end
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	always @(*) begin
		andOp_31_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_31_in1 = valid ? eq_30_out : eq_30_out;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_33_in1 = valid ? eq_32_out : eq_32_out;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_35_in1 = valid ? eq_34_out : eq_34_out;
	end
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	always @(*) begin
		andOp_37_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_37_in1 = valid ? eq_36_out : eq_36_out;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? eq_38_out : eq_38_out;
		andOp_39_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_4.andOp_4_in0
	// controller for andOp_4.andOp_4_in1
	// Insensitive connections
	always @(*) begin
		andOp_4_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_4_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? andOp_39_out : andOp_39_out;
		andOp_40_in1 = valid ? andOp_33_out : andOp_33_out;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? eq_41_out : eq_41_out;
		andOp_42_in1 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	always @(*) begin
		andOp_44_in0 = valid ? eq_43_out : eq_43_out;
		andOp_44_in1 = valid ? andOp_31_out : andOp_31_out;
	end
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	always @(*) begin
		andOp_46_in0 = valid ? eq_45_out : eq_45_out;
		andOp_46_in1 = valid ? andOp_35_out : andOp_35_out;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? eq_47_out : eq_47_out;
		andOp_48_in1 = valid ? andOp_31_out : andOp_31_out;
	end
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	always @(*) begin
		andOp_50_in0 = valid ? eq_49_out : eq_49_out;
		andOp_50_in1 = valid ? andOp_35_out : andOp_35_out;
	end
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	always @(*) begin
		andOp_52_in0 = valid ? eq_51_out : eq_51_out;
		andOp_52_in1 = valid ? andOp_31_out : andOp_31_out;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? eq_53_out : eq_53_out;
		andOp_54_in1 = valid ? andOp_35_out : andOp_35_out;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_56_in1 = valid ? eq_55_out : eq_55_out;
	end
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	always @(*) begin
		andOp_58_in0 = valid ? eq_57_out : eq_57_out;
		andOp_58_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? andOp_58_out : andOp_58_out;
		andOp_59_in1 = valid ? andOp_56_out : andOp_56_out;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? andOp_4_out : andOp_4_out;
		andOp_6_in1 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	always @(*) begin
		andOp_61_in0 = valid ? eq_60_out : eq_60_out;
		andOp_61_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? andOp_61_out : andOp_61_out;
		andOp_62_in1 = valid ? andOp_56_out : andOp_56_out;
	end
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	always @(*) begin
		andOp_64_in0 = valid ? eq_63_out : eq_63_out;
		andOp_64_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? andOp_64_out : andOp_64_out;
		andOp_65_in1 = valid ? andOp_56_out : andOp_56_out;
	end
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	always @(*) begin
		andOp_67_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_67_in1 = valid ? eq_66_out : eq_66_out;
	end
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	always @(*) begin
		andOp_69_in0 = valid ? eq_68_out : eq_68_out;
		andOp_69_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	always @(*) begin
		andOp_70_in0 = valid ? andOp_69_out : andOp_69_out;
		andOp_70_in1 = valid ? andOp_67_out : andOp_67_out;
	end
	// controller for andOp_72.andOp_72_in0
	// controller for andOp_72.andOp_72_in1
	// Insensitive connections
	always @(*) begin
		andOp_72_in0 = valid ? eq_71_out : eq_71_out;
		andOp_72_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	always @(*) begin
		andOp_73_in0 = valid ? andOp_72_out : andOp_72_out;
		andOp_73_in1 = valid ? andOp_67_out : andOp_67_out;
	end
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	always @(*) begin
		andOp_75_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_75_in1 = valid ? eq_74_out : eq_74_out;
	end
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	always @(*) begin
		andOp_77_in0 = valid ? eq_76_out : eq_76_out;
		andOp_77_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_78.andOp_78_in0
	// controller for andOp_78.andOp_78_in1
	// Insensitive connections
	always @(*) begin
		andOp_78_in0 = valid ? andOp_77_out : andOp_77_out;
		andOp_78_in1 = valid ? andOp_75_out : andOp_75_out;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? andOp_4_out : andOp_4_out;
		andOp_8_in1 = valid ? notOp_7_out : notOp_7_out;
	end
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	always @(*) begin
		andOp_80_in0 = valid ? eq_79_out : eq_79_out;
		andOp_80_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	always @(*) begin
		andOp_81_in0 = valid ? andOp_80_out : andOp_80_out;
		andOp_81_in1 = valid ? andOp_75_out : andOp_75_out;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_83_in1 = valid ? eq_82_out : eq_82_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_85_in1 = valid ? eq_84_out : eq_84_out;
	end
	// controller for andOp_87.andOp_87_in0
	// controller for andOp_87.andOp_87_in1
	// Insensitive connections
	always @(*) begin
		andOp_87_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_87_in1 = valid ? eq_86_out : eq_86_out;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_89_in1 = valid ? eq_88_out : eq_88_out;
	end
	// controller for andOp_91.andOp_91_in0
	// controller for andOp_91.andOp_91_in1
	// Insensitive connections
	always @(*) begin
		andOp_91_in0 = valid ? eq_90_out : eq_90_out;
		andOp_91_in1 = valid ? andOp_85_out : andOp_85_out;
	end
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	always @(*) begin
		andOp_93_in0 = valid ? eq_92_out : eq_92_out;
		andOp_93_in1 = valid ? andOp_87_out : andOp_87_out;
	end
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	always @(*) begin
		andOp_95_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_95_in1 = valid ? eq_94_out : eq_94_out;
	end
	// controller for andOp_97.andOp_97_in0
	// controller for andOp_97.andOp_97_in1
	// Insensitive connections
	always @(*) begin
		andOp_97_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_97_in1 = valid ? eq_96_out : eq_96_out;
	end
	// controller for andOp_99.andOp_99_in0
	// controller for andOp_99.andOp_99_in1
	// Insensitive connections
	always @(*) begin
		andOp_99_in0 = valid ? eq_98_out : eq_98_out;
		andOp_99_in1 = valid ? andOp_97_out : andOp_97_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_9_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_10_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_11_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (andOp_1_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_2_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_2_happened.br_2_happened_in_data
	always @(*) begin
		if (andOp_4_out) begin 
			br_2_happened_in_data = 1'd1;
		end else if (notOp_5_out) begin 
			br_2_happened_in_data = 1'd0;
		end else begin
			br_2_happened_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd1 : 32'd1;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_10.eq_10_in0
	// controller for eq_10.eq_10_in1
	// Insensitive connections
	always @(*) begin
		eq_10_in0 = valid ? 32'd1 : 32'd1;
		eq_10_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_100.eq_100_in0
	// controller for eq_100.eq_100_in1
	// Insensitive connections
	always @(*) begin
		eq_100_in0 = valid ? 32'd4 : 32'd4;
		eq_100_in1 = valid ? global_state : global_state;
	end
	// controller for eq_102.eq_102_in0
	// controller for eq_102.eq_102_in1
	// Insensitive connections
	always @(*) begin
		eq_102_in0 = valid ? 32'd6 : 32'd6;
		eq_102_in1 = valid ? global_state : global_state;
	end
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	always @(*) begin
		eq_104_in0 = valid ? 32'd7 : 32'd7;
		eq_104_in1 = valid ? global_state : global_state;
	end
	// controller for eq_106.eq_106_in0
	// controller for eq_106.eq_106_in1
	// Insensitive connections
	always @(*) begin
		eq_106_in0 = valid ? 32'd7 : 32'd7;
		eq_106_in1 = valid ? global_state : global_state;
	end
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	always @(*) begin
		eq_108_in0 = valid ? 32'd8 : 32'd8;
		eq_108_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd2 : 32'd2;
		eq_11_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_110.eq_110_in0
	// controller for eq_110.eq_110_in1
	// Insensitive connections
	always @(*) begin
		eq_110_in0 = valid ? 32'd7 : 32'd7;
		eq_110_in1 = valid ? global_state : global_state;
	end
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	always @(*) begin
		eq_112_in0 = valid ? 32'd7 : 32'd7;
		eq_112_in1 = valid ? global_state : global_state;
	end
	// controller for eq_114.eq_114_in0
	// controller for eq_114.eq_114_in1
	// Insensitive connections
	always @(*) begin
		eq_114_in0 = valid ? 32'd8 : 32'd8;
		eq_114_in1 = valid ? global_state : global_state;
	end
	// controller for eq_116.eq_116_in0
	// controller for eq_116.eq_116_in1
	// Insensitive connections
	always @(*) begin
		eq_116_in0 = valid ? 32'd6 : 32'd6;
		eq_116_in1 = valid ? global_state : global_state;
	end
	// controller for eq_118.eq_118_in0
	// controller for eq_118.eq_118_in1
	// Insensitive connections
	always @(*) begin
		eq_118_in0 = valid ? 32'd6 : 32'd6;
		eq_118_in1 = valid ? global_state : global_state;
	end
	// controller for eq_12.eq_12_in0
	// controller for eq_12.eq_12_in1
	// Insensitive connections
	always @(*) begin
		eq_12_in0 = valid ? 32'd0 : 32'd0;
		eq_12_in1 = valid ? global_state : global_state;
	end
	// controller for eq_120.eq_120_in0
	// controller for eq_120.eq_120_in1
	// Insensitive connections
	always @(*) begin
		eq_120_in0 = valid ? 32'd8 : 32'd8;
		eq_120_in1 = valid ? global_state : global_state;
	end
	// controller for eq_122.eq_122_in0
	// controller for eq_122.eq_122_in1
	// Insensitive connections
	always @(*) begin
		eq_122_in0 = valid ? 32'd8 : 32'd8;
		eq_122_in1 = valid ? global_state : global_state;
	end
	// controller for eq_124.eq_124_in0
	// controller for eq_124.eq_124_in1
	// Insensitive connections
	always @(*) begin
		eq_124_in0 = valid ? 32'd1 : 32'd1;
		eq_124_in1 = valid ? global_state : global_state;
	end
	// controller for eq_125.eq_125_in0
	// controller for eq_125.eq_125_in1
	// Insensitive connections
	always @(*) begin
		eq_125_in0 = valid ? 32'd5 : 32'd5;
		eq_125_in1 = valid ? global_state : global_state;
	end
	// controller for eq_126.eq_126_in0
	// controller for eq_126.eq_126_in1
	// Insensitive connections
	always @(*) begin
		eq_126_in0 = valid ? 32'd8 : 32'd8;
		eq_126_in1 = valid ? global_state : global_state;
	end
	// controller for eq_127.eq_127_in0
	// controller for eq_127.eq_127_in1
	// Insensitive connections
	always @(*) begin
		eq_127_in0 = valid ? 32'd0 : 32'd0;
		eq_127_in1 = valid ? global_state : global_state;
	end
	// controller for eq_129.eq_129_in0
	// controller for eq_129.eq_129_in1
	// Insensitive connections
	always @(*) begin
		eq_129_in0 = valid ? 32'd1 : 32'd1;
		eq_129_in1 = valid ? global_state : global_state;
	end
	// controller for eq_131.eq_131_in0
	// controller for eq_131.eq_131_in1
	// Insensitive connections
	always @(*) begin
		eq_131_in0 = valid ? 32'd2 : 32'd2;
		eq_131_in1 = valid ? global_state : global_state;
	end
	// controller for eq_134.eq_134_in0
	// controller for eq_134.eq_134_in1
	// Insensitive connections
	always @(*) begin
		eq_134_in0 = valid ? 32'd3 : 32'd3;
		eq_134_in1 = valid ? global_state : global_state;
	end
	// controller for eq_136.eq_136_in0
	// controller for eq_136.eq_136_in1
	// Insensitive connections
	always @(*) begin
		eq_136_in0 = valid ? 32'd4 : 32'd4;
		eq_136_in1 = valid ? global_state : global_state;
	end
	// controller for eq_138.eq_138_in0
	// controller for eq_138.eq_138_in1
	// Insensitive connections
	always @(*) begin
		eq_138_in0 = valid ? 32'd5 : 32'd5;
		eq_138_in1 = valid ? global_state : global_state;
	end
	// controller for eq_14.eq_14_in0
	// controller for eq_14.eq_14_in1
	// Insensitive connections
	always @(*) begin
		eq_14_in0 = valid ? 32'd2 : 32'd2;
		eq_14_in1 = valid ? global_state : global_state;
	end
	// controller for eq_141.eq_141_in0
	// controller for eq_141.eq_141_in1
	// Insensitive connections
	always @(*) begin
		eq_141_in0 = valid ? 32'd5 : 32'd5;
		eq_141_in1 = valid ? global_state : global_state;
	end
	// controller for eq_143.eq_143_in0
	// controller for eq_143.eq_143_in1
	// Insensitive connections
	always @(*) begin
		eq_143_in0 = valid ? 32'd6 : 32'd6;
		eq_143_in1 = valid ? global_state : global_state;
	end
	// controller for eq_146.eq_146_in0
	// controller for eq_146.eq_146_in1
	// Insensitive connections
	always @(*) begin
		eq_146_in0 = valid ? 32'd7 : 32'd7;
		eq_146_in1 = valid ? global_state : global_state;
	end
	// controller for eq_148.eq_148_in0
	// controller for eq_148.eq_148_in1
	// Insensitive connections
	always @(*) begin
		eq_148_in0 = valid ? 32'd8 : 32'd8;
		eq_148_in1 = valid ? global_state : global_state;
	end
	// controller for eq_150.eq_150_in0
	// controller for eq_150.eq_150_in1
	// Insensitive connections
	always @(*) begin
		eq_150_in0 = valid ? 32'd0 : 32'd0;
		eq_150_in1 = valid ? global_state : global_state;
	end
	// controller for eq_151.eq_151_in0
	// controller for eq_151.eq_151_in1
	// Insensitive connections
	always @(*) begin
		eq_151_in0 = valid ? 32'd1 : 32'd1;
		eq_151_in1 = valid ? global_state : global_state;
	end
	// controller for eq_152.eq_152_in0
	// controller for eq_152.eq_152_in1
	// Insensitive connections
	always @(*) begin
		eq_152_in0 = valid ? 32'd2 : 32'd2;
		eq_152_in1 = valid ? global_state : global_state;
	end
	// controller for eq_153.eq_153_in0
	// controller for eq_153.eq_153_in1
	// Insensitive connections
	always @(*) begin
		eq_153_in0 = valid ? 32'd2 : 32'd2;
		eq_153_in1 = valid ? global_state : global_state;
	end
	// controller for eq_156.eq_156_in0
	// controller for eq_156.eq_156_in1
	// Insensitive connections
	always @(*) begin
		eq_156_in0 = valid ? 32'd2 : 32'd2;
		eq_156_in1 = valid ? global_state : global_state;
	end
	// controller for eq_159.eq_159_in0
	// controller for eq_159.eq_159_in1
	// Insensitive connections
	always @(*) begin
		eq_159_in0 = valid ? 32'd2 : 32'd2;
		eq_159_in1 = valid ? global_state : global_state;
	end
	// controller for eq_16.eq_16_in0
	// controller for eq_16.eq_16_in1
	// Insensitive connections
	always @(*) begin
		eq_16_in0 = valid ? 32'd3 : 32'd3;
		eq_16_in1 = valid ? global_state : global_state;
	end
	// controller for eq_162.eq_162_in0
	// controller for eq_162.eq_162_in1
	// Insensitive connections
	always @(*) begin
		eq_162_in0 = valid ? 32'd3 : 32'd3;
		eq_162_in1 = valid ? global_state : global_state;
	end
	// controller for eq_163.eq_163_in0
	// controller for eq_163.eq_163_in1
	// Insensitive connections
	always @(*) begin
		eq_163_in0 = valid ? 32'd4 : 32'd4;
		eq_163_in1 = valid ? global_state : global_state;
	end
	// controller for eq_164.eq_164_in0
	// controller for eq_164.eq_164_in1
	// Insensitive connections
	always @(*) begin
		eq_164_in0 = valid ? 32'd5 : 32'd5;
		eq_164_in1 = valid ? global_state : global_state;
	end
	// controller for eq_165.eq_165_in0
	// controller for eq_165.eq_165_in1
	// Insensitive connections
	always @(*) begin
		eq_165_in0 = valid ? 32'd6 : 32'd6;
		eq_165_in1 = valid ? global_state : global_state;
	end
	// controller for eq_166.eq_166_in0
	// controller for eq_166.eq_166_in1
	// Insensitive connections
	always @(*) begin
		eq_166_in0 = valid ? 32'd7 : 32'd7;
		eq_166_in1 = valid ? global_state : global_state;
	end
	// controller for eq_167.eq_167_in0
	// controller for eq_167.eq_167_in1
	// Insensitive connections
	always @(*) begin
		eq_167_in0 = valid ? 32'd8 : 32'd8;
		eq_167_in1 = valid ? global_state : global_state;
	end
	// controller for eq_18.eq_18_in0
	// controller for eq_18.eq_18_in1
	// Insensitive connections
	always @(*) begin
		eq_18_in0 = valid ? 32'd4 : 32'd4;
		eq_18_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd6 : 32'd6;
		eq_20_in1 = valid ? global_state : global_state;
	end
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	always @(*) begin
		eq_22_in0 = valid ? 32'd7 : 32'd7;
		eq_22_in1 = valid ? global_state : global_state;
	end
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	always @(*) begin
		eq_24_in0 = valid ? 32'd0 : 32'd0;
		eq_24_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd0 : 32'd0;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd0 : 32'd0;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd5 : 32'd5;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd0 : 32'd0;
		eq_30_in1 = valid ? global_state : global_state;
	end
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	always @(*) begin
		eq_32_in0 = valid ? 32'd2 : 32'd2;
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
		eq_36_in0 = valid ? 32'd7 : 32'd7;
		eq_36_in1 = valid ? global_state : global_state;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd2 : 32'd2;
		eq_38_in1 = valid ? global_state : global_state;
	end
	// controller for eq_41.eq_41_in0
	// controller for eq_41.eq_41_in1
	// Insensitive connections
	always @(*) begin
		eq_41_in0 = valid ? 32'd7 : 32'd7;
		eq_41_in1 = valid ? global_state : global_state;
	end
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	always @(*) begin
		eq_43_in0 = valid ? 32'd0 : 32'd0;
		eq_43_in1 = valid ? global_state : global_state;
	end
	// controller for eq_45.eq_45_in0
	// controller for eq_45.eq_45_in1
	// Insensitive connections
	always @(*) begin
		eq_45_in0 = valid ? 32'd4 : 32'd4;
		eq_45_in1 = valid ? global_state : global_state;
	end
	// controller for eq_47.eq_47_in0
	// controller for eq_47.eq_47_in1
	// Insensitive connections
	always @(*) begin
		eq_47_in0 = valid ? 32'd0 : 32'd0;
		eq_47_in1 = valid ? global_state : global_state;
	end
	// controller for eq_49.eq_49_in0
	// controller for eq_49.eq_49_in1
	// Insensitive connections
	always @(*) begin
		eq_49_in0 = valid ? 32'd4 : 32'd4;
		eq_49_in1 = valid ? global_state : global_state;
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
		eq_53_in0 = valid ? 32'd4 : 32'd4;
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
		eq_57_in0 = valid ? 32'd2 : 32'd2;
		eq_57_in1 = valid ? global_state : global_state;
	end
	// controller for eq_60.eq_60_in0
	// controller for eq_60.eq_60_in1
	// Insensitive connections
	always @(*) begin
		eq_60_in0 = valid ? 32'd2 : 32'd2;
		eq_60_in1 = valid ? global_state : global_state;
	end
	// controller for eq_63.eq_63_in0
	// controller for eq_63.eq_63_in1
	// Insensitive connections
	always @(*) begin
		eq_63_in0 = valid ? 32'd2 : 32'd2;
		eq_63_in1 = valid ? global_state : global_state;
	end
	// controller for eq_66.eq_66_in0
	// controller for eq_66.eq_66_in1
	// Insensitive connections
	always @(*) begin
		eq_66_in0 = valid ? 32'd2 : 32'd2;
		eq_66_in1 = valid ? global_state : global_state;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd2 : 32'd2;
		eq_68_in1 = valid ? global_state : global_state;
	end
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	always @(*) begin
		eq_71_in0 = valid ? 32'd2 : 32'd2;
		eq_71_in1 = valid ? global_state : global_state;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd2 : 32'd2;
		eq_74_in1 = valid ? global_state : global_state;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd2 : 32'd2;
		eq_76_in1 = valid ? global_state : global_state;
	end
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	always @(*) begin
		eq_79_in0 = valid ? 32'd2 : 32'd2;
		eq_79_in1 = valid ? global_state : global_state;
	end
	// controller for eq_82.eq_82_in0
	// controller for eq_82.eq_82_in1
	// Insensitive connections
	always @(*) begin
		eq_82_in0 = valid ? 32'd2 : 32'd2;
		eq_82_in1 = valid ? global_state : global_state;
	end
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	always @(*) begin
		eq_84_in0 = valid ? 32'd3 : 32'd3;
		eq_84_in1 = valid ? global_state : global_state;
	end
	// controller for eq_86.eq_86_in0
	// controller for eq_86.eq_86_in1
	// Insensitive connections
	always @(*) begin
		eq_86_in0 = valid ? 32'd4 : 32'd4;
		eq_86_in1 = valid ? global_state : global_state;
	end
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	always @(*) begin
		eq_88_in0 = valid ? 32'd4 : 32'd4;
		eq_88_in1 = valid ? global_state : global_state;
	end
	// controller for eq_9.eq_9_in0
	// controller for eq_9.eq_9_in1
	// Insensitive connections
	always @(*) begin
		eq_9_in0 = valid ? 32'd0 : 32'd0;
		eq_9_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd3 : 32'd3;
		eq_90_in1 = valid ? global_state : global_state;
	end
	// controller for eq_92.eq_92_in0
	// controller for eq_92.eq_92_in1
	// Insensitive connections
	always @(*) begin
		eq_92_in0 = valid ? 32'd4 : 32'd4;
		eq_92_in1 = valid ? global_state : global_state;
	end
	// controller for eq_94.eq_94_in0
	// controller for eq_94.eq_94_in1
	// Insensitive connections
	always @(*) begin
		eq_94_in0 = valid ? 32'd2 : 32'd2;
		eq_94_in1 = valid ? global_state : global_state;
	end
	// controller for eq_96.eq_96_in0
	// controller for eq_96.eq_96_in1
	// Insensitive connections
	always @(*) begin
		eq_96_in0 = valid ? 32'd4 : 32'd4;
		eq_96_in1 = valid ? global_state : global_state;
	end
	// controller for eq_98.eq_98_in0
	// controller for eq_98.eq_98_in1
	// Insensitive connections
	always @(*) begin
		eq_98_in0 = valid ? 32'd4 : 32'd4;
		eq_98_in1 = valid ? global_state : global_state;
	end
	// controller for icmp_8.cmp_in0_icmp_8
	// controller for icmp_8.cmp_in1_icmp_8
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_8 = valid ? add_out_add_7 : add_out_add_7;
		cmp_in1_icmp_8 = valid ? (32'd4) : (32'd4);
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if (andOp_91_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (andOp_93_out) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_140.notOp_140_in0
	// Insensitive connections
	always @(*) begin
		notOp_140_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_2.notOp_2_in0
	// Insensitive connections
	always @(*) begin
		notOp_2_in0 = valid ? andOp_1_out : andOp_1_out;
	end
	// controller for notOp_5.notOp_5_in0
	// Insensitive connections
	always @(*) begin
		notOp_5_in0 = valid ? andOp_4_out : andOp_4_out;
	end
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	always @(*) begin
		notOp_7_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_111_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_113_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (andOp_115_out) begin 
			out_write_valid_reg = (1'd0);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// controller for phi_5.phi_in_phi_5
	// controller for phi_5.phi_last_block_phi_5
	// controller for phi_5.phi_s_phi_5
	// Insensitive connections
	always @(*) begin
		phi_in_phi_5 = valid ? {(32'd0), add_tmp_2} : {(32'd0), add_tmp_2};
		phi_last_block_phi_5 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_5 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_40_out) begin 
			raddr_ram_0_reg = 0;
		end else if (andOp_42_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_44_out) begin 
			waddr_ram_0_reg = 0;
		end else if (andOp_46_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_48_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (andOp_50_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_52_out) begin 
			wen_ram_0_reg = 1;
		end else if (andOp_54_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_24.valid_reg
	always @(*) begin
		if (andOp_123_out) begin 
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
			if (andOp_158_out) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (andOp_13_out) begin
				global_next_block <= 0;
			end
			if (andOp_15_out) begin
				global_next_block <= 2;
			end
			if (andOp_17_out) begin
				global_next_block <= 2;
			end
			if (andOp_19_out) begin
				global_next_block <= 2;
			end
			if (andOp_21_out) begin
				global_next_block <= 1;
			end
			if (andOp_23_out) begin
				global_next_block <= 1;
			end
			if (andOp_6_out) begin
				global_next_block <= 1;
			end
			if (andOp_8_out) begin
				global_next_block <= 2;
			end
			if (br_0_happened_out_data) begin
				global_next_block <= 2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_128_out) begin
				global_state <= 1;
			end
			if (andOp_130_out) begin
				global_state <= 2;
			end
			if (andOp_133_out) begin
				global_state <= 3;
			end
			if (andOp_135_out) begin
				global_state <= 4;
			end
			if (andOp_137_out) begin
				global_state <= 5;
			end
			if (andOp_139_out) begin
				global_state <= 6;
			end
			if (andOp_142_out) begin
				global_state <= 2;
			end
			if (andOp_145_out) begin
				global_state <= 7;
			end
			if (andOp_147_out) begin
				global_state <= 8;
			end
			if (andOp_149_out) begin
				global_state <= 8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if (andOp_161_out) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_124_out) begin
				last_BB_reg <= 0;
			end
			if (eq_125_out) begin
				last_BB_reg <= 2;
			end
			if (eq_126_out) begin
				last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_1 <= 0;
		end else begin
			if (andOp_155_out) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

