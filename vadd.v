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
	br_dummy br_unit();

	wire [63:0] phi_phi2_in;
	wire [31:0] phi_phi2_last_block;
	wire [63:0] phi_phi2_s;
	wire [31:0] phi_phi2_out;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_phi2(.in(phi_phi2_in), .last_block(phi_phi2_last_block), .out(phi_phi2_out), .s(phi_phi2_s));

	wire [31:0] add_add3_in0;
	wire [31:0] add_add3_in1;
	wire [31:0] add_add3_out;
	add #(.WIDTH(32)) add_add3(.in0(add_add3_in0), .in1(add_add3_in1), .out(add_add3_out));

	wire [31:0] add_add11_in0;
	wire [31:0] add_add11_in1;
	wire [31:0] add_add11_out;
	add #(.WIDTH(32)) add_add11(.in0(add_add11_in0), .in1(add_add11_in1), .out(add_add11_out));

	wire [31:0] icmp_icmp4_in0;
	wire [31:0] icmp_icmp4_in1;
	wire [0:0] icmp_icmp4_out;
	ne #(.WIDTH(32)) icmp_icmp4(.in0(icmp_icmp4_in0), .in1(icmp_icmp4_in1), .out(icmp_icmp4_out));

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

	reg [0:0] bb_1_active_in_state_5_in_data;
	wire [0:0] bb_1_active_in_state_5_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_5(.in_data(bb_1_active_in_state_5_in_data), .out_data(bb_1_active_in_state_5_out_data));

	reg [31:0] bb_1_predecessor_in_state_5_in_data;
	wire [31:0] bb_1_predecessor_in_state_5_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_5(.in_data(bb_1_predecessor_in_state_5_in_data), .out_data(bb_1_predecessor_in_state_5_out_data));

	reg [0:0] br_1_happened_in_state_5_in_data;
	wire [0:0] br_1_happened_in_state_5_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_5(.in_data(br_1_happened_in_state_5_in_data), .out_data(br_1_happened_in_state_5_out_data));

	reg [0:0] bb_2_active_in_state_6_in_data;
	wire [0:0] bb_2_active_in_state_6_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_6(.in_data(bb_2_active_in_state_6_in_data), .out_data(bb_2_active_in_state_6_out_data));

	reg [31:0] bb_2_predecessor_in_state_6_in_data;
	wire [31:0] bb_2_predecessor_in_state_6_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_6(.in_data(bb_2_predecessor_in_state_6_in_data), .out_data(bb_2_predecessor_in_state_6_out_data));

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

	wire [0:0] andOp_28_in0;
	wire [0:0] andOp_28_in1;
	wire [0:0] andOp_28_out;
	andOp #(.WIDTH(1)) andOp_28(.in0(andOp_28_in0), .in1(andOp_28_in1), .out(andOp_28_out));

	wire [0:0] notOp_29_in0;
	wire [0:0] notOp_29_out;
	notOp #(.WIDTH(1)) notOp_29(.in(notOp_29_in0), .out(notOp_29_out));

	wire [0:0] andOp_30_in0;
	wire [0:0] andOp_30_in1;
	wire [0:0] andOp_30_out;
	andOp #(.WIDTH(1)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

	wire [0:0] notOp_31_in0;
	wire [0:0] notOp_31_out;
	notOp #(.WIDTH(1)) notOp_31(.in(notOp_31_in0), .out(notOp_31_out));

	wire [0:0] andOp_32_in0;
	wire [0:0] andOp_32_in1;
	wire [0:0] andOp_32_out;
	andOp #(.WIDTH(1)) andOp_32(.in0(andOp_32_in0), .in1(andOp_32_in1), .out(andOp_32_out));

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

	wire [31:0] eq_40_in0;
	wire [31:0] eq_40_in1;
	wire [0:0] eq_40_out;
	eq #(.WIDTH(32)) eq_40(.in0(eq_40_in0), .in1(eq_40_in1), .out(eq_40_out));

	wire [31:0] eq_41_in0;
	wire [31:0] eq_41_in1;
	wire [0:0] eq_41_out;
	eq #(.WIDTH(32)) eq_41(.in0(eq_41_in0), .in1(eq_41_in1), .out(eq_41_out));

	wire [31:0] eq_42_in0;
	wire [31:0] eq_42_in1;
	wire [0:0] eq_42_out;
	eq #(.WIDTH(32)) eq_42(.in0(eq_42_in0), .in1(eq_42_in1), .out(eq_42_out));

	wire [31:0] eq_43_in0;
	wire [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	wire [31:0] eq_44_in0;
	wire [31:0] eq_44_in1;
	wire [0:0] eq_44_out;
	eq #(.WIDTH(32)) eq_44(.in0(eq_44_in0), .in1(eq_44_in1), .out(eq_44_out));

	wire [31:0] eq_45_in0;
	wire [31:0] eq_45_in1;
	wire [0:0] eq_45_out;
	eq #(.WIDTH(32)) eq_45(.in0(eq_45_in0), .in1(eq_45_in1), .out(eq_45_out));

	wire [31:0] eq_46_in0;
	wire [31:0] eq_46_in1;
	wire [0:0] eq_46_out;
	eq #(.WIDTH(32)) eq_46(.in0(eq_46_in0), .in1(eq_46_in1), .out(eq_46_out));

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

	wire [31:0] concat_50_in0;
	wire [31:0] concat_50_in1;
	wire [63:0] concat_50_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_50(.in0(concat_50_in0), .in1(concat_50_in1), .out(concat_50_out));

	wire [31:0] concat_51_in0;
	wire [31:0] concat_51_in1;
	wire [63:0] concat_51_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_51(.in0(concat_51_in0), .in1(concat_51_in1), .out(concat_51_out));

	wire [0:0] andOp_52_in0;
	wire [0:0] andOp_52_in1;
	wire [0:0] andOp_52_out;
	andOp #(.WIDTH(1)) andOp_52(.in0(andOp_52_in0), .in1(andOp_52_in1), .out(andOp_52_out));

	wire [0:0] andOp_53_in0;
	wire [0:0] andOp_53_in1;
	wire [0:0] andOp_53_out;
	andOp #(.WIDTH(1)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	wire [0:0] andOp_54_in0;
	wire [0:0] andOp_54_in1;
	wire [0:0] andOp_54_out;
	andOp #(.WIDTH(1)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	wire [0:0] andOp_55_in0;
	wire [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	wire [0:0] andOp_56_in0;
	wire [0:0] andOp_56_in1;
	wire [0:0] andOp_56_out;
	andOp #(.WIDTH(1)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

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

	wire [0:0] notOp_67_in0;
	wire [0:0] notOp_67_out;
	notOp #(.WIDTH(1)) notOp_67(.in(notOp_67_in0), .out(notOp_67_out));

	wire [0:0] andOp_68_in0;
	wire [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	wire [0:0] andOp_69_in0;
	wire [0:0] andOp_69_in1;
	wire [0:0] andOp_69_out;
	andOp #(.WIDTH(1)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	wire [0:0] andOp_70_in0;
	wire [0:0] andOp_70_in1;
	wire [0:0] andOp_70_out;
	andOp #(.WIDTH(1)) andOp_70(.in0(andOp_70_in0), .in1(andOp_70_in1), .out(andOp_70_out));

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

	wire [0:0] notOp_76_in0;
	wire [0:0] notOp_76_out;
	notOp #(.WIDTH(1)) notOp_76(.in(notOp_76_in0), .out(notOp_76_out));

	wire [0:0] andOp_77_in0;
	wire [0:0] andOp_77_in1;
	wire [0:0] andOp_77_out;
	andOp #(.WIDTH(1)) andOp_77(.in0(andOp_77_in0), .in1(andOp_77_in1), .out(andOp_77_out));

	wire [0:0] notOp_78_in0;
	wire [0:0] notOp_78_out;
	notOp #(.WIDTH(1)) notOp_78(.in(notOp_78_in0), .out(notOp_78_out));

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

	wire [0:0] andOp_82_in0;
	wire [0:0] andOp_82_in1;
	wire [0:0] andOp_82_out;
	andOp #(.WIDTH(1)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	wire [0:0] andOp_83_in0;
	wire [0:0] andOp_83_in1;
	wire [0:0] andOp_83_out;
	andOp #(.WIDTH(1)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	wire [0:0] andOp_84_in0;
	wire [0:0] andOp_84_in1;
	wire [0:0] andOp_84_out;
	andOp #(.WIDTH(1)) andOp_84(.in0(andOp_84_in0), .in1(andOp_84_in1), .out(andOp_84_out));

	wire [0:0] andOp_85_in0;
	wire [0:0] andOp_85_in1;
	wire [0:0] andOp_85_out;
	andOp #(.WIDTH(1)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	wire [0:0] andOp_86_in0;
	wire [0:0] andOp_86_in1;
	wire [0:0] andOp_86_out;
	andOp #(.WIDTH(1)) andOp_86(.in0(andOp_86_in0), .in1(andOp_86_in1), .out(andOp_86_out));

	wire [0:0] notOp_87_in0;
	wire [0:0] notOp_87_out;
	notOp #(.WIDTH(1)) notOp_87(.in(notOp_87_in0), .out(notOp_87_out));

	wire [0:0] andOp_88_in0;
	wire [0:0] andOp_88_in1;
	wire [0:0] andOp_88_out;
	andOp #(.WIDTH(1)) andOp_88(.in0(andOp_88_in0), .in1(andOp_88_in1), .out(andOp_88_out));

	wire [0:0] notOp_89_in0;
	wire [0:0] notOp_89_out;
	notOp #(.WIDTH(1)) notOp_89(.in(notOp_89_in0), .out(notOp_89_out));

	wire [0:0] andOp_90_in0;
	wire [0:0] andOp_90_in1;
	wire [0:0] andOp_90_out;
	andOp #(.WIDTH(1)) andOp_90(.in0(andOp_90_in0), .in1(andOp_90_in1), .out(andOp_90_out));

	wire [0:0] notOp_91_in0;
	wire [0:0] notOp_91_out;
	notOp #(.WIDTH(1)) notOp_91(.in(notOp_91_in0), .out(notOp_91_out));

	wire [0:0] andOp_92_in0;
	wire [0:0] andOp_92_in1;
	wire [0:0] andOp_92_out;
	andOp #(.WIDTH(1)) andOp_92(.in0(andOp_92_in0), .in1(andOp_92_in1), .out(andOp_92_out));

	wire [0:0] notOp_93_in0;
	wire [0:0] notOp_93_out;
	notOp #(.WIDTH(1)) notOp_93(.in(notOp_93_in0), .out(notOp_93_out));

	wire [0:0] andOp_94_in0;
	wire [0:0] andOp_94_in1;
	wire [0:0] andOp_94_out;
	andOp #(.WIDTH(1)) andOp_94(.in0(andOp_94_in0), .in1(andOp_94_in1), .out(andOp_94_out));

	wire [0:0] notOp_95_in0;
	wire [0:0] notOp_95_out;
	notOp #(.WIDTH(1)) notOp_95(.in(notOp_95_in0), .out(notOp_95_out));

	wire [0:0] andOp_96_in0;
	wire [0:0] andOp_96_in1;
	wire [0:0] andOp_96_out;
	andOp #(.WIDTH(1)) andOp_96(.in0(andOp_96_in0), .in1(andOp_96_in1), .out(andOp_96_out));

	wire [0:0] notOp_97_in0;
	wire [0:0] notOp_97_out;
	notOp #(.WIDTH(1)) notOp_97(.in(notOp_97_in0), .out(notOp_97_out));

	wire [0:0] andOp_98_in0;
	wire [0:0] andOp_98_in1;
	wire [0:0] andOp_98_out;
	andOp #(.WIDTH(1)) andOp_98(.in0(andOp_98_in0), .in1(andOp_98_in1), .out(andOp_98_out));

	wire [0:0] notOp_99_in0;
	wire [0:0] notOp_99_out;
	notOp #(.WIDTH(1)) notOp_99(.in(notOp_99_in0), .out(notOp_99_out));

	wire [0:0] andOp_100_in0;
	wire [0:0] andOp_100_in1;
	wire [0:0] andOp_100_out;
	andOp #(.WIDTH(1)) andOp_100(.in0(andOp_100_in0), .in1(andOp_100_in1), .out(andOp_100_out));

	wire [0:0] notOp_101_in0;
	wire [0:0] notOp_101_out;
	notOp #(.WIDTH(1)) notOp_101(.in(notOp_101_in0), .out(notOp_101_out));

	wire [0:0] andOp_102_in0;
	wire [0:0] andOp_102_in1;
	wire [0:0] andOp_102_out;
	andOp #(.WIDTH(1)) andOp_102(.in0(andOp_102_in0), .in1(andOp_102_in1), .out(andOp_102_out));

	reg [0:0] in_pipeline_0_in_data;
	wire [0:0] in_pipeline_0_out_data;
	hls_wire #(.WIDTH(1)) in_pipeline_0(.in_data(in_pipeline_0_in_data), .out_data(in_pipeline_0_out_data));

	wire [0:0] orOp_103_in0;
	wire [0:0] orOp_103_in1;
	wire [0:0] orOp_103_out;
	orOp #(.WIDTH(1)) orOp_103(.in0(orOp_103_in0), .in1(orOp_103_in1), .out(orOp_103_out));

	wire [0:0] orOp_104_in0;
	wire [0:0] orOp_104_in1;
	wire [0:0] orOp_104_out;
	orOp #(.WIDTH(1)) orOp_104(.in0(orOp_104_in0), .in1(orOp_104_in1), .out(orOp_104_out));

	wire [0:0] orOp_105_in0;
	wire [0:0] orOp_105_in1;
	wire [0:0] orOp_105_out;
	orOp #(.WIDTH(1)) orOp_105(.in0(orOp_105_in0), .in1(orOp_105_in1), .out(orOp_105_out));

	wire [0:0] orOp_106_in0;
	wire [0:0] orOp_106_in1;
	wire [0:0] orOp_106_out;
	orOp #(.WIDTH(1)) orOp_106(.in0(orOp_106_in0), .in1(orOp_106_in1), .out(orOp_106_out));

	wire [0:0] orOp_107_in0;
	wire [0:0] orOp_107_in1;
	wire [0:0] orOp_107_out;
	orOp #(.WIDTH(1)) orOp_107(.in0(orOp_107_in0), .in1(orOp_107_in1), .out(orOp_107_out));

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

	wire [0:0] andOp_111_in0;
	wire [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	wire [0:0] andOp_112_in0;
	wire [0:0] andOp_112_in1;
	wire [0:0] andOp_112_out;
	andOp #(.WIDTH(1)) andOp_112(.in0(andOp_112_in0), .in1(andOp_112_in1), .out(andOp_112_out));

	wire [31:0] eq_113_in0;
	wire [31:0] eq_113_in1;
	wire [0:0] eq_113_out;
	eq #(.WIDTH(32)) eq_113(.in0(eq_113_in0), .in1(eq_113_in1), .out(eq_113_out));

	wire [31:0] eq_114_in0;
	wire [31:0] eq_114_in1;
	wire [0:0] eq_114_out;
	eq #(.WIDTH(32)) eq_114(.in0(eq_114_in0), .in1(eq_114_in1), .out(eq_114_out));

	wire [31:0] eq_115_in0;
	wire [31:0] eq_115_in1;
	wire [0:0] eq_115_out;
	eq #(.WIDTH(32)) eq_115(.in0(eq_115_in0), .in1(eq_115_in1), .out(eq_115_out));

	wire [31:0] eq_116_in0;
	wire [31:0] eq_116_in1;
	wire [0:0] eq_116_out;
	eq #(.WIDTH(32)) eq_116(.in0(eq_116_in0), .in1(eq_116_in1), .out(eq_116_out));

	wire [31:0] eq_117_in0;
	wire [31:0] eq_117_in1;
	wire [0:0] eq_117_out;
	eq #(.WIDTH(32)) eq_117(.in0(eq_117_in0), .in1(eq_117_in1), .out(eq_117_out));

	wire [31:0] eq_118_in0;
	wire [31:0] eq_118_in1;
	wire [0:0] eq_118_out;
	eq #(.WIDTH(32)) eq_118(.in0(eq_118_in0), .in1(eq_118_in1), .out(eq_118_out));

	wire [31:0] eq_119_in0;
	wire [31:0] eq_119_in1;
	wire [0:0] eq_119_out;
	eq #(.WIDTH(32)) eq_119(.in0(eq_119_in0), .in1(eq_119_in1), .out(eq_119_out));

	wire [31:0] eq_120_in0;
	wire [31:0] eq_120_in1;
	wire [0:0] eq_120_out;
	eq #(.WIDTH(32)) eq_120(.in0(eq_120_in0), .in1(eq_120_in1), .out(eq_120_out));

	wire [31:0] eq_121_in0;
	wire [31:0] eq_121_in1;
	wire [0:0] eq_121_out;
	eq #(.WIDTH(32)) eq_121(.in0(eq_121_in0), .in1(eq_121_in1), .out(eq_121_out));

	wire [31:0] eq_122_in0;
	wire [31:0] eq_122_in1;
	wire [0:0] eq_122_out;
	eq #(.WIDTH(32)) eq_122(.in0(eq_122_in0), .in1(eq_122_in1), .out(eq_122_out));

	wire [31:0] eq_123_in0;
	wire [31:0] eq_123_in1;
	wire [0:0] eq_123_out;
	eq #(.WIDTH(32)) eq_123(.in0(eq_123_in0), .in1(eq_123_in1), .out(eq_123_out));

	// End Functional Units

	reg [31:0] data_store_0_0;
	reg [31:0] data_store_1_2;
	reg [31:0] data_store_1_3;
	reg [31:0] global_state;
	reg [0:0] out_of_pipe_1_6;
	reg [0:0] out_of_pipe_bb_1_6;
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
	reg [31:0] state_6_entry_BB_reg;
	reg [0:0] state_6_is_active;
	reg [31:0] state_6_last_BB_reg;
	reg [31:0] state_6_last_state;

	// controller for add_add11.add_add11_in0
	// controller for add_add11.add_add11_in1
	// Insensitive connections
	assign add_add11_in0 = arg_0_rdata_0;
	assign add_add11_in1 = arg_1_rdata_0;
	// controller for add_add3.add_add3_in0
	// controller for add_add3.add_add3_in1
	// Insensitive connections
	assign add_add3_in0 = phi_phi2_out;
	assign add_add3_in1 = 32'd1;
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	assign andOp_10_in0 = andOp_8_out;
	assign andOp_10_in1 = icmp_icmp4_out;
	// controller for andOp_100.andOp_100_in0
	// controller for andOp_100.andOp_100_in1
	// Insensitive connections
	assign andOp_100_in0 = notOp_99_out;
	assign andOp_100_in1 = 1'd1;
	// controller for andOp_102.andOp_102_in0
	// controller for andOp_102.andOp_102_in1
	// Insensitive connections
	assign andOp_102_in0 = notOp_101_out;
	assign andOp_102_in1 = andOp_100_out;
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	assign andOp_111_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_111_in1 = state_1_is_active;
	// controller for andOp_112.andOp_112_in0
	// controller for andOp_112.andOp_112_in1
	// Insensitive connections
	assign andOp_112_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_112_in1 = state_1_is_active;
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
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	assign andOp_23_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_23_in1 = state_1_is_active;
	// controller for andOp_25.andOp_25_in0
	// controller for andOp_25.andOp_25_in1
	// Insensitive connections
	assign andOp_25_in0 = andOp_23_out;
	assign andOp_25_in1 = icmp_icmp4_out;
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	assign andOp_27_in0 = andOp_23_out;
	assign andOp_27_in1 = notOp_26_out;
	// controller for andOp_28.andOp_28_in0
	// controller for andOp_28.andOp_28_in1
	// Insensitive connections
	assign andOp_28_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_28_in1 = state_1_is_active;
	// controller for andOp_30.andOp_30_in0
	// controller for andOp_30.andOp_30_in1
	// Insensitive connections
	assign andOp_30_in0 = andOp_28_out;
	assign andOp_30_in1 = icmp_icmp4_out;
	// controller for andOp_32.andOp_32_in0
	// controller for andOp_32.andOp_32_in1
	// Insensitive connections
	assign andOp_32_in0 = andOp_28_out;
	assign andOp_32_in1 = notOp_31_out;
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	assign andOp_47_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_47_in1 = state_1_is_active;
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	assign andOp_48_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_48_in1 = state_2_is_active;
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	assign andOp_49_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_49_in1 = state_1_is_active;
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	assign andOp_52_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_52_in1 = state_1_is_active;
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	assign andOp_53_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_53_in1 = state_1_is_active;
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	assign andOp_54_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_54_in1 = state_1_is_active;
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	assign andOp_55_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_55_in1 = state_2_is_active;
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	assign andOp_56_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_56_in1 = state_2_is_active;
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	assign andOp_57_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_57_in1 = state_2_is_active;
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	assign andOp_58_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_58_in1 = state_2_is_active;
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	assign andOp_59_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_59_in1 = state_2_is_active;
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	assign andOp_6_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_6_in1 = state_0_is_active;
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	assign andOp_60_in0 = bb_2_active_in_state_6_out_data;
	assign andOp_60_in1 = state_6_is_active;
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
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	assign andOp_68_in0 = andOp_66_out;
	assign andOp_68_in1 = notOp_67_out;
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	assign andOp_69_in0 = in_pipeline_0_out_data;
	assign andOp_69_in1 = andOp_68_out;
	// controller for andOp_70.andOp_70_in0
	// controller for andOp_70.andOp_70_in1
	// Insensitive connections
	assign andOp_70_in0 = andOp_69_out;
	assign andOp_70_in1 = out_of_pipe_1_6;
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	assign andOp_71_in0 = andOp_69_out;
	assign andOp_71_in1 = out_of_pipe_1_6;
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	assign andOp_73_in0 = 1'd1;
	assign andOp_73_in1 = notOp_72_out;
	// controller for andOp_75.andOp_75_in0
	// controller for andOp_75.andOp_75_in1
	// Insensitive connections
	assign andOp_75_in0 = andOp_73_out;
	assign andOp_75_in1 = notOp_74_out;
	// controller for andOp_77.andOp_77_in0
	// controller for andOp_77.andOp_77_in1
	// Insensitive connections
	assign andOp_77_in0 = andOp_75_out;
	assign andOp_77_in1 = notOp_76_out;
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	assign andOp_79_in0 = andOp_77_out;
	assign andOp_79_in1 = notOp_78_out;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_8_in1 = state_1_is_active;
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	assign andOp_80_in0 = in_pipeline_0_out_data;
	assign andOp_80_in1 = andOp_79_out;
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	assign andOp_81_in0 = andOp_80_out;
	assign andOp_81_in1 = out_of_pipe_bb_1_6;
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	assign andOp_82_in0 = bb_1_active_in_state_1_out_data;
	assign andOp_82_in1 = state_1_is_active;
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	assign andOp_83_in0 = bb_1_active_in_state_2_out_data;
	assign andOp_83_in1 = state_2_is_active;
	// controller for andOp_84.andOp_84_in0
	// controller for andOp_84.andOp_84_in1
	// Insensitive connections
	assign andOp_84_in0 = bb_1_active_in_state_3_out_data;
	assign andOp_84_in1 = state_3_is_active;
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	assign andOp_85_in0 = bb_1_active_in_state_4_out_data;
	assign andOp_85_in1 = state_4_is_active;
	// controller for andOp_86.andOp_86_in0
	// controller for andOp_86.andOp_86_in1
	// Insensitive connections
	assign andOp_86_in0 = bb_2_active_in_state_6_out_data;
	assign andOp_86_in1 = state_6_is_active;
	// controller for andOp_88.andOp_88_in0
	// controller for andOp_88.andOp_88_in1
	// Insensitive connections
	assign andOp_88_in0 = notOp_87_out;
	assign andOp_88_in1 = 1'd1;
	// controller for andOp_90.andOp_90_in0
	// controller for andOp_90.andOp_90_in1
	// Insensitive connections
	assign andOp_90_in0 = notOp_89_out;
	assign andOp_90_in1 = andOp_88_out;
	// controller for andOp_92.andOp_92_in0
	// controller for andOp_92.andOp_92_in1
	// Insensitive connections
	assign andOp_92_in0 = notOp_91_out;
	assign andOp_92_in1 = 1'd1;
	// controller for andOp_94.andOp_94_in0
	// controller for andOp_94.andOp_94_in1
	// Insensitive connections
	assign andOp_94_in0 = notOp_93_out;
	assign andOp_94_in1 = 1'd1;
	// controller for andOp_96.andOp_96_in0
	// controller for andOp_96.andOp_96_in1
	// Insensitive connections
	assign andOp_96_in0 = notOp_95_out;
	assign andOp_96_in1 = 1'd1;
	// controller for andOp_98.andOp_98_in0
	// controller for andOp_98.andOp_98_in1
	// Insensitive connections
	assign andOp_98_in0 = notOp_97_out;
	assign andOp_98_in1 = 1'd1;
	// controller for arg_0.arg_0_raddr_0_reg
	always @(*) begin
		if (andOp_54_out) begin 
			arg_0_raddr_0_reg = phi_phi2_out;
		end else begin
			arg_0_raddr_0_reg = 0;
		end
	end
	// controller for arg_1.arg_1_raddr_0_reg
	always @(*) begin
		if (andOp_47_out) begin 
			arg_1_raddr_0_reg = phi_phi2_out;
		end else begin
			arg_1_raddr_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_waddr_0_reg
	always @(*) begin
		if (andOp_56_out) begin 
			arg_2_waddr_0_reg = data_in_2_5_out_data;
		end else begin
			arg_2_waddr_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_wdata_0_reg
	always @(*) begin
		if (andOp_57_out) begin 
			arg_2_wdata_0_reg = add_add11_out;
		end else begin
			arg_2_wdata_0_reg = 0;
		end
	end
	// controller for arg_2.arg_2_wen_0_reg
	always @(*) begin
		if (andOp_58_out) begin 
			arg_2_wen_0_reg = -(1'd1);
		end else begin
			arg_2_wen_0_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_33_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_40_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_1.bb_1_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_1_in_data = eq_34_out;
		end else begin
			bb_1_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_2.bb_1_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_2_in_data = eq_35_out;
		end else begin
			bb_1_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_3.bb_1_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_3_in_data = eq_36_out;
		end else begin
			bb_1_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = eq_37_out;
		end else begin
			bb_1_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_5.bb_1_active_in_state_5_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_5_in_data = eq_38_out;
		end else begin
			bb_1_active_in_state_5_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_1.bb_1_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_41_out) begin 
			bb_1_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_2.bb_1_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_42_out) begin 
			bb_1_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_3.bb_1_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_43_out) begin 
			bb_1_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_4.bb_1_predecessor_in_state_4_in_data
	always @(*) begin
		if (eq_44_out) begin 
			bb_1_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_5.bb_1_predecessor_in_state_5_in_data
	always @(*) begin
		if (eq_45_out) begin 
			bb_1_predecessor_in_state_5_in_data = state_5_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_5_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_6.bb_2_active_in_state_6_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_6_in_data = eq_39_out;
		end else begin
			bb_2_active_in_state_6_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_6.bb_2_predecessor_in_state_6_in_data
	always @(*) begin
		if (eq_46_out) begin 
			bb_2_predecessor_in_state_6_in_data = state_6_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_6_in_data = 0;
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
	// controller for br_1_happened_in_state_5.br_1_happened_in_state_5_in_data
	always @(*) begin
		if (andOp_28_out) begin 
			br_1_happened_in_state_5_in_data = 1'd1;
		end else if (notOp_29_out) begin 
			br_1_happened_in_state_5_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_5_in_data = 0;
		end
	end
	// controller for concat_50.concat_50_in0
	// controller for concat_50.concat_50_in1
	// Insensitive connections
	assign concat_50_in0 = data_in_1_4_out_data;
	assign concat_50_in1 = 32'd0;
	// controller for concat_51.concat_51_in0
	// controller for concat_51.concat_51_in1
	// Insensitive connections
	assign concat_51_in0 = 32'd1;
	assign concat_51_in1 = 32'd0;
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_108_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_1_4.data_in_1_4_in_data
	always @(*) begin
		if (eq_109_out) begin 
			data_in_1_4_in_data = data_store_0_0;
		end else if (eq_110_out) begin 
			data_in_1_4_in_data = data_store_1_3;
		end else begin
			data_in_1_4_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_113_out) begin 
			data_in_2_5_in_data = data_store_1_2;
		end else if (eq_114_out) begin 
			data_in_2_5_in_data = 32'd0;
		end else begin
			data_in_2_5_in_data = 0;
		end
	end
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	assign eq_108_in0 = 32'd0;
	assign eq_108_in1 = state_0_last_state;
	// controller for eq_109.eq_109_in0
	// controller for eq_109.eq_109_in1
	// Insensitive connections
	assign eq_109_in0 = 32'd0;
	assign eq_109_in1 = state_1_last_state;
	// controller for eq_110.eq_110_in0
	// controller for eq_110.eq_110_in1
	// Insensitive connections
	assign eq_110_in0 = 32'd1;
	assign eq_110_in1 = state_1_last_state;
	// controller for eq_113.eq_113_in0
	// controller for eq_113.eq_113_in1
	// Insensitive connections
	assign eq_113_in0 = 32'd1;
	assign eq_113_in1 = state_2_last_state;
	// controller for eq_114.eq_114_in0
	// controller for eq_114.eq_114_in1
	// Insensitive connections
	assign eq_114_in0 = 32'd2;
	assign eq_114_in1 = state_2_last_state;
	// controller for eq_115.eq_115_in0
	// controller for eq_115.eq_115_in1
	// Insensitive connections
	assign eq_115_in0 = 32'd2;
	assign eq_115_in1 = state_3_last_state;
	// controller for eq_116.eq_116_in0
	// controller for eq_116.eq_116_in1
	// Insensitive connections
	assign eq_116_in0 = 32'd3;
	assign eq_116_in1 = state_3_last_state;
	// controller for eq_117.eq_117_in0
	// controller for eq_117.eq_117_in1
	// Insensitive connections
	assign eq_117_in0 = 32'd3;
	assign eq_117_in1 = state_4_last_state;
	// controller for eq_118.eq_118_in0
	// controller for eq_118.eq_118_in1
	// Insensitive connections
	assign eq_118_in0 = 32'd4;
	assign eq_118_in1 = state_4_last_state;
	// controller for eq_119.eq_119_in0
	// controller for eq_119.eq_119_in1
	// Insensitive connections
	assign eq_119_in0 = 32'd4;
	assign eq_119_in1 = state_5_last_state;
	// controller for eq_120.eq_120_in0
	// controller for eq_120.eq_120_in1
	// Insensitive connections
	assign eq_120_in0 = 32'd5;
	assign eq_120_in1 = state_5_last_state;
	// controller for eq_121.eq_121_in0
	// controller for eq_121.eq_121_in1
	// Insensitive connections
	assign eq_121_in0 = 32'd1;
	assign eq_121_in1 = state_6_last_state;
	// controller for eq_122.eq_122_in0
	// controller for eq_122.eq_122_in1
	// Insensitive connections
	assign eq_122_in0 = 32'd5;
	assign eq_122_in1 = state_6_last_state;
	// controller for eq_123.eq_123_in0
	// controller for eq_123.eq_123_in1
	// Insensitive connections
	assign eq_123_in0 = 32'd6;
	assign eq_123_in1 = state_6_last_state;
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	assign eq_33_in0 = 32'd0;
	assign eq_33_in1 = state_0_entry_BB_reg;
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	assign eq_34_in0 = 32'd1;
	assign eq_34_in1 = state_1_entry_BB_reg;
	// controller for eq_35.eq_35_in0
	// controller for eq_35.eq_35_in1
	// Insensitive connections
	assign eq_35_in0 = 32'd1;
	assign eq_35_in1 = state_2_entry_BB_reg;
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	assign eq_36_in0 = 32'd1;
	assign eq_36_in1 = state_3_entry_BB_reg;
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	assign eq_37_in0 = 32'd1;
	assign eq_37_in1 = state_4_entry_BB_reg;
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	assign eq_38_in0 = 32'd1;
	assign eq_38_in1 = state_5_entry_BB_reg;
	// controller for eq_39.eq_39_in0
	// controller for eq_39.eq_39_in1
	// Insensitive connections
	assign eq_39_in0 = 32'd2;
	assign eq_39_in1 = state_6_entry_BB_reg;
	// controller for eq_40.eq_40_in0
	// controller for eq_40.eq_40_in1
	// Insensitive connections
	assign eq_40_in0 = 32'd0;
	assign eq_40_in1 = state_0_entry_BB_reg;
	// controller for eq_41.eq_41_in0
	// controller for eq_41.eq_41_in1
	// Insensitive connections
	assign eq_41_in0 = 32'd1;
	assign eq_41_in1 = state_1_entry_BB_reg;
	// controller for eq_42.eq_42_in0
	// controller for eq_42.eq_42_in1
	// Insensitive connections
	assign eq_42_in0 = 32'd1;
	assign eq_42_in1 = state_2_entry_BB_reg;
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	assign eq_43_in0 = 32'd1;
	assign eq_43_in1 = state_3_entry_BB_reg;
	// controller for eq_44.eq_44_in0
	// controller for eq_44.eq_44_in1
	// Insensitive connections
	assign eq_44_in0 = 32'd1;
	assign eq_44_in1 = state_4_entry_BB_reg;
	// controller for eq_45.eq_45_in0
	// controller for eq_45.eq_45_in1
	// Insensitive connections
	assign eq_45_in0 = 32'd1;
	assign eq_45_in1 = state_5_entry_BB_reg;
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	assign eq_46_in0 = 32'd2;
	assign eq_46_in1 = state_6_entry_BB_reg;
	// controller for icmp_icmp4.icmp_icmp4_in0
	// controller for icmp_icmp4.icmp_icmp4_in1
	// Insensitive connections
	assign icmp_icmp4_in0 = add_add3_out;
	assign icmp_icmp4_in1 = 32'd512;
	// controller for in_pipeline_0.in_pipeline_0_in_data
	always @(*) begin
		if (1'd1) begin 
			in_pipeline_0_in_data = orOp_107_out;
		end else begin
			in_pipeline_0_in_data = 0;
		end
	end
	// controller for notOp_101.notOp_101_in0
	// Insensitive connections
	assign notOp_101_in0 = andOp_86_out;
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
	// controller for notOp_24.notOp_24_in0
	// Insensitive connections
	assign notOp_24_in0 = andOp_23_out;
	// controller for notOp_26.notOp_26_in0
	// Insensitive connections
	assign notOp_26_in0 = icmp_icmp4_out;
	// controller for notOp_29.notOp_29_in0
	// Insensitive connections
	assign notOp_29_in0 = andOp_28_out;
	// controller for notOp_31.notOp_31_in0
	// Insensitive connections
	assign notOp_31_in0 = icmp_icmp4_out;
	// controller for notOp_61.notOp_61_in0
	// Insensitive connections
	assign notOp_61_in0 = state_1_is_active;
	// controller for notOp_63.notOp_63_in0
	// Insensitive connections
	assign notOp_63_in0 = state_2_is_active;
	// controller for notOp_65.notOp_65_in0
	// Insensitive connections
	assign notOp_65_in0 = state_3_is_active;
	// controller for notOp_67.notOp_67_in0
	// Insensitive connections
	assign notOp_67_in0 = state_4_is_active;
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	assign notOp_7_in0 = andOp_6_out;
	// controller for notOp_72.notOp_72_in0
	// Insensitive connections
	assign notOp_72_in0 = state_1_is_active;
	// controller for notOp_74.notOp_74_in0
	// Insensitive connections
	assign notOp_74_in0 = state_2_is_active;
	// controller for notOp_76.notOp_76_in0
	// Insensitive connections
	assign notOp_76_in0 = state_3_is_active;
	// controller for notOp_78.notOp_78_in0
	// Insensitive connections
	assign notOp_78_in0 = state_4_is_active;
	// controller for notOp_87.notOp_87_in0
	// Insensitive connections
	assign notOp_87_in0 = andOp_10_out;
	// controller for notOp_89.notOp_89_in0
	// Insensitive connections
	assign notOp_89_in0 = andOp_6_out;
	// controller for notOp_9.notOp_9_in0
	// Insensitive connections
	assign notOp_9_in0 = andOp_8_out;
	// controller for notOp_91.notOp_91_in0
	// Insensitive connections
	assign notOp_91_in0 = andOp_82_out;
	// controller for notOp_93.notOp_93_in0
	// Insensitive connections
	assign notOp_93_in0 = andOp_83_out;
	// controller for notOp_95.notOp_95_in0
	// Insensitive connections
	assign notOp_95_in0 = andOp_84_out;
	// controller for notOp_97.notOp_97_in0
	// Insensitive connections
	assign notOp_97_in0 = andOp_85_out;
	// controller for notOp_99.notOp_99_in0
	// Insensitive connections
	assign notOp_99_in0 = andOp_71_out;
	// controller for orOp_103.orOp_103_in0
	// controller for orOp_103.orOp_103_in1
	// Insensitive connections
	assign orOp_103_in0 = state_1_is_active;
	assign orOp_103_in1 = 1'd0;
	// controller for orOp_104.orOp_104_in0
	// controller for orOp_104.orOp_104_in1
	// Insensitive connections
	assign orOp_104_in0 = state_2_is_active;
	assign orOp_104_in1 = orOp_103_out;
	// controller for orOp_105.orOp_105_in0
	// controller for orOp_105.orOp_105_in1
	// Insensitive connections
	assign orOp_105_in0 = state_3_is_active;
	assign orOp_105_in1 = orOp_104_out;
	// controller for orOp_106.orOp_106_in0
	// controller for orOp_106.orOp_106_in1
	// Insensitive connections
	assign orOp_106_in0 = state_4_is_active;
	assign orOp_106_in1 = orOp_105_out;
	// controller for orOp_107.orOp_107_in0
	// controller for orOp_107.orOp_107_in1
	// Insensitive connections
	assign orOp_107_in0 = state_5_is_active;
	assign orOp_107_in1 = orOp_106_out;
	// controller for phi_phi2.phi_phi2_in
	// controller for phi_phi2.phi_phi2_last_block
	// controller for phi_phi2.phi_phi2_s
	// Insensitive connections
	assign phi_phi2_in = concat_50_out;
	assign phi_phi2_last_block = bb_1_predecessor_in_state_1_out_data;
	assign phi_phi2_s = concat_51_out;
	// controller for ret13.valid_reg
	always @(*) begin
		if (andOp_60_out) begin 
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
			if (andOp_111_out) begin
				data_store_1_2 <= phi_phi2_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_3 <= 0;
		end else begin
			if (andOp_112_out) begin
				data_store_1_3 <= add_add3_out;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_6_out) begin
				global_state <= 32'd200000;
			end
			if (andOp_70_out) begin
				global_state <= 32'd6;
			end
			if (andOp_86_out) begin
				global_state <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_1_6 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_1_6 <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			out_of_pipe_bb_1_6 <= 0;
		end else begin
			if (andOp_12_out) begin
				out_of_pipe_bb_1_6 <= 1'd1;
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
			if (andOp_6_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_90_out) begin
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
			if (andOp_82_out) begin
				state_2_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_82_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_92_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_82_out) begin
				state_2_last_BB_reg <= bb_1_predecessor_in_state_1_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_82_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_83_out) begin
				state_3_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_83_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_94_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_83_out) begin
				state_3_last_BB_reg <= bb_1_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_83_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_84_out) begin
				state_4_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_84_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_96_out) begin
				state_4_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_84_out) begin
				state_4_last_BB_reg <= bb_1_predecessor_in_state_3_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_state <= 0;
		end else begin
			if (andOp_84_out) begin
				state_4_last_state <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_entry_BB_reg <= 0;
		end else begin
			if (andOp_85_out) begin
				state_5_entry_BB_reg <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_is_active <= 0;
		end else begin
			if (andOp_85_out) begin
				state_5_is_active <= 1'd1;
			end
			if (andOp_98_out) begin
				state_5_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_last_BB_reg <= 0;
		end else begin
			if (andOp_85_out) begin
				state_5_last_BB_reg <= bb_1_predecessor_in_state_4_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_5_last_state <= 0;
		end else begin
			if (andOp_85_out) begin
				state_5_last_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_6_entry_BB_reg <= 0;
		end else begin
			if (andOp_81_out) begin
				state_6_entry_BB_reg <= 32'd2;
			end
			if (andOp_86_out) begin
				state_6_entry_BB_reg <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_6_is_active <= 0;
		end else begin
			if (andOp_102_out) begin
				state_6_is_active <= 1'd0;
			end
			if (andOp_71_out) begin
				state_6_is_active <= 1'd1;
			end
			if (andOp_86_out) begin
				state_6_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_6_last_BB_reg <= 0;
		end else begin
			if (andOp_12_out) begin
				state_6_last_BB_reg <= 32'd1;
			end
			if (andOp_86_out) begin
				state_6_last_BB_reg <= bb_2_predecessor_in_state_6_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_6_last_state <= 0;
		end else begin
			if (andOp_12_out) begin
				state_6_last_state <= 32'd1;
			end
			if (andOp_86_out) begin
				state_6_last_state <= 32'd6;
			end
		end
	end

endmodule

