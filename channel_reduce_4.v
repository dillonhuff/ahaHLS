module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [0:0] valid);

	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [0:0] valid_reg;

	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add alloca_0();

	add bitcast_1();

	add call_2();

	add call_26();

	reg [63:0] phi_in_phi_9;
	reg [31:0] phi_last_block_phi_9;
	reg [63:0] phi_s_phi_9;
	wire [31:0] phi_out_phi_9;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_9(.in(phi_in_phi_9), .last_block(phi_last_block_phi_9), .out(phi_out_phi_9), .s(phi_s_phi_9));

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

	reg [31:0] data_in_1_1_in_data;
	wire [31:0] data_in_1_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_1(.in_data(data_in_1_1_in_data), .out_data(data_in_1_1_out_data));

	reg [31:0] data_in_1_3_in_data;
	wire [31:0] data_in_1_3_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_3(.in_data(data_in_1_3_in_data), .out_data(data_in_1_3_out_data));

	reg [31:0] data_in_2_5_in_data;
	wire [31:0] data_in_2_5_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_5(.in_data(data_in_2_5_in_data), .out_data(data_in_2_5_out_data));

	reg [31:0] data_in_3_7_in_data;
	wire [31:0] data_in_3_7_out_data;
	hls_wire #(.WIDTH(32)) data_in_3_7(.in_data(data_in_3_7_in_data), .out_data(data_in_3_7_out_data));

	reg [31:0] data_in_3_9_in_data;
	wire [31:0] data_in_3_9_out_data;
	hls_wire #(.WIDTH(32)) data_in_3_9(.in_data(data_in_3_9_in_data), .out_data(data_in_3_9_out_data));

	reg [0:0] data_in_3_11_in_data;
	wire [0:0] data_in_3_11_out_data;
	hls_wire #(.WIDTH(1)) data_in_3_11(.in_data(data_in_3_11_in_data), .out_data(data_in_3_11_out_data));

	reg [31:0] data_in_4_13_in_data;
	wire [31:0] data_in_4_13_out_data;
	hls_wire #(.WIDTH(32)) data_in_4_13(.in_data(data_in_4_13_in_data), .out_data(data_in_4_13_out_data));

	reg [31:0] data_in_4_15_in_data;
	wire [31:0] data_in_4_15_out_data;
	hls_wire #(.WIDTH(32)) data_in_4_15(.in_data(data_in_4_15_in_data), .out_data(data_in_4_15_out_data));

	reg [0:0] data_in_4_17_in_data;
	wire [0:0] data_in_4_17_out_data;
	hls_wire #(.WIDTH(1)) data_in_4_17(.in_data(data_in_4_17_in_data), .out_data(data_in_4_17_out_data));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] bb_9_active_in_state_1_in_data;
	wire [0:0] bb_9_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_9_active_in_state_1(.in_data(bb_9_active_in_state_1_in_data), .out_data(bb_9_active_in_state_1_out_data));

	reg [31:0] bb_9_predecessor_in_state_1_in_data;
	wire [31:0] bb_9_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_9_predecessor_in_state_1(.in_data(bb_9_predecessor_in_state_1_in_data), .out_data(bb_9_predecessor_in_state_1_out_data));

	reg [0:0] bb_8_active_in_state_1_in_data;
	wire [0:0] bb_8_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_8_active_in_state_1(.in_data(bb_8_active_in_state_1_in_data), .out_data(bb_8_active_in_state_1_out_data));

	reg [31:0] bb_8_predecessor_in_state_1_in_data;
	wire [31:0] bb_8_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_8_predecessor_in_state_1(.in_data(bb_8_predecessor_in_state_1_in_data), .out_data(bb_8_predecessor_in_state_1_out_data));

	reg [0:0] bb_0_active_in_state_1_in_data;
	wire [0:0] bb_0_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_1(.in_data(bb_0_active_in_state_1_in_data), .out_data(bb_0_active_in_state_1_out_data));

	reg [31:0] bb_0_predecessor_in_state_1_in_data;
	wire [31:0] bb_0_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_1(.in_data(bb_0_predecessor_in_state_1_in_data), .out_data(bb_0_predecessor_in_state_1_out_data));

	reg [0:0] bb_3_active_in_state_1_in_data;
	wire [0:0] bb_3_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active_in_state_1(.in_data(bb_3_active_in_state_1_in_data), .out_data(bb_3_active_in_state_1_out_data));

	reg [31:0] bb_3_predecessor_in_state_1_in_data;
	wire [31:0] bb_3_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_3_predecessor_in_state_1(.in_data(bb_3_predecessor_in_state_1_in_data), .out_data(bb_3_predecessor_in_state_1_out_data));

	reg [0:0] bb_10_active_in_state_2_in_data;
	wire [0:0] bb_10_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active_in_state_2(.in_data(bb_10_active_in_state_2_in_data), .out_data(bb_10_active_in_state_2_out_data));

	reg [31:0] bb_10_predecessor_in_state_2_in_data;
	wire [31:0] bb_10_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor_in_state_2(.in_data(bb_10_predecessor_in_state_2_in_data), .out_data(bb_10_predecessor_in_state_2_out_data));

	reg [0:0] bb_10_active_in_state_3_in_data;
	wire [0:0] bb_10_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active_in_state_3(.in_data(bb_10_active_in_state_3_in_data), .out_data(bb_10_active_in_state_3_out_data));

	reg [31:0] bb_10_predecessor_in_state_3_in_data;
	wire [31:0] bb_10_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor_in_state_3(.in_data(bb_10_predecessor_in_state_3_in_data), .out_data(bb_10_predecessor_in_state_3_out_data));

	reg [0:0] bb_4_active_in_state_3_in_data;
	wire [0:0] bb_4_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_3(.in_data(bb_4_active_in_state_3_in_data), .out_data(bb_4_active_in_state_3_out_data));

	reg [31:0] bb_4_predecessor_in_state_3_in_data;
	wire [31:0] bb_4_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_3(.in_data(bb_4_predecessor_in_state_3_in_data), .out_data(bb_4_predecessor_in_state_3_out_data));

	reg [0:0] bb_2_active_in_state_4_in_data;
	wire [0:0] bb_2_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_4(.in_data(bb_2_active_in_state_4_in_data), .out_data(bb_2_active_in_state_4_out_data));

	reg [31:0] bb_2_predecessor_in_state_4_in_data;
	wire [31:0] bb_2_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_4(.in_data(bb_2_predecessor_in_state_4_in_data), .out_data(bb_2_predecessor_in_state_4_out_data));

	reg [0:0] bb_5_active_in_state_4_in_data;
	wire [0:0] bb_5_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_5_active_in_state_4(.in_data(bb_5_active_in_state_4_in_data), .out_data(bb_5_active_in_state_4_out_data));

	reg [31:0] bb_5_predecessor_in_state_4_in_data;
	wire [31:0] bb_5_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_5_predecessor_in_state_4(.in_data(bb_5_predecessor_in_state_4_in_data), .out_data(bb_5_predecessor_in_state_4_out_data));

	reg [0:0] bb_6_active_in_state_4_in_data;
	wire [0:0] bb_6_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_6_active_in_state_4(.in_data(bb_6_active_in_state_4_in_data), .out_data(bb_6_active_in_state_4_out_data));

	reg [31:0] bb_6_predecessor_in_state_4_in_data;
	wire [31:0] bb_6_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_6_predecessor_in_state_4(.in_data(bb_6_predecessor_in_state_4_in_data), .out_data(bb_6_predecessor_in_state_4_out_data));

	reg [0:0] bb_7_active_in_state_4_in_data;
	wire [0:0] bb_7_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_7_active_in_state_4(.in_data(bb_7_active_in_state_4_in_data), .out_data(bb_7_active_in_state_4_out_data));

	reg [31:0] bb_7_predecessor_in_state_4_in_data;
	wire [31:0] bb_7_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_7_predecessor_in_state_4(.in_data(bb_7_predecessor_in_state_4_in_data), .out_data(bb_7_predecessor_in_state_4_out_data));

	reg [0:0] bb_4_active_in_state_4_in_data;
	wire [0:0] bb_4_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_4(.in_data(bb_4_active_in_state_4_in_data), .out_data(bb_4_active_in_state_4_out_data));

	reg [31:0] bb_4_predecessor_in_state_4_in_data;
	wire [31:0] bb_4_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_4(.in_data(bb_4_predecessor_in_state_4_in_data), .out_data(bb_4_predecessor_in_state_4_out_data));

	reg [0:0] bb_1_active_in_state_4_in_data;
	wire [0:0] bb_1_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_4(.in_data(bb_1_active_in_state_4_in_data), .out_data(bb_1_active_in_state_4_out_data));

	reg [31:0] bb_1_predecessor_in_state_4_in_data;
	wire [31:0] bb_1_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_4(.in_data(bb_1_predecessor_in_state_4_in_data), .out_data(bb_1_predecessor_in_state_4_out_data));

	reg [0:0] andOp_18_in0;
	reg [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [0:0] andOp_19_in0;
	reg [0:0] andOp_19_in1;
	wire [0:0] andOp_19_out;
	andOp #(.WIDTH(1)) andOp_19(.in0(andOp_19_in0), .in1(andOp_19_in1), .out(andOp_19_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] notOp_20_in0;
	wire [0:0] notOp_20_out;
	notOp #(.WIDTH(1)) notOp_20(.in(notOp_20_in0), .out(notOp_20_out));

	reg [0:0] andOp_21_in0;
	reg [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [0:0] andOp_22_in0;
	reg [0:0] andOp_22_in1;
	wire [0:0] andOp_22_out;
	andOp #(.WIDTH(1)) andOp_22(.in0(andOp_22_in0), .in1(andOp_22_in1), .out(andOp_22_out));

	reg [0:0] br_9_happened_in_state_1_in_data;
	wire [0:0] br_9_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened_in_state_1(.in_data(br_9_happened_in_state_1_in_data), .out_data(br_9_happened_in_state_1_out_data));

	reg [0:0] notOp_23_in0;
	wire [0:0] notOp_23_out;
	notOp #(.WIDTH(1)) notOp_23(.in(notOp_23_in0), .out(notOp_23_out));

	reg [0:0] andOp_24_in0;
	reg [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

	reg [0:0] notOp_25_in0;
	wire [0:0] notOp_25_out;
	notOp #(.WIDTH(1)) notOp_25(.in(notOp_25_in0), .out(notOp_25_out));

	reg [0:0] andOp_26_in0;
	reg [0:0] andOp_26_in1;
	wire [0:0] andOp_26_out;
	andOp #(.WIDTH(1)) andOp_26(.in0(andOp_26_in0), .in1(andOp_26_in1), .out(andOp_26_out));

	reg [0:0] andOp_27_in0;
	reg [0:0] andOp_27_in1;
	wire [0:0] andOp_27_out;
	andOp #(.WIDTH(1)) andOp_27(.in0(andOp_27_in0), .in1(andOp_27_in1), .out(andOp_27_out));

	reg [0:0] andOp_28_in0;
	reg [0:0] andOp_28_in1;
	wire [0:0] andOp_28_out;
	andOp #(.WIDTH(1)) andOp_28(.in0(andOp_28_in0), .in1(andOp_28_in1), .out(andOp_28_out));

	reg [0:0] br_8_happened_in_state_1_in_data;
	wire [0:0] br_8_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened_in_state_1(.in_data(br_8_happened_in_state_1_in_data), .out_data(br_8_happened_in_state_1_out_data));

	reg [0:0] notOp_29_in0;
	wire [0:0] notOp_29_out;
	notOp #(.WIDTH(1)) notOp_29(.in(notOp_29_in0), .out(notOp_29_out));

	reg [0:0] andOp_30_in0;
	reg [0:0] andOp_30_in1;
	wire [0:0] andOp_30_out;
	andOp #(.WIDTH(1)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

	reg [0:0] andOp_31_in0;
	reg [0:0] andOp_31_in1;
	wire [0:0] andOp_31_out;
	andOp #(.WIDTH(1)) andOp_31(.in0(andOp_31_in0), .in1(andOp_31_in1), .out(andOp_31_out));

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	reg [0:0] notOp_32_in0;
	wire [0:0] notOp_32_out;
	notOp #(.WIDTH(1)) notOp_32(.in(notOp_32_in0), .out(notOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [0:0] andOp_34_in0;
	reg [0:0] andOp_34_in1;
	wire [0:0] andOp_34_out;
	andOp #(.WIDTH(1)) andOp_34(.in0(andOp_34_in0), .in1(andOp_34_in1), .out(andOp_34_out));

	reg [0:0] br_3_happened_in_state_1_in_data;
	wire [0:0] br_3_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_1(.in_data(br_3_happened_in_state_1_in_data), .out_data(br_3_happened_in_state_1_out_data));

	reg [0:0] notOp_35_in0;
	wire [0:0] notOp_35_out;
	notOp #(.WIDTH(1)) notOp_35(.in(notOp_35_in0), .out(notOp_35_out));

	reg [0:0] andOp_36_in0;
	reg [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	reg [0:0] andOp_37_in0;
	reg [0:0] andOp_37_in1;
	wire [0:0] andOp_37_out;
	andOp #(.WIDTH(1)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	reg [0:0] br_10_happened_in_state_2_in_data;
	wire [0:0] br_10_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_2(.in_data(br_10_happened_in_state_2_in_data), .out_data(br_10_happened_in_state_2_out_data));

	reg [0:0] notOp_38_in0;
	wire [0:0] notOp_38_out;
	notOp #(.WIDTH(1)) notOp_38(.in(notOp_38_in0), .out(notOp_38_out));

	reg [0:0] andOp_39_in0;
	reg [0:0] andOp_39_in1;
	wire [0:0] andOp_39_out;
	andOp #(.WIDTH(1)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	reg [0:0] andOp_40_in0;
	reg [0:0] andOp_40_in1;
	wire [0:0] andOp_40_out;
	andOp #(.WIDTH(1)) andOp_40(.in0(andOp_40_in0), .in1(andOp_40_in1), .out(andOp_40_out));

	reg [0:0] br_10_happened_in_state_3_in_data;
	wire [0:0] br_10_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_3(.in_data(br_10_happened_in_state_3_in_data), .out_data(br_10_happened_in_state_3_out_data));

	reg [0:0] notOp_41_in0;
	wire [0:0] notOp_41_out;
	notOp #(.WIDTH(1)) notOp_41(.in(notOp_41_in0), .out(notOp_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [0:0] andOp_43_in0;
	reg [0:0] andOp_43_in1;
	wire [0:0] andOp_43_out;
	andOp #(.WIDTH(1)) andOp_43(.in0(andOp_43_in0), .in1(andOp_43_in1), .out(andOp_43_out));

	reg [0:0] br_4_happened_in_state_3_in_data;
	wire [0:0] br_4_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_3(.in_data(br_4_happened_in_state_3_in_data), .out_data(br_4_happened_in_state_3_out_data));

	reg [0:0] notOp_44_in0;
	wire [0:0] notOp_44_out;
	notOp #(.WIDTH(1)) notOp_44(.in(notOp_44_in0), .out(notOp_44_out));

	reg [0:0] andOp_45_in0;
	reg [0:0] andOp_45_in1;
	wire [0:0] andOp_45_out;
	andOp #(.WIDTH(1)) andOp_45(.in0(andOp_45_in0), .in1(andOp_45_in1), .out(andOp_45_out));

	reg [0:0] notOp_46_in0;
	wire [0:0] notOp_46_out;
	notOp #(.WIDTH(1)) notOp_46(.in(notOp_46_in0), .out(notOp_46_out));

	reg [0:0] andOp_47_in0;
	reg [0:0] andOp_47_in1;
	wire [0:0] andOp_47_out;
	andOp #(.WIDTH(1)) andOp_47(.in0(andOp_47_in0), .in1(andOp_47_in1), .out(andOp_47_out));

	reg [0:0] andOp_48_in0;
	reg [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	reg [0:0] andOp_49_in0;
	reg [0:0] andOp_49_in1;
	wire [0:0] andOp_49_out;
	andOp #(.WIDTH(1)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

	reg [0:0] br_5_happened_in_state_4_in_data;
	wire [0:0] br_5_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened_in_state_4(.in_data(br_5_happened_in_state_4_in_data), .out_data(br_5_happened_in_state_4_out_data));

	reg [0:0] notOp_50_in0;
	wire [0:0] notOp_50_out;
	notOp #(.WIDTH(1)) notOp_50(.in(notOp_50_in0), .out(notOp_50_out));

	reg [0:0] andOp_51_in0;
	reg [0:0] andOp_51_in1;
	wire [0:0] andOp_51_out;
	andOp #(.WIDTH(1)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	reg [0:0] andOp_52_in0;
	reg [0:0] andOp_52_in1;
	wire [0:0] andOp_52_out;
	andOp #(.WIDTH(1)) andOp_52(.in0(andOp_52_in0), .in1(andOp_52_in1), .out(andOp_52_out));

	reg [0:0] br_6_happened_in_state_4_in_data;
	wire [0:0] br_6_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened_in_state_4(.in_data(br_6_happened_in_state_4_in_data), .out_data(br_6_happened_in_state_4_out_data));

	reg [0:0] notOp_53_in0;
	wire [0:0] notOp_53_out;
	notOp #(.WIDTH(1)) notOp_53(.in(notOp_53_in0), .out(notOp_53_out));

	reg [0:0] andOp_54_in0;
	reg [0:0] andOp_54_in1;
	wire [0:0] andOp_54_out;
	andOp #(.WIDTH(1)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	reg [0:0] notOp_55_in0;
	wire [0:0] notOp_55_out;
	notOp #(.WIDTH(1)) notOp_55(.in(notOp_55_in0), .out(notOp_55_out));

	reg [0:0] andOp_56_in0;
	reg [0:0] andOp_56_in1;
	wire [0:0] andOp_56_out;
	andOp #(.WIDTH(1)) andOp_56(.in0(andOp_56_in0), .in1(andOp_56_in1), .out(andOp_56_out));

	reg [0:0] andOp_57_in0;
	reg [0:0] andOp_57_in1;
	wire [0:0] andOp_57_out;
	andOp #(.WIDTH(1)) andOp_57(.in0(andOp_57_in0), .in1(andOp_57_in1), .out(andOp_57_out));

	reg [0:0] andOp_58_in0;
	reg [0:0] andOp_58_in1;
	wire [0:0] andOp_58_out;
	andOp #(.WIDTH(1)) andOp_58(.in0(andOp_58_in0), .in1(andOp_58_in1), .out(andOp_58_out));

	reg [0:0] br_7_happened_in_state_4_in_data;
	wire [0:0] br_7_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_4(.in_data(br_7_happened_in_state_4_in_data), .out_data(br_7_happened_in_state_4_out_data));

	reg [0:0] notOp_59_in0;
	wire [0:0] notOp_59_out;
	notOp #(.WIDTH(1)) notOp_59(.in(notOp_59_in0), .out(notOp_59_out));

	reg [0:0] andOp_60_in0;
	reg [0:0] andOp_60_in1;
	wire [0:0] andOp_60_out;
	andOp #(.WIDTH(1)) andOp_60(.in0(andOp_60_in0), .in1(andOp_60_in1), .out(andOp_60_out));

	reg [0:0] andOp_61_in0;
	reg [0:0] andOp_61_in1;
	wire [0:0] andOp_61_out;
	andOp #(.WIDTH(1)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

	reg [0:0] br_4_happened_in_state_4_in_data;
	wire [0:0] br_4_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_4(.in_data(br_4_happened_in_state_4_in_data), .out_data(br_4_happened_in_state_4_out_data));

	reg [0:0] notOp_62_in0;
	wire [0:0] notOp_62_out;
	notOp #(.WIDTH(1)) notOp_62(.in(notOp_62_in0), .out(notOp_62_out));

	reg [0:0] andOp_63_in0;
	reg [0:0] andOp_63_in1;
	wire [0:0] andOp_63_out;
	andOp #(.WIDTH(1)) andOp_63(.in0(andOp_63_in0), .in1(andOp_63_in1), .out(andOp_63_out));

	reg [0:0] notOp_64_in0;
	wire [0:0] notOp_64_out;
	notOp #(.WIDTH(1)) notOp_64(.in(notOp_64_in0), .out(notOp_64_out));

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

	reg [0:0] br_1_happened_in_state_4_in_data;
	wire [0:0] br_1_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_4(.in_data(br_1_happened_in_state_4_in_data), .out_data(br_1_happened_in_state_4_out_data));

	reg [0:0] notOp_68_in0;
	wire [0:0] notOp_68_out;
	notOp #(.WIDTH(1)) notOp_68(.in(notOp_68_in0), .out(notOp_68_out));

	reg [31:0] eq_69_in0;
	reg [31:0] eq_69_in1;
	wire [0:0] eq_69_out;
	eq #(.WIDTH(32)) eq_69(.in0(eq_69_in0), .in1(eq_69_in1), .out(eq_69_out));

	reg [31:0] eq_70_in0;
	reg [31:0] eq_70_in1;
	wire [0:0] eq_70_out;
	eq #(.WIDTH(32)) eq_70(.in0(eq_70_in0), .in1(eq_70_in1), .out(eq_70_out));

	reg [0:0] orOp_71_in0;
	reg [0:0] orOp_71_in1;
	wire [0:0] orOp_71_out;
	orOp #(.WIDTH(1)) orOp_71(.in0(orOp_71_in0), .in1(orOp_71_in1), .out(orOp_71_out));

	reg [31:0] eq_72_in0;
	reg [31:0] eq_72_in1;
	wire [0:0] eq_72_out;
	eq #(.WIDTH(32)) eq_72(.in0(eq_72_in0), .in1(eq_72_in1), .out(eq_72_out));

	reg [0:0] orOp_73_in0;
	reg [0:0] orOp_73_in1;
	wire [0:0] orOp_73_out;
	orOp #(.WIDTH(1)) orOp_73(.in0(orOp_73_in0), .in1(orOp_73_in1), .out(orOp_73_out));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	reg [31:0] eq_75_in0;
	reg [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

	reg [0:0] orOp_76_in0;
	reg [0:0] orOp_76_in1;
	wire [0:0] orOp_76_out;
	orOp #(.WIDTH(1)) orOp_76(.in0(orOp_76_in0), .in1(orOp_76_in1), .out(orOp_76_out));

	reg [31:0] eq_77_in0;
	reg [31:0] eq_77_in1;
	wire [0:0] eq_77_out;
	eq #(.WIDTH(32)) eq_77(.in0(eq_77_in0), .in1(eq_77_in1), .out(eq_77_out));

	reg [31:0] eq_78_in0;
	reg [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	reg [31:0] eq_79_in0;
	reg [31:0] eq_79_in1;
	wire [0:0] eq_79_out;
	eq #(.WIDTH(32)) eq_79(.in0(eq_79_in0), .in1(eq_79_in1), .out(eq_79_out));

	reg [0:0] orOp_80_in0;
	reg [0:0] orOp_80_in1;
	wire [0:0] orOp_80_out;
	orOp #(.WIDTH(1)) orOp_80(.in0(orOp_80_in0), .in1(orOp_80_in1), .out(orOp_80_out));

	reg [31:0] eq_81_in0;
	reg [31:0] eq_81_in1;
	wire [0:0] eq_81_out;
	eq #(.WIDTH(32)) eq_81(.in0(eq_81_in0), .in1(eq_81_in1), .out(eq_81_out));

	reg [0:0] orOp_82_in0;
	reg [0:0] orOp_82_in1;
	wire [0:0] orOp_82_out;
	orOp #(.WIDTH(1)) orOp_82(.in0(orOp_82_in0), .in1(orOp_82_in1), .out(orOp_82_out));

	reg [31:0] eq_83_in0;
	reg [31:0] eq_83_in1;
	wire [0:0] eq_83_out;
	eq #(.WIDTH(32)) eq_83(.in0(eq_83_in0), .in1(eq_83_in1), .out(eq_83_out));

	reg [0:0] orOp_84_in0;
	reg [0:0] orOp_84_in1;
	wire [0:0] orOp_84_out;
	orOp #(.WIDTH(1)) orOp_84(.in0(orOp_84_in0), .in1(orOp_84_in1), .out(orOp_84_out));

	reg [31:0] eq_85_in0;
	reg [31:0] eq_85_in1;
	wire [0:0] eq_85_out;
	eq #(.WIDTH(32)) eq_85(.in0(eq_85_in0), .in1(eq_85_in1), .out(eq_85_out));

	reg [0:0] orOp_86_in0;
	reg [0:0] orOp_86_in1;
	wire [0:0] orOp_86_out;
	orOp #(.WIDTH(1)) orOp_86(.in0(orOp_86_in0), .in1(orOp_86_in1), .out(orOp_86_out));

	reg [31:0] eq_87_in0;
	reg [31:0] eq_87_in1;
	wire [0:0] eq_87_out;
	eq #(.WIDTH(32)) eq_87(.in0(eq_87_in0), .in1(eq_87_in1), .out(eq_87_out));

	reg [0:0] orOp_88_in0;
	reg [0:0] orOp_88_in1;
	wire [0:0] orOp_88_out;
	orOp #(.WIDTH(1)) orOp_88(.in0(orOp_88_in0), .in1(orOp_88_in1), .out(orOp_88_out));

	reg [31:0] eq_89_in0;
	reg [31:0] eq_89_in1;
	wire [0:0] eq_89_out;
	eq #(.WIDTH(32)) eq_89(.in0(eq_89_in0), .in1(eq_89_in1), .out(eq_89_out));

	reg [31:0] eq_90_in0;
	reg [31:0] eq_90_in1;
	wire [0:0] eq_90_out;
	eq #(.WIDTH(32)) eq_90(.in0(eq_90_in0), .in1(eq_90_in1), .out(eq_90_out));

	reg [0:0] orOp_91_in0;
	reg [0:0] orOp_91_in1;
	wire [0:0] orOp_91_out;
	orOp #(.WIDTH(1)) orOp_91(.in0(orOp_91_in0), .in1(orOp_91_in1), .out(orOp_91_out));

	reg [31:0] eq_92_in0;
	reg [31:0] eq_92_in1;
	wire [0:0] eq_92_out;
	eq #(.WIDTH(32)) eq_92(.in0(eq_92_in0), .in1(eq_92_in1), .out(eq_92_out));

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

	reg [31:0] eq_96_in0;
	reg [31:0] eq_96_in1;
	wire [0:0] eq_96_out;
	eq #(.WIDTH(32)) eq_96(.in0(eq_96_in0), .in1(eq_96_in1), .out(eq_96_out));

	reg [0:0] notOp_97_in0;
	wire [0:0] notOp_97_out;
	notOp #(.WIDTH(1)) notOp_97(.in(notOp_97_in0), .out(notOp_97_out));

	reg [0:0] andOp_98_in0;
	reg [0:0] andOp_98_in1;
	wire [0:0] andOp_98_out;
	andOp #(.WIDTH(1)) andOp_98(.in0(andOp_98_in0), .in1(andOp_98_in1), .out(andOp_98_out));

	reg [31:0] eq_99_in0;
	reg [31:0] eq_99_in1;
	wire [0:0] eq_99_out;
	eq #(.WIDTH(32)) eq_99(.in0(eq_99_in0), .in1(eq_99_in1), .out(eq_99_out));

	reg [31:0] eq_100_in0;
	reg [31:0] eq_100_in1;
	wire [0:0] eq_100_out;
	eq #(.WIDTH(32)) eq_100(.in0(eq_100_in0), .in1(eq_100_in1), .out(eq_100_out));

	reg [0:0] notOp_101_in0;
	wire [0:0] notOp_101_out;
	notOp #(.WIDTH(1)) notOp_101(.in(notOp_101_in0), .out(notOp_101_out));

	reg [0:0] andOp_102_in0;
	reg [0:0] andOp_102_in1;
	wire [0:0] andOp_102_out;
	andOp #(.WIDTH(1)) andOp_102(.in0(andOp_102_in0), .in1(andOp_102_in1), .out(andOp_102_out));

	reg [31:0] eq_103_in0;
	reg [31:0] eq_103_in1;
	wire [0:0] eq_103_out;
	eq #(.WIDTH(32)) eq_103(.in0(eq_103_in0), .in1(eq_103_in1), .out(eq_103_out));

	reg [31:0] eq_104_in0;
	reg [31:0] eq_104_in1;
	wire [0:0] eq_104_out;
	eq #(.WIDTH(32)) eq_104(.in0(eq_104_in0), .in1(eq_104_in1), .out(eq_104_out));

	reg [31:0] eq_105_in0;
	reg [31:0] eq_105_in1;
	wire [0:0] eq_105_out;
	eq #(.WIDTH(32)) eq_105(.in0(eq_105_in0), .in1(eq_105_in1), .out(eq_105_out));

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

	reg [0:0] notOp_109_in0;
	wire [0:0] notOp_109_out;
	notOp #(.WIDTH(1)) notOp_109(.in(notOp_109_in0), .out(notOp_109_out));

	reg [0:0] andOp_110_in0;
	reg [0:0] andOp_110_in1;
	wire [0:0] andOp_110_out;
	andOp #(.WIDTH(1)) andOp_110(.in0(andOp_110_in0), .in1(andOp_110_in1), .out(andOp_110_out));

	reg [31:0] eq_111_in0;
	reg [31:0] eq_111_in1;
	wire [0:0] eq_111_out;
	eq #(.WIDTH(32)) eq_111(.in0(eq_111_in0), .in1(eq_111_in1), .out(eq_111_out));

	reg [0:0] notOp_112_in0;
	wire [0:0] notOp_112_out;
	notOp #(.WIDTH(1)) notOp_112(.in(notOp_112_in0), .out(notOp_112_out));

	reg [0:0] andOp_113_in0;
	reg [0:0] andOp_113_in1;
	wire [0:0] andOp_113_out;
	andOp #(.WIDTH(1)) andOp_113(.in0(andOp_113_in0), .in1(andOp_113_in1), .out(andOp_113_out));

	reg [31:0] eq_114_in0;
	reg [31:0] eq_114_in1;
	wire [0:0] eq_114_out;
	eq #(.WIDTH(32)) eq_114(.in0(eq_114_in0), .in1(eq_114_in1), .out(eq_114_out));

	reg [0:0] notOp_115_in0;
	wire [0:0] notOp_115_out;
	notOp #(.WIDTH(1)) notOp_115(.in(notOp_115_in0), .out(notOp_115_out));

	reg [0:0] andOp_116_in0;
	reg [0:0] andOp_116_in1;
	wire [0:0] andOp_116_out;
	andOp #(.WIDTH(1)) andOp_116(.in0(andOp_116_in0), .in1(andOp_116_in1), .out(andOp_116_out));

	reg [31:0] eq_117_in0;
	reg [31:0] eq_117_in1;
	wire [0:0] eq_117_out;
	eq #(.WIDTH(32)) eq_117(.in0(eq_117_in0), .in1(eq_117_in1), .out(eq_117_out));

	reg [0:0] notOp_118_in0;
	wire [0:0] notOp_118_out;
	notOp #(.WIDTH(1)) notOp_118(.in(notOp_118_in0), .out(notOp_118_out));

	reg [0:0] andOp_119_in0;
	reg [0:0] andOp_119_in1;
	wire [0:0] andOp_119_out;
	andOp #(.WIDTH(1)) andOp_119(.in0(andOp_119_in0), .in1(andOp_119_in1), .out(andOp_119_out));

	reg [31:0] eq_120_in0;
	reg [31:0] eq_120_in1;
	wire [0:0] eq_120_out;
	eq #(.WIDTH(32)) eq_120(.in0(eq_120_in0), .in1(eq_120_in1), .out(eq_120_out));

	reg [31:0] eq_121_in0;
	reg [31:0] eq_121_in1;
	wire [0:0] eq_121_out;
	eq #(.WIDTH(32)) eq_121(.in0(eq_121_in0), .in1(eq_121_in1), .out(eq_121_out));

	reg [0:0] notOp_122_in0;
	wire [0:0] notOp_122_out;
	notOp #(.WIDTH(1)) notOp_122(.in(notOp_122_in0), .out(notOp_122_out));

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

	reg [0:0] andOp_126_in0;
	reg [0:0] andOp_126_in1;
	wire [0:0] andOp_126_out;
	andOp #(.WIDTH(1)) andOp_126(.in0(andOp_126_in0), .in1(andOp_126_in1), .out(andOp_126_out));

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

	reg [0:0] andOp_134_in0;
	reg [0:0] andOp_134_in1;
	wire [0:0] andOp_134_out;
	andOp #(.WIDTH(1)) andOp_134(.in0(andOp_134_in0), .in1(andOp_134_in1), .out(andOp_134_out));

	reg [31:0] concat_135_in0;
	reg [31:0] concat_135_in1;
	wire [63:0] concat_135_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_135(.in0(concat_135_in0), .in1(concat_135_in1), .out(concat_135_out));

	reg [31:0] concat_136_in0;
	reg [31:0] concat_136_in1;
	wire [63:0] concat_136_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_136(.in0(concat_136_in0), .in1(concat_136_in1), .out(concat_136_out));

	reg [0:0] andOp_137_in0;
	reg [0:0] andOp_137_in1;
	wire [0:0] andOp_137_out;
	andOp #(.WIDTH(1)) andOp_137(.in0(andOp_137_in0), .in1(andOp_137_in1), .out(andOp_137_out));

	reg [31:0] tmp_output_138_in_data;
	wire [31:0] tmp_output_138_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_138(.in_data(tmp_output_138_in_data), .out_data(tmp_output_138_out_data));

	reg [31:0] eq_139_in0;
	reg [31:0] eq_139_in1;
	wire [0:0] eq_139_out;
	eq #(.WIDTH(32)) eq_139(.in0(eq_139_in0), .in1(eq_139_in1), .out(eq_139_out));

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

	reg [0:0] andOp_147_in0;
	reg [0:0] andOp_147_in1;
	wire [0:0] andOp_147_out;
	andOp #(.WIDTH(1)) andOp_147(.in0(andOp_147_in0), .in1(andOp_147_in1), .out(andOp_147_out));

	reg [0:0] andOp_148_in0;
	reg [0:0] andOp_148_in1;
	wire [0:0] andOp_148_out;
	andOp #(.WIDTH(1)) andOp_148(.in0(andOp_148_in0), .in1(andOp_148_in1), .out(andOp_148_out));

	reg [0:0] andOp_149_in0;
	reg [0:0] andOp_149_in1;
	wire [0:0] andOp_149_out;
	andOp #(.WIDTH(1)) andOp_149(.in0(andOp_149_in0), .in1(andOp_149_in1), .out(andOp_149_out));

	reg [0:0] andOp_150_in0;
	reg [0:0] andOp_150_in1;
	wire [0:0] andOp_150_out;
	andOp #(.WIDTH(1)) andOp_150(.in0(andOp_150_in0), .in1(andOp_150_in1), .out(andOp_150_out));

	reg [0:0] notOp_151_in0;
	wire [0:0] notOp_151_out;
	notOp #(.WIDTH(1)) notOp_151(.in(notOp_151_in0), .out(notOp_151_out));

	reg [0:0] andOp_152_in0;
	reg [0:0] andOp_152_in1;
	wire [0:0] andOp_152_out;
	andOp #(.WIDTH(1)) andOp_152(.in0(andOp_152_in0), .in1(andOp_152_in1), .out(andOp_152_out));

	reg [0:0] notOp_153_in0;
	wire [0:0] notOp_153_out;
	notOp #(.WIDTH(1)) notOp_153(.in(notOp_153_in0), .out(notOp_153_out));

	reg [0:0] andOp_154_in0;
	reg [0:0] andOp_154_in1;
	wire [0:0] andOp_154_out;
	andOp #(.WIDTH(1)) andOp_154(.in0(andOp_154_in0), .in1(andOp_154_in1), .out(andOp_154_out));

	reg [0:0] notOp_155_in0;
	wire [0:0] notOp_155_out;
	notOp #(.WIDTH(1)) notOp_155(.in(notOp_155_in0), .out(notOp_155_out));

	reg [0:0] andOp_156_in0;
	reg [0:0] andOp_156_in1;
	wire [0:0] andOp_156_out;
	andOp #(.WIDTH(1)) andOp_156(.in0(andOp_156_in0), .in1(andOp_156_in1), .out(andOp_156_out));

	reg [0:0] notOp_157_in0;
	wire [0:0] notOp_157_out;
	notOp #(.WIDTH(1)) notOp_157(.in(notOp_157_in0), .out(notOp_157_out));

	reg [0:0] andOp_158_in0;
	reg [0:0] andOp_158_in1;
	wire [0:0] andOp_158_out;
	andOp #(.WIDTH(1)) andOp_158(.in0(andOp_158_in0), .in1(andOp_158_in1), .out(andOp_158_out));

	reg [0:0] notOp_159_in0;
	wire [0:0] notOp_159_out;
	notOp #(.WIDTH(1)) notOp_159(.in(notOp_159_in0), .out(notOp_159_out));

	reg [0:0] andOp_160_in0;
	reg [0:0] andOp_160_in1;
	wire [0:0] andOp_160_out;
	andOp #(.WIDTH(1)) andOp_160(.in0(andOp_160_in0), .in1(andOp_160_in1), .out(andOp_160_out));

	reg [0:0] notOp_161_in0;
	wire [0:0] notOp_161_out;
	notOp #(.WIDTH(1)) notOp_161(.in(notOp_161_in0), .out(notOp_161_out));

	reg [0:0] andOp_162_in0;
	reg [0:0] andOp_162_in1;
	wire [0:0] andOp_162_out;
	andOp #(.WIDTH(1)) andOp_162(.in0(andOp_162_in0), .in1(andOp_162_in1), .out(andOp_162_out));

	reg [0:0] notOp_163_in0;
	wire [0:0] notOp_163_out;
	notOp #(.WIDTH(1)) notOp_163(.in(notOp_163_in0), .out(notOp_163_out));

	reg [0:0] andOp_164_in0;
	reg [0:0] andOp_164_in1;
	wire [0:0] andOp_164_out;
	andOp #(.WIDTH(1)) andOp_164(.in0(andOp_164_in0), .in1(andOp_164_in1), .out(andOp_164_out));

	reg [0:0] notOp_165_in0;
	wire [0:0] notOp_165_out;
	notOp #(.WIDTH(1)) notOp_165(.in(notOp_165_in0), .out(notOp_165_out));

	reg [0:0] andOp_166_in0;
	reg [0:0] andOp_166_in1;
	wire [0:0] andOp_166_out;
	andOp #(.WIDTH(1)) andOp_166(.in0(andOp_166_in0), .in1(andOp_166_in1), .out(andOp_166_out));

	reg [31:0] eq_167_in0;
	reg [31:0] eq_167_in1;
	wire [0:0] eq_167_out;
	eq #(.WIDTH(32)) eq_167(.in0(eq_167_in0), .in1(eq_167_in1), .out(eq_167_out));

	reg [31:0] eq_168_in0;
	reg [31:0] eq_168_in1;
	wire [0:0] eq_168_out;
	eq #(.WIDTH(32)) eq_168(.in0(eq_168_in0), .in1(eq_168_in1), .out(eq_168_out));

	reg [31:0] eq_169_in0;
	reg [31:0] eq_169_in1;
	wire [0:0] eq_169_out;
	eq #(.WIDTH(32)) eq_169(.in0(eq_169_in0), .in1(eq_169_in1), .out(eq_169_out));

	reg [31:0] eq_170_in0;
	reg [31:0] eq_170_in1;
	wire [0:0] eq_170_out;
	eq #(.WIDTH(32)) eq_170(.in0(eq_170_in0), .in1(eq_170_in1), .out(eq_170_out));

	reg [0:0] andOp_171_in0;
	reg [0:0] andOp_171_in1;
	wire [0:0] andOp_171_out;
	andOp #(.WIDTH(1)) andOp_171(.in0(andOp_171_in0), .in1(andOp_171_in1), .out(andOp_171_out));

	reg [31:0] eq_172_in0;
	reg [31:0] eq_172_in1;
	wire [0:0] eq_172_out;
	eq #(.WIDTH(32)) eq_172(.in0(eq_172_in0), .in1(eq_172_in1), .out(eq_172_out));

	reg [31:0] eq_173_in0;
	reg [31:0] eq_173_in1;
	wire [0:0] eq_173_out;
	eq #(.WIDTH(32)) eq_173(.in0(eq_173_in0), .in1(eq_173_in1), .out(eq_173_out));

	reg [31:0] eq_174_in0;
	reg [31:0] eq_174_in1;
	wire [0:0] eq_174_out;
	eq #(.WIDTH(32)) eq_174(.in0(eq_174_in0), .in1(eq_174_in1), .out(eq_174_out));

	reg [31:0] eq_175_in0;
	reg [31:0] eq_175_in1;
	wire [0:0] eq_175_out;
	eq #(.WIDTH(32)) eq_175(.in0(eq_175_in0), .in1(eq_175_in1), .out(eq_175_out));

	reg [0:0] andOp_176_in0;
	reg [0:0] andOp_176_in1;
	wire [0:0] andOp_176_out;
	andOp #(.WIDTH(1)) andOp_176(.in0(andOp_176_in0), .in1(andOp_176_in1), .out(andOp_176_out));

	reg [0:0] andOp_177_in0;
	reg [0:0] andOp_177_in1;
	wire [0:0] andOp_177_out;
	andOp #(.WIDTH(1)) andOp_177(.in0(andOp_177_in0), .in1(andOp_177_in1), .out(andOp_177_out));

	reg [31:0] eq_178_in0;
	reg [31:0] eq_178_in1;
	wire [0:0] eq_178_out;
	eq #(.WIDTH(32)) eq_178(.in0(eq_178_in0), .in1(eq_178_in1), .out(eq_178_out));

	reg [31:0] eq_179_in0;
	reg [31:0] eq_179_in1;
	wire [0:0] eq_179_out;
	eq #(.WIDTH(32)) eq_179(.in0(eq_179_in0), .in1(eq_179_in1), .out(eq_179_out));

	// End Functional Units

	reg [31:0] data_store_1_0;
	reg [31:0] data_store_1_2;
	reg [31:0] data_store_2_4;
	reg [0:0] data_store_3_10;
	reg [31:0] data_store_3_6;
	reg [31:0] data_store_3_8;
	reg [31:0] data_store_4_12;
	reg [31:0] data_store_4_14;
	reg [0:0] data_store_4_16;
	reg [31:0] global_state;
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

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? rdata_ram_0 : rdata_ram_0;
		add_in1_add_14 = valid ? tmp_output_138_out_data : tmp_output_138_out_data;
	end
	// controller for add_add_16.add_in0_add_16
	// controller for add_add_16.add_in1_add_16
	// Insensitive connections
	always @(*) begin
		add_in0_add_16 = valid ? data_in_3_7_out_data : data_in_3_7_out_data;
		add_in1_add_16 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_102.andOp_102_in0
	// controller for andOp_102.andOp_102_in1
	// Insensitive connections
	always @(*) begin
		andOp_102_in0 = valid ? notOp_101_out : notOp_101_out;
		andOp_102_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	always @(*) begin
		andOp_107_in0 = valid ? notOp_106_out : notOp_106_out;
		andOp_107_in1 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for andOp_110.andOp_110_in0
	// controller for andOp_110.andOp_110_in1
	// Insensitive connections
	always @(*) begin
		andOp_110_in0 = valid ? notOp_109_out : notOp_109_out;
		andOp_110_in1 = valid ? andOp_58_out : andOp_58_out;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? notOp_112_out : notOp_112_out;
		andOp_113_in1 = valid ? andOp_67_out : andOp_67_out;
	end
	// controller for andOp_116.andOp_116_in0
	// controller for andOp_116.andOp_116_in1
	// Insensitive connections
	always @(*) begin
		andOp_116_in0 = valid ? notOp_115_out : notOp_115_out;
		andOp_116_in1 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? notOp_118_out : notOp_118_out;
		andOp_119_in1 = valid ? andOp_54_out : andOp_54_out;
	end
	// controller for andOp_123.andOp_123_in0
	// controller for andOp_123.andOp_123_in1
	// Insensitive connections
	always @(*) begin
		andOp_123_in0 = valid ? notOp_122_out : notOp_122_out;
		andOp_123_in1 = valid ? andOp_45_out : andOp_45_out;
	end
	// controller for andOp_124.andOp_124_in0
	// controller for andOp_124.andOp_124_in1
	// Insensitive connections
	always @(*) begin
		andOp_124_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_124_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_125_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_126.andOp_126_in0
	// controller for andOp_126.andOp_126_in1
	// Insensitive connections
	always @(*) begin
		andOp_126_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_126_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_127.andOp_127_in0
	// controller for andOp_127.andOp_127_in1
	// Insensitive connections
	always @(*) begin
		andOp_127_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_127_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_128_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	always @(*) begin
		andOp_129_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_129_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_130_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_131.andOp_131_in0
	// controller for andOp_131.andOp_131_in1
	// Insensitive connections
	always @(*) begin
		andOp_131_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_131_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_132.andOp_132_in0
	// controller for andOp_132.andOp_132_in1
	// Insensitive connections
	always @(*) begin
		andOp_132_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_132_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_133_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_134.andOp_134_in0
	// controller for andOp_134.andOp_134_in1
	// Insensitive connections
	always @(*) begin
		andOp_134_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_134_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_137.andOp_137_in0
	// controller for andOp_137.andOp_137_in1
	// Insensitive connections
	always @(*) begin
		andOp_137_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_137_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_140.andOp_140_in0
	// controller for andOp_140.andOp_140_in1
	// Insensitive connections
	always @(*) begin
		andOp_140_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_140_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_141_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_142_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_143.andOp_143_in0
	// controller for andOp_143.andOp_143_in1
	// Insensitive connections
	always @(*) begin
		andOp_143_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_143_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_144_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_145_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_146.andOp_146_in0
	// controller for andOp_146.andOp_146_in1
	// Insensitive connections
	always @(*) begin
		andOp_146_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_146_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_147.andOp_147_in0
	// controller for andOp_147.andOp_147_in1
	// Insensitive connections
	always @(*) begin
		andOp_147_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_147_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_148.andOp_148_in0
	// controller for andOp_148.andOp_148_in1
	// Insensitive connections
	always @(*) begin
		andOp_148_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_148_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_149.andOp_149_in0
	// controller for andOp_149.andOp_149_in1
	// Insensitive connections
	always @(*) begin
		andOp_149_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_149_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_150.andOp_150_in0
	// controller for andOp_150.andOp_150_in1
	// Insensitive connections
	always @(*) begin
		andOp_150_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_150_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? notOp_151_out : notOp_151_out;
		andOp_152_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_154.andOp_154_in0
	// controller for andOp_154.andOp_154_in1
	// Insensitive connections
	always @(*) begin
		andOp_154_in0 = valid ? notOp_153_out : notOp_153_out;
		andOp_154_in1 = valid ? andOp_152_out : andOp_152_out;
	end
	// controller for andOp_156.andOp_156_in0
	// controller for andOp_156.andOp_156_in1
	// Insensitive connections
	always @(*) begin
		andOp_156_in0 = valid ? notOp_155_out : notOp_155_out;
		andOp_156_in1 = valid ? andOp_154_out : andOp_154_out;
	end
	// controller for andOp_158.andOp_158_in0
	// controller for andOp_158.andOp_158_in1
	// Insensitive connections
	always @(*) begin
		andOp_158_in0 = valid ? notOp_157_out : notOp_157_out;
		andOp_158_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_160.andOp_160_in0
	// controller for andOp_160.andOp_160_in1
	// Insensitive connections
	always @(*) begin
		andOp_160_in0 = valid ? notOp_159_out : notOp_159_out;
		andOp_160_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_162.andOp_162_in0
	// controller for andOp_162.andOp_162_in1
	// Insensitive connections
	always @(*) begin
		andOp_162_in0 = valid ? notOp_161_out : notOp_161_out;
		andOp_162_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_164.andOp_164_in0
	// controller for andOp_164.andOp_164_in1
	// Insensitive connections
	always @(*) begin
		andOp_164_in0 = valid ? notOp_163_out : notOp_163_out;
		andOp_164_in1 = valid ? andOp_162_out : andOp_162_out;
	end
	// controller for andOp_166.andOp_166_in0
	// controller for andOp_166.andOp_166_in1
	// Insensitive connections
	always @(*) begin
		andOp_166_in0 = valid ? notOp_165_out : notOp_165_out;
		andOp_166_in1 = valid ? andOp_164_out : andOp_164_out;
	end
	// controller for andOp_171.andOp_171_in0
	// controller for andOp_171.andOp_171_in1
	// Insensitive connections
	always @(*) begin
		andOp_171_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_171_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_176.andOp_176_in0
	// controller for andOp_176.andOp_176_in1
	// Insensitive connections
	always @(*) begin
		andOp_176_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_176_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_177.andOp_177_in0
	// controller for andOp_177.andOp_177_in1
	// Insensitive connections
	always @(*) begin
		andOp_177_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_177_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_18_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_19.andOp_19_in0
	// controller for andOp_19.andOp_19_in1
	// Insensitive connections
	always @(*) begin
		andOp_19_in0 = valid ? andOp_18_out : andOp_18_out;
		andOp_19_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_21.andOp_21_in0
	// controller for andOp_21.andOp_21_in1
	// Insensitive connections
	always @(*) begin
		andOp_21_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_21_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_24_in0 = valid ? andOp_22_out : andOp_22_out;
		andOp_24_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_26.andOp_26_in0
	// controller for andOp_26.andOp_26_in1
	// Insensitive connections
	always @(*) begin
		andOp_26_in0 = valid ? andOp_22_out : andOp_22_out;
		andOp_26_in1 = valid ? notOp_25_out : notOp_25_out;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? bb_8_active_in_state_1_out_data : bb_8_active_in_state_1_out_data;
		andOp_27_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_30_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_30_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_33_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_33_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_36_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_36_in1 = valid ? state_3_is_active : state_3_is_active;
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
		andOp_39_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_39_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_40.andOp_40_in0
	// controller for andOp_40.andOp_40_in1
	// Insensitive connections
	always @(*) begin
		andOp_40_in0 = valid ? andOp_39_out : andOp_39_out;
		andOp_40_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_42_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_43.andOp_43_in0
	// controller for andOp_43.andOp_43_in1
	// Insensitive connections
	always @(*) begin
		andOp_43_in0 = valid ? andOp_42_out : andOp_42_out;
		andOp_43_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? andOp_43_out : andOp_43_out;
		andOp_45_in1 = valid ? data_in_4_17_out_data : data_in_4_17_out_data;
	end
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	always @(*) begin
		andOp_47_in0 = valid ? andOp_43_out : andOp_43_out;
		andOp_47_in1 = valid ? notOp_46_out : notOp_46_out;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? bb_5_active_in_state_4_out_data : bb_5_active_in_state_4_out_data;
		andOp_48_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? andOp_48_out : andOp_48_out;
		andOp_49_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_51_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_52.andOp_52_in0
	// controller for andOp_52.andOp_52_in1
	// Insensitive connections
	always @(*) begin
		andOp_52_in0 = valid ? andOp_51_out : andOp_51_out;
		andOp_52_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? andOp_52_out : andOp_52_out;
		andOp_54_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? andOp_52_out : andOp_52_out;
		andOp_56_in1 = valid ? notOp_55_out : notOp_55_out;
	end
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	always @(*) begin
		andOp_57_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_57_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_58.andOp_58_in0
	// controller for andOp_58.andOp_58_in1
	// Insensitive connections
	always @(*) begin
		andOp_58_in0 = valid ? andOp_57_out : andOp_57_out;
		andOp_58_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_60.andOp_60_in0
	// controller for andOp_60.andOp_60_in1
	// Insensitive connections
	always @(*) begin
		andOp_60_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_60_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	always @(*) begin
		andOp_61_in0 = valid ? andOp_60_out : andOp_60_out;
		andOp_61_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? andOp_61_out : andOp_61_out;
		andOp_63_in1 = valid ? data_in_4_17_out_data : data_in_4_17_out_data;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? andOp_61_out : andOp_61_out;
		andOp_65_in1 = valid ? notOp_64_out : notOp_64_out;
	end
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? bb_1_active_in_state_4_out_data : bb_1_active_in_state_4_out_data;
		andOp_66_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_67.andOp_67_in0
	// controller for andOp_67.andOp_67_in1
	// Insensitive connections
	always @(*) begin
		andOp_67_in0 = valid ? andOp_66_out : andOp_66_out;
		andOp_67_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_95.andOp_95_in0
	// controller for andOp_95.andOp_95_in1
	// Insensitive connections
	always @(*) begin
		andOp_95_in0 = valid ? notOp_94_out : notOp_94_out;
		andOp_95_in1 = valid ? andOp_28_out : andOp_28_out;
	end
	// controller for andOp_98.andOp_98_in0
	// controller for andOp_98.andOp_98_in1
	// Insensitive connections
	always @(*) begin
		andOp_98_in0 = valid ? notOp_97_out : notOp_97_out;
		andOp_98_in1 = valid ? andOp_34_out : andOp_34_out;
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_69_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_74_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_92_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_99_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_2.bb_10_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_2_in_data = eq_77_out;
		end else begin
			bb_10_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_3.bb_10_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_3_in_data = eq_78_out;
		end else begin
			bb_10_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_2.bb_10_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_103_out) begin 
			bb_10_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_3.bb_10_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_104_out) begin 
			bb_10_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = orOp_91_out;
		end else begin
			bb_1_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_4.bb_1_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_123_out) begin 
			bb_1_predecessor_in_state_4_in_data = 32'd4;
		end else if (eq_121_out) begin 
			bb_1_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_4.bb_2_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_4_in_data = orOp_82_out;
		end else begin
			bb_2_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_4.bb_2_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_110_out) begin 
			bb_2_predecessor_in_state_4_in_data = 32'd7;
		end else if (eq_108_out) begin 
			bb_2_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_1.bb_3_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_1_in_data = orOp_76_out;
		end else begin
			bb_3_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_1.bb_3_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_102_out) begin 
			bb_3_predecessor_in_state_1_in_data = 32'd0;
		end else if (eq_100_out) begin 
			bb_3_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_3.bb_4_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_3_in_data = orOp_80_out;
		end else begin
			bb_4_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_4.bb_4_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_4_in_data = eq_89_out;
		end else begin
			bb_4_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_3.bb_4_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_107_out) begin 
			bb_4_predecessor_in_state_3_in_data = 32'd10;
		end else if (eq_105_out) begin 
			bb_4_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_4.bb_4_predecessor_in_state_4_in_data
	always @(*) begin
		if (eq_120_out) begin 
			bb_4_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_active_in_state_4.bb_5_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_state_4_in_data = orOp_84_out;
		end else begin
			bb_5_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_predecessor_in_state_4.bb_5_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_113_out) begin 
			bb_5_predecessor_in_state_4_in_data = 32'd1;
		end else if (eq_111_out) begin 
			bb_5_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_5_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_active_in_state_4.bb_6_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_state_4_in_data = orOp_86_out;
		end else begin
			bb_6_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_predecessor_in_state_4.bb_6_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_116_out) begin 
			bb_6_predecessor_in_state_4_in_data = 32'd5;
		end else if (eq_114_out) begin 
			bb_6_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_6_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_4.bb_7_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_4_in_data = orOp_88_out;
		end else begin
			bb_7_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_predecessor_in_state_4.bb_7_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_119_out) begin 
			bb_7_predecessor_in_state_4_in_data = 32'd6;
		end else if (eq_117_out) begin 
			bb_7_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_7_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_8_active_in_state_1.bb_8_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_8_active_in_state_1_in_data = orOp_73_out;
		end else begin
			bb_8_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_8_predecessor_in_state_1.bb_8_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_98_out) begin 
			bb_8_predecessor_in_state_1_in_data = 32'd3;
		end else if (eq_96_out) begin 
			bb_8_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_8_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_active_in_state_1.bb_9_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_state_1_in_data = orOp_71_out;
		end else begin
			bb_9_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_predecessor_in_state_1.bb_9_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_95_out) begin 
			bb_9_predecessor_in_state_1_in_data = 32'd8;
		end else if (eq_93_out) begin 
			bb_9_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_9_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_19_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_20_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_31_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_32_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_2.br_10_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_37_out) begin 
			br_10_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_38_out) begin 
			br_10_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_3.br_10_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_40_out) begin 
			br_10_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_41_out) begin 
			br_10_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_4.br_1_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_67_out) begin 
			br_1_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_68_out) begin 
			br_1_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_3_happened_in_state_1.br_3_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_34_out) begin 
			br_3_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_35_out) begin 
			br_3_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_3.br_4_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_43_out) begin 
			br_4_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_44_out) begin 
			br_4_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_4.br_4_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_61_out) begin 
			br_4_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_62_out) begin 
			br_4_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_5_happened_in_state_4.br_5_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_49_out) begin 
			br_5_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_50_out) begin 
			br_5_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_5_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_6_happened_in_state_4.br_6_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_52_out) begin 
			br_6_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_53_out) begin 
			br_6_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_6_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_4.br_7_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_58_out) begin 
			br_7_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_59_out) begin 
			br_7_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_8_happened_in_state_1.br_8_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_28_out) begin 
			br_8_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_29_out) begin 
			br_8_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_8_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_9_happened_in_state_1.br_9_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_22_out) begin 
			br_9_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_23_out) begin 
			br_9_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_9_happened_in_state_1_in_data = 0;
		end
	end
	// controller for concat_135.concat_135_in0
	// controller for concat_135.concat_135_in1
	// Insensitive connections
	always @(*) begin
		concat_135_in0 = valid ? data_in_1_3_out_data : data_in_1_3_out_data;
		concat_135_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_136.concat_136_in0
	// controller for concat_136.concat_136_in1
	// Insensitive connections
	always @(*) begin
		concat_136_in0 = valid ? 32'd4 : 32'd4;
		concat_136_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for data_in_1_1.data_in_1_1_in_data
	always @(*) begin
		if (eq_168_out) begin 
			data_in_1_1_in_data = 32'd0;
		end else if (eq_169_out) begin 
			data_in_1_1_in_data = data_store_1_0;
		end else if (eq_170_out) begin 
			data_in_1_1_in_data = data_store_4_12;
		end else begin
			data_in_1_1_in_data = 0;
		end
	end
	// controller for data_in_1_3.data_in_1_3_in_data
	always @(*) begin
		if (eq_168_out) begin 
			data_in_1_3_in_data = 32'd0;
		end else if (eq_169_out) begin 
			data_in_1_3_in_data = data_store_1_2;
		end else if (eq_170_out) begin 
			data_in_1_3_in_data = data_store_4_14;
		end else begin
			data_in_1_3_in_data = 0;
		end
	end
	// controller for data_in_2_5.data_in_2_5_in_data
	always @(*) begin
		if (eq_172_out) begin 
			data_in_2_5_in_data = data_store_1_0;
		end else if (eq_173_out) begin 
			data_in_2_5_in_data = data_store_2_4;
		end else begin
			data_in_2_5_in_data = 0;
		end
	end
	// controller for data_in_3_11.data_in_3_11_in_data
	always @(*) begin
		if (eq_174_out) begin 
			data_in_3_11_in_data = 1'd0;
		end else if (eq_175_out) begin 
			data_in_3_11_in_data = data_store_3_10;
		end else begin
			data_in_3_11_in_data = 0;
		end
	end
	// controller for data_in_3_7.data_in_3_7_in_data
	always @(*) begin
		if (eq_174_out) begin 
			data_in_3_7_in_data = data_store_2_4;
		end else if (eq_175_out) begin 
			data_in_3_7_in_data = data_store_3_6;
		end else begin
			data_in_3_7_in_data = 0;
		end
	end
	// controller for data_in_3_9.data_in_3_9_in_data
	always @(*) begin
		if (eq_174_out) begin 
			data_in_3_9_in_data = 32'd0;
		end else if (eq_175_out) begin 
			data_in_3_9_in_data = data_store_3_8;
		end else begin
			data_in_3_9_in_data = 0;
		end
	end
	// controller for data_in_4_13.data_in_4_13_in_data
	always @(*) begin
		if (eq_178_out) begin 
			data_in_4_13_in_data = data_store_3_6;
		end else if (eq_179_out) begin 
			data_in_4_13_in_data = data_store_4_12;
		end else begin
			data_in_4_13_in_data = 0;
		end
	end
	// controller for data_in_4_15.data_in_4_15_in_data
	always @(*) begin
		if (eq_178_out) begin 
			data_in_4_15_in_data = data_store_3_8;
		end else if (eq_179_out) begin 
			data_in_4_15_in_data = data_store_4_14;
		end else begin
			data_in_4_15_in_data = 0;
		end
	end
	// controller for data_in_4_17.data_in_4_17_in_data
	always @(*) begin
		if (eq_178_out) begin 
			data_in_4_17_in_data = data_store_3_10;
		end else if (eq_179_out) begin 
			data_in_4_17_in_data = data_store_4_16;
		end else begin
			data_in_4_17_in_data = 0;
		end
	end
	// controller for eq_100.eq_100_in0
	// controller for eq_100.eq_100_in1
	// Insensitive connections
	always @(*) begin
		eq_100_in0 = valid ? 32'd3 : 32'd3;
		eq_100_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_103.eq_103_in0
	// controller for eq_103.eq_103_in1
	// Insensitive connections
	always @(*) begin
		eq_103_in0 = valid ? 32'd10 : 32'd10;
		eq_103_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_104.eq_104_in0
	// controller for eq_104.eq_104_in1
	// Insensitive connections
	always @(*) begin
		eq_104_in0 = valid ? 32'd10 : 32'd10;
		eq_104_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_105.eq_105_in0
	// controller for eq_105.eq_105_in1
	// Insensitive connections
	always @(*) begin
		eq_105_in0 = valid ? 32'd4 : 32'd4;
		eq_105_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	always @(*) begin
		eq_108_in0 = valid ? 32'd2 : 32'd2;
		eq_108_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_111.eq_111_in0
	// controller for eq_111.eq_111_in1
	// Insensitive connections
	always @(*) begin
		eq_111_in0 = valid ? 32'd5 : 32'd5;
		eq_111_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_114.eq_114_in0
	// controller for eq_114.eq_114_in1
	// Insensitive connections
	always @(*) begin
		eq_114_in0 = valid ? 32'd6 : 32'd6;
		eq_114_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_117.eq_117_in0
	// controller for eq_117.eq_117_in1
	// Insensitive connections
	always @(*) begin
		eq_117_in0 = valid ? 32'd7 : 32'd7;
		eq_117_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_120.eq_120_in0
	// controller for eq_120.eq_120_in1
	// Insensitive connections
	always @(*) begin
		eq_120_in0 = valid ? 32'd4 : 32'd4;
		eq_120_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_121.eq_121_in0
	// controller for eq_121.eq_121_in1
	// Insensitive connections
	always @(*) begin
		eq_121_in0 = valid ? 32'd1 : 32'd1;
		eq_121_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_139.eq_139_in0
	// controller for eq_139.eq_139_in1
	// Insensitive connections
	always @(*) begin
		eq_139_in0 = valid ? 32'd10 : 32'd10;
		eq_139_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_167.eq_167_in0
	// controller for eq_167.eq_167_in1
	// Insensitive connections
	always @(*) begin
		eq_167_in0 = valid ? 32'd0 : 32'd0;
		eq_167_in1 = valid ? state_0_last_state : state_0_last_state;
	end
	// controller for eq_168.eq_168_in0
	// controller for eq_168.eq_168_in1
	// Insensitive connections
	always @(*) begin
		eq_168_in0 = valid ? 32'd0 : 32'd0;
		eq_168_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_169.eq_169_in0
	// controller for eq_169.eq_169_in1
	// Insensitive connections
	always @(*) begin
		eq_169_in0 = valid ? 32'd1 : 32'd1;
		eq_169_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_170.eq_170_in0
	// controller for eq_170.eq_170_in1
	// Insensitive connections
	always @(*) begin
		eq_170_in0 = valid ? 32'd4 : 32'd4;
		eq_170_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_172.eq_172_in0
	// controller for eq_172.eq_172_in1
	// Insensitive connections
	always @(*) begin
		eq_172_in0 = valid ? 32'd1 : 32'd1;
		eq_172_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_173.eq_173_in0
	// controller for eq_173.eq_173_in1
	// Insensitive connections
	always @(*) begin
		eq_173_in0 = valid ? 32'd2 : 32'd2;
		eq_173_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_174.eq_174_in0
	// controller for eq_174.eq_174_in1
	// Insensitive connections
	always @(*) begin
		eq_174_in0 = valid ? 32'd2 : 32'd2;
		eq_174_in1 = valid ? state_3_last_state : state_3_last_state;
	end
	// controller for eq_175.eq_175_in0
	// controller for eq_175.eq_175_in1
	// Insensitive connections
	always @(*) begin
		eq_175_in0 = valid ? 32'd3 : 32'd3;
		eq_175_in1 = valid ? state_3_last_state : state_3_last_state;
	end
	// controller for eq_178.eq_178_in0
	// controller for eq_178.eq_178_in1
	// Insensitive connections
	always @(*) begin
		eq_178_in0 = valid ? 32'd3 : 32'd3;
		eq_178_in1 = valid ? state_4_last_state : state_4_last_state;
	end
	// controller for eq_179.eq_179_in0
	// controller for eq_179.eq_179_in1
	// Insensitive connections
	always @(*) begin
		eq_179_in0 = valid ? 32'd4 : 32'd4;
		eq_179_in1 = valid ? state_4_last_state : state_4_last_state;
	end
	// controller for eq_69.eq_69_in0
	// controller for eq_69.eq_69_in1
	// Insensitive connections
	always @(*) begin
		eq_69_in0 = valid ? 32'd0 : 32'd0;
		eq_69_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd9 : 32'd9;
		eq_70_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	always @(*) begin
		eq_72_in0 = valid ? 32'd8 : 32'd8;
		eq_72_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd0 : 32'd0;
		eq_74_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	always @(*) begin
		eq_75_in0 = valid ? 32'd3 : 32'd3;
		eq_75_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_77.eq_77_in0
	// controller for eq_77.eq_77_in1
	// Insensitive connections
	always @(*) begin
		eq_77_in0 = valid ? 32'd10 : 32'd10;
		eq_77_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd10 : 32'd10;
		eq_78_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_79.eq_79_in0
	// controller for eq_79.eq_79_in1
	// Insensitive connections
	always @(*) begin
		eq_79_in0 = valid ? 32'd4 : 32'd4;
		eq_79_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_81.eq_81_in0
	// controller for eq_81.eq_81_in1
	// Insensitive connections
	always @(*) begin
		eq_81_in0 = valid ? 32'd2 : 32'd2;
		eq_81_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_83.eq_83_in0
	// controller for eq_83.eq_83_in1
	// Insensitive connections
	always @(*) begin
		eq_83_in0 = valid ? 32'd5 : 32'd5;
		eq_83_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_85.eq_85_in0
	// controller for eq_85.eq_85_in1
	// Insensitive connections
	always @(*) begin
		eq_85_in0 = valid ? 32'd6 : 32'd6;
		eq_85_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	always @(*) begin
		eq_87_in0 = valid ? 32'd7 : 32'd7;
		eq_87_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_89.eq_89_in0
	// controller for eq_89.eq_89_in1
	// Insensitive connections
	always @(*) begin
		eq_89_in0 = valid ? 32'd4 : 32'd4;
		eq_89_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd1 : 32'd1;
		eq_90_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_92.eq_92_in0
	// controller for eq_92.eq_92_in1
	// Insensitive connections
	always @(*) begin
		eq_92_in0 = valid ? 32'd0 : 32'd0;
		eq_92_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_93.eq_93_in0
	// controller for eq_93.eq_93_in1
	// Insensitive connections
	always @(*) begin
		eq_93_in0 = valid ? 32'd9 : 32'd9;
		eq_93_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_96.eq_96_in0
	// controller for eq_96.eq_96_in1
	// Insensitive connections
	always @(*) begin
		eq_96_in0 = valid ? 32'd8 : 32'd8;
		eq_96_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_99.eq_99_in0
	// controller for eq_99.eq_99_in1
	// Insensitive connections
	always @(*) begin
		eq_99_in0 = valid ? 32'd0 : 32'd0;
		eq_99_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
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
		if (andOp_132_out) begin 
			in_read_valid_reg = -(1'd1);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_101.notOp_101_in0
	// Insensitive connections
	always @(*) begin
		notOp_101_in0 = valid ? eq_100_out : eq_100_out;
	end
	// controller for notOp_106.notOp_106_in0
	// Insensitive connections
	always @(*) begin
		notOp_106_in0 = valid ? eq_105_out : eq_105_out;
	end
	// controller for notOp_109.notOp_109_in0
	// Insensitive connections
	always @(*) begin
		notOp_109_in0 = valid ? eq_108_out : eq_108_out;
	end
	// controller for notOp_112.notOp_112_in0
	// Insensitive connections
	always @(*) begin
		notOp_112_in0 = valid ? eq_111_out : eq_111_out;
	end
	// controller for notOp_115.notOp_115_in0
	// Insensitive connections
	always @(*) begin
		notOp_115_in0 = valid ? eq_114_out : eq_114_out;
	end
	// controller for notOp_118.notOp_118_in0
	// Insensitive connections
	always @(*) begin
		notOp_118_in0 = valid ? eq_117_out : eq_117_out;
	end
	// controller for notOp_122.notOp_122_in0
	// Insensitive connections
	always @(*) begin
		notOp_122_in0 = valid ? eq_121_out : eq_121_out;
	end
	// controller for notOp_151.notOp_151_in0
	// Insensitive connections
	always @(*) begin
		notOp_151_in0 = valid ? andOp_147_out : andOp_147_out;
	end
	// controller for notOp_153.notOp_153_in0
	// Insensitive connections
	always @(*) begin
		notOp_153_in0 = valid ? andOp_26_out : andOp_26_out;
	end
	// controller for notOp_155.notOp_155_in0
	// Insensitive connections
	always @(*) begin
		notOp_155_in0 = valid ? andOp_47_out : andOp_47_out;
	end
	// controller for notOp_157.notOp_157_in0
	// Insensitive connections
	always @(*) begin
		notOp_157_in0 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for notOp_159.notOp_159_in0
	// Insensitive connections
	always @(*) begin
		notOp_159_in0 = valid ? andOp_148_out : andOp_148_out;
	end
	// controller for notOp_161.notOp_161_in0
	// Insensitive connections
	always @(*) begin
		notOp_161_in0 = valid ? andOp_149_out : andOp_149_out;
	end
	// controller for notOp_163.notOp_163_in0
	// Insensitive connections
	always @(*) begin
		notOp_163_in0 = valid ? andOp_150_out : andOp_150_out;
	end
	// controller for notOp_165.notOp_165_in0
	// Insensitive connections
	always @(*) begin
		notOp_165_in0 = valid ? andOp_56_out : andOp_56_out;
	end
	// controller for notOp_20.notOp_20_in0
	// Insensitive connections
	always @(*) begin
		notOp_20_in0 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for notOp_23.notOp_23_in0
	// Insensitive connections
	always @(*) begin
		notOp_23_in0 = valid ? andOp_22_out : andOp_22_out;
	end
	// controller for notOp_25.notOp_25_in0
	// Insensitive connections
	always @(*) begin
		notOp_25_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_29.notOp_29_in0
	// Insensitive connections
	always @(*) begin
		notOp_29_in0 = valid ? andOp_28_out : andOp_28_out;
	end
	// controller for notOp_32.notOp_32_in0
	// Insensitive connections
	always @(*) begin
		notOp_32_in0 = valid ? andOp_31_out : andOp_31_out;
	end
	// controller for notOp_35.notOp_35_in0
	// Insensitive connections
	always @(*) begin
		notOp_35_in0 = valid ? andOp_34_out : andOp_34_out;
	end
	// controller for notOp_38.notOp_38_in0
	// Insensitive connections
	always @(*) begin
		notOp_38_in0 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for notOp_41.notOp_41_in0
	// Insensitive connections
	always @(*) begin
		notOp_41_in0 = valid ? andOp_40_out : andOp_40_out;
	end
	// controller for notOp_44.notOp_44_in0
	// Insensitive connections
	always @(*) begin
		notOp_44_in0 = valid ? andOp_43_out : andOp_43_out;
	end
	// controller for notOp_46.notOp_46_in0
	// Insensitive connections
	always @(*) begin
		notOp_46_in0 = valid ? data_in_4_17_out_data : data_in_4_17_out_data;
	end
	// controller for notOp_50.notOp_50_in0
	// Insensitive connections
	always @(*) begin
		notOp_50_in0 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for notOp_53.notOp_53_in0
	// Insensitive connections
	always @(*) begin
		notOp_53_in0 = valid ? andOp_52_out : andOp_52_out;
	end
	// controller for notOp_55.notOp_55_in0
	// Insensitive connections
	always @(*) begin
		notOp_55_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for notOp_59.notOp_59_in0
	// Insensitive connections
	always @(*) begin
		notOp_59_in0 = valid ? andOp_58_out : andOp_58_out;
	end
	// controller for notOp_62.notOp_62_in0
	// Insensitive connections
	always @(*) begin
		notOp_62_in0 = valid ? andOp_61_out : andOp_61_out;
	end
	// controller for notOp_64.notOp_64_in0
	// Insensitive connections
	always @(*) begin
		notOp_64_in0 = valid ? data_in_4_17_out_data : data_in_4_17_out_data;
	end
	// controller for notOp_68.notOp_68_in0
	// Insensitive connections
	always @(*) begin
		notOp_68_in0 = valid ? andOp_67_out : andOp_67_out;
	end
	// controller for notOp_94.notOp_94_in0
	// Insensitive connections
	always @(*) begin
		notOp_94_in0 = valid ? eq_93_out : eq_93_out;
	end
	// controller for notOp_97.notOp_97_in0
	// Insensitive connections
	always @(*) begin
		notOp_97_in0 = valid ? eq_96_out : eq_96_out;
	end
	// controller for orOp_71.orOp_71_in0
	// controller for orOp_71.orOp_71_in1
	// Insensitive connections
	always @(*) begin
		orOp_71_in0 = valid ? eq_70_out : eq_70_out;
		orOp_71_in1 = valid ? andOp_28_out : andOp_28_out;
	end
	// controller for orOp_73.orOp_73_in0
	// controller for orOp_73.orOp_73_in1
	// Insensitive connections
	always @(*) begin
		orOp_73_in0 = valid ? eq_72_out : eq_72_out;
		orOp_73_in1 = valid ? andOp_34_out : andOp_34_out;
	end
	// controller for orOp_76.orOp_76_in0
	// controller for orOp_76.orOp_76_in1
	// Insensitive connections
	always @(*) begin
		orOp_76_in0 = valid ? eq_75_out : eq_75_out;
		orOp_76_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for orOp_80.orOp_80_in0
	// controller for orOp_80.orOp_80_in1
	// Insensitive connections
	always @(*) begin
		orOp_80_in0 = valid ? eq_79_out : eq_79_out;
		orOp_80_in1 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for orOp_82.orOp_82_in0
	// controller for orOp_82.orOp_82_in1
	// Insensitive connections
	always @(*) begin
		orOp_82_in0 = valid ? eq_81_out : eq_81_out;
		orOp_82_in1 = valid ? andOp_58_out : andOp_58_out;
	end
	// controller for orOp_84.orOp_84_in0
	// controller for orOp_84.orOp_84_in1
	// Insensitive connections
	always @(*) begin
		orOp_84_in0 = valid ? eq_83_out : eq_83_out;
		orOp_84_in1 = valid ? andOp_67_out : andOp_67_out;
	end
	// controller for orOp_86.orOp_86_in0
	// controller for orOp_86.orOp_86_in1
	// Insensitive connections
	always @(*) begin
		orOp_86_in0 = valid ? eq_85_out : eq_85_out;
		orOp_86_in1 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for orOp_88.orOp_88_in0
	// controller for orOp_88.orOp_88_in1
	// Insensitive connections
	always @(*) begin
		orOp_88_in0 = valid ? eq_87_out : eq_87_out;
		orOp_88_in1 = valid ? andOp_54_out : andOp_54_out;
	end
	// controller for orOp_91.orOp_91_in0
	// controller for orOp_91.orOp_91_in1
	// Insensitive connections
	always @(*) begin
		orOp_91_in0 = valid ? eq_90_out : eq_90_out;
		orOp_91_in1 = valid ? andOp_45_out : andOp_45_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_144_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_143_out) begin 
			out_write_valid_reg = -(1'd1);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// controller for phi_9.phi_in_phi_9
	// controller for phi_9.phi_last_block_phi_9
	// controller for phi_9.phi_s_phi_9
	// Insensitive connections
	always @(*) begin
		phi_in_phi_9 = valid ? concat_135_out : concat_135_out;
		phi_last_block_phi_9 = valid ? bb_3_predecessor_in_state_1_out_data : bb_3_predecessor_in_state_1_out_data;
		phi_s_phi_9 = valid ? concat_136_out : concat_136_out;
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_128_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else if (andOp_130_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_127_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else if (andOp_129_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_127_out) begin 
			wdata_ram_0_reg = 32'd0;
		end else if (andOp_129_out) begin 
			wdata_ram_0_reg = add_out_add_14;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_127_out) begin 
			wen_ram_0_reg = 1'd1;
		end else if (andOp_129_out) begin 
			wen_ram_0_reg = 1'd1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_27.valid_reg
	always @(*) begin
		if (andOp_146_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_138.tmp_output_138_in_data
	always @(*) begin
		if (eq_139_out) begin 
			tmp_output_138_in_data = in_out_data;
		end else begin
			tmp_output_138_in_data = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			data_store_1_0 <= 0;
		end else begin
			if (andOp_171_out) begin
				data_store_1_0 <= phi_out_phi_9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_2 <= 0;
		end else begin
			if (state_1_is_active) begin
				data_store_1_2 <= data_in_1_3_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_4 <= 0;
		end else begin
			if (state_2_is_active) begin
				data_store_2_4 <= data_in_2_5_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_10 <= 0;
		end else begin
			if (andOp_177_out) begin
				data_store_3_10 <= cmp_out_icmp_17;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_6 <= 0;
		end else begin
			if (state_3_is_active) begin
				data_store_3_6 <= data_in_3_7_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_8 <= 0;
		end else begin
			if (andOp_176_out) begin
				data_store_3_8 <= add_out_add_16;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_12 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_12 <= data_in_4_13_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_14 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_14 <= data_in_4_15_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_16 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_16 <= data_in_4_17_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_147_out) begin
				global_state <= 32'd1;
			end
			if (andOp_148_out) begin
				global_state <= 32'd3;
			end
			if (andOp_149_out) begin
				global_state <= 32'd4;
			end
			if (andOp_150_out) begin
				global_state <= 32'd4;
			end
			if (andOp_24_out) begin
				global_state <= 32'd2;
			end
			if (andOp_26_out) begin
				global_state <= 32'd1;
			end
			if (andOp_47_out) begin
				global_state <= 32'd1;
			end
			if (andOp_56_out) begin
				global_state <= 32'd4;
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
			if (andOp_147_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
			if (andOp_26_out) begin
				state_1_entry_BB_reg <= 32'd9;
			end
			if (andOp_47_out) begin
				state_1_entry_BB_reg <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_147_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_156_out) begin
				state_1_is_active <= 1'd0;
			end
			if (andOp_26_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_47_out) begin
				state_1_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_147_out) begin
				state_1_last_BB_reg <= bb_0_predecessor_in_state_0_out_data;
			end
			if (andOp_26_out) begin
				state_1_last_BB_reg <= 32'd9;
			end
			if (andOp_47_out) begin
				state_1_last_BB_reg <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_147_out) begin
				state_1_last_state <= 32'd0;
			end
			if (andOp_26_out) begin
				state_1_last_state <= 32'd1;
			end
			if (andOp_47_out) begin
				state_1_last_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_24_out) begin
				state_2_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_158_out) begin
				state_2_is_active <= 1'd0;
			end
			if (andOp_24_out) begin
				state_2_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_24_out) begin
				state_2_last_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_24_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_148_out) begin
				state_3_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_148_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_160_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_148_out) begin
				state_3_last_BB_reg <= bb_10_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_148_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_149_out) begin
				state_4_entry_BB_reg <= 32'd4;
			end
			if (andOp_150_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
			if (andOp_56_out) begin
				state_4_entry_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_149_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_150_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_166_out) begin
				state_4_is_active <= 1'd0;
			end
			if (andOp_56_out) begin
				state_4_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_149_out) begin
				state_4_last_BB_reg <= bb_4_predecessor_in_state_3_out_data;
			end
			if (andOp_150_out) begin
				state_4_last_BB_reg <= bb_2_predecessor_in_state_4_out_data;
			end
			if (andOp_56_out) begin
				state_4_last_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_state <= 0;
		end else begin
			if (andOp_149_out) begin
				state_4_last_state <= 32'd3;
			end
			if (andOp_150_out) begin
				state_4_last_state <= 32'd4;
			end
			if (andOp_56_out) begin
				state_4_last_state <= 32'd4;
			end
		end
	end

endmodule

