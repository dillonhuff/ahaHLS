module vadd(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [8:0] arg_0_debug_addr, input [31:0] arg_0_debug_data, output [8:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [8:0] arg_0_raddr_0, input [31:0] arg_0_rdata_0, output [0:0] arg_0_rst, output [8:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, output [8:0] arg_1_debug_addr, input [31:0] arg_1_debug_data, output [8:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [8:0] arg_1_raddr_0, input [31:0] arg_1_rdata_0, output [0:0] arg_1_rst, output [8:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0, output [8:0] arg_2_debug_addr, input [31:0] arg_2_debug_data, output [8:0] arg_2_debug_write_addr, output [31:0] arg_2_debug_write_data, output [0:0] arg_2_debug_write_en, output [8:0] arg_2_raddr_0, input [31:0] arg_2_rdata_0, output [0:0] arg_2_rst, output [8:0] arg_2_waddr_0, output [31:0] arg_2_wdata_0, output [0:0] arg_2_wen_0);

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
	reg [8:0] arg_1_debug_addr_reg;
	reg [8:0] arg_1_debug_write_addr_reg;
	reg [31:0] arg_1_debug_write_data_reg;
	reg [0:0] arg_1_debug_write_en_reg;
	reg [8:0] arg_1_raddr_0_reg;
	reg [0:0] arg_1_rst_reg;
	reg [8:0] arg_1_waddr_0_reg;
	reg [31:0] arg_1_wdata_0_reg;
	reg [0:0] arg_1_wen_0_reg;
	reg [8:0] arg_2_debug_addr_reg;
	reg [8:0] arg_2_debug_write_addr_reg;
	reg [31:0] arg_2_debug_write_data_reg;
	reg [0:0] arg_2_debug_write_en_reg;
	reg [8:0] arg_2_raddr_0_reg;
	reg [0:0] arg_2_rst_reg;
	reg [8:0] arg_2_waddr_0_reg;
	reg [31:0] arg_2_wdata_0_reg;
	reg [0:0] arg_2_wen_0_reg;

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
	assign arg_2_debug_addr = arg_2_debug_addr_reg;
	assign arg_2_debug_write_addr = arg_2_debug_write_addr_reg;
	assign arg_2_debug_write_data = arg_2_debug_write_data_reg;
	assign arg_2_debug_write_en = arg_2_debug_write_en_reg;
	assign arg_2_raddr_0 = arg_2_raddr_0_reg;
	assign arg_2_rst = arg_2_rst_reg;
	assign arg_2_waddr_0 = arg_2_waddr_0_reg;
	assign arg_2_wdata_0 = arg_2_wdata_0_reg;
	assign arg_2_wen_0 = arg_2_wen_0_reg;

	// Start debug wires and ports

	initial begin
	end






	// End debug wires and ports

	// Start Functional Units
	wire [63:0] phi_phi1_in;
	wire [31:0] phi_phi1_last_block;
	wire [63:0] phi_phi1_s;
	wire [31:0] phi_phi1_out;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_phi1(.in(phi_phi1_in), .last_block(phi_phi1_last_block), .out(phi_phi1_out), .s(phi_phi1_s));

	br_dummy br_unit();

	wire [31:0] add_add3_in0;
	wire [31:0] add_add3_in1;
	wire [31:0] add_add3_out;
	add #(.WIDTH(32)) add_add3(.in0(add_add3_in0), .in1(add_add3_in1), .out(add_add3_out));

	wire [31:0] icmp_icmp4_in0;
	wire [31:0] icmp_icmp4_in1;
	wire [0:0] icmp_icmp4_out;
	ne #(.WIDTH(32)) icmp_icmp4(.in0(icmp_icmp4_in0), .in1(icmp_icmp4_in1), .out(icmp_icmp4_out));

	wire [31:0] add_add12_in0;
	wire [31:0] add_add12_in1;
	wire [31:0] add_add12_out;
	add #(.WIDTH(32)) add_add12(.in0(add_add12_in0), .in1(add_add12_in1), .out(add_add12_out));

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

	reg [0:0] bb_2_active_in_state_4_in_data;
	wire [0:0] bb_2_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_4(.in_data(bb_2_active_in_state_4_in_data), .out_data(bb_2_active_in_state_4_out_data));

	reg [31:0] bb_2_predecessor_in_state_4_in_data;
	wire [31:0] bb_2_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_4(.in_data(bb_2_predecessor_in_state_4_in_data), .out_data(bb_2_predecessor_in_state_4_out_data));

	reg [31:0] data_in_0_1_in_data;
	wire [31:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [31:0] data_in_1_4_in_data;
	wire [31:0] data_in_1_4_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_4(.in_data(data_in_1_4_in_data), .out_data(data_in_1_4_out_data));

	reg [31:0] data_in_2_5_in_data;
	wire [31:0] data_in_2_5_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_5(.in_data(data_in_2_5_in_data), .out_data(data_in_2_5_out_data));

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

	wire [0:0] andOp_33_in0;
	wire [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	wire [31:0] concat_34_in0;
	wire [31:0] concat_34_in1;
	wire [63:0] concat_34_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_34(.in0(concat_34_in0), .in1(concat_34_in1), .out(concat_34_out));

	wire [31:0] concat_35_in0;
	wire [31:0] concat_35_in1;
	wire [63:0] concat_35_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_35(.in0(concat_35_in0), .in1(concat_35_in1), .out(concat_35_out));

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

	wire [0:0] notOp_47_in0;
	wire [0:0] notOp_47_out;
	notOp #(.WIDTH(1)) notOp_47(.in(notOp_47_in0), .out(notOp_47_out));

	wire [0:0] andOp_48_in0;
	wire [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	wire [0:0] notOp_49_in0;
	wire [0:0] notOp_49_out;
	notOp #(.WIDTH(1)) notOp_49(.in(notOp_49_in0), .out(notOp_49_out));

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

	wire [0:0] notOp_54_in0;
	wire [0:0] notOp_54_out;
	notOp #(.WIDTH(1)) notOp_54(.in(notOp_54_in0), .out(notOp_54_out));

	wire [0:0] andOp_55_in0;
	wire [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	wire [0:0] notOp_56_in0;
	wire [0:0] notOp_56_out;
	notOp #(.WIDTH(1)) notOp_56(.in(notOp_56_in0), .out(notOp_56_out));

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

	wire [0:0] andOp_60_in0;
	wire [0:0] andOp_60_in1;
	wire [0:0] andOp_60_out;
	andOp #(.WIDTH(1)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	wire [0:0] andOp_61_in0;
	wire [0:0] andOp_61_in1;
	wire [0:0] andOp_61_out;
	andOp #(.WIDTH(1)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

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

	reg [0:0] in_pipeline_0_in_data;
	wire [0:0] in_pipeline_0_out_data;
	hls_wire #(.WIDTH(1)) in_pipeline_0(.in_data(in_pipeline_0_in_data), .out_data(in_pipeline_0_out_data));

	wire [0:0] orOp_75_in0;
	wire [0:0] orOp_75_in1;
	wire [0:0] orOp_75_out;
	orOp #(.WIDTH(1)) orOp_75(.in0(orOp_75_in0), .in1(orOp_75_in1), .out(orOp_75_out));

	wire [0:0] orOp_76_in0;
	wire [0:0] orOp_76_in1;
	wire [0:0] orOp_76_out;
	orOp #(.WIDTH(1)) orOp_76(.in0(orOp_76_in0), .in1(orOp_76_in1), .out(orOp_76_out));

	wire [0:0] orOp_77_in0;
	wire [0:0] orOp_77_in1;
	wire [0:0] orOp_77_out;
	orOp #(.WIDTH(1)) orOp_77(.in0(orOp_77_in0), .in1(orOp_77_in1), .out(orOp_77_out));

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

	wire [0:0] andOp_81_in0;
	wire [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	wire [0:0] andOp_82_in0;
	wire [0:0] andOp_82_in1;
	wire [0:0] andOp_82_out;
	andOp #(.WIDTH(1)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	wire [31:0] eq_83_in0;
	wire [31:0] eq_83_in1;
	wire [0:0] eq_83_out;
	eq #(.WIDTH(32)) eq_83(.in0(eq_83_in0), .in1(eq_83_in1), .out(eq_83_out));

	wire [31:0] eq_84_in0;
	wire [31:0] eq_84_in1;
	wire [0:0] eq_84_out;
	eq #(.WIDTH(32)) eq_84(.in0(eq_84_in0), .in1(eq_84_in1), .out(eq_84_out));

	wire [31:0] eq_85_in0;
	wire [31:0] eq_85_in1;
	wire [0:0] eq_85_out;
	eq #(.WIDTH(32)) eq_85(.in0(eq_85_in0), .in1(eq_85_in1), .out(eq_85_out));

	wire [31:0] eq_86_in0;
	wire [31:0] eq_86_in1;
	wire [0:0] eq_86_out;
	eq #(.WIDTH(32)) eq_86(.in0(eq_86_in0), .in1(eq_86_in1), .out(eq_86_out));

	wire [31:0] eq_87_in0;
	wire [31:0] eq_87_in1;
	wire [0:0] eq_87_out;
	eq #(.WIDTH(32)) eq_87(.in0(eq_87_in0), .in1(eq_87_in1), .out(eq_87_out));

	wire [31:0] eq_88_in0;
	wire [31:0] eq_88_in1;
	wire [0:0] eq_88_out;
	eq #(.WIDTH(32)) eq_88(.in0(eq_88_in0), .in1(eq_88_in1), .out(eq_88_out));

	wire [31:0] eq_89_in0;
	wire [31:0] eq_89_in1;
	wire [0:0] eq_89_out;
	eq #(.WIDTH(32)) eq_89(.in0(eq_89_in0), .in1(eq_89_in1), .out(eq_89_out));

	// End Functional Units

	reg [31:0] data_store_0_0;
	reg [31:0] data_store_1_2;
	reg [31:0] data_store_1_3;
	reg [31:0] global_state;
	reg [0:0] out_of_pipe_1_4;
	reg [0:0] out_of_pipe_bb_1_4;
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

	// controller for add_add12.add_add12_in0
	// controller for add_add12.add_add12_in1
	// Insensitive connections
	assign add_add12_in0 = arg_0_rdata_0;
	assign add_add12_in1 = arg_1_rdata_0;
	// controller for add_add3.add_add3_in0
	// controller for add_add3.add_add3_in1
	// Insensitive connections
	assign add_add3_in0 = phi_phi1_out;
	assign add_add3_in1 = 32'd1;
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	assign andOp_10_in0 = andOp_8_out;
	assign andOp_10_in1 = icmp_icmp4_out;
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
	assign andOp_15_in1 = icmp_icmp4_out;
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
	assign andOp_20_in1 = icmp_icmp4_out;
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	assign andOp_22_in0 = andOp_18_out;
	assign andOp_22_in1 = notOp_21_out;
	// controller for andOp_33.andOp_33_in0
	// controller for andOp_33.andOp_33_in1
	// Insensitive connections
	assign andOp_33_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_33_in1 = state_1_is_active;
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	assign andOp_36_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_36_in1 = state_1_is_active;
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	assign andOp_37_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_37_in1 = state_2_is_active;
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	assign andOp_38_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_38_in1 = state_1_is_active;
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	assign andOp_39_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_39_in1 = state_1_is_active;
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	assign andOp_40_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_40_in1 = state_1_is_active;
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	assign andOp_41_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_41_in1 = state_2_is_active;
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	assign andOp_42_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_42_in1 = state_2_is_active;
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	assign andOp_43_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_43_in1 = state_2_is_active;
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	assign andOp_44_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_44_in1 = state_2_is_active;
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	assign andOp_45_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_45_in1 = state_2_is_active;
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	assign andOp_46_in0 = bb_2_active_in_state_4_out_data;
	assign andOp_46_in1 = state_4_is_active;
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	assign andOp_48_in0 = 1'd1;
	assign andOp_48_in1 = notOp_47_out;
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	assign andOp_50_in0 = andOp_48_out;
	assign andOp_50_in1 = notOp_49_out;
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	assign andOp_51_in0 = in_pipeline_0_out_data;
	assign andOp_51_in1 = andOp_50_out;
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	assign andOp_52_in0 = andOp_51_out;
	assign andOp_52_in1 = out_of_pipe_1_4;
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	assign andOp_53_in0 = andOp_51_out;
	assign andOp_53_in1 = out_of_pipe_1_4;
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	assign andOp_55_in0 = 1'd1;
	assign andOp_55_in1 = notOp_54_out;
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	assign andOp_57_in0 = andOp_55_out;
	assign andOp_57_in1 = notOp_56_out;
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	assign andOp_58_in0 = in_pipeline_0_out_data;
	assign andOp_58_in1 = andOp_57_out;
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	assign andOp_59_in0 = andOp_58_out;
	assign andOp_59_in1 = out_of_pipe_bb_1_4;
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	assign andOp_6_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_6_in1 = state_0_is_active;
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	assign andOp_60_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_60_in1 = state_1_is_active;
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	assign andOp_61_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_61_in1 = state_2_is_active;
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	assign andOp_62_in0 = bb_2_active_in_state_4_out_data;
	assign andOp_62_in1 = state_4_is_active;
	// controller for andOp_64.andOp_64_in0
	// controller for andOp_64.andOp_64_in1
	// Insensitive connections
	assign andOp_64_in0 = notOp_63_out;
	assign andOp_64_in1 = 1'd1;
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	assign andOp_66_in0 = notOp_65_out;
	assign andOp_66_in1 = andOp_64_out;
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
	assign andOp_72_in1 = 1'd1;
	// controller for andOp_74.andOp_74_in0
	// controller for andOp_74.andOp_74_in1
	// Insensitive connections
	assign andOp_74_in0 = notOp_73_out;
	assign andOp_74_in1 = andOp_72_out;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_8_in1 = state_1_is_active;
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	assign andOp_81_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_81_in1 = state_1_is_active;
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	assign andOp_82_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_82_in1 = state_1_is_active;
	// controller for arg_0.arg_0_raddr_0_reg
	always @(*) begin
		if (andOp_36_out) begin 
			arg_0_raddr_0_reg = phi_phi1_out;
		end else begin
			arg_0_raddr_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_raddr_0_reg
	always @(*) begin
		if (andOp_40_out) begin 
			arg_1_raddr_0_reg = phi_phi1_out;
		end else begin
			arg_1_raddr_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_waddr_0_reg
	always @(*) begin
		if (andOp_44_out) begin 
			arg_2_waddr_0_reg = data_in_2_5_out_data;
		end else begin
			arg_2_waddr_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_wdata_0_reg
	always @(*) begin
		if (andOp_43_out) begin 
			arg_2_wdata_0_reg = add_add12_out;
		end else begin
			arg_2_wdata_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_wen_0_reg
	always @(*) begin
		if (andOp_42_out) begin 
			arg_2_wen_0_reg = -(1'd1);
		end else begin
			arg_2_wen_0_reg = 0;
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
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_28_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_1.bb_1_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_1_in_data = eq_24_out;
		end else begin
			bb_1_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_2.bb_1_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_2_in_data = eq_25_out;
		end else begin
			bb_1_active_in_state_2_in_data = 0;
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
	// controller for bb_1_predecessor_in_state_1.bb_1_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_29_out) begin 
			bb_1_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_2.bb_1_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_30_out) begin 
			bb_1_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_3.bb_1_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_31_out) begin 
			bb_1_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_4.bb_2_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_4_in_data = eq_27_out;
		end else begin
			bb_2_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_4.bb_2_predecessor_in_state_4_in_data
	always @(*) begin
		if (eq_32_out) begin 
			bb_2_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_4_in_data = 0;
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
	// controller for concat_34.concat_34_in0
	// controller for concat_34.concat_34_in1
	// Insensitive connections
	assign concat_34_in0 = data_in_1_4_out_data;
	assign concat_34_in1 = 32'd0;
	// controller for concat_35.concat_35_in0
	// controller for concat_35.concat_35_in1
	// Insensitive connections
	assign concat_35_in0 = 32'd1;
	assign concat_35_in1 = 32'd0;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_78_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_4.data_in_1_4_in_data
	always @(*) begin
		if (eq_79_out) begin 
			data_in_1_4_in_data = data_store_0_0;
		end else if (eq_80_out) begin 
			data_in_1_4_in_data = data_store_1_3;
		end else begin
			data_in_1_4_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_83_out) begin 
			data_in_2_5_in_data = data_store_1_2;
		end else if (eq_84_out) begin 
			data_in_2_5_in_data = 32'd0;
		end else begin
			data_in_2_5_in_data = 0;
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
	assign eq_24_in0 = 32'd1;
	assign eq_24_in1 = state_1_entry_BB_reg;
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	assign eq_25_in0 = 32'd1;
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
	assign eq_27_in1 = state_4_entry_BB_reg;
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
	assign eq_32_in0 = 32'd2;
	assign eq_32_in1 = state_4_entry_BB_reg;
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	assign eq_78_in0 = 32'd0;
	assign eq_78_in1 = state_0_last_state;
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	assign eq_79_in0 = 32'd0;
	assign eq_79_in1 = state_1_last_state;
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	assign eq_80_in0 = 32'd1;
	assign eq_80_in1 = state_1_last_state;
	// controller for eq_83.eq_83_in0
	// controller for eq_83.eq_83_in1
	// Insensitive connections
	assign eq_83_in0 = 32'd1;
	assign eq_83_in1 = state_2_last_state;
	// controller for eq_84.eq_84_in0
	// controller for eq_84.eq_84_in1
	// Insensitive connections
	assign eq_84_in0 = 32'd2;
	assign eq_84_in1 = state_2_last_state;
	// controller for eq_85.eq_85_in0
	// controller for eq_85.eq_85_in1
	// Insensitive connections
	assign eq_85_in0 = 32'd2;
	assign eq_85_in1 = state_3_last_state;
	// controller for eq_86.eq_86_in0
	// controller for eq_86.eq_86_in1
	// Insensitive connections
	assign eq_86_in0 = 32'd3;
	assign eq_86_in1 = state_3_last_state;
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	assign eq_87_in0 = 32'd1;
	assign eq_87_in1 = state_4_last_state;
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	assign eq_88_in0 = 32'd3;
	assign eq_88_in1 = state_4_last_state;
	// controller for eq_89.eq_89_in0
	// controller for eq_89.eq_89_in1
	// Insensitive connections
	assign eq_89_in0 = 32'd4;
	assign eq_89_in1 = state_4_last_state;
	// controller for icmp_icmp4.icmp_icmp4_in0
	// controller for icmp_icmp4.icmp_icmp4_in1
	// Insensitive connections
	assign icmp_icmp4_in0 = add_add3_out;
	assign icmp_icmp4_in1 = 32'd512;
	// controller for in_pipeline_0.in_pipeline_0_in_data
	always @(*) begin
		if (1'd1) begin 
			in_pipeline_0_in_data = orOp_77_out;
		end else begin
			in_pipeline_0_in_data = 0;
		end
	end
	// controller for notOp_11.notOp_11_in0
	// Insensitive connections
	assign notOp_11_in0 = icmp_icmp4_out;
	// controller for notOp_14.notOp_14_in0
	// Insensitive connections
	assign notOp_14_in0 = andOp_13_out;
	// controller for notOp_16.notOp_16_in0
	// Insensitive connections
	assign notOp_16_in0 = icmp_icmp4_out;
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	assign notOp_19_in0 = andOp_18_out;
	// controller for notOp_21.notOp_21_in0
	// Insensitive connections
	assign notOp_21_in0 = icmp_icmp4_out;
	// controller for notOp_47.notOp_47_in0
	// Insensitive connections
	assign notOp_47_in0 = state_1_is_active;
	// controller for notOp_49.notOp_49_in0
	// Insensitive connections
	assign notOp_49_in0 = state_2_is_active;
	// controller for notOp_54.notOp_54_in0
	// Insensitive connections
	assign notOp_54_in0 = state_1_is_active;
	// controller for notOp_56.notOp_56_in0
	// Insensitive connections
	assign notOp_56_in0 = state_2_is_active;
	// controller for notOp_63.notOp_63_in0
	// Insensitive connections
	assign notOp_63_in0 = andOp_10_out;
	// controller for notOp_65.notOp_65_in0
	// Insensitive connections
	assign notOp_65_in0 = andOp_6_out;
	// controller for notOp_67.notOp_67_in0
	// Insensitive connections
	assign notOp_67_in0 = andOp_60_out;
	// controller for notOp_69.notOp_69_in0
	// Insensitive connections
	assign notOp_69_in0 = andOp_61_out;
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	assign notOp_7_in0 = andOp_6_out;
	// controller for notOp_71.notOp_71_in0
	// Insensitive connections
	assign notOp_71_in0 = andOp_53_out;
	// controller for notOp_73.notOp_73_in0
	// Insensitive connections
	assign notOp_73_in0 = andOp_62_out;
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	assign notOp_9_in0 = andOp_8_out;
	// controller for orOp_75.orOp_75_in0
	// controller for orOp_75.orOp_75_in1
	// Insensitive connections
	assign orOp_75_in0 = state_1_is_active;
	assign orOp_75_in1 = 1'd0;
	// controller for orOp_76.orOp_76_in0
	// controller for orOp_76.orOp_76_in1
	// Insensitive connections
	assign orOp_76_in0 = state_2_is_active;
	assign orOp_76_in1 = orOp_75_out;
	// controller for orOp_77.orOp_77_in0
	// controller for orOp_77.orOp_77_in1
	// Insensitive connections
	assign orOp_77_in0 = state_3_is_active;
	assign orOp_77_in1 = orOp_76_out;
	// controller for phi_phi1.phi_phi1_in
	// controller for phi_phi1.phi_phi1_last_block
	// controller for phi_phi1.phi_phi1_s
	// Insensitive connections
	assign phi_phi1_in = concat_34_out;
	assign phi_phi1_last_block = bb_1_predecessor_in_state_1_out_data;
	assign phi_phi1_s = concat_35_out;
	// controller for ret13.valid_reg
	always @(*) begin
		if (andOp_46_out) begin 
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
			if (state_0_is_active) begin
				data_store_0_0 <= data_in_0_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_2 <= 0;
		end else begin
			if (andOp_81_out) begin
				data_store_1_2 <= phi_phi1_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_3 <= 0;
		end else begin
			if (andOp_82_out) begin
				data_store_1_3 <= add_add3_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_52_out) begin
				global_state <= 32'd4;
			end
			if (andOp_62_out) begin
				global_state <= 32'd4;
			end
			if (andOp_6_out) begin
				global_state <= 32'd200000;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_1_4 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_1_4 <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_bb_1_4 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_bb_1_4 <= 1'd1;
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
			if (andOp_10_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_66_out) begin
				state_1_is_active <= 1'd0;
			end
			if (andOp_6_out) begin
				state_1_is_active <= 1'd1;
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
			if (andOp_60_out) begin
				state_2_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_60_out) begin
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
			if (andOp_60_out) begin
				state_2_last_BB_reg <= bb_1_predecessor_in_state_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_60_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_61_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_61_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_70_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_61_out) begin
				state_3_last_BB_reg <= bb_1_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_61_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_59_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
			if (andOp_62_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_53_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_62_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_74_out) begin
				state_4_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_12_out) begin
				state_4_last_BB_reg <= 32'd1;
			end
			if (andOp_62_out) begin
				state_4_last_BB_reg <= bb_2_predecessor_in_state_4_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_state <= 0;
		end else begin
			if (andOp_12_out) begin
				state_4_last_state <= 32'd1;
			end
			if (andOp_62_out) begin
				state_4_last_state <= 32'd4;
			end
		end
	end

endmodule

