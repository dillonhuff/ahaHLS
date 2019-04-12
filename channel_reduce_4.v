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

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [31:0] andOp_1_in0;
	reg [31:0] andOp_1_in1;
	wire [31:0] andOp_1_out;
	andOp #(.WIDTH(32)) andOp_1(.in0(andOp_1_in0), .in1(andOp_1_in1), .out(andOp_1_out));

	reg [31:0] andOp_2_in0;
	reg [31:0] andOp_2_in1;
	wire [31:0] andOp_2_out;
	andOp #(.WIDTH(32)) andOp_2(.in0(andOp_2_in0), .in1(andOp_2_in1), .out(andOp_2_out));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [31:0] andOp_4_in0;
	reg [31:0] andOp_4_in1;
	wire [31:0] andOp_4_out;
	andOp #(.WIDTH(32)) andOp_4(.in0(andOp_4_in0), .in1(andOp_4_in1), .out(andOp_4_out));

	reg [31:0] eq_5_in0;
	reg [31:0] eq_5_in1;
	wire [0:0] eq_5_out;
	eq #(.WIDTH(32)) eq_5(.in0(eq_5_in0), .in1(eq_5_in1), .out(eq_5_out));

	reg [31:0] andOp_6_in0;
	reg [31:0] andOp_6_in1;
	wire [31:0] andOp_6_out;
	andOp #(.WIDTH(32)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [31:0] eq_7_in0;
	reg [31:0] eq_7_in1;
	wire [0:0] eq_7_out;
	eq #(.WIDTH(32)) eq_7(.in0(eq_7_in0), .in1(eq_7_in1), .out(eq_7_out));

	reg [31:0] andOp_8_in0;
	reg [31:0] andOp_8_in1;
	wire [31:0] andOp_8_out;
	andOp #(.WIDTH(32)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

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

	reg [31:0] andOp_22_in0;
	reg [31:0] andOp_22_in1;
	wire [31:0] andOp_22_out;
	andOp #(.WIDTH(32)) andOp_22(.in0(andOp_22_in0), .in1(andOp_22_in1), .out(andOp_22_out));

	reg [31:0] eq_23_in0;
	reg [31:0] eq_23_in1;
	wire [0:0] eq_23_out;
	eq #(.WIDTH(32)) eq_23(.in0(eq_23_in0), .in1(eq_23_in1), .out(eq_23_out));

	reg [31:0] andOp_24_in0;
	reg [31:0] andOp_24_in1;
	wire [31:0] andOp_24_out;
	andOp #(.WIDTH(32)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

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

	reg [31:0] andOp_28_in0;
	reg [31:0] andOp_28_in1;
	wire [31:0] andOp_28_out;
	andOp #(.WIDTH(32)) andOp_28(.in0(andOp_28_in0), .in1(andOp_28_in1), .out(andOp_28_out));

	reg [31:0] eq_29_in0;
	reg [31:0] eq_29_in1;
	wire [0:0] eq_29_out;
	eq #(.WIDTH(32)) eq_29(.in0(eq_29_in0), .in1(eq_29_in1), .out(eq_29_out));

	reg [31:0] andOp_30_in0;
	reg [31:0] andOp_30_in1;
	wire [31:0] andOp_30_out;
	andOp #(.WIDTH(32)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

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

	reg [31:0] andOp_34_in0;
	reg [31:0] andOp_34_in1;
	wire [31:0] andOp_34_out;
	andOp #(.WIDTH(32)) andOp_34(.in0(andOp_34_in0), .in1(andOp_34_in1), .out(andOp_34_out));

	reg [31:0] eq_35_in0;
	reg [31:0] eq_35_in1;
	wire [0:0] eq_35_out;
	eq #(.WIDTH(32)) eq_35(.in0(eq_35_in0), .in1(eq_35_in1), .out(eq_35_out));

	reg [31:0] andOp_36_in0;
	reg [31:0] andOp_36_in1;
	wire [31:0] andOp_36_out;
	andOp #(.WIDTH(32)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

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

	reg [31:0] eq_50_in0;
	reg [31:0] eq_50_in1;
	wire [0:0] eq_50_out;
	eq #(.WIDTH(32)) eq_50(.in0(eq_50_in0), .in1(eq_50_in1), .out(eq_50_out));

	reg [31:0] andOp_51_in0;
	reg [31:0] andOp_51_in1;
	wire [31:0] andOp_51_out;
	andOp #(.WIDTH(32)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	reg [31:0] eq_52_in0;
	reg [31:0] eq_52_in1;
	wire [0:0] eq_52_out;
	eq #(.WIDTH(32)) eq_52(.in0(eq_52_in0), .in1(eq_52_in1), .out(eq_52_out));

	reg [31:0] andOp_53_in0;
	reg [31:0] andOp_53_in1;
	wire [31:0] andOp_53_out;
	andOp #(.WIDTH(32)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	reg [31:0] eq_54_in0;
	reg [31:0] eq_54_in1;
	wire [0:0] eq_54_out;
	eq #(.WIDTH(32)) eq_54(.in0(eq_54_in0), .in1(eq_54_in1), .out(eq_54_out));

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

	reg [31:0] eq_66_in0;
	reg [31:0] eq_66_in1;
	wire [0:0] eq_66_out;
	eq #(.WIDTH(32)) eq_66(.in0(eq_66_in0), .in1(eq_66_in1), .out(eq_66_out));

	reg [31:0] andOp_67_in0;
	reg [31:0] andOp_67_in1;
	wire [31:0] andOp_67_out;
	andOp #(.WIDTH(32)) andOp_67(.in0(andOp_67_in0), .in1(andOp_67_in1), .out(andOp_67_out));

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

	reg [31:0] andOp_75_in0;
	reg [31:0] andOp_75_in1;
	wire [31:0] andOp_75_out;
	andOp #(.WIDTH(32)) andOp_75(.in0(andOp_75_in0), .in1(andOp_75_in1), .out(andOp_75_out));

	reg [31:0] eq_76_in0;
	reg [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	reg [31:0] andOp_77_in0;
	reg [31:0] andOp_77_in1;
	wire [31:0] andOp_77_out;
	andOp #(.WIDTH(32)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	reg [31:0] eq_78_in0;
	reg [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	reg [31:0] eq_79_in0;
	reg [31:0] eq_79_in1;
	wire [0:0] eq_79_out;
	eq #(.WIDTH(32)) eq_79(.in0(eq_79_in0), .in1(eq_79_in1), .out(eq_79_out));

	reg [31:0] eq_80_in0;
	reg [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

	reg [31:0] eq_81_in0;
	reg [31:0] eq_81_in1;
	wire [0:0] eq_81_out;
	eq #(.WIDTH(32)) eq_81(.in0(eq_81_in0), .in1(eq_81_in1), .out(eq_81_out));

	reg [31:0] andOp_82_in0;
	reg [31:0] andOp_82_in1;
	wire [31:0] andOp_82_out;
	andOp #(.WIDTH(32)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	reg [31:0] andOp_83_in0;
	reg [31:0] andOp_83_in1;
	wire [31:0] andOp_83_out;
	andOp #(.WIDTH(32)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	reg [31:0] eq_84_in0;
	reg [31:0] eq_84_in1;
	wire [0:0] eq_84_out;
	eq #(.WIDTH(32)) eq_84(.in0(eq_84_in0), .in1(eq_84_in1), .out(eq_84_out));

	reg [31:0] andOp_85_in0;
	reg [31:0] andOp_85_in1;
	wire [31:0] andOp_85_out;
	andOp #(.WIDTH(32)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	reg [31:0] andOp_86_in0;
	reg [31:0] andOp_86_in1;
	wire [31:0] andOp_86_out;
	andOp #(.WIDTH(32)) andOp_86(.in0(andOp_86_in0), .in1(andOp_86_in1), .out(andOp_86_out));

	reg [31:0] eq_87_in0;
	reg [31:0] eq_87_in1;
	wire [0:0] eq_87_out;
	eq #(.WIDTH(32)) eq_87(.in0(eq_87_in0), .in1(eq_87_in1), .out(eq_87_out));

	reg [31:0] andOp_88_in0;
	reg [31:0] andOp_88_in1;
	wire [31:0] andOp_88_out;
	andOp #(.WIDTH(32)) andOp_88(.in0(andOp_88_in0), .in1(andOp_88_in1), .out(andOp_88_out));

	reg [31:0] andOp_89_in0;
	reg [31:0] andOp_89_in1;
	wire [31:0] andOp_89_out;
	andOp #(.WIDTH(32)) andOp_89(.in0(andOp_89_in0), .in1(andOp_89_in1), .out(andOp_89_out));

	reg [31:0] eq_90_in0;
	reg [31:0] eq_90_in1;
	wire [0:0] eq_90_out;
	eq #(.WIDTH(32)) eq_90(.in0(eq_90_in0), .in1(eq_90_in1), .out(eq_90_out));

	reg [31:0] eq_91_in0;
	reg [31:0] eq_91_in1;
	wire [0:0] eq_91_out;
	eq #(.WIDTH(32)) eq_91(.in0(eq_91_in0), .in1(eq_91_in1), .out(eq_91_out));

	reg [31:0] eq_92_in0;
	reg [31:0] eq_92_in1;
	wire [0:0] eq_92_out;
	eq #(.WIDTH(32)) eq_92(.in0(eq_92_in0), .in1(eq_92_in1), .out(eq_92_out));

	reg [31:0] eq_93_in0;
	reg [31:0] eq_93_in1;
	wire [0:0] eq_93_out;
	eq #(.WIDTH(32)) eq_93(.in0(eq_93_in0), .in1(eq_93_in1), .out(eq_93_out));

	reg [31:0] eq_94_in0;
	reg [31:0] eq_94_in1;
	wire [0:0] eq_94_out;
	eq #(.WIDTH(32)) eq_94(.in0(eq_94_in0), .in1(eq_94_in1), .out(eq_94_out));

	reg [31:0] eq_95_in0;
	reg [31:0] eq_95_in1;
	wire [0:0] eq_95_out;
	eq #(.WIDTH(32)) eq_95(.in0(eq_95_in0), .in1(eq_95_in1), .out(eq_95_out));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_96_in0;
	reg [31:0] eq_96_in1;
	wire [0:0] eq_96_out;
	eq #(.WIDTH(32)) eq_96(.in0(eq_96_in0), .in1(eq_96_in1), .out(eq_96_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [31:0] eq_97_in0;
	reg [31:0] eq_97_in1;
	wire [0:0] eq_97_out;
	eq #(.WIDTH(32)) eq_97(.in0(eq_97_in0), .in1(eq_97_in1), .out(eq_97_out));

	reg [0:0] notOp_98_in0;
	wire [0:0] notOp_98_out;
	notOp #(.WIDTH(1)) notOp_98(.in(notOp_98_in0), .out(notOp_98_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_99_in0;
	reg [31:0] eq_99_in1;
	wire [0:0] eq_99_out;
	eq #(.WIDTH(32)) eq_99(.in0(eq_99_in0), .in1(eq_99_in1), .out(eq_99_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_100_in0;
	reg [31:0] eq_100_in1;
	wire [0:0] eq_100_out;
	eq #(.WIDTH(32)) eq_100(.in0(eq_100_in0), .in1(eq_100_in1), .out(eq_100_out));

	reg [0:0] br_2_happened_in_data;
	wire [0:0] br_2_happened_out_data;
	hls_wire #(.WIDTH(1)) br_2_happened(.in_data(br_2_happened_in_data), .out_data(br_2_happened_out_data));

	reg [31:0] eq_101_in0;
	reg [31:0] eq_101_in1;
	wire [0:0] eq_101_out;
	eq #(.WIDTH(32)) eq_101(.in0(eq_101_in0), .in1(eq_101_in1), .out(eq_101_out));

	reg [0:0] notOp_102_in0;
	wire [0:0] notOp_102_out;
	notOp #(.WIDTH(1)) notOp_102(.in(notOp_102_in0), .out(notOp_102_out));

	reg [0:0] notOp_103_in0;
	wire [0:0] notOp_103_out;
	notOp #(.WIDTH(1)) notOp_103(.in(notOp_103_in0), .out(notOp_103_out));

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
		andOp_10_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? eq_11_out : eq_11_out;
		andOp_12_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? eq_13_out : eq_13_out;
		andOp_14_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? eq_15_out : eq_15_out;
		andOp_16_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? eq_17_out : eq_17_out;
		andOp_18_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? andOp_18_out : andOp_18_out;
		andOp_19_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_2.andOp_2_in0
	// controller for andOp_2.andOp_2_in1
	// Insensitive connections
	always @(*) begin
		andOp_2_in0 = valid ? andOp_1_out : andOp_1_out;
		andOp_2_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? eq_20_out : eq_20_out;
		andOp_21_in1 = valid ? in_read_ready : in_read_ready;
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
		andOp_24_in0 = valid ? eq_23_out : eq_23_out;
		andOp_24_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	always @(*) begin
		andOp_25_in0 = valid ? andOp_24_out : andOp_24_out;
		andOp_25_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? eq_26_out : eq_26_out;
		andOp_27_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_28.andOp_28_in0
	// controller for andOp_28.andOp_28_in1
	// Insensitive connections
	always @(*) begin
		andOp_28_in0 = valid ? andOp_27_out : andOp_27_out;
		andOp_28_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_30.andOp_30_in0
	// controller for andOp_30.andOp_30_in1
	// Insensitive connections
	always @(*) begin
		andOp_30_in0 = valid ? eq_29_out : eq_29_out;
		andOp_30_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	always @(*) begin
		andOp_31_in0 = valid ? andOp_30_out : andOp_30_out;
		andOp_31_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? eq_32_out : eq_32_out;
		andOp_33_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_34.andOp_34_in0
	// controller for andOp_34.andOp_34_in1
	// Insensitive connections
	always @(*) begin
		andOp_34_in0 = valid ? andOp_33_out : andOp_33_out;
		andOp_34_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	always @(*) begin
		andOp_36_in0 = valid ? eq_35_out : eq_35_out;
		andOp_36_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	always @(*) begin
		andOp_37_in0 = valid ? andOp_36_out : andOp_36_out;
		andOp_37_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? eq_38_out : eq_38_out;
		andOp_39_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_4.andOp_4_in0
	// controller for andOp_4.andOp_4_in1
	// Insensitive connections
	always @(*) begin
		andOp_4_in0 = valid ? eq_3_out : eq_3_out;
		andOp_4_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	always @(*) begin
		andOp_41_in0 = valid ? eq_40_out : eq_40_out;
		andOp_41_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	always @(*) begin
		andOp_43_in0 = valid ? eq_42_out : eq_42_out;
		andOp_43_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? eq_44_out : eq_44_out;
		andOp_45_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	always @(*) begin
		andOp_47_in0 = valid ? eq_46_out : eq_46_out;
		andOp_47_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? eq_48_out : eq_48_out;
		andOp_49_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? eq_50_out : eq_50_out;
		andOp_51_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	always @(*) begin
		andOp_53_in0 = valid ? eq_52_out : eq_52_out;
		andOp_53_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	always @(*) begin
		andOp_58_in0 = valid ? eq_57_out : eq_57_out;
		andOp_58_in1 = valid ? 1 : 1;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? eq_5_out : eq_5_out;
		andOp_6_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? eq_59_out : eq_59_out;
		andOp_60_in1 = valid ? 1 : 1;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? eq_61_out : eq_61_out;
		andOp_62_in1 = valid ? 1 : 1;
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? andOp_62_out : andOp_62_out;
		andOp_63_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? eq_64_out : eq_64_out;
		andOp_65_in1 = valid ? 1 : 1;
	end
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	always @(*) begin
		andOp_67_in0 = valid ? eq_66_out : eq_66_out;
		andOp_67_in1 = valid ? 1 : 1;
	end
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	always @(*) begin
		andOp_69_in0 = valid ? eq_68_out : eq_68_out;
		andOp_69_in1 = valid ? (icmp_tmp_3) : (icmp_tmp_3);
	end
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	always @(*) begin
		andOp_70_in0 = valid ? eq_68_out : eq_68_out;
		andOp_70_in1 = valid ? !(icmp_tmp_3) : !(icmp_tmp_3);
	end
	// controller for andOp_72.andOp_72_in0
	// controller for andOp_72.andOp_72_in1
	// Insensitive connections
	always @(*) begin
		andOp_72_in0 = valid ? eq_71_out : eq_71_out;
		andOp_72_in1 = valid ? 1 : 1;
	end
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	always @(*) begin
		andOp_73_in0 = valid ? andOp_72_out : andOp_72_out;
		andOp_73_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	always @(*) begin
		andOp_75_in0 = valid ? eq_74_out : eq_74_out;
		andOp_75_in1 = valid ? 1 : 1;
	end
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	always @(*) begin
		andOp_77_in0 = valid ? eq_76_out : eq_76_out;
		andOp_77_in1 = valid ? 1 : 1;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? eq_7_out : eq_7_out;
		andOp_8_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	always @(*) begin
		andOp_82_in0 = valid ? eq_80_out : eq_80_out;
		andOp_82_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? andOp_82_out : andOp_82_out;
		andOp_83_in1 = valid ? eq_81_out : eq_81_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? eq_80_out : eq_80_out;
		andOp_85_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_86.andOp_86_in0
	// controller for andOp_86.andOp_86_in1
	// Insensitive connections
	always @(*) begin
		andOp_86_in0 = valid ? andOp_85_out : andOp_85_out;
		andOp_86_in1 = valid ? eq_84_out : eq_84_out;
	end
	// controller for andOp_88.andOp_88_in0
	// controller for andOp_88.andOp_88_in1
	// Insensitive connections
	always @(*) begin
		andOp_88_in0 = valid ? eq_80_out : eq_80_out;
		andOp_88_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? andOp_88_out : andOp_88_out;
		andOp_89_in1 = valid ? eq_87_out : eq_87_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_96_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_99_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_100_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (eq_97_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_98_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_2_happened.br_2_happened_in_data
	always @(*) begin
		if (eq_101_out) begin 
			br_2_happened_in_data = 1'd1;
		end else if (notOp_102_out) begin 
			br_2_happened_in_data = 1'd0;
		end else begin
			br_2_happened_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd2 : 32'd2;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_100.eq_100_in0
	// controller for eq_100.eq_100_in1
	// Insensitive connections
	always @(*) begin
		eq_100_in0 = valid ? 32'd2 : 32'd2;
		eq_100_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_101.eq_101_in0
	// controller for eq_101.eq_101_in1
	// Insensitive connections
	always @(*) begin
		eq_101_in0 = valid ? 32'd2 : 32'd2;
		eq_101_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd4 : 32'd4;
		eq_11_in1 = valid ? global_state : global_state;
	end
	// controller for eq_13.eq_13_in0
	// controller for eq_13.eq_13_in1
	// Insensitive connections
	always @(*) begin
		eq_13_in0 = valid ? 32'd0 : 32'd0;
		eq_13_in1 = valid ? global_state : global_state;
	end
	// controller for eq_15.eq_15_in0
	// controller for eq_15.eq_15_in1
	// Insensitive connections
	always @(*) begin
		eq_15_in0 = valid ? 32'd4 : 32'd4;
		eq_15_in1 = valid ? global_state : global_state;
	end
	// controller for eq_17.eq_17_in0
	// controller for eq_17.eq_17_in1
	// Insensitive connections
	always @(*) begin
		eq_17_in0 = valid ? 32'd2 : 32'd2;
		eq_17_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd2 : 32'd2;
		eq_20_in1 = valid ? global_state : global_state;
	end
	// controller for eq_23.eq_23_in0
	// controller for eq_23.eq_23_in1
	// Insensitive connections
	always @(*) begin
		eq_23_in0 = valid ? 32'd2 : 32'd2;
		eq_23_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd2 : 32'd2;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	always @(*) begin
		eq_29_in0 = valid ? 32'd2 : 32'd2;
		eq_29_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd7 : 32'd7;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	always @(*) begin
		eq_32_in0 = valid ? 32'd2 : 32'd2;
		eq_32_in1 = valid ? global_state : global_state;
	end
	// controller for eq_35.eq_35_in0
	// controller for eq_35.eq_35_in1
	// Insensitive connections
	always @(*) begin
		eq_35_in0 = valid ? 32'd2 : 32'd2;
		eq_35_in1 = valid ? global_state : global_state;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd3 : 32'd3;
		eq_38_in1 = valid ? global_state : global_state;
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
		eq_44_in0 = valid ? 32'd4 : 32'd4;
		eq_44_in1 = valid ? global_state : global_state;
	end
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	always @(*) begin
		eq_46_in0 = valid ? 32'd7 : 32'd7;
		eq_46_in1 = valid ? global_state : global_state;
	end
	// controller for eq_48.eq_48_in0
	// controller for eq_48.eq_48_in1
	// Insensitive connections
	always @(*) begin
		eq_48_in0 = valid ? 32'd7 : 32'd7;
		eq_48_in1 = valid ? global_state : global_state;
	end
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	always @(*) begin
		eq_5_in0 = valid ? 32'd0 : 32'd0;
		eq_5_in1 = valid ? global_state : global_state;
	end
	// controller for eq_50.eq_50_in0
	// controller for eq_50.eq_50_in1
	// Insensitive connections
	always @(*) begin
		eq_50_in0 = valid ? 32'd8 : 32'd8;
		eq_50_in1 = valid ? global_state : global_state;
	end
	// controller for eq_52.eq_52_in0
	// controller for eq_52.eq_52_in1
	// Insensitive connections
	always @(*) begin
		eq_52_in0 = valid ? 32'd8 : 32'd8;
		eq_52_in1 = valid ? global_state : global_state;
	end
	// controller for eq_54.eq_54_in0
	// controller for eq_54.eq_54_in1
	// Insensitive connections
	always @(*) begin
		eq_54_in0 = valid ? 32'd1 : 32'd1;
		eq_54_in1 = valid ? global_state : global_state;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd5 : 32'd5;
		eq_55_in1 = valid ? global_state : global_state;
	end
	// controller for eq_56.eq_56_in0
	// controller for eq_56.eq_56_in1
	// Insensitive connections
	always @(*) begin
		eq_56_in0 = valid ? 32'd8 : 32'd8;
		eq_56_in1 = valid ? global_state : global_state;
	end
	// controller for eq_57.eq_57_in0
	// controller for eq_57.eq_57_in1
	// Insensitive connections
	always @(*) begin
		eq_57_in0 = valid ? 32'd0 : 32'd0;
		eq_57_in1 = valid ? global_state : global_state;
	end
	// controller for eq_59.eq_59_in0
	// controller for eq_59.eq_59_in1
	// Insensitive connections
	always @(*) begin
		eq_59_in0 = valid ? 32'd1 : 32'd1;
		eq_59_in1 = valid ? global_state : global_state;
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
		eq_64_in0 = valid ? 32'd3 : 32'd3;
		eq_64_in1 = valid ? global_state : global_state;
	end
	// controller for eq_66.eq_66_in0
	// controller for eq_66.eq_66_in1
	// Insensitive connections
	always @(*) begin
		eq_66_in0 = valid ? 32'd4 : 32'd4;
		eq_66_in1 = valid ? global_state : global_state;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd5 : 32'd5;
		eq_68_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd4 : 32'd4;
		eq_7_in1 = valid ? global_state : global_state;
	end
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	always @(*) begin
		eq_71_in0 = valid ? 32'd6 : 32'd6;
		eq_71_in1 = valid ? global_state : global_state;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd7 : 32'd7;
		eq_74_in1 = valid ? global_state : global_state;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd8 : 32'd8;
		eq_76_in1 = valid ? global_state : global_state;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd0 : 32'd0;
		eq_78_in1 = valid ? global_state : global_state;
	end
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	always @(*) begin
		eq_79_in0 = valid ? 32'd1 : 32'd1;
		eq_79_in1 = valid ? global_state : global_state;
	end
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	always @(*) begin
		eq_80_in0 = valid ? 32'd2 : 32'd2;
		eq_80_in1 = valid ? global_state : global_state;
	end
	// controller for eq_81.eq_81_in0
	// controller for eq_81.eq_81_in1
	// Insensitive connections
	always @(*) begin
		eq_81_in0 = valid ? 32'd2 : 32'd2;
		eq_81_in1 = valid ? global_state : global_state;
	end
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	always @(*) begin
		eq_84_in0 = valid ? 32'd2 : 32'd2;
		eq_84_in1 = valid ? global_state : global_state;
	end
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	always @(*) begin
		eq_87_in0 = valid ? 32'd2 : 32'd2;
		eq_87_in1 = valid ? global_state : global_state;
	end
	// controller for eq_9.eq_9_in0
	// controller for eq_9.eq_9_in1
	// Insensitive connections
	always @(*) begin
		eq_9_in0 = valid ? 32'd0 : 32'd0;
		eq_9_in1 = valid ? global_state : global_state;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd3 : 32'd3;
		eq_90_in1 = valid ? global_state : global_state;
	end
	// controller for eq_91.eq_91_in0
	// controller for eq_91.eq_91_in1
	// Insensitive connections
	always @(*) begin
		eq_91_in0 = valid ? 32'd4 : 32'd4;
		eq_91_in1 = valid ? global_state : global_state;
	end
	// controller for eq_92.eq_92_in0
	// controller for eq_92.eq_92_in1
	// Insensitive connections
	always @(*) begin
		eq_92_in0 = valid ? 32'd5 : 32'd5;
		eq_92_in1 = valid ? global_state : global_state;
	end
	// controller for eq_93.eq_93_in0
	// controller for eq_93.eq_93_in1
	// Insensitive connections
	always @(*) begin
		eq_93_in0 = valid ? 32'd6 : 32'd6;
		eq_93_in1 = valid ? global_state : global_state;
	end
	// controller for eq_94.eq_94_in0
	// controller for eq_94.eq_94_in1
	// Insensitive connections
	always @(*) begin
		eq_94_in0 = valid ? 32'd7 : 32'd7;
		eq_94_in1 = valid ? global_state : global_state;
	end
	// controller for eq_95.eq_95_in0
	// controller for eq_95.eq_95_in1
	// Insensitive connections
	always @(*) begin
		eq_95_in0 = valid ? 32'd8 : 32'd8;
		eq_95_in1 = valid ? global_state : global_state;
	end
	// controller for eq_96.eq_96_in0
	// controller for eq_96.eq_96_in1
	// Insensitive connections
	always @(*) begin
		eq_96_in0 = valid ? 32'd0 : 32'd0;
		eq_96_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_97.eq_97_in0
	// controller for eq_97.eq_97_in1
	// Insensitive connections
	always @(*) begin
		eq_97_in0 = valid ? 32'd0 : 32'd0;
		eq_97_in1 = valid ? global_state : global_state;
	end
	// controller for eq_99.eq_99_in0
	// controller for eq_99.eq_99_in1
	// Insensitive connections
	always @(*) begin
		eq_99_in0 = valid ? 32'd1 : 32'd1;
		eq_99_in1 = valid ? global_next_block : global_next_block;
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
		if (andOp_39_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (andOp_41_out) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_102.notOp_102_in0
	// Insensitive connections
	always @(*) begin
		notOp_102_in0 = valid ? eq_101_out : eq_101_out;
	end
	// controller for notOp_103.notOp_103_in0
	// Insensitive connections
	always @(*) begin
		notOp_103_in0 = valid ? icmp_tmp_3 : icmp_tmp_3;
	end
	// controller for notOp_98.notOp_98_in0
	// Insensitive connections
	always @(*) begin
		notOp_98_in0 = valid ? eq_97_out : eq_97_out;
	end
	// controller for out.out_in_data_reg
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_49_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (andOp_51_out) begin 
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
		if (andOp_2_out) begin 
			raddr_ram_0_reg = 0;
		end else if (andOp_4_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_6_out) begin 
			waddr_ram_0_reg = 0;
		end else if (andOp_8_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_10_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (andOp_12_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_14_out) begin 
			wen_ram_0_reg = 1;
		end else if (andOp_16_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_24.valid_reg
	always @(*) begin
		if (andOp_53_out) begin 
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
			if (andOp_86_out) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (br_0_happened_out_data) begin
				global_next_block <= 2;
			end
			if (icmp_tmp_3) begin
				global_next_block <= 1;
			end
			if (notOp_103_out) begin
				global_next_block <= 2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_58_out) begin
				global_state <= 1;
			end
			if (andOp_60_out) begin
				global_state <= 2;
			end
			if (andOp_63_out) begin
				global_state <= 3;
			end
			if (andOp_65_out) begin
				global_state <= 4;
			end
			if (andOp_67_out) begin
				global_state <= 5;
			end
			if (andOp_69_out) begin
				global_state <= 6;
			end
			if (andOp_70_out) begin
				global_state <= 2;
			end
			if (andOp_73_out) begin
				global_state <= 7;
			end
			if (andOp_75_out) begin
				global_state <= 8;
			end
			if (andOp_77_out) begin
				global_state <= 8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if (andOp_89_out) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_54_out) begin
				last_BB_reg <= 0;
			end
			if (eq_55_out) begin
				last_BB_reg <= 2;
			end
			if (eq_56_out) begin
				last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_1 <= 0;
		end else begin
			if (andOp_83_out) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

