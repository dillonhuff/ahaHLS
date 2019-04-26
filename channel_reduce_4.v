module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready);

	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [0:0] valid_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;

	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign valid = valid_reg;
	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;

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

	add call_18();

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

	reg [0:0] bb_0_active_in_state_0_in_data;
	wire [0:0] bb_0_active_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_0(.in_data(bb_0_active_in_state_0_in_data), .out_data(bb_0_active_in_state_0_out_data));

	reg [31:0] bb_0_predecessor_in_state_0_in_data;
	wire [31:0] bb_0_predecessor_in_state_0_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_0(.in_data(bb_0_predecessor_in_state_0_in_data), .out_data(bb_0_predecessor_in_state_0_out_data));

	reg [0:0] bb_8_active_in_state_1_in_data;
	wire [0:0] bb_8_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_8_active_in_state_1(.in_data(bb_8_active_in_state_1_in_data), .out_data(bb_8_active_in_state_1_out_data));

	reg [31:0] bb_8_predecessor_in_state_1_in_data;
	wire [31:0] bb_8_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_8_predecessor_in_state_1(.in_data(bb_8_predecessor_in_state_1_in_data), .out_data(bb_8_predecessor_in_state_1_out_data));

	reg [0:0] bb_9_active_in_state_1_in_data;
	wire [0:0] bb_9_active_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) bb_9_active_in_state_1(.in_data(bb_9_active_in_state_1_in_data), .out_data(bb_9_active_in_state_1_out_data));

	reg [31:0] bb_9_predecessor_in_state_1_in_data;
	wire [31:0] bb_9_predecessor_in_state_1_out_data;
	hls_wire #(.WIDTH(32)) bb_9_predecessor_in_state_1(.in_data(bb_9_predecessor_in_state_1_in_data), .out_data(bb_9_predecessor_in_state_1_out_data));

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

	reg [0:0] bb_1_active_in_state_4_in_data;
	wire [0:0] bb_1_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_4(.in_data(bb_1_active_in_state_4_in_data), .out_data(bb_1_active_in_state_4_out_data));

	reg [31:0] bb_1_predecessor_in_state_4_in_data;
	wire [31:0] bb_1_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_4(.in_data(bb_1_predecessor_in_state_4_in_data), .out_data(bb_1_predecessor_in_state_4_out_data));

	reg [0:0] bb_7_active_in_state_4_in_data;
	wire [0:0] bb_7_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_7_active_in_state_4(.in_data(bb_7_active_in_state_4_in_data), .out_data(bb_7_active_in_state_4_out_data));

	reg [31:0] bb_7_predecessor_in_state_4_in_data;
	wire [31:0] bb_7_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_7_predecessor_in_state_4(.in_data(bb_7_predecessor_in_state_4_in_data), .out_data(bb_7_predecessor_in_state_4_out_data));

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

	reg [0:0] bb_2_active_in_state_4_in_data;
	wire [0:0] bb_2_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active_in_state_4(.in_data(bb_2_active_in_state_4_in_data), .out_data(bb_2_active_in_state_4_out_data));

	reg [31:0] bb_2_predecessor_in_state_4_in_data;
	wire [31:0] bb_2_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_2_predecessor_in_state_4(.in_data(bb_2_predecessor_in_state_4_in_data), .out_data(bb_2_predecessor_in_state_4_out_data));

	reg [0:0] andOp_5_in0;
	reg [0:0] andOp_5_in1;
	wire [0:0] andOp_5_out;
	andOp #(.WIDTH(1)) andOp_5(.in0(andOp_5_in0), .in1(andOp_5_in1), .out(andOp_5_out));

	reg [0:0] andOp_6_in0;
	reg [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

	reg [0:0] notOp_7_in0;
	wire [0:0] notOp_7_out;
	notOp #(.WIDTH(1)) notOp_7(.in(notOp_7_in0), .out(notOp_7_out));

	reg [0:0] andOp_8_in0;
	reg [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	reg [0:0] andOp_9_in0;
	reg [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	reg [0:0] br_8_happened_in_state_1_in_data;
	wire [0:0] br_8_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened_in_state_1(.in_data(br_8_happened_in_state_1_in_data), .out_data(br_8_happened_in_state_1_out_data));

	reg [0:0] notOp_10_in0;
	wire [0:0] notOp_10_out;
	notOp #(.WIDTH(1)) notOp_10(.in(notOp_10_in0), .out(notOp_10_out));

	reg [0:0] andOp_11_in0;
	reg [0:0] andOp_11_in1;
	wire [0:0] andOp_11_out;
	andOp #(.WIDTH(1)) andOp_11(.in0(andOp_11_in0), .in1(andOp_11_in1), .out(andOp_11_out));

	reg [0:0] andOp_12_in0;
	reg [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	reg [0:0] br_9_happened_in_state_1_in_data;
	wire [0:0] br_9_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened_in_state_1(.in_data(br_9_happened_in_state_1_in_data), .out_data(br_9_happened_in_state_1_out_data));

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

	reg [0:0] andOp_17_in0;
	reg [0:0] andOp_17_in1;
	wire [0:0] andOp_17_out;
	andOp #(.WIDTH(1)) andOp_17(.in0(andOp_17_in0), .in1(andOp_17_in1), .out(andOp_17_out));

	reg [0:0] andOp_18_in0;
	reg [0:0] andOp_18_in1;
	wire [0:0] andOp_18_out;
	andOp #(.WIDTH(1)) andOp_18(.in0(andOp_18_in0), .in1(andOp_18_in1), .out(andOp_18_out));

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	reg [0:0] notOp_19_in0;
	wire [0:0] notOp_19_out;
	notOp #(.WIDTH(1)) notOp_19(.in(notOp_19_in0), .out(notOp_19_out));

	reg [0:0] andOp_20_in0;
	reg [0:0] andOp_20_in1;
	wire [0:0] andOp_20_out;
	andOp #(.WIDTH(1)) andOp_20(.in0(andOp_20_in0), .in1(andOp_20_in1), .out(andOp_20_out));

	reg [0:0] andOp_21_in0;
	reg [0:0] andOp_21_in1;
	wire [0:0] andOp_21_out;
	andOp #(.WIDTH(1)) andOp_21(.in0(andOp_21_in0), .in1(andOp_21_in1), .out(andOp_21_out));

	reg [0:0] br_3_happened_in_state_1_in_data;
	wire [0:0] br_3_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_1(.in_data(br_3_happened_in_state_1_in_data), .out_data(br_3_happened_in_state_1_out_data));

	reg [0:0] notOp_22_in0;
	wire [0:0] notOp_22_out;
	notOp #(.WIDTH(1)) notOp_22(.in(notOp_22_in0), .out(notOp_22_out));

	reg [0:0] andOp_23_in0;
	reg [0:0] andOp_23_in1;
	wire [0:0] andOp_23_out;
	andOp #(.WIDTH(1)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	reg [0:0] andOp_24_in0;
	reg [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

	reg [0:0] br_10_happened_in_state_2_in_data;
	wire [0:0] br_10_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_2(.in_data(br_10_happened_in_state_2_in_data), .out_data(br_10_happened_in_state_2_out_data));

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

	reg [0:0] br_4_happened_in_state_3_in_data;
	wire [0:0] br_4_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_3(.in_data(br_4_happened_in_state_3_in_data), .out_data(br_4_happened_in_state_3_out_data));

	reg [0:0] notOp_28_in0;
	wire [0:0] notOp_28_out;
	notOp #(.WIDTH(1)) notOp_28(.in(notOp_28_in0), .out(notOp_28_out));

	reg [0:0] andOp_29_in0;
	reg [0:0] andOp_29_in1;
	wire [0:0] andOp_29_out;
	andOp #(.WIDTH(1)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	reg [0:0] notOp_30_in0;
	wire [0:0] notOp_30_out;
	notOp #(.WIDTH(1)) notOp_30(.in(notOp_30_in0), .out(notOp_30_out));

	reg [0:0] andOp_31_in0;
	reg [0:0] andOp_31_in1;
	wire [0:0] andOp_31_out;
	andOp #(.WIDTH(1)) andOp_31(.in0(andOp_31_in0), .in1(andOp_31_in1), .out(andOp_31_out));

	reg [0:0] andOp_32_in0;
	reg [0:0] andOp_32_in1;
	wire [0:0] andOp_32_out;
	andOp #(.WIDTH(1)) andOp_32(.in0(andOp_32_in0), .in1(andOp_32_in1), .out(andOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [0:0] br_10_happened_in_state_3_in_data;
	wire [0:0] br_10_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_3(.in_data(br_10_happened_in_state_3_in_data), .out_data(br_10_happened_in_state_3_out_data));

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

	reg [0:0] br_4_happened_in_state_4_in_data;
	wire [0:0] br_4_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_4(.in_data(br_4_happened_in_state_4_in_data), .out_data(br_4_happened_in_state_4_out_data));

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

	reg [0:0] andOp_41_in0;
	reg [0:0] andOp_41_in1;
	wire [0:0] andOp_41_out;
	andOp #(.WIDTH(1)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [0:0] br_1_happened_in_state_4_in_data;
	wire [0:0] br_1_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_4(.in_data(br_1_happened_in_state_4_in_data), .out_data(br_1_happened_in_state_4_out_data));

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

	reg [0:0] br_7_happened_in_state_4_in_data;
	wire [0:0] br_7_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_4(.in_data(br_7_happened_in_state_4_in_data), .out_data(br_7_happened_in_state_4_out_data));

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

	reg [0:0] br_5_happened_in_state_4_in_data;
	wire [0:0] br_5_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened_in_state_4(.in_data(br_5_happened_in_state_4_in_data), .out_data(br_5_happened_in_state_4_out_data));

	reg [0:0] notOp_49_in0;
	wire [0:0] notOp_49_out;
	notOp #(.WIDTH(1)) notOp_49(.in(notOp_49_in0), .out(notOp_49_out));

	reg [0:0] andOp_50_in0;
	reg [0:0] andOp_50_in1;
	wire [0:0] andOp_50_out;
	andOp #(.WIDTH(1)) andOp_50(.in0(andOp_50_in0), .in1(andOp_50_in1), .out(andOp_50_out));

	reg [0:0] andOp_51_in0;
	reg [0:0] andOp_51_in1;
	wire [0:0] andOp_51_out;
	andOp #(.WIDTH(1)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	reg [0:0] br_6_happened_in_state_4_in_data;
	wire [0:0] br_6_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened_in_state_4(.in_data(br_6_happened_in_state_4_in_data), .out_data(br_6_happened_in_state_4_out_data));

	reg [0:0] notOp_52_in0;
	wire [0:0] notOp_52_out;
	notOp #(.WIDTH(1)) notOp_52(.in(notOp_52_in0), .out(notOp_52_out));

	reg [0:0] andOp_53_in0;
	reg [0:0] andOp_53_in1;
	wire [0:0] andOp_53_out;
	andOp #(.WIDTH(1)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	reg [0:0] notOp_54_in0;
	wire [0:0] notOp_54_out;
	notOp #(.WIDTH(1)) notOp_54(.in(notOp_54_in0), .out(notOp_54_out));

	reg [0:0] andOp_55_in0;
	reg [0:0] andOp_55_in1;
	wire [0:0] andOp_55_out;
	andOp #(.WIDTH(1)) andOp_55(.in0(andOp_55_in0), .in1(andOp_55_in1), .out(andOp_55_out));

	reg [31:0] eq_56_in0;
	reg [31:0] eq_56_in1;
	wire [0:0] eq_56_out;
	eq #(.WIDTH(32)) eq_56(.in0(eq_56_in0), .in1(eq_56_in1), .out(eq_56_out));

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

	reg [31:0] eq_62_in0;
	reg [31:0] eq_62_in1;
	wire [0:0] eq_62_out;
	eq #(.WIDTH(32)) eq_62(.in0(eq_62_in0), .in1(eq_62_in1), .out(eq_62_out));

	reg [0:0] orOp_63_in0;
	reg [0:0] orOp_63_in1;
	wire [0:0] orOp_63_out;
	orOp #(.WIDTH(1)) orOp_63(.in0(orOp_63_in0), .in1(orOp_63_in1), .out(orOp_63_out));

	reg [31:0] eq_64_in0;
	reg [31:0] eq_64_in1;
	wire [0:0] eq_64_out;
	eq #(.WIDTH(32)) eq_64(.in0(eq_64_in0), .in1(eq_64_in1), .out(eq_64_out));

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

	reg [31:0] eq_68_in0;
	reg [31:0] eq_68_in1;
	wire [0:0] eq_68_out;
	eq #(.WIDTH(32)) eq_68(.in0(eq_68_in0), .in1(eq_68_in1), .out(eq_68_out));

	reg [0:0] orOp_69_in0;
	reg [0:0] orOp_69_in1;
	wire [0:0] orOp_69_out;
	orOp #(.WIDTH(1)) orOp_69(.in0(orOp_69_in0), .in1(orOp_69_in1), .out(orOp_69_out));

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

	reg [0:0] orOp_75_in0;
	reg [0:0] orOp_75_in1;
	wire [0:0] orOp_75_out;
	orOp #(.WIDTH(1)) orOp_75(.in0(orOp_75_in0), .in1(orOp_75_in1), .out(orOp_75_out));

	reg [31:0] eq_76_in0;
	reg [31:0] eq_76_in1;
	wire [0:0] eq_76_out;
	eq #(.WIDTH(32)) eq_76(.in0(eq_76_in0), .in1(eq_76_in1), .out(eq_76_out));

	reg [0:0] orOp_77_in0;
	reg [0:0] orOp_77_in1;
	wire [0:0] orOp_77_out;
	orOp #(.WIDTH(1)) orOp_77(.in0(orOp_77_in0), .in1(orOp_77_in1), .out(orOp_77_out));

	reg [31:0] eq_78_in0;
	reg [31:0] eq_78_in1;
	wire [0:0] eq_78_out;
	eq #(.WIDTH(32)) eq_78(.in0(eq_78_in0), .in1(eq_78_in1), .out(eq_78_out));

	reg [0:0] orOp_79_in0;
	reg [0:0] orOp_79_in1;
	wire [0:0] orOp_79_out;
	orOp #(.WIDTH(1)) orOp_79(.in0(orOp_79_in0), .in1(orOp_79_in1), .out(orOp_79_out));

	reg [0:0] andOp_80_in0;
	reg [0:0] andOp_80_in1;
	wire [0:0] andOp_80_out;
	andOp #(.WIDTH(1)) andOp_80(.in0(andOp_80_in0), .in1(andOp_80_in1), .out(andOp_80_out));

	reg [0:0] andOp_81_in0;
	reg [0:0] andOp_81_in1;
	wire [0:0] andOp_81_out;
	andOp #(.WIDTH(1)) andOp_81(.in0(andOp_81_in0), .in1(andOp_81_in1), .out(andOp_81_out));

	reg [0:0] andOp_82_in0;
	reg [0:0] andOp_82_in1;
	wire [0:0] andOp_82_out;
	andOp #(.WIDTH(1)) andOp_82(.in0(andOp_82_in0), .in1(andOp_82_in1), .out(andOp_82_out));

	reg [0:0] andOp_83_in0;
	reg [0:0] andOp_83_in1;
	wire [0:0] andOp_83_out;
	andOp #(.WIDTH(1)) andOp_83(.in0(andOp_83_in0), .in1(andOp_83_in1), .out(andOp_83_out));

	reg [0:0] andOp_84_in0;
	reg [0:0] andOp_84_in1;
	wire [0:0] andOp_84_out;
	andOp #(.WIDTH(1)) andOp_84(.in0(andOp_84_in0), .in1(andOp_84_in1), .out(andOp_84_out));

	reg [0:0] andOp_85_in0;
	reg [0:0] andOp_85_in1;
	wire [0:0] andOp_85_out;
	andOp #(.WIDTH(1)) andOp_85(.in0(andOp_85_in0), .in1(andOp_85_in1), .out(andOp_85_out));

	reg [0:0] andOp_86_in0;
	reg [0:0] andOp_86_in1;
	wire [0:0] andOp_86_out;
	andOp #(.WIDTH(1)) andOp_86(.in0(andOp_86_in0), .in1(andOp_86_in1), .out(andOp_86_out));

	reg [31:0] eq_87_in0;
	reg [31:0] eq_87_in1;
	wire [0:0] eq_87_out;
	eq #(.WIDTH(32)) eq_87(.in0(eq_87_in0), .in1(eq_87_in1), .out(eq_87_out));

	reg [31:0] eq_88_in0;
	reg [31:0] eq_88_in1;
	wire [0:0] eq_88_out;
	eq #(.WIDTH(32)) eq_88(.in0(eq_88_in0), .in1(eq_88_in1), .out(eq_88_out));

	reg [0:0] notOp_89_in0;
	wire [0:0] notOp_89_out;
	notOp #(.WIDTH(1)) notOp_89(.in(notOp_89_in0), .out(notOp_89_out));

	reg [0:0] andOp_90_in0;
	reg [0:0] andOp_90_in1;
	wire [0:0] andOp_90_out;
	andOp #(.WIDTH(1)) andOp_90(.in0(andOp_90_in0), .in1(andOp_90_in1), .out(andOp_90_out));

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

	reg [31:0] eq_95_in0;
	reg [31:0] eq_95_in1;
	wire [0:0] eq_95_out;
	eq #(.WIDTH(32)) eq_95(.in0(eq_95_in0), .in1(eq_95_in1), .out(eq_95_out));

	reg [0:0] notOp_96_in0;
	wire [0:0] notOp_96_out;
	notOp #(.WIDTH(1)) notOp_96(.in(notOp_96_in0), .out(notOp_96_out));

	reg [0:0] andOp_97_in0;
	reg [0:0] andOp_97_in1;
	wire [0:0] andOp_97_out;
	andOp #(.WIDTH(1)) andOp_97(.in0(andOp_97_in0), .in1(andOp_97_in1), .out(andOp_97_out));

	reg [31:0] eq_98_in0;
	reg [31:0] eq_98_in1;
	wire [0:0] eq_98_out;
	eq #(.WIDTH(32)) eq_98(.in0(eq_98_in0), .in1(eq_98_in1), .out(eq_98_out));

	reg [31:0] eq_99_in0;
	reg [31:0] eq_99_in1;
	wire [0:0] eq_99_out;
	eq #(.WIDTH(32)) eq_99(.in0(eq_99_in0), .in1(eq_99_in1), .out(eq_99_out));

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

	reg [31:0] eq_109_in0;
	reg [31:0] eq_109_in1;
	wire [0:0] eq_109_out;
	eq #(.WIDTH(32)) eq_109(.in0(eq_109_in0), .in1(eq_109_in1), .out(eq_109_out));

	reg [0:0] notOp_110_in0;
	wire [0:0] notOp_110_out;
	notOp #(.WIDTH(1)) notOp_110(.in(notOp_110_in0), .out(notOp_110_out));

	reg [0:0] andOp_111_in0;
	reg [0:0] andOp_111_in1;
	wire [0:0] andOp_111_out;
	andOp #(.WIDTH(1)) andOp_111(.in0(andOp_111_in0), .in1(andOp_111_in1), .out(andOp_111_out));

	reg [31:0] eq_112_in0;
	reg [31:0] eq_112_in1;
	wire [0:0] eq_112_out;
	eq #(.WIDTH(32)) eq_112(.in0(eq_112_in0), .in1(eq_112_in1), .out(eq_112_out));

	reg [0:0] notOp_113_in0;
	wire [0:0] notOp_113_out;
	notOp #(.WIDTH(1)) notOp_113(.in(notOp_113_in0), .out(notOp_113_out));

	reg [0:0] andOp_114_in0;
	reg [0:0] andOp_114_in1;
	wire [0:0] andOp_114_out;
	andOp #(.WIDTH(1)) andOp_114(.in0(andOp_114_in0), .in1(andOp_114_in1), .out(andOp_114_out));

	reg [31:0] eq_115_in0;
	reg [31:0] eq_115_in1;
	wire [0:0] eq_115_out;
	eq #(.WIDTH(32)) eq_115(.in0(eq_115_in0), .in1(eq_115_in1), .out(eq_115_out));

	reg [0:0] notOp_116_in0;
	wire [0:0] notOp_116_out;
	notOp #(.WIDTH(1)) notOp_116(.in(notOp_116_in0), .out(notOp_116_out));

	reg [0:0] andOp_117_in0;
	reg [0:0] andOp_117_in1;
	wire [0:0] andOp_117_out;
	andOp #(.WIDTH(1)) andOp_117(.in0(andOp_117_in0), .in1(andOp_117_in1), .out(andOp_117_out));

	reg [31:0] eq_118_in0;
	reg [31:0] eq_118_in1;
	wire [0:0] eq_118_out;
	eq #(.WIDTH(32)) eq_118(.in0(eq_118_in0), .in1(eq_118_in1), .out(eq_118_out));

	reg [0:0] notOp_119_in0;
	wire [0:0] notOp_119_out;
	notOp #(.WIDTH(1)) notOp_119(.in(notOp_119_in0), .out(notOp_119_out));

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

	reg [31:0] concat_132_in0;
	reg [31:0] concat_132_in1;
	wire [63:0] concat_132_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_132(.in0(concat_132_in0), .in1(concat_132_in1), .out(concat_132_out));

	reg [31:0] concat_133_in0;
	reg [31:0] concat_133_in1;
	wire [63:0] concat_133_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_133(.in0(concat_133_in0), .in1(concat_133_in1), .out(concat_133_out));

	reg [0:0] andOp_134_in0;
	reg [0:0] andOp_134_in1;
	wire [0:0] andOp_134_out;
	andOp #(.WIDTH(1)) andOp_134(.in0(andOp_134_in0), .in1(andOp_134_in1), .out(andOp_134_out));

	reg [31:0] tmp_output_135_in_data;
	wire [31:0] tmp_output_135_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_135(.in_data(tmp_output_135_in_data), .out_data(tmp_output_135_out_data));

	reg [31:0] eq_136_in0;
	reg [31:0] eq_136_in1;
	wire [0:0] eq_136_out;
	eq #(.WIDTH(32)) eq_136(.in0(eq_136_in0), .in1(eq_136_in1), .out(eq_136_out));

	reg [0:0] andOp_137_in0;
	reg [0:0] andOp_137_in1;
	wire [0:0] andOp_137_out;
	andOp #(.WIDTH(1)) andOp_137(.in0(andOp_137_in0), .in1(andOp_137_in1), .out(andOp_137_out));

	reg [0:0] andOp_138_in0;
	reg [0:0] andOp_138_in1;
	wire [0:0] andOp_138_out;
	andOp #(.WIDTH(1)) andOp_138(.in0(andOp_138_in0), .in1(andOp_138_in1), .out(andOp_138_out));

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
	reg [31:0] state_0_last_BB_reg;
	reg [31:0] state_1_entry_BB_reg;
	reg [31:0] state_1_last_BB_reg;
	reg [31:0] state_2_entry_BB_reg;
	reg [31:0] state_2_last_BB_reg;
	reg [31:0] state_3_entry_BB_reg;
	reg [31:0] state_3_last_BB_reg;
	reg [31:0] state_4_entry_BB_reg;
	reg [31:0] state_4_last_BB_reg;

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? rdata_ram_0 : rdata_ram_0;
		add_in1_add_14 = valid ? tmp_output_135_out_data : tmp_output_135_out_data;
	end
	// controller for add_add_16.add_in0_add_16
	// controller for add_add_16.add_in1_add_16
	// Insensitive connections
	always @(*) begin
		add_in0_add_16 = valid ? phi_tmp_1 : phi_tmp_1;
		add_in1_add_16 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	always @(*) begin
		andOp_101_in0 = valid ? notOp_100_out : notOp_100_out;
		andOp_101_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for andOp_105.andOp_105_in0
	// controller for andOp_105.andOp_105_in1
	// Insensitive connections
	always @(*) begin
		andOp_105_in0 = valid ? notOp_104_out : notOp_104_out;
		andOp_105_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for andOp_108.andOp_108_in0
	// controller for andOp_108.andOp_108_in1
	// Insensitive connections
	always @(*) begin
		andOp_108_in0 = valid ? notOp_107_out : notOp_107_out;
		andOp_108_in1 = valid ? andOp_29_out : andOp_29_out;
	end
	// controller for andOp_11.andOp_11_in0
	// controller for andOp_11.andOp_11_in1
	// Insensitive connections
	always @(*) begin
		andOp_11_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_11_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? notOp_110_out : notOp_110_out;
		andOp_111_in1 = valid ? andOp_53_out : andOp_53_out;
	end
	// controller for andOp_114.andOp_114_in0
	// controller for andOp_114.andOp_114_in1
	// Insensitive connections
	always @(*) begin
		andOp_114_in0 = valid ? notOp_113_out : notOp_113_out;
		andOp_114_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for andOp_117.andOp_117_in0
	// controller for andOp_117.andOp_117_in1
	// Insensitive connections
	always @(*) begin
		andOp_117_in0 = valid ? notOp_116_out : notOp_116_out;
		andOp_117_in1 = valid ? andOp_48_out : andOp_48_out;
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
		andOp_120_in0 = valid ? notOp_119_out : notOp_119_out;
		andOp_120_in1 = valid ? andOp_45_out : andOp_45_out;
	end
	// controller for andOp_121.andOp_121_in0
	// controller for andOp_121.andOp_121_in1
	// Insensitive connections
	always @(*) begin
		andOp_121_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_121_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_122_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_123.andOp_123_in0
	// controller for andOp_123.andOp_123_in1
	// Insensitive connections
	always @(*) begin
		andOp_123_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_123_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_124.andOp_124_in0
	// controller for andOp_124.andOp_124_in1
	// Insensitive connections
	always @(*) begin
		andOp_124_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_124_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_125_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_126.andOp_126_in0
	// controller for andOp_126.andOp_126_in1
	// Insensitive connections
	always @(*) begin
		andOp_126_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_126_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_127.andOp_127_in0
	// controller for andOp_127.andOp_127_in1
	// Insensitive connections
	always @(*) begin
		andOp_127_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_127_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_128_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	always @(*) begin
		andOp_129_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_129_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_130_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_131.andOp_131_in0
	// controller for andOp_131.andOp_131_in1
	// Insensitive connections
	always @(*) begin
		andOp_131_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_131_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_134.andOp_134_in0
	// controller for andOp_134.andOp_134_in1
	// Insensitive connections
	always @(*) begin
		andOp_134_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_134_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_137.andOp_137_in0
	// controller for andOp_137.andOp_137_in1
	// Insensitive connections
	always @(*) begin
		andOp_137_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_137_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_138.andOp_138_in0
	// controller for andOp_138.andOp_138_in1
	// Insensitive connections
	always @(*) begin
		andOp_138_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_138_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_139_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	always @(*) begin
		andOp_14_in0 = valid ? andOp_12_out : andOp_12_out;
		andOp_14_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_140.andOp_140_in0
	// controller for andOp_140.andOp_140_in1
	// Insensitive connections
	always @(*) begin
		andOp_140_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_140_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_141_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_142_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_143.andOp_143_in0
	// controller for andOp_143.andOp_143_in1
	// Insensitive connections
	always @(*) begin
		andOp_143_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_143_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_144.andOp_144_in0
	// controller for andOp_144.andOp_144_in1
	// Insensitive connections
	always @(*) begin
		andOp_144_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_144_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? andOp_144_out : andOp_144_out;
		andOp_145_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_146.andOp_146_in0
	// controller for andOp_146.andOp_146_in1
	// Insensitive connections
	always @(*) begin
		andOp_146_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_146_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_147.andOp_147_in0
	// controller for andOp_147.andOp_147_in1
	// Insensitive connections
	always @(*) begin
		andOp_147_in0 = valid ? andOp_146_out : andOp_146_out;
		andOp_147_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_148.andOp_148_in0
	// controller for andOp_148.andOp_148_in1
	// Insensitive connections
	always @(*) begin
		andOp_148_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_148_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_149.andOp_149_in0
	// controller for andOp_149.andOp_149_in1
	// Insensitive connections
	always @(*) begin
		andOp_149_in0 = valid ? andOp_148_out : andOp_148_out;
		andOp_149_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_150.andOp_150_in0
	// controller for andOp_150.andOp_150_in1
	// Insensitive connections
	always @(*) begin
		andOp_150_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_150_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_151.andOp_151_in0
	// controller for andOp_151.andOp_151_in1
	// Insensitive connections
	always @(*) begin
		andOp_151_in0 = valid ? andOp_150_out : andOp_150_out;
		andOp_151_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_152_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_153.andOp_153_in0
	// controller for andOp_153.andOp_153_in1
	// Insensitive connections
	always @(*) begin
		andOp_153_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_153_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_154.andOp_154_in0
	// controller for andOp_154.andOp_154_in1
	// Insensitive connections
	always @(*) begin
		andOp_154_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_154_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_155.andOp_155_in0
	// controller for andOp_155.andOp_155_in1
	// Insensitive connections
	always @(*) begin
		andOp_155_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_155_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	always @(*) begin
		andOp_16_in0 = valid ? andOp_12_out : andOp_12_out;
		andOp_16_in1 = valid ? notOp_15_out : notOp_15_out;
	end
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	always @(*) begin
		andOp_17_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_17_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	always @(*) begin
		andOp_18_in0 = valid ? andOp_17_out : andOp_17_out;
		andOp_18_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	always @(*) begin
		andOp_20_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_20_in1 = valid ? eq_1_out : eq_1_out;
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
		andOp_23_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_23_in1 = valid ? eq_3_out : eq_3_out;
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
		andOp_26_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_26_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_27.andOp_27_in0
	// controller for andOp_27.andOp_27_in1
	// Insensitive connections
	always @(*) begin
		andOp_27_in0 = valid ? andOp_26_out : andOp_26_out;
		andOp_27_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_29.andOp_29_in0
	// controller for andOp_29.andOp_29_in1
	// Insensitive connections
	always @(*) begin
		andOp_29_in0 = valid ? andOp_27_out : andOp_27_out;
		andOp_29_in1 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for andOp_31.andOp_31_in0
	// controller for andOp_31.andOp_31_in1
	// Insensitive connections
	always @(*) begin
		andOp_31_in0 = valid ? andOp_27_out : andOp_27_out;
		andOp_31_in1 = valid ? notOp_30_out : notOp_30_out;
	end
	// controller for andOp_32.andOp_32_in0
	// controller for andOp_32.andOp_32_in1
	// Insensitive connections
	always @(*) begin
		andOp_32_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_32_in1 = valid ? eq_3_out : eq_3_out;
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
		andOp_35_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_35_in1 = valid ? eq_4_out : eq_4_out;
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
		andOp_38_in1 = valid ? icmp_tmp_6 : icmp_tmp_6;
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
		andOp_41_in0 = valid ? bb_1_active_in_state_4_out_data : bb_1_active_in_state_4_out_data;
		andOp_41_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_42.andOp_42_in0
	// controller for andOp_42.andOp_42_in1
	// Insensitive connections
	always @(*) begin
		andOp_42_in0 = valid ? andOp_41_out : andOp_41_out;
		andOp_42_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_44.andOp_44_in0
	// controller for andOp_44.andOp_44_in1
	// Insensitive connections
	always @(*) begin
		andOp_44_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_44_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_45.andOp_45_in0
	// controller for andOp_45.andOp_45_in1
	// Insensitive connections
	always @(*) begin
		andOp_45_in0 = valid ? andOp_44_out : andOp_44_out;
		andOp_45_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_47.andOp_47_in0
	// controller for andOp_47.andOp_47_in1
	// Insensitive connections
	always @(*) begin
		andOp_47_in0 = valid ? bb_5_active_in_state_4_out_data : bb_5_active_in_state_4_out_data;
		andOp_47_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_48.andOp_48_in0
	// controller for andOp_48.andOp_48_in1
	// Insensitive connections
	always @(*) begin
		andOp_48_in0 = valid ? andOp_47_out : andOp_47_out;
		andOp_48_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_5.andOp_5_in0
	// controller for andOp_5.andOp_5_in1
	// Insensitive connections
	always @(*) begin
		andOp_5_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_5_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	always @(*) begin
		andOp_50_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_50_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_51.andOp_51_in0
	// controller for andOp_51.andOp_51_in1
	// Insensitive connections
	always @(*) begin
		andOp_51_in0 = valid ? andOp_50_out : andOp_50_out;
		andOp_51_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_53.andOp_53_in0
	// controller for andOp_53.andOp_53_in1
	// Insensitive connections
	always @(*) begin
		andOp_53_in0 = valid ? andOp_51_out : andOp_51_out;
		andOp_53_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_55.andOp_55_in0
	// controller for andOp_55.andOp_55_in1
	// Insensitive connections
	always @(*) begin
		andOp_55_in0 = valid ? andOp_51_out : andOp_51_out;
		andOp_55_in1 = valid ? notOp_54_out : notOp_54_out;
	end
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	always @(*) begin
		andOp_6_in0 = valid ? andOp_5_out : andOp_5_out;
		andOp_6_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	always @(*) begin
		andOp_8_in0 = valid ? bb_8_active_in_state_1_out_data : bb_8_active_in_state_1_out_data;
		andOp_8_in1 = valid ? eq_1_out : eq_1_out;
	end
	// controller for andOp_80.andOp_80_in0
	// controller for andOp_80.andOp_80_in1
	// Insensitive connections
	always @(*) begin
		andOp_80_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_80_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_81.andOp_81_in0
	// controller for andOp_81.andOp_81_in1
	// Insensitive connections
	always @(*) begin
		andOp_81_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_81_in1 = valid ? eq_0_out : eq_0_out;
	end
	// controller for andOp_82.andOp_82_in0
	// controller for andOp_82.andOp_82_in1
	// Insensitive connections
	always @(*) begin
		andOp_82_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_82_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_83.andOp_83_in0
	// controller for andOp_83.andOp_83_in1
	// Insensitive connections
	always @(*) begin
		andOp_83_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_83_in1 = valid ? eq_2_out : eq_2_out;
	end
	// controller for andOp_84.andOp_84_in0
	// controller for andOp_84.andOp_84_in1
	// Insensitive connections
	always @(*) begin
		andOp_84_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_84_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_85.andOp_85_in0
	// controller for andOp_85.andOp_85_in1
	// Insensitive connections
	always @(*) begin
		andOp_85_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_85_in1 = valid ? eq_3_out : eq_3_out;
	end
	// controller for andOp_86.andOp_86_in0
	// controller for andOp_86.andOp_86_in1
	// Insensitive connections
	always @(*) begin
		andOp_86_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_86_in1 = valid ? eq_4_out : eq_4_out;
	end
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	always @(*) begin
		andOp_9_in0 = valid ? andOp_8_out : andOp_8_out;
		andOp_9_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_90.andOp_90_in0
	// controller for andOp_90.andOp_90_in1
	// Insensitive connections
	always @(*) begin
		andOp_90_in0 = valid ? notOp_89_out : notOp_89_out;
		andOp_90_in1 = valid ? andOp_21_out : andOp_21_out;
	end
	// controller for andOp_93.andOp_93_in0
	// controller for andOp_93.andOp_93_in1
	// Insensitive connections
	always @(*) begin
		andOp_93_in0 = valid ? notOp_92_out : notOp_92_out;
		andOp_93_in1 = valid ? andOp_9_out : andOp_9_out;
	end
	// controller for andOp_97.andOp_97_in0
	// controller for andOp_97.andOp_97_in1
	// Insensitive connections
	always @(*) begin
		andOp_97_in0 = valid ? notOp_96_out : notOp_96_out;
		andOp_97_in1 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_56_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_61_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_87_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_94_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_2.bb_10_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_2_in_data = eq_64_out;
		end else begin
			bb_10_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_3.bb_10_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_3_in_data = eq_67_out;
		end else begin
			bb_10_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_2.bb_10_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_98_out) begin 
			bb_10_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_3.bb_10_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_102_out) begin 
			bb_10_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = orOp_71_out;
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
			bb_2_active_in_state_4_in_data = orOp_79_out;
		end else begin
			bb_2_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_4.bb_2_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_120_out) begin 
			bb_2_predecessor_in_state_4_in_data = 32'd7;
		end else if (eq_118_out) begin 
			bb_2_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_1.bb_3_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_1_in_data = orOp_63_out;
		end else begin
			bb_3_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_1.bb_3_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_97_out) begin 
			bb_3_predecessor_in_state_1_in_data = 32'd0;
		end else if (eq_95_out) begin 
			bb_3_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_3.bb_4_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_3_in_data = orOp_66_out;
		end else begin
			bb_4_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_4.bb_4_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_4_in_data = orOp_69_out;
		end else begin
			bb_4_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_3.bb_4_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_101_out) begin 
			bb_4_predecessor_in_state_3_in_data = 32'd10;
		end else if (eq_99_out) begin 
			bb_4_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_4.bb_4_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_105_out) begin 
			bb_4_predecessor_in_state_4_in_data = 32'd10;
		end else if (eq_103_out) begin 
			bb_4_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_active_in_state_4.bb_5_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_state_4_in_data = orOp_75_out;
		end else begin
			bb_5_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_predecessor_in_state_4.bb_5_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_114_out) begin 
			bb_5_predecessor_in_state_4_in_data = 32'd1;
		end else if (eq_112_out) begin 
			bb_5_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_5_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_active_in_state_4.bb_6_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_state_4_in_data = orOp_77_out;
		end else begin
			bb_6_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_predecessor_in_state_4.bb_6_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_117_out) begin 
			bb_6_predecessor_in_state_4_in_data = 32'd5;
		end else if (eq_115_out) begin 
			bb_6_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_6_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_4.bb_7_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_4_in_data = orOp_73_out;
		end else begin
			bb_7_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_predecessor_in_state_4.bb_7_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_111_out) begin 
			bb_7_predecessor_in_state_4_in_data = 32'd6;
		end else if (eq_109_out) begin 
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
		if (andOp_90_out) begin 
			bb_8_predecessor_in_state_1_in_data = 32'd3;
		end else if (eq_88_out) begin 
			bb_8_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_8_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_active_in_state_1.bb_9_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_state_1_in_data = orOp_60_out;
		end else begin
			bb_9_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_predecessor_in_state_1.bb_9_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_93_out) begin 
			bb_9_predecessor_in_state_1_in_data = 32'd8;
		end else if (eq_91_out) begin 
			bb_9_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_9_predecessor_in_state_1_in_data = 0;
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
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_18_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_19_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_2.br_10_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_24_out) begin 
			br_10_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_25_out) begin 
			br_10_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_3.br_10_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_33_out) begin 
			br_10_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_34_out) begin 
			br_10_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_4.br_1_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_42_out) begin 
			br_1_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_43_out) begin 
			br_1_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_3_happened_in_state_1.br_3_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_21_out) begin 
			br_3_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_22_out) begin 
			br_3_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_3.br_4_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_27_out) begin 
			br_4_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_28_out) begin 
			br_4_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_4.br_4_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_36_out) begin 
			br_4_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_37_out) begin 
			br_4_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_5_happened_in_state_4.br_5_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_48_out) begin 
			br_5_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_49_out) begin 
			br_5_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_5_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_6_happened_in_state_4.br_6_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_51_out) begin 
			br_6_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_52_out) begin 
			br_6_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_6_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_4.br_7_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_45_out) begin 
			br_7_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_46_out) begin 
			br_7_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_8_happened_in_state_1.br_8_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_9_out) begin 
			br_8_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_10_out) begin 
			br_8_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_8_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_9_happened_in_state_1.br_9_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_12_out) begin 
			br_9_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_13_out) begin 
			br_9_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_9_happened_in_state_1_in_data = 0;
		end
	end
	// controller for concat_132.concat_132_in0
	// controller for concat_132.concat_132_in1
	// Insensitive connections
	always @(*) begin
		concat_132_in0 = valid ? add_tmp_5 : add_tmp_5;
		concat_132_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_133.concat_133_in0
	// controller for concat_133.concat_133_in1
	// Insensitive connections
	always @(*) begin
		concat_133_in0 = valid ? 32'd4 : 32'd4;
		concat_133_in1 = valid ? 32'd0 : 32'd0;
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
	// controller for eq_102.eq_102_in0
	// controller for eq_102.eq_102_in1
	// Insensitive connections
	always @(*) begin
		eq_102_in0 = valid ? 32'd10 : 32'd10;
		eq_102_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_103.eq_103_in0
	// controller for eq_103.eq_103_in1
	// Insensitive connections
	always @(*) begin
		eq_103_in0 = valid ? 32'd4 : 32'd4;
		eq_103_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_106.eq_106_in0
	// controller for eq_106.eq_106_in1
	// Insensitive connections
	always @(*) begin
		eq_106_in0 = valid ? 32'd1 : 32'd1;
		eq_106_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_109.eq_109_in0
	// controller for eq_109.eq_109_in1
	// Insensitive connections
	always @(*) begin
		eq_109_in0 = valid ? 32'd7 : 32'd7;
		eq_109_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	always @(*) begin
		eq_112_in0 = valid ? 32'd5 : 32'd5;
		eq_112_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_115.eq_115_in0
	// controller for eq_115.eq_115_in1
	// Insensitive connections
	always @(*) begin
		eq_115_in0 = valid ? 32'd6 : 32'd6;
		eq_115_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_118.eq_118_in0
	// controller for eq_118.eq_118_in1
	// Insensitive connections
	always @(*) begin
		eq_118_in0 = valid ? 32'd2 : 32'd2;
		eq_118_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_136.eq_136_in0
	// controller for eq_136.eq_136_in1
	// Insensitive connections
	always @(*) begin
		eq_136_in0 = valid ? 32'd10 : 32'd10;
		eq_136_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
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
	// controller for eq_56.eq_56_in0
	// controller for eq_56.eq_56_in1
	// Insensitive connections
	always @(*) begin
		eq_56_in0 = valid ? 32'd0 : 32'd0;
		eq_56_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
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
		eq_59_in0 = valid ? 32'd9 : 32'd9;
		eq_59_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_61.eq_61_in0
	// controller for eq_61.eq_61_in1
	// Insensitive connections
	always @(*) begin
		eq_61_in0 = valid ? 32'd0 : 32'd0;
		eq_61_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_62.eq_62_in0
	// controller for eq_62.eq_62_in1
	// Insensitive connections
	always @(*) begin
		eq_62_in0 = valid ? 32'd3 : 32'd3;
		eq_62_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_64.eq_64_in0
	// controller for eq_64.eq_64_in1
	// Insensitive connections
	always @(*) begin
		eq_64_in0 = valid ? 32'd10 : 32'd10;
		eq_64_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_65.eq_65_in0
	// controller for eq_65.eq_65_in1
	// Insensitive connections
	always @(*) begin
		eq_65_in0 = valid ? 32'd4 : 32'd4;
		eq_65_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_67.eq_67_in0
	// controller for eq_67.eq_67_in1
	// Insensitive connections
	always @(*) begin
		eq_67_in0 = valid ? 32'd10 : 32'd10;
		eq_67_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_68.eq_68_in0
	// controller for eq_68.eq_68_in1
	// Insensitive connections
	always @(*) begin
		eq_68_in0 = valid ? 32'd4 : 32'd4;
		eq_68_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_70.eq_70_in0
	// controller for eq_70.eq_70_in1
	// Insensitive connections
	always @(*) begin
		eq_70_in0 = valid ? 32'd1 : 32'd1;
		eq_70_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_72.eq_72_in0
	// controller for eq_72.eq_72_in1
	// Insensitive connections
	always @(*) begin
		eq_72_in0 = valid ? 32'd7 : 32'd7;
		eq_72_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd5 : 32'd5;
		eq_74_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd6 : 32'd6;
		eq_76_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd2 : 32'd2;
		eq_78_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_87.eq_87_in0
	// controller for eq_87.eq_87_in1
	// Insensitive connections
	always @(*) begin
		eq_87_in0 = valid ? 32'd0 : 32'd0;
		eq_87_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	always @(*) begin
		eq_88_in0 = valid ? 32'd8 : 32'd8;
		eq_88_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_91.eq_91_in0
	// controller for eq_91.eq_91_in1
	// Insensitive connections
	always @(*) begin
		eq_91_in0 = valid ? 32'd9 : 32'd9;
		eq_91_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_94.eq_94_in0
	// controller for eq_94.eq_94_in1
	// Insensitive connections
	always @(*) begin
		eq_94_in0 = valid ? 32'd0 : 32'd0;
		eq_94_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_95.eq_95_in0
	// controller for eq_95.eq_95_in1
	// Insensitive connections
	always @(*) begin
		eq_95_in0 = valid ? 32'd3 : 32'd3;
		eq_95_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_98.eq_98_in0
	// controller for eq_98.eq_98_in1
	// Insensitive connections
	always @(*) begin
		eq_98_in0 = valid ? 32'd10 : 32'd10;
		eq_98_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_99.eq_99_in0
	// controller for eq_99.eq_99_in1
	// Insensitive connections
	always @(*) begin
		eq_99_in0 = valid ? 32'd4 : 32'd4;
		eq_99_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
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
		if (andOp_129_out) begin 
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
	// controller for notOp_100.notOp_100_in0
	// Insensitive connections
	always @(*) begin
		notOp_100_in0 = valid ? eq_99_out : eq_99_out;
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
	// controller for notOp_110.notOp_110_in0
	// Insensitive connections
	always @(*) begin
		notOp_110_in0 = valid ? eq_109_out : eq_109_out;
	end
	// controller for notOp_113.notOp_113_in0
	// Insensitive connections
	always @(*) begin
		notOp_113_in0 = valid ? eq_112_out : eq_112_out;
	end
	// controller for notOp_116.notOp_116_in0
	// Insensitive connections
	always @(*) begin
		notOp_116_in0 = valid ? eq_115_out : eq_115_out;
	end
	// controller for notOp_119.notOp_119_in0
	// Insensitive connections
	always @(*) begin
		notOp_119_in0 = valid ? eq_118_out : eq_118_out;
	end
	// controller for notOp_13.notOp_13_in0
	// Insensitive connections
	always @(*) begin
		notOp_13_in0 = valid ? andOp_12_out : andOp_12_out;
	end
	// controller for notOp_15.notOp_15_in0
	// Insensitive connections
	always @(*) begin
		notOp_15_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	always @(*) begin
		notOp_19_in0 = valid ? andOp_18_out : andOp_18_out;
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
	// controller for notOp_28.notOp_28_in0
	// Insensitive connections
	always @(*) begin
		notOp_28_in0 = valid ? andOp_27_out : andOp_27_out;
	end
	// controller for notOp_30.notOp_30_in0
	// Insensitive connections
	always @(*) begin
		notOp_30_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
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
		notOp_39_in0 = valid ? icmp_tmp_6 : icmp_tmp_6;
	end
	// controller for notOp_43.notOp_43_in0
	// Insensitive connections
	always @(*) begin
		notOp_43_in0 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for notOp_46.notOp_46_in0
	// Insensitive connections
	always @(*) begin
		notOp_46_in0 = valid ? andOp_45_out : andOp_45_out;
	end
	// controller for notOp_49.notOp_49_in0
	// Insensitive connections
	always @(*) begin
		notOp_49_in0 = valid ? andOp_48_out : andOp_48_out;
	end
	// controller for notOp_52.notOp_52_in0
	// Insensitive connections
	always @(*) begin
		notOp_52_in0 = valid ? andOp_51_out : andOp_51_out;
	end
	// controller for notOp_54.notOp_54_in0
	// Insensitive connections
	always @(*) begin
		notOp_54_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for notOp_7.notOp_7_in0
	// Insensitive connections
	always @(*) begin
		notOp_7_in0 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for notOp_89.notOp_89_in0
	// Insensitive connections
	always @(*) begin
		notOp_89_in0 = valid ? eq_88_out : eq_88_out;
	end
	// controller for notOp_92.notOp_92_in0
	// Insensitive connections
	always @(*) begin
		notOp_92_in0 = valid ? eq_91_out : eq_91_out;
	end
	// controller for notOp_96.notOp_96_in0
	// Insensitive connections
	always @(*) begin
		notOp_96_in0 = valid ? eq_95_out : eq_95_out;
	end
	// controller for orOp_58.orOp_58_in0
	// controller for orOp_58.orOp_58_in1
	// Insensitive connections
	always @(*) begin
		orOp_58_in0 = valid ? eq_57_out : eq_57_out;
		orOp_58_in1 = valid ? andOp_21_out : andOp_21_out;
	end
	// controller for orOp_60.orOp_60_in0
	// controller for orOp_60.orOp_60_in1
	// Insensitive connections
	always @(*) begin
		orOp_60_in0 = valid ? eq_59_out : eq_59_out;
		orOp_60_in1 = valid ? andOp_9_out : andOp_9_out;
	end
	// controller for orOp_63.orOp_63_in0
	// controller for orOp_63.orOp_63_in1
	// Insensitive connections
	always @(*) begin
		orOp_63_in0 = valid ? eq_62_out : eq_62_out;
		orOp_63_in1 = valid ? andOp_6_out : andOp_6_out;
	end
	// controller for orOp_66.orOp_66_in0
	// controller for orOp_66.orOp_66_in1
	// Insensitive connections
	always @(*) begin
		orOp_66_in0 = valid ? eq_65_out : eq_65_out;
		orOp_66_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for orOp_69.orOp_69_in0
	// controller for orOp_69.orOp_69_in1
	// Insensitive connections
	always @(*) begin
		orOp_69_in0 = valid ? eq_68_out : eq_68_out;
		orOp_69_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for orOp_71.orOp_71_in0
	// controller for orOp_71.orOp_71_in1
	// Insensitive connections
	always @(*) begin
		orOp_71_in0 = valid ? eq_70_out : eq_70_out;
		orOp_71_in1 = valid ? andOp_29_out : andOp_29_out;
	end
	// controller for orOp_73.orOp_73_in0
	// controller for orOp_73.orOp_73_in1
	// Insensitive connections
	always @(*) begin
		orOp_73_in0 = valid ? eq_72_out : eq_72_out;
		orOp_73_in1 = valid ? andOp_53_out : andOp_53_out;
	end
	// controller for orOp_75.orOp_75_in0
	// controller for orOp_75.orOp_75_in1
	// Insensitive connections
	always @(*) begin
		orOp_75_in0 = valid ? eq_74_out : eq_74_out;
		orOp_75_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for orOp_77.orOp_77_in0
	// controller for orOp_77.orOp_77_in1
	// Insensitive connections
	always @(*) begin
		orOp_77_in0 = valid ? eq_76_out : eq_76_out;
		orOp_77_in1 = valid ? andOp_48_out : andOp_48_out;
	end
	// controller for orOp_79.orOp_79_in0
	// controller for orOp_79.orOp_79_in1
	// Insensitive connections
	always @(*) begin
		orOp_79_in0 = valid ? eq_78_out : eq_78_out;
		orOp_79_in1 = valid ? andOp_45_out : andOp_45_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_143_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_142_out) begin 
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
		phi_in_phi_8 = valid ? concat_132_out : concat_132_out;
		phi_last_block_phi_8 = valid ? bb_3_predecessor_in_state_1_out_data : bb_3_predecessor_in_state_1_out_data;
		phi_s_phi_8 = valid ? concat_133_out : concat_133_out;
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_125_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else if (andOp_127_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_124_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else if (andOp_126_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_124_out) begin 
			wdata_ram_0_reg = 32'd0;
		end else if (andOp_126_out) begin 
			wdata_ram_0_reg = add_out_add_14;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_124_out) begin 
			wen_ram_0_reg = 1'd1;
		end else if (andOp_126_out) begin 
			wen_ram_0_reg = 1'd1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_19.valid_reg
	always @(*) begin
		if (andOp_140_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_135.tmp_output_135_in_data
	always @(*) begin
		if (eq_136_out) begin 
			tmp_output_135_in_data = in_out_data;
		end else begin
			tmp_output_135_in_data = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_5 <= 0;
		end else begin
			if (andOp_154_out) begin
				add_tmp_5 <= add_out_add_16;
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
			if (andOp_145_out) begin
				global_state <= 32'd1;
			end
			if (andOp_147_out) begin
				global_state <= 32'd3;
			end
			if (andOp_149_out) begin
				global_state <= 32'd4;
			end
			if (andOp_14_out) begin
				global_state <= 32'd2;
			end
			if (andOp_151_out) begin
				global_state <= 32'd4;
			end
			if (andOp_16_out) begin
				global_state <= 32'd1;
			end
			if (andOp_31_out) begin
				global_state <= 32'd1;
			end
			if (andOp_55_out) begin
				global_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_6 <= 0;
		end else begin
			if (andOp_155_out) begin
				icmp_tmp_6 <= cmp_out_icmp_17;
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
			if (andOp_80_out) begin
				state_0_entry_BB_reg <= 32'd0;
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
			if (andOp_16_out) begin
				state_1_entry_BB_reg <= 32'd9;
			end
			if (andOp_31_out) begin
				state_1_entry_BB_reg <= 32'd3;
			end
			if (andOp_81_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_16_out) begin
				state_1_last_BB_reg <= 32'd9;
			end
			if (andOp_31_out) begin
				state_1_last_BB_reg <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_14_out) begin
				state_2_entry_BB_reg <= 32'd10;
			end
			if (andOp_82_out) begin
				state_2_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_14_out) begin
				state_2_last_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_83_out) begin
				state_3_entry_BB_reg <= 32'd10;
			end
			if (andOp_84_out) begin
				state_3_entry_BB_reg <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_24_out) begin
				state_3_last_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_55_out) begin
				state_4_entry_BB_reg <= 32'd6;
			end
			if (andOp_85_out) begin
				state_4_entry_BB_reg <= 32'd4;
			end
			if (andOp_86_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_45_out) begin
				state_4_last_BB_reg <= 32'd7;
			end
			if (andOp_55_out) begin
				state_4_last_BB_reg <= 32'd6;
			end
		end
	end

endmodule

