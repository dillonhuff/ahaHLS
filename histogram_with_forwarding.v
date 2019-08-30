module histogram_with_forwarding(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [8:0] arg_0_debug_addr, input [31:0] arg_0_debug_data, output [8:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [8:0] arg_0_raddr_0, input [31:0] arg_0_rdata_0, output [0:0] arg_0_rst, output [8:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, output [7:0] arg_1_debug_addr, input [31:0] arg_1_debug_data, output [7:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [7:0] arg_1_raddr_0, input [31:0] arg_1_rdata_0, output [0:0] arg_1_rst, output [7:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0);

	reg [0:0] valid_reg;
	reg [8:0] arg_0_debug_addr_reg;
	reg [8:0] arg_0_debug_write_addr_reg;
	reg [31:0] arg_0_debug_write_data_reg;
	reg [0:0] arg_0_debug_write_en_reg;
	reg [8:0] arg_0_raddr_0_reg;
	reg [0:0] arg_0_rst_reg;
	reg [8:0] arg_0_waddr_0_reg;
	reg [31:0] arg_0_wdata_0_reg;
	reg [0:0] arg_0_wen_0_reg;
	reg [7:0] arg_1_debug_addr_reg;
	reg [7:0] arg_1_debug_write_addr_reg;
	reg [31:0] arg_1_debug_write_data_reg;
	reg [0:0] arg_1_debug_write_en_reg;
	reg [7:0] arg_1_raddr_0_reg;
	reg [0:0] arg_1_rst_reg;
	reg [7:0] arg_1_waddr_0_reg;
	reg [31:0] arg_1_wdata_0_reg;
	reg [0:0] arg_1_wen_0_reg;

	assign valid = valid_reg;
	assign arg_0_debug_addr = arg_0_debug_addr_reg;
	assign arg_0_debug_write_addr = arg_0_debug_write_addr_reg;
	assign arg_0_debug_write_data = arg_0_debug_write_data_reg;
	assign arg_0_debug_write_en = arg_0_debug_write_en_reg;
	assign arg_0_raddr_0 = arg_0_raddr_0_reg;
	assign arg_0_rst = arg_0_rst_reg;
	assign arg_0_waddr_0 = arg_0_waddr_0_reg;
	assign arg_0_wdata_0 = arg_0_wdata_0_reg;
	assign arg_0_wen_0 = arg_0_wen_0_reg;
	assign arg_1_debug_addr = arg_1_debug_addr_reg;
	assign arg_1_debug_write_addr = arg_1_debug_write_addr_reg;
	assign arg_1_debug_write_data = arg_1_debug_write_data_reg;
	assign arg_1_debug_write_en = arg_1_debug_write_en_reg;
	assign arg_1_raddr_0 = arg_1_raddr_0_reg;
	assign arg_1_rst = arg_1_rst_reg;
	assign arg_1_waddr_0 = arg_1_waddr_0_reg;
	assign arg_1_wdata_0 = arg_1_wdata_0_reg;
	assign arg_1_wen_0 = arg_1_wen_0_reg;

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

	wire [31:0] add_add2_in0;
	wire [31:0] add_add2_in1;
	wire [31:0] add_add2_out;
	add #(.WIDTH(32)) add_add2(.in0(add_add2_in0), .in1(add_add2_in1), .out(add_add2_out));

	wire [31:0] add_add9_in0;
	wire [31:0] add_add9_in1;
	wire [31:0] add_add9_out;
	add #(.WIDTH(32)) add_add9(.in0(add_add9_in0), .in1(add_add9_in1), .out(add_add9_out));

	wire [31:0] icmp_icmp3_in0;
	wire [31:0] icmp_icmp3_in1;
	wire [0:0] icmp_icmp3_out;
	ne #(.WIDTH(32)) icmp_icmp3(.in0(icmp_icmp3_in0), .in1(icmp_icmp3_in1), .out(icmp_icmp3_out));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] bb_1_active_in_state_1_in_data;
	wire [0:0] bb_1_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_1(.in_data(bb_1_active_in_state_1_in_data), .out_data(bb_1_active_in_state_1_out_data));

	reg [31:0] bb_1_predecessor_in_state_1_in_data;
	wire [31:0] bb_1_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_1(.in_data(bb_1_predecessor_in_state_1_in_data), .out_data(bb_1_predecessor_in_state_1_out_data));

	reg [0:0] br_1_happened_in_state_1_in_data;
	wire [0:0] br_1_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_1(.in_data(br_1_happened_in_state_1_in_data), .out_data(br_1_happened_in_state_1_out_data));

	reg [0:0] bb_1_active_in_state_2_in_data;
	wire [0:0] bb_1_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_2(.in_data(bb_1_active_in_state_2_in_data), .out_data(bb_1_active_in_state_2_out_data));

	reg [31:0] bb_1_predecessor_in_state_2_in_data;
	wire [31:0] bb_1_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_2(.in_data(bb_1_predecessor_in_state_2_in_data), .out_data(bb_1_predecessor_in_state_2_out_data));

	reg [0:0] br_1_happened_in_state_2_in_data;
	wire [0:0] br_1_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_2(.in_data(br_1_happened_in_state_2_in_data), .out_data(br_1_happened_in_state_2_out_data));

	reg [0:0] bb_1_active_in_state_3_in_data;
	wire [0:0] bb_1_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_3(.in_data(bb_1_active_in_state_3_in_data), .out_data(bb_1_active_in_state_3_out_data));

	reg [31:0] bb_1_predecessor_in_state_3_in_data;
	wire [31:0] bb_1_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_3(.in_data(bb_1_predecessor_in_state_3_in_data), .out_data(bb_1_predecessor_in_state_3_out_data));

	reg [0:0] br_1_happened_in_state_3_in_data;
	wire [0:0] br_1_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_3(.in_data(br_1_happened_in_state_3_in_data), .out_data(br_1_happened_in_state_3_out_data));

	reg [0:0] bb_1_active_in_state_4_in_data;
	wire [0:0] bb_1_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_4(.in_data(bb_1_active_in_state_4_in_data), .out_data(bb_1_active_in_state_4_out_data));

	reg [31:0] bb_1_predecessor_in_state_4_in_data;
	wire [31:0] bb_1_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_4(.in_data(bb_1_predecessor_in_state_4_in_data), .out_data(bb_1_predecessor_in_state_4_out_data));

	reg [0:0] br_1_happened_in_state_4_in_data;
	wire [0:0] br_1_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_4(.in_data(br_1_happened_in_state_4_in_data), .out_data(br_1_happened_in_state_4_out_data));

	reg [0:0] bb_2_active_in_state_5_in_data;
	wire [0:0] bb_2_active_in_state_5_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_5(.in_data(bb_2_active_in_state_5_in_data), .out_data(bb_2_active_in_state_5_out_data));

	reg [31:0] bb_2_predecessor_in_state_5_in_data;
	wire [31:0] bb_2_predecessor_in_state_5_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_5(.in_data(bb_2_predecessor_in_state_5_in_data), .out_data(bb_2_predecessor_in_state_5_out_data));

	reg [31:0] data_in_0_1_in_data;
	wire [31:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [31:0] data_in_1_3_in_data;
	wire [31:0] data_in_1_3_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_3(.in_data(data_in_1_3_in_data), .out_data(data_in_1_3_out_data));

	reg [7:0] data_in_3_5_in_data;
	wire [7:0] data_in_3_5_out_data;
	hls_wire #(.WIDTH(8)) data_in_3_5(.in_data(data_in_3_5_in_data), .out_data(data_in_3_5_out_data));

	wire [0:0] andOp_6_in0;
	wire [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	wire [0:0] notOp_7_in0;
	wire [0:0] notOp_7_out;
	notOp #(.WIDTH(1)) notOp_7(.in(notOp_7_in0), .out(notOp_7_out));

	wire [0:0] andOp_8_in0;
	wire [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	wire [0:0] notOp_9_in0;
	wire [0:0] notOp_9_out;
	notOp #(.WIDTH(1)) notOp_9(.in(notOp_9_in0), .out(notOp_9_out));

	wire [0:0] andOp_10_in0;
	wire [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	wire [0:0] notOp_11_in0;
	wire [0:0] notOp_11_out;
	notOp #(.WIDTH(1)) notOp_11(.in(notOp_11_in0), .out(notOp_11_out));

	wire [0:0] andOp_12_in0;
	wire [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	wire [0:0] andOp_13_in0;
	wire [0:0] andOp_13_in1;
	wire [0:0] andOp_13_out;
	andOp #(.WIDTH(1)) andOp_13(.in0(andOp_13_in0), .in1(andOp_13_in1), .out(andOp_13_out));

	wire [0:0] notOp_14_in0;
	wire [0:0] notOp_14_out;
	notOp #(.WIDTH(1)) notOp_14(.in(notOp_14_in0), .out(notOp_14_out));

	wire [0:0] andOp_15_in0;
	wire [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

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

	wire [31:0] eq_28_in0;
	wire [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

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

	wire [31:0] eq_34_in0;
	wire [31:0] eq_34_in1;
	wire [0:0] eq_34_out;
	eq #(.WIDTH(32)) eq_34(.in0(eq_34_in0), .in1(eq_34_in1), .out(eq_34_out));

	wire [31:0] eq_35_in0;
	wire [31:0] eq_35_in1;
	wire [0:0] eq_35_out;
	eq #(.WIDTH(32)) eq_35(.in0(eq_35_in0), .in1(eq_35_in1), .out(eq_35_out));

	wire [31:0] eq_36_in0;
	wire [31:0] eq_36_in1;
	wire [0:0] eq_36_out;
	eq #(.WIDTH(32)) eq_36(.in0(eq_36_in0), .in1(eq_36_in1), .out(eq_36_out));

	wire [31:0] eq_37_in0;
	wire [31:0] eq_37_in1;
	wire [0:0] eq_37_out;
	eq #(.WIDTH(32)) eq_37(.in0(eq_37_in0), .in1(eq_37_in1), .out(eq_37_out));

	wire [31:0] eq_38_in0;
	wire [31:0] eq_38_in1;
	wire [0:0] eq_38_out;
	eq #(.WIDTH(32)) eq_38(.in0(eq_38_in0), .in1(eq_38_in1), .out(eq_38_out));

	wire [31:0] eq_39_in0;
	wire [31:0] eq_39_in1;
	wire [0:0] eq_39_out;
	eq #(.WIDTH(32)) eq_39(.in0(eq_39_in0), .in1(eq_39_in1), .out(eq_39_out));

	wire [0:0] andOp_40_in0;
	wire [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	wire [31:0] concat_41_in0;
	wire [31:0] concat_41_in1;
	wire [63:0] concat_41_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_41(.in0(concat_41_in0), .in1(concat_41_in1), .out(concat_41_out));

	wire [31:0] concat_42_in0;
	wire [31:0] concat_42_in1;
	wire [63:0] concat_42_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_42(.in0(concat_42_in0), .in1(concat_42_in1), .out(concat_42_out));

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

	wire [31:0] add_55_in0;
	wire [31:0] add_55_in1;
	wire [31:0] add_55_out;
	add #(.WIDTH(32)) add_55(.in0(add_55_in0), .in1(add_55_in1), .out(add_55_out));

	wire [0:0] notOp_56_in0;
	wire [0:0] notOp_56_out;
	notOp #(.WIDTH(1)) notOp_56(.in(notOp_56_in0), .out(notOp_56_out));

	wire [0:0] andOp_57_in0;
	wire [0:0] andOp_57_in1;
	wire [0:0] andOp_57_out;
	andOp #(.WIDTH(1)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

	wire [31:0] eq_58_in0;
	wire [31:0] eq_58_in1;
	wire [0:0] eq_58_out;
	eq #(.WIDTH(32)) eq_58(.in0(eq_58_in0), .in1(eq_58_in1), .out(eq_58_out));

	wire [0:0] andOp_60_in0;
	wire [0:0] andOp_60_in1;
	wire [0:0] andOp_60_out;
	andOp #(.WIDTH(1)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	wire [0:0] notOp_61_in0;
	wire [0:0] notOp_61_out;
	notOp #(.WIDTH(1)) notOp_61(.in(notOp_61_in0), .out(notOp_61_out));

	wire [0:0] andOp_62_in0;
	wire [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	wire [0:0] notOp_63_in0;
	wire [0:0] notOp_63_out;
	notOp #(.WIDTH(1)) notOp_63(.in(notOp_63_in0), .out(notOp_63_out));

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

	wire [0:0] andOp_67_in0;
	wire [0:0] andOp_67_in1;
	wire [0:0] andOp_67_out;
	andOp #(.WIDTH(1)) andOp_67(.in0(andOp_67_in0), .in1(andOp_67_in1), .out(andOp_67_out));

	wire [0:0] andOp_68_in0;
	wire [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	wire [0:0] andOp_69_in0;
	wire [0:0] andOp_69_in1;
	wire [0:0] andOp_69_out;
	andOp #(.WIDTH(1)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	wire [0:0] notOp_70_in0;
	wire [0:0] notOp_70_out;
	notOp #(.WIDTH(1)) notOp_70(.in(notOp_70_in0), .out(notOp_70_out));

	wire [0:0] andOp_71_in0;
	wire [0:0] andOp_71_in1;
	wire [0:0] andOp_71_out;
	andOp #(.WIDTH(1)) andOp_71(.in0(andOp_71_in0), .in1(andOp_71_in1), .out(andOp_71_out));

	wire [0:0] notOp_72_in0;
	wire [0:0] notOp_72_out;
	notOp #(.WIDTH(1)) notOp_72(.in(notOp_72_in0), .out(notOp_72_out));

	wire [0:0] andOp_73_in0;
	wire [0:0] andOp_73_in1;
	wire [0:0] andOp_73_out;
	andOp #(.WIDTH(1)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	wire [0:0] notOp_74_in0;
	wire [0:0] notOp_74_out;
	notOp #(.WIDTH(1)) notOp_74(.in(notOp_74_in0), .out(notOp_74_out));

	wire [0:0] andOp_75_in0;
	wire [0:0] andOp_75_in1;
	wire [0:0] andOp_75_out;
	andOp #(.WIDTH(1)) andOp_75(.in0(andOp_75_in0), .in1(andOp_75_in1), .out(andOp_75_out));

	wire [0:0] andOp_76_in0;
	wire [0:0] andOp_76_in1;
	wire [0:0] andOp_76_out;
	andOp #(.WIDTH(1)) andOp_76(.in0(andOp_76_in0), .in1(andOp_76_in1), .out(andOp_76_out));

	wire [0:0] andOp_77_in0;
	wire [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	wire [0:0] andOp_78_in0;
	wire [0:0] andOp_78_in1;
	wire [0:0] andOp_78_out;
	andOp #(.WIDTH(1)) andOp_78(.in0(andOp_78_in0), .in1(andOp_78_in1), .out(andOp_78_out));

	wire [0:0] andOp_79_in0;
	wire [0:0] andOp_79_in1;
	wire [0:0] andOp_79_out;
	andOp #(.WIDTH(1)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	wire [0:0] andOp_80_in0;
	wire [0:0] andOp_80_in1;
	wire [0:0] andOp_80_out;
	andOp #(.WIDTH(1)) andOp_80(.in0(andOp_80_in0), .in1(andOp_80_in1), .out(andOp_80_out));

	wire [0:0] andOp_81_in0;
	wire [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	wire [0:0] notOp_82_in0;
	wire [0:0] notOp_82_out;
	notOp #(.WIDTH(1)) notOp_82(.in(notOp_82_in0), .out(notOp_82_out));

	wire [0:0] andOp_83_in0;
	wire [0:0] andOp_83_in1;
	wire [0:0] andOp_83_out;
	andOp #(.WIDTH(1)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	wire [0:0] notOp_84_in0;
	wire [0:0] notOp_84_out;
	notOp #(.WIDTH(1)) notOp_84(.in(notOp_84_in0), .out(notOp_84_out));

	wire [0:0] andOp_85_in0;
	wire [0:0] andOp_85_in1;
	wire [0:0] andOp_85_out;
	andOp #(.WIDTH(1)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	wire [0:0] notOp_86_in0;
	wire [0:0] notOp_86_out;
	notOp #(.WIDTH(1)) notOp_86(.in(notOp_86_in0), .out(notOp_86_out));

	wire [0:0] andOp_87_in0;
	wire [0:0] andOp_87_in1;
	wire [0:0] andOp_87_out;
	andOp #(.WIDTH(1)) andOp_87(.in0(andOp_87_in0), .in1(andOp_87_in1), .out(andOp_87_out));

	wire [0:0] notOp_88_in0;
	wire [0:0] notOp_88_out;
	notOp #(.WIDTH(1)) notOp_88(.in(notOp_88_in0), .out(notOp_88_out));

	wire [0:0] andOp_89_in0;
	wire [0:0] andOp_89_in1;
	wire [0:0] andOp_89_out;
	andOp #(.WIDTH(1)) andOp_89(.in0(andOp_89_in0), .in1(andOp_89_in1), .out(andOp_89_out));

	wire [0:0] notOp_90_in0;
	wire [0:0] notOp_90_out;
	notOp #(.WIDTH(1)) notOp_90(.in(notOp_90_in0), .out(notOp_90_out));

	wire [0:0] andOp_91_in0;
	wire [0:0] andOp_91_in1;
	wire [0:0] andOp_91_out;
	andOp #(.WIDTH(1)) andOp_91(.in0(andOp_91_in0), .in1(andOp_91_in1), .out(andOp_91_out));

	wire [0:0] notOp_92_in0;
	wire [0:0] notOp_92_out;
	notOp #(.WIDTH(1)) notOp_92(.in(notOp_92_in0), .out(notOp_92_out));

	wire [0:0] andOp_93_in0;
	wire [0:0] andOp_93_in1;
	wire [0:0] andOp_93_out;
	andOp #(.WIDTH(1)) andOp_93(.in0(andOp_93_in0), .in1(andOp_93_in1), .out(andOp_93_out));

	wire [0:0] notOp_94_in0;
	wire [0:0] notOp_94_out;
	notOp #(.WIDTH(1)) notOp_94(.in(notOp_94_in0), .out(notOp_94_out));

	wire [0:0] andOp_95_in0;
	wire [0:0] andOp_95_in1;
	wire [0:0] andOp_95_out;
	andOp #(.WIDTH(1)) andOp_95(.in0(andOp_95_in0), .in1(andOp_95_in1), .out(andOp_95_out));

	reg [0:0] in_pipeline_0_in_data;
	wire [0:0] in_pipeline_0_out_data;
	hls_wire #(.WIDTH(1)) in_pipeline_0(.in_data(in_pipeline_0_in_data), .out_data(in_pipeline_0_out_data));

	wire [0:0] orOp_96_in0;
	wire [0:0] orOp_96_in1;
	wire [0:0] orOp_96_out;
	orOp #(.WIDTH(1)) orOp_96(.in0(orOp_96_in0), .in1(orOp_96_in1), .out(orOp_96_out));

	wire [0:0] orOp_97_in0;
	wire [0:0] orOp_97_in1;
	wire [0:0] orOp_97_out;
	orOp #(.WIDTH(1)) orOp_97(.in0(orOp_97_in0), .in1(orOp_97_in1), .out(orOp_97_out));

	wire [0:0] orOp_98_in0;
	wire [0:0] orOp_98_in1;
	wire [0:0] orOp_98_out;
	orOp #(.WIDTH(1)) orOp_98(.in0(orOp_98_in0), .in1(orOp_98_in1), .out(orOp_98_out));

	wire [0:0] orOp_99_in0;
	wire [0:0] orOp_99_in1;
	wire [0:0] orOp_99_out;
	orOp #(.WIDTH(1)) orOp_99(.in0(orOp_99_in0), .in1(orOp_99_in1), .out(orOp_99_out));

	wire [31:0] eq_100_in0;
	wire [31:0] eq_100_in1;
	wire [0:0] eq_100_out;
	eq #(.WIDTH(32)) eq_100(.in0(eq_100_in0), .in1(eq_100_in1), .out(eq_100_out));

	wire [31:0] eq_101_in0;
	wire [31:0] eq_101_in1;
	wire [0:0] eq_101_out;
	eq #(.WIDTH(32)) eq_101(.in0(eq_101_in0), .in1(eq_101_in1), .out(eq_101_out));

	wire [31:0] eq_102_in0;
	wire [31:0] eq_102_in1;
	wire [0:0] eq_102_out;
	eq #(.WIDTH(32)) eq_102(.in0(eq_102_in0), .in1(eq_102_in1), .out(eq_102_out));

	wire [0:0] andOp_103_in0;
	wire [0:0] andOp_103_in1;
	wire [0:0] andOp_103_out;
	andOp #(.WIDTH(1)) andOp_103(.in0(andOp_103_in0), .in1(andOp_103_in1), .out(andOp_103_out));

	wire [31:0] eq_104_in0;
	wire [31:0] eq_104_in1;
	wire [0:0] eq_104_out;
	eq #(.WIDTH(32)) eq_104(.in0(eq_104_in0), .in1(eq_104_in1), .out(eq_104_out));

	wire [31:0] eq_105_in0;
	wire [31:0] eq_105_in1;
	wire [0:0] eq_105_out;
	eq #(.WIDTH(32)) eq_105(.in0(eq_105_in0), .in1(eq_105_in1), .out(eq_105_out));

	wire [0:0] andOp_106_in0;
	wire [0:0] andOp_106_in1;
	wire [0:0] andOp_106_out;
	andOp #(.WIDTH(1)) andOp_106(.in0(andOp_106_in0), .in1(andOp_106_in1), .out(andOp_106_out));

	wire [31:0] eq_107_in0;
	wire [31:0] eq_107_in1;
	wire [0:0] eq_107_out;
	eq #(.WIDTH(32)) eq_107(.in0(eq_107_in0), .in1(eq_107_in1), .out(eq_107_out));

	wire [31:0] eq_108_in0;
	wire [31:0] eq_108_in1;
	wire [0:0] eq_108_out;
	eq #(.WIDTH(32)) eq_108(.in0(eq_108_in0), .in1(eq_108_in1), .out(eq_108_out));

	wire [31:0] eq_109_in0;
	wire [31:0] eq_109_in1;
	wire [0:0] eq_109_out;
	eq #(.WIDTH(32)) eq_109(.in0(eq_109_in0), .in1(eq_109_in1), .out(eq_109_out));

	wire [31:0] eq_110_in0;
	wire [31:0] eq_110_in1;
	wire [0:0] eq_110_out;
	eq #(.WIDTH(32)) eq_110(.in0(eq_110_in0), .in1(eq_110_in1), .out(eq_110_out));

	wire [31:0] eq_111_in0;
	wire [31:0] eq_111_in1;
	wire [0:0] eq_111_out;
	eq #(.WIDTH(32)) eq_111(.in0(eq_111_in0), .in1(eq_111_in1), .out(eq_111_out));

	wire [31:0] eq_112_in0;
	wire [31:0] eq_112_in1;
	wire [0:0] eq_112_out;
	eq #(.WIDTH(32)) eq_112(.in0(eq_112_in0), .in1(eq_112_in1), .out(eq_112_out));

	wire [31:0] eq_113_in0;
	wire [31:0] eq_113_in1;
	wire [0:0] eq_113_out;
	eq #(.WIDTH(32)) eq_113(.in0(eq_113_in0), .in1(eq_113_in1), .out(eq_113_out));

	// End Functional Units

	reg [31:0] counter__54;
	reg [31:0] data_store_0_0;
	reg [31:0] data_store_1_2;
	reg [7:0] data_store_2_4;
	reg [0:0] delayed_signal__59;
	reg [31:0] global_state;
	reg [0:0] out_of_pipe_1_5;
	reg [0:0] out_of_pipe_bb_1_5;
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
	reg [31:0] state_4_entry_BB_reg;
	reg [0:0] state_4_is_active;
	reg [31:0] state_4_last_BB_reg;
	reg [31:0] state_4_last_state;
	reg [31:0] state_5_entry_BB_reg;
	reg [0:0] state_5_is_active;
	reg [31:0] state_5_last_BB_reg;
	reg [31:0] state_5_last_state;

	// controller for add_55.add_55_in0
	// controller for add_55.add_55_in1
	// Insensitive connections
	assign add_55_in0 = counter__54;
	assign add_55_in1 = 32'd1;
	// controller for add_add2.add_add2_in0
	// controller for add_add2.add_add2_in1
	// Insensitive connections
	assign add_add2_in0 = phi_phi1_out;
	assign add_add2_in1 = 32'd1;
	// controller for add_add9.add_add9_in0
	// controller for add_add9.add_add9_in1
	// Insensitive connections
	assign add_add9_in0 = arg_1_rdata_0;
	assign add_add9_in1 = 32'd1;
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	assign andOp_10_in0 = andOp_8_out;
	assign andOp_10_in1 = icmp_icmp3_out;
	// controller for andOp_103.andOp_103_in0
	// controller for andOp_103.andOp_103_in1
	// Insensitive connections
	assign andOp_103_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_103_in1 = state_1_is_active;
	// controller for andOp_106.andOp_106_in0
	// controller for andOp_106.andOp_106_in1
	// Insensitive connections
	assign andOp_106_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_106_in1 = state_2_is_active;
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	assign andOp_12_in0 = andOp_8_out;
	assign andOp_12_in1 = notOp_11_out;
	// controller for andOp_13.andOp_13_in0
	// controller for andOp_13.andOp_13_in1
	// Insensitive connections
	assign andOp_13_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_13_in1 = state_1_is_active;
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	assign andOp_15_in0 = andOp_13_out;
	assign andOp_15_in1 = icmp_icmp3_out;
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	assign andOp_17_in0 = andOp_13_out;
	assign andOp_17_in1 = notOp_16_out;
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	assign andOp_18_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_18_in1 = state_1_is_active;
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	assign andOp_20_in0 = andOp_18_out;
	assign andOp_20_in1 = icmp_icmp3_out;
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	assign andOp_22_in0 = andOp_18_out;
	assign andOp_22_in1 = notOp_21_out;
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	assign andOp_23_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_23_in1 = state_1_is_active;
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	assign andOp_25_in0 = andOp_23_out;
	assign andOp_25_in1 = icmp_icmp3_out;
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	assign andOp_27_in0 = andOp_23_out;
	assign andOp_27_in1 = notOp_26_out;
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	assign andOp_40_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_40_in1 = state_1_is_active;
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	assign andOp_43_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_43_in1 = state_1_is_active;
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	assign andOp_44_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_44_in1 = state_1_is_active;
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	assign andOp_45_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_45_in1 = state_1_is_active;
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	assign andOp_46_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_46_in1 = state_2_is_active;
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	assign andOp_47_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_47_in1 = state_2_is_active;
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
	assign andOp_53_in0 = bb_2_active_in_state_5_out_data;
	assign andOp_53_in1 = state_5_is_active;
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	assign andOp_57_in0 = notOp_56_out;
	assign andOp_57_in1 = 1'd1;
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	assign andOp_6_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_6_in1 = state_0_is_active;
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	assign andOp_60_in0 = delayed_signal__59;
	assign andOp_60_in1 = eq_58_out;
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	assign andOp_62_in0 = 1'd1;
	assign andOp_62_in1 = notOp_61_out;
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	assign andOp_64_in0 = andOp_62_out;
	assign andOp_64_in1 = notOp_63_out;
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	assign andOp_66_in0 = andOp_64_out;
	assign andOp_66_in1 = notOp_65_out;
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	assign andOp_67_in0 = in_pipeline_0_out_data;
	assign andOp_67_in1 = andOp_66_out;
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	assign andOp_68_in0 = andOp_67_out;
	assign andOp_68_in1 = out_of_pipe_1_5;
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	assign andOp_69_in0 = andOp_67_out;
	assign andOp_69_in1 = out_of_pipe_1_5;
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	assign andOp_71_in0 = 1'd1;
	assign andOp_71_in1 = notOp_70_out;
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	assign andOp_73_in0 = andOp_71_out;
	assign andOp_73_in1 = notOp_72_out;
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	assign andOp_75_in0 = andOp_73_out;
	assign andOp_75_in1 = notOp_74_out;
	// controller for andOp_76.andOp_76_in0
	// controller for andOp_76.andOp_76_in1
	// Insensitive connections
	assign andOp_76_in0 = in_pipeline_0_out_data;
	assign andOp_76_in1 = andOp_75_out;
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	assign andOp_77_in0 = andOp_76_out;
	assign andOp_77_in1 = out_of_pipe_bb_1_5;
	// controller for andOp_78.andOp_78_in0
	// controller for andOp_78.andOp_78_in1
	// Insensitive connections
	assign andOp_78_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_78_in1 = state_1_is_active;
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	assign andOp_79_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_79_in1 = state_2_is_active;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_8_in1 = state_1_is_active;
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	assign andOp_80_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_80_in1 = state_3_is_active;
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	assign andOp_81_in0 = bb_2_active_in_state_5_out_data;
	assign andOp_81_in1 = state_5_is_active;
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	assign andOp_83_in0 = notOp_82_out;
	assign andOp_83_in1 = 1'd1;
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	assign andOp_85_in0 = notOp_84_out;
	assign andOp_85_in1 = andOp_83_out;
	// controller for andOp_87.andOp_87_in0
	// controller for andOp_87.andOp_87_in1
	// Insensitive connections
	assign andOp_87_in0 = notOp_86_out;
	assign andOp_87_in1 = 1'd1;
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	assign andOp_89_in0 = notOp_88_out;
	assign andOp_89_in1 = 1'd1;
	// controller for andOp_91.andOp_91_in0
	// controller for andOp_91.andOp_91_in1
	// Insensitive connections
	assign andOp_91_in0 = notOp_90_out;
	assign andOp_91_in1 = 1'd1;
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	assign andOp_93_in0 = notOp_92_out;
	assign andOp_93_in1 = 1'd1;
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	assign andOp_95_in0 = notOp_94_out;
	assign andOp_95_in1 = andOp_93_out;
	// controller for arg_0.arg_0_raddr_0_reg
	always @(*) begin
		if (andOp_45_out) begin 
			arg_0_raddr_0_reg = phi_phi1_out;
		end else begin
			arg_0_raddr_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_raddr_0_reg
	always @(*) begin
		if (andOp_47_out) begin 
			arg_1_raddr_0_reg = arg_0_rdata_0;
		end else begin
			arg_1_raddr_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_waddr_0_reg
	always @(*) begin
		if (andOp_48_out) begin 
			arg_1_waddr_0_reg = data_in_3_5_out_data;
		end else begin
			arg_1_waddr_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_wdata_0_reg
	always @(*) begin
		if (andOp_49_out) begin 
			arg_1_wdata_0_reg = add_add9_out;
		end else begin
			arg_1_wdata_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_wen_0_reg
	always @(*) begin
		if (andOp_51_out) begin 
			arg_1_wen_0_reg = -(1'd1);
		end else begin
			arg_1_wen_0_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_28_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_34_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_1.bb_1_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_1_in_data = eq_29_out;
		end else begin
			bb_1_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_2.bb_1_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_2_in_data = eq_30_out;
		end else begin
			bb_1_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_3.bb_1_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_3_in_data = eq_31_out;
		end else begin
			bb_1_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = eq_32_out;
		end else begin
			bb_1_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_1.bb_1_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_35_out) begin 
			bb_1_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_2.bb_1_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_36_out) begin 
			bb_1_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_3.bb_1_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_37_out) begin 
			bb_1_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_4.bb_1_predecessor_in_state_4_in_data
	always @(*) begin
		if (eq_38_out) begin 
			bb_1_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_5.bb_2_active_in_state_5_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_5_in_data = eq_33_out;
		end else begin
			bb_2_active_in_state_5_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_5.bb_2_predecessor_in_state_5_in_data
	always @(*) begin
		if (eq_39_out) begin 
			bb_2_predecessor_in_state_5_in_data = state_5_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_5_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_6_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_7_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_1.br_1_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_8_out) begin 
			br_1_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_9_out) begin 
			br_1_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_2.br_1_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_13_out) begin 
			br_1_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_14_out) begin 
			br_1_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_2_in_data = 0;
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
	// controller for br_1_happened_in_state_4.br_1_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_23_out) begin 
			br_1_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_24_out) begin 
			br_1_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_4_in_data = 0;
		end
	end
	// controller for concat_41.concat_41_in0
	// controller for concat_41.concat_41_in1
	// Insensitive connections
	assign concat_41_in0 = data_in_1_3_out_data;
	assign concat_41_in1 = 32'd0;
	// controller for concat_42.concat_42_in0
	// controller for concat_42.concat_42_in1
	// Insensitive connections
	assign concat_42_in0 = 32'd1;
	assign concat_42_in1 = 32'd0;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_100_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_3.data_in_1_3_in_data
	always @(*) begin
		if (eq_101_out) begin 
			data_in_1_3_in_data = data_store_0_0;
		end else if (eq_102_out) begin 
			data_in_1_3_in_data = data_store_1_2;
		end else begin
			data_in_1_3_in_data = 0;
		end
	end
	// controller for data_in_3_5.data_in_3_5_in_data
	always @(*) begin
		if (eq_107_out) begin 
			data_in_3_5_in_data = data_store_2_4;
		end else if (eq_108_out) begin 
			data_in_3_5_in_data = 8'd0;
		end else begin
			data_in_3_5_in_data = 0;
		end
	end
	// controller for eq_100.eq_100_in0
	// controller for eq_100.eq_100_in1
	// Insensitive connections
	assign eq_100_in0 = 32'd0;
	assign eq_100_in1 = state_0_last_state;
	// controller for eq_101.eq_101_in0
	// controller for eq_101.eq_101_in1
	// Insensitive connections
	assign eq_101_in0 = 32'd0;
	assign eq_101_in1 = state_1_last_state;
	// controller for eq_102.eq_102_in0
	// controller for eq_102.eq_102_in1
	// Insensitive connections
	assign eq_102_in0 = 32'd1;
	assign eq_102_in1 = state_1_last_state;
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	assign eq_104_in0 = 32'd1;
	assign eq_104_in1 = state_2_last_state;
	// controller for eq_105.eq_105_in0
	// controller for eq_105.eq_105_in1
	// Insensitive connections
	assign eq_105_in0 = 32'd2;
	assign eq_105_in1 = state_2_last_state;
	// controller for eq_107.eq_107_in0
	// controller for eq_107.eq_107_in1
	// Insensitive connections
	assign eq_107_in0 = 32'd2;
	assign eq_107_in1 = state_3_last_state;
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	assign eq_108_in0 = 32'd3;
	assign eq_108_in1 = state_3_last_state;
	// controller for eq_109.eq_109_in0
	// controller for eq_109.eq_109_in1
	// Insensitive connections
	assign eq_109_in0 = 32'd3;
	assign eq_109_in1 = state_4_last_state;
	// controller for eq_110.eq_110_in0
	// controller for eq_110.eq_110_in1
	// Insensitive connections
	assign eq_110_in0 = 32'd4;
	assign eq_110_in1 = state_4_last_state;
	// controller for eq_111.eq_111_in0
	// controller for eq_111.eq_111_in1
	// Insensitive connections
	assign eq_111_in0 = 32'd1;
	assign eq_111_in1 = state_5_last_state;
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	assign eq_112_in0 = 32'd4;
	assign eq_112_in1 = state_5_last_state;
	// controller for eq_113.eq_113_in0
	// controller for eq_113.eq_113_in1
	// Insensitive connections
	assign eq_113_in0 = 32'd5;
	assign eq_113_in1 = state_5_last_state;
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	assign eq_28_in0 = 32'd0;
	assign eq_28_in1 = state_0_entry_BB_reg;
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	assign eq_29_in0 = 32'd1;
	assign eq_29_in1 = state_1_entry_BB_reg;
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	assign eq_30_in0 = 32'd1;
	assign eq_30_in1 = state_2_entry_BB_reg;
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	assign eq_31_in0 = 32'd1;
	assign eq_31_in1 = state_3_entry_BB_reg;
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	assign eq_32_in0 = 32'd1;
	assign eq_32_in1 = state_4_entry_BB_reg;
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	assign eq_33_in0 = 32'd2;
	assign eq_33_in1 = state_5_entry_BB_reg;
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	assign eq_34_in0 = 32'd0;
	assign eq_34_in1 = state_0_entry_BB_reg;
	// controller for eq_35.eq_35_in0
	// controller for eq_35.eq_35_in1
	// Insensitive connections
	assign eq_35_in0 = 32'd1;
	assign eq_35_in1 = state_1_entry_BB_reg;
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	assign eq_36_in0 = 32'd1;
	assign eq_36_in1 = state_2_entry_BB_reg;
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	assign eq_37_in0 = 32'd1;
	assign eq_37_in1 = state_3_entry_BB_reg;
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	assign eq_38_in0 = 32'd1;
	assign eq_38_in1 = state_4_entry_BB_reg;
	// controller for eq_39.eq_39_in0
	// controller for eq_39.eq_39_in1
	// Insensitive connections
	assign eq_39_in0 = 32'd2;
	assign eq_39_in1 = state_5_entry_BB_reg;
	// controller for eq_58.eq_58_in0
	// controller for eq_58.eq_58_in1
	// Insensitive connections
	assign eq_58_in0 = counter__54;
	assign eq_58_in1 = 32'd2;
	// controller for icmp_icmp3.icmp_icmp3_in0
	// controller for icmp_icmp3.icmp_icmp3_in1
	// Insensitive connections
	assign icmp_icmp3_in0 = add_add2_out;
	assign icmp_icmp3_in1 = 32'd1024;
	// controller for in_pipeline_0.in_pipeline_0_in_data
	always @(*) begin
		if (1'd1) begin 
			in_pipeline_0_in_data = orOp_99_out;
		end else begin
			in_pipeline_0_in_data = 0;
		end
	end
	// controller for notOp_11.notOp_11_in0
	// Insensitive connections
	assign notOp_11_in0 = icmp_icmp3_out;
	// controller for notOp_14.notOp_14_in0
	// Insensitive connections
	assign notOp_14_in0 = andOp_13_out;
	// controller for notOp_16.notOp_16_in0
	// Insensitive connections
	assign notOp_16_in0 = icmp_icmp3_out;
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	assign notOp_19_in0 = andOp_18_out;
	// controller for notOp_21.notOp_21_in0
	// Insensitive connections
	assign notOp_21_in0 = icmp_icmp3_out;
	// controller for notOp_24.notOp_24_in0
	// Insensitive connections
	assign notOp_24_in0 = andOp_23_out;
	// controller for notOp_26.notOp_26_in0
	// Insensitive connections
	assign notOp_26_in0 = icmp_icmp3_out;
	// controller for notOp_56.notOp_56_in0
	// Insensitive connections
	assign notOp_56_in0 = state_1_is_active;
	// controller for notOp_61.notOp_61_in0
	// Insensitive connections
	assign notOp_61_in0 = state_1_is_active;
	// controller for notOp_63.notOp_63_in0
	// Insensitive connections
	assign notOp_63_in0 = state_2_is_active;
	// controller for notOp_65.notOp_65_in0
	// Insensitive connections
	assign notOp_65_in0 = state_3_is_active;
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	assign notOp_7_in0 = andOp_6_out;
	// controller for notOp_70.notOp_70_in0
	// Insensitive connections
	assign notOp_70_in0 = state_1_is_active;
	// controller for notOp_72.notOp_72_in0
	// Insensitive connections
	assign notOp_72_in0 = state_2_is_active;
	// controller for notOp_74.notOp_74_in0
	// Insensitive connections
	assign notOp_74_in0 = state_3_is_active;
	// controller for notOp_82.notOp_82_in0
	// Insensitive connections
	assign notOp_82_in0 = andOp_60_out;
	// controller for notOp_84.notOp_84_in0
	// Insensitive connections
	assign notOp_84_in0 = andOp_6_out;
	// controller for notOp_86.notOp_86_in0
	// Insensitive connections
	assign notOp_86_in0 = andOp_78_out;
	// controller for notOp_88.notOp_88_in0
	// Insensitive connections
	assign notOp_88_in0 = andOp_79_out;
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	assign notOp_9_in0 = andOp_8_out;
	// controller for notOp_90.notOp_90_in0
	// Insensitive connections
	assign notOp_90_in0 = andOp_80_out;
	// controller for notOp_92.notOp_92_in0
	// Insensitive connections
	assign notOp_92_in0 = andOp_69_out;
	// controller for notOp_94.notOp_94_in0
	// Insensitive connections
	assign notOp_94_in0 = andOp_81_out;
	// controller for orOp_96.orOp_96_in0
	// controller for orOp_96.orOp_96_in1
	// Insensitive connections
	assign orOp_96_in0 = state_1_is_active;
	assign orOp_96_in1 = 1'd0;
	// controller for orOp_97.orOp_97_in0
	// controller for orOp_97.orOp_97_in1
	// Insensitive connections
	assign orOp_97_in0 = state_2_is_active;
	assign orOp_97_in1 = orOp_96_out;
	// controller for orOp_98.orOp_98_in0
	// controller for orOp_98.orOp_98_in1
	// Insensitive connections
	assign orOp_98_in0 = state_3_is_active;
	assign orOp_98_in1 = orOp_97_out;
	// controller for orOp_99.orOp_99_in0
	// controller for orOp_99.orOp_99_in1
	// Insensitive connections
	assign orOp_99_in0 = state_4_is_active;
	assign orOp_99_in1 = orOp_98_out;
	// controller for phi_phi1.phi_phi1_in
	// controller for phi_phi1.phi_phi1_last_block
	// controller for phi_phi1.phi_phi1_s
	// Insensitive connections
	assign phi_phi1_in = concat_41_out;
	assign phi_phi1_last_block = bb_1_predecessor_in_state_1_out_data;
	assign phi_phi1_s = concat_42_out;
	// controller for ret13.valid_reg
	always @(*) begin
		if (andOp_53_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			counter__54 <= 0;
		end else begin
			if (andOp_57_out) begin
				counter__54 <= add_55_out;
			end
			if (state_1_is_active) begin
				counter__54 <= 32'd0;
			end
		end
	end

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
			if (andOp_103_out) begin
				data_store_1_2 <= add_add2_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_4 <= 0;
		end else begin
			if (andOp_106_out) begin
				data_store_2_4 <= arg_0_rdata_0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			delayed_signal__59 <= 0;
		end else begin
			if (state_1_is_active) begin
				delayed_signal__59 <= andOp_10_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_68_out) begin
				global_state <= 32'd5;
			end
			if (andOp_6_out) begin
				global_state <= 32'd200000;
			end
			if (andOp_81_out) begin
				global_state <= 32'd5;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_1_5 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_1_5 <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_bb_1_5 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_bb_1_5 <= 1'd1;
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
			if (andOp_10_out) begin
				state_1_entry_BB_reg <= 32'd1;
			end
			if (andOp_6_out) begin
				state_1_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_60_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_6_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_85_out) begin
				state_1_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_10_out) begin
				state_1_last_BB_reg <= 32'd1;
			end
			if (andOp_6_out) begin
				state_1_last_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_10_out) begin
				state_1_last_state <= 32'd1;
			end
			if (andOp_6_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_78_out) begin
				state_2_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_78_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_87_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_78_out) begin
				state_2_last_BB_reg <= bb_1_predecessor_in_state_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_78_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_79_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_79_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_89_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_79_out) begin
				state_3_last_BB_reg <= bb_1_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_79_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_80_out) begin
				state_4_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_80_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_91_out) begin
				state_4_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_80_out) begin
				state_4_last_BB_reg <= bb_1_predecessor_in_state_3_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_state <= 0;
		end else begin
			if (andOp_80_out) begin
				state_4_last_state <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_entry_BB_reg <= 0;
		end else begin
			if (andOp_77_out) begin
				state_5_entry_BB_reg <= 32'd2;
			end
			if (andOp_81_out) begin
				state_5_entry_BB_reg <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_is_active <= 0;
		end else begin
			if (andOp_69_out) begin
				state_5_is_active <= 1'd1;
			end
			if (andOp_81_out) begin
				state_5_is_active <= 1'd1;
			end
			if (andOp_95_out) begin
				state_5_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_last_BB_reg <= 0;
		end else begin
			if (andOp_12_out) begin
				state_5_last_BB_reg <= 32'd1;
			end
			if (andOp_81_out) begin
				state_5_last_BB_reg <= bb_2_predecessor_in_state_5_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_last_state <= 0;
		end else begin
			if (andOp_12_out) begin
				state_5_last_state <= 32'd1;
			end
			if (andOp_81_out) begin
				state_5_last_state <= 32'd5;
			end
		end
	end

endmodule

