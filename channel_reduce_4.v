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

	add alloca_0();

	add bitcast_1();

	add call_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add call_25();

	reg [63:0] phi_in_phi_8;
	reg [31:0] phi_last_block_phi_8;
	reg [63:0] phi_s_phi_8;
	wire [31:0] phi_out_phi_8;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_8(.in(phi_in_phi_8), .last_block(phi_last_block_phi_8), .out(phi_out_phi_8), .s(phi_s_phi_8));

	reg [31:0] add_in0_add_13;
	reg [31:0] add_in1_add_13;
	wire [31:0] add_out_add_13;
	add #(.WIDTH(32)) add_add_13(.in0(add_in0_add_13), .in1(add_in1_add_13), .out(add_out_add_13));

	reg [31:0] add_in0_add_15;
	reg [31:0] add_in1_add_15;
	wire [31:0] add_out_add_15;
	add #(.WIDTH(32)) add_add_15(.in0(add_in0_add_15), .in1(add_in1_add_15), .out(add_out_add_15));

	reg [31:0] cmp_in0_icmp_16;
	reg [31:0] cmp_in1_icmp_16;
	wire [0:0] cmp_out_icmp_16;
	eq #(.WIDTH(32)) icmp_16(.in0(cmp_in0_icmp_16), .in1(cmp_in1_icmp_16), .out(cmp_out_icmp_16));

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

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

	reg [0:0] bb_10_active_in_state_2_in_data;
	wire [0:0] bb_10_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active_in_state_2(.in_data(bb_10_active_in_state_2_in_data), .out_data(bb_10_active_in_state_2_out_data));

	reg [31:0] bb_10_predecessor_in_state_2_in_data;
	wire [31:0] bb_10_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor_in_state_2(.in_data(bb_10_predecessor_in_state_2_in_data), .out_data(bb_10_predecessor_in_state_2_out_data));

	reg [0:0] bb_4_active_in_state_3_in_data;
	wire [0:0] bb_4_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_3(.in_data(bb_4_active_in_state_3_in_data), .out_data(bb_4_active_in_state_3_out_data));

	reg [31:0] bb_4_predecessor_in_state_3_in_data;
	wire [31:0] bb_4_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_3(.in_data(bb_4_predecessor_in_state_3_in_data), .out_data(bb_4_predecessor_in_state_3_out_data));

	reg [0:0] bb_10_active_in_state_3_in_data;
	wire [0:0] bb_10_active_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) bb_10_active_in_state_3(.in_data(bb_10_active_in_state_3_in_data), .out_data(bb_10_active_in_state_3_out_data));

	reg [31:0] bb_10_predecessor_in_state_3_in_data;
	wire [31:0] bb_10_predecessor_in_state_3_out_data;
	hls_wire #(.WIDTH(32)) bb_10_predecessor_in_state_3(.in_data(bb_10_predecessor_in_state_3_in_data), .out_data(bb_10_predecessor_in_state_3_out_data));

	reg [0:0] bb_4_active_in_state_4_in_data;
	wire [0:0] bb_4_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_4(.in_data(bb_4_active_in_state_4_in_data), .out_data(bb_4_active_in_state_4_out_data));

	reg [31:0] bb_4_predecessor_in_state_4_in_data;
	wire [31:0] bb_4_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_4(.in_data(bb_4_predecessor_in_state_4_in_data), .out_data(bb_4_predecessor_in_state_4_out_data));

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

	reg [0:0] bb_2_active_in_state_4_in_data;
	wire [0:0] bb_2_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_4(.in_data(bb_2_active_in_state_4_in_data), .out_data(bb_2_active_in_state_4_out_data));

	reg [31:0] bb_2_predecessor_in_state_4_in_data;
	wire [31:0] bb_2_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_4(.in_data(bb_2_predecessor_in_state_4_in_data), .out_data(bb_2_predecessor_in_state_4_out_data));

	reg [0:0] bb_1_active_in_state_4_in_data;
	wire [0:0] bb_1_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_4(.in_data(bb_1_active_in_state_4_in_data), .out_data(bb_1_active_in_state_4_out_data));

	reg [31:0] bb_1_predecessor_in_state_4_in_data;
	wire [31:0] bb_1_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_4(.in_data(bb_1_predecessor_in_state_4_in_data), .out_data(bb_1_predecessor_in_state_4_out_data));

	reg [0:0] andOp_0_in0;
	reg [0:0] andOp_0_in1;
	wire [0:0] andOp_0_out;
	andOp #(.WIDTH(1)) andOp_0(.in0(andOp_0_in0), .in1(andOp_0_in1), .out(andOp_0_out));

	reg [0:0] andOp_1_in0;
	reg [0:0] andOp_1_in1;
	wire [0:0] andOp_1_out;
	andOp #(.WIDTH(1)) andOp_1(.in0(andOp_1_in0), .in1(andOp_1_in1), .out(andOp_1_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] notOp_2_in0;
	wire [0:0] notOp_2_out;
	notOp #(.WIDTH(1)) notOp_2(.in(notOp_2_in0), .out(notOp_2_out));

	reg [0:0] andOp_3_in0;
	reg [0:0] andOp_3_in1;
	wire [0:0] andOp_3_out;
	andOp #(.WIDTH(1)) andOp_3(.in0(andOp_3_in0), .in1(andOp_3_in1), .out(andOp_3_out));

	reg [0:0] andOp_4_in0;
	reg [0:0] andOp_4_in1;
	wire [0:0] andOp_4_out;
	andOp #(.WIDTH(1)) andOp_4(.in0(andOp_4_in0), .in1(andOp_4_in1), .out(andOp_4_out));

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	reg [0:0] notOp_5_in0;
	wire [0:0] notOp_5_out;
	notOp #(.WIDTH(1)) notOp_5(.in(notOp_5_in0), .out(notOp_5_out));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] andOp_7_in0;
	reg [0:0] andOp_7_in1;
	wire [0:0] andOp_7_out;
	andOp #(.WIDTH(1)) andOp_7(.in0(andOp_7_in0), .in1(andOp_7_in1), .out(andOp_7_out));

	reg [0:0] br_3_happened_in_state_1_in_data;
	wire [0:0] br_3_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_1(.in_data(br_3_happened_in_state_1_in_data), .out_data(br_3_happened_in_state_1_out_data));

	reg [0:0] notOp_8_in0;
	wire [0:0] notOp_8_out;
	notOp #(.WIDTH(1)) notOp_8(.in(notOp_8_in0), .out(notOp_8_out));

	reg [0:0] andOp_9_in0;
	reg [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	reg [0:0] andOp_10_in0;
	reg [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	reg [0:0] br_9_happened_in_state_1_in_data;
	wire [0:0] br_9_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened_in_state_1(.in_data(br_9_happened_in_state_1_in_data), .out_data(br_9_happened_in_state_1_out_data));

	reg [0:0] notOp_11_in0;
	wire [0:0] notOp_11_out;
	notOp #(.WIDTH(1)) notOp_11(.in(notOp_11_in0), .out(notOp_11_out));

	reg [0:0] andOp_12_in0;
	reg [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] notOp_13_in0;
	wire [0:0] notOp_13_out;
	notOp #(.WIDTH(1)) notOp_13(.in(notOp_13_in0), .out(notOp_13_out));

	reg [0:0] andOp_14_in0;
	reg [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	reg [0:0] andOp_15_in0;
	reg [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	reg [0:0] andOp_16_in0;
	reg [0:0] andOp_16_in1;
	wire [0:0] andOp_16_out;
	andOp #(.WIDTH(1)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

	reg [0:0] br_8_happened_in_state_1_in_data;
	wire [0:0] br_8_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened_in_state_1(.in_data(br_8_happened_in_state_1_in_data), .out_data(br_8_happened_in_state_1_out_data));

	reg [0:0] notOp_17_in0;
	wire [0:0] notOp_17_out;
	notOp #(.WIDTH(1)) notOp_17(.in(notOp_17_in0), .out(notOp_17_out));

	reg [0:0] andOp_18_in0;
	reg [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [0:0] andOp_19_in0;
	reg [0:0] andOp_19_in1;
	wire [0:0] andOp_19_out;
	andOp #(.WIDTH(1)) andOp_19(.in0(andOp_19_in0), .in1(andOp_19_in1), .out(andOp_19_out));

	reg [0:0] br_10_happened_in_state_2_in_data;
	wire [0:0] br_10_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_2(.in_data(br_10_happened_in_state_2_in_data), .out_data(br_10_happened_in_state_2_out_data));

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

	reg [0:0] br_4_happened_in_state_3_in_data;
	wire [0:0] br_4_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_3(.in_data(br_4_happened_in_state_3_in_data), .out_data(br_4_happened_in_state_3_out_data));

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

	reg [0:0] br_10_happened_in_state_3_in_data;
	wire [0:0] br_10_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_3(.in_data(br_10_happened_in_state_3_in_data), .out_data(br_10_happened_in_state_3_out_data));

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

	reg [0:0] br_4_happened_in_state_4_in_data;
	wire [0:0] br_4_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_4(.in_data(br_4_happened_in_state_4_in_data), .out_data(br_4_happened_in_state_4_out_data));

	reg [0:0] notOp_32_in0;
	wire [0:0] notOp_32_out;
	notOp #(.WIDTH(1)) notOp_32(.in(notOp_32_in0), .out(notOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [0:0] notOp_34_in0;
	wire [0:0] notOp_34_out;
	notOp #(.WIDTH(1)) notOp_34(.in(notOp_34_in0), .out(notOp_34_out));

	reg [0:0] andOp_35_in0;
	reg [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	reg [0:0] andOp_36_in0;
	reg [0:0] andOp_36_in1;
	wire [0:0] andOp_36_out;
	andOp #(.WIDTH(1)) andOp_36(.in0(andOp_36_in0), .in1(andOp_36_in1), .out(andOp_36_out));

	reg [0:0] andOp_37_in0;
	reg [0:0] andOp_37_in1;
	wire [0:0] andOp_37_out;
	andOp #(.WIDTH(1)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	reg [0:0] br_5_happened_in_state_4_in_data;
	wire [0:0] br_5_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened_in_state_4(.in_data(br_5_happened_in_state_4_in_data), .out_data(br_5_happened_in_state_4_out_data));

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

	reg [0:0] br_6_happened_in_state_4_in_data;
	wire [0:0] br_6_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened_in_state_4(.in_data(br_6_happened_in_state_4_in_data), .out_data(br_6_happened_in_state_4_out_data));

	reg [0:0] notOp_41_in0;
	wire [0:0] notOp_41_out;
	notOp #(.WIDTH(1)) notOp_41(.in(notOp_41_in0), .out(notOp_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [0:0] notOp_43_in0;
	wire [0:0] notOp_43_out;
	notOp #(.WIDTH(1)) notOp_43(.in(notOp_43_in0), .out(notOp_43_out));

	reg [0:0] andOp_44_in0;
	reg [0:0] andOp_44_in1;
	wire [0:0] andOp_44_out;
	andOp #(.WIDTH(1)) andOp_44(.in0(andOp_44_in0), .in1(andOp_44_in1), .out(andOp_44_out));

	reg [0:0] andOp_45_in0;
	reg [0:0] andOp_45_in1;
	wire [0:0] andOp_45_out;
	andOp #(.WIDTH(1)) andOp_45(.in0(andOp_45_in0), .in1(andOp_45_in1), .out(andOp_45_out));

	reg [0:0] andOp_46_in0;
	reg [0:0] andOp_46_in1;
	wire [0:0] andOp_46_out;
	andOp #(.WIDTH(1)) andOp_46(.in0(andOp_46_in0), .in1(andOp_46_in1), .out(andOp_46_out));

	reg [0:0] br_7_happened_in_state_4_in_data;
	wire [0:0] br_7_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_4(.in_data(br_7_happened_in_state_4_in_data), .out_data(br_7_happened_in_state_4_out_data));

	reg [0:0] notOp_47_in0;
	wire [0:0] notOp_47_out;
	notOp #(.WIDTH(1)) notOp_47(.in(notOp_47_in0), .out(notOp_47_out));

	reg [0:0] andOp_48_in0;
	reg [0:0] andOp_48_in1;
	wire [0:0] andOp_48_out;
	andOp #(.WIDTH(1)) andOp_48(.in0(andOp_48_in0), .in1(andOp_48_in1), .out(andOp_48_out));

	reg [0:0] andOp_49_in0;
	reg [0:0] andOp_49_in1;
	wire [0:0] andOp_49_out;
	andOp #(.WIDTH(1)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

	reg [0:0] br_1_happened_in_state_4_in_data;
	wire [0:0] br_1_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_4(.in_data(br_1_happened_in_state_4_in_data), .out_data(br_1_happened_in_state_4_out_data));

	reg [0:0] notOp_50_in0;
	wire [0:0] notOp_50_out;
	notOp #(.WIDTH(1)) notOp_50(.in(notOp_50_in0), .out(notOp_50_out));

	reg [31:0] eq_51_in0;
	reg [31:0] eq_51_in1;
	wire [0:0] eq_51_out;
	eq #(.WIDTH(32)) eq_51(.in0(eq_51_in0), .in1(eq_51_in1), .out(eq_51_out));

	reg [31:0] eq_52_in0;
	reg [31:0] eq_52_in1;
	wire [0:0] eq_52_out;
	eq #(.WIDTH(32)) eq_52(.in0(eq_52_in0), .in1(eq_52_in1), .out(eq_52_out));

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

	reg [31:0] eq_60_in0;
	reg [31:0] eq_60_in1;
	wire [0:0] eq_60_out;
	eq #(.WIDTH(32)) eq_60(.in0(eq_60_in0), .in1(eq_60_in1), .out(eq_60_out));

	reg [0:0] orOp_61_in0;
	reg [0:0] orOp_61_in1;
	wire [0:0] orOp_61_out;
	orOp #(.WIDTH(1)) orOp_61(.in0(orOp_61_in0), .in1(orOp_61_in1), .out(orOp_61_out));

	reg [31:0] eq_62_in0;
	reg [31:0] eq_62_in1;
	wire [0:0] eq_62_out;
	eq #(.WIDTH(32)) eq_62(.in0(eq_62_in0), .in1(eq_62_in1), .out(eq_62_out));

	reg [31:0] eq_63_in0;
	reg [31:0] eq_63_in1;
	wire [0:0] eq_63_out;
	eq #(.WIDTH(32)) eq_63(.in0(eq_63_in0), .in1(eq_63_in1), .out(eq_63_out));

	reg [0:0] orOp_64_in0;
	reg [0:0] orOp_64_in1;
	wire [0:0] orOp_64_out;
	orOp #(.WIDTH(1)) orOp_64(.in0(orOp_64_in0), .in1(orOp_64_in1), .out(orOp_64_out));

	reg [31:0] eq_65_in0;
	reg [31:0] eq_65_in1;
	wire [0:0] eq_65_out;
	eq #(.WIDTH(32)) eq_65(.in0(eq_65_in0), .in1(eq_65_in1), .out(eq_65_out));

	reg [0:0] orOp_66_in0;
	reg [0:0] orOp_66_in1;
	wire [0:0] orOp_66_out;
	orOp #(.WIDTH(1)) orOp_66(.in0(orOp_66_in0), .in1(orOp_66_in1), .out(orOp_66_out));

	reg [31:0] eq_67_in0;
	reg [31:0] eq_67_in1;
	wire [0:0] eq_67_out;
	eq #(.WIDTH(32)) eq_67(.in0(eq_67_in0), .in1(eq_67_in1), .out(eq_67_out));

	reg [0:0] orOp_68_in0;
	reg [0:0] orOp_68_in1;
	wire [0:0] orOp_68_out;
	orOp #(.WIDTH(1)) orOp_68(.in0(orOp_68_in0), .in1(orOp_68_in1), .out(orOp_68_out));

	reg [31:0] eq_69_in0;
	reg [31:0] eq_69_in1;
	wire [0:0] eq_69_out;
	eq #(.WIDTH(32)) eq_69(.in0(eq_69_in0), .in1(eq_69_in1), .out(eq_69_out));

	reg [0:0] orOp_70_in0;
	reg [0:0] orOp_70_in1;
	wire [0:0] orOp_70_out;
	orOp #(.WIDTH(1)) orOp_70(.in0(orOp_70_in0), .in1(orOp_70_in1), .out(orOp_70_out));

	reg [31:0] eq_71_in0;
	reg [31:0] eq_71_in1;
	wire [0:0] eq_71_out;
	eq #(.WIDTH(32)) eq_71(.in0(eq_71_in0), .in1(eq_71_in1), .out(eq_71_out));

	reg [0:0] orOp_72_in0;
	reg [0:0] orOp_72_in1;
	wire [0:0] orOp_72_out;
	orOp #(.WIDTH(1)) orOp_72(.in0(orOp_72_in0), .in1(orOp_72_in1), .out(orOp_72_out));

	reg [31:0] eq_73_in0;
	reg [31:0] eq_73_in1;
	wire [0:0] eq_73_out;
	eq #(.WIDTH(32)) eq_73(.in0(eq_73_in0), .in1(eq_73_in1), .out(eq_73_out));

	reg [0:0] orOp_74_in0;
	reg [0:0] orOp_74_in1;
	wire [0:0] orOp_74_out;
	orOp #(.WIDTH(1)) orOp_74(.in0(orOp_74_in0), .in1(orOp_74_in1), .out(orOp_74_out));

	reg [31:0] eq_75_in0;
	reg [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

	reg [31:0] eq_76_in0;
	reg [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	reg [31:0] eq_77_in0;
	reg [31:0] eq_77_in1;
	wire [0:0] eq_77_out;
	eq #(.WIDTH(32)) eq_77(.in0(eq_77_in0), .in1(eq_77_in1), .out(eq_77_out));

	reg [0:0] notOp_78_in0;
	wire [0:0] notOp_78_out;
	notOp #(.WIDTH(1)) notOp_78(.in(notOp_78_in0), .out(notOp_78_out));

	reg [0:0] andOp_79_in0;
	reg [0:0] andOp_79_in1;
	wire [0:0] andOp_79_out;
	andOp #(.WIDTH(1)) andOp_79(.in0(andOp_79_in0), .in1(andOp_79_in1), .out(andOp_79_out));

	reg [31:0] eq_80_in0;
	reg [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

	reg [0:0] notOp_81_in0;
	wire [0:0] notOp_81_out;
	notOp #(.WIDTH(1)) notOp_81(.in(notOp_81_in0), .out(notOp_81_out));

	reg [0:0] andOp_82_in0;
	reg [0:0] andOp_82_in1;
	wire [0:0] andOp_82_out;
	andOp #(.WIDTH(1)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	reg [31:0] eq_83_in0;
	reg [31:0] eq_83_in1;
	wire [0:0] eq_83_out;
	eq #(.WIDTH(32)) eq_83(.in0(eq_83_in0), .in1(eq_83_in1), .out(eq_83_out));

	reg [0:0] notOp_84_in0;
	wire [0:0] notOp_84_out;
	notOp #(.WIDTH(1)) notOp_84(.in(notOp_84_in0), .out(notOp_84_out));

	reg [0:0] andOp_85_in0;
	reg [0:0] andOp_85_in1;
	wire [0:0] andOp_85_out;
	andOp #(.WIDTH(1)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	reg [31:0] eq_86_in0;
	reg [31:0] eq_86_in1;
	wire [0:0] eq_86_out;
	eq #(.WIDTH(32)) eq_86(.in0(eq_86_in0), .in1(eq_86_in1), .out(eq_86_out));

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

	reg [31:0] eq_90_in0;
	reg [31:0] eq_90_in1;
	wire [0:0] eq_90_out;
	eq #(.WIDTH(32)) eq_90(.in0(eq_90_in0), .in1(eq_90_in1), .out(eq_90_out));

	reg [31:0] eq_91_in0;
	reg [31:0] eq_91_in1;
	wire [0:0] eq_91_out;
	eq #(.WIDTH(32)) eq_91(.in0(eq_91_in0), .in1(eq_91_in1), .out(eq_91_out));

	reg [0:0] notOp_92_in0;
	wire [0:0] notOp_92_out;
	notOp #(.WIDTH(1)) notOp_92(.in(notOp_92_in0), .out(notOp_92_out));

	reg [0:0] andOp_93_in0;
	reg [0:0] andOp_93_in1;
	wire [0:0] andOp_93_out;
	andOp #(.WIDTH(1)) andOp_93(.in0(andOp_93_in0), .in1(andOp_93_in1), .out(andOp_93_out));

	reg [31:0] eq_94_in0;
	reg [31:0] eq_94_in1;
	wire [0:0] eq_94_out;
	eq #(.WIDTH(32)) eq_94(.in0(eq_94_in0), .in1(eq_94_in1), .out(eq_94_out));

	reg [0:0] notOp_95_in0;
	wire [0:0] notOp_95_out;
	notOp #(.WIDTH(1)) notOp_95(.in(notOp_95_in0), .out(notOp_95_out));

	reg [0:0] andOp_96_in0;
	reg [0:0] andOp_96_in1;
	wire [0:0] andOp_96_out;
	andOp #(.WIDTH(1)) andOp_96(.in0(andOp_96_in0), .in1(andOp_96_in1), .out(andOp_96_out));

	reg [31:0] eq_97_in0;
	reg [31:0] eq_97_in1;
	wire [0:0] eq_97_out;
	eq #(.WIDTH(32)) eq_97(.in0(eq_97_in0), .in1(eq_97_in1), .out(eq_97_out));

	reg [0:0] notOp_98_in0;
	wire [0:0] notOp_98_out;
	notOp #(.WIDTH(1)) notOp_98(.in(notOp_98_in0), .out(notOp_98_out));

	reg [0:0] andOp_99_in0;
	reg [0:0] andOp_99_in1;
	wire [0:0] andOp_99_out;
	andOp #(.WIDTH(1)) andOp_99(.in0(andOp_99_in0), .in1(andOp_99_in1), .out(andOp_99_out));

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

	reg [0:0] notOp_104_in0;
	wire [0:0] notOp_104_out;
	notOp #(.WIDTH(1)) notOp_104(.in(notOp_104_in0), .out(notOp_104_out));

	reg [0:0] andOp_105_in0;
	reg [0:0] andOp_105_in1;
	wire [0:0] andOp_105_out;
	andOp #(.WIDTH(1)) andOp_105(.in0(andOp_105_in0), .in1(andOp_105_in1), .out(andOp_105_out));

	reg [31:0] eq_106_in0;
	reg [31:0] eq_106_in1;
	wire [0:0] eq_106_out;
	eq #(.WIDTH(32)) eq_106(.in0(eq_106_in0), .in1(eq_106_in1), .out(eq_106_out));

	reg [0:0] notOp_107_in0;
	wire [0:0] notOp_107_out;
	notOp #(.WIDTH(1)) notOp_107(.in(notOp_107_in0), .out(notOp_107_out));

	reg [0:0] andOp_108_in0;
	reg [0:0] andOp_108_in1;
	wire [0:0] andOp_108_out;
	andOp #(.WIDTH(1)) andOp_108(.in0(andOp_108_in0), .in1(andOp_108_in1), .out(andOp_108_out));

	reg [0:0] andOp_109_in0;
	reg [0:0] andOp_109_in1;
	wire [0:0] andOp_109_out;
	andOp #(.WIDTH(1)) andOp_109(.in0(andOp_109_in0), .in1(andOp_109_in1), .out(andOp_109_out));

	reg [0:0] andOp_110_in0;
	reg [0:0] andOp_110_in1;
	wire [0:0] andOp_110_out;
	andOp #(.WIDTH(1)) andOp_110(.in0(andOp_110_in0), .in1(andOp_110_in1), .out(andOp_110_out));

	reg [0:0] andOp_111_in0;
	reg [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [0:0] andOp_112_in0;
	reg [0:0] andOp_112_in1;
	wire [0:0] andOp_112_out;
	andOp #(.WIDTH(1)) andOp_112(.in0(andOp_112_in0), .in1(andOp_112_in1), .out(andOp_112_out));

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

	reg [31:0] concat_120_in0;
	reg [31:0] concat_120_in1;
	wire [63:0] concat_120_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_120(.in0(concat_120_in0), .in1(concat_120_in1), .out(concat_120_out));

	reg [31:0] concat_121_in0;
	reg [31:0] concat_121_in1;
	wire [63:0] concat_121_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_121(.in0(concat_121_in0), .in1(concat_121_in1), .out(concat_121_out));

	reg [0:0] andOp_122_in0;
	reg [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	reg [31:0] tmp_output_123_in_data;
	wire [31:0] tmp_output_123_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_123(.in_data(tmp_output_123_in_data), .out_data(tmp_output_123_out_data));

	reg [31:0] eq_124_in0;
	reg [31:0] eq_124_in1;
	wire [0:0] eq_124_out;
	eq #(.WIDTH(32)) eq_124(.in0(eq_124_in0), .in1(eq_124_in1), .out(eq_124_out));

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

	reg [0:0] andOp_135_in0;
	reg [0:0] andOp_135_in1;
	wire [0:0] andOp_135_out;
	andOp #(.WIDTH(1)) andOp_135(.in0(andOp_135_in0), .in1(andOp_135_in1), .out(andOp_135_out));

	reg [0:0] notOp_136_in0;
	wire [0:0] notOp_136_out;
	notOp #(.WIDTH(1)) notOp_136(.in(notOp_136_in0), .out(notOp_136_out));

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

	reg [0:0] notOp_140_in0;
	wire [0:0] notOp_140_out;
	notOp #(.WIDTH(1)) notOp_140(.in(notOp_140_in0), .out(notOp_140_out));

	reg [0:0] andOp_141_in0;
	reg [0:0] andOp_141_in1;
	wire [0:0] andOp_141_out;
	andOp #(.WIDTH(1)) andOp_141(.in0(andOp_141_in0), .in1(andOp_141_in1), .out(andOp_141_out));

	reg [0:0] notOp_142_in0;
	wire [0:0] notOp_142_out;
	notOp #(.WIDTH(1)) notOp_142(.in(notOp_142_in0), .out(notOp_142_out));

	reg [0:0] andOp_143_in0;
	reg [0:0] andOp_143_in1;
	wire [0:0] andOp_143_out;
	andOp #(.WIDTH(1)) andOp_143(.in0(andOp_143_in0), .in1(andOp_143_in1), .out(andOp_143_out));

	reg [0:0] notOp_144_in0;
	wire [0:0] notOp_144_out;
	notOp #(.WIDTH(1)) notOp_144(.in(notOp_144_in0), .out(notOp_144_out));

	reg [0:0] andOp_145_in0;
	reg [0:0] andOp_145_in1;
	wire [0:0] andOp_145_out;
	andOp #(.WIDTH(1)) andOp_145(.in0(andOp_145_in0), .in1(andOp_145_in1), .out(andOp_145_out));

	reg [0:0] notOp_146_in0;
	wire [0:0] notOp_146_out;
	notOp #(.WIDTH(1)) notOp_146(.in(notOp_146_in0), .out(notOp_146_out));

	reg [0:0] andOp_147_in0;
	reg [0:0] andOp_147_in1;
	wire [0:0] andOp_147_out;
	andOp #(.WIDTH(1)) andOp_147(.in0(andOp_147_in0), .in1(andOp_147_in1), .out(andOp_147_out));

	reg [0:0] notOp_148_in0;
	wire [0:0] notOp_148_out;
	notOp #(.WIDTH(1)) notOp_148(.in(notOp_148_in0), .out(notOp_148_out));

	reg [0:0] andOp_149_in0;
	reg [0:0] andOp_149_in1;
	wire [0:0] andOp_149_out;
	andOp #(.WIDTH(1)) andOp_149(.in0(andOp_149_in0), .in1(andOp_149_in1), .out(andOp_149_out));

	reg [0:0] notOp_150_in0;
	wire [0:0] notOp_150_out;
	notOp #(.WIDTH(1)) notOp_150(.in(notOp_150_in0), .out(notOp_150_out));

	reg [0:0] andOp_151_in0;
	reg [0:0] andOp_151_in1;
	wire [0:0] andOp_151_out;
	andOp #(.WIDTH(1)) andOp_151(.in0(andOp_151_in0), .in1(andOp_151_in1), .out(andOp_151_out));

	reg [0:0] andOp_152_in0;
	reg [0:0] andOp_152_in1;
	wire [0:0] andOp_152_out;
	andOp #(.WIDTH(1)) andOp_152(.in0(andOp_152_in0), .in1(andOp_152_in1), .out(andOp_152_out));

	reg [0:0] andOp_153_in0;
	reg [0:0] andOp_153_in1;
	wire [0:0] andOp_153_out;
	andOp #(.WIDTH(1)) andOp_153(.in0(andOp_153_in0), .in1(andOp_153_in1), .out(andOp_153_out));

	reg [0:0] andOp_154_in0;
	reg [0:0] andOp_154_in1;
	wire [0:0] andOp_154_out;
	andOp #(.WIDTH(1)) andOp_154(.in0(andOp_154_in0), .in1(andOp_154_in1), .out(andOp_154_out));

	reg [0:0] andOp_155_in0;
	reg [0:0] andOp_155_in1;
	wire [0:0] andOp_155_out;
	andOp #(.WIDTH(1)) andOp_155(.in0(andOp_155_in0), .in1(andOp_155_in1), .out(andOp_155_out));

	// End Functional Units

	reg [31:0] add_tmp_5;
	reg [31:0] call_tmp_2;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_6;
	reg [31:0] phi_tmp_1;
	reg [31:0] state_0_entry_BB_reg;
	reg [0:0] state_0_is_active;
	reg [31:0] state_0_last_BB_reg;
	reg [31:0] state_1_entry_BB_reg;
	reg [0:0] state_1_is_active;
	reg [31:0] state_1_last_BB_reg;
	reg [31:0] state_2_entry_BB_reg;
	reg [0:0] state_2_is_active;
	reg [31:0] state_2_last_BB_reg;
	reg [31:0] state_3_entry_BB_reg;
	reg [0:0] state_3_is_active;
	reg [31:0] state_3_last_BB_reg;
	reg [31:0] state_4_entry_BB_reg;
	reg [0:0] state_4_is_active;
	reg [31:0] state_4_last_BB_reg;

	// controller for add_add_13.add_in0_add_13
	// controller for add_add_13.add_in1_add_13
	// Insensitive connections
	always @(*) begin
		add_in0_add_13 = valid ? rdata_ram_0 : rdata_ram_0;
		add_in1_add_13 = valid ? tmp_output_123_out_data : tmp_output_123_out_data;
	end
	// controller for add_add_15.add_in0_add_15
	// controller for add_add_15.add_in1_add_15
	// Insensitive connections
	always @(*) begin
		add_in0_add_15 = valid ? phi_tmp_1 : phi_tmp_1;
		add_in1_add_15 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_0.andOp_0_in0
	// controller for andOp_0.andOp_0_in1
	// Insensitive connections
	always @(*) begin
		andOp_0_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_0_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_1.andOp_1_in0
	// controller for andOp_1.andOp_1_in1
	// Insensitive connections
	always @(*) begin
		andOp_1_in0 = valid ? andOp_0_out : andOp_0_out;
		andOp_1_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	always @(*) begin
		andOp_10_in0 = valid ? andOp_9_out : andOp_9_out;
		andOp_10_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_102.andOp_102_in0
	// controller for andOp_102.andOp_102_in1
	// Insensitive connections
	always @(*) begin
		andOp_102_in0 = valid ? notOp_101_out : notOp_101_out;
		andOp_102_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	always @(*) begin
		andOp_105_in0 = valid ? notOp_104_out : notOp_104_out;
		andOp_105_in1 = valid ? andOp_46_out : andOp_46_out;
	end
	// controller for andOp_108.andOp_108_in0
	// controller for andOp_108.andOp_108_in1
	// Insensitive connections
	always @(*) begin
		andOp_108_in0 = valid ? notOp_107_out : notOp_107_out;
		andOp_108_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for andOp_109.andOp_109_in0
	// controller for andOp_109.andOp_109_in1
	// Insensitive connections
	always @(*) begin
		andOp_109_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_109_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_110.andOp_110_in0
	// controller for andOp_110.andOp_110_in1
	// Insensitive connections
	always @(*) begin
		andOp_110_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_110_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_111_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_112.andOp_112_in0
	// controller for andOp_112.andOp_112_in1
	// Insensitive connections
	always @(*) begin
		andOp_112_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_112_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_113.andOp_113_in0
	// controller for andOp_113.andOp_113_in1
	// Insensitive connections
	always @(*) begin
		andOp_113_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_113_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	always @(*) begin
		andOp_114_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_114_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_115.andOp_115_in0
	// controller for andOp_115.andOp_115_in1
	// Insensitive connections
	always @(*) begin
		andOp_115_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_115_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_116.andOp_116_in0
	// controller for andOp_116.andOp_116_in1
	// Insensitive connections
	always @(*) begin
		andOp_116_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_116_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_117.andOp_117_in0
	// controller for andOp_117.andOp_117_in1
	// Insensitive connections
	always @(*) begin
		andOp_117_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_117_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_118.andOp_118_in0
	// controller for andOp_118.andOp_118_in1
	// Insensitive connections
	always @(*) begin
		andOp_118_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_118_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_119_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	always @(*) begin
		andOp_12_in0 = valid ? andOp_10_out : andOp_10_out;
		andOp_12_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_122_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_125_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_126.andOp_126_in0
	// controller for andOp_126.andOp_126_in1
	// Insensitive connections
	always @(*) begin
		andOp_126_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_126_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_127.andOp_127_in0
	// controller for andOp_127.andOp_127_in1
	// Insensitive connections
	always @(*) begin
		andOp_127_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_127_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_128_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	always @(*) begin
		andOp_129_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_129_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_130_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_131.andOp_131_in0
	// controller for andOp_131.andOp_131_in1
	// Insensitive connections
	always @(*) begin
		andOp_131_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_131_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_132.andOp_132_in0
	// controller for andOp_132.andOp_132_in1
	// Insensitive connections
	always @(*) begin
		andOp_132_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_132_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_133.andOp_133_in0
	// controller for andOp_133.andOp_133_in1
	// Insensitive connections
	always @(*) begin
		andOp_133_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_133_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_134.andOp_134_in0
	// controller for andOp_134.andOp_134_in1
	// Insensitive connections
	always @(*) begin
		andOp_134_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_134_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_135.andOp_135_in0
	// controller for andOp_135.andOp_135_in1
	// Insensitive connections
	always @(*) begin
		andOp_135_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_135_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_137.andOp_137_in0
	// controller for andOp_137.andOp_137_in1
	// Insensitive connections
	always @(*) begin
		andOp_137_in0 = valid ? notOp_136_out : notOp_136_out;
		andOp_137_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? notOp_138_out : notOp_138_out;
		andOp_139_in1 = valid ? andOp_137_out : andOp_137_out;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? andOp_10_out : andOp_10_out;
		andOp_14_in1 = valid ? notOp_13_out : notOp_13_out;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? notOp_140_out : notOp_140_out;
		andOp_141_in1 = valid ? andOp_139_out : andOp_139_out;
	end
	// controller for andOp_143.andOp_143_in0
	// controller for andOp_143.andOp_143_in1
	// Insensitive connections
	always @(*) begin
		andOp_143_in0 = valid ? notOp_142_out : notOp_142_out;
		andOp_143_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? notOp_144_out : notOp_144_out;
		andOp_145_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_147.andOp_147_in0
	// controller for andOp_147.andOp_147_in1
	// Insensitive connections
	always @(*) begin
		andOp_147_in0 = valid ? notOp_146_out : notOp_146_out;
		andOp_147_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_149.andOp_149_in0
	// controller for andOp_149.andOp_149_in1
	// Insensitive connections
	always @(*) begin
		andOp_149_in0 = valid ? notOp_148_out : notOp_148_out;
		andOp_149_in1 = valid ? andOp_147_out : andOp_147_out;
	end
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	always @(*) begin
		andOp_15_in0 = valid ? bb_8_active_in_state_1_out_data : bb_8_active_in_state_1_out_data;
		andOp_15_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_151.andOp_151_in0
	// controller for andOp_151.andOp_151_in1
	// Insensitive connections
	always @(*) begin
		andOp_151_in0 = valid ? notOp_150_out : notOp_150_out;
		andOp_151_in1 = valid ? andOp_149_out : andOp_149_out;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_152_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_153.andOp_153_in0
	// controller for andOp_153.andOp_153_in1
	// Insensitive connections
	always @(*) begin
		andOp_153_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_153_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_154.andOp_154_in0
	// controller for andOp_154.andOp_154_in1
	// Insensitive connections
	always @(*) begin
		andOp_154_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_154_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_155.andOp_155_in0
	// controller for andOp_155.andOp_155_in1
	// Insensitive connections
	always @(*) begin
		andOp_155_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_155_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? andOp_15_out : andOp_15_out;
		andOp_16_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_18_in1 = valid ? state_3_is_active : state_3_is_active;
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
		andOp_21_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_21_in1 = valid ? state_4_is_active : state_4_is_active;
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
		andOp_24_in1 = valid ? icmp_tmp_6 : icmp_tmp_6;
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
		andOp_27_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_27_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_28.andOp_28_in0
	// controller for andOp_28.andOp_28_in1
	// Insensitive connections
	always @(*) begin
		andOp_28_in0 = valid ? andOp_27_out : andOp_27_out;
		andOp_28_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_3.andOp_3_in0
	// controller for andOp_3.andOp_3_in1
	// Insensitive connections
	always @(*) begin
		andOp_3_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_3_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_30.andOp_30_in0
	// controller for andOp_30.andOp_30_in1
	// Insensitive connections
	always @(*) begin
		andOp_30_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_30_in1 = valid ? state_4_is_active : state_4_is_active;
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
		andOp_33_in0 = valid ? andOp_31_out : andOp_31_out;
		andOp_33_in1 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for andOp_35.andOp_35_in0
	// controller for andOp_35.andOp_35_in1
	// Insensitive connections
	always @(*) begin
		andOp_35_in0 = valid ? andOp_31_out : andOp_31_out;
		andOp_35_in1 = valid ? notOp_34_out : notOp_34_out;
	end
	// controller for andOp_36.andOp_36_in0
	// controller for andOp_36.andOp_36_in1
	// Insensitive connections
	always @(*) begin
		andOp_36_in0 = valid ? bb_5_active_in_state_4_out_data : bb_5_active_in_state_4_out_data;
		andOp_36_in1 = valid ? state_4_is_active : state_4_is_active;
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
		andOp_39_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_39_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_4.andOp_4_in0
	// controller for andOp_4.andOp_4_in1
	// Insensitive connections
	always @(*) begin
		andOp_4_in0 = valid ? andOp_3_out : andOp_3_out;
		andOp_4_in1 = valid ? 1'd1 : 1'd1;
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
		andOp_42_in0 = valid ? andOp_40_out : andOp_40_out;
		andOp_42_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	always @(*) begin
		andOp_44_in0 = valid ? andOp_40_out : andOp_40_out;
		andOp_44_in1 = valid ? notOp_43_out : notOp_43_out;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_45_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_46.andOp_46_in0
	// controller for andOp_46.andOp_46_in1
	// Insensitive connections
	always @(*) begin
		andOp_46_in0 = valid ? andOp_45_out : andOp_45_out;
		andOp_46_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? bb_1_active_in_state_4_out_data : bb_1_active_in_state_4_out_data;
		andOp_48_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? andOp_48_out : andOp_48_out;
		andOp_49_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_6_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_7.andOp_7_in0
	// controller for andOp_7.andOp_7_in1
	// Insensitive connections
	always @(*) begin
		andOp_7_in0 = valid ? andOp_6_out : andOp_6_out;
		andOp_7_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_79.andOp_79_in0
	// controller for andOp_79.andOp_79_in1
	// Insensitive connections
	always @(*) begin
		andOp_79_in0 = valid ? notOp_78_out : notOp_78_out;
		andOp_79_in1 = valid ? andOp_1_out : andOp_1_out;
	end
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	always @(*) begin
		andOp_82_in0 = valid ? notOp_81_out : notOp_81_out;
		andOp_82_in1 = valid ? andOp_16_out : andOp_16_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? notOp_84_out : notOp_84_out;
		andOp_85_in1 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for andOp_89.andOp_89_in0
	// controller for andOp_89.andOp_89_in1
	// Insensitive connections
	always @(*) begin
		andOp_89_in0 = valid ? notOp_88_out : notOp_88_out;
		andOp_89_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	always @(*) begin
		andOp_9_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_9_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	always @(*) begin
		andOp_93_in0 = valid ? notOp_92_out : notOp_92_out;
		andOp_93_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for andOp_96.andOp_96_in0
	// controller for andOp_96.andOp_96_in1
	// Insensitive connections
	always @(*) begin
		andOp_96_in0 = valid ? notOp_95_out : notOp_95_out;
		andOp_96_in1 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for andOp_99.andOp_99_in0
	// controller for andOp_99.andOp_99_in1
	// Insensitive connections
	always @(*) begin
		andOp_99_in0 = valid ? notOp_98_out : notOp_98_out;
		andOp_99_in1 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_51_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_52_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_75_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_76_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_2.bb_10_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_2_in_data = eq_59_out;
		end else begin
			bb_10_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_3.bb_10_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_3_in_data = eq_62_out;
		end else begin
			bb_10_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_2.bb_10_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_86_out) begin 
			bb_10_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_3.bb_10_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_90_out) begin 
			bb_10_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = orOp_74_out;
		end else begin
			bb_1_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_4.bb_1_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_108_out) begin 
			bb_1_predecessor_in_state_4_in_data = 32'd4;
		end else if (eq_106_out) begin 
			bb_1_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_4.bb_2_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_4_in_data = orOp_72_out;
		end else begin
			bb_2_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_4.bb_2_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_105_out) begin 
			bb_2_predecessor_in_state_4_in_data = 32'd7;
		end else if (eq_103_out) begin 
			bb_2_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_1.bb_3_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_1_in_data = orOp_54_out;
		end else begin
			bb_3_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_1.bb_3_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_79_out) begin 
			bb_3_predecessor_in_state_1_in_data = 32'd0;
		end else if (eq_77_out) begin 
			bb_3_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_3.bb_4_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_3_in_data = orOp_61_out;
		end else begin
			bb_4_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_4.bb_4_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_4_in_data = orOp_64_out;
		end else begin
			bb_4_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_3.bb_4_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_89_out) begin 
			bb_4_predecessor_in_state_3_in_data = 32'd10;
		end else if (eq_87_out) begin 
			bb_4_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_4.bb_4_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_93_out) begin 
			bb_4_predecessor_in_state_4_in_data = 32'd10;
		end else if (eq_91_out) begin 
			bb_4_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_active_in_state_4.bb_5_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_state_4_in_data = orOp_66_out;
		end else begin
			bb_5_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_predecessor_in_state_4.bb_5_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_96_out) begin 
			bb_5_predecessor_in_state_4_in_data = 32'd1;
		end else if (eq_94_out) begin 
			bb_5_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_5_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_active_in_state_4.bb_6_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_state_4_in_data = orOp_68_out;
		end else begin
			bb_6_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_predecessor_in_state_4.bb_6_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_99_out) begin 
			bb_6_predecessor_in_state_4_in_data = 32'd5;
		end else if (eq_97_out) begin 
			bb_6_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_6_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_4.bb_7_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_4_in_data = orOp_70_out;
		end else begin
			bb_7_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_predecessor_in_state_4.bb_7_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_102_out) begin 
			bb_7_predecessor_in_state_4_in_data = 32'd6;
		end else if (eq_100_out) begin 
			bb_7_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_7_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_8_active_in_state_1.bb_8_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_8_active_in_state_1_in_data = orOp_58_out;
		end else begin
			bb_8_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_8_predecessor_in_state_1.bb_8_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_85_out) begin 
			bb_8_predecessor_in_state_1_in_data = 32'd3;
		end else if (eq_83_out) begin 
			bb_8_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_8_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_active_in_state_1.bb_9_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_state_1_in_data = orOp_56_out;
		end else begin
			bb_9_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_predecessor_in_state_1.bb_9_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_82_out) begin 
			bb_9_predecessor_in_state_1_in_data = 32'd8;
		end else if (eq_80_out) begin 
			bb_9_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_9_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_1_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_2_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_4_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_5_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_2.br_10_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_19_out) begin 
			br_10_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_20_out) begin 
			br_10_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_3.br_10_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_28_out) begin 
			br_10_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_29_out) begin 
			br_10_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_4.br_1_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_49_out) begin 
			br_1_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_50_out) begin 
			br_1_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_3_happened_in_state_1.br_3_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_7_out) begin 
			br_3_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_8_out) begin 
			br_3_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_3.br_4_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_22_out) begin 
			br_4_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_23_out) begin 
			br_4_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_4.br_4_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_31_out) begin 
			br_4_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_32_out) begin 
			br_4_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_5_happened_in_state_4.br_5_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_37_out) begin 
			br_5_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_38_out) begin 
			br_5_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_5_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_6_happened_in_state_4.br_6_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_40_out) begin 
			br_6_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_41_out) begin 
			br_6_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_6_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_4.br_7_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_46_out) begin 
			br_7_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_47_out) begin 
			br_7_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_8_happened_in_state_1.br_8_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_16_out) begin 
			br_8_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_17_out) begin 
			br_8_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_8_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_9_happened_in_state_1.br_9_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_10_out) begin 
			br_9_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_11_out) begin 
			br_9_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_9_happened_in_state_1_in_data = 0;
		end
	end
	// controller for concat_120.concat_120_in0
	// controller for concat_120.concat_120_in1
	// Insensitive connections
	always @(*) begin
		concat_120_in0 = valid ? add_tmp_5 : add_tmp_5;
		concat_120_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_121.concat_121_in0
	// controller for concat_121.concat_121_in1
	// Insensitive connections
	always @(*) begin
		concat_121_in0 = valid ? 32'd4 : 32'd4;
		concat_121_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for eq_100.eq_100_in0
	// controller for eq_100.eq_100_in1
	// Insensitive connections
	always @(*) begin
		eq_100_in0 = valid ? 32'd7 : 32'd7;
		eq_100_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_103.eq_103_in0
	// controller for eq_103.eq_103_in1
	// Insensitive connections
	always @(*) begin
		eq_103_in0 = valid ? 32'd2 : 32'd2;
		eq_103_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_106.eq_106_in0
	// controller for eq_106.eq_106_in1
	// Insensitive connections
	always @(*) begin
		eq_106_in0 = valid ? 32'd1 : 32'd1;
		eq_106_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_124.eq_124_in0
	// controller for eq_124.eq_124_in1
	// Insensitive connections
	always @(*) begin
		eq_124_in0 = valid ? 32'd10 : 32'd10;
		eq_124_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_51.eq_51_in0
	// controller for eq_51.eq_51_in1
	// Insensitive connections
	always @(*) begin
		eq_51_in0 = valid ? 32'd0 : 32'd0;
		eq_51_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_52.eq_52_in0
	// controller for eq_52.eq_52_in1
	// Insensitive connections
	always @(*) begin
		eq_52_in0 = valid ? 32'd0 : 32'd0;
		eq_52_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_53.eq_53_in0
	// controller for eq_53.eq_53_in1
	// Insensitive connections
	always @(*) begin
		eq_53_in0 = valid ? 32'd3 : 32'd3;
		eq_53_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_55.eq_55_in0
	// controller for eq_55.eq_55_in1
	// Insensitive connections
	always @(*) begin
		eq_55_in0 = valid ? 32'd9 : 32'd9;
		eq_55_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_57.eq_57_in0
	// controller for eq_57.eq_57_in1
	// Insensitive connections
	always @(*) begin
		eq_57_in0 = valid ? 32'd8 : 32'd8;
		eq_57_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_59.eq_59_in0
	// controller for eq_59.eq_59_in1
	// Insensitive connections
	always @(*) begin
		eq_59_in0 = valid ? 32'd10 : 32'd10;
		eq_59_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_60.eq_60_in0
	// controller for eq_60.eq_60_in1
	// Insensitive connections
	always @(*) begin
		eq_60_in0 = valid ? 32'd4 : 32'd4;
		eq_60_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_62.eq_62_in0
	// controller for eq_62.eq_62_in1
	// Insensitive connections
	always @(*) begin
		eq_62_in0 = valid ? 32'd10 : 32'd10;
		eq_62_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_63.eq_63_in0
	// controller for eq_63.eq_63_in1
	// Insensitive connections
	always @(*) begin
		eq_63_in0 = valid ? 32'd4 : 32'd4;
		eq_63_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_65.eq_65_in0
	// controller for eq_65.eq_65_in1
	// Insensitive connections
	always @(*) begin
		eq_65_in0 = valid ? 32'd5 : 32'd5;
		eq_65_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_67.eq_67_in0
	// controller for eq_67.eq_67_in1
	// Insensitive connections
	always @(*) begin
		eq_67_in0 = valid ? 32'd6 : 32'd6;
		eq_67_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_69.eq_69_in0
	// controller for eq_69.eq_69_in1
	// Insensitive connections
	always @(*) begin
		eq_69_in0 = valid ? 32'd7 : 32'd7;
		eq_69_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_71.eq_71_in0
	// controller for eq_71.eq_71_in1
	// Insensitive connections
	always @(*) begin
		eq_71_in0 = valid ? 32'd2 : 32'd2;
		eq_71_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_73.eq_73_in0
	// controller for eq_73.eq_73_in1
	// Insensitive connections
	always @(*) begin
		eq_73_in0 = valid ? 32'd1 : 32'd1;
		eq_73_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	always @(*) begin
		eq_75_in0 = valid ? 32'd0 : 32'd0;
		eq_75_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd0 : 32'd0;
		eq_76_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_77.eq_77_in0
	// controller for eq_77.eq_77_in1
	// Insensitive connections
	always @(*) begin
		eq_77_in0 = valid ? 32'd3 : 32'd3;
		eq_77_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	always @(*) begin
		eq_80_in0 = valid ? 32'd9 : 32'd9;
		eq_80_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_83.eq_83_in0
	// controller for eq_83.eq_83_in1
	// Insensitive connections
	always @(*) begin
		eq_83_in0 = valid ? 32'd8 : 32'd8;
		eq_83_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_86.eq_86_in0
	// controller for eq_86.eq_86_in1
	// Insensitive connections
	always @(*) begin
		eq_86_in0 = valid ? 32'd10 : 32'd10;
		eq_86_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	always @(*) begin
		eq_87_in0 = valid ? 32'd4 : 32'd4;
		eq_87_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_90.eq_90_in0
	// controller for eq_90.eq_90_in1
	// Insensitive connections
	always @(*) begin
		eq_90_in0 = valid ? 32'd10 : 32'd10;
		eq_90_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_91.eq_91_in0
	// controller for eq_91.eq_91_in1
	// Insensitive connections
	always @(*) begin
		eq_91_in0 = valid ? 32'd4 : 32'd4;
		eq_91_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_94.eq_94_in0
	// controller for eq_94.eq_94_in1
	// Insensitive connections
	always @(*) begin
		eq_94_in0 = valid ? 32'd5 : 32'd5;
		eq_94_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_97.eq_97_in0
	// controller for eq_97.eq_97_in1
	// Insensitive connections
	always @(*) begin
		eq_97_in0 = valid ? 32'd6 : 32'd6;
		eq_97_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for icmp_16.cmp_in0_icmp_16
	// controller for icmp_16.cmp_in1_icmp_16
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_16 = valid ? add_out_add_15 : add_out_add_15;
		cmp_in1_icmp_16 = valid ? 32'd4 : 32'd4;
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if (andOp_117_out) begin 
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
	// controller for notOp_104.notOp_104_in0
	// Insensitive connections
	always @(*) begin
		notOp_104_in0 = valid ? eq_103_out : eq_103_out;
	end
	// controller for notOp_107.notOp_107_in0
	// Insensitive connections
	always @(*) begin
		notOp_107_in0 = valid ? eq_106_out : eq_106_out;
	end
	// controller for notOp_11.notOp_11_in0
	// Insensitive connections
	always @(*) begin
		notOp_11_in0 = valid ? andOp_10_out : andOp_10_out;
	end
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	always @(*) begin
		notOp_13_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_136.notOp_136_in0
	// Insensitive connections
	always @(*) begin
		notOp_136_in0 = valid ? andOp_132_out : andOp_132_out;
	end
	// controller for notOp_138.notOp_138_in0
	// Insensitive connections
	always @(*) begin
		notOp_138_in0 = valid ? andOp_14_out : andOp_14_out;
	end
	// controller for notOp_140.notOp_140_in0
	// Insensitive connections
	always @(*) begin
		notOp_140_in0 = valid ? andOp_26_out : andOp_26_out;
	end
	// controller for notOp_142.notOp_142_in0
	// Insensitive connections
	always @(*) begin
		notOp_142_in0 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for notOp_144.notOp_144_in0
	// Insensitive connections
	always @(*) begin
		notOp_144_in0 = valid ? andOp_133_out : andOp_133_out;
	end
	// controller for notOp_146.notOp_146_in0
	// Insensitive connections
	always @(*) begin
		notOp_146_in0 = valid ? andOp_134_out : andOp_134_out;
	end
	// controller for notOp_148.notOp_148_in0
	// Insensitive connections
	always @(*) begin
		notOp_148_in0 = valid ? andOp_135_out : andOp_135_out;
	end
	// controller for notOp_150.notOp_150_in0
	// Insensitive connections
	always @(*) begin
		notOp_150_in0 = valid ? andOp_44_out : andOp_44_out;
	end
	// controller for notOp_17.notOp_17_in0
	// Insensitive connections
	always @(*) begin
		notOp_17_in0 = valid ? andOp_16_out : andOp_16_out;
	end
	// controller for notOp_2.notOp_2_in0
	// Insensitive connections
	always @(*) begin
		notOp_2_in0 = valid ? andOp_1_out : andOp_1_out;
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
		notOp_25_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
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
	// controller for notOp_34.notOp_34_in0
	// Insensitive connections
	always @(*) begin
		notOp_34_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
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
	// controller for notOp_43.notOp_43_in0
	// Insensitive connections
	always @(*) begin
		notOp_43_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for notOp_47.notOp_47_in0
	// Insensitive connections
	always @(*) begin
		notOp_47_in0 = valid ? andOp_46_out : andOp_46_out;
	end
	// controller for notOp_5.notOp_5_in0
	// Insensitive connections
	always @(*) begin
		notOp_5_in0 = valid ? andOp_4_out : andOp_4_out;
	end
	// controller for notOp_50.notOp_50_in0
	// Insensitive connections
	always @(*) begin
		notOp_50_in0 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for notOp_78.notOp_78_in0
	// Insensitive connections
	always @(*) begin
		notOp_78_in0 = valid ? eq_77_out : eq_77_out;
	end
	// controller for notOp_8.notOp_8_in0
	// Insensitive connections
	always @(*) begin
		notOp_8_in0 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for notOp_81.notOp_81_in0
	// Insensitive connections
	always @(*) begin
		notOp_81_in0 = valid ? eq_80_out : eq_80_out;
	end
	// controller for notOp_84.notOp_84_in0
	// Insensitive connections
	always @(*) begin
		notOp_84_in0 = valid ? eq_83_out : eq_83_out;
	end
	// controller for notOp_88.notOp_88_in0
	// Insensitive connections
	always @(*) begin
		notOp_88_in0 = valid ? eq_87_out : eq_87_out;
	end
	// controller for notOp_92.notOp_92_in0
	// Insensitive connections
	always @(*) begin
		notOp_92_in0 = valid ? eq_91_out : eq_91_out;
	end
	// controller for notOp_95.notOp_95_in0
	// Insensitive connections
	always @(*) begin
		notOp_95_in0 = valid ? eq_94_out : eq_94_out;
	end
	// controller for notOp_98.notOp_98_in0
	// Insensitive connections
	always @(*) begin
		notOp_98_in0 = valid ? eq_97_out : eq_97_out;
	end
	// controller for orOp_54.orOp_54_in0
	// controller for orOp_54.orOp_54_in1
	// Insensitive connections
	always @(*) begin
		orOp_54_in0 = valid ? eq_53_out : eq_53_out;
		orOp_54_in1 = valid ? andOp_1_out : andOp_1_out;
	end
	// controller for orOp_56.orOp_56_in0
	// controller for orOp_56.orOp_56_in1
	// Insensitive connections
	always @(*) begin
		orOp_56_in0 = valid ? eq_55_out : eq_55_out;
		orOp_56_in1 = valid ? andOp_16_out : andOp_16_out;
	end
	// controller for orOp_58.orOp_58_in0
	// controller for orOp_58.orOp_58_in1
	// Insensitive connections
	always @(*) begin
		orOp_58_in0 = valid ? eq_57_out : eq_57_out;
		orOp_58_in1 = valid ? andOp_7_out : andOp_7_out;
	end
	// controller for orOp_61.orOp_61_in0
	// controller for orOp_61.orOp_61_in1
	// Insensitive connections
	always @(*) begin
		orOp_61_in0 = valid ? eq_60_out : eq_60_out;
		orOp_61_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for orOp_64.orOp_64_in0
	// controller for orOp_64.orOp_64_in1
	// Insensitive connections
	always @(*) begin
		orOp_64_in0 = valid ? eq_63_out : eq_63_out;
		orOp_64_in1 = valid ? andOp_19_out : andOp_19_out;
	end
	// controller for orOp_66.orOp_66_in0
	// controller for orOp_66.orOp_66_in1
	// Insensitive connections
	always @(*) begin
		orOp_66_in0 = valid ? eq_65_out : eq_65_out;
		orOp_66_in1 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for orOp_68.orOp_68_in0
	// controller for orOp_68.orOp_68_in1
	// Insensitive connections
	always @(*) begin
		orOp_68_in0 = valid ? eq_67_out : eq_67_out;
		orOp_68_in1 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for orOp_70.orOp_70_in0
	// controller for orOp_70.orOp_70_in1
	// Insensitive connections
	always @(*) begin
		orOp_70_in0 = valid ? eq_69_out : eq_69_out;
		orOp_70_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for orOp_72.orOp_72_in0
	// controller for orOp_72.orOp_72_in1
	// Insensitive connections
	always @(*) begin
		orOp_72_in0 = valid ? eq_71_out : eq_71_out;
		orOp_72_in1 = valid ? andOp_46_out : andOp_46_out;
	end
	// controller for orOp_74.orOp_74_in0
	// controller for orOp_74.orOp_74_in1
	// Insensitive connections
	always @(*) begin
		orOp_74_in0 = valid ? eq_73_out : eq_73_out;
		orOp_74_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_127_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_128_out) begin 
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
		phi_in_phi_8 = valid ? concat_120_out : concat_120_out;
		phi_last_block_phi_8 = valid ? bb_3_predecessor_in_state_1_out_data : bb_3_predecessor_in_state_1_out_data;
		phi_s_phi_8 = valid ? concat_121_out : concat_121_out;
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_113_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else if (andOp_115_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_112_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else if (andOp_114_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_112_out) begin 
			wdata_ram_0_reg = 32'd0;
		end else if (andOp_114_out) begin 
			wdata_ram_0_reg = add_out_add_13;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_112_out) begin 
			wen_ram_0_reg = 1'd1;
		end else if (andOp_114_out) begin 
			wen_ram_0_reg = 1'd1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_26.valid_reg
	always @(*) begin
		if (andOp_131_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_123.tmp_output_123_in_data
	always @(*) begin
		if (eq_124_out) begin 
			tmp_output_123_in_data = in_out_data;
		end else begin
			tmp_output_123_in_data = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_5 <= 0;
		end else begin
			if (andOp_154_out) begin
				add_tmp_5 <= add_out_add_15;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			call_tmp_2 <= 0;
		end else begin
			if (andOp_153_out) begin
				call_tmp_2 <= in_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_12_out) begin
				global_state <= 32'd2;
			end
			if (andOp_132_out) begin
				global_state <= 32'd1;
			end
			if (andOp_133_out) begin
				global_state <= 32'd3;
			end
			if (andOp_134_out) begin
				global_state <= 32'd4;
			end
			if (andOp_135_out) begin
				global_state <= 32'd4;
			end
			if (andOp_14_out) begin
				global_state <= 32'd1;
			end
			if (andOp_26_out) begin
				global_state <= 32'd1;
			end
			if (andOp_44_out) begin
				global_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_6 <= 0;
		end else begin
			if (andOp_155_out) begin
				icmp_tmp_6 <= cmp_out_icmp_16;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			phi_tmp_1 <= 0;
		end else begin
			if (andOp_152_out) begin
				phi_tmp_1 <= phi_out_phi_8;
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
			state_1_entry_BB_reg <= 0;
		end else begin
			if (andOp_132_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
			if (andOp_14_out) begin
				state_1_entry_BB_reg <= 32'd9;
			end
			if (andOp_26_out) begin
				state_1_entry_BB_reg <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_132_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_141_out) begin
				state_1_is_active <= 1'd0;
			end
			if (andOp_14_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_26_out) begin
				state_1_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_14_out) begin
				state_1_last_BB_reg <= 32'd9;
			end
			if (andOp_26_out) begin
				state_1_last_BB_reg <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_12_out) begin
				state_2_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_12_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_143_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_12_out) begin
				state_2_last_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_133_out) begin
				state_3_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_133_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_145_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_19_out) begin
				state_3_last_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_134_out) begin
				state_4_entry_BB_reg <= 32'd4;
			end
			if (andOp_135_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
			if (andOp_44_out) begin
				state_4_entry_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_134_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_135_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_151_out) begin
				state_4_is_active <= 1'd0;
			end
			if (andOp_44_out) begin
				state_4_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_44_out) begin
				state_4_last_BB_reg <= 32'd6;
			end
			if (andOp_46_out) begin
				state_4_last_BB_reg <= 32'd7;
			end
		end
	end

endmodule

