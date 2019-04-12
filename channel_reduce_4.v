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
	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add alloca_0();

	add bitcast_1();

	add call_2();

	br_dummy br_unit();

	add call_17();

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

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [31:0] andOp_1_in0;
	reg [31:0] andOp_1_in1;
	wire [31:0] andOp_1_out;
	andOp #(.WIDTH(32)) andOp_1(.in0(andOp_1_in0), .in1(andOp_1_in1), .out(andOp_1_out));

	reg [31:0] eq_2_in0;
	reg [31:0] eq_2_in1;
	wire [0:0] eq_2_out;
	eq #(.WIDTH(32)) eq_2(.in0(eq_2_in0), .in1(eq_2_in1), .out(eq_2_out));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [31:0] eq_4_in0;
	reg [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	reg [31:0] eq_5_in0;
	reg [31:0] eq_5_in1;
	wire [0:0] eq_5_out;
	eq #(.WIDTH(32)) eq_5(.in0(eq_5_in0), .in1(eq_5_in1), .out(eq_5_out));

	reg [31:0] eq_6_in0;
	reg [31:0] eq_6_in1;
	wire [0:0] eq_6_out;
	eq #(.WIDTH(32)) eq_6(.in0(eq_6_in0), .in1(eq_6_in1), .out(eq_6_out));

	reg [31:0] eq_7_in0;
	reg [31:0] eq_7_in1;
	wire [0:0] eq_7_out;
	eq #(.WIDTH(32)) eq_7(.in0(eq_7_in0), .in1(eq_7_in1), .out(eq_7_out));

	reg [31:0] eq_8_in0;
	reg [31:0] eq_8_in1;
	wire [0:0] eq_8_out;
	eq #(.WIDTH(32)) eq_8(.in0(eq_8_in0), .in1(eq_8_in1), .out(eq_8_out));

	reg [31:0] eq_9_in0;
	reg [31:0] eq_9_in1;
	wire [0:0] eq_9_out;
	eq #(.WIDTH(32)) eq_9(.in0(eq_9_in0), .in1(eq_9_in1), .out(eq_9_out));

	reg [31:0] andOp_10_in0;
	reg [31:0] andOp_10_in1;
	wire [31:0] andOp_10_out;
	andOp #(.WIDTH(32)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [31:0] andOp_12_in0;
	reg [31:0] andOp_12_in1;
	wire [31:0] andOp_12_out;
	andOp #(.WIDTH(32)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [31:0] eq_13_in0;
	reg [31:0] eq_13_in1;
	wire [0:0] eq_13_out;
	eq #(.WIDTH(32)) eq_13(.in0(eq_13_in0), .in1(eq_13_in1), .out(eq_13_out));

	reg [31:0] andOp_14_in0;
	reg [31:0] andOp_14_in1;
	wire [31:0] andOp_14_out;
	andOp #(.WIDTH(32)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	reg [31:0] eq_15_in0;
	reg [31:0] eq_15_in1;
	wire [0:0] eq_15_out;
	eq #(.WIDTH(32)) eq_15(.in0(eq_15_in0), .in1(eq_15_in1), .out(eq_15_out));

	reg [31:0] andOp_16_in0;
	reg [31:0] andOp_16_in1;
	wire [31:0] andOp_16_out;
	andOp #(.WIDTH(32)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

	reg [31:0] eq_17_in0;
	reg [31:0] eq_17_in1;
	wire [0:0] eq_17_out;
	eq #(.WIDTH(32)) eq_17(.in0(eq_17_in0), .in1(eq_17_in1), .out(eq_17_out));

	reg [31:0] andOp_18_in0;
	reg [31:0] andOp_18_in1;
	wire [31:0] andOp_18_out;
	andOp #(.WIDTH(32)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [31:0] eq_19_in0;
	reg [31:0] eq_19_in1;
	wire [0:0] eq_19_out;
	eq #(.WIDTH(32)) eq_19(.in0(eq_19_in0), .in1(eq_19_in1), .out(eq_19_out));

	reg [31:0] andOp_20_in0;
	reg [31:0] andOp_20_in1;
	wire [31:0] andOp_20_out;
	andOp #(.WIDTH(32)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	reg [31:0] eq_21_in0;
	reg [31:0] eq_21_in1;
	wire [0:0] eq_21_out;
	eq #(.WIDTH(32)) eq_21(.in0(eq_21_in0), .in1(eq_21_in1), .out(eq_21_out));

	reg [31:0] andOp_22_in0;
	reg [31:0] andOp_22_in1;
	wire [31:0] andOp_22_out;
	andOp #(.WIDTH(32)) andOp_22(.in0(andOp_22_in0), .in1(andOp_22_in1), .out(andOp_22_out));

	reg [31:0] eq_23_in0;
	reg [31:0] eq_23_in1;
	wire [0:0] eq_23_out;
	eq #(.WIDTH(32)) eq_23(.in0(eq_23_in0), .in1(eq_23_in1), .out(eq_23_out));

	reg [31:0] eq_24_in0;
	reg [31:0] eq_24_in1;
	wire [0:0] eq_24_out;
	eq #(.WIDTH(32)) eq_24(.in0(eq_24_in0), .in1(eq_24_in1), .out(eq_24_out));

	reg [31:0] eq_25_in0;
	reg [31:0] eq_25_in1;
	wire [0:0] eq_25_out;
	eq #(.WIDTH(32)) eq_25(.in0(eq_25_in0), .in1(eq_25_in1), .out(eq_25_out));

	reg [31:0] eq_26_in0;
	reg [31:0] eq_26_in1;
	wire [0:0] eq_26_out;
	eq #(.WIDTH(32)) eq_26(.in0(eq_26_in0), .in1(eq_26_in1), .out(eq_26_out));

	reg [31:0] eq_27_in0;
	reg [31:0] eq_27_in1;
	wire [0:0] eq_27_out;
	eq #(.WIDTH(32)) eq_27(.in0(eq_27_in0), .in1(eq_27_in1), .out(eq_27_out));

	reg [31:0] eq_28_in0;
	reg [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

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

	reg [31:0] eq_32_in0;
	reg [31:0] eq_32_in1;
	wire [0:0] eq_32_out;
	eq #(.WIDTH(32)) eq_32(.in0(eq_32_in0), .in1(eq_32_in1), .out(eq_32_out));

	reg [31:0] eq_33_in0;
	reg [31:0] eq_33_in1;
	wire [0:0] eq_33_out;
	eq #(.WIDTH(32)) eq_33(.in0(eq_33_in0), .in1(eq_33_in1), .out(eq_33_out));

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

	reg [31:0] andOp_47_in0;
	reg [31:0] andOp_47_in1;
	wire [31:0] andOp_47_out;
	andOp #(.WIDTH(32)) andOp_47(.in0(andOp_47_in0), .in1(andOp_47_in1), .out(andOp_47_out));

	reg [31:0] eq_48_in0;
	reg [31:0] eq_48_in1;
	wire [0:0] eq_48_out;
	eq #(.WIDTH(32)) eq_48(.in0(eq_48_in0), .in1(eq_48_in1), .out(eq_48_out));

	reg [31:0] andOp_49_in0;
	reg [31:0] andOp_49_in1;
	wire [31:0] andOp_49_out;
	andOp #(.WIDTH(32)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

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

	reg [31:0] eq_56_in0;
	reg [31:0] eq_56_in1;
	wire [0:0] eq_56_out;
	eq #(.WIDTH(32)) eq_56(.in0(eq_56_in0), .in1(eq_56_in1), .out(eq_56_out));

	reg [31:0] eq_57_in0;
	reg [31:0] eq_57_in1;
	wire [0:0] eq_57_out;
	eq #(.WIDTH(32)) eq_57(.in0(eq_57_in0), .in1(eq_57_in1), .out(eq_57_out));

	reg [31:0] eq_58_in0;
	reg [31:0] eq_58_in1;
	wire [0:0] eq_58_out;
	eq #(.WIDTH(32)) eq_58(.in0(eq_58_in0), .in1(eq_58_in1), .out(eq_58_out));

	reg [31:0] andOp_59_in0;
	reg [31:0] andOp_59_in1;
	wire [31:0] andOp_59_out;
	andOp #(.WIDTH(32)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	reg [31:0] andOp_60_in0;
	reg [31:0] andOp_60_in1;
	wire [31:0] andOp_60_out;
	andOp #(.WIDTH(32)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	reg [31:0] eq_61_in0;
	reg [31:0] eq_61_in1;
	wire [0:0] eq_61_out;
	eq #(.WIDTH(32)) eq_61(.in0(eq_61_in0), .in1(eq_61_in1), .out(eq_61_out));

	reg [31:0] andOp_62_in0;
	reg [31:0] andOp_62_in1;
	wire [31:0] andOp_62_out;
	andOp #(.WIDTH(32)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

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

	reg [31:0] andOp_66_in0;
	reg [31:0] andOp_66_in1;
	wire [31:0] andOp_66_out;
	andOp #(.WIDTH(32)) andOp_66(.in0(andOp_66_in0), .in1(andOp_66_in1), .out(andOp_66_out));

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

	reg [31:0] eq_72_in0;
	reg [31:0] eq_72_in1;
	wire [0:0] eq_72_out;
	eq #(.WIDTH(32)) eq_72(.in0(eq_72_in0), .in1(eq_72_in1), .out(eq_72_out));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_73_in0;
	reg [31:0] eq_73_in1;
	wire [0:0] eq_73_out;
	eq #(.WIDTH(32)) eq_73(.in0(eq_73_in0), .in1(eq_73_in1), .out(eq_73_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_75_in0;
	reg [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

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
		andOp_1_in0 = valid ? eq_0_out : eq_0_out;
		andOp_1_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	always @(*) begin
		andOp_10_in0 = valid ? eq_9_out : eq_9_out;
		andOp_10_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? eq_11_out : eq_11_out;
		andOp_12_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? eq_13_out : eq_13_out;
		andOp_14_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? eq_15_out : eq_15_out;
		andOp_16_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? eq_17_out : eq_17_out;
		andOp_18_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	always @(*) begin
		andOp_20_in0 = valid ? eq_19_out : eq_19_out;
		andOp_20_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	always @(*) begin
		andOp_22_in0 = valid ? eq_21_out : eq_21_out;
		andOp_22_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? eq_34_out : eq_34_out;
		andOp_35_in1 = valid ? 1 : 1;
	end
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	always @(*) begin
		andOp_37_in0 = valid ? eq_36_out : eq_36_out;
		andOp_37_in1 = valid ? 1 : 1;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? eq_38_out : eq_38_out;
		andOp_39_in1 = valid ? 1 : 1;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? andOp_39_out : andOp_39_out;
		andOp_40_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? eq_41_out : eq_41_out;
		andOp_42_in1 = valid ? 1 : 1;
	end
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	always @(*) begin
		andOp_44_in0 = valid ? eq_43_out : eq_43_out;
		andOp_44_in1 = valid ? 1 : 1;
	end
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	always @(*) begin
		andOp_46_in0 = valid ? eq_45_out : eq_45_out;
		andOp_46_in1 = valid ? (icmp_tmp_3) : (icmp_tmp_3);
	end
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	always @(*) begin
		andOp_47_in0 = valid ? eq_45_out : eq_45_out;
		andOp_47_in1 = valid ? !(icmp_tmp_3) : !(icmp_tmp_3);
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? eq_48_out : eq_48_out;
		andOp_49_in1 = valid ? 1 : 1;
	end
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	always @(*) begin
		andOp_50_in0 = valid ? andOp_49_out : andOp_49_out;
		andOp_50_in1 = valid ? out_write_ready : out_write_ready;
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
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? eq_57_out : eq_57_out;
		andOp_59_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? andOp_59_out : andOp_59_out;
		andOp_60_in1 = valid ? eq_58_out : eq_58_out;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? eq_57_out : eq_57_out;
		andOp_62_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? andOp_62_out : andOp_62_out;
		andOp_63_in1 = valid ? eq_61_out : eq_61_out;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? eq_57_out : eq_57_out;
		andOp_65_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? andOp_65_out : andOp_65_out;
		andOp_66_in1 = valid ? eq_64_out : eq_64_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_73_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_74_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_75_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd2 : 32'd2;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd2 : 32'd2;
		eq_11_in1 = valid ? global_state : global_state;
	end
	// controller for eq_13.eq_13_in0
	// controller for eq_13.eq_13_in1
	// Insensitive connections
	always @(*) begin
		eq_13_in0 = valid ? 32'd2 : 32'd2;
		eq_13_in1 = valid ? global_state : global_state;
	end
	// controller for eq_15.eq_15_in0
	// controller for eq_15.eq_15_in1
	// Insensitive connections
	always @(*) begin
		eq_15_in0 = valid ? 32'd2 : 32'd2;
		eq_15_in1 = valid ? global_state : global_state;
	end
	// controller for eq_17.eq_17_in0
	// controller for eq_17.eq_17_in1
	// Insensitive connections
	always @(*) begin
		eq_17_in0 = valid ? 32'd2 : 32'd2;
		eq_17_in1 = valid ? global_state : global_state;
	end
	// controller for eq_19.eq_19_in0
	// controller for eq_19.eq_19_in1
	// Insensitive connections
	always @(*) begin
		eq_19_in0 = valid ? 32'd2 : 32'd2;
		eq_19_in1 = valid ? global_state : global_state;
	end
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	always @(*) begin
		eq_2_in0 = valid ? 32'd7 : 32'd7;
		eq_2_in1 = valid ? global_state : global_state;
	end
	// controller for eq_21.eq_21_in0
	// controller for eq_21.eq_21_in1
	// Insensitive connections
	always @(*) begin
		eq_21_in0 = valid ? 32'd2 : 32'd2;
		eq_21_in1 = valid ? global_state : global_state;
	end
	// controller for eq_23.eq_23_in0
	// controller for eq_23.eq_23_in1
	// Insensitive connections
	always @(*) begin
		eq_23_in0 = valid ? 32'd3 : 32'd3;
		eq_23_in1 = valid ? global_state : global_state;
	end
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	always @(*) begin
		eq_24_in0 = valid ? 32'd4 : 32'd4;
		eq_24_in1 = valid ? global_state : global_state;
	end
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	always @(*) begin
		eq_25_in0 = valid ? 32'd4 : 32'd4;
		eq_25_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd4 : 32'd4;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	always @(*) begin
		eq_27_in0 = valid ? 32'd7 : 32'd7;
		eq_27_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd7 : 32'd7;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	always @(*) begin
		eq_29_in0 = valid ? 32'd8 : 32'd8;
		eq_29_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd0 : 32'd0;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd8 : 32'd8;
		eq_30_in1 = valid ? global_state : global_state;
	end
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	always @(*) begin
		eq_31_in0 = valid ? 32'd1 : 32'd1;
		eq_31_in1 = valid ? global_state : global_state;
	end
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	always @(*) begin
		eq_32_in0 = valid ? 32'd5 : 32'd5;
		eq_32_in1 = valid ? global_state : global_state;
	end
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	always @(*) begin
		eq_33_in0 = valid ? 32'd8 : 32'd8;
		eq_33_in1 = valid ? global_state : global_state;
	end
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	always @(*) begin
		eq_34_in0 = valid ? 32'd0 : 32'd0;
		eq_34_in1 = valid ? global_state : global_state;
	end
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	always @(*) begin
		eq_36_in0 = valid ? 32'd1 : 32'd1;
		eq_36_in1 = valid ? global_state : global_state;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd2 : 32'd2;
		eq_38_in1 = valid ? global_state : global_state;
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
		eq_41_in0 = valid ? 32'd3 : 32'd3;
		eq_41_in1 = valid ? global_state : global_state;
	end
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	always @(*) begin
		eq_43_in0 = valid ? 32'd4 : 32'd4;
		eq_43_in1 = valid ? global_state : global_state;
	end
	// controller for eq_45.eq_45_in0
	// controller for eq_45.eq_45_in1
	// Insensitive connections
	always @(*) begin
		eq_45_in0 = valid ? 32'd5 : 32'd5;
		eq_45_in1 = valid ? global_state : global_state;
	end
	// controller for eq_48.eq_48_in0
	// controller for eq_48.eq_48_in1
	// Insensitive connections
	always @(*) begin
		eq_48_in0 = valid ? 32'd6 : 32'd6;
		eq_48_in1 = valid ? global_state : global_state;
	end
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	always @(*) begin
		eq_5_in0 = valid ? 32'd0 : 32'd0;
		eq_5_in1 = valid ? global_state : global_state;
	end
	// controller for eq_51.eq_51_in0
	// controller for eq_51.eq_51_in1
	// Insensitive connections
	always @(*) begin
		eq_51_in0 = valid ? 32'd7 : 32'd7;
		eq_51_in1 = valid ? global_state : global_state;
	end
	// controller for eq_53.eq_53_in0
	// controller for eq_53.eq_53_in1
	// Insensitive connections
	always @(*) begin
		eq_53_in0 = valid ? 32'd8 : 32'd8;
		eq_53_in1 = valid ? global_state : global_state;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd0 : 32'd0;
		eq_55_in1 = valid ? global_state : global_state;
	end
	// controller for eq_56.eq_56_in0
	// controller for eq_56.eq_56_in1
	// Insensitive connections
	always @(*) begin
		eq_56_in0 = valid ? 32'd1 : 32'd1;
		eq_56_in1 = valid ? global_state : global_state;
	end
	// controller for eq_57.eq_57_in0
	// controller for eq_57.eq_57_in1
	// Insensitive connections
	always @(*) begin
		eq_57_in0 = valid ? 32'd2 : 32'd2;
		eq_57_in1 = valid ? global_state : global_state;
	end
	// controller for eq_58.eq_58_in0
	// controller for eq_58.eq_58_in1
	// Insensitive connections
	always @(*) begin
		eq_58_in0 = valid ? 32'd2 : 32'd2;
		eq_58_in1 = valid ? global_state : global_state;
	end
	// controller for eq_6.eq_6_in0
	// controller for eq_6.eq_6_in1
	// Insensitive connections
	always @(*) begin
		eq_6_in0 = valid ? 32'd4 : 32'd4;
		eq_6_in1 = valid ? global_state : global_state;
	end
	// controller for eq_61.eq_61_in0
	// controller for eq_61.eq_61_in1
	// Insensitive connections
	always @(*) begin
		eq_61_in0 = valid ? 32'd2 : 32'd2;
		eq_61_in1 = valid ? global_state : global_state;
	end
	// controller for eq_64.eq_64_in0
	// controller for eq_64.eq_64_in1
	// Insensitive connections
	always @(*) begin
		eq_64_in0 = valid ? 32'd2 : 32'd2;
		eq_64_in1 = valid ? global_state : global_state;
	end
	// controller for eq_67.eq_67_in0
	// controller for eq_67.eq_67_in1
	// Insensitive connections
	always @(*) begin
		eq_67_in0 = valid ? 32'd3 : 32'd3;
		eq_67_in1 = valid ? global_state : global_state;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd4 : 32'd4;
		eq_68_in1 = valid ? global_state : global_state;
	end
	// controller for eq_69.eq_69_in0
	// controller for eq_69.eq_69_in1
	// Insensitive connections
	always @(*) begin
		eq_69_in0 = valid ? 32'd5 : 32'd5;
		eq_69_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd0 : 32'd0;
		eq_7_in1 = valid ? global_state : global_state;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd6 : 32'd6;
		eq_70_in1 = valid ? global_state : global_state;
	end
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	always @(*) begin
		eq_71_in0 = valid ? 32'd7 : 32'd7;
		eq_71_in1 = valid ? global_state : global_state;
	end
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	always @(*) begin
		eq_72_in0 = valid ? 32'd8 : 32'd8;
		eq_72_in1 = valid ? global_state : global_state;
	end
	// controller for eq_73.eq_73_in0
	// controller for eq_73.eq_73_in1
	// Insensitive connections
	always @(*) begin
		eq_73_in0 = valid ? 32'd0 : 32'd0;
		eq_73_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd1 : 32'd1;
		eq_74_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	always @(*) begin
		eq_75_in0 = valid ? 32'd2 : 32'd2;
		eq_75_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_8.eq_8_in0
	// controller for eq_8.eq_8_in1
	// Insensitive connections
	always @(*) begin
		eq_8_in0 = valid ? 32'd4 : 32'd4;
		eq_8_in1 = valid ? global_state : global_state;
	end
	// controller for eq_9.eq_9_in0
	// controller for eq_9.eq_9_in1
	// Insensitive connections
	always @(*) begin
		eq_9_in0 = valid ? 32'd2 : 32'd2;
		eq_9_in1 = valid ? global_state : global_state;
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
		if (eq_23_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (eq_24_out) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for out.out_in_data_reg
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (eq_28_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (eq_29_out) begin 
			out_write_valid_reg = (1'd0);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? rdata_ram_0 : rdata_ram_0;
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
		if (andOp_1_out) begin 
			raddr_ram_0_reg = 0;
		end else if (eq_2_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (eq_3_out) begin 
			waddr_ram_0_reg = 0;
		end else if (eq_4_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (eq_5_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (eq_6_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (eq_7_out) begin 
			wen_ram_0_reg = 1;
		end else if (eq_8_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_23.valid_reg
	always @(*) begin
		if (eq_30_out) begin 
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
			if (andOp_63_out) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_35_out) begin
				global_state <= 1;
			end
			if (andOp_37_out) begin
				global_state <= 2;
			end
			if (andOp_40_out) begin
				global_state <= 3;
			end
			if (andOp_42_out) begin
				global_state <= 4;
			end
			if (andOp_44_out) begin
				global_state <= 5;
			end
			if (andOp_46_out) begin
				global_state <= 6;
			end
			if (andOp_47_out) begin
				global_state <= 2;
			end
			if (andOp_50_out) begin
				global_state <= 7;
			end
			if (andOp_52_out) begin
				global_state <= 8;
			end
			if (andOp_54_out) begin
				global_state <= 8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if (andOp_66_out) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_31_out) begin
				last_BB_reg <= 0;
			end
			if (eq_32_out) begin
				last_BB_reg <= 2;
			end
			if (eq_33_out) begin
				last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_1 <= 0;
		end else begin
			if (andOp_60_out) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

