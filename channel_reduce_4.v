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
	add call_0();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	br_dummy br_unit();

	add call_16();

	add alloca_2();

	add bitcast_3();

	add call_18();

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

	reg [0:0] tmp_output_2_in_data;
	wire [0:0] tmp_output_2_out_data;
	hls_wire #(.WIDTH(1)) tmp_output_2(.in_data(tmp_output_2_in_data), .out_data(tmp_output_2_out_data));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [31:0] eq_4_in0;
	reg [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	reg [0:0] andOp_5_in0;
	reg [0:0] andOp_5_in1;
	wire [0:0] andOp_5_out;
	andOp #(.WIDTH(1)) andOp_5(.in0(andOp_5_in0), .in1(andOp_5_in1), .out(andOp_5_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [0:0] notOp_6_in0;
	wire [0:0] notOp_6_out;
	notOp #(.WIDTH(1)) notOp_6(.in(notOp_6_in0), .out(notOp_6_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_7_in0;
	reg [31:0] eq_7_in1;
	wire [0:0] eq_7_out;
	eq #(.WIDTH(32)) eq_7(.in0(eq_7_in0), .in1(eq_7_in1), .out(eq_7_out));

	reg [0:0] andOp_8_in0;
	reg [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	reg [0:0] tmp_output_9_in_data;
	wire [0:0] tmp_output_9_out_data;
	hls_wire #(.WIDTH(1)) tmp_output_9(.in_data(tmp_output_9_in_data), .out_data(tmp_output_9_out_data));

	reg [31:0] eq_10_in0;
	reg [31:0] eq_10_in1;
	wire [0:0] eq_10_out;
	eq #(.WIDTH(32)) eq_10(.in0(eq_10_in0), .in1(eq_10_in1), .out(eq_10_out));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [0:0] andOp_12_in0;
	reg [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] br_2_happened_in_data;
	wire [0:0] br_2_happened_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened(.in_data(br_2_happened_in_data), .out_data(br_2_happened_out_data));

	reg [0:0] notOp_13_in0;
	wire [0:0] notOp_13_out;
	notOp #(.WIDTH(1)) notOp_13(.in(notOp_13_in0), .out(notOp_13_out));

	reg [0:0] andOp_14_in0;
	reg [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	reg [0:0] notOp_15_in0;
	wire [0:0] notOp_15_out;
	notOp #(.WIDTH(1)) notOp_15(.in(notOp_15_in0), .out(notOp_15_out));

	reg [0:0] andOp_16_in0;
	reg [0:0] andOp_16_in1;
	wire [0:0] andOp_16_out;
	andOp #(.WIDTH(1)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

	reg [31:0] eq_17_in0;
	reg [31:0] eq_17_in1;
	wire [0:0] eq_17_out;
	eq #(.WIDTH(32)) eq_17(.in0(eq_17_in0), .in1(eq_17_in1), .out(eq_17_out));

	reg [31:0] eq_18_in0;
	reg [31:0] eq_18_in1;
	wire [0:0] eq_18_out;
	eq #(.WIDTH(32)) eq_18(.in0(eq_18_in0), .in1(eq_18_in1), .out(eq_18_out));

	reg [0:0] orOp_19_in0;
	reg [0:0] orOp_19_in1;
	wire [0:0] orOp_19_out;
	orOp #(.WIDTH(1)) orOp_19(.in0(orOp_19_in0), .in1(orOp_19_in1), .out(orOp_19_out));

	reg [31:0] eq_20_in0;
	reg [31:0] eq_20_in1;
	wire [0:0] eq_20_out;
	eq #(.WIDTH(32)) eq_20(.in0(eq_20_in0), .in1(eq_20_in1), .out(eq_20_out));

	reg [0:0] orOp_21_in0;
	reg [0:0] orOp_21_in1;
	wire [0:0] orOp_21_out;
	orOp #(.WIDTH(1)) orOp_21(.in0(orOp_21_in0), .in1(orOp_21_in1), .out(orOp_21_out));

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

	reg [31:0] bb_0_predecessor_in_data;
	wire [31:0] bb_0_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor(.in_data(bb_0_predecessor_in_data), .out_data(bb_0_predecessor_out_data));

	reg [31:0] eq_36_in0;
	reg [31:0] eq_36_in1;
	wire [0:0] eq_36_out;
	eq #(.WIDTH(32)) eq_36(.in0(eq_36_in0), .in1(eq_36_in1), .out(eq_36_out));

	reg [31:0] bb_1_predecessor_in_data;
	wire [31:0] bb_1_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor(.in_data(bb_1_predecessor_in_data), .out_data(bb_1_predecessor_out_data));

	reg [31:0] eq_37_in0;
	reg [31:0] eq_37_in1;
	wire [0:0] eq_37_out;
	eq #(.WIDTH(32)) eq_37(.in0(eq_37_in0), .in1(eq_37_in1), .out(eq_37_out));

	reg [0:0] notOp_38_in0;
	wire [0:0] notOp_38_out;
	notOp #(.WIDTH(1)) notOp_38(.in(notOp_38_in0), .out(notOp_38_out));

	reg [0:0] andOp_39_in0;
	reg [0:0] andOp_39_in1;
	wire [0:0] andOp_39_out;
	andOp #(.WIDTH(1)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	reg [31:0] bb_2_predecessor_in_data;
	wire [31:0] bb_2_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor(.in_data(bb_2_predecessor_in_data), .out_data(bb_2_predecessor_out_data));

	reg [31:0] eq_40_in0;
	reg [31:0] eq_40_in1;
	wire [0:0] eq_40_out;
	eq #(.WIDTH(32)) eq_40(.in0(eq_40_in0), .in1(eq_40_in1), .out(eq_40_out));

	reg [0:0] notOp_41_in0;
	wire [0:0] notOp_41_out;
	notOp #(.WIDTH(1)) notOp_41(.in(notOp_41_in0), .out(notOp_41_out));

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

	reg [31:0] eq_47_in0;
	reg [31:0] eq_47_in1;
	wire [0:0] eq_47_out;
	eq #(.WIDTH(32)) eq_47(.in0(eq_47_in0), .in1(eq_47_in1), .out(eq_47_out));

	reg [0:0] andOp_48_in0;
	reg [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	reg [31:0] andOp_49_in0;
	reg [31:0] andOp_49_in1;
	wire [31:0] andOp_49_out;
	andOp #(.WIDTH(32)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

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

	reg [31:0] eq_54_in0;
	reg [31:0] eq_54_in1;
	wire [0:0] eq_54_out;
	eq #(.WIDTH(32)) eq_54(.in0(eq_54_in0), .in1(eq_54_in1), .out(eq_54_out));

	reg [0:0] andOp_55_in0;
	reg [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	reg [31:0] eq_56_in0;
	reg [31:0] eq_56_in1;
	wire [0:0] eq_56_out;
	eq #(.WIDTH(32)) eq_56(.in0(eq_56_in0), .in1(eq_56_in1), .out(eq_56_out));

	reg [0:0] andOp_57_in0;
	reg [0:0] andOp_57_in1;
	wire [0:0] andOp_57_out;
	andOp #(.WIDTH(1)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

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

	reg [31:0] andOp_66_in0;
	reg [31:0] andOp_66_in1;
	wire [31:0] andOp_66_out;
	andOp #(.WIDTH(32)) andOp_66(.in0(andOp_66_in0), .in1(andOp_66_in1), .out(andOp_66_out));

	reg [31:0] eq_67_in0;
	reg [31:0] eq_67_in1;
	wire [0:0] eq_67_out;
	eq #(.WIDTH(32)) eq_67(.in0(eq_67_in0), .in1(eq_67_in1), .out(eq_67_out));

	reg [0:0] andOp_68_in0;
	reg [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	reg [31:0] andOp_69_in0;
	reg [31:0] andOp_69_in1;
	wire [31:0] andOp_69_out;
	andOp #(.WIDTH(32)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

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

	reg [31:0] eq_76_in0;
	reg [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	reg [0:0] andOp_77_in0;
	reg [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	reg [31:0] eq_78_in0;
	reg [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	reg [0:0] andOp_79_in0;
	reg [0:0] andOp_79_in1;
	wire [0:0] andOp_79_out;
	andOp #(.WIDTH(1)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	reg [31:0] eq_80_in0;
	reg [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

	reg [0:0] andOp_81_in0;
	reg [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	reg [31:0] andOp_82_in0;
	reg [31:0] andOp_82_in1;
	wire [31:0] andOp_82_out;
	andOp #(.WIDTH(32)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	reg [31:0] eq_83_in0;
	reg [31:0] eq_83_in1;
	wire [0:0] eq_83_out;
	eq #(.WIDTH(32)) eq_83(.in0(eq_83_in0), .in1(eq_83_in1), .out(eq_83_out));

	reg [0:0] andOp_84_in0;
	reg [0:0] andOp_84_in1;
	wire [0:0] andOp_84_out;
	andOp #(.WIDTH(1)) andOp_84(.in0(andOp_84_in0), .in1(andOp_84_in1), .out(andOp_84_out));

	reg [31:0] andOp_85_in0;
	reg [31:0] andOp_85_in1;
	wire [31:0] andOp_85_out;
	andOp #(.WIDTH(32)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

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

	reg [0:0] notOp_106_in0;
	wire [0:0] notOp_106_out;
	notOp #(.WIDTH(1)) notOp_106(.in(notOp_106_in0), .out(notOp_106_out));

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

	reg [0:0] andOp_111_in0;
	reg [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [0:0] andOp_112_in0;
	reg [0:0] andOp_112_in1;
	wire [0:0] andOp_112_out;
	andOp #(.WIDTH(1)) andOp_112(.in0(andOp_112_in0), .in1(andOp_112_in1), .out(andOp_112_out));

	reg [31:0] eq_113_in0;
	reg [31:0] eq_113_in1;
	wire [0:0] eq_113_out;
	eq #(.WIDTH(32)) eq_113(.in0(eq_113_in0), .in1(eq_113_in1), .out(eq_113_out));

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

	reg [31:0] andOp_120_in0;
	reg [31:0] andOp_120_in1;
	wire [31:0] andOp_120_out;
	andOp #(.WIDTH(32)) andOp_120(.in0(andOp_120_in0), .in1(andOp_120_in1), .out(andOp_120_out));

	reg [31:0] eq_121_in0;
	reg [31:0] eq_121_in1;
	wire [0:0] eq_121_out;
	eq #(.WIDTH(32)) eq_121(.in0(eq_121_in0), .in1(eq_121_in1), .out(eq_121_out));

	reg [0:0] andOp_122_in0;
	reg [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	reg [0:0] andOp_123_in0;
	reg [0:0] andOp_123_in1;
	wire [0:0] andOp_123_out;
	andOp #(.WIDTH(1)) andOp_123(.in0(andOp_123_in0), .in1(andOp_123_in1), .out(andOp_123_out));

	reg [31:0] eq_124_in0;
	reg [31:0] eq_124_in1;
	wire [0:0] eq_124_out;
	eq #(.WIDTH(32)) eq_124(.in0(eq_124_in0), .in1(eq_124_in1), .out(eq_124_out));

	reg [31:0] andOp_125_in0;
	reg [31:0] andOp_125_in1;
	wire [31:0] andOp_125_out;
	andOp #(.WIDTH(32)) andOp_125(.in0(andOp_125_in0), .in1(andOp_125_in1), .out(andOp_125_out));

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

	reg [0:0] notOp_131_in0;
	wire [0:0] notOp_131_out;
	notOp #(.WIDTH(1)) notOp_131(.in(notOp_131_in0), .out(notOp_131_out));

	reg [31:0] eq_132_in0;
	reg [31:0] eq_132_in1;
	wire [0:0] eq_132_out;
	eq #(.WIDTH(32)) eq_132(.in0(eq_132_in0), .in1(eq_132_in1), .out(eq_132_out));

	reg [0:0] andOp_133_in0;
	reg [0:0] andOp_133_in1;
	wire [0:0] andOp_133_out;
	andOp #(.WIDTH(1)) andOp_133(.in0(andOp_133_in0), .in1(andOp_133_in1), .out(andOp_133_out));

	reg [0:0] andOp_134_in0;
	reg [0:0] andOp_134_in1;
	wire [0:0] andOp_134_out;
	andOp #(.WIDTH(1)) andOp_134(.in0(andOp_134_in0), .in1(andOp_134_in1), .out(andOp_134_out));

	reg [31:0] eq_135_in0;
	reg [31:0] eq_135_in1;
	wire [0:0] eq_135_out;
	eq #(.WIDTH(32)) eq_135(.in0(eq_135_in0), .in1(eq_135_in1), .out(eq_135_out));

	reg [0:0] tmp_output_136_in_data;
	wire [0:0] tmp_output_136_out_data;
	hls_wire #(.WIDTH(1)) tmp_output_136(.in_data(tmp_output_136_in_data), .out_data(tmp_output_136_out_data));

	reg [31:0] eq_137_in0;
	reg [31:0] eq_137_in1;
	wire [0:0] eq_137_out;
	eq #(.WIDTH(32)) eq_137(.in0(eq_137_in0), .in1(eq_137_in1), .out(eq_137_out));

	reg [31:0] eq_138_in0;
	reg [31:0] eq_138_in1;
	wire [0:0] eq_138_out;
	eq #(.WIDTH(32)) eq_138(.in0(eq_138_in0), .in1(eq_138_in1), .out(eq_138_out));

	reg [31:0] andOp_139_in0;
	reg [31:0] andOp_139_in1;
	wire [31:0] andOp_139_out;
	andOp #(.WIDTH(32)) andOp_139(.in0(andOp_139_in0), .in1(andOp_139_in1), .out(andOp_139_out));

	reg [31:0] eq_140_in0;
	reg [31:0] eq_140_in1;
	wire [0:0] eq_140_out;
	eq #(.WIDTH(32)) eq_140(.in0(eq_140_in0), .in1(eq_140_in1), .out(eq_140_out));

	reg [0:0] andOp_141_in0;
	reg [0:0] andOp_141_in1;
	wire [0:0] andOp_141_out;
	andOp #(.WIDTH(1)) andOp_141(.in0(andOp_141_in0), .in1(andOp_141_in1), .out(andOp_141_out));

	reg [0:0] andOp_142_in0;
	reg [0:0] andOp_142_in1;
	wire [0:0] andOp_142_out;
	andOp #(.WIDTH(1)) andOp_142(.in0(andOp_142_in0), .in1(andOp_142_in1), .out(andOp_142_out));

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

	reg [0:0] andOp_147_in0;
	reg [0:0] andOp_147_in1;
	wire [0:0] andOp_147_out;
	andOp #(.WIDTH(1)) andOp_147(.in0(andOp_147_in0), .in1(andOp_147_in1), .out(andOp_147_out));

	reg [0:0] andOp_148_in0;
	reg [0:0] andOp_148_in1;
	wire [0:0] andOp_148_out;
	andOp #(.WIDTH(1)) andOp_148(.in0(andOp_148_in0), .in1(andOp_148_in1), .out(andOp_148_out));

	reg [31:0] eq_149_in0;
	reg [31:0] eq_149_in1;
	wire [0:0] eq_149_out;
	eq #(.WIDTH(32)) eq_149(.in0(eq_149_in0), .in1(eq_149_in1), .out(eq_149_out));

	reg [31:0] andOp_150_in0;
	reg [31:0] andOp_150_in1;
	wire [31:0] andOp_150_out;
	andOp #(.WIDTH(32)) andOp_150(.in0(andOp_150_in0), .in1(andOp_150_in1), .out(andOp_150_out));

	reg [31:0] eq_151_in0;
	reg [31:0] eq_151_in1;
	wire [0:0] eq_151_out;
	eq #(.WIDTH(32)) eq_151(.in0(eq_151_in0), .in1(eq_151_in1), .out(eq_151_out));

	reg [0:0] andOp_152_in0;
	reg [0:0] andOp_152_in1;
	wire [0:0] andOp_152_out;
	andOp #(.WIDTH(1)) andOp_152(.in0(andOp_152_in0), .in1(andOp_152_in1), .out(andOp_152_out));

	reg [0:0] andOp_153_in0;
	reg [0:0] andOp_153_in1;
	wire [0:0] andOp_153_out;
	andOp #(.WIDTH(1)) andOp_153(.in0(andOp_153_in0), .in1(andOp_153_in1), .out(andOp_153_out));

	reg [31:0] eq_154_in0;
	reg [31:0] eq_154_in1;
	wire [0:0] eq_154_out;
	eq #(.WIDTH(32)) eq_154(.in0(eq_154_in0), .in1(eq_154_in1), .out(eq_154_out));

	reg [31:0] andOp_155_in0;
	reg [31:0] andOp_155_in1;
	wire [31:0] andOp_155_out;
	andOp #(.WIDTH(32)) andOp_155(.in0(andOp_155_in0), .in1(andOp_155_in1), .out(andOp_155_out));

	reg [31:0] eq_156_in0;
	reg [31:0] eq_156_in1;
	wire [0:0] eq_156_out;
	eq #(.WIDTH(32)) eq_156(.in0(eq_156_in0), .in1(eq_156_in1), .out(eq_156_out));

	reg [0:0] andOp_157_in0;
	reg [0:0] andOp_157_in1;
	wire [0:0] andOp_157_out;
	andOp #(.WIDTH(1)) andOp_157(.in0(andOp_157_in0), .in1(andOp_157_in1), .out(andOp_157_out));

	reg [31:0] eq_158_in0;
	reg [31:0] eq_158_in1;
	wire [0:0] eq_158_out;
	eq #(.WIDTH(32)) eq_158(.in0(eq_158_in0), .in1(eq_158_in1), .out(eq_158_out));

	reg [0:0] andOp_159_in0;
	reg [0:0] andOp_159_in1;
	wire [0:0] andOp_159_out;
	andOp #(.WIDTH(1)) andOp_159(.in0(andOp_159_in0), .in1(andOp_159_in1), .out(andOp_159_out));

	reg [31:0] eq_160_in0;
	reg [31:0] eq_160_in1;
	wire [0:0] eq_160_out;
	eq #(.WIDTH(32)) eq_160(.in0(eq_160_in0), .in1(eq_160_in1), .out(eq_160_out));

	reg [0:0] andOp_161_in0;
	reg [0:0] andOp_161_in1;
	wire [0:0] andOp_161_out;
	andOp #(.WIDTH(1)) andOp_161(.in0(andOp_161_in0), .in1(andOp_161_in1), .out(andOp_161_out));

	reg [31:0] eq_162_in0;
	reg [31:0] eq_162_in1;
	wire [0:0] eq_162_out;
	eq #(.WIDTH(32)) eq_162(.in0(eq_162_in0), .in1(eq_162_in1), .out(eq_162_out));

	reg [0:0] andOp_163_in0;
	reg [0:0] andOp_163_in1;
	wire [0:0] andOp_163_out;
	andOp #(.WIDTH(1)) andOp_163(.in0(andOp_163_in0), .in1(andOp_163_in1), .out(andOp_163_out));

	reg [31:0] eq_164_in0;
	reg [31:0] eq_164_in1;
	wire [0:0] eq_164_out;
	eq #(.WIDTH(32)) eq_164(.in0(eq_164_in0), .in1(eq_164_in1), .out(eq_164_out));

	reg [0:0] andOp_165_in0;
	reg [0:0] andOp_165_in1;
	wire [0:0] andOp_165_out;
	andOp #(.WIDTH(1)) andOp_165(.in0(andOp_165_in0), .in1(andOp_165_in1), .out(andOp_165_out));

	reg [31:0] eq_166_in0;
	reg [31:0] eq_166_in1;
	wire [0:0] eq_166_out;
	eq #(.WIDTH(32)) eq_166(.in0(eq_166_in0), .in1(eq_166_in1), .out(eq_166_out));

	reg [0:0] andOp_167_in0;
	reg [0:0] andOp_167_in1;
	wire [0:0] andOp_167_out;
	andOp #(.WIDTH(1)) andOp_167(.in0(andOp_167_in0), .in1(andOp_167_in1), .out(andOp_167_out));

	reg [31:0] eq_168_in0;
	reg [31:0] eq_168_in1;
	wire [0:0] eq_168_out;
	eq #(.WIDTH(32)) eq_168(.in0(eq_168_in0), .in1(eq_168_in1), .out(eq_168_out));

	reg [0:0] andOp_169_in0;
	reg [0:0] andOp_169_in1;
	wire [0:0] andOp_169_out;
	andOp #(.WIDTH(1)) andOp_169(.in0(andOp_169_in0), .in1(andOp_169_in1), .out(andOp_169_out));

	reg [31:0] eq_170_in0;
	reg [31:0] eq_170_in1;
	wire [0:0] eq_170_out;
	eq #(.WIDTH(32)) eq_170(.in0(eq_170_in0), .in1(eq_170_in1), .out(eq_170_out));

	reg [0:0] andOp_171_in0;
	reg [0:0] andOp_171_in1;
	wire [0:0] andOp_171_out;
	andOp #(.WIDTH(1)) andOp_171(.in0(andOp_171_in0), .in1(andOp_171_in1), .out(andOp_171_out));

	reg [31:0] andOp_172_in0;
	reg [31:0] andOp_172_in1;
	wire [31:0] andOp_172_out;
	andOp #(.WIDTH(32)) andOp_172(.in0(andOp_172_in0), .in1(andOp_172_in1), .out(andOp_172_out));

	reg [31:0] andOp_173_in0;
	reg [31:0] andOp_173_in1;
	wire [31:0] andOp_173_out;
	andOp #(.WIDTH(32)) andOp_173(.in0(andOp_173_in0), .in1(andOp_173_in1), .out(andOp_173_out));

	reg [31:0] eq_174_in0;
	reg [31:0] eq_174_in1;
	wire [0:0] eq_174_out;
	eq #(.WIDTH(32)) eq_174(.in0(eq_174_in0), .in1(eq_174_in1), .out(eq_174_out));

	reg [0:0] andOp_175_in0;
	reg [0:0] andOp_175_in1;
	wire [0:0] andOp_175_out;
	andOp #(.WIDTH(1)) andOp_175(.in0(andOp_175_in0), .in1(andOp_175_in1), .out(andOp_175_out));

	reg [31:0] eq_176_in0;
	reg [31:0] eq_176_in1;
	wire [0:0] eq_176_out;
	eq #(.WIDTH(32)) eq_176(.in0(eq_176_in0), .in1(eq_176_in1), .out(eq_176_out));

	reg [0:0] andOp_177_in0;
	reg [0:0] andOp_177_in1;
	wire [0:0] andOp_177_out;
	andOp #(.WIDTH(1)) andOp_177(.in0(andOp_177_in0), .in1(andOp_177_in1), .out(andOp_177_out));

	reg [31:0] andOp_178_in0;
	reg [31:0] andOp_178_in1;
	wire [31:0] andOp_178_out;
	andOp #(.WIDTH(32)) andOp_178(.in0(andOp_178_in0), .in1(andOp_178_in1), .out(andOp_178_out));

	reg [31:0] andOp_179_in0;
	reg [31:0] andOp_179_in1;
	wire [31:0] andOp_179_out;
	andOp #(.WIDTH(32)) andOp_179(.in0(andOp_179_in0), .in1(andOp_179_in1), .out(andOp_179_out));

	reg [31:0] eq_180_in0;
	reg [31:0] eq_180_in1;
	wire [0:0] eq_180_out;
	eq #(.WIDTH(32)) eq_180(.in0(eq_180_in0), .in1(eq_180_in1), .out(eq_180_out));

	reg [0:0] andOp_181_in0;
	reg [0:0] andOp_181_in1;
	wire [0:0] andOp_181_out;
	andOp #(.WIDTH(1)) andOp_181(.in0(andOp_181_in0), .in1(andOp_181_in1), .out(andOp_181_out));

	reg [31:0] eq_182_in0;
	reg [31:0] eq_182_in1;
	wire [0:0] eq_182_out;
	eq #(.WIDTH(32)) eq_182(.in0(eq_182_in0), .in1(eq_182_in1), .out(eq_182_out));

	reg [0:0] andOp_183_in0;
	reg [0:0] andOp_183_in1;
	wire [0:0] andOp_183_out;
	andOp #(.WIDTH(1)) andOp_183(.in0(andOp_183_in0), .in1(andOp_183_in1), .out(andOp_183_out));

	reg [31:0] andOp_184_in0;
	reg [31:0] andOp_184_in1;
	wire [31:0] andOp_184_out;
	andOp #(.WIDTH(32)) andOp_184(.in0(andOp_184_in0), .in1(andOp_184_in1), .out(andOp_184_out));

	reg [31:0] andOp_185_in0;
	reg [31:0] andOp_185_in1;
	wire [31:0] andOp_185_out;
	andOp #(.WIDTH(32)) andOp_185(.in0(andOp_185_in0), .in1(andOp_185_in1), .out(andOp_185_out));

	reg [31:0] eq_186_in0;
	reg [31:0] eq_186_in1;
	wire [0:0] eq_186_out;
	eq #(.WIDTH(32)) eq_186(.in0(eq_186_in0), .in1(eq_186_in1), .out(eq_186_out));

	reg [0:0] andOp_187_in0;
	reg [0:0] andOp_187_in1;
	wire [0:0] andOp_187_out;
	andOp #(.WIDTH(1)) andOp_187(.in0(andOp_187_in0), .in1(andOp_187_in1), .out(andOp_187_out));

	reg [31:0] eq_188_in0;
	reg [31:0] eq_188_in1;
	wire [0:0] eq_188_out;
	eq #(.WIDTH(32)) eq_188(.in0(eq_188_in0), .in1(eq_188_in1), .out(eq_188_out));

	reg [0:0] andOp_189_in0;
	reg [0:0] andOp_189_in1;
	wire [0:0] andOp_189_out;
	andOp #(.WIDTH(1)) andOp_189(.in0(andOp_189_in0), .in1(andOp_189_in1), .out(andOp_189_out));

	reg [31:0] eq_190_in0;
	reg [31:0] eq_190_in1;
	wire [0:0] eq_190_out;
	eq #(.WIDTH(32)) eq_190(.in0(eq_190_in0), .in1(eq_190_in1), .out(eq_190_out));

	reg [0:0] andOp_191_in0;
	reg [0:0] andOp_191_in1;
	wire [0:0] andOp_191_out;
	andOp #(.WIDTH(1)) andOp_191(.in0(andOp_191_in0), .in1(andOp_191_in1), .out(andOp_191_out));

	reg [31:0] eq_192_in0;
	reg [31:0] eq_192_in1;
	wire [0:0] eq_192_out;
	eq #(.WIDTH(32)) eq_192(.in0(eq_192_in0), .in1(eq_192_in1), .out(eq_192_out));

	reg [0:0] andOp_193_in0;
	reg [0:0] andOp_193_in1;
	wire [0:0] andOp_193_out;
	andOp #(.WIDTH(1)) andOp_193(.in0(andOp_193_in0), .in1(andOp_193_in1), .out(andOp_193_out));

	reg [31:0] eq_194_in0;
	reg [31:0] eq_194_in1;
	wire [0:0] eq_194_out;
	eq #(.WIDTH(32)) eq_194(.in0(eq_194_in0), .in1(eq_194_in1), .out(eq_194_out));

	reg [0:0] andOp_195_in0;
	reg [0:0] andOp_195_in1;
	wire [0:0] andOp_195_out;
	andOp #(.WIDTH(1)) andOp_195(.in0(andOp_195_in0), .in1(andOp_195_in1), .out(andOp_195_out));

	reg [31:0] eq_196_in0;
	reg [31:0] eq_196_in1;
	wire [0:0] eq_196_out;
	eq #(.WIDTH(32)) eq_196(.in0(eq_196_in0), .in1(eq_196_in1), .out(eq_196_out));

	reg [0:0] andOp_197_in0;
	reg [0:0] andOp_197_in1;
	wire [0:0] andOp_197_out;
	andOp #(.WIDTH(1)) andOp_197(.in0(andOp_197_in0), .in1(andOp_197_in1), .out(andOp_197_out));

	reg [31:0] eq_198_in0;
	reg [31:0] eq_198_in1;
	wire [0:0] eq_198_out;
	eq #(.WIDTH(32)) eq_198(.in0(eq_198_in0), .in1(eq_198_in1), .out(eq_198_out));

	reg [0:0] andOp_199_in0;
	reg [0:0] andOp_199_in1;
	wire [0:0] andOp_199_out;
	andOp #(.WIDTH(1)) andOp_199(.in0(andOp_199_in0), .in1(andOp_199_in1), .out(andOp_199_out));

	reg [31:0] eq_200_in0;
	reg [31:0] eq_200_in1;
	wire [0:0] eq_200_out;
	eq #(.WIDTH(32)) eq_200(.in0(eq_200_in0), .in1(eq_200_in1), .out(eq_200_out));

	reg [0:0] andOp_201_in0;
	reg [0:0] andOp_201_in1;
	wire [0:0] andOp_201_out;
	andOp #(.WIDTH(1)) andOp_201(.in0(andOp_201_in0), .in1(andOp_201_in1), .out(andOp_201_out));

	reg [31:0] eq_202_in0;
	reg [31:0] eq_202_in1;
	wire [0:0] eq_202_out;
	eq #(.WIDTH(32)) eq_202(.in0(eq_202_in0), .in1(eq_202_in1), .out(eq_202_out));

	reg [0:0] andOp_203_in0;
	reg [0:0] andOp_203_in1;
	wire [0:0] andOp_203_out;
	andOp #(.WIDTH(1)) andOp_203(.in0(andOp_203_in0), .in1(andOp_203_in1), .out(andOp_203_out));

	reg [31:0] eq_204_in0;
	reg [31:0] eq_204_in1;
	wire [0:0] eq_204_out;
	eq #(.WIDTH(32)) eq_204(.in0(eq_204_in0), .in1(eq_204_in1), .out(eq_204_out));

	reg [0:0] andOp_205_in0;
	reg [0:0] andOp_205_in1;
	wire [0:0] andOp_205_out;
	andOp #(.WIDTH(1)) andOp_205(.in0(andOp_205_in0), .in1(andOp_205_in1), .out(andOp_205_out));

	reg [31:0] eq_206_in0;
	reg [31:0] eq_206_in1;
	wire [0:0] eq_206_out;
	eq #(.WIDTH(32)) eq_206(.in0(eq_206_in0), .in1(eq_206_in1), .out(eq_206_out));

	reg [0:0] andOp_207_in0;
	reg [0:0] andOp_207_in1;
	wire [0:0] andOp_207_out;
	andOp #(.WIDTH(1)) andOp_207(.in0(andOp_207_in0), .in1(andOp_207_in1), .out(andOp_207_out));

	reg [31:0] eq_208_in0;
	reg [31:0] eq_208_in1;
	wire [0:0] eq_208_out;
	eq #(.WIDTH(32)) eq_208(.in0(eq_208_in0), .in1(eq_208_in1), .out(eq_208_out));

	reg [0:0] andOp_209_in0;
	reg [0:0] andOp_209_in1;
	wire [0:0] andOp_209_out;
	andOp #(.WIDTH(1)) andOp_209(.in0(andOp_209_in0), .in1(andOp_209_in1), .out(andOp_209_out));

	reg [31:0] eq_210_in0;
	reg [31:0] eq_210_in1;
	wire [0:0] eq_210_out;
	eq #(.WIDTH(32)) eq_210(.in0(eq_210_in0), .in1(eq_210_in1), .out(eq_210_out));

	reg [0:0] andOp_211_in0;
	reg [0:0] andOp_211_in1;
	wire [0:0] andOp_211_out;
	andOp #(.WIDTH(1)) andOp_211(.in0(andOp_211_in0), .in1(andOp_211_in1), .out(andOp_211_out));

	reg [31:0] eq_212_in0;
	reg [31:0] eq_212_in1;
	wire [0:0] eq_212_out;
	eq #(.WIDTH(32)) eq_212(.in0(eq_212_in0), .in1(eq_212_in1), .out(eq_212_out));

	reg [0:0] andOp_213_in0;
	reg [0:0] andOp_213_in1;
	wire [0:0] andOp_213_out;
	andOp #(.WIDTH(1)) andOp_213(.in0(andOp_213_in0), .in1(andOp_213_in1), .out(andOp_213_out));

	reg [31:0] eq_214_in0;
	reg [31:0] eq_214_in1;
	wire [0:0] eq_214_out;
	eq #(.WIDTH(32)) eq_214(.in0(eq_214_in0), .in1(eq_214_in1), .out(eq_214_out));

	reg [0:0] andOp_215_in0;
	reg [0:0] andOp_215_in1;
	wire [0:0] andOp_215_out;
	andOp #(.WIDTH(1)) andOp_215(.in0(andOp_215_in0), .in1(andOp_215_in1), .out(andOp_215_out));

	reg [31:0] eq_216_in0;
	reg [31:0] eq_216_in1;
	wire [0:0] eq_216_out;
	eq #(.WIDTH(32)) eq_216(.in0(eq_216_in0), .in1(eq_216_in1), .out(eq_216_out));

	reg [0:0] andOp_217_in0;
	reg [0:0] andOp_217_in1;
	wire [0:0] andOp_217_out;
	andOp #(.WIDTH(1)) andOp_217(.in0(andOp_217_in0), .in1(andOp_217_in1), .out(andOp_217_out));

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
		andOp_101_in0 = valid ? notOp_100_out : notOp_100_out;
		andOp_101_in1 = valid ? andOp_97_out : andOp_97_out;
	end
	// controller for andOp_103.andOp_103_in0
	// controller for andOp_103.andOp_103_in1
	// Insensitive connections
	always @(*) begin
		andOp_103_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
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
		andOp_107_in0 = valid ? notOp_106_out : notOp_106_out;
		andOp_107_in1 = valid ? andOp_103_out : andOp_103_out;
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
		andOp_111_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_111_in1 = valid ? eq_110_out : eq_110_out;
	end
	// controller for andOp_112.andOp_112_in0
	// controller for andOp_112.andOp_112_in1
	// Insensitive connections
	always @(*) begin
		andOp_112_in0 = valid ? andOp_111_out : andOp_111_out;
		andOp_112_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	always @(*) begin
		andOp_114_in0 = valid ? eq_113_out : eq_113_out;
		andOp_114_in1 = valid ? andOp_112_out : andOp_112_out;
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
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? andOp_8_out : andOp_8_out;
		andOp_12_in1 = valid ? tmp_output_9_out_data : tmp_output_9_out_data;
	end
	// controller for andOp_120.andOp_120_in0
	// controller for andOp_120.andOp_120_in1
	// Insensitive connections
	always @(*) begin
		andOp_120_in0 = valid ? andOp_119_out : andOp_119_out;
		andOp_120_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_122_in1 = valid ? eq_121_out : eq_121_out;
	end
	// controller for andOp_123.andOp_123_in0
	// controller for andOp_123.andOp_123_in1
	// Insensitive connections
	always @(*) begin
		andOp_123_in0 = valid ? andOp_122_out : andOp_122_out;
		andOp_123_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? eq_124_out : eq_124_out;
		andOp_125_in1 = valid ? andOp_123_out : andOp_123_out;
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
		andOp_128_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? eq_129_out : eq_129_out;
		andOp_130_in1 = valid ? andOp_128_out : andOp_128_out;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_133_in1 = valid ? eq_132_out : eq_132_out;
	end
	// controller for andOp_134.andOp_134_in0
	// controller for andOp_134.andOp_134_in1
	// Insensitive connections
	always @(*) begin
		andOp_134_in0 = valid ? andOp_133_out : andOp_133_out;
		andOp_134_in1 = valid ? notOp_131_out : notOp_131_out;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? eq_135_out : eq_135_out;
		andOp_139_in1 = valid ? andOp_134_out : andOp_134_out;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? andOp_12_out : andOp_12_out;
		andOp_14_in1 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_141_in1 = valid ? eq_140_out : eq_140_out;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? andOp_141_out : andOp_141_out;
		andOp_142_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? eq_143_out : eq_143_out;
		andOp_144_in1 = valid ? andOp_142_out : andOp_142_out;
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
		andOp_147_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_147_in1 = valid ? eq_146_out : eq_146_out;
	end
	// controller for andOp_148.andOp_148_in0
	// controller for andOp_148.andOp_148_in1
	// Insensitive connections
	always @(*) begin
		andOp_148_in0 = valid ? andOp_147_out : andOp_147_out;
		andOp_148_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_150.andOp_150_in0
	// controller for andOp_150.andOp_150_in1
	// Insensitive connections
	always @(*) begin
		andOp_150_in0 = valid ? eq_149_out : eq_149_out;
		andOp_150_in1 = valid ? andOp_148_out : andOp_148_out;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_152_in1 = valid ? eq_151_out : eq_151_out;
	end
	// controller for andOp_153.andOp_153_in0
	// controller for andOp_153.andOp_153_in1
	// Insensitive connections
	always @(*) begin
		andOp_153_in0 = valid ? andOp_152_out : andOp_152_out;
		andOp_153_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_155.andOp_155_in0
	// controller for andOp_155.andOp_155_in1
	// Insensitive connections
	always @(*) begin
		andOp_155_in0 = valid ? eq_154_out : eq_154_out;
		andOp_155_in1 = valid ? andOp_153_out : andOp_153_out;
	end
	// controller for andOp_157.andOp_157_in0
	// controller for andOp_157.andOp_157_in1
	// Insensitive connections
	always @(*) begin
		andOp_157_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_157_in1 = valid ? eq_156_out : eq_156_out;
	end
	// controller for andOp_159.andOp_159_in0
	// controller for andOp_159.andOp_159_in1
	// Insensitive connections
	always @(*) begin
		andOp_159_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_159_in1 = valid ? eq_158_out : eq_158_out;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? andOp_12_out : andOp_12_out;
		andOp_16_in1 = valid ? notOp_15_out : notOp_15_out;
	end
	// controller for andOp_161.andOp_161_in0
	// controller for andOp_161.andOp_161_in1
	// Insensitive connections
	always @(*) begin
		andOp_161_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_161_in1 = valid ? eq_160_out : eq_160_out;
	end
	// controller for andOp_163.andOp_163_in0
	// controller for andOp_163.andOp_163_in1
	// Insensitive connections
	always @(*) begin
		andOp_163_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_163_in1 = valid ? eq_162_out : eq_162_out;
	end
	// controller for andOp_165.andOp_165_in0
	// controller for andOp_165.andOp_165_in1
	// Insensitive connections
	always @(*) begin
		andOp_165_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_165_in1 = valid ? eq_164_out : eq_164_out;
	end
	// controller for andOp_167.andOp_167_in0
	// controller for andOp_167.andOp_167_in1
	// Insensitive connections
	always @(*) begin
		andOp_167_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_167_in1 = valid ? eq_166_out : eq_166_out;
	end
	// controller for andOp_169.andOp_169_in0
	// controller for andOp_169.andOp_169_in1
	// Insensitive connections
	always @(*) begin
		andOp_169_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_169_in1 = valid ? eq_168_out : eq_168_out;
	end
	// controller for andOp_171.andOp_171_in0
	// controller for andOp_171.andOp_171_in1
	// Insensitive connections
	always @(*) begin
		andOp_171_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_171_in1 = valid ? eq_170_out : eq_170_out;
	end
	// controller for andOp_172.andOp_172_in0
	// controller for andOp_172.andOp_172_in1
	// Insensitive connections
	always @(*) begin
		andOp_172_in0 = valid ? andOp_169_out : andOp_169_out;
		andOp_172_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_173.andOp_173_in0
	// controller for andOp_173.andOp_173_in1
	// Insensitive connections
	always @(*) begin
		andOp_173_in0 = valid ? andOp_172_out : andOp_172_out;
		andOp_173_in1 = valid ? andOp_171_out : andOp_171_out;
	end
	// controller for andOp_175.andOp_175_in0
	// controller for andOp_175.andOp_175_in1
	// Insensitive connections
	always @(*) begin
		andOp_175_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_175_in1 = valid ? eq_174_out : eq_174_out;
	end
	// controller for andOp_177.andOp_177_in0
	// controller for andOp_177.andOp_177_in1
	// Insensitive connections
	always @(*) begin
		andOp_177_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_177_in1 = valid ? eq_176_out : eq_176_out;
	end
	// controller for andOp_178.andOp_178_in0
	// controller for andOp_178.andOp_178_in1
	// Insensitive connections
	always @(*) begin
		andOp_178_in0 = valid ? andOp_175_out : andOp_175_out;
		andOp_178_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_179.andOp_179_in0
	// controller for andOp_179.andOp_179_in1
	// Insensitive connections
	always @(*) begin
		andOp_179_in0 = valid ? andOp_178_out : andOp_178_out;
		andOp_179_in1 = valid ? andOp_177_out : andOp_177_out;
	end
	// controller for andOp_181.andOp_181_in0
	// controller for andOp_181.andOp_181_in1
	// Insensitive connections
	always @(*) begin
		andOp_181_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_181_in1 = valid ? eq_180_out : eq_180_out;
	end
	// controller for andOp_183.andOp_183_in0
	// controller for andOp_183.andOp_183_in1
	// Insensitive connections
	always @(*) begin
		andOp_183_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_183_in1 = valid ? eq_182_out : eq_182_out;
	end
	// controller for andOp_184.andOp_184_in0
	// controller for andOp_184.andOp_184_in1
	// Insensitive connections
	always @(*) begin
		andOp_184_in0 = valid ? andOp_181_out : andOp_181_out;
		andOp_184_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_185.andOp_185_in0
	// controller for andOp_185.andOp_185_in1
	// Insensitive connections
	always @(*) begin
		andOp_185_in0 = valid ? andOp_184_out : andOp_184_out;
		andOp_185_in1 = valid ? andOp_183_out : andOp_183_out;
	end
	// controller for andOp_187.andOp_187_in0
	// controller for andOp_187.andOp_187_in1
	// Insensitive connections
	always @(*) begin
		andOp_187_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_187_in1 = valid ? eq_186_out : eq_186_out;
	end
	// controller for andOp_189.andOp_189_in0
	// controller for andOp_189.andOp_189_in1
	// Insensitive connections
	always @(*) begin
		andOp_189_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_189_in1 = valid ? eq_188_out : eq_188_out;
	end
	// controller for andOp_191.andOp_191_in0
	// controller for andOp_191.andOp_191_in1
	// Insensitive connections
	always @(*) begin
		andOp_191_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_191_in1 = valid ? eq_190_out : eq_190_out;
	end
	// controller for andOp_193.andOp_193_in0
	// controller for andOp_193.andOp_193_in1
	// Insensitive connections
	always @(*) begin
		andOp_193_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_193_in1 = valid ? eq_192_out : eq_192_out;
	end
	// controller for andOp_195.andOp_195_in0
	// controller for andOp_195.andOp_195_in1
	// Insensitive connections
	always @(*) begin
		andOp_195_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_195_in1 = valid ? eq_194_out : eq_194_out;
	end
	// controller for andOp_197.andOp_197_in0
	// controller for andOp_197.andOp_197_in1
	// Insensitive connections
	always @(*) begin
		andOp_197_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_197_in1 = valid ? eq_196_out : eq_196_out;
	end
	// controller for andOp_199.andOp_199_in0
	// controller for andOp_199.andOp_199_in1
	// Insensitive connections
	always @(*) begin
		andOp_199_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_199_in1 = valid ? eq_198_out : eq_198_out;
	end
	// controller for andOp_201.andOp_201_in0
	// controller for andOp_201.andOp_201_in1
	// Insensitive connections
	always @(*) begin
		andOp_201_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_201_in1 = valid ? eq_200_out : eq_200_out;
	end
	// controller for andOp_203.andOp_203_in0
	// controller for andOp_203.andOp_203_in1
	// Insensitive connections
	always @(*) begin
		andOp_203_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_203_in1 = valid ? eq_202_out : eq_202_out;
	end
	// controller for andOp_205.andOp_205_in0
	// controller for andOp_205.andOp_205_in1
	// Insensitive connections
	always @(*) begin
		andOp_205_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_205_in1 = valid ? eq_204_out : eq_204_out;
	end
	// controller for andOp_207.andOp_207_in0
	// controller for andOp_207.andOp_207_in1
	// Insensitive connections
	always @(*) begin
		andOp_207_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_207_in1 = valid ? eq_206_out : eq_206_out;
	end
	// controller for andOp_209.andOp_209_in0
	// controller for andOp_209.andOp_209_in1
	// Insensitive connections
	always @(*) begin
		andOp_209_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_209_in1 = valid ? eq_208_out : eq_208_out;
	end
	// controller for andOp_211.andOp_211_in0
	// controller for andOp_211.andOp_211_in1
	// Insensitive connections
	always @(*) begin
		andOp_211_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_211_in1 = valid ? eq_210_out : eq_210_out;
	end
	// controller for andOp_213.andOp_213_in0
	// controller for andOp_213.andOp_213_in1
	// Insensitive connections
	always @(*) begin
		andOp_213_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_213_in1 = valid ? eq_212_out : eq_212_out;
	end
	// controller for andOp_215.andOp_215_in0
	// controller for andOp_215.andOp_215_in1
	// Insensitive connections
	always @(*) begin
		andOp_215_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_215_in1 = valid ? eq_214_out : eq_214_out;
	end
	// controller for andOp_217.andOp_217_in0
	// controller for andOp_217.andOp_217_in1
	// Insensitive connections
	always @(*) begin
		andOp_217_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_217_in1 = valid ? eq_216_out : eq_216_out;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_23_in1 = valid ? eq_22_out : eq_22_out;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_25_in1 = valid ? eq_24_out : eq_24_out;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_27_in1 = valid ? eq_26_out : eq_26_out;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_29_in1 = valid ? eq_28_out : eq_28_out;
	end
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	always @(*) begin
		andOp_31_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_31_in1 = valid ? eq_30_out : eq_30_out;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_33_in1 = valid ? eq_32_out : eq_32_out;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_35_in1 = valid ? eq_34_out : eq_34_out;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? notOp_38_out : notOp_38_out;
		andOp_39_in1 = valid ? andOp_14_out : andOp_14_out;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? notOp_41_out : notOp_41_out;
		andOp_42_in1 = valid ? andOp_5_out : andOp_5_out;
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
		andOp_46_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_46_in1 = valid ? eq_45_out : eq_45_out;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_48_in1 = valid ? eq_47_out : eq_47_out;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? in_read_ready : in_read_ready;
		andOp_49_in1 = valid ? andOp_48_out : andOp_48_out;
	end
	// controller for andOp_5.andOp_5_in0
	// controller for andOp_5.andOp_5_in1
	// Insensitive connections
	always @(*) begin
		andOp_5_in0 = valid ? andOp_1_out : andOp_1_out;
		andOp_5_in1 = valid ? tmp_output_2_out_data : tmp_output_2_out_data;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_51_in1 = valid ? eq_50_out : eq_50_out;
	end
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	always @(*) begin
		andOp_53_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_53_in1 = valid ? eq_52_out : eq_52_out;
	end
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	always @(*) begin
		andOp_55_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_55_in1 = valid ? eq_54_out : eq_54_out;
	end
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	always @(*) begin
		andOp_57_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_57_in1 = valid ? eq_56_out : eq_56_out;
	end
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_59_in1 = valid ? eq_58_out : eq_58_out;
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
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? in_read_ready : in_read_ready;
		andOp_66_in1 = valid ? andOp_65_out : andOp_65_out;
	end
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	always @(*) begin
		andOp_68_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_68_in1 = valid ? eq_67_out : eq_67_out;
	end
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	always @(*) begin
		andOp_69_in0 = valid ? in_read_ready : in_read_ready;
		andOp_69_in1 = valid ? andOp_68_out : andOp_68_out;
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
		andOp_75_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_75_in1 = valid ? eq_74_out : eq_74_out;
	end
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	always @(*) begin
		andOp_77_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_77_in1 = valid ? eq_76_out : eq_76_out;
	end
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	always @(*) begin
		andOp_79_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_79_in1 = valid ? eq_78_out : eq_78_out;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_8_in1 = valid ? eq_7_out : eq_7_out;
	end
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	always @(*) begin
		andOp_81_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_81_in1 = valid ? eq_80_out : eq_80_out;
	end
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	always @(*) begin
		andOp_82_in0 = valid ? out_write_ready : out_write_ready;
		andOp_82_in1 = valid ? andOp_81_out : andOp_81_out;
	end
	// controller for andOp_84.andOp_84_in0
	// controller for andOp_84.andOp_84_in1
	// Insensitive connections
	always @(*) begin
		andOp_84_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_84_in1 = valid ? eq_83_out : eq_83_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? out_write_ready : out_write_ready;
		andOp_85_in1 = valid ? andOp_84_out : andOp_84_out;
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
		andOp_91_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_91_in1 = valid ? eq_90_out : eq_90_out;
	end
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	always @(*) begin
		andOp_93_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_93_in1 = valid ? eq_92_out : eq_92_out;
	end
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	always @(*) begin
		andOp_95_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_95_in1 = valid ? eq_94_out : eq_94_out;
	end
	// controller for andOp_97.andOp_97_in0
	// controller for andOp_97.andOp_97_in1
	// Insensitive connections
	always @(*) begin
		andOp_97_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_97_in1 = valid ? eq_96_out : eq_96_out;
	end
	// controller for andOp_99.andOp_99_in0
	// controller for andOp_99.andOp_99_in1
	// Insensitive connections
	always @(*) begin
		andOp_99_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_99_in1 = valid ? eq_98_out : eq_98_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_17_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_0_predecessor.bb_0_predecessor_in_data
	always @(*) begin
		if (eq_36_out) begin 
			bb_0_predecessor_in_data = last_BB_reg;
		end else begin
			bb_0_predecessor_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = orOp_19_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_1_predecessor.bb_1_predecessor_in_data
	always @(*) begin
		if (andOp_39_out) begin 
			bb_1_predecessor_in_data = 32'd2;
		end else if (eq_37_out) begin 
			bb_1_predecessor_in_data = last_BB_reg;
		end else begin
			bb_1_predecessor_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = orOp_21_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for bb_2_predecessor.bb_2_predecessor_in_data
	always @(*) begin
		if (andOp_42_out) begin 
			bb_2_predecessor_in_data = 32'd0;
		end else if (eq_40_out) begin 
			bb_2_predecessor_in_data = last_BB_reg;
		end else begin
			bb_2_predecessor_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (andOp_5_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_6_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_2_happened.br_2_happened_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_2_happened_in_data = 1'd1;
		end else if (notOp_13_out) begin 
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
		eq_10_in0 = valid ? 32'd2 : 32'd2;
		eq_10_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_102.eq_102_in0
	// controller for eq_102.eq_102_in1
	// Insensitive connections
	always @(*) begin
		eq_102_in0 = valid ? 32'd4 : 32'd4;
		eq_102_in1 = valid ? global_state : global_state;
	end
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	always @(*) begin
		eq_104_in0 = valid ? 32'd4 : 32'd4;
		eq_104_in1 = valid ? global_state : global_state;
	end
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	always @(*) begin
		eq_108_in0 = valid ? 32'd6 : 32'd6;
		eq_108_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd1 : 32'd1;
		eq_11_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_110.eq_110_in0
	// controller for eq_110.eq_110_in1
	// Insensitive connections
	always @(*) begin
		eq_110_in0 = valid ? 32'd0 : 32'd0;
		eq_110_in1 = valid ? global_state : global_state;
	end
	// controller for eq_113.eq_113_in0
	// controller for eq_113.eq_113_in1
	// Insensitive connections
	always @(*) begin
		eq_113_in0 = valid ? 32'd0 : 32'd0;
		eq_113_in1 = valid ? global_state : global_state;
	end
	// controller for eq_115.eq_115_in0
	// controller for eq_115.eq_115_in1
	// Insensitive connections
	always @(*) begin
		eq_115_in0 = valid ? 32'd1 : 32'd1;
		eq_115_in1 = valid ? global_state : global_state;
	end
	// controller for eq_118.eq_118_in0
	// controller for eq_118.eq_118_in1
	// Insensitive connections
	always @(*) begin
		eq_118_in0 = valid ? 32'd1 : 32'd1;
		eq_118_in1 = valid ? global_state : global_state;
	end
	// controller for eq_121.eq_121_in0
	// controller for eq_121.eq_121_in1
	// Insensitive connections
	always @(*) begin
		eq_121_in0 = valid ? 32'd2 : 32'd2;
		eq_121_in1 = valid ? global_state : global_state;
	end
	// controller for eq_124.eq_124_in0
	// controller for eq_124.eq_124_in1
	// Insensitive connections
	always @(*) begin
		eq_124_in0 = valid ? 32'd2 : 32'd2;
		eq_124_in1 = valid ? global_state : global_state;
	end
	// controller for eq_126.eq_126_in0
	// controller for eq_126.eq_126_in1
	// Insensitive connections
	always @(*) begin
		eq_126_in0 = valid ? 32'd3 : 32'd3;
		eq_126_in1 = valid ? global_state : global_state;
	end
	// controller for eq_129.eq_129_in0
	// controller for eq_129.eq_129_in1
	// Insensitive connections
	always @(*) begin
		eq_129_in0 = valid ? 32'd3 : 32'd3;
		eq_129_in1 = valid ? global_state : global_state;
	end
	// controller for eq_132.eq_132_in0
	// controller for eq_132.eq_132_in1
	// Insensitive connections
	always @(*) begin
		eq_132_in0 = valid ? 32'd4 : 32'd4;
		eq_132_in1 = valid ? global_state : global_state;
	end
	// controller for eq_135.eq_135_in0
	// controller for eq_135.eq_135_in1
	// Insensitive connections
	always @(*) begin
		eq_135_in0 = valid ? 32'd4 : 32'd4;
		eq_135_in1 = valid ? global_state : global_state;
	end
	// controller for eq_137.eq_137_in0
	// controller for eq_137.eq_137_in1
	// Insensitive connections
	always @(*) begin
		eq_137_in0 = valid ? 32'd2 : 32'd2;
		eq_137_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_138.eq_138_in0
	// controller for eq_138.eq_138_in1
	// Insensitive connections
	always @(*) begin
		eq_138_in0 = valid ? 32'd1 : 32'd1;
		eq_138_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_140.eq_140_in0
	// controller for eq_140.eq_140_in1
	// Insensitive connections
	always @(*) begin
		eq_140_in0 = valid ? 32'd4 : 32'd4;
		eq_140_in1 = valid ? global_state : global_state;
	end
	// controller for eq_143.eq_143_in0
	// controller for eq_143.eq_143_in1
	// Insensitive connections
	always @(*) begin
		eq_143_in0 = valid ? 32'd4 : 32'd4;
		eq_143_in1 = valid ? global_state : global_state;
	end
	// controller for eq_146.eq_146_in0
	// controller for eq_146.eq_146_in1
	// Insensitive connections
	always @(*) begin
		eq_146_in0 = valid ? 32'd5 : 32'd5;
		eq_146_in1 = valid ? global_state : global_state;
	end
	// controller for eq_149.eq_149_in0
	// controller for eq_149.eq_149_in1
	// Insensitive connections
	always @(*) begin
		eq_149_in0 = valid ? 32'd5 : 32'd5;
		eq_149_in1 = valid ? global_state : global_state;
	end
	// controller for eq_151.eq_151_in0
	// controller for eq_151.eq_151_in1
	// Insensitive connections
	always @(*) begin
		eq_151_in0 = valid ? 32'd6 : 32'd6;
		eq_151_in1 = valid ? global_state : global_state;
	end
	// controller for eq_154.eq_154_in0
	// controller for eq_154.eq_154_in1
	// Insensitive connections
	always @(*) begin
		eq_154_in0 = valid ? 32'd6 : 32'd6;
		eq_154_in1 = valid ? global_state : global_state;
	end
	// controller for eq_156.eq_156_in0
	// controller for eq_156.eq_156_in1
	// Insensitive connections
	always @(*) begin
		eq_156_in0 = valid ? 32'd0 : 32'd0;
		eq_156_in1 = valid ? global_state : global_state;
	end
	// controller for eq_158.eq_158_in0
	// controller for eq_158.eq_158_in1
	// Insensitive connections
	always @(*) begin
		eq_158_in0 = valid ? 32'd0 : 32'd0;
		eq_158_in1 = valid ? global_state : global_state;
	end
	// controller for eq_160.eq_160_in0
	// controller for eq_160.eq_160_in1
	// Insensitive connections
	always @(*) begin
		eq_160_in0 = valid ? 32'd0 : 32'd0;
		eq_160_in1 = valid ? global_state : global_state;
	end
	// controller for eq_162.eq_162_in0
	// controller for eq_162.eq_162_in1
	// Insensitive connections
	always @(*) begin
		eq_162_in0 = valid ? 32'd1 : 32'd1;
		eq_162_in1 = valid ? global_state : global_state;
	end
	// controller for eq_164.eq_164_in0
	// controller for eq_164.eq_164_in1
	// Insensitive connections
	always @(*) begin
		eq_164_in0 = valid ? 32'd1 : 32'd1;
		eq_164_in1 = valid ? global_state : global_state;
	end
	// controller for eq_166.eq_166_in0
	// controller for eq_166.eq_166_in1
	// Insensitive connections
	always @(*) begin
		eq_166_in0 = valid ? 32'd1 : 32'd1;
		eq_166_in1 = valid ? global_state : global_state;
	end
	// controller for eq_168.eq_168_in0
	// controller for eq_168.eq_168_in1
	// Insensitive connections
	always @(*) begin
		eq_168_in0 = valid ? 32'd1 : 32'd1;
		eq_168_in1 = valid ? global_state : global_state;
	end
	// controller for eq_17.eq_17_in0
	// controller for eq_17.eq_17_in1
	// Insensitive connections
	always @(*) begin
		eq_17_in0 = valid ? 32'd0 : 32'd0;
		eq_17_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_170.eq_170_in0
	// controller for eq_170.eq_170_in1
	// Insensitive connections
	always @(*) begin
		eq_170_in0 = valid ? 32'd1 : 32'd1;
		eq_170_in1 = valid ? global_state : global_state;
	end
	// controller for eq_174.eq_174_in0
	// controller for eq_174.eq_174_in1
	// Insensitive connections
	always @(*) begin
		eq_174_in0 = valid ? 32'd1 : 32'd1;
		eq_174_in1 = valid ? global_state : global_state;
	end
	// controller for eq_176.eq_176_in0
	// controller for eq_176.eq_176_in1
	// Insensitive connections
	always @(*) begin
		eq_176_in0 = valid ? 32'd1 : 32'd1;
		eq_176_in1 = valid ? global_state : global_state;
	end
	// controller for eq_18.eq_18_in0
	// controller for eq_18.eq_18_in1
	// Insensitive connections
	always @(*) begin
		eq_18_in0 = valid ? 32'd1 : 32'd1;
		eq_18_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_180.eq_180_in0
	// controller for eq_180.eq_180_in1
	// Insensitive connections
	always @(*) begin
		eq_180_in0 = valid ? 32'd1 : 32'd1;
		eq_180_in1 = valid ? global_state : global_state;
	end
	// controller for eq_182.eq_182_in0
	// controller for eq_182.eq_182_in1
	// Insensitive connections
	always @(*) begin
		eq_182_in0 = valid ? 32'd1 : 32'd1;
		eq_182_in1 = valid ? global_state : global_state;
	end
	// controller for eq_186.eq_186_in0
	// controller for eq_186.eq_186_in1
	// Insensitive connections
	always @(*) begin
		eq_186_in0 = valid ? 32'd1 : 32'd1;
		eq_186_in1 = valid ? global_state : global_state;
	end
	// controller for eq_188.eq_188_in0
	// controller for eq_188.eq_188_in1
	// Insensitive connections
	always @(*) begin
		eq_188_in0 = valid ? 32'd1 : 32'd1;
		eq_188_in1 = valid ? global_state : global_state;
	end
	// controller for eq_190.eq_190_in0
	// controller for eq_190.eq_190_in1
	// Insensitive connections
	always @(*) begin
		eq_190_in0 = valid ? 32'd2 : 32'd2;
		eq_190_in1 = valid ? global_state : global_state;
	end
	// controller for eq_192.eq_192_in0
	// controller for eq_192.eq_192_in1
	// Insensitive connections
	always @(*) begin
		eq_192_in0 = valid ? 32'd3 : 32'd3;
		eq_192_in1 = valid ? global_state : global_state;
	end
	// controller for eq_194.eq_194_in0
	// controller for eq_194.eq_194_in1
	// Insensitive connections
	always @(*) begin
		eq_194_in0 = valid ? 32'd3 : 32'd3;
		eq_194_in1 = valid ? global_state : global_state;
	end
	// controller for eq_196.eq_196_in0
	// controller for eq_196.eq_196_in1
	// Insensitive connections
	always @(*) begin
		eq_196_in0 = valid ? 32'd3 : 32'd3;
		eq_196_in1 = valid ? global_state : global_state;
	end
	// controller for eq_198.eq_198_in0
	// controller for eq_198.eq_198_in1
	// Insensitive connections
	always @(*) begin
		eq_198_in0 = valid ? 32'd4 : 32'd4;
		eq_198_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd2 : 32'd2;
		eq_20_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_200.eq_200_in0
	// controller for eq_200.eq_200_in1
	// Insensitive connections
	always @(*) begin
		eq_200_in0 = valid ? 32'd4 : 32'd4;
		eq_200_in1 = valid ? global_state : global_state;
	end
	// controller for eq_202.eq_202_in0
	// controller for eq_202.eq_202_in1
	// Insensitive connections
	always @(*) begin
		eq_202_in0 = valid ? 32'd4 : 32'd4;
		eq_202_in1 = valid ? global_state : global_state;
	end
	// controller for eq_204.eq_204_in0
	// controller for eq_204.eq_204_in1
	// Insensitive connections
	always @(*) begin
		eq_204_in0 = valid ? 32'd4 : 32'd4;
		eq_204_in1 = valid ? global_state : global_state;
	end
	// controller for eq_206.eq_206_in0
	// controller for eq_206.eq_206_in1
	// Insensitive connections
	always @(*) begin
		eq_206_in0 = valid ? 32'd4 : 32'd4;
		eq_206_in1 = valid ? global_state : global_state;
	end
	// controller for eq_208.eq_208_in0
	// controller for eq_208.eq_208_in1
	// Insensitive connections
	always @(*) begin
		eq_208_in0 = valid ? 32'd5 : 32'd5;
		eq_208_in1 = valid ? global_state : global_state;
	end
	// controller for eq_210.eq_210_in0
	// controller for eq_210.eq_210_in1
	// Insensitive connections
	always @(*) begin
		eq_210_in0 = valid ? 32'd5 : 32'd5;
		eq_210_in1 = valid ? global_state : global_state;
	end
	// controller for eq_212.eq_212_in0
	// controller for eq_212.eq_212_in1
	// Insensitive connections
	always @(*) begin
		eq_212_in0 = valid ? 32'd5 : 32'd5;
		eq_212_in1 = valid ? global_state : global_state;
	end
	// controller for eq_214.eq_214_in0
	// controller for eq_214.eq_214_in1
	// Insensitive connections
	always @(*) begin
		eq_214_in0 = valid ? 32'd6 : 32'd6;
		eq_214_in1 = valid ? global_state : global_state;
	end
	// controller for eq_216.eq_216_in0
	// controller for eq_216.eq_216_in1
	// Insensitive connections
	always @(*) begin
		eq_216_in0 = valid ? 32'd6 : 32'd6;
		eq_216_in1 = valid ? global_state : global_state;
	end
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	always @(*) begin
		eq_22_in0 = valid ? 32'd0 : 32'd0;
		eq_22_in1 = valid ? global_state : global_state;
	end
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	always @(*) begin
		eq_24_in0 = valid ? 32'd1 : 32'd1;
		eq_24_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd2 : 32'd2;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd3 : 32'd3;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd2 : 32'd2;
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
		eq_32_in0 = valid ? 32'd5 : 32'd5;
		eq_32_in1 = valid ? global_state : global_state;
	end
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	always @(*) begin
		eq_34_in0 = valid ? 32'd6 : 32'd6;
		eq_34_in1 = valid ? global_state : global_state;
	end
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	always @(*) begin
		eq_36_in0 = valid ? 32'd0 : 32'd0;
		eq_36_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	always @(*) begin
		eq_37_in0 = valid ? 32'd1 : 32'd1;
		eq_37_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd0 : 32'd0;
		eq_4_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_40.eq_40_in0
	// controller for eq_40.eq_40_in1
	// Insensitive connections
	always @(*) begin
		eq_40_in0 = valid ? 32'd2 : 32'd2;
		eq_40_in1 = valid ? global_next_block : global_next_block;
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
		eq_45_in0 = valid ? 32'd0 : 32'd0;
		eq_45_in1 = valid ? global_state : global_state;
	end
	// controller for eq_47.eq_47_in0
	// controller for eq_47.eq_47_in1
	// Insensitive connections
	always @(*) begin
		eq_47_in0 = valid ? 32'd1 : 32'd1;
		eq_47_in1 = valid ? global_state : global_state;
	end
	// controller for eq_50.eq_50_in0
	// controller for eq_50.eq_50_in1
	// Insensitive connections
	always @(*) begin
		eq_50_in0 = valid ? 32'd3 : 32'd3;
		eq_50_in1 = valid ? global_state : global_state;
	end
	// controller for eq_52.eq_52_in0
	// controller for eq_52.eq_52_in1
	// Insensitive connections
	always @(*) begin
		eq_52_in0 = valid ? 32'd5 : 32'd5;
		eq_52_in1 = valid ? global_state : global_state;
	end
	// controller for eq_54.eq_54_in0
	// controller for eq_54.eq_54_in1
	// Insensitive connections
	always @(*) begin
		eq_54_in0 = valid ? 32'd0 : 32'd0;
		eq_54_in1 = valid ? global_state : global_state;
	end
	// controller for eq_56.eq_56_in0
	// controller for eq_56.eq_56_in1
	// Insensitive connections
	always @(*) begin
		eq_56_in0 = valid ? 32'd0 : 32'd0;
		eq_56_in1 = valid ? global_state : global_state;
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
		eq_64_in0 = valid ? 32'd1 : 32'd1;
		eq_64_in1 = valid ? global_state : global_state;
	end
	// controller for eq_67.eq_67_in0
	// controller for eq_67.eq_67_in1
	// Insensitive connections
	always @(*) begin
		eq_67_in0 = valid ? 32'd1 : 32'd1;
		eq_67_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd4 : 32'd4;
		eq_7_in1 = valid ? global_state : global_state;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd2 : 32'd2;
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
		eq_74_in0 = valid ? 32'd3 : 32'd3;
		eq_74_in1 = valid ? global_state : global_state;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd1 : 32'd1;
		eq_76_in1 = valid ? global_state : global_state;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd3 : 32'd3;
		eq_78_in1 = valid ? global_state : global_state;
	end
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	always @(*) begin
		eq_80_in0 = valid ? 32'd4 : 32'd4;
		eq_80_in1 = valid ? global_state : global_state;
	end
	// controller for eq_83.eq_83_in0
	// controller for eq_83.eq_83_in1
	// Insensitive connections
	always @(*) begin
		eq_83_in0 = valid ? 32'd4 : 32'd4;
		eq_83_in1 = valid ? global_state : global_state;
	end
	// controller for eq_86.eq_86_in0
	// controller for eq_86.eq_86_in1
	// Insensitive connections
	always @(*) begin
		eq_86_in0 = valid ? 32'd5 : 32'd5;
		eq_86_in1 = valid ? global_state : global_state;
	end
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	always @(*) begin
		eq_88_in0 = valid ? 32'd5 : 32'd5;
		eq_88_in1 = valid ? global_state : global_state;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd6 : 32'd6;
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
		eq_94_in0 = valid ? 32'd6 : 32'd6;
		eq_94_in1 = valid ? global_state : global_state;
	end
	// controller for eq_96.eq_96_in0
	// controller for eq_96.eq_96_in1
	// Insensitive connections
	always @(*) begin
		eq_96_in0 = valid ? 32'd1 : 32'd1;
		eq_96_in1 = valid ? global_state : global_state;
	end
	// controller for eq_98.eq_98_in0
	// controller for eq_98.eq_98_in1
	// Insensitive connections
	always @(*) begin
		eq_98_in0 = valid ? 32'd1 : 32'd1;
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
		if (andOp_71_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (andOp_73_out) begin 
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
	// controller for notOp_106.notOp_106_in0
	// Insensitive connections
	always @(*) begin
		notOp_106_in0 = valid ? andOp_105_out : andOp_105_out;
	end
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	always @(*) begin
		notOp_13_in0 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for notOp_131.notOp_131_in0
	// Insensitive connections
	always @(*) begin
		notOp_131_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_15.notOp_15_in0
	// Insensitive connections
	always @(*) begin
		notOp_15_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_38.notOp_38_in0
	// Insensitive connections
	always @(*) begin
		notOp_38_in0 = valid ? eq_37_out : eq_37_out;
	end
	// controller for notOp_41.notOp_41_in0
	// Insensitive connections
	always @(*) begin
		notOp_41_in0 = valid ? eq_40_out : eq_40_out;
	end
	// controller for notOp_6.notOp_6_in0
	// Insensitive connections
	always @(*) begin
		notOp_6_in0 = valid ? andOp_5_out : andOp_5_out;
	end
	// controller for orOp_19.orOp_19_in0
	// controller for orOp_19.orOp_19_in1
	// Insensitive connections
	always @(*) begin
		orOp_19_in0 = valid ? eq_18_out : eq_18_out;
		orOp_19_in1 = valid ? andOp_14_out : andOp_14_out;
	end
	// controller for orOp_21.orOp_21_in0
	// controller for orOp_21.orOp_21_in1
	// Insensitive connections
	always @(*) begin
		orOp_21_in0 = valid ? eq_20_out : eq_20_out;
		orOp_21_in1 = valid ? andOp_5_out : andOp_5_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_89_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_87_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (andOp_91_out) begin 
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
		if (andOp_49_out) begin 
			raddr_ram_0_reg = 0;
		end else if (andOp_53_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_46_out) begin 
			waddr_ram_0_reg = 0;
		end else if (andOp_51_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_46_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (andOp_51_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_46_out) begin 
			wen_ram_0_reg = 1;
		end else if (andOp_51_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_23.valid_reg
	always @(*) begin
		if (andOp_95_out) begin 
			valid_reg = 1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_136.tmp_output_136_in_data
	always @(*) begin
		if (eq_137_out) begin 
			tmp_output_136_in_data = call_tmp_7;
		end else begin
			tmp_output_136_in_data = 0;
		end
	end
	// controller for tmp_output_2.tmp_output_2_in_data
	always @(*) begin
		if (eq_4_out) begin 
			tmp_output_2_in_data = call_tmp_4;
		end else begin
			tmp_output_2_in_data = 0;
		end
	end
	// controller for tmp_output_9.tmp_output_9_in_data
	always @(*) begin
		if (eq_10_out) begin 
			tmp_output_9_in_data = call_tmp_7;
		end else begin
			tmp_output_9_in_data = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_2 <= 0;
		end else begin
			if (andOp_179_out) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (andOp_16_out) begin
				global_next_block <= 2;
			end
			if (andOp_23_out) begin
				global_next_block <= 0;
			end
			if (andOp_25_out) begin
				global_next_block <= 2;
			end
			if (andOp_27_out) begin
				global_next_block <= 2;
			end
			if (andOp_29_out) begin
				global_next_block <= 2;
			end
			if (andOp_31_out) begin
				global_next_block <= 1;
			end
			if (andOp_33_out) begin
				global_next_block <= 1;
			end
			if (andOp_35_out) begin
				global_next_block <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_114_out) begin
				global_state <= 1;
			end
			if (andOp_120_out) begin
				global_state <= 2;
			end
			if (andOp_125_out) begin
				global_state <= 3;
			end
			if (andOp_130_out) begin
				global_state <= 4;
			end
			if (andOp_139_out) begin
				global_state <= 1;
			end
			if (andOp_145_out) begin
				global_state <= 5;
			end
			if (andOp_150_out) begin
				global_state <= 6;
			end
			if (andOp_155_out) begin
				global_state <= 6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if (andOp_185_out) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (andOp_101_out) begin
				last_BB_reg <= 0;
			end
			if (andOp_107_out) begin
				last_BB_reg <= 2;
			end
			if (andOp_109_out) begin
				last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_1 <= 0;
		end else begin
			if (andOp_173_out) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

