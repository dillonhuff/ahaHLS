module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);

	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [0:0] valid_reg;

	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	add alloca_0();

	add bitcast_1();

	add call_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add call_21();

	reg [63:0] phi_in_phi_8;
	reg [31:0] phi_last_block_phi_8;
	reg [63:0] phi_s_phi_8;
	wire [31:0] phi_out_phi_8;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_8(.in(phi_in_phi_8), .last_block(phi_last_block_phi_8), .out(phi_out_phi_8), .s(phi_s_phi_8));

	reg [31:0] add_in0_add_14;
	reg [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	reg [31:0] add_in0_add_16;
	reg [31:0] add_in1_add_16;
	wire [31:0] add_out_add_16;
	add #(.WIDTH(32)) add_add_16(.in0(add_in0_add_16), .in1(add_in1_add_16), .out(add_out_add_16));

	reg [31:0] cmp_in0_icmp_17;
	reg [31:0] cmp_in1_icmp_17;
	wire [0:0] cmp_out_icmp_17;
	eq #(.WIDTH(32)) icmp_17(.in0(cmp_in0_icmp_17), .in1(cmp_in1_icmp_17), .out(cmp_out_icmp_17));

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [31:0] eq_1_in0;
	reg [31:0] eq_1_in1;
	wire [0:0] eq_1_out;
	eq #(.WIDTH(32)) eq_1(.in0(eq_1_in0), .in1(eq_1_in1), .out(eq_1_out));

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

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [0:0] andOp_5_in0;
	reg [0:0] andOp_5_in1;
	wire [0:0] andOp_5_out;
	andOp #(.WIDTH(1)) andOp_5(.in0(andOp_5_in0), .in1(andOp_5_in1), .out(andOp_5_out));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] br_0_happened_in_data;
	wire [0:0] br_0_happened_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened(.in_data(br_0_happened_in_data), .out_data(br_0_happened_out_data));

	reg [0:0] notOp_7_in0;
	wire [0:0] notOp_7_out;
	notOp #(.WIDTH(1)) notOp_7(.in(notOp_7_in0), .out(notOp_7_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [0:0] andOp_8_in0;
	reg [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	reg [0:0] andOp_9_in0;
	reg [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	reg [0:0] br_1_happened_in_data;
	wire [0:0] br_1_happened_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened(.in_data(br_1_happened_in_data), .out_data(br_1_happened_out_data));

	reg [0:0] notOp_10_in0;
	wire [0:0] notOp_10_out;
	notOp #(.WIDTH(1)) notOp_10(.in(notOp_10_in0), .out(notOp_10_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [0:0] bb_3_active_in_data;
	wire [0:0] bb_3_active_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active(.in_data(bb_3_active_in_data), .out_data(bb_3_active_out_data));

	reg [0:0] andOp_11_in0;
	reg [0:0] andOp_11_in1;
	wire [0:0] andOp_11_out;
	andOp #(.WIDTH(1)) andOp_11(.in0(andOp_11_in0), .in1(andOp_11_in1), .out(andOp_11_out));

	reg [0:0] andOp_12_in0;
	reg [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] br_3_happened_in_data;
	wire [0:0] br_3_happened_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened(.in_data(br_3_happened_in_data), .out_data(br_3_happened_out_data));

	reg [0:0] notOp_13_in0;
	wire [0:0] notOp_13_out;
	notOp #(.WIDTH(1)) notOp_13(.in(notOp_13_in0), .out(notOp_13_out));

	reg [0:0] bb_4_active_in_data;
	wire [0:0] bb_4_active_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active(.in_data(bb_4_active_in_data), .out_data(bb_4_active_out_data));

	reg [0:0] andOp_14_in0;
	reg [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	reg [0:0] andOp_15_in0;
	reg [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [0:0] br_4_happened_in_data;
	wire [0:0] br_4_happened_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened(.in_data(br_4_happened_in_data), .out_data(br_4_happened_out_data));

	reg [0:0] notOp_16_in0;
	wire [0:0] notOp_16_out;
	notOp #(.WIDTH(1)) notOp_16(.in(notOp_16_in0), .out(notOp_16_out));

	reg [0:0] andOp_17_in0;
	reg [0:0] andOp_17_in1;
	wire [0:0] andOp_17_out;
	andOp #(.WIDTH(1)) andOp_17(.in0(andOp_17_in0), .in1(andOp_17_in1), .out(andOp_17_out));

	reg [0:0] notOp_18_in0;
	wire [0:0] notOp_18_out;
	notOp #(.WIDTH(1)) notOp_18(.in(notOp_18_in0), .out(notOp_18_out));

	reg [0:0] andOp_19_in0;
	reg [0:0] andOp_19_in1;
	wire [0:0] andOp_19_out;
	andOp #(.WIDTH(1)) andOp_19(.in0(andOp_19_in0), .in1(andOp_19_in1), .out(andOp_19_out));

	reg [0:0] bb_5_active_in_data;
	wire [0:0] bb_5_active_out_data;
	hls_wire #(.WIDTH(1)) bb_5_active(.in_data(bb_5_active_in_data), .out_data(bb_5_active_out_data));

	reg [0:0] andOp_20_in0;
	reg [0:0] andOp_20_in1;
	wire [0:0] andOp_20_out;
	andOp #(.WIDTH(1)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	reg [0:0] andOp_21_in0;
	reg [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [0:0] br_5_happened_in_data;
	wire [0:0] br_5_happened_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened(.in_data(br_5_happened_in_data), .out_data(br_5_happened_out_data));

	reg [0:0] notOp_22_in0;
	wire [0:0] notOp_22_out;
	notOp #(.WIDTH(1)) notOp_22(.in(notOp_22_in0), .out(notOp_22_out));

	reg [0:0] bb_6_active_in_data;
	wire [0:0] bb_6_active_out_data;
	hls_wire #(.WIDTH(1)) bb_6_active(.in_data(bb_6_active_in_data), .out_data(bb_6_active_out_data));

	reg [0:0] andOp_23_in0;
	reg [0:0] andOp_23_in1;
	wire [0:0] andOp_23_out;
	andOp #(.WIDTH(1)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	reg [0:0] andOp_24_in0;
	reg [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

	reg [0:0] br_6_happened_in_data;
	wire [0:0] br_6_happened_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened(.in_data(br_6_happened_in_data), .out_data(br_6_happened_out_data));

	reg [0:0] notOp_25_in0;
	wire [0:0] notOp_25_out;
	notOp #(.WIDTH(1)) notOp_25(.in(notOp_25_in0), .out(notOp_25_out));

	reg [0:0] andOp_26_in0;
	reg [0:0] andOp_26_in1;
	wire [0:0] andOp_26_out;
	andOp #(.WIDTH(1)) andOp_26(.in0(andOp_26_in0), .in1(andOp_26_in1), .out(andOp_26_out));

	reg [0:0] notOp_27_in0;
	wire [0:0] notOp_27_out;
	notOp #(.WIDTH(1)) notOp_27(.in(notOp_27_in0), .out(notOp_27_out));

	reg [0:0] andOp_28_in0;
	reg [0:0] andOp_28_in1;
	wire [0:0] andOp_28_out;
	andOp #(.WIDTH(1)) andOp_28(.in0(andOp_28_in0), .in1(andOp_28_in1), .out(andOp_28_out));

	reg [0:0] bb_7_active_in_data;
	wire [0:0] bb_7_active_out_data;
	hls_wire #(.WIDTH(1)) bb_7_active(.in_data(bb_7_active_in_data), .out_data(bb_7_active_out_data));

	reg [0:0] andOp_29_in0;
	reg [0:0] andOp_29_in1;
	wire [0:0] andOp_29_out;
	andOp #(.WIDTH(1)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	reg [0:0] andOp_30_in0;
	reg [0:0] andOp_30_in1;
	wire [0:0] andOp_30_out;
	andOp #(.WIDTH(1)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

	reg [0:0] br_7_happened_in_data;
	wire [0:0] br_7_happened_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened(.in_data(br_7_happened_in_data), .out_data(br_7_happened_out_data));

	reg [0:0] notOp_31_in0;
	wire [0:0] notOp_31_out;
	notOp #(.WIDTH(1)) notOp_31(.in(notOp_31_in0), .out(notOp_31_out));

	reg [0:0] bb_8_active_in_data;
	wire [0:0] bb_8_active_out_data;
	hls_wire #(.WIDTH(1)) bb_8_active(.in_data(bb_8_active_in_data), .out_data(bb_8_active_out_data));

	reg [0:0] andOp_32_in0;
	reg [0:0] andOp_32_in1;
	wire [0:0] andOp_32_out;
	andOp #(.WIDTH(1)) andOp_32(.in0(andOp_32_in0), .in1(andOp_32_in1), .out(andOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [0:0] br_8_happened_in_data;
	wire [0:0] br_8_happened_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened(.in_data(br_8_happened_in_data), .out_data(br_8_happened_out_data));

	reg [0:0] notOp_34_in0;
	wire [0:0] notOp_34_out;
	notOp #(.WIDTH(1)) notOp_34(.in(notOp_34_in0), .out(notOp_34_out));

	reg [0:0] bb_9_active_in_data;
	wire [0:0] bb_9_active_out_data;
	hls_wire #(.WIDTH(1)) bb_9_active(.in_data(bb_9_active_in_data), .out_data(bb_9_active_out_data));

	reg [0:0] andOp_35_in0;
	reg [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	reg [0:0] andOp_36_in0;
	reg [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	reg [0:0] br_9_happened_in_data;
	wire [0:0] br_9_happened_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened(.in_data(br_9_happened_in_data), .out_data(br_9_happened_out_data));

	reg [0:0] notOp_37_in0;
	wire [0:0] notOp_37_out;
	notOp #(.WIDTH(1)) notOp_37(.in(notOp_37_in0), .out(notOp_37_out));

	reg [0:0] andOp_38_in0;
	reg [0:0] andOp_38_in1;
	wire [0:0] andOp_38_out;
	andOp #(.WIDTH(1)) andOp_38(.in0(andOp_38_in0), .in1(andOp_38_in1), .out(andOp_38_out));

	reg [0:0] notOp_39_in0;
	wire [0:0] notOp_39_out;
	notOp #(.WIDTH(1)) notOp_39(.in(notOp_39_in0), .out(notOp_39_out));

	reg [0:0] andOp_40_in0;
	reg [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	reg [0:0] bb_10_active_in_data;
	wire [0:0] bb_10_active_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active(.in_data(bb_10_active_in_data), .out_data(bb_10_active_out_data));

	reg [0:0] andOp_41_in0;
	reg [0:0] andOp_41_in1;
	wire [0:0] andOp_41_out;
	andOp #(.WIDTH(1)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [0:0] br_10_happened_in_data;
	wire [0:0] br_10_happened_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened(.in_data(br_10_happened_in_data), .out_data(br_10_happened_out_data));

	reg [0:0] notOp_43_in0;
	wire [0:0] notOp_43_out;
	notOp #(.WIDTH(1)) notOp_43(.in(notOp_43_in0), .out(notOp_43_out));

	reg [31:0] eq_44_in0;
	reg [31:0] eq_44_in1;
	wire [0:0] eq_44_out;
	eq #(.WIDTH(32)) eq_44(.in0(eq_44_in0), .in1(eq_44_in1), .out(eq_44_out));

	reg [31:0] eq_45_in0;
	reg [31:0] eq_45_in1;
	wire [0:0] eq_45_out;
	eq #(.WIDTH(32)) eq_45(.in0(eq_45_in0), .in1(eq_45_in1), .out(eq_45_out));

	reg [0:0] orOp_46_in0;
	reg [0:0] orOp_46_in1;
	wire [0:0] orOp_46_out;
	orOp #(.WIDTH(1)) orOp_46(.in0(orOp_46_in0), .in1(orOp_46_in1), .out(orOp_46_out));

	reg [31:0] eq_47_in0;
	reg [31:0] eq_47_in1;
	wire [0:0] eq_47_out;
	eq #(.WIDTH(32)) eq_47(.in0(eq_47_in0), .in1(eq_47_in1), .out(eq_47_out));

	reg [0:0] orOp_48_in0;
	reg [0:0] orOp_48_in1;
	wire [0:0] orOp_48_out;
	orOp #(.WIDTH(1)) orOp_48(.in0(orOp_48_in0), .in1(orOp_48_in1), .out(orOp_48_out));

	reg [31:0] eq_49_in0;
	reg [31:0] eq_49_in1;
	wire [0:0] eq_49_out;
	eq #(.WIDTH(32)) eq_49(.in0(eq_49_in0), .in1(eq_49_in1), .out(eq_49_out));

	reg [0:0] orOp_50_in0;
	reg [0:0] orOp_50_in1;
	wire [0:0] orOp_50_out;
	orOp #(.WIDTH(1)) orOp_50(.in0(orOp_50_in0), .in1(orOp_50_in1), .out(orOp_50_out));

	reg [31:0] eq_51_in0;
	reg [31:0] eq_51_in1;
	wire [0:0] eq_51_out;
	eq #(.WIDTH(32)) eq_51(.in0(eq_51_in0), .in1(eq_51_in1), .out(eq_51_out));

	reg [0:0] orOp_52_in0;
	reg [0:0] orOp_52_in1;
	wire [0:0] orOp_52_out;
	orOp #(.WIDTH(1)) orOp_52(.in0(orOp_52_in0), .in1(orOp_52_in1), .out(orOp_52_out));

	reg [31:0] eq_53_in0;
	reg [31:0] eq_53_in1;
	wire [0:0] eq_53_out;
	eq #(.WIDTH(32)) eq_53(.in0(eq_53_in0), .in1(eq_53_in1), .out(eq_53_out));

	reg [0:0] orOp_54_in0;
	reg [0:0] orOp_54_in1;
	wire [0:0] orOp_54_out;
	orOp #(.WIDTH(1)) orOp_54(.in0(orOp_54_in0), .in1(orOp_54_in1), .out(orOp_54_out));

	reg [31:0] eq_55_in0;
	reg [31:0] eq_55_in1;
	wire [0:0] eq_55_out;
	eq #(.WIDTH(32)) eq_55(.in0(eq_55_in0), .in1(eq_55_in1), .out(eq_55_out));

	reg [0:0] orOp_56_in0;
	reg [0:0] orOp_56_in1;
	wire [0:0] orOp_56_out;
	orOp #(.WIDTH(1)) orOp_56(.in0(orOp_56_in0), .in1(orOp_56_in1), .out(orOp_56_out));

	reg [31:0] eq_57_in0;
	reg [31:0] eq_57_in1;
	wire [0:0] eq_57_out;
	eq #(.WIDTH(32)) eq_57(.in0(eq_57_in0), .in1(eq_57_in1), .out(eq_57_out));

	reg [0:0] orOp_58_in0;
	reg [0:0] orOp_58_in1;
	wire [0:0] orOp_58_out;
	orOp #(.WIDTH(1)) orOp_58(.in0(orOp_58_in0), .in1(orOp_58_in1), .out(orOp_58_out));

	reg [31:0] eq_59_in0;
	reg [31:0] eq_59_in1;
	wire [0:0] eq_59_out;
	eq #(.WIDTH(32)) eq_59(.in0(eq_59_in0), .in1(eq_59_in1), .out(eq_59_out));

	reg [0:0] orOp_60_in0;
	reg [0:0] orOp_60_in1;
	wire [0:0] orOp_60_out;
	orOp #(.WIDTH(1)) orOp_60(.in0(orOp_60_in0), .in1(orOp_60_in1), .out(orOp_60_out));

	reg [31:0] eq_61_in0;
	reg [31:0] eq_61_in1;
	wire [0:0] eq_61_out;
	eq #(.WIDTH(32)) eq_61(.in0(eq_61_in0), .in1(eq_61_in1), .out(eq_61_out));

	reg [0:0] orOp_62_in0;
	reg [0:0] orOp_62_in1;
	wire [0:0] orOp_62_out;
	orOp #(.WIDTH(1)) orOp_62(.in0(orOp_62_in0), .in1(orOp_62_in1), .out(orOp_62_out));

	reg [31:0] eq_63_in0;
	reg [31:0] eq_63_in1;
	wire [0:0] eq_63_out;
	eq #(.WIDTH(32)) eq_63(.in0(eq_63_in0), .in1(eq_63_in1), .out(eq_63_out));

	reg [0:0] andOp_64_in0;
	reg [0:0] andOp_64_in1;
	wire [0:0] andOp_64_out;
	andOp #(.WIDTH(1)) andOp_64(.in0(andOp_64_in0), .in1(andOp_64_in1), .out(andOp_64_out));

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

	reg [31:0] bb_0_predecessor_in_data;
	wire [31:0] bb_0_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor(.in_data(bb_0_predecessor_in_data), .out_data(bb_0_predecessor_out_data));

	reg [31:0] eq_68_in0;
	reg [31:0] eq_68_in1;
	wire [0:0] eq_68_out;
	eq #(.WIDTH(32)) eq_68(.in0(eq_68_in0), .in1(eq_68_in1), .out(eq_68_out));

	reg [31:0] bb_1_predecessor_in_data;
	wire [31:0] bb_1_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor(.in_data(bb_1_predecessor_in_data), .out_data(bb_1_predecessor_out_data));

	reg [31:0] eq_69_in0;
	reg [31:0] eq_69_in1;
	wire [0:0] eq_69_out;
	eq #(.WIDTH(32)) eq_69(.in0(eq_69_in0), .in1(eq_69_in1), .out(eq_69_out));

	reg [0:0] notOp_70_in0;
	wire [0:0] notOp_70_out;
	notOp #(.WIDTH(1)) notOp_70(.in(notOp_70_in0), .out(notOp_70_out));

	reg [0:0] andOp_71_in0;
	reg [0:0] andOp_71_in1;
	wire [0:0] andOp_71_out;
	andOp #(.WIDTH(1)) andOp_71(.in0(andOp_71_in0), .in1(andOp_71_in1), .out(andOp_71_out));

	reg [31:0] bb_2_predecessor_in_data;
	wire [31:0] bb_2_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor(.in_data(bb_2_predecessor_in_data), .out_data(bb_2_predecessor_out_data));

	reg [31:0] eq_72_in0;
	reg [31:0] eq_72_in1;
	wire [0:0] eq_72_out;
	eq #(.WIDTH(32)) eq_72(.in0(eq_72_in0), .in1(eq_72_in1), .out(eq_72_out));

	reg [0:0] notOp_73_in0;
	wire [0:0] notOp_73_out;
	notOp #(.WIDTH(1)) notOp_73(.in(notOp_73_in0), .out(notOp_73_out));

	reg [0:0] andOp_74_in0;
	reg [0:0] andOp_74_in1;
	wire [0:0] andOp_74_out;
	andOp #(.WIDTH(1)) andOp_74(.in0(andOp_74_in0), .in1(andOp_74_in1), .out(andOp_74_out));

	reg [31:0] bb_3_predecessor_in_data;
	wire [31:0] bb_3_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_3_predecessor(.in_data(bb_3_predecessor_in_data), .out_data(bb_3_predecessor_out_data));

	reg [31:0] eq_75_in0;
	reg [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

	reg [0:0] notOp_76_in0;
	wire [0:0] notOp_76_out;
	notOp #(.WIDTH(1)) notOp_76(.in(notOp_76_in0), .out(notOp_76_out));

	reg [0:0] andOp_77_in0;
	reg [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	reg [31:0] bb_4_predecessor_in_data;
	wire [31:0] bb_4_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor(.in_data(bb_4_predecessor_in_data), .out_data(bb_4_predecessor_out_data));

	reg [31:0] eq_78_in0;
	reg [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	reg [0:0] notOp_79_in0;
	wire [0:0] notOp_79_out;
	notOp #(.WIDTH(1)) notOp_79(.in(notOp_79_in0), .out(notOp_79_out));

	reg [0:0] andOp_80_in0;
	reg [0:0] andOp_80_in1;
	wire [0:0] andOp_80_out;
	andOp #(.WIDTH(1)) andOp_80(.in0(andOp_80_in0), .in1(andOp_80_in1), .out(andOp_80_out));

	reg [31:0] bb_5_predecessor_in_data;
	wire [31:0] bb_5_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_5_predecessor(.in_data(bb_5_predecessor_in_data), .out_data(bb_5_predecessor_out_data));

	reg [31:0] eq_81_in0;
	reg [31:0] eq_81_in1;
	wire [0:0] eq_81_out;
	eq #(.WIDTH(32)) eq_81(.in0(eq_81_in0), .in1(eq_81_in1), .out(eq_81_out));

	reg [0:0] notOp_82_in0;
	wire [0:0] notOp_82_out;
	notOp #(.WIDTH(1)) notOp_82(.in(notOp_82_in0), .out(notOp_82_out));

	reg [0:0] andOp_83_in0;
	reg [0:0] andOp_83_in1;
	wire [0:0] andOp_83_out;
	andOp #(.WIDTH(1)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	reg [31:0] bb_6_predecessor_in_data;
	wire [31:0] bb_6_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_6_predecessor(.in_data(bb_6_predecessor_in_data), .out_data(bb_6_predecessor_out_data));

	reg [31:0] eq_84_in0;
	reg [31:0] eq_84_in1;
	wire [0:0] eq_84_out;
	eq #(.WIDTH(32)) eq_84(.in0(eq_84_in0), .in1(eq_84_in1), .out(eq_84_out));

	reg [0:0] notOp_85_in0;
	wire [0:0] notOp_85_out;
	notOp #(.WIDTH(1)) notOp_85(.in(notOp_85_in0), .out(notOp_85_out));

	reg [0:0] andOp_86_in0;
	reg [0:0] andOp_86_in1;
	wire [0:0] andOp_86_out;
	andOp #(.WIDTH(1)) andOp_86(.in0(andOp_86_in0), .in1(andOp_86_in1), .out(andOp_86_out));

	reg [31:0] bb_7_predecessor_in_data;
	wire [31:0] bb_7_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_7_predecessor(.in_data(bb_7_predecessor_in_data), .out_data(bb_7_predecessor_out_data));

	reg [31:0] eq_87_in0;
	reg [31:0] eq_87_in1;
	wire [0:0] eq_87_out;
	eq #(.WIDTH(32)) eq_87(.in0(eq_87_in0), .in1(eq_87_in1), .out(eq_87_out));

	reg [0:0] notOp_88_in0;
	wire [0:0] notOp_88_out;
	notOp #(.WIDTH(1)) notOp_88(.in(notOp_88_in0), .out(notOp_88_out));

	reg [0:0] andOp_89_in0;
	reg [0:0] andOp_89_in1;
	wire [0:0] andOp_89_out;
	andOp #(.WIDTH(1)) andOp_89(.in0(andOp_89_in0), .in1(andOp_89_in1), .out(andOp_89_out));

	reg [31:0] bb_8_predecessor_in_data;
	wire [31:0] bb_8_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_8_predecessor(.in_data(bb_8_predecessor_in_data), .out_data(bb_8_predecessor_out_data));

	reg [31:0] eq_90_in0;
	reg [31:0] eq_90_in1;
	wire [0:0] eq_90_out;
	eq #(.WIDTH(32)) eq_90(.in0(eq_90_in0), .in1(eq_90_in1), .out(eq_90_out));

	reg [0:0] notOp_91_in0;
	wire [0:0] notOp_91_out;
	notOp #(.WIDTH(1)) notOp_91(.in(notOp_91_in0), .out(notOp_91_out));

	reg [0:0] andOp_92_in0;
	reg [0:0] andOp_92_in1;
	wire [0:0] andOp_92_out;
	andOp #(.WIDTH(1)) andOp_92(.in0(andOp_92_in0), .in1(andOp_92_in1), .out(andOp_92_out));

	reg [31:0] bb_9_predecessor_in_data;
	wire [31:0] bb_9_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_9_predecessor(.in_data(bb_9_predecessor_in_data), .out_data(bb_9_predecessor_out_data));

	reg [31:0] eq_93_in0;
	reg [31:0] eq_93_in1;
	wire [0:0] eq_93_out;
	eq #(.WIDTH(32)) eq_93(.in0(eq_93_in0), .in1(eq_93_in1), .out(eq_93_out));

	reg [0:0] notOp_94_in0;
	wire [0:0] notOp_94_out;
	notOp #(.WIDTH(1)) notOp_94(.in(notOp_94_in0), .out(notOp_94_out));

	reg [0:0] andOp_95_in0;
	reg [0:0] andOp_95_in1;
	wire [0:0] andOp_95_out;
	andOp #(.WIDTH(1)) andOp_95(.in0(andOp_95_in0), .in1(andOp_95_in1), .out(andOp_95_out));

	reg [31:0] bb_10_predecessor_in_data;
	wire [31:0] bb_10_predecessor_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor(.in_data(bb_10_predecessor_in_data), .out_data(bb_10_predecessor_out_data));

	reg [31:0] eq_96_in0;
	reg [31:0] eq_96_in1;
	wire [0:0] eq_96_out;
	eq #(.WIDTH(32)) eq_96(.in0(eq_96_in0), .in1(eq_96_in1), .out(eq_96_out));

	reg [0:0] andOp_97_in0;
	reg [0:0] andOp_97_in1;
	wire [0:0] andOp_97_out;
	andOp #(.WIDTH(1)) andOp_97(.in0(andOp_97_in0), .in1(andOp_97_in1), .out(andOp_97_out));

	reg [0:0] andOp_98_in0;
	reg [0:0] andOp_98_in1;
	wire [0:0] andOp_98_out;
	andOp #(.WIDTH(1)) andOp_98(.in0(andOp_98_in0), .in1(andOp_98_in1), .out(andOp_98_out));

	reg [0:0] andOp_99_in0;
	reg [0:0] andOp_99_in1;
	wire [0:0] andOp_99_out;
	andOp #(.WIDTH(1)) andOp_99(.in0(andOp_99_in0), .in1(andOp_99_in1), .out(andOp_99_out));

	reg [0:0] andOp_100_in0;
	reg [0:0] andOp_100_in1;
	wire [0:0] andOp_100_out;
	andOp #(.WIDTH(1)) andOp_100(.in0(andOp_100_in0), .in1(andOp_100_in1), .out(andOp_100_out));

	reg [0:0] andOp_101_in0;
	reg [0:0] andOp_101_in1;
	wire [0:0] andOp_101_out;
	andOp #(.WIDTH(1)) andOp_101(.in0(andOp_101_in0), .in1(andOp_101_in1), .out(andOp_101_out));

	reg [0:0] andOp_102_in0;
	reg [0:0] andOp_102_in1;
	wire [0:0] andOp_102_out;
	andOp #(.WIDTH(1)) andOp_102(.in0(andOp_102_in0), .in1(andOp_102_in1), .out(andOp_102_out));

	reg [0:0] andOp_103_in0;
	reg [0:0] andOp_103_in1;
	wire [0:0] andOp_103_out;
	andOp #(.WIDTH(1)) andOp_103(.in0(andOp_103_in0), .in1(andOp_103_in1), .out(andOp_103_out));

	reg [0:0] andOp_104_in0;
	reg [0:0] andOp_104_in1;
	wire [0:0] andOp_104_out;
	andOp #(.WIDTH(1)) andOp_104(.in0(andOp_104_in0), .in1(andOp_104_in1), .out(andOp_104_out));

	reg [0:0] andOp_105_in0;
	reg [0:0] andOp_105_in1;
	wire [0:0] andOp_105_out;
	andOp #(.WIDTH(1)) andOp_105(.in0(andOp_105_in0), .in1(andOp_105_in1), .out(andOp_105_out));

	reg [0:0] andOp_106_in0;
	reg [0:0] andOp_106_in1;
	wire [0:0] andOp_106_out;
	andOp #(.WIDTH(1)) andOp_106(.in0(andOp_106_in0), .in1(andOp_106_in1), .out(andOp_106_out));

	reg [0:0] andOp_107_in0;
	reg [0:0] andOp_107_in1;
	wire [0:0] andOp_107_out;
	andOp #(.WIDTH(1)) andOp_107(.in0(andOp_107_in0), .in1(andOp_107_in1), .out(andOp_107_out));

	reg [31:0] concat_108_in0;
	reg [31:0] concat_108_in1;
	wire [63:0] concat_108_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_108(.in0(concat_108_in0), .in1(concat_108_in1), .out(concat_108_out));

	reg [31:0] concat_109_in0;
	reg [31:0] concat_109_in1;
	wire [63:0] concat_109_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_109(.in0(concat_109_in0), .in1(concat_109_in1), .out(concat_109_out));

	reg [0:0] andOp_110_in0;
	reg [0:0] andOp_110_in1;
	wire [0:0] andOp_110_out;
	andOp #(.WIDTH(1)) andOp_110(.in0(andOp_110_in0), .in1(andOp_110_in1), .out(andOp_110_out));

	reg [31:0] tmp_output_111_in_data;
	wire [31:0] tmp_output_111_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_111(.in_data(tmp_output_111_in_data), .out_data(tmp_output_111_out_data));

	reg [31:0] eq_112_in0;
	reg [31:0] eq_112_in1;
	wire [0:0] eq_112_out;
	eq #(.WIDTH(32)) eq_112(.in0(eq_112_in0), .in1(eq_112_in1), .out(eq_112_out));

	reg [0:0] andOp_113_in0;
	reg [0:0] andOp_113_in1;
	wire [0:0] andOp_113_out;
	andOp #(.WIDTH(1)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	reg [0:0] andOp_114_in0;
	reg [0:0] andOp_114_in1;
	wire [0:0] andOp_114_out;
	andOp #(.WIDTH(1)) andOp_114(.in0(andOp_114_in0), .in1(andOp_114_in1), .out(andOp_114_out));

	reg [0:0] andOp_115_in0;
	reg [0:0] andOp_115_in1;
	wire [0:0] andOp_115_out;
	andOp #(.WIDTH(1)) andOp_115(.in0(andOp_115_in0), .in1(andOp_115_in1), .out(andOp_115_out));

	reg [0:0] andOp_116_in0;
	reg [0:0] andOp_116_in1;
	wire [0:0] andOp_116_out;
	andOp #(.WIDTH(1)) andOp_116(.in0(andOp_116_in0), .in1(andOp_116_in1), .out(andOp_116_out));

	reg [0:0] andOp_117_in0;
	reg [0:0] andOp_117_in1;
	wire [0:0] andOp_117_out;
	andOp #(.WIDTH(1)) andOp_117(.in0(andOp_117_in0), .in1(andOp_117_in1), .out(andOp_117_out));

	reg [0:0] andOp_118_in0;
	reg [0:0] andOp_118_in1;
	wire [0:0] andOp_118_out;
	andOp #(.WIDTH(1)) andOp_118(.in0(andOp_118_in0), .in1(andOp_118_in1), .out(andOp_118_out));

	reg [0:0] andOp_119_in0;
	reg [0:0] andOp_119_in1;
	wire [0:0] andOp_119_out;
	andOp #(.WIDTH(1)) andOp_119(.in0(andOp_119_in0), .in1(andOp_119_in1), .out(andOp_119_out));

	reg [0:0] andOp_120_in0;
	reg [0:0] andOp_120_in1;
	wire [0:0] andOp_120_out;
	andOp #(.WIDTH(1)) andOp_120(.in0(andOp_120_in0), .in1(andOp_120_in1), .out(andOp_120_out));

	reg [0:0] andOp_121_in0;
	reg [0:0] andOp_121_in1;
	wire [0:0] andOp_121_out;
	andOp #(.WIDTH(1)) andOp_121(.in0(andOp_121_in0), .in1(andOp_121_in1), .out(andOp_121_out));

	reg [0:0] andOp_122_in0;
	reg [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	reg [0:0] andOp_123_in0;
	reg [0:0] andOp_123_in1;
	wire [0:0] andOp_123_out;
	andOp #(.WIDTH(1)) andOp_123(.in0(andOp_123_in0), .in1(andOp_123_in1), .out(andOp_123_out));

	reg [0:0] andOp_124_in0;
	reg [0:0] andOp_124_in1;
	wire [0:0] andOp_124_out;
	andOp #(.WIDTH(1)) andOp_124(.in0(andOp_124_in0), .in1(andOp_124_in1), .out(andOp_124_out));

	reg [0:0] andOp_125_in0;
	reg [0:0] andOp_125_in1;
	wire [0:0] andOp_125_out;
	andOp #(.WIDTH(1)) andOp_125(.in0(andOp_125_in0), .in1(andOp_125_in1), .out(andOp_125_out));

	reg [0:0] notOp_126_in0;
	wire [0:0] notOp_126_out;
	notOp #(.WIDTH(1)) notOp_126(.in(notOp_126_in0), .out(notOp_126_out));

	reg [0:0] andOp_127_in0;
	reg [0:0] andOp_127_in1;
	wire [0:0] andOp_127_out;
	andOp #(.WIDTH(1)) andOp_127(.in0(andOp_127_in0), .in1(andOp_127_in1), .out(andOp_127_out));

	reg [0:0] andOp_128_in0;
	reg [0:0] andOp_128_in1;
	wire [0:0] andOp_128_out;
	andOp #(.WIDTH(1)) andOp_128(.in0(andOp_128_in0), .in1(andOp_128_in1), .out(andOp_128_out));

	reg [0:0] andOp_129_in0;
	reg [0:0] andOp_129_in1;
	wire [0:0] andOp_129_out;
	andOp #(.WIDTH(1)) andOp_129(.in0(andOp_129_in0), .in1(andOp_129_in1), .out(andOp_129_out));

	reg [0:0] andOp_130_in0;
	reg [0:0] andOp_130_in1;
	wire [0:0] andOp_130_out;
	andOp #(.WIDTH(1)) andOp_130(.in0(andOp_130_in0), .in1(andOp_130_in1), .out(andOp_130_out));

	reg [0:0] andOp_131_in0;
	reg [0:0] andOp_131_in1;
	wire [0:0] andOp_131_out;
	andOp #(.WIDTH(1)) andOp_131(.in0(andOp_131_in0), .in1(andOp_131_in1), .out(andOp_131_out));

	reg [0:0] andOp_132_in0;
	reg [0:0] andOp_132_in1;
	wire [0:0] andOp_132_out;
	andOp #(.WIDTH(1)) andOp_132(.in0(andOp_132_in0), .in1(andOp_132_in1), .out(andOp_132_out));

	reg [0:0] andOp_133_in0;
	reg [0:0] andOp_133_in1;
	wire [0:0] andOp_133_out;
	andOp #(.WIDTH(1)) andOp_133(.in0(andOp_133_in0), .in1(andOp_133_in1), .out(andOp_133_out));

	reg [0:0] notOp_134_in0;
	wire [0:0] notOp_134_out;
	notOp #(.WIDTH(1)) notOp_134(.in(notOp_134_in0), .out(notOp_134_out));

	reg [0:0] andOp_135_in0;
	reg [0:0] andOp_135_in1;
	wire [0:0] andOp_135_out;
	andOp #(.WIDTH(1)) andOp_135(.in0(andOp_135_in0), .in1(andOp_135_in1), .out(andOp_135_out));

	reg [0:0] andOp_136_in0;
	reg [0:0] andOp_136_in1;
	wire [0:0] andOp_136_out;
	andOp #(.WIDTH(1)) andOp_136(.in0(andOp_136_in0), .in1(andOp_136_in1), .out(andOp_136_out));

	reg [0:0] andOp_137_in0;
	reg [0:0] andOp_137_in1;
	wire [0:0] andOp_137_out;
	andOp #(.WIDTH(1)) andOp_137(.in0(andOp_137_in0), .in1(andOp_137_in1), .out(andOp_137_out));

	reg [0:0] notOp_138_in0;
	wire [0:0] notOp_138_out;
	notOp #(.WIDTH(1)) notOp_138(.in(notOp_138_in0), .out(notOp_138_out));

	reg [0:0] andOp_139_in0;
	reg [0:0] andOp_139_in1;
	wire [0:0] andOp_139_out;
	andOp #(.WIDTH(1)) andOp_139(.in0(andOp_139_in0), .in1(andOp_139_in1), .out(andOp_139_out));

	reg [0:0] andOp_140_in0;
	reg [0:0] andOp_140_in1;
	wire [0:0] andOp_140_out;
	andOp #(.WIDTH(1)) andOp_140(.in0(andOp_140_in0), .in1(andOp_140_in1), .out(andOp_140_out));

	reg [0:0] andOp_141_in0;
	reg [0:0] andOp_141_in1;
	wire [0:0] andOp_141_out;
	andOp #(.WIDTH(1)) andOp_141(.in0(andOp_141_in0), .in1(andOp_141_in1), .out(andOp_141_out));

	reg [0:0] andOp_142_in0;
	reg [0:0] andOp_142_in1;
	wire [0:0] andOp_142_out;
	andOp #(.WIDTH(1)) andOp_142(.in0(andOp_142_in0), .in1(andOp_142_in1), .out(andOp_142_out));

	reg [0:0] andOp_143_in0;
	reg [0:0] andOp_143_in1;
	wire [0:0] andOp_143_out;
	andOp #(.WIDTH(1)) andOp_143(.in0(andOp_143_in0), .in1(andOp_143_in1), .out(andOp_143_out));

	reg [0:0] andOp_144_in0;
	reg [0:0] andOp_144_in1;
	wire [0:0] andOp_144_out;
	andOp #(.WIDTH(1)) andOp_144(.in0(andOp_144_in0), .in1(andOp_144_in1), .out(andOp_144_out));

	reg [0:0] andOp_145_in0;
	reg [0:0] andOp_145_in1;
	wire [0:0] andOp_145_out;
	andOp #(.WIDTH(1)) andOp_145(.in0(andOp_145_in0), .in1(andOp_145_in1), .out(andOp_145_out));

	reg [0:0] andOp_146_in0;
	reg [0:0] andOp_146_in1;
	wire [0:0] andOp_146_out;
	andOp #(.WIDTH(1)) andOp_146(.in0(andOp_146_in0), .in1(andOp_146_in1), .out(andOp_146_out));

	// End Functional Units

	reg [31:0] add_tmp_5;
	reg [31:0] call_tmp_2;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_6;
	reg [31:0] last_BB_reg;
	reg [31:0] phi_tmp_1;

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? rdata_ram_0 : rdata_ram_0;
		add_in1_add_14 = valid ? tmp_output_111_out_data : tmp_output_111_out_data;
	end
	// controller for add_add_16.add_in0_add_16
	// controller for add_add_16.add_in1_add_16
	// Insensitive connections
	always @(*) begin
		add_in0_add_16 = valid ? phi_tmp_1 : phi_tmp_1;
		add_in1_add_16 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_100.andOp_100_in0
	// controller for andOp_100.andOp_100_in1
	// Insensitive connections
	always @(*) begin
		andOp_100_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_100_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	always @(*) begin
		andOp_101_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_101_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_102.andOp_102_in0
	// controller for andOp_102.andOp_102_in1
	// Insensitive connections
	always @(*) begin
		andOp_102_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_102_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_103.andOp_103_in0
	// controller for andOp_103.andOp_103_in1
	// Insensitive connections
	always @(*) begin
		andOp_103_in0 = valid ? bb_7_active_out_data : bb_7_active_out_data;
		andOp_103_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_104.andOp_104_in0
	// controller for andOp_104.andOp_104_in1
	// Insensitive connections
	always @(*) begin
		andOp_104_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_104_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	always @(*) begin
		andOp_105_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_105_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_106.andOp_106_in0
	// controller for andOp_106.andOp_106_in1
	// Insensitive connections
	always @(*) begin
		andOp_106_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_106_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	always @(*) begin
		andOp_107_in0 = valid ? bb_3_active_out_data : bb_3_active_out_data;
		andOp_107_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_11.andOp_11_in0
	// controller for andOp_11.andOp_11_in1
	// Insensitive connections
	always @(*) begin
		andOp_11_in0 = valid ? bb_3_active_out_data : bb_3_active_out_data;
		andOp_11_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_110.andOp_110_in0
	// controller for andOp_110.andOp_110_in1
	// Insensitive connections
	always @(*) begin
		andOp_110_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_110_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_113_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	always @(*) begin
		andOp_114_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_114_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_115.andOp_115_in0
	// controller for andOp_115.andOp_115_in1
	// Insensitive connections
	always @(*) begin
		andOp_115_in0 = valid ? bb_7_active_out_data : bb_7_active_out_data;
		andOp_115_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_116.andOp_116_in0
	// controller for andOp_116.andOp_116_in1
	// Insensitive connections
	always @(*) begin
		andOp_116_in0 = valid ? bb_6_active_out_data : bb_6_active_out_data;
		andOp_116_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_117.andOp_117_in0
	// controller for andOp_117.andOp_117_in1
	// Insensitive connections
	always @(*) begin
		andOp_117_in0 = valid ? bb_7_active_out_data : bb_7_active_out_data;
		andOp_117_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_118.andOp_118_in0
	// controller for andOp_118.andOp_118_in1
	// Insensitive connections
	always @(*) begin
		andOp_118_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_118_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_119_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? andOp_11_out : andOp_11_out;
		andOp_12_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_120.andOp_120_in0
	// controller for andOp_120.andOp_120_in1
	// Insensitive connections
	always @(*) begin
		andOp_120_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_120_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_121.andOp_121_in0
	// controller for andOp_121.andOp_121_in1
	// Insensitive connections
	always @(*) begin
		andOp_121_in0 = valid ? andOp_120_out : andOp_120_out;
		andOp_121_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_122_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_123.andOp_123_in0
	// controller for andOp_123.andOp_123_in1
	// Insensitive connections
	always @(*) begin
		andOp_123_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_123_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_124.andOp_124_in0
	// controller for andOp_124.andOp_124_in1
	// Insensitive connections
	always @(*) begin
		andOp_124_in0 = valid ? andOp_123_out : andOp_123_out;
		andOp_124_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_125_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_127.andOp_127_in0
	// controller for andOp_127.andOp_127_in1
	// Insensitive connections
	always @(*) begin
		andOp_127_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_127_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? andOp_127_out : andOp_127_out;
		andOp_128_in1 = valid ? notOp_126_out : notOp_126_out;
	end
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	always @(*) begin
		andOp_129_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_129_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? andOp_129_out : andOp_129_out;
		andOp_130_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_131.andOp_131_in0
	// controller for andOp_131.andOp_131_in1
	// Insensitive connections
	always @(*) begin
		andOp_131_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_131_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_132.andOp_132_in0
	// controller for andOp_132.andOp_132_in1
	// Insensitive connections
	always @(*) begin
		andOp_132_in0 = valid ? andOp_131_out : andOp_131_out;
		andOp_132_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_133_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_135.andOp_135_in0
	// controller for andOp_135.andOp_135_in1
	// Insensitive connections
	always @(*) begin
		andOp_135_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_135_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_136.andOp_136_in0
	// controller for andOp_136.andOp_136_in1
	// Insensitive connections
	always @(*) begin
		andOp_136_in0 = valid ? andOp_135_out : andOp_135_out;
		andOp_136_in1 = valid ? notOp_134_out : notOp_134_out;
	end
	// controller for andOp_137.andOp_137_in0
	// controller for andOp_137.andOp_137_in1
	// Insensitive connections
	always @(*) begin
		andOp_137_in0 = valid ? bb_6_active_out_data : bb_6_active_out_data;
		andOp_137_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? bb_6_active_out_data : bb_6_active_out_data;
		andOp_139_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_14_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_140.andOp_140_in0
	// controller for andOp_140.andOp_140_in1
	// Insensitive connections
	always @(*) begin
		andOp_140_in0 = valid ? andOp_139_out : andOp_139_out;
		andOp_140_in1 = valid ? notOp_138_out : notOp_138_out;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_141_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? andOp_141_out : andOp_141_out;
		andOp_142_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_143.andOp_143_in0
	// controller for andOp_143.andOp_143_in1
	// Insensitive connections
	always @(*) begin
		andOp_143_in0 = valid ? bb_3_active_out_data : bb_3_active_out_data;
		andOp_143_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_144_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_145_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_146.andOp_146_in0
	// controller for andOp_146.andOp_146_in1
	// Insensitive connections
	always @(*) begin
		andOp_146_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_146_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	always @(*) begin
		andOp_15_in0 = valid ? andOp_14_out : andOp_14_out;
		andOp_15_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	always @(*) begin
		andOp_17_in0 = valid ? andOp_15_out : andOp_15_out;
		andOp_17_in1 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? andOp_15_out : andOp_15_out;
		andOp_19_in1 = valid ? notOp_18_out : notOp_18_out;
	end
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	always @(*) begin
		andOp_20_in0 = valid ? bb_5_active_out_data : bb_5_active_out_data;
		andOp_20_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? andOp_20_out : andOp_20_out;
		andOp_21_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? bb_6_active_out_data : bb_6_active_out_data;
		andOp_23_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_24.andOp_24_in0
	// controller for andOp_24.andOp_24_in1
	// Insensitive connections
	always @(*) begin
		andOp_24_in0 = valid ? andOp_23_out : andOp_23_out;
		andOp_24_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_26.andOp_26_in0
	// controller for andOp_26.andOp_26_in1
	// Insensitive connections
	always @(*) begin
		andOp_26_in0 = valid ? andOp_24_out : andOp_24_out;
		andOp_26_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_28.andOp_28_in0
	// controller for andOp_28.andOp_28_in1
	// Insensitive connections
	always @(*) begin
		andOp_28_in0 = valid ? andOp_24_out : andOp_24_out;
		andOp_28_in1 = valid ? notOp_27_out : notOp_27_out;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? bb_7_active_out_data : bb_7_active_out_data;
		andOp_29_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_30.andOp_30_in0
	// controller for andOp_30.andOp_30_in1
	// Insensitive connections
	always @(*) begin
		andOp_30_in0 = valid ? andOp_29_out : andOp_29_out;
		andOp_30_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_32.andOp_32_in0
	// controller for andOp_32.andOp_32_in1
	// Insensitive connections
	always @(*) begin
		andOp_32_in0 = valid ? bb_8_active_out_data : bb_8_active_out_data;
		andOp_32_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	always @(*) begin
		andOp_33_in0 = valid ? andOp_32_out : andOp_32_out;
		andOp_33_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? bb_9_active_out_data : bb_9_active_out_data;
		andOp_35_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	always @(*) begin
		andOp_36_in0 = valid ? andOp_35_out : andOp_35_out;
		andOp_36_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	always @(*) begin
		andOp_38_in0 = valid ? andOp_36_out : andOp_36_out;
		andOp_38_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? andOp_36_out : andOp_36_out;
		andOp_40_in1 = valid ? notOp_39_out : notOp_39_out;
	end
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	always @(*) begin
		andOp_41_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_41_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? andOp_41_out : andOp_41_out;
		andOp_42_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_5.andOp_5_in0
	// controller for andOp_5.andOp_5_in1
	// Insensitive connections
	always @(*) begin
		andOp_5_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_5_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? andOp_5_out : andOp_5_out;
		andOp_6_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	always @(*) begin
		andOp_64_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_64_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? bb_10_active_out_data : bb_10_active_out_data;
		andOp_65_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? bb_4_active_out_data : bb_4_active_out_data;
		andOp_66_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	always @(*) begin
		andOp_67_in0 = valid ? bb_2_active_out_data : bb_2_active_out_data;
		andOp_67_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	always @(*) begin
		andOp_71_in0 = valid ? notOp_70_out : notOp_70_out;
		andOp_71_in1 = valid ? andOp_17_out : andOp_17_out;
	end
	// controller for andOp_74.andOp_74_in0
	// controller for andOp_74.andOp_74_in1
	// Insensitive connections
	always @(*) begin
		andOp_74_in0 = valid ? notOp_73_out : notOp_73_out;
		andOp_74_in1 = valid ? andOp_30_out : andOp_30_out;
	end
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	always @(*) begin
		andOp_77_in0 = valid ? notOp_76_out : notOp_76_out;
		andOp_77_in1 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? bb_1_active_out_data : bb_1_active_out_data;
		andOp_8_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	always @(*) begin
		andOp_80_in0 = valid ? notOp_79_out : notOp_79_out;
		andOp_80_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? notOp_82_out : notOp_82_out;
		andOp_83_in1 = valid ? andOp_9_out : andOp_9_out;
	end
	// controller for andOp_86.andOp_86_in0
	// controller for andOp_86.andOp_86_in1
	// Insensitive connections
	always @(*) begin
		andOp_86_in0 = valid ? notOp_85_out : notOp_85_out;
		andOp_86_in1 = valid ? andOp_21_out : andOp_21_out;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? notOp_88_out : notOp_88_out;
		andOp_89_in1 = valid ? andOp_26_out : andOp_26_out;
	end
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	always @(*) begin
		andOp_9_in0 = valid ? andOp_8_out : andOp_8_out;
		andOp_9_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_92.andOp_92_in0
	// controller for andOp_92.andOp_92_in1
	// Insensitive connections
	always @(*) begin
		andOp_92_in0 = valid ? notOp_91_out : notOp_91_out;
		andOp_92_in1 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	always @(*) begin
		andOp_95_in0 = valid ? notOp_94_out : notOp_94_out;
		andOp_95_in1 = valid ? andOp_33_out : andOp_33_out;
	end
	// controller for andOp_97.andOp_97_in0
	// controller for andOp_97.andOp_97_in1
	// Insensitive connections
	always @(*) begin
		andOp_97_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_97_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_98.andOp_98_in0
	// controller for andOp_98.andOp_98_in1
	// Insensitive connections
	always @(*) begin
		andOp_98_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_98_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_99.andOp_99_in0
	// controller for andOp_99.andOp_99_in1
	// Insensitive connections
	always @(*) begin
		andOp_99_in0 = valid ? bb_0_active_out_data : bb_0_active_out_data;
		andOp_99_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_44_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_0_predecessor.bb_0_predecessor_in_data
	always @(*) begin
		if (eq_68_out) begin 
			bb_0_predecessor_in_data = last_BB_reg;
		end else begin
			bb_0_predecessor_in_data = 0;
		end
	end
	// controller for bb_10_active.bb_10_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_data = eq_63_out;
		end else begin
			bb_10_active_in_data = 0;
		end
	end
	// controller for bb_10_predecessor.bb_10_predecessor_in_data
	always @(*) begin
		if (eq_96_out) begin 
			bb_10_predecessor_in_data = last_BB_reg;
		end else begin
			bb_10_predecessor_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = orOp_46_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_1_predecessor.bb_1_predecessor_in_data
	always @(*) begin
		if (andOp_71_out) begin 
			bb_1_predecessor_in_data = 32'd4;
		end else if (eq_69_out) begin 
			bb_1_predecessor_in_data = last_BB_reg;
		end else begin
			bb_1_predecessor_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = orOp_48_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for bb_2_predecessor.bb_2_predecessor_in_data
	always @(*) begin
		if (andOp_74_out) begin 
			bb_2_predecessor_in_data = 32'd7;
		end else if (eq_72_out) begin 
			bb_2_predecessor_in_data = last_BB_reg;
		end else begin
			bb_2_predecessor_in_data = 0;
		end
	end
	// controller for bb_3_active.bb_3_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_data = orOp_50_out;
		end else begin
			bb_3_active_in_data = 0;
		end
	end
	// controller for bb_3_predecessor.bb_3_predecessor_in_data
	always @(*) begin
		if (andOp_77_out) begin 
			bb_3_predecessor_in_data = 32'd0;
		end else if (eq_75_out) begin 
			bb_3_predecessor_in_data = last_BB_reg;
		end else begin
			bb_3_predecessor_in_data = 0;
		end
	end
	// controller for bb_4_active.bb_4_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_data = orOp_52_out;
		end else begin
			bb_4_active_in_data = 0;
		end
	end
	// controller for bb_4_predecessor.bb_4_predecessor_in_data
	always @(*) begin
		if (andOp_80_out) begin 
			bb_4_predecessor_in_data = 32'd10;
		end else if (eq_78_out) begin 
			bb_4_predecessor_in_data = last_BB_reg;
		end else begin
			bb_4_predecessor_in_data = 0;
		end
	end
	// controller for bb_5_active.bb_5_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_data = orOp_54_out;
		end else begin
			bb_5_active_in_data = 0;
		end
	end
	// controller for bb_5_predecessor.bb_5_predecessor_in_data
	always @(*) begin
		if (andOp_83_out) begin 
			bb_5_predecessor_in_data = 32'd1;
		end else if (eq_81_out) begin 
			bb_5_predecessor_in_data = last_BB_reg;
		end else begin
			bb_5_predecessor_in_data = 0;
		end
	end
	// controller for bb_6_active.bb_6_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_data = orOp_56_out;
		end else begin
			bb_6_active_in_data = 0;
		end
	end
	// controller for bb_6_predecessor.bb_6_predecessor_in_data
	always @(*) begin
		if (andOp_86_out) begin 
			bb_6_predecessor_in_data = 32'd5;
		end else if (eq_84_out) begin 
			bb_6_predecessor_in_data = last_BB_reg;
		end else begin
			bb_6_predecessor_in_data = 0;
		end
	end
	// controller for bb_7_active.bb_7_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_data = orOp_58_out;
		end else begin
			bb_7_active_in_data = 0;
		end
	end
	// controller for bb_7_predecessor.bb_7_predecessor_in_data
	always @(*) begin
		if (andOp_89_out) begin 
			bb_7_predecessor_in_data = 32'd6;
		end else if (eq_87_out) begin 
			bb_7_predecessor_in_data = last_BB_reg;
		end else begin
			bb_7_predecessor_in_data = 0;
		end
	end
	// controller for bb_8_active.bb_8_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_8_active_in_data = orOp_60_out;
		end else begin
			bb_8_active_in_data = 0;
		end
	end
	// controller for bb_8_predecessor.bb_8_predecessor_in_data
	always @(*) begin
		if (andOp_92_out) begin 
			bb_8_predecessor_in_data = 32'd3;
		end else if (eq_90_out) begin 
			bb_8_predecessor_in_data = last_BB_reg;
		end else begin
			bb_8_predecessor_in_data = 0;
		end
	end
	// controller for bb_9_active.bb_9_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_data = orOp_62_out;
		end else begin
			bb_9_active_in_data = 0;
		end
	end
	// controller for bb_9_predecessor.bb_9_predecessor_in_data
	always @(*) begin
		if (andOp_95_out) begin 
			bb_9_predecessor_in_data = 32'd8;
		end else if (eq_93_out) begin 
			bb_9_predecessor_in_data = last_BB_reg;
		end else begin
			bb_9_predecessor_in_data = 0;
		end
	end
	// controller for br_0_happened.br_0_happened_in_data
	always @(*) begin
		if (andOp_6_out) begin 
			br_0_happened_in_data = 1'd1;
		end else if (notOp_7_out) begin 
			br_0_happened_in_data = 1'd0;
		end else begin
			br_0_happened_in_data = 0;
		end
	end
	// controller for br_10_happened.br_10_happened_in_data
	always @(*) begin
		if (andOp_42_out) begin 
			br_10_happened_in_data = 1'd1;
		end else if (notOp_43_out) begin 
			br_10_happened_in_data = 1'd0;
		end else begin
			br_10_happened_in_data = 0;
		end
	end
	// controller for br_1_happened.br_1_happened_in_data
	always @(*) begin
		if (andOp_9_out) begin 
			br_1_happened_in_data = 1'd1;
		end else if (notOp_10_out) begin 
			br_1_happened_in_data = 1'd0;
		end else begin
			br_1_happened_in_data = 0;
		end
	end
	// controller for br_3_happened.br_3_happened_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_3_happened_in_data = 1'd1;
		end else if (notOp_13_out) begin 
			br_3_happened_in_data = 1'd0;
		end else begin
			br_3_happened_in_data = 0;
		end
	end
	// controller for br_4_happened.br_4_happened_in_data
	always @(*) begin
		if (andOp_15_out) begin 
			br_4_happened_in_data = 1'd1;
		end else if (notOp_16_out) begin 
			br_4_happened_in_data = 1'd0;
		end else begin
			br_4_happened_in_data = 0;
		end
	end
	// controller for br_5_happened.br_5_happened_in_data
	always @(*) begin
		if (andOp_21_out) begin 
			br_5_happened_in_data = 1'd1;
		end else if (notOp_22_out) begin 
			br_5_happened_in_data = 1'd0;
		end else begin
			br_5_happened_in_data = 0;
		end
	end
	// controller for br_6_happened.br_6_happened_in_data
	always @(*) begin
		if (andOp_24_out) begin 
			br_6_happened_in_data = 1'd1;
		end else if (notOp_25_out) begin 
			br_6_happened_in_data = 1'd0;
		end else begin
			br_6_happened_in_data = 0;
		end
	end
	// controller for br_7_happened.br_7_happened_in_data
	always @(*) begin
		if (andOp_30_out) begin 
			br_7_happened_in_data = 1'd1;
		end else if (notOp_31_out) begin 
			br_7_happened_in_data = 1'd0;
		end else begin
			br_7_happened_in_data = 0;
		end
	end
	// controller for br_8_happened.br_8_happened_in_data
	always @(*) begin
		if (andOp_33_out) begin 
			br_8_happened_in_data = 1'd1;
		end else if (notOp_34_out) begin 
			br_8_happened_in_data = 1'd0;
		end else begin
			br_8_happened_in_data = 0;
		end
	end
	// controller for br_9_happened.br_9_happened_in_data
	always @(*) begin
		if (andOp_36_out) begin 
			br_9_happened_in_data = 1'd1;
		end else if (notOp_37_out) begin 
			br_9_happened_in_data = 1'd0;
		end else begin
			br_9_happened_in_data = 0;
		end
	end
	// controller for concat_108.concat_108_in0
	// controller for concat_108.concat_108_in1
	// Insensitive connections
	always @(*) begin
		concat_108_in0 = valid ? add_tmp_5 : add_tmp_5;
		concat_108_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_109.concat_109_in0
	// controller for concat_109.concat_109_in1
	// Insensitive connections
	always @(*) begin
		concat_109_in0 = valid ? 32'd4 : 32'd4;
		concat_109_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd0 : 32'd0;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	always @(*) begin
		eq_1_in0 = valid ? 32'd1 : 32'd1;
		eq_1_in1 = valid ? global_state : global_state;
	end
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	always @(*) begin
		eq_112_in0 = valid ? 32'd10 : 32'd10;
		eq_112_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	always @(*) begin
		eq_2_in0 = valid ? 32'd2 : 32'd2;
		eq_2_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd3 : 32'd3;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd4 : 32'd4;
		eq_4_in1 = valid ? global_state : global_state;
	end
	// controller for eq_44.eq_44_in0
	// controller for eq_44.eq_44_in1
	// Insensitive connections
	always @(*) begin
		eq_44_in0 = valid ? 32'd0 : 32'd0;
		eq_44_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_45.eq_45_in0
	// controller for eq_45.eq_45_in1
	// Insensitive connections
	always @(*) begin
		eq_45_in0 = valid ? 32'd1 : 32'd1;
		eq_45_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_47.eq_47_in0
	// controller for eq_47.eq_47_in1
	// Insensitive connections
	always @(*) begin
		eq_47_in0 = valid ? 32'd2 : 32'd2;
		eq_47_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_49.eq_49_in0
	// controller for eq_49.eq_49_in1
	// Insensitive connections
	always @(*) begin
		eq_49_in0 = valid ? 32'd3 : 32'd3;
		eq_49_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_51.eq_51_in0
	// controller for eq_51.eq_51_in1
	// Insensitive connections
	always @(*) begin
		eq_51_in0 = valid ? 32'd4 : 32'd4;
		eq_51_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_53.eq_53_in0
	// controller for eq_53.eq_53_in1
	// Insensitive connections
	always @(*) begin
		eq_53_in0 = valid ? 32'd5 : 32'd5;
		eq_53_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd6 : 32'd6;
		eq_55_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_57.eq_57_in0
	// controller for eq_57.eq_57_in1
	// Insensitive connections
	always @(*) begin
		eq_57_in0 = valid ? 32'd7 : 32'd7;
		eq_57_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_59.eq_59_in0
	// controller for eq_59.eq_59_in1
	// Insensitive connections
	always @(*) begin
		eq_59_in0 = valid ? 32'd8 : 32'd8;
		eq_59_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_61.eq_61_in0
	// controller for eq_61.eq_61_in1
	// Insensitive connections
	always @(*) begin
		eq_61_in0 = valid ? 32'd9 : 32'd9;
		eq_61_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_63.eq_63_in0
	// controller for eq_63.eq_63_in1
	// Insensitive connections
	always @(*) begin
		eq_63_in0 = valid ? 32'd10 : 32'd10;
		eq_63_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd0 : 32'd0;
		eq_68_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_69.eq_69_in0
	// controller for eq_69.eq_69_in1
	// Insensitive connections
	always @(*) begin
		eq_69_in0 = valid ? 32'd1 : 32'd1;
		eq_69_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	always @(*) begin
		eq_72_in0 = valid ? 32'd2 : 32'd2;
		eq_72_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	always @(*) begin
		eq_75_in0 = valid ? 32'd3 : 32'd3;
		eq_75_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd4 : 32'd4;
		eq_78_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_81.eq_81_in0
	// controller for eq_81.eq_81_in1
	// Insensitive connections
	always @(*) begin
		eq_81_in0 = valid ? 32'd5 : 32'd5;
		eq_81_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	always @(*) begin
		eq_84_in0 = valid ? 32'd6 : 32'd6;
		eq_84_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	always @(*) begin
		eq_87_in0 = valid ? 32'd7 : 32'd7;
		eq_87_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd8 : 32'd8;
		eq_90_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_93.eq_93_in0
	// controller for eq_93.eq_93_in1
	// Insensitive connections
	always @(*) begin
		eq_93_in0 = valid ? 32'd9 : 32'd9;
		eq_93_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_96.eq_96_in0
	// controller for eq_96.eq_96_in1
	// Insensitive connections
	always @(*) begin
		eq_96_in0 = valid ? 32'd10 : 32'd10;
		eq_96_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for icmp_17.cmp_in0_icmp_17
	// controller for icmp_17.cmp_in1_icmp_17
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_17 = valid ? add_out_add_16 : add_out_add_16;
		cmp_in1_icmp_17 = valid ? 32'd4 : 32'd4;
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if (andOp_105_out) begin 
			in_read_valid_reg = -(1'd1);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_10.notOp_10_in0
	// Insensitive connections
	always @(*) begin
		notOp_10_in0 = valid ? andOp_9_out : andOp_9_out;
	end
	// controller for notOp_126.notOp_126_in0
	// Insensitive connections
	always @(*) begin
		notOp_126_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	always @(*) begin
		notOp_13_in0 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for notOp_134.notOp_134_in0
	// Insensitive connections
	always @(*) begin
		notOp_134_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for notOp_138.notOp_138_in0
	// Insensitive connections
	always @(*) begin
		notOp_138_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for notOp_16.notOp_16_in0
	// Insensitive connections
	always @(*) begin
		notOp_16_in0 = valid ? andOp_15_out : andOp_15_out;
	end
	// controller for notOp_18.notOp_18_in0
	// Insensitive connections
	always @(*) begin
		notOp_18_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for notOp_22.notOp_22_in0
	// Insensitive connections
	always @(*) begin
		notOp_22_in0 = valid ? andOp_21_out : andOp_21_out;
	end
	// controller for notOp_25.notOp_25_in0
	// Insensitive connections
	always @(*) begin
		notOp_25_in0 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for notOp_27.notOp_27_in0
	// Insensitive connections
	always @(*) begin
		notOp_27_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for notOp_31.notOp_31_in0
	// Insensitive connections
	always @(*) begin
		notOp_31_in0 = valid ? andOp_30_out : andOp_30_out;
	end
	// controller for notOp_34.notOp_34_in0
	// Insensitive connections
	always @(*) begin
		notOp_34_in0 = valid ? andOp_33_out : andOp_33_out;
	end
	// controller for notOp_37.notOp_37_in0
	// Insensitive connections
	always @(*) begin
		notOp_37_in0 = valid ? andOp_36_out : andOp_36_out;
	end
	// controller for notOp_39.notOp_39_in0
	// Insensitive connections
	always @(*) begin
		notOp_39_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_43.notOp_43_in0
	// Insensitive connections
	always @(*) begin
		notOp_43_in0 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	always @(*) begin
		notOp_7_in0 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for notOp_70.notOp_70_in0
	// Insensitive connections
	always @(*) begin
		notOp_70_in0 = valid ? eq_69_out : eq_69_out;
	end
	// controller for notOp_73.notOp_73_in0
	// Insensitive connections
	always @(*) begin
		notOp_73_in0 = valid ? eq_72_out : eq_72_out;
	end
	// controller for notOp_76.notOp_76_in0
	// Insensitive connections
	always @(*) begin
		notOp_76_in0 = valid ? eq_75_out : eq_75_out;
	end
	// controller for notOp_79.notOp_79_in0
	// Insensitive connections
	always @(*) begin
		notOp_79_in0 = valid ? eq_78_out : eq_78_out;
	end
	// controller for notOp_82.notOp_82_in0
	// Insensitive connections
	always @(*) begin
		notOp_82_in0 = valid ? eq_81_out : eq_81_out;
	end
	// controller for notOp_85.notOp_85_in0
	// Insensitive connections
	always @(*) begin
		notOp_85_in0 = valid ? eq_84_out : eq_84_out;
	end
	// controller for notOp_88.notOp_88_in0
	// Insensitive connections
	always @(*) begin
		notOp_88_in0 = valid ? eq_87_out : eq_87_out;
	end
	// controller for notOp_91.notOp_91_in0
	// Insensitive connections
	always @(*) begin
		notOp_91_in0 = valid ? eq_90_out : eq_90_out;
	end
	// controller for notOp_94.notOp_94_in0
	// Insensitive connections
	always @(*) begin
		notOp_94_in0 = valid ? eq_93_out : eq_93_out;
	end
	// controller for orOp_46.orOp_46_in0
	// controller for orOp_46.orOp_46_in1
	// Insensitive connections
	always @(*) begin
		orOp_46_in0 = valid ? eq_45_out : eq_45_out;
		orOp_46_in1 = valid ? andOp_17_out : andOp_17_out;
	end
	// controller for orOp_48.orOp_48_in0
	// controller for orOp_48.orOp_48_in1
	// Insensitive connections
	always @(*) begin
		orOp_48_in0 = valid ? eq_47_out : eq_47_out;
		orOp_48_in1 = valid ? andOp_30_out : andOp_30_out;
	end
	// controller for orOp_50.orOp_50_in0
	// controller for orOp_50.orOp_50_in1
	// Insensitive connections
	always @(*) begin
		orOp_50_in0 = valid ? eq_49_out : eq_49_out;
		orOp_50_in1 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for orOp_52.orOp_52_in0
	// controller for orOp_52.orOp_52_in1
	// Insensitive connections
	always @(*) begin
		orOp_52_in0 = valid ? eq_51_out : eq_51_out;
		orOp_52_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for orOp_54.orOp_54_in0
	// controller for orOp_54.orOp_54_in1
	// Insensitive connections
	always @(*) begin
		orOp_54_in0 = valid ? eq_53_out : eq_53_out;
		orOp_54_in1 = valid ? andOp_9_out : andOp_9_out;
	end
	// controller for orOp_56.orOp_56_in0
	// controller for orOp_56.orOp_56_in1
	// Insensitive connections
	always @(*) begin
		orOp_56_in0 = valid ? eq_55_out : eq_55_out;
		orOp_56_in1 = valid ? andOp_21_out : andOp_21_out;
	end
	// controller for orOp_58.orOp_58_in0
	// controller for orOp_58.orOp_58_in1
	// Insensitive connections
	always @(*) begin
		orOp_58_in0 = valid ? eq_57_out : eq_57_out;
		orOp_58_in1 = valid ? andOp_26_out : andOp_26_out;
	end
	// controller for orOp_60.orOp_60_in0
	// controller for orOp_60.orOp_60_in1
	// Insensitive connections
	always @(*) begin
		orOp_60_in0 = valid ? eq_59_out : eq_59_out;
		orOp_60_in1 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for orOp_62.orOp_62_in0
	// controller for orOp_62.orOp_62_in1
	// Insensitive connections
	always @(*) begin
		orOp_62_in0 = valid ? eq_61_out : eq_61_out;
		orOp_62_in1 = valid ? andOp_33_out : andOp_33_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_117_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_115_out) begin 
			out_write_valid_reg = -(1'd1);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// controller for phi_8.phi_in_phi_8
	// controller for phi_8.phi_last_block_phi_8
	// controller for phi_8.phi_s_phi_8
	// Insensitive connections
	always @(*) begin
		phi_in_phi_8 = valid ? concat_108_out : concat_108_out;
		phi_last_block_phi_8 = valid ? bb_3_predecessor_out_data : bb_3_predecessor_out_data;
		phi_s_phi_8 = valid ? concat_109_out : concat_109_out;
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_101_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else if (andOp_103_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_100_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else if (andOp_102_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_100_out) begin 
			wdata_ram_0_reg = 32'd0;
		end else if (andOp_102_out) begin 
			wdata_ram_0_reg = add_out_add_14;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_100_out) begin 
			wen_ram_0_reg = 1'd1;
		end else if (andOp_102_out) begin 
			wen_ram_0_reg = 1'd1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_22.valid_reg
	always @(*) begin
		if (andOp_119_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_111.tmp_output_111_in_data
	always @(*) begin
		if (eq_112_out) begin 
			tmp_output_111_in_data = in_out_data;
		end else begin
			tmp_output_111_in_data = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_5 <= 0;
		end else begin
			if (andOp_145_out) begin
				add_tmp_5 <= add_out_add_16;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			call_tmp_2 <= 0;
		end else begin
			if (andOp_144_out) begin
				call_tmp_2 <= in_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
			if (andOp_19_out) begin
				global_next_block <= 32'd3;
			end
			if (andOp_28_out) begin
				global_next_block <= 32'd6;
			end
			if (andOp_38_out) begin
				global_next_block <= 32'd10;
			end
			if (andOp_40_out) begin
				global_next_block <= 32'd9;
			end
			if (andOp_64_out) begin
				global_next_block <= 32'd0;
			end
			if (andOp_65_out) begin
				global_next_block <= 32'd10;
			end
			if (andOp_66_out) begin
				global_next_block <= 32'd4;
			end
			if (andOp_67_out) begin
				global_next_block <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_121_out) begin
				global_state <= 32'd1;
			end
			if (andOp_124_out) begin
				global_state <= 32'd2;
			end
			if (andOp_128_out) begin
				global_state <= 32'd1;
			end
			if (andOp_130_out) begin
				global_state <= 32'd3;
			end
			if (andOp_132_out) begin
				global_state <= 32'd4;
			end
			if (andOp_136_out) begin
				global_state <= 32'd1;
			end
			if (andOp_140_out) begin
				global_state <= 32'd4;
			end
			if (andOp_142_out) begin
				global_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_6 <= 0;
		end else begin
			if (andOp_146_out) begin
				icmp_tmp_6 <= cmp_out_icmp_17;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (andOp_122_out) begin
				last_BB_reg <= 32'd9;
			end
			if (andOp_125_out) begin
				last_BB_reg <= 32'd9;
			end
			if (andOp_133_out) begin
				last_BB_reg <= 32'd4;
			end
			if (andOp_137_out) begin
				last_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			phi_tmp_1 <= 0;
		end else begin
			if (andOp_143_out) begin
				phi_tmp_1 <= phi_out_phi_8;
			end
		end
	end

endmodule

