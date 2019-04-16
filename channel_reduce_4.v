module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready);

	reg [0:0] valid_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;

	assign valid = valid_reg;
	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
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

	add call_16();

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

	add call_19();

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

	reg [0:0] andOp_2_in0;
	reg [0:0] andOp_2_in1;
	wire [0:0] andOp_2_out;
	andOp #(.WIDTH(1)) andOp_2(.in0(andOp_2_in0), .in1(andOp_2_in1), .out(andOp_2_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [0:0] notOp_3_in0;
	wire [0:0] notOp_3_out;
	notOp #(.WIDTH(1)) notOp_3(.in(notOp_3_in0), .out(notOp_3_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_4_in0;
	reg [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	reg [0:0] andOp_5_in0;
	reg [0:0] andOp_5_in1;
	wire [0:0] andOp_5_out;
	andOp #(.WIDTH(1)) andOp_5(.in0(andOp_5_in0), .in1(andOp_5_in1), .out(andOp_5_out));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] br_2_happened_in_data;
	wire [0:0] br_2_happened_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened(.in_data(br_2_happened_in_data), .out_data(br_2_happened_out_data));

	reg [0:0] notOp_7_in0;
	wire [0:0] notOp_7_out;
	notOp #(.WIDTH(1)) notOp_7(.in(notOp_7_in0), .out(notOp_7_out));

	reg [0:0] andOp_8_in0;
	reg [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	reg [0:0] notOp_9_in0;
	wire [0:0] notOp_9_out;
	notOp #(.WIDTH(1)) notOp_9(.in(notOp_9_in0), .out(notOp_9_out));

	reg [0:0] andOp_10_in0;
	reg [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [31:0] eq_12_in0;
	reg [31:0] eq_12_in1;
	wire [0:0] eq_12_out;
	eq #(.WIDTH(32)) eq_12(.in0(eq_12_in0), .in1(eq_12_in1), .out(eq_12_out));

	reg [0:0] orOp_13_in0;
	reg [0:0] orOp_13_in1;
	wire [0:0] orOp_13_out;
	orOp #(.WIDTH(1)) orOp_13(.in0(orOp_13_in0), .in1(orOp_13_in1), .out(orOp_13_out));

	reg [31:0] eq_14_in0;
	reg [31:0] eq_14_in1;
	wire [0:0] eq_14_out;
	eq #(.WIDTH(32)) eq_14(.in0(eq_14_in0), .in1(eq_14_in1), .out(eq_14_out));

	reg [0:0] orOp_15_in0;
	reg [0:0] orOp_15_in1;
	wire [0:0] orOp_15_out;
	orOp #(.WIDTH(1)) orOp_15(.in0(orOp_15_in0), .in1(orOp_15_in1), .out(orOp_15_out));

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

	reg [31:0] bb_0_predecessor_in_data;
	wire [31:0] bb_0_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor(.in_data(bb_0_predecessor_in_data), .out_data(bb_0_predecessor_out_data));

	reg [31:0] eq_30_in0;
	reg [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	reg [31:0] bb_1_predecessor_in_data;
	wire [31:0] bb_1_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor(.in_data(bb_1_predecessor_in_data), .out_data(bb_1_predecessor_out_data));

	reg [31:0] eq_31_in0;
	reg [31:0] eq_31_in1;
	wire [0:0] eq_31_out;
	eq #(.WIDTH(32)) eq_31(.in0(eq_31_in0), .in1(eq_31_in1), .out(eq_31_out));

	reg [0:0] notOp_32_in0;
	wire [0:0] notOp_32_out;
	notOp #(.WIDTH(1)) notOp_32(.in(notOp_32_in0), .out(notOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [31:0] bb_2_predecessor_in_data;
	wire [31:0] bb_2_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor(.in_data(bb_2_predecessor_in_data), .out_data(bb_2_predecessor_out_data));

	reg [31:0] eq_34_in0;
	reg [31:0] eq_34_in1;
	wire [0:0] eq_34_out;
	eq #(.WIDTH(32)) eq_34(.in0(eq_34_in0), .in1(eq_34_in1), .out(eq_34_out));

	reg [0:0] notOp_35_in0;
	wire [0:0] notOp_35_out;
	notOp #(.WIDTH(1)) notOp_35(.in(notOp_35_in0), .out(notOp_35_out));

	reg [0:0] andOp_36_in0;
	reg [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	reg [31:0] eq_37_in0;
	reg [31:0] eq_37_in1;
	wire [0:0] eq_37_out;
	eq #(.WIDTH(32)) eq_37(.in0(eq_37_in0), .in1(eq_37_in1), .out(eq_37_out));

	reg [0:0] andOp_38_in0;
	reg [0:0] andOp_38_in1;
	wire [0:0] andOp_38_out;
	andOp #(.WIDTH(1)) andOp_38(.in0(andOp_38_in0), .in1(andOp_38_in1), .out(andOp_38_out));

	reg [31:0] eq_39_in0;
	reg [31:0] eq_39_in1;
	wire [0:0] eq_39_out;
	eq #(.WIDTH(32)) eq_39(.in0(eq_39_in0), .in1(eq_39_in1), .out(eq_39_out));

	reg [0:0] andOp_40_in0;
	reg [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	reg [31:0] eq_41_in0;
	reg [31:0] eq_41_in1;
	wire [0:0] eq_41_out;
	eq #(.WIDTH(32)) eq_41(.in0(eq_41_in0), .in1(eq_41_in1), .out(eq_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [31:0] eq_43_in0;
	reg [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	reg [0:0] andOp_44_in0;
	reg [0:0] andOp_44_in1;
	wire [0:0] andOp_44_out;
	andOp #(.WIDTH(1)) andOp_44(.in0(andOp_44_in0), .in1(andOp_44_in1), .out(andOp_44_out));

	reg [31:0] eq_45_in0;
	reg [31:0] eq_45_in1;
	wire [0:0] eq_45_out;
	eq #(.WIDTH(32)) eq_45(.in0(eq_45_in0), .in1(eq_45_in1), .out(eq_45_out));

	reg [0:0] andOp_46_in0;
	reg [0:0] andOp_46_in1;
	wire [0:0] andOp_46_out;
	andOp #(.WIDTH(1)) andOp_46(.in0(andOp_46_in0), .in1(andOp_46_in1), .out(andOp_46_out));

	reg [31:0] andOp_47_in0;
	reg [31:0] andOp_47_in1;
	wire [31:0] andOp_47_out;
	andOp #(.WIDTH(32)) andOp_47(.in0(andOp_47_in0), .in1(andOp_47_in1), .out(andOp_47_out));

	reg [31:0] eq_48_in0;
	reg [31:0] eq_48_in1;
	wire [0:0] eq_48_out;
	eq #(.WIDTH(32)) eq_48(.in0(eq_48_in0), .in1(eq_48_in1), .out(eq_48_out));

	reg [0:0] andOp_49_in0;
	reg [0:0] andOp_49_in1;
	wire [0:0] andOp_49_out;
	andOp #(.WIDTH(1)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

	reg [31:0] eq_50_in0;
	reg [31:0] eq_50_in1;
	wire [0:0] eq_50_out;
	eq #(.WIDTH(32)) eq_50(.in0(eq_50_in0), .in1(eq_50_in1), .out(eq_50_out));

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

	reg [31:0] andOp_57_in0;
	reg [31:0] andOp_57_in1;
	wire [31:0] andOp_57_out;
	andOp #(.WIDTH(32)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

	reg [31:0] eq_58_in0;
	reg [31:0] eq_58_in1;
	wire [0:0] eq_58_out;
	eq #(.WIDTH(32)) eq_58(.in0(eq_58_in0), .in1(eq_58_in1), .out(eq_58_out));

	reg [0:0] andOp_59_in0;
	reg [0:0] andOp_59_in1;
	wire [0:0] andOp_59_out;
	andOp #(.WIDTH(1)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	reg [31:0] andOp_60_in0;
	reg [31:0] andOp_60_in1;
	wire [31:0] andOp_60_out;
	andOp #(.WIDTH(32)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	reg [31:0] eq_61_in0;
	reg [31:0] eq_61_in1;
	wire [0:0] eq_61_out;
	eq #(.WIDTH(32)) eq_61(.in0(eq_61_in0), .in1(eq_61_in1), .out(eq_61_out));

	reg [0:0] andOp_62_in0;
	reg [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	reg [31:0] andOp_63_in0;
	reg [31:0] andOp_63_in1;
	wire [31:0] andOp_63_out;
	andOp #(.WIDTH(32)) andOp_63(.in0(andOp_63_in0), .in1(andOp_63_in1), .out(andOp_63_out));

	reg [31:0] eq_64_in0;
	reg [31:0] eq_64_in1;
	wire [0:0] eq_64_out;
	eq #(.WIDTH(32)) eq_64(.in0(eq_64_in0), .in1(eq_64_in1), .out(eq_64_out));

	reg [0:0] andOp_65_in0;
	reg [0:0] andOp_65_in1;
	wire [0:0] andOp_65_out;
	andOp #(.WIDTH(1)) andOp_65(.in0(andOp_65_in0), .in1(andOp_65_in1), .out(andOp_65_out));

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

	reg [0:0] andOp_69_in0;
	reg [0:0] andOp_69_in1;
	wire [0:0] andOp_69_out;
	andOp #(.WIDTH(1)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	reg [31:0] eq_70_in0;
	reg [31:0] eq_70_in1;
	wire [0:0] eq_70_out;
	eq #(.WIDTH(32)) eq_70(.in0(eq_70_in0), .in1(eq_70_in1), .out(eq_70_out));

	reg [0:0] andOp_71_in0;
	reg [0:0] andOp_71_in1;
	wire [0:0] andOp_71_out;
	andOp #(.WIDTH(1)) andOp_71(.in0(andOp_71_in0), .in1(andOp_71_in1), .out(andOp_71_out));

	reg [31:0] eq_72_in0;
	reg [31:0] eq_72_in1;
	wire [0:0] eq_72_out;
	eq #(.WIDTH(32)) eq_72(.in0(eq_72_in0), .in1(eq_72_in1), .out(eq_72_out));

	reg [0:0] andOp_73_in0;
	reg [0:0] andOp_73_in1;
	wire [0:0] andOp_73_out;
	andOp #(.WIDTH(1)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	reg [0:0] andOp_75_in0;
	reg [0:0] andOp_75_in1;
	wire [0:0] andOp_75_out;
	andOp #(.WIDTH(1)) andOp_75(.in0(andOp_75_in0), .in1(andOp_75_in1), .out(andOp_75_out));

	reg [31:0] andOp_76_in0;
	reg [31:0] andOp_76_in1;
	wire [31:0] andOp_76_out;
	andOp #(.WIDTH(32)) andOp_76(.in0(andOp_76_in0), .in1(andOp_76_in1), .out(andOp_76_out));

	reg [31:0] eq_77_in0;
	reg [31:0] eq_77_in1;
	wire [0:0] eq_77_out;
	eq #(.WIDTH(32)) eq_77(.in0(eq_77_in0), .in1(eq_77_in1), .out(eq_77_out));

	reg [0:0] andOp_78_in0;
	reg [0:0] andOp_78_in1;
	wire [0:0] andOp_78_out;
	andOp #(.WIDTH(1)) andOp_78(.in0(andOp_78_in0), .in1(andOp_78_in1), .out(andOp_78_out));

	reg [31:0] andOp_79_in0;
	reg [31:0] andOp_79_in1;
	wire [31:0] andOp_79_out;
	andOp #(.WIDTH(32)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	reg [31:0] eq_80_in0;
	reg [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

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

	reg [0:0] andOp_91_in0;
	reg [0:0] andOp_91_in1;
	wire [0:0] andOp_91_out;
	andOp #(.WIDTH(1)) andOp_91(.in0(andOp_91_in0), .in1(andOp_91_in1), .out(andOp_91_out));

	reg [31:0] eq_92_in0;
	reg [31:0] eq_92_in1;
	wire [0:0] eq_92_out;
	eq #(.WIDTH(32)) eq_92(.in0(eq_92_in0), .in1(eq_92_in1), .out(eq_92_out));

	reg [0:0] andOp_93_in0;
	reg [0:0] andOp_93_in1;
	wire [0:0] andOp_93_out;
	andOp #(.WIDTH(1)) andOp_93(.in0(andOp_93_in0), .in1(andOp_93_in1), .out(andOp_93_out));

	reg [0:0] notOp_94_in0;
	wire [0:0] notOp_94_out;
	notOp #(.WIDTH(1)) notOp_94(.in(notOp_94_in0), .out(notOp_94_out));

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

	reg [0:0] andOp_99_in0;
	reg [0:0] andOp_99_in1;
	wire [0:0] andOp_99_out;
	andOp #(.WIDTH(1)) andOp_99(.in0(andOp_99_in0), .in1(andOp_99_in1), .out(andOp_99_out));

	reg [0:0] notOp_100_in0;
	wire [0:0] notOp_100_out;
	notOp #(.WIDTH(1)) notOp_100(.in(notOp_100_in0), .out(notOp_100_out));

	reg [0:0] andOp_101_in0;
	reg [0:0] andOp_101_in1;
	wire [0:0] andOp_101_out;
	andOp #(.WIDTH(1)) andOp_101(.in0(andOp_101_in0), .in1(andOp_101_in1), .out(andOp_101_out));

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

	reg [0:0] andOp_106_in0;
	reg [0:0] andOp_106_in1;
	wire [0:0] andOp_106_out;
	andOp #(.WIDTH(1)) andOp_106(.in0(andOp_106_in0), .in1(andOp_106_in1), .out(andOp_106_out));

	reg [31:0] eq_107_in0;
	reg [31:0] eq_107_in1;
	wire [0:0] eq_107_out;
	eq #(.WIDTH(32)) eq_107(.in0(eq_107_in0), .in1(eq_107_in1), .out(eq_107_out));

	reg [31:0] andOp_108_in0;
	reg [31:0] andOp_108_in1;
	wire [31:0] andOp_108_out;
	andOp #(.WIDTH(32)) andOp_108(.in0(andOp_108_in0), .in1(andOp_108_in1), .out(andOp_108_out));

	reg [31:0] eq_109_in0;
	reg [31:0] eq_109_in1;
	wire [0:0] eq_109_out;
	eq #(.WIDTH(32)) eq_109(.in0(eq_109_in0), .in1(eq_109_in1), .out(eq_109_out));

	reg [0:0] andOp_110_in0;
	reg [0:0] andOp_110_in1;
	wire [0:0] andOp_110_out;
	andOp #(.WIDTH(1)) andOp_110(.in0(andOp_110_in0), .in1(andOp_110_in1), .out(andOp_110_out));

	reg [0:0] andOp_111_in0;
	reg [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [31:0] eq_112_in0;
	reg [31:0] eq_112_in1;
	wire [0:0] eq_112_out;
	eq #(.WIDTH(32)) eq_112(.in0(eq_112_in0), .in1(eq_112_in1), .out(eq_112_out));

	reg [31:0] andOp_113_in0;
	reg [31:0] andOp_113_in1;
	wire [31:0] andOp_113_out;
	andOp #(.WIDTH(32)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	reg [31:0] andOp_114_in0;
	reg [31:0] andOp_114_in1;
	wire [31:0] andOp_114_out;
	andOp #(.WIDTH(32)) andOp_114(.in0(andOp_114_in0), .in1(andOp_114_in1), .out(andOp_114_out));

	reg [31:0] eq_115_in0;
	reg [31:0] eq_115_in1;
	wire [0:0] eq_115_out;
	eq #(.WIDTH(32)) eq_115(.in0(eq_115_in0), .in1(eq_115_in1), .out(eq_115_out));

	reg [0:0] andOp_116_in0;
	reg [0:0] andOp_116_in1;
	wire [0:0] andOp_116_out;
	andOp #(.WIDTH(1)) andOp_116(.in0(andOp_116_in0), .in1(andOp_116_in1), .out(andOp_116_out));

	reg [0:0] andOp_117_in0;
	reg [0:0] andOp_117_in1;
	wire [0:0] andOp_117_out;
	andOp #(.WIDTH(1)) andOp_117(.in0(andOp_117_in0), .in1(andOp_117_in1), .out(andOp_117_out));

	reg [31:0] eq_118_in0;
	reg [31:0] eq_118_in1;
	wire [0:0] eq_118_out;
	eq #(.WIDTH(32)) eq_118(.in0(eq_118_in0), .in1(eq_118_in1), .out(eq_118_out));

	reg [31:0] andOp_119_in0;
	reg [31:0] andOp_119_in1;
	wire [31:0] andOp_119_out;
	andOp #(.WIDTH(32)) andOp_119(.in0(andOp_119_in0), .in1(andOp_119_in1), .out(andOp_119_out));

	reg [31:0] eq_120_in0;
	reg [31:0] eq_120_in1;
	wire [0:0] eq_120_out;
	eq #(.WIDTH(32)) eq_120(.in0(eq_120_in0), .in1(eq_120_in1), .out(eq_120_out));

	reg [0:0] andOp_121_in0;
	reg [0:0] andOp_121_in1;
	wire [0:0] andOp_121_out;
	andOp #(.WIDTH(1)) andOp_121(.in0(andOp_121_in0), .in1(andOp_121_in1), .out(andOp_121_out));

	reg [0:0] andOp_122_in0;
	reg [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	reg [31:0] eq_123_in0;
	reg [31:0] eq_123_in1;
	wire [0:0] eq_123_out;
	eq #(.WIDTH(32)) eq_123(.in0(eq_123_in0), .in1(eq_123_in1), .out(eq_123_out));

	reg [31:0] andOp_124_in0;
	reg [31:0] andOp_124_in1;
	wire [31:0] andOp_124_out;
	andOp #(.WIDTH(32)) andOp_124(.in0(andOp_124_in0), .in1(andOp_124_in1), .out(andOp_124_out));

	reg [0:0] notOp_125_in0;
	wire [0:0] notOp_125_out;
	notOp #(.WIDTH(1)) notOp_125(.in(notOp_125_in0), .out(notOp_125_out));

	reg [31:0] eq_126_in0;
	reg [31:0] eq_126_in1;
	wire [0:0] eq_126_out;
	eq #(.WIDTH(32)) eq_126(.in0(eq_126_in0), .in1(eq_126_in1), .out(eq_126_out));

	reg [0:0] andOp_127_in0;
	reg [0:0] andOp_127_in1;
	wire [0:0] andOp_127_out;
	andOp #(.WIDTH(1)) andOp_127(.in0(andOp_127_in0), .in1(andOp_127_in1), .out(andOp_127_out));

	reg [0:0] andOp_128_in0;
	reg [0:0] andOp_128_in1;
	wire [0:0] andOp_128_out;
	andOp #(.WIDTH(1)) andOp_128(.in0(andOp_128_in0), .in1(andOp_128_in1), .out(andOp_128_out));

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

	reg [0:0] andOp_132_in0;
	reg [0:0] andOp_132_in1;
	wire [0:0] andOp_132_out;
	andOp #(.WIDTH(1)) andOp_132(.in0(andOp_132_in0), .in1(andOp_132_in1), .out(andOp_132_out));

	reg [0:0] andOp_133_in0;
	reg [0:0] andOp_133_in1;
	wire [0:0] andOp_133_out;
	andOp #(.WIDTH(1)) andOp_133(.in0(andOp_133_in0), .in1(andOp_133_in1), .out(andOp_133_out));

	reg [31:0] eq_134_in0;
	reg [31:0] eq_134_in1;
	wire [0:0] eq_134_out;
	eq #(.WIDTH(32)) eq_134(.in0(eq_134_in0), .in1(eq_134_in1), .out(eq_134_out));

	reg [31:0] andOp_135_in0;
	reg [31:0] andOp_135_in1;
	wire [31:0] andOp_135_out;
	andOp #(.WIDTH(32)) andOp_135(.in0(andOp_135_in0), .in1(andOp_135_in1), .out(andOp_135_out));

	reg [31:0] andOp_136_in0;
	reg [31:0] andOp_136_in1;
	wire [31:0] andOp_136_out;
	andOp #(.WIDTH(32)) andOp_136(.in0(andOp_136_in0), .in1(andOp_136_in1), .out(andOp_136_out));

	reg [31:0] eq_137_in0;
	reg [31:0] eq_137_in1;
	wire [0:0] eq_137_out;
	eq #(.WIDTH(32)) eq_137(.in0(eq_137_in0), .in1(eq_137_in1), .out(eq_137_out));

	reg [0:0] andOp_138_in0;
	reg [0:0] andOp_138_in1;
	wire [0:0] andOp_138_out;
	andOp #(.WIDTH(1)) andOp_138(.in0(andOp_138_in0), .in1(andOp_138_in1), .out(andOp_138_out));

	reg [0:0] andOp_139_in0;
	reg [0:0] andOp_139_in1;
	wire [0:0] andOp_139_out;
	andOp #(.WIDTH(1)) andOp_139(.in0(andOp_139_in0), .in1(andOp_139_in1), .out(andOp_139_out));

	reg [31:0] eq_140_in0;
	reg [31:0] eq_140_in1;
	wire [0:0] eq_140_out;
	eq #(.WIDTH(32)) eq_140(.in0(eq_140_in0), .in1(eq_140_in1), .out(eq_140_out));

	reg [31:0] andOp_141_in0;
	reg [31:0] andOp_141_in1;
	wire [31:0] andOp_141_out;
	andOp #(.WIDTH(32)) andOp_141(.in0(andOp_141_in0), .in1(andOp_141_in1), .out(andOp_141_out));

	reg [31:0] eq_142_in0;
	reg [31:0] eq_142_in1;
	wire [0:0] eq_142_out;
	eq #(.WIDTH(32)) eq_142(.in0(eq_142_in0), .in1(eq_142_in1), .out(eq_142_out));

	reg [0:0] andOp_143_in0;
	reg [0:0] andOp_143_in1;
	wire [0:0] andOp_143_out;
	andOp #(.WIDTH(1)) andOp_143(.in0(andOp_143_in0), .in1(andOp_143_in1), .out(andOp_143_out));

	reg [0:0] andOp_144_in0;
	reg [0:0] andOp_144_in1;
	wire [0:0] andOp_144_out;
	andOp #(.WIDTH(1)) andOp_144(.in0(andOp_144_in0), .in1(andOp_144_in1), .out(andOp_144_out));

	reg [31:0] eq_145_in0;
	reg [31:0] eq_145_in1;
	wire [0:0] eq_145_out;
	eq #(.WIDTH(32)) eq_145(.in0(eq_145_in0), .in1(eq_145_in1), .out(eq_145_out));

	reg [31:0] andOp_146_in0;
	reg [31:0] andOp_146_in1;
	wire [31:0] andOp_146_out;
	andOp #(.WIDTH(32)) andOp_146(.in0(andOp_146_in0), .in1(andOp_146_in1), .out(andOp_146_out));

	reg [31:0] eq_147_in0;
	reg [31:0] eq_147_in1;
	wire [0:0] eq_147_out;
	eq #(.WIDTH(32)) eq_147(.in0(eq_147_in0), .in1(eq_147_in1), .out(eq_147_out));

	reg [0:0] andOp_148_in0;
	reg [0:0] andOp_148_in1;
	wire [0:0] andOp_148_out;
	andOp #(.WIDTH(1)) andOp_148(.in0(andOp_148_in0), .in1(andOp_148_in1), .out(andOp_148_out));

	reg [31:0] eq_149_in0;
	reg [31:0] eq_149_in1;
	wire [0:0] eq_149_out;
	eq #(.WIDTH(32)) eq_149(.in0(eq_149_in0), .in1(eq_149_in1), .out(eq_149_out));

	reg [0:0] andOp_150_in0;
	reg [0:0] andOp_150_in1;
	wire [0:0] andOp_150_out;
	andOp #(.WIDTH(1)) andOp_150(.in0(andOp_150_in0), .in1(andOp_150_in1), .out(andOp_150_out));

	reg [31:0] eq_151_in0;
	reg [31:0] eq_151_in1;
	wire [0:0] eq_151_out;
	eq #(.WIDTH(32)) eq_151(.in0(eq_151_in0), .in1(eq_151_in1), .out(eq_151_out));

	reg [0:0] andOp_152_in0;
	reg [0:0] andOp_152_in1;
	wire [0:0] andOp_152_out;
	andOp #(.WIDTH(1)) andOp_152(.in0(andOp_152_in0), .in1(andOp_152_in1), .out(andOp_152_out));

	reg [31:0] eq_153_in0;
	reg [31:0] eq_153_in1;
	wire [0:0] eq_153_out;
	eq #(.WIDTH(32)) eq_153(.in0(eq_153_in0), .in1(eq_153_in1), .out(eq_153_out));

	reg [0:0] andOp_154_in0;
	reg [0:0] andOp_154_in1;
	wire [0:0] andOp_154_out;
	andOp #(.WIDTH(1)) andOp_154(.in0(andOp_154_in0), .in1(andOp_154_in1), .out(andOp_154_out));

	reg [31:0] eq_155_in0;
	reg [31:0] eq_155_in1;
	wire [0:0] eq_155_out;
	eq #(.WIDTH(32)) eq_155(.in0(eq_155_in0), .in1(eq_155_in1), .out(eq_155_out));

	reg [0:0] andOp_156_in0;
	reg [0:0] andOp_156_in1;
	wire [0:0] andOp_156_out;
	andOp #(.WIDTH(1)) andOp_156(.in0(andOp_156_in0), .in1(andOp_156_in1), .out(andOp_156_out));

	reg [31:0] eq_157_in0;
	reg [31:0] eq_157_in1;
	wire [0:0] eq_157_out;
	eq #(.WIDTH(32)) eq_157(.in0(eq_157_in0), .in1(eq_157_in1), .out(eq_157_out));

	reg [0:0] andOp_158_in0;
	reg [0:0] andOp_158_in1;
	wire [0:0] andOp_158_out;
	andOp #(.WIDTH(1)) andOp_158(.in0(andOp_158_in0), .in1(andOp_158_in1), .out(andOp_158_out));

	reg [31:0] eq_159_in0;
	reg [31:0] eq_159_in1;
	wire [0:0] eq_159_out;
	eq #(.WIDTH(32)) eq_159(.in0(eq_159_in0), .in1(eq_159_in1), .out(eq_159_out));

	reg [0:0] andOp_160_in0;
	reg [0:0] andOp_160_in1;
	wire [0:0] andOp_160_out;
	andOp #(.WIDTH(1)) andOp_160(.in0(andOp_160_in0), .in1(andOp_160_in1), .out(andOp_160_out));

	reg [31:0] eq_161_in0;
	reg [31:0] eq_161_in1;
	wire [0:0] eq_161_out;
	eq #(.WIDTH(32)) eq_161(.in0(eq_161_in0), .in1(eq_161_in1), .out(eq_161_out));

	reg [0:0] andOp_162_in0;
	reg [0:0] andOp_162_in1;
	wire [0:0] andOp_162_out;
	andOp #(.WIDTH(1)) andOp_162(.in0(andOp_162_in0), .in1(andOp_162_in1), .out(andOp_162_out));

	reg [31:0] andOp_163_in0;
	reg [31:0] andOp_163_in1;
	wire [31:0] andOp_163_out;
	andOp #(.WIDTH(32)) andOp_163(.in0(andOp_163_in0), .in1(andOp_163_in1), .out(andOp_163_out));

	reg [31:0] andOp_164_in0;
	reg [31:0] andOp_164_in1;
	wire [31:0] andOp_164_out;
	andOp #(.WIDTH(32)) andOp_164(.in0(andOp_164_in0), .in1(andOp_164_in1), .out(andOp_164_out));

	reg [31:0] eq_165_in0;
	reg [31:0] eq_165_in1;
	wire [0:0] eq_165_out;
	eq #(.WIDTH(32)) eq_165(.in0(eq_165_in0), .in1(eq_165_in1), .out(eq_165_out));

	reg [0:0] andOp_166_in0;
	reg [0:0] andOp_166_in1;
	wire [0:0] andOp_166_out;
	andOp #(.WIDTH(1)) andOp_166(.in0(andOp_166_in0), .in1(andOp_166_in1), .out(andOp_166_out));

	reg [31:0] eq_167_in0;
	reg [31:0] eq_167_in1;
	wire [0:0] eq_167_out;
	eq #(.WIDTH(32)) eq_167(.in0(eq_167_in0), .in1(eq_167_in1), .out(eq_167_out));

	reg [0:0] andOp_168_in0;
	reg [0:0] andOp_168_in1;
	wire [0:0] andOp_168_out;
	andOp #(.WIDTH(1)) andOp_168(.in0(andOp_168_in0), .in1(andOp_168_in1), .out(andOp_168_out));

	reg [31:0] andOp_169_in0;
	reg [31:0] andOp_169_in1;
	wire [31:0] andOp_169_out;
	andOp #(.WIDTH(32)) andOp_169(.in0(andOp_169_in0), .in1(andOp_169_in1), .out(andOp_169_out));

	reg [31:0] andOp_170_in0;
	reg [31:0] andOp_170_in1;
	wire [31:0] andOp_170_out;
	andOp #(.WIDTH(32)) andOp_170(.in0(andOp_170_in0), .in1(andOp_170_in1), .out(andOp_170_out));

	reg [31:0] eq_171_in0;
	reg [31:0] eq_171_in1;
	wire [0:0] eq_171_out;
	eq #(.WIDTH(32)) eq_171(.in0(eq_171_in0), .in1(eq_171_in1), .out(eq_171_out));

	reg [0:0] andOp_172_in0;
	reg [0:0] andOp_172_in1;
	wire [0:0] andOp_172_out;
	andOp #(.WIDTH(1)) andOp_172(.in0(andOp_172_in0), .in1(andOp_172_in1), .out(andOp_172_out));

	reg [31:0] eq_173_in0;
	reg [31:0] eq_173_in1;
	wire [0:0] eq_173_out;
	eq #(.WIDTH(32)) eq_173(.in0(eq_173_in0), .in1(eq_173_in1), .out(eq_173_out));

	reg [0:0] andOp_174_in0;
	reg [0:0] andOp_174_in1;
	wire [0:0] andOp_174_out;
	andOp #(.WIDTH(1)) andOp_174(.in0(andOp_174_in0), .in1(andOp_174_in1), .out(andOp_174_out));

	reg [31:0] andOp_175_in0;
	reg [31:0] andOp_175_in1;
	wire [31:0] andOp_175_out;
	andOp #(.WIDTH(32)) andOp_175(.in0(andOp_175_in0), .in1(andOp_175_in1), .out(andOp_175_out));

	reg [31:0] andOp_176_in0;
	reg [31:0] andOp_176_in1;
	wire [31:0] andOp_176_out;
	andOp #(.WIDTH(32)) andOp_176(.in0(andOp_176_in0), .in1(andOp_176_in1), .out(andOp_176_out));

	reg [31:0] eq_177_in0;
	reg [31:0] eq_177_in1;
	wire [0:0] eq_177_out;
	eq #(.WIDTH(32)) eq_177(.in0(eq_177_in0), .in1(eq_177_in1), .out(eq_177_out));

	reg [0:0] andOp_178_in0;
	reg [0:0] andOp_178_in1;
	wire [0:0] andOp_178_out;
	andOp #(.WIDTH(1)) andOp_178(.in0(andOp_178_in0), .in1(andOp_178_in1), .out(andOp_178_out));

	reg [31:0] eq_179_in0;
	reg [31:0] eq_179_in1;
	wire [0:0] eq_179_out;
	eq #(.WIDTH(32)) eq_179(.in0(eq_179_in0), .in1(eq_179_in1), .out(eq_179_out));

	reg [0:0] andOp_180_in0;
	reg [0:0] andOp_180_in1;
	wire [0:0] andOp_180_out;
	andOp #(.WIDTH(1)) andOp_180(.in0(andOp_180_in0), .in1(andOp_180_in1), .out(andOp_180_out));

	reg [31:0] eq_181_in0;
	reg [31:0] eq_181_in1;
	wire [0:0] eq_181_out;
	eq #(.WIDTH(32)) eq_181(.in0(eq_181_in0), .in1(eq_181_in1), .out(eq_181_out));

	reg [0:0] andOp_182_in0;
	reg [0:0] andOp_182_in1;
	wire [0:0] andOp_182_out;
	andOp #(.WIDTH(1)) andOp_182(.in0(andOp_182_in0), .in1(andOp_182_in1), .out(andOp_182_out));

	reg [31:0] eq_183_in0;
	reg [31:0] eq_183_in1;
	wire [0:0] eq_183_out;
	eq #(.WIDTH(32)) eq_183(.in0(eq_183_in0), .in1(eq_183_in1), .out(eq_183_out));

	reg [0:0] andOp_184_in0;
	reg [0:0] andOp_184_in1;
	wire [0:0] andOp_184_out;
	andOp #(.WIDTH(1)) andOp_184(.in0(andOp_184_in0), .in1(andOp_184_in1), .out(andOp_184_out));

	reg [31:0] eq_185_in0;
	reg [31:0] eq_185_in1;
	wire [0:0] eq_185_out;
	eq #(.WIDTH(32)) eq_185(.in0(eq_185_in0), .in1(eq_185_in1), .out(eq_185_out));

	reg [0:0] andOp_186_in0;
	reg [0:0] andOp_186_in1;
	wire [0:0] andOp_186_out;
	andOp #(.WIDTH(1)) andOp_186(.in0(andOp_186_in0), .in1(andOp_186_in1), .out(andOp_186_out));

	reg [31:0] eq_187_in0;
	reg [31:0] eq_187_in1;
	wire [0:0] eq_187_out;
	eq #(.WIDTH(32)) eq_187(.in0(eq_187_in0), .in1(eq_187_in1), .out(eq_187_out));

	reg [0:0] andOp_188_in0;
	reg [0:0] andOp_188_in1;
	wire [0:0] andOp_188_out;
	andOp #(.WIDTH(1)) andOp_188(.in0(andOp_188_in0), .in1(andOp_188_in1), .out(andOp_188_out));

	reg [31:0] eq_189_in0;
	reg [31:0] eq_189_in1;
	wire [0:0] eq_189_out;
	eq #(.WIDTH(32)) eq_189(.in0(eq_189_in0), .in1(eq_189_in1), .out(eq_189_out));

	reg [0:0] andOp_190_in0;
	reg [0:0] andOp_190_in1;
	wire [0:0] andOp_190_out;
	andOp #(.WIDTH(1)) andOp_190(.in0(andOp_190_in0), .in1(andOp_190_in1), .out(andOp_190_out));

	reg [31:0] eq_191_in0;
	reg [31:0] eq_191_in1;
	wire [0:0] eq_191_out;
	eq #(.WIDTH(32)) eq_191(.in0(eq_191_in0), .in1(eq_191_in1), .out(eq_191_out));

	reg [0:0] andOp_192_in0;
	reg [0:0] andOp_192_in1;
	wire [0:0] andOp_192_out;
	andOp #(.WIDTH(1)) andOp_192(.in0(andOp_192_in0), .in1(andOp_192_in1), .out(andOp_192_out));

	reg [31:0] eq_193_in0;
	reg [31:0] eq_193_in1;
	wire [0:0] eq_193_out;
	eq #(.WIDTH(32)) eq_193(.in0(eq_193_in0), .in1(eq_193_in1), .out(eq_193_out));

	reg [0:0] andOp_194_in0;
	reg [0:0] andOp_194_in1;
	wire [0:0] andOp_194_out;
	andOp #(.WIDTH(1)) andOp_194(.in0(andOp_194_in0), .in1(andOp_194_in1), .out(andOp_194_out));

	reg [31:0] eq_195_in0;
	reg [31:0] eq_195_in1;
	wire [0:0] eq_195_out;
	eq #(.WIDTH(32)) eq_195(.in0(eq_195_in0), .in1(eq_195_in1), .out(eq_195_out));

	reg [0:0] andOp_196_in0;
	reg [0:0] andOp_196_in1;
	wire [0:0] andOp_196_out;
	andOp #(.WIDTH(1)) andOp_196(.in0(andOp_196_in0), .in1(andOp_196_in1), .out(andOp_196_out));

	reg [31:0] eq_197_in0;
	reg [31:0] eq_197_in1;
	wire [0:0] eq_197_out;
	eq #(.WIDTH(32)) eq_197(.in0(eq_197_in0), .in1(eq_197_in1), .out(eq_197_out));

	reg [0:0] andOp_198_in0;
	reg [0:0] andOp_198_in1;
	wire [0:0] andOp_198_out;
	andOp #(.WIDTH(1)) andOp_198(.in0(andOp_198_in0), .in1(andOp_198_in1), .out(andOp_198_out));

	reg [31:0] eq_199_in0;
	reg [31:0] eq_199_in1;
	wire [0:0] eq_199_out;
	eq #(.WIDTH(32)) eq_199(.in0(eq_199_in0), .in1(eq_199_in1), .out(eq_199_out));

	reg [0:0] andOp_200_in0;
	reg [0:0] andOp_200_in1;
	wire [0:0] andOp_200_out;
	andOp #(.WIDTH(1)) andOp_200(.in0(andOp_200_in0), .in1(andOp_200_in1), .out(andOp_200_out));

	reg [31:0] eq_201_in0;
	reg [31:0] eq_201_in1;
	wire [0:0] eq_201_out;
	eq #(.WIDTH(32)) eq_201(.in0(eq_201_in0), .in1(eq_201_in1), .out(eq_201_out));

	reg [0:0] andOp_202_in0;
	reg [0:0] andOp_202_in1;
	wire [0:0] andOp_202_out;
	andOp #(.WIDTH(1)) andOp_202(.in0(andOp_202_in0), .in1(andOp_202_in1), .out(andOp_202_out));

	reg [31:0] eq_203_in0;
	reg [31:0] eq_203_in1;
	wire [0:0] eq_203_out;
	eq #(.WIDTH(32)) eq_203(.in0(eq_203_in0), .in1(eq_203_in1), .out(eq_203_out));

	reg [0:0] andOp_204_in0;
	reg [0:0] andOp_204_in1;
	wire [0:0] andOp_204_out;
	andOp #(.WIDTH(1)) andOp_204(.in0(andOp_204_in0), .in1(andOp_204_in1), .out(andOp_204_out));

	reg [31:0] eq_205_in0;
	reg [31:0] eq_205_in1;
	wire [0:0] eq_205_out;
	eq #(.WIDTH(32)) eq_205(.in0(eq_205_in0), .in1(eq_205_in1), .out(eq_205_out));

	reg [0:0] andOp_206_in0;
	reg [0:0] andOp_206_in1;
	wire [0:0] andOp_206_out;
	andOp #(.WIDTH(1)) andOp_206(.in0(andOp_206_in0), .in1(andOp_206_in1), .out(andOp_206_out));

	reg [31:0] eq_207_in0;
	reg [31:0] eq_207_in1;
	wire [0:0] eq_207_out;
	eq #(.WIDTH(32)) eq_207(.in0(eq_207_in0), .in1(eq_207_in1), .out(eq_207_out));

	reg [0:0] andOp_208_in0;
	reg [0:0] andOp_208_in1;
	wire [0:0] andOp_208_out;
	andOp #(.WIDTH(1)) andOp_208(.in0(andOp_208_in0), .in1(andOp_208_in1), .out(andOp_208_out));

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
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	always @(*) begin
		andOp_10_in0 = valid ? andOp_6_out : andOp_6_out;
		andOp_10_in1 = valid ? notOp_9_out : notOp_9_out;
	end
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	always @(*) begin
		andOp_101_in0 = valid ? notOp_100_out : notOp_100_out;
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
		andOp_105_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_105_in1 = valid ? eq_104_out : eq_104_out;
	end
	// controller for andOp_106.andOp_106_in0
	// controller for andOp_106.andOp_106_in1
	// Insensitive connections
	always @(*) begin
		andOp_106_in0 = valid ? andOp_105_out : andOp_105_out;
		andOp_106_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_108.andOp_108_in0
	// controller for andOp_108.andOp_108_in1
	// Insensitive connections
	always @(*) begin
		andOp_108_in0 = valid ? eq_107_out : eq_107_out;
		andOp_108_in1 = valid ? andOp_106_out : andOp_106_out;
	end
	// controller for andOp_110.andOp_110_in0
	// controller for andOp_110.andOp_110_in1
	// Insensitive connections
	always @(*) begin
		andOp_110_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_110_in1 = valid ? eq_109_out : eq_109_out;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? andOp_110_out : andOp_110_out;
		andOp_111_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? eq_112_out : eq_112_out;
		andOp_113_in1 = valid ? andOp_111_out : andOp_111_out;
	end
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	always @(*) begin
		andOp_114_in0 = valid ? andOp_113_out : andOp_113_out;
		andOp_114_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_116.andOp_116_in0
	// controller for andOp_116.andOp_116_in1
	// Insensitive connections
	always @(*) begin
		andOp_116_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_116_in1 = valid ? eq_115_out : eq_115_out;
	end
	// controller for andOp_117.andOp_117_in0
	// controller for andOp_117.andOp_117_in1
	// Insensitive connections
	always @(*) begin
		andOp_117_in0 = valid ? andOp_116_out : andOp_116_out;
		andOp_117_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? eq_118_out : eq_118_out;
		andOp_119_in1 = valid ? andOp_117_out : andOp_117_out;
	end
	// controller for andOp_121.andOp_121_in0
	// controller for andOp_121.andOp_121_in1
	// Insensitive connections
	always @(*) begin
		andOp_121_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_121_in1 = valid ? eq_120_out : eq_120_out;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? andOp_121_out : andOp_121_out;
		andOp_122_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_124.andOp_124_in0
	// controller for andOp_124.andOp_124_in1
	// Insensitive connections
	always @(*) begin
		andOp_124_in0 = valid ? eq_123_out : eq_123_out;
		andOp_124_in1 = valid ? andOp_122_out : andOp_122_out;
	end
	// controller for andOp_127.andOp_127_in0
	// controller for andOp_127.andOp_127_in1
	// Insensitive connections
	always @(*) begin
		andOp_127_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_127_in1 = valid ? eq_126_out : eq_126_out;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? andOp_127_out : andOp_127_out;
		andOp_128_in1 = valid ? notOp_125_out : notOp_125_out;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? eq_129_out : eq_129_out;
		andOp_130_in1 = valid ? andOp_128_out : andOp_128_out;
	end
	// controller for andOp_132.andOp_132_in0
	// controller for andOp_132.andOp_132_in1
	// Insensitive connections
	always @(*) begin
		andOp_132_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_132_in1 = valid ? eq_131_out : eq_131_out;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? andOp_132_out : andOp_132_out;
		andOp_133_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_135.andOp_135_in0
	// controller for andOp_135.andOp_135_in1
	// Insensitive connections
	always @(*) begin
		andOp_135_in0 = valid ? eq_134_out : eq_134_out;
		andOp_135_in1 = valid ? andOp_133_out : andOp_133_out;
	end
	// controller for andOp_136.andOp_136_in0
	// controller for andOp_136.andOp_136_in1
	// Insensitive connections
	always @(*) begin
		andOp_136_in0 = valid ? andOp_135_out : andOp_135_out;
		andOp_136_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_138.andOp_138_in0
	// controller for andOp_138.andOp_138_in1
	// Insensitive connections
	always @(*) begin
		andOp_138_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_138_in1 = valid ? eq_137_out : eq_137_out;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? andOp_138_out : andOp_138_out;
		andOp_139_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? eq_140_out : eq_140_out;
		andOp_141_in1 = valid ? andOp_139_out : andOp_139_out;
	end
	// controller for andOp_143.andOp_143_in0
	// controller for andOp_143.andOp_143_in1
	// Insensitive connections
	always @(*) begin
		andOp_143_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_143_in1 = valid ? eq_142_out : eq_142_out;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? andOp_143_out : andOp_143_out;
		andOp_144_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_146.andOp_146_in0
	// controller for andOp_146.andOp_146_in1
	// Insensitive connections
	always @(*) begin
		andOp_146_in0 = valid ? eq_145_out : eq_145_out;
		andOp_146_in1 = valid ? andOp_144_out : andOp_144_out;
	end
	// controller for andOp_148.andOp_148_in0
	// controller for andOp_148.andOp_148_in1
	// Insensitive connections
	always @(*) begin
		andOp_148_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_148_in1 = valid ? eq_147_out : eq_147_out;
	end
	// controller for andOp_150.andOp_150_in0
	// controller for andOp_150.andOp_150_in1
	// Insensitive connections
	always @(*) begin
		andOp_150_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_150_in1 = valid ? eq_149_out : eq_149_out;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_152_in1 = valid ? eq_151_out : eq_151_out;
	end
	// controller for andOp_154.andOp_154_in0
	// controller for andOp_154.andOp_154_in1
	// Insensitive connections
	always @(*) begin
		andOp_154_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_154_in1 = valid ? eq_153_out : eq_153_out;
	end
	// controller for andOp_156.andOp_156_in0
	// controller for andOp_156.andOp_156_in1
	// Insensitive connections
	always @(*) begin
		andOp_156_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_156_in1 = valid ? eq_155_out : eq_155_out;
	end
	// controller for andOp_158.andOp_158_in0
	// controller for andOp_158.andOp_158_in1
	// Insensitive connections
	always @(*) begin
		andOp_158_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_158_in1 = valid ? eq_157_out : eq_157_out;
	end
	// controller for andOp_160.andOp_160_in0
	// controller for andOp_160.andOp_160_in1
	// Insensitive connections
	always @(*) begin
		andOp_160_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_160_in1 = valid ? eq_159_out : eq_159_out;
	end
	// controller for andOp_162.andOp_162_in0
	// controller for andOp_162.andOp_162_in1
	// Insensitive connections
	always @(*) begin
		andOp_162_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_162_in1 = valid ? eq_161_out : eq_161_out;
	end
	// controller for andOp_163.andOp_163_in0
	// controller for andOp_163.andOp_163_in1
	// Insensitive connections
	always @(*) begin
		andOp_163_in0 = valid ? andOp_160_out : andOp_160_out;
		andOp_163_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_164.andOp_164_in0
	// controller for andOp_164.andOp_164_in1
	// Insensitive connections
	always @(*) begin
		andOp_164_in0 = valid ? andOp_163_out : andOp_163_out;
		andOp_164_in1 = valid ? andOp_162_out : andOp_162_out;
	end
	// controller for andOp_166.andOp_166_in0
	// controller for andOp_166.andOp_166_in1
	// Insensitive connections
	always @(*) begin
		andOp_166_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_166_in1 = valid ? eq_165_out : eq_165_out;
	end
	// controller for andOp_168.andOp_168_in0
	// controller for andOp_168.andOp_168_in1
	// Insensitive connections
	always @(*) begin
		andOp_168_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_168_in1 = valid ? eq_167_out : eq_167_out;
	end
	// controller for andOp_169.andOp_169_in0
	// controller for andOp_169.andOp_169_in1
	// Insensitive connections
	always @(*) begin
		andOp_169_in0 = valid ? andOp_166_out : andOp_166_out;
		andOp_169_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	always @(*) begin
		andOp_17_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_17_in1 = valid ? eq_16_out : eq_16_out;
	end
	// controller for andOp_170.andOp_170_in0
	// controller for andOp_170.andOp_170_in1
	// Insensitive connections
	always @(*) begin
		andOp_170_in0 = valid ? andOp_169_out : andOp_169_out;
		andOp_170_in1 = valid ? andOp_168_out : andOp_168_out;
	end
	// controller for andOp_172.andOp_172_in0
	// controller for andOp_172.andOp_172_in1
	// Insensitive connections
	always @(*) begin
		andOp_172_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_172_in1 = valid ? eq_171_out : eq_171_out;
	end
	// controller for andOp_174.andOp_174_in0
	// controller for andOp_174.andOp_174_in1
	// Insensitive connections
	always @(*) begin
		andOp_174_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_174_in1 = valid ? eq_173_out : eq_173_out;
	end
	// controller for andOp_175.andOp_175_in0
	// controller for andOp_175.andOp_175_in1
	// Insensitive connections
	always @(*) begin
		andOp_175_in0 = valid ? andOp_172_out : andOp_172_out;
		andOp_175_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_176.andOp_176_in0
	// controller for andOp_176.andOp_176_in1
	// Insensitive connections
	always @(*) begin
		andOp_176_in0 = valid ? andOp_175_out : andOp_175_out;
		andOp_176_in1 = valid ? andOp_174_out : andOp_174_out;
	end
	// controller for andOp_178.andOp_178_in0
	// controller for andOp_178.andOp_178_in1
	// Insensitive connections
	always @(*) begin
		andOp_178_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_178_in1 = valid ? eq_177_out : eq_177_out;
	end
	// controller for andOp_180.andOp_180_in0
	// controller for andOp_180.andOp_180_in1
	// Insensitive connections
	always @(*) begin
		andOp_180_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_180_in1 = valid ? eq_179_out : eq_179_out;
	end
	// controller for andOp_182.andOp_182_in0
	// controller for andOp_182.andOp_182_in1
	// Insensitive connections
	always @(*) begin
		andOp_182_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_182_in1 = valid ? eq_181_out : eq_181_out;
	end
	// controller for andOp_184.andOp_184_in0
	// controller for andOp_184.andOp_184_in1
	// Insensitive connections
	always @(*) begin
		andOp_184_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_184_in1 = valid ? eq_183_out : eq_183_out;
	end
	// controller for andOp_186.andOp_186_in0
	// controller for andOp_186.andOp_186_in1
	// Insensitive connections
	always @(*) begin
		andOp_186_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_186_in1 = valid ? eq_185_out : eq_185_out;
	end
	// controller for andOp_188.andOp_188_in0
	// controller for andOp_188.andOp_188_in1
	// Insensitive connections
	always @(*) begin
		andOp_188_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_188_in1 = valid ? eq_187_out : eq_187_out;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_19_in1 = valid ? eq_18_out : eq_18_out;
	end
	// controller for andOp_190.andOp_190_in0
	// controller for andOp_190.andOp_190_in1
	// Insensitive connections
	always @(*) begin
		andOp_190_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_190_in1 = valid ? eq_189_out : eq_189_out;
	end
	// controller for andOp_192.andOp_192_in0
	// controller for andOp_192.andOp_192_in1
	// Insensitive connections
	always @(*) begin
		andOp_192_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_192_in1 = valid ? eq_191_out : eq_191_out;
	end
	// controller for andOp_194.andOp_194_in0
	// controller for andOp_194.andOp_194_in1
	// Insensitive connections
	always @(*) begin
		andOp_194_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_194_in1 = valid ? eq_193_out : eq_193_out;
	end
	// controller for andOp_196.andOp_196_in0
	// controller for andOp_196.andOp_196_in1
	// Insensitive connections
	always @(*) begin
		andOp_196_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_196_in1 = valid ? eq_195_out : eq_195_out;
	end
	// controller for andOp_198.andOp_198_in0
	// controller for andOp_198.andOp_198_in1
	// Insensitive connections
	always @(*) begin
		andOp_198_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_198_in1 = valid ? eq_197_out : eq_197_out;
	end
	// controller for andOp_2.andOp_2_in0
	// controller for andOp_2.andOp_2_in1
	// Insensitive connections
	always @(*) begin
		andOp_2_in0 = valid ? andOp_1_out : andOp_1_out;
		andOp_2_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_200.andOp_200_in0
	// controller for andOp_200.andOp_200_in1
	// Insensitive connections
	always @(*) begin
		andOp_200_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_200_in1 = valid ? eq_199_out : eq_199_out;
	end
	// controller for andOp_202.andOp_202_in0
	// controller for andOp_202.andOp_202_in1
	// Insensitive connections
	always @(*) begin
		andOp_202_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_202_in1 = valid ? eq_201_out : eq_201_out;
	end
	// controller for andOp_204.andOp_204_in0
	// controller for andOp_204.andOp_204_in1
	// Insensitive connections
	always @(*) begin
		andOp_204_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_204_in1 = valid ? eq_203_out : eq_203_out;
	end
	// controller for andOp_206.andOp_206_in0
	// controller for andOp_206.andOp_206_in1
	// Insensitive connections
	always @(*) begin
		andOp_206_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_206_in1 = valid ? eq_205_out : eq_205_out;
	end
	// controller for andOp_208.andOp_208_in0
	// controller for andOp_208.andOp_208_in1
	// Insensitive connections
	always @(*) begin
		andOp_208_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_208_in1 = valid ? eq_207_out : eq_207_out;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_21_in1 = valid ? eq_20_out : eq_20_out;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_23_in1 = valid ? eq_22_out : eq_22_out;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_25_in1 = valid ? eq_24_out : eq_24_out;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_27_in1 = valid ? eq_26_out : eq_26_out;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_29_in1 = valid ? eq_28_out : eq_28_out;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? notOp_32_out : notOp_32_out;
		andOp_33_in1 = valid ? andOp_8_out : andOp_8_out;
	end
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	always @(*) begin
		andOp_36_in0 = valid ? notOp_35_out : notOp_35_out;
		andOp_36_in1 = valid ? andOp_2_out : andOp_2_out;
	end
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	always @(*) begin
		andOp_38_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_38_in1 = valid ? eq_37_out : eq_37_out;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_40_in1 = valid ? eq_39_out : eq_39_out;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_42_in1 = valid ? eq_41_out : eq_41_out;
	end
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	always @(*) begin
		andOp_44_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_44_in1 = valid ? eq_43_out : eq_43_out;
	end
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	always @(*) begin
		andOp_46_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_46_in1 = valid ? eq_45_out : eq_45_out;
	end
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	always @(*) begin
		andOp_47_in0 = valid ? in_read_ready : in_read_ready;
		andOp_47_in1 = valid ? andOp_46_out : andOp_46_out;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_49_in1 = valid ? eq_48_out : eq_48_out;
	end
	// controller for andOp_5.andOp_5_in0
	// controller for andOp_5.andOp_5_in1
	// Insensitive connections
	always @(*) begin
		andOp_5_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_5_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_51_in1 = valid ? eq_50_out : eq_50_out;
	end
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	always @(*) begin
		andOp_53_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_53_in1 = valid ? eq_52_out : eq_52_out;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? in_read_ready : in_read_ready;
		andOp_54_in1 = valid ? andOp_53_out : andOp_53_out;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_56_in1 = valid ? eq_55_out : eq_55_out;
	end
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	always @(*) begin
		andOp_57_in0 = valid ? in_read_ready : in_read_ready;
		andOp_57_in1 = valid ? andOp_56_out : andOp_56_out;
	end
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_59_in1 = valid ? eq_58_out : eq_58_out;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? andOp_5_out : andOp_5_out;
		andOp_6_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? in_read_ready : in_read_ready;
		andOp_60_in1 = valid ? andOp_59_out : andOp_59_out;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_62_in1 = valid ? eq_61_out : eq_61_out;
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? in_read_ready : in_read_ready;
		andOp_63_in1 = valid ? andOp_62_out : andOp_62_out;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_65_in1 = valid ? eq_64_out : eq_64_out;
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
		andOp_69_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_69_in1 = valid ? eq_68_out : eq_68_out;
	end
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	always @(*) begin
		andOp_71_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_71_in1 = valid ? eq_70_out : eq_70_out;
	end
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	always @(*) begin
		andOp_73_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_73_in1 = valid ? eq_72_out : eq_72_out;
	end
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	always @(*) begin
		andOp_75_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_75_in1 = valid ? eq_74_out : eq_74_out;
	end
	// controller for andOp_76.andOp_76_in0
	// controller for andOp_76.andOp_76_in1
	// Insensitive connections
	always @(*) begin
		andOp_76_in0 = valid ? out_write_ready : out_write_ready;
		andOp_76_in1 = valid ? andOp_75_out : andOp_75_out;
	end
	// controller for andOp_78.andOp_78_in0
	// controller for andOp_78.andOp_78_in1
	// Insensitive connections
	always @(*) begin
		andOp_78_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_78_in1 = valid ? eq_77_out : eq_77_out;
	end
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	always @(*) begin
		andOp_79_in0 = valid ? out_write_ready : out_write_ready;
		andOp_79_in1 = valid ? andOp_78_out : andOp_78_out;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? andOp_6_out : andOp_6_out;
		andOp_8_in1 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	always @(*) begin
		andOp_81_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_81_in1 = valid ? eq_80_out : eq_80_out;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_83_in1 = valid ? eq_82_out : eq_82_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_85_in1 = valid ? eq_84_out : eq_84_out;
	end
	// controller for andOp_87.andOp_87_in0
	// controller for andOp_87.andOp_87_in1
	// Insensitive connections
	always @(*) begin
		andOp_87_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_87_in1 = valid ? eq_86_out : eq_86_out;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_89_in1 = valid ? eq_88_out : eq_88_out;
	end
	// controller for andOp_91.andOp_91_in0
	// controller for andOp_91.andOp_91_in1
	// Insensitive connections
	always @(*) begin
		andOp_91_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_91_in1 = valid ? eq_90_out : eq_90_out;
	end
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	always @(*) begin
		andOp_93_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_93_in1 = valid ? eq_92_out : eq_92_out;
	end
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	always @(*) begin
		andOp_95_in0 = valid ? notOp_94_out : notOp_94_out;
		andOp_95_in1 = valid ? andOp_91_out : andOp_91_out;
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
		andOp_99_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_99_in1 = valid ? eq_98_out : eq_98_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_11_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_0_predecessor.bb_0_predecessor_in_data
	always @(*) begin
		if (eq_30_out) begin 
			bb_0_predecessor_in_data = last_BB_reg;
		end else begin
			bb_0_predecessor_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = orOp_13_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_1_predecessor.bb_1_predecessor_in_data
	always @(*) begin
		if (andOp_33_out) begin 
			bb_1_predecessor_in_data = 32'd2;
		end else if (eq_31_out) begin 
			bb_1_predecessor_in_data = last_BB_reg;
		end else begin
			bb_1_predecessor_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = orOp_15_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for bb_2_predecessor.bb_2_predecessor_in_data
	always @(*) begin
		if (andOp_36_out) begin 
			bb_2_predecessor_in_data = 32'd0;
		end else if (eq_34_out) begin 
			bb_2_predecessor_in_data = last_BB_reg;
		end else begin
			bb_2_predecessor_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (andOp_2_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_3_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_2_happened.br_2_happened_in_data
	always @(*) begin
		if (andOp_6_out) begin 
			br_2_happened_in_data = 1'd1;
		end else if (notOp_7_out) begin 
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
		eq_104_in0 = valid ? 32'd0 : 32'd0;
		eq_104_in1 = valid ? global_state : global_state;
	end
	// controller for eq_107.eq_107_in0
	// controller for eq_107.eq_107_in1
	// Insensitive connections
	always @(*) begin
		eq_107_in0 = valid ? 32'd0 : 32'd0;
		eq_107_in1 = valid ? global_state : global_state;
	end
	// controller for eq_109.eq_109_in0
	// controller for eq_109.eq_109_in1
	// Insensitive connections
	always @(*) begin
		eq_109_in0 = valid ? 32'd1 : 32'd1;
		eq_109_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd0 : 32'd0;
		eq_11_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	always @(*) begin
		eq_112_in0 = valid ? 32'd1 : 32'd1;
		eq_112_in1 = valid ? global_state : global_state;
	end
	// controller for eq_115.eq_115_in0
	// controller for eq_115.eq_115_in1
	// Insensitive connections
	always @(*) begin
		eq_115_in0 = valid ? 32'd2 : 32'd2;
		eq_115_in1 = valid ? global_state : global_state;
	end
	// controller for eq_118.eq_118_in0
	// controller for eq_118.eq_118_in1
	// Insensitive connections
	always @(*) begin
		eq_118_in0 = valid ? 32'd2 : 32'd2;
		eq_118_in1 = valid ? global_state : global_state;
	end
	// controller for eq_12.eq_12_in0
	// controller for eq_12.eq_12_in1
	// Insensitive connections
	always @(*) begin
		eq_12_in0 = valid ? 32'd1 : 32'd1;
		eq_12_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_120.eq_120_in0
	// controller for eq_120.eq_120_in1
	// Insensitive connections
	always @(*) begin
		eq_120_in0 = valid ? 32'd3 : 32'd3;
		eq_120_in1 = valid ? global_state : global_state;
	end
	// controller for eq_123.eq_123_in0
	// controller for eq_123.eq_123_in1
	// Insensitive connections
	always @(*) begin
		eq_123_in0 = valid ? 32'd3 : 32'd3;
		eq_123_in1 = valid ? global_state : global_state;
	end
	// controller for eq_126.eq_126_in0
	// controller for eq_126.eq_126_in1
	// Insensitive connections
	always @(*) begin
		eq_126_in0 = valid ? 32'd4 : 32'd4;
		eq_126_in1 = valid ? global_state : global_state;
	end
	// controller for eq_129.eq_129_in0
	// controller for eq_129.eq_129_in1
	// Insensitive connections
	always @(*) begin
		eq_129_in0 = valid ? 32'd4 : 32'd4;
		eq_129_in1 = valid ? global_state : global_state;
	end
	// controller for eq_131.eq_131_in0
	// controller for eq_131.eq_131_in1
	// Insensitive connections
	always @(*) begin
		eq_131_in0 = valid ? 32'd4 : 32'd4;
		eq_131_in1 = valid ? global_state : global_state;
	end
	// controller for eq_134.eq_134_in0
	// controller for eq_134.eq_134_in1
	// Insensitive connections
	always @(*) begin
		eq_134_in0 = valid ? 32'd4 : 32'd4;
		eq_134_in1 = valid ? global_state : global_state;
	end
	// controller for eq_137.eq_137_in0
	// controller for eq_137.eq_137_in1
	// Insensitive connections
	always @(*) begin
		eq_137_in0 = valid ? 32'd5 : 32'd5;
		eq_137_in1 = valid ? global_state : global_state;
	end
	// controller for eq_14.eq_14_in0
	// controller for eq_14.eq_14_in1
	// Insensitive connections
	always @(*) begin
		eq_14_in0 = valid ? 32'd2 : 32'd2;
		eq_14_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_140.eq_140_in0
	// controller for eq_140.eq_140_in1
	// Insensitive connections
	always @(*) begin
		eq_140_in0 = valid ? 32'd5 : 32'd5;
		eq_140_in1 = valid ? global_state : global_state;
	end
	// controller for eq_142.eq_142_in0
	// controller for eq_142.eq_142_in1
	// Insensitive connections
	always @(*) begin
		eq_142_in0 = valid ? 32'd6 : 32'd6;
		eq_142_in1 = valid ? global_state : global_state;
	end
	// controller for eq_145.eq_145_in0
	// controller for eq_145.eq_145_in1
	// Insensitive connections
	always @(*) begin
		eq_145_in0 = valid ? 32'd6 : 32'd6;
		eq_145_in1 = valid ? global_state : global_state;
	end
	// controller for eq_147.eq_147_in0
	// controller for eq_147.eq_147_in1
	// Insensitive connections
	always @(*) begin
		eq_147_in0 = valid ? 32'd0 : 32'd0;
		eq_147_in1 = valid ? global_state : global_state;
	end
	// controller for eq_149.eq_149_in0
	// controller for eq_149.eq_149_in1
	// Insensitive connections
	always @(*) begin
		eq_149_in0 = valid ? 32'd0 : 32'd0;
		eq_149_in1 = valid ? global_state : global_state;
	end
	// controller for eq_151.eq_151_in0
	// controller for eq_151.eq_151_in1
	// Insensitive connections
	always @(*) begin
		eq_151_in0 = valid ? 32'd0 : 32'd0;
		eq_151_in1 = valid ? global_state : global_state;
	end
	// controller for eq_153.eq_153_in0
	// controller for eq_153.eq_153_in1
	// Insensitive connections
	always @(*) begin
		eq_153_in0 = valid ? 32'd1 : 32'd1;
		eq_153_in1 = valid ? global_state : global_state;
	end
	// controller for eq_155.eq_155_in0
	// controller for eq_155.eq_155_in1
	// Insensitive connections
	always @(*) begin
		eq_155_in0 = valid ? 32'd1 : 32'd1;
		eq_155_in1 = valid ? global_state : global_state;
	end
	// controller for eq_157.eq_157_in0
	// controller for eq_157.eq_157_in1
	// Insensitive connections
	always @(*) begin
		eq_157_in0 = valid ? 32'd1 : 32'd1;
		eq_157_in1 = valid ? global_state : global_state;
	end
	// controller for eq_159.eq_159_in0
	// controller for eq_159.eq_159_in1
	// Insensitive connections
	always @(*) begin
		eq_159_in0 = valid ? 32'd1 : 32'd1;
		eq_159_in1 = valid ? global_state : global_state;
	end
	// controller for eq_16.eq_16_in0
	// controller for eq_16.eq_16_in1
	// Insensitive connections
	always @(*) begin
		eq_16_in0 = valid ? 32'd0 : 32'd0;
		eq_16_in1 = valid ? global_state : global_state;
	end
	// controller for eq_161.eq_161_in0
	// controller for eq_161.eq_161_in1
	// Insensitive connections
	always @(*) begin
		eq_161_in0 = valid ? 32'd1 : 32'd1;
		eq_161_in1 = valid ? global_state : global_state;
	end
	// controller for eq_165.eq_165_in0
	// controller for eq_165.eq_165_in1
	// Insensitive connections
	always @(*) begin
		eq_165_in0 = valid ? 32'd1 : 32'd1;
		eq_165_in1 = valid ? global_state : global_state;
	end
	// controller for eq_167.eq_167_in0
	// controller for eq_167.eq_167_in1
	// Insensitive connections
	always @(*) begin
		eq_167_in0 = valid ? 32'd1 : 32'd1;
		eq_167_in1 = valid ? global_state : global_state;
	end
	// controller for eq_171.eq_171_in0
	// controller for eq_171.eq_171_in1
	// Insensitive connections
	always @(*) begin
		eq_171_in0 = valid ? 32'd1 : 32'd1;
		eq_171_in1 = valid ? global_state : global_state;
	end
	// controller for eq_173.eq_173_in0
	// controller for eq_173.eq_173_in1
	// Insensitive connections
	always @(*) begin
		eq_173_in0 = valid ? 32'd1 : 32'd1;
		eq_173_in1 = valid ? global_state : global_state;
	end
	// controller for eq_177.eq_177_in0
	// controller for eq_177.eq_177_in1
	// Insensitive connections
	always @(*) begin
		eq_177_in0 = valid ? 32'd1 : 32'd1;
		eq_177_in1 = valid ? global_state : global_state;
	end
	// controller for eq_179.eq_179_in0
	// controller for eq_179.eq_179_in1
	// Insensitive connections
	always @(*) begin
		eq_179_in0 = valid ? 32'd1 : 32'd1;
		eq_179_in1 = valid ? global_state : global_state;
	end
	// controller for eq_18.eq_18_in0
	// controller for eq_18.eq_18_in1
	// Insensitive connections
	always @(*) begin
		eq_18_in0 = valid ? 32'd1 : 32'd1;
		eq_18_in1 = valid ? global_state : global_state;
	end
	// controller for eq_181.eq_181_in0
	// controller for eq_181.eq_181_in1
	// Insensitive connections
	always @(*) begin
		eq_181_in0 = valid ? 32'd2 : 32'd2;
		eq_181_in1 = valid ? global_state : global_state;
	end
	// controller for eq_183.eq_183_in0
	// controller for eq_183.eq_183_in1
	// Insensitive connections
	always @(*) begin
		eq_183_in0 = valid ? 32'd3 : 32'd3;
		eq_183_in1 = valid ? global_state : global_state;
	end
	// controller for eq_185.eq_185_in0
	// controller for eq_185.eq_185_in1
	// Insensitive connections
	always @(*) begin
		eq_185_in0 = valid ? 32'd3 : 32'd3;
		eq_185_in1 = valid ? global_state : global_state;
	end
	// controller for eq_187.eq_187_in0
	// controller for eq_187.eq_187_in1
	// Insensitive connections
	always @(*) begin
		eq_187_in0 = valid ? 32'd3 : 32'd3;
		eq_187_in1 = valid ? global_state : global_state;
	end
	// controller for eq_189.eq_189_in0
	// controller for eq_189.eq_189_in1
	// Insensitive connections
	always @(*) begin
		eq_189_in0 = valid ? 32'd4 : 32'd4;
		eq_189_in1 = valid ? global_state : global_state;
	end
	// controller for eq_191.eq_191_in0
	// controller for eq_191.eq_191_in1
	// Insensitive connections
	always @(*) begin
		eq_191_in0 = valid ? 32'd4 : 32'd4;
		eq_191_in1 = valid ? global_state : global_state;
	end
	// controller for eq_193.eq_193_in0
	// controller for eq_193.eq_193_in1
	// Insensitive connections
	always @(*) begin
		eq_193_in0 = valid ? 32'd4 : 32'd4;
		eq_193_in1 = valid ? global_state : global_state;
	end
	// controller for eq_195.eq_195_in0
	// controller for eq_195.eq_195_in1
	// Insensitive connections
	always @(*) begin
		eq_195_in0 = valid ? 32'd4 : 32'd4;
		eq_195_in1 = valid ? global_state : global_state;
	end
	// controller for eq_197.eq_197_in0
	// controller for eq_197.eq_197_in1
	// Insensitive connections
	always @(*) begin
		eq_197_in0 = valid ? 32'd4 : 32'd4;
		eq_197_in1 = valid ? global_state : global_state;
	end
	// controller for eq_199.eq_199_in0
	// controller for eq_199.eq_199_in1
	// Insensitive connections
	always @(*) begin
		eq_199_in0 = valid ? 32'd5 : 32'd5;
		eq_199_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd2 : 32'd2;
		eq_20_in1 = valid ? global_state : global_state;
	end
	// controller for eq_201.eq_201_in0
	// controller for eq_201.eq_201_in1
	// Insensitive connections
	always @(*) begin
		eq_201_in0 = valid ? 32'd5 : 32'd5;
		eq_201_in1 = valid ? global_state : global_state;
	end
	// controller for eq_203.eq_203_in0
	// controller for eq_203.eq_203_in1
	// Insensitive connections
	always @(*) begin
		eq_203_in0 = valid ? 32'd5 : 32'd5;
		eq_203_in1 = valid ? global_state : global_state;
	end
	// controller for eq_205.eq_205_in0
	// controller for eq_205.eq_205_in1
	// Insensitive connections
	always @(*) begin
		eq_205_in0 = valid ? 32'd6 : 32'd6;
		eq_205_in1 = valid ? global_state : global_state;
	end
	// controller for eq_207.eq_207_in0
	// controller for eq_207.eq_207_in1
	// Insensitive connections
	always @(*) begin
		eq_207_in0 = valid ? 32'd6 : 32'd6;
		eq_207_in1 = valid ? global_state : global_state;
	end
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	always @(*) begin
		eq_22_in0 = valid ? 32'd3 : 32'd3;
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
		eq_26_in0 = valid ? 32'd5 : 32'd5;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd6 : 32'd6;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd0 : 32'd0;
		eq_30_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	always @(*) begin
		eq_31_in0 = valid ? 32'd1 : 32'd1;
		eq_31_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	always @(*) begin
		eq_34_in0 = valid ? 32'd2 : 32'd2;
		eq_34_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	always @(*) begin
		eq_37_in0 = valid ? 32'd0 : 32'd0;
		eq_37_in1 = valid ? global_state : global_state;
	end
	// controller for eq_39.eq_39_in0
	// controller for eq_39.eq_39_in1
	// Insensitive connections
	always @(*) begin
		eq_39_in0 = valid ? 32'd0 : 32'd0;
		eq_39_in1 = valid ? global_state : global_state;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd4 : 32'd4;
		eq_4_in1 = valid ? global_state : global_state;
	end
	// controller for eq_41.eq_41_in0
	// controller for eq_41.eq_41_in1
	// Insensitive connections
	always @(*) begin
		eq_41_in0 = valid ? 32'd0 : 32'd0;
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
		eq_45_in0 = valid ? 32'd1 : 32'd1;
		eq_45_in1 = valid ? global_state : global_state;
	end
	// controller for eq_48.eq_48_in0
	// controller for eq_48.eq_48_in1
	// Insensitive connections
	always @(*) begin
		eq_48_in0 = valid ? 32'd3 : 32'd3;
		eq_48_in1 = valid ? global_state : global_state;
	end
	// controller for eq_50.eq_50_in0
	// controller for eq_50.eq_50_in1
	// Insensitive connections
	always @(*) begin
		eq_50_in0 = valid ? 32'd5 : 32'd5;
		eq_50_in1 = valid ? global_state : global_state;
	end
	// controller for eq_52.eq_52_in0
	// controller for eq_52.eq_52_in1
	// Insensitive connections
	always @(*) begin
		eq_52_in0 = valid ? 32'd1 : 32'd1;
		eq_52_in1 = valid ? global_state : global_state;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd1 : 32'd1;
		eq_55_in1 = valid ? global_state : global_state;
	end
	// controller for eq_58.eq_58_in0
	// controller for eq_58.eq_58_in1
	// Insensitive connections
	always @(*) begin
		eq_58_in0 = valid ? 32'd1 : 32'd1;
		eq_58_in1 = valid ? global_state : global_state;
	end
	// controller for eq_61.eq_61_in0
	// controller for eq_61.eq_61_in1
	// Insensitive connections
	always @(*) begin
		eq_61_in0 = valid ? 32'd1 : 32'd1;
		eq_61_in1 = valid ? global_state : global_state;
	end
	// controller for eq_64.eq_64_in0
	// controller for eq_64.eq_64_in1
	// Insensitive connections
	always @(*) begin
		eq_64_in0 = valid ? 32'd2 : 32'd2;
		eq_64_in1 = valid ? global_state : global_state;
	end
	// controller for eq_66.eq_66_in0
	// controller for eq_66.eq_66_in1
	// Insensitive connections
	always @(*) begin
		eq_66_in0 = valid ? 32'd3 : 32'd3;
		eq_66_in1 = valid ? global_state : global_state;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd3 : 32'd3;
		eq_68_in1 = valid ? global_state : global_state;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd1 : 32'd1;
		eq_70_in1 = valid ? global_state : global_state;
	end
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	always @(*) begin
		eq_72_in0 = valid ? 32'd3 : 32'd3;
		eq_72_in1 = valid ? global_state : global_state;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd4 : 32'd4;
		eq_74_in1 = valid ? global_state : global_state;
	end
	// controller for eq_77.eq_77_in0
	// controller for eq_77.eq_77_in1
	// Insensitive connections
	always @(*) begin
		eq_77_in0 = valid ? 32'd4 : 32'd4;
		eq_77_in1 = valid ? global_state : global_state;
	end
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	always @(*) begin
		eq_80_in0 = valid ? 32'd5 : 32'd5;
		eq_80_in1 = valid ? global_state : global_state;
	end
	// controller for eq_82.eq_82_in0
	// controller for eq_82.eq_82_in1
	// Insensitive connections
	always @(*) begin
		eq_82_in0 = valid ? 32'd5 : 32'd5;
		eq_82_in1 = valid ? global_state : global_state;
	end
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	always @(*) begin
		eq_84_in0 = valid ? 32'd6 : 32'd6;
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
		eq_88_in0 = valid ? 32'd6 : 32'd6;
		eq_88_in1 = valid ? global_state : global_state;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd1 : 32'd1;
		eq_90_in1 = valid ? global_state : global_state;
	end
	// controller for eq_92.eq_92_in0
	// controller for eq_92.eq_92_in1
	// Insensitive connections
	always @(*) begin
		eq_92_in0 = valid ? 32'd1 : 32'd1;
		eq_92_in1 = valid ? global_state : global_state;
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
		if (andOp_65_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (andOp_67_out) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_100.notOp_100_in0
	// Insensitive connections
	always @(*) begin
		notOp_100_in0 = valid ? andOp_99_out : andOp_99_out;
	end
	// controller for notOp_125.notOp_125_in0
	// Insensitive connections
	always @(*) begin
		notOp_125_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_3.notOp_3_in0
	// Insensitive connections
	always @(*) begin
		notOp_3_in0 = valid ? andOp_2_out : andOp_2_out;
	end
	// controller for notOp_32.notOp_32_in0
	// Insensitive connections
	always @(*) begin
		notOp_32_in0 = valid ? eq_31_out : eq_31_out;
	end
	// controller for notOp_35.notOp_35_in0
	// Insensitive connections
	always @(*) begin
		notOp_35_in0 = valid ? eq_34_out : eq_34_out;
	end
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	always @(*) begin
		notOp_7_in0 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	always @(*) begin
		notOp_9_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_94.notOp_94_in0
	// Insensitive connections
	always @(*) begin
		notOp_94_in0 = valid ? andOp_93_out : andOp_93_out;
	end
	// controller for orOp_13.orOp_13_in0
	always @(*) begin
		if (1'd1) begin 
			orOp_13_in0 = eq_12_out;
		end else begin
			orOp_13_in0 = 0;
		end
	end
	// controller for orOp_13.orOp_13_in1
	always @(*) begin
		if (1'd1) begin 
			orOp_13_in1 = andOp_8_out;
		end else begin
			orOp_13_in1 = 0;
		end
	end
	// controller for orOp_15.orOp_15_in0
	always @(*) begin
		if (1'd1) begin 
			orOp_15_in0 = eq_14_out;
		end else begin
			orOp_15_in0 = 0;
		end
	end
	// controller for orOp_15.orOp_15_in1
	always @(*) begin
		if (1'd1) begin 
			orOp_15_in1 = andOp_2_out;
		end else begin
			orOp_15_in1 = 0;
		end
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_83_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_81_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (andOp_85_out) begin 
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
		phi_last_block_phi_5 = valid ? bb_2_predecessor_out_data : bb_2_predecessor_out_data;
		phi_s_phi_5 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_47_out) begin 
			raddr_ram_0_reg = 0;
		end else if (andOp_51_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_44_out) begin 
			waddr_ram_0_reg = 0;
		end else if (andOp_49_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_44_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (andOp_49_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_44_out) begin 
			wen_ram_0_reg = 1;
		end else if (andOp_49_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_23.valid_reg
	always @(*) begin
		if (andOp_89_out) begin 
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
			if (andOp_170_out) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (andOp_10_out) begin
				global_next_block <= 2;
			end
			if (andOp_17_out) begin
				global_next_block <= 0;
			end
			if (andOp_19_out) begin
				global_next_block <= 2;
			end
			if (andOp_21_out) begin
				global_next_block <= 2;
			end
			if (andOp_23_out) begin
				global_next_block <= 2;
			end
			if (andOp_25_out) begin
				global_next_block <= 1;
			end
			if (andOp_27_out) begin
				global_next_block <= 1;
			end
			if (andOp_29_out) begin
				global_next_block <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_108_out) begin
				global_state <= 1;
			end
			if (andOp_114_out) begin
				global_state <= 2;
			end
			if (andOp_119_out) begin
				global_state <= 3;
			end
			if (andOp_124_out) begin
				global_state <= 4;
			end
			if (andOp_130_out) begin
				global_state <= 1;
			end
			if (andOp_136_out) begin
				global_state <= 5;
			end
			if (andOp_141_out) begin
				global_state <= 6;
			end
			if (andOp_146_out) begin
				global_state <= 6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if (andOp_176_out) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (andOp_101_out) begin
				last_BB_reg <= 2;
			end
			if (andOp_103_out) begin
				last_BB_reg <= 1;
			end
			if (andOp_95_out) begin
				last_BB_reg <= 0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_1 <= 0;
		end else begin
			if (andOp_164_out) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

