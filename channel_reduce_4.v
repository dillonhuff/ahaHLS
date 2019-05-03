module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready);

	reg [0:0] valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;

	assign valid = valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add alloca_0();

	add bitcast_1();

	add call_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	br_dummy br_unit();

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

	reg [31:0] add_in0_add_14;
	reg [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	reg [31:0] cmp_in0_icmp_15;
	reg [31:0] cmp_in1_icmp_15;
	wire [0:0] cmp_out_icmp_15;
	eq #(.WIDTH(32)) icmp_15(.in0(cmp_in0_icmp_15), .in1(cmp_in1_icmp_15), .out(cmp_out_icmp_15));

	reg [31:0] data_in_0_1_in_data;
	wire [31:0] data_in_0_1_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_1(.in_data(data_in_0_1_in_data), .out_data(data_in_0_1_out_data));

	reg [31:0] data_in_0_3_in_data;
	wire [31:0] data_in_0_3_out_data;
	hls_wire #(.WIDTH(32)) data_in_0_3(.in_data(data_in_0_3_in_data), .out_data(data_in_0_3_out_data));

	reg [31:0] data_in_1_5_in_data;
	wire [31:0] data_in_1_5_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_5(.in_data(data_in_1_5_in_data), .out_data(data_in_1_5_out_data));

	reg [31:0] data_in_1_7_in_data;
	wire [31:0] data_in_1_7_out_data;
	hls_wire #(.WIDTH(32)) data_in_1_7(.in_data(data_in_1_7_in_data), .out_data(data_in_1_7_out_data));

	reg [31:0] data_in_2_9_in_data;
	wire [31:0] data_in_2_9_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_9(.in_data(data_in_2_9_in_data), .out_data(data_in_2_9_out_data));

	reg [31:0] data_in_2_11_in_data;
	wire [31:0] data_in_2_11_out_data;
	hls_wire #(.WIDTH(32)) data_in_2_11(.in_data(data_in_2_11_in_data), .out_data(data_in_2_11_out_data));

	reg [31:0] data_in_3_13_in_data;
	wire [31:0] data_in_3_13_out_data;
	hls_wire #(.WIDTH(32)) data_in_3_13(.in_data(data_in_3_13_in_data), .out_data(data_in_3_13_out_data));

	reg [31:0] data_in_3_15_in_data;
	wire [31:0] data_in_3_15_out_data;
	hls_wire #(.WIDTH(32)) data_in_3_15(.in_data(data_in_3_15_in_data), .out_data(data_in_3_15_out_data));

	reg [31:0] data_in_4_18_in_data;
	wire [31:0] data_in_4_18_out_data;
	hls_wire #(.WIDTH(32)) data_in_4_18(.in_data(data_in_4_18_in_data), .out_data(data_in_4_18_out_data));

	reg [31:0] data_in_4_20_in_data;
	wire [31:0] data_in_4_20_out_data;
	hls_wire #(.WIDTH(32)) data_in_4_20(.in_data(data_in_4_20_in_data), .out_data(data_in_4_20_out_data));

	reg [0:0] data_in_4_22_in_data;
	wire [0:0] data_in_4_22_out_data;
	hls_wire #(.WIDTH(1)) data_in_4_22(.in_data(data_in_4_22_in_data), .out_data(data_in_4_22_out_data));

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

	reg [0:0] bb_1_active_in_state_4_in_data;
	wire [0:0] bb_1_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active_in_state_4(.in_data(bb_1_active_in_state_4_in_data), .out_data(bb_1_active_in_state_4_out_data));

	reg [31:0] bb_1_predecessor_in_state_4_in_data;
	wire [31:0] bb_1_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_1_predecessor_in_state_4(.in_data(bb_1_predecessor_in_state_4_in_data), .out_data(bb_1_predecessor_in_state_4_out_data));

	reg [0:0] bb_4_active_in_state_4_in_data;
	wire [0:0] bb_4_active_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active_in_state_4(.in_data(bb_4_active_in_state_4_in_data), .out_data(bb_4_active_in_state_4_out_data));

	reg [31:0] bb_4_predecessor_in_state_4_in_data;
	wire [31:0] bb_4_predecessor_in_state_4_out_data;
	hls_wire #(.WIDTH(32)) bb_4_predecessor_in_state_4(.in_data(bb_4_predecessor_in_state_4_in_data), .out_data(bb_4_predecessor_in_state_4_out_data));

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

	reg [0:0] andOp_23_in0;
	reg [0:0] andOp_23_in1;
	wire [0:0] andOp_23_out;
	andOp #(.WIDTH(1)) andOp_23(.in0(andOp_23_in0), .in1(andOp_23_in1), .out(andOp_23_out));

	reg [0:0] andOp_24_in0;
	reg [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

	reg [0:0] br_0_happened_in_state_0_in_data;
	wire [0:0] br_0_happened_in_state_0_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_0(.in_data(br_0_happened_in_state_0_in_data), .out_data(br_0_happened_in_state_0_out_data));

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

	reg [0:0] br_0_happened_in_state_1_in_data;
	wire [0:0] br_0_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_0_happened_in_state_1(.in_data(br_0_happened_in_state_1_in_data), .out_data(br_0_happened_in_state_1_out_data));

	reg [0:0] notOp_28_in0;
	wire [0:0] notOp_28_out;
	notOp #(.WIDTH(1)) notOp_28(.in(notOp_28_in0), .out(notOp_28_out));

	reg [0:0] andOp_29_in0;
	reg [0:0] andOp_29_in1;
	wire [0:0] andOp_29_out;
	andOp #(.WIDTH(1)) andOp_29(.in0(andOp_29_in0), .in1(andOp_29_in1), .out(andOp_29_out));

	reg [0:0] andOp_30_in0;
	reg [0:0] andOp_30_in1;
	wire [0:0] andOp_30_out;
	andOp #(.WIDTH(1)) andOp_30(.in0(andOp_30_in0), .in1(andOp_30_in1), .out(andOp_30_out));

	reg [0:0] br_3_happened_in_state_1_in_data;
	wire [0:0] br_3_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_3_happened_in_state_1(.in_data(br_3_happened_in_state_1_in_data), .out_data(br_3_happened_in_state_1_out_data));

	reg [0:0] notOp_31_in0;
	wire [0:0] notOp_31_out;
	notOp #(.WIDTH(1)) notOp_31(.in(notOp_31_in0), .out(notOp_31_out));

	reg [0:0] andOp_32_in0;
	reg [0:0] andOp_32_in1;
	wire [0:0] andOp_32_out;
	andOp #(.WIDTH(1)) andOp_32(.in0(andOp_32_in0), .in1(andOp_32_in1), .out(andOp_32_out));

	reg [0:0] andOp_33_in0;
	reg [0:0] andOp_33_in1;
	wire [0:0] andOp_33_out;
	andOp #(.WIDTH(1)) andOp_33(.in0(andOp_33_in0), .in1(andOp_33_in1), .out(andOp_33_out));

	reg [0:0] br_9_happened_in_state_1_in_data;
	wire [0:0] br_9_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_9_happened_in_state_1(.in_data(br_9_happened_in_state_1_in_data), .out_data(br_9_happened_in_state_1_out_data));

	reg [0:0] notOp_34_in0;
	wire [0:0] notOp_34_out;
	notOp #(.WIDTH(1)) notOp_34(.in(notOp_34_in0), .out(notOp_34_out));

	reg [0:0] andOp_35_in0;
	reg [0:0] andOp_35_in1;
	wire [0:0] andOp_35_out;
	andOp #(.WIDTH(1)) andOp_35(.in0(andOp_35_in0), .in1(andOp_35_in1), .out(andOp_35_out));

	reg [0:0] notOp_36_in0;
	wire [0:0] notOp_36_out;
	notOp #(.WIDTH(1)) notOp_36(.in(notOp_36_in0), .out(notOp_36_out));

	reg [0:0] andOp_37_in0;
	reg [0:0] andOp_37_in1;
	wire [0:0] andOp_37_out;
	andOp #(.WIDTH(1)) andOp_37(.in0(andOp_37_in0), .in1(andOp_37_in1), .out(andOp_37_out));

	reg [0:0] andOp_38_in0;
	reg [0:0] andOp_38_in1;
	wire [0:0] andOp_38_out;
	andOp #(.WIDTH(1)) andOp_38(.in0(andOp_38_in0), .in1(andOp_38_in1), .out(andOp_38_out));

	reg [0:0] andOp_39_in0;
	reg [0:0] andOp_39_in1;
	wire [0:0] andOp_39_out;
	andOp #(.WIDTH(1)) andOp_39(.in0(andOp_39_in0), .in1(andOp_39_in1), .out(andOp_39_out));

	reg [0:0] br_8_happened_in_state_1_in_data;
	wire [0:0] br_8_happened_in_state_1_out_data;
	hls_wire #(.WIDTH(1)) br_8_happened_in_state_1(.in_data(br_8_happened_in_state_1_in_data), .out_data(br_8_happened_in_state_1_out_data));

	reg [0:0] notOp_40_in0;
	wire [0:0] notOp_40_out;
	notOp #(.WIDTH(1)) notOp_40(.in(notOp_40_in0), .out(notOp_40_out));

	reg [0:0] andOp_41_in0;
	reg [0:0] andOp_41_in1;
	wire [0:0] andOp_41_out;
	andOp #(.WIDTH(1)) andOp_41(.in0(andOp_41_in0), .in1(andOp_41_in1), .out(andOp_41_out));

	reg [0:0] andOp_42_in0;
	reg [0:0] andOp_42_in1;
	wire [0:0] andOp_42_out;
	andOp #(.WIDTH(1)) andOp_42(.in0(andOp_42_in0), .in1(andOp_42_in1), .out(andOp_42_out));

	reg [0:0] br_10_happened_in_state_2_in_data;
	wire [0:0] br_10_happened_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_2(.in_data(br_10_happened_in_state_2_in_data), .out_data(br_10_happened_in_state_2_out_data));

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

	reg [0:0] br_4_happened_in_state_3_in_data;
	wire [0:0] br_4_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_3(.in_data(br_4_happened_in_state_3_in_data), .out_data(br_4_happened_in_state_3_out_data));

	reg [0:0] notOp_46_in0;
	wire [0:0] notOp_46_out;
	notOp #(.WIDTH(1)) notOp_46(.in(notOp_46_in0), .out(notOp_46_out));

	reg [0:0] andOp_47_in0;
	reg [0:0] andOp_47_in1;
	wire [0:0] andOp_47_out;
	andOp #(.WIDTH(1)) andOp_47(.in0(andOp_47_in0), .in1(andOp_47_in1), .out(andOp_47_out));

	reg [0:0] notOp_48_in0;
	wire [0:0] notOp_48_out;
	notOp #(.WIDTH(1)) notOp_48(.in(notOp_48_in0), .out(notOp_48_out));

	reg [0:0] andOp_49_in0;
	reg [0:0] andOp_49_in1;
	wire [0:0] andOp_49_out;
	andOp #(.WIDTH(1)) andOp_49(.in0(andOp_49_in0), .in1(andOp_49_in1), .out(andOp_49_out));

	reg [0:0] andOp_50_in0;
	reg [0:0] andOp_50_in1;
	wire [0:0] andOp_50_out;
	andOp #(.WIDTH(1)) andOp_50(.in0(andOp_50_in0), .in1(andOp_50_in1), .out(andOp_50_out));

	reg [0:0] andOp_51_in0;
	reg [0:0] andOp_51_in1;
	wire [0:0] andOp_51_out;
	andOp #(.WIDTH(1)) andOp_51(.in0(andOp_51_in0), .in1(andOp_51_in1), .out(andOp_51_out));

	reg [0:0] br_10_happened_in_state_3_in_data;
	wire [0:0] br_10_happened_in_state_3_out_data;
	hls_wire #(.WIDTH(1)) br_10_happened_in_state_3(.in_data(br_10_happened_in_state_3_in_data), .out_data(br_10_happened_in_state_3_out_data));

	reg [0:0] notOp_52_in0;
	wire [0:0] notOp_52_out;
	notOp #(.WIDTH(1)) notOp_52(.in(notOp_52_in0), .out(notOp_52_out));

	reg [0:0] andOp_53_in0;
	reg [0:0] andOp_53_in1;
	wire [0:0] andOp_53_out;
	andOp #(.WIDTH(1)) andOp_53(.in0(andOp_53_in0), .in1(andOp_53_in1), .out(andOp_53_out));

	reg [0:0] andOp_54_in0;
	reg [0:0] andOp_54_in1;
	wire [0:0] andOp_54_out;
	andOp #(.WIDTH(1)) andOp_54(.in0(andOp_54_in0), .in1(andOp_54_in1), .out(andOp_54_out));

	reg [0:0] br_1_happened_in_state_4_in_data;
	wire [0:0] br_1_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_1_happened_in_state_4(.in_data(br_1_happened_in_state_4_in_data), .out_data(br_1_happened_in_state_4_out_data));

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

	reg [0:0] br_4_happened_in_state_4_in_data;
	wire [0:0] br_4_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_4_happened_in_state_4(.in_data(br_4_happened_in_state_4_in_data), .out_data(br_4_happened_in_state_4_out_data));

	reg [0:0] notOp_58_in0;
	wire [0:0] notOp_58_out;
	notOp #(.WIDTH(1)) notOp_58(.in(notOp_58_in0), .out(notOp_58_out));

	reg [0:0] andOp_59_in0;
	reg [0:0] andOp_59_in1;
	wire [0:0] andOp_59_out;
	andOp #(.WIDTH(1)) andOp_59(.in0(andOp_59_in0), .in1(andOp_59_in1), .out(andOp_59_out));

	reg [0:0] notOp_60_in0;
	wire [0:0] notOp_60_out;
	notOp #(.WIDTH(1)) notOp_60(.in(notOp_60_in0), .out(notOp_60_out));

	reg [0:0] andOp_61_in0;
	reg [0:0] andOp_61_in1;
	wire [0:0] andOp_61_out;
	andOp #(.WIDTH(1)) andOp_61(.in0(andOp_61_in0), .in1(andOp_61_in1), .out(andOp_61_out));

	reg [0:0] andOp_62_in0;
	reg [0:0] andOp_62_in1;
	wire [0:0] andOp_62_out;
	andOp #(.WIDTH(1)) andOp_62(.in0(andOp_62_in0), .in1(andOp_62_in1), .out(andOp_62_out));

	reg [0:0] andOp_63_in0;
	reg [0:0] andOp_63_in1;
	wire [0:0] andOp_63_out;
	andOp #(.WIDTH(1)) andOp_63(.in0(andOp_63_in0), .in1(andOp_63_in1), .out(andOp_63_out));

	reg [0:0] br_7_happened_in_state_4_in_data;
	wire [0:0] br_7_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_7_happened_in_state_4(.in_data(br_7_happened_in_state_4_in_data), .out_data(br_7_happened_in_state_4_out_data));

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

	reg [0:0] br_5_happened_in_state_4_in_data;
	wire [0:0] br_5_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_5_happened_in_state_4(.in_data(br_5_happened_in_state_4_in_data), .out_data(br_5_happened_in_state_4_out_data));

	reg [0:0] notOp_67_in0;
	wire [0:0] notOp_67_out;
	notOp #(.WIDTH(1)) notOp_67(.in(notOp_67_in0), .out(notOp_67_out));

	reg [0:0] andOp_68_in0;
	reg [0:0] andOp_68_in1;
	wire [0:0] andOp_68_out;
	andOp #(.WIDTH(1)) andOp_68(.in0(andOp_68_in0), .in1(andOp_68_in1), .out(andOp_68_out));

	reg [0:0] andOp_69_in0;
	reg [0:0] andOp_69_in1;
	wire [0:0] andOp_69_out;
	andOp #(.WIDTH(1)) andOp_69(.in0(andOp_69_in0), .in1(andOp_69_in1), .out(andOp_69_out));

	reg [0:0] br_6_happened_in_state_4_in_data;
	wire [0:0] br_6_happened_in_state_4_out_data;
	hls_wire #(.WIDTH(1)) br_6_happened_in_state_4(.in_data(br_6_happened_in_state_4_in_data), .out_data(br_6_happened_in_state_4_out_data));

	reg [0:0] notOp_70_in0;
	wire [0:0] notOp_70_out;
	notOp #(.WIDTH(1)) notOp_70(.in(notOp_70_in0), .out(notOp_70_out));

	reg [0:0] andOp_71_in0;
	reg [0:0] andOp_71_in1;
	wire [0:0] andOp_71_out;
	andOp #(.WIDTH(1)) andOp_71(.in0(andOp_71_in0), .in1(andOp_71_in1), .out(andOp_71_out));

	reg [0:0] notOp_72_in0;
	wire [0:0] notOp_72_out;
	notOp #(.WIDTH(1)) notOp_72(.in(notOp_72_in0), .out(notOp_72_out));

	reg [0:0] andOp_73_in0;
	reg [0:0] andOp_73_in1;
	wire [0:0] andOp_73_out;
	andOp #(.WIDTH(1)) andOp_73(.in0(andOp_73_in0), .in1(andOp_73_in1), .out(andOp_73_out));

	reg [31:0] eq_74_in0;
	reg [31:0] eq_74_in1;
	wire [0:0] eq_74_out;
	eq #(.WIDTH(32)) eq_74(.in0(eq_74_in0), .in1(eq_74_in1), .out(eq_74_out));

	reg [31:0] eq_75_in0;
	reg [31:0] eq_75_in1;
	wire [0:0] eq_75_out;
	eq #(.WIDTH(32)) eq_75(.in0(eq_75_in0), .in1(eq_75_in1), .out(eq_75_out));

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

	reg [31:0] eq_80_in0;
	reg [31:0] eq_80_in1;
	wire [0:0] eq_80_out;
	eq #(.WIDTH(32)) eq_80(.in0(eq_80_in0), .in1(eq_80_in1), .out(eq_80_out));

	reg [0:0] orOp_81_in0;
	reg [0:0] orOp_81_in1;
	wire [0:0] orOp_81_out;
	orOp #(.WIDTH(1)) orOp_81(.in0(orOp_81_in0), .in1(orOp_81_in1), .out(orOp_81_out));

	reg [31:0] eq_82_in0;
	reg [31:0] eq_82_in1;
	wire [0:0] eq_82_out;
	eq #(.WIDTH(32)) eq_82(.in0(eq_82_in0), .in1(eq_82_in1), .out(eq_82_out));

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

	reg [31:0] eq_86_in0;
	reg [31:0] eq_86_in1;
	wire [0:0] eq_86_out;
	eq #(.WIDTH(32)) eq_86(.in0(eq_86_in0), .in1(eq_86_in1), .out(eq_86_out));

	reg [0:0] orOp_87_in0;
	reg [0:0] orOp_87_in1;
	wire [0:0] orOp_87_out;
	orOp #(.WIDTH(1)) orOp_87(.in0(orOp_87_in0), .in1(orOp_87_in1), .out(orOp_87_out));

	reg [31:0] eq_88_in0;
	reg [31:0] eq_88_in1;
	wire [0:0] eq_88_out;
	eq #(.WIDTH(32)) eq_88(.in0(eq_88_in0), .in1(eq_88_in1), .out(eq_88_out));

	reg [31:0] eq_89_in0;
	reg [31:0] eq_89_in1;
	wire [0:0] eq_89_out;
	eq #(.WIDTH(32)) eq_89(.in0(eq_89_in0), .in1(eq_89_in1), .out(eq_89_out));

	reg [0:0] orOp_90_in0;
	reg [0:0] orOp_90_in1;
	wire [0:0] orOp_90_out;
	orOp #(.WIDTH(1)) orOp_90(.in0(orOp_90_in0), .in1(orOp_90_in1), .out(orOp_90_out));

	reg [31:0] eq_91_in0;
	reg [31:0] eq_91_in1;
	wire [0:0] eq_91_out;
	eq #(.WIDTH(32)) eq_91(.in0(eq_91_in0), .in1(eq_91_in1), .out(eq_91_out));

	reg [0:0] orOp_92_in0;
	reg [0:0] orOp_92_in1;
	wire [0:0] orOp_92_out;
	orOp #(.WIDTH(1)) orOp_92(.in0(orOp_92_in0), .in1(orOp_92_in1), .out(orOp_92_out));

	reg [31:0] eq_93_in0;
	reg [31:0] eq_93_in1;
	wire [0:0] eq_93_out;
	eq #(.WIDTH(32)) eq_93(.in0(eq_93_in0), .in1(eq_93_in1), .out(eq_93_out));

	reg [0:0] orOp_94_in0;
	reg [0:0] orOp_94_in1;
	wire [0:0] orOp_94_out;
	orOp #(.WIDTH(1)) orOp_94(.in0(orOp_94_in0), .in1(orOp_94_in1), .out(orOp_94_out));

	reg [31:0] eq_95_in0;
	reg [31:0] eq_95_in1;
	wire [0:0] eq_95_out;
	eq #(.WIDTH(32)) eq_95(.in0(eq_95_in0), .in1(eq_95_in1), .out(eq_95_out));

	reg [0:0] orOp_96_in0;
	reg [0:0] orOp_96_in1;
	wire [0:0] orOp_96_out;
	orOp #(.WIDTH(1)) orOp_96(.in0(orOp_96_in0), .in1(orOp_96_in1), .out(orOp_96_out));

	reg [31:0] eq_97_in0;
	reg [31:0] eq_97_in1;
	wire [0:0] eq_97_out;
	eq #(.WIDTH(32)) eq_97(.in0(eq_97_in0), .in1(eq_97_in1), .out(eq_97_out));

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

	reg [0:0] notOp_103_in0;
	wire [0:0] notOp_103_out;
	notOp #(.WIDTH(1)) notOp_103(.in(notOp_103_in0), .out(notOp_103_out));

	reg [0:0] andOp_104_in0;
	reg [0:0] andOp_104_in1;
	wire [0:0] andOp_104_out;
	andOp #(.WIDTH(1)) andOp_104(.in0(andOp_104_in0), .in1(andOp_104_in1), .out(andOp_104_out));

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

	reg [31:0] eq_113_in0;
	reg [31:0] eq_113_in1;
	wire [0:0] eq_113_out;
	eq #(.WIDTH(32)) eq_113(.in0(eq_113_in0), .in1(eq_113_in1), .out(eq_113_out));

	reg [0:0] notOp_114_in0;
	wire [0:0] notOp_114_out;
	notOp #(.WIDTH(1)) notOp_114(.in(notOp_114_in0), .out(notOp_114_out));

	reg [0:0] andOp_115_in0;
	reg [0:0] andOp_115_in1;
	wire [0:0] andOp_115_out;
	andOp #(.WIDTH(1)) andOp_115(.in0(andOp_115_in0), .in1(andOp_115_in1), .out(andOp_115_out));

	reg [31:0] eq_116_in0;
	reg [31:0] eq_116_in1;
	wire [0:0] eq_116_out;
	eq #(.WIDTH(32)) eq_116(.in0(eq_116_in0), .in1(eq_116_in1), .out(eq_116_out));

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

	reg [0:0] notOp_121_in0;
	wire [0:0] notOp_121_out;
	notOp #(.WIDTH(1)) notOp_121(.in(notOp_121_in0), .out(notOp_121_out));

	reg [0:0] andOp_122_in0;
	reg [0:0] andOp_122_in1;
	wire [0:0] andOp_122_out;
	andOp #(.WIDTH(1)) andOp_122(.in0(andOp_122_in0), .in1(andOp_122_in1), .out(andOp_122_out));

	reg [31:0] eq_123_in0;
	reg [31:0] eq_123_in1;
	wire [0:0] eq_123_out;
	eq #(.WIDTH(32)) eq_123(.in0(eq_123_in0), .in1(eq_123_in1), .out(eq_123_out));

	reg [0:0] notOp_124_in0;
	wire [0:0] notOp_124_out;
	notOp #(.WIDTH(1)) notOp_124(.in(notOp_124_in0), .out(notOp_124_out));

	reg [0:0] andOp_125_in0;
	reg [0:0] andOp_125_in1;
	wire [0:0] andOp_125_out;
	andOp #(.WIDTH(1)) andOp_125(.in0(andOp_125_in0), .in1(andOp_125_in1), .out(andOp_125_out));

	reg [31:0] eq_126_in0;
	reg [31:0] eq_126_in1;
	wire [0:0] eq_126_out;
	eq #(.WIDTH(32)) eq_126(.in0(eq_126_in0), .in1(eq_126_in1), .out(eq_126_out));

	reg [0:0] notOp_127_in0;
	wire [0:0] notOp_127_out;
	notOp #(.WIDTH(1)) notOp_127(.in(notOp_127_in0), .out(notOp_127_out));

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

	reg [0:0] andOp_136_in0;
	reg [0:0] andOp_136_in1;
	wire [0:0] andOp_136_out;
	andOp #(.WIDTH(1)) andOp_136(.in0(andOp_136_in0), .in1(andOp_136_in1), .out(andOp_136_out));

	reg [31:0] concat_137_in0;
	reg [31:0] concat_137_in1;
	wire [63:0] concat_137_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_137(.in0(concat_137_in0), .in1(concat_137_in1), .out(concat_137_out));

	reg [31:0] concat_138_in0;
	reg [31:0] concat_138_in1;
	wire [63:0] concat_138_out;
	concat #(.IN0_WIDTH(32), .IN1_WIDTH(32)) concat_138(.in0(concat_138_in0), .in1(concat_138_in1), .out(concat_138_out));

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

	reg [31:0] tmp_output_143_in_data;
	wire [31:0] tmp_output_143_out_data;
	hls_wire #(.WIDTH(32)) tmp_output_143(.in_data(tmp_output_143_in_data), .out_data(tmp_output_143_out_data));

	reg [31:0] eq_144_in0;
	reg [31:0] eq_144_in1;
	wire [0:0] eq_144_out;
	eq #(.WIDTH(32)) eq_144(.in0(eq_144_in0), .in1(eq_144_in1), .out(eq_144_out));

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

	reg [0:0] notOp_156_in0;
	wire [0:0] notOp_156_out;
	notOp #(.WIDTH(1)) notOp_156(.in(notOp_156_in0), .out(notOp_156_out));

	reg [0:0] andOp_157_in0;
	reg [0:0] andOp_157_in1;
	wire [0:0] andOp_157_out;
	andOp #(.WIDTH(1)) andOp_157(.in0(andOp_157_in0), .in1(andOp_157_in1), .out(andOp_157_out));

	reg [0:0] notOp_158_in0;
	wire [0:0] notOp_158_out;
	notOp #(.WIDTH(1)) notOp_158(.in(notOp_158_in0), .out(notOp_158_out));

	reg [0:0] andOp_159_in0;
	reg [0:0] andOp_159_in1;
	wire [0:0] andOp_159_out;
	andOp #(.WIDTH(1)) andOp_159(.in0(andOp_159_in0), .in1(andOp_159_in1), .out(andOp_159_out));

	reg [0:0] notOp_160_in0;
	wire [0:0] notOp_160_out;
	notOp #(.WIDTH(1)) notOp_160(.in(notOp_160_in0), .out(notOp_160_out));

	reg [0:0] andOp_161_in0;
	reg [0:0] andOp_161_in1;
	wire [0:0] andOp_161_out;
	andOp #(.WIDTH(1)) andOp_161(.in0(andOp_161_in0), .in1(andOp_161_in1), .out(andOp_161_out));

	reg [0:0] notOp_162_in0;
	wire [0:0] notOp_162_out;
	notOp #(.WIDTH(1)) notOp_162(.in(notOp_162_in0), .out(notOp_162_out));

	reg [0:0] andOp_163_in0;
	reg [0:0] andOp_163_in1;
	wire [0:0] andOp_163_out;
	andOp #(.WIDTH(1)) andOp_163(.in0(andOp_163_in0), .in1(andOp_163_in1), .out(andOp_163_out));

	reg [0:0] notOp_164_in0;
	wire [0:0] notOp_164_out;
	notOp #(.WIDTH(1)) notOp_164(.in(notOp_164_in0), .out(notOp_164_out));

	reg [0:0] andOp_165_in0;
	reg [0:0] andOp_165_in1;
	wire [0:0] andOp_165_out;
	andOp #(.WIDTH(1)) andOp_165(.in0(andOp_165_in0), .in1(andOp_165_in1), .out(andOp_165_out));

	reg [0:0] notOp_166_in0;
	wire [0:0] notOp_166_out;
	notOp #(.WIDTH(1)) notOp_166(.in(notOp_166_in0), .out(notOp_166_out));

	reg [0:0] andOp_167_in0;
	reg [0:0] andOp_167_in1;
	wire [0:0] andOp_167_out;
	andOp #(.WIDTH(1)) andOp_167(.in0(andOp_167_in0), .in1(andOp_167_in1), .out(andOp_167_out));

	reg [0:0] notOp_168_in0;
	wire [0:0] notOp_168_out;
	notOp #(.WIDTH(1)) notOp_168(.in(notOp_168_in0), .out(notOp_168_out));

	reg [0:0] andOp_169_in0;
	reg [0:0] andOp_169_in1;
	wire [0:0] andOp_169_out;
	andOp #(.WIDTH(1)) andOp_169(.in0(andOp_169_in0), .in1(andOp_169_in1), .out(andOp_169_out));

	reg [0:0] notOp_170_in0;
	wire [0:0] notOp_170_out;
	notOp #(.WIDTH(1)) notOp_170(.in(notOp_170_in0), .out(notOp_170_out));

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

	reg [31:0] eq_177_in0;
	reg [31:0] eq_177_in1;
	wire [0:0] eq_177_out;
	eq #(.WIDTH(32)) eq_177(.in0(eq_177_in0), .in1(eq_177_in1), .out(eq_177_out));

	reg [31:0] eq_178_in0;
	reg [31:0] eq_178_in1;
	wire [0:0] eq_178_out;
	eq #(.WIDTH(32)) eq_178(.in0(eq_178_in0), .in1(eq_178_in1), .out(eq_178_out));

	reg [31:0] eq_179_in0;
	reg [31:0] eq_179_in1;
	wire [0:0] eq_179_out;
	eq #(.WIDTH(32)) eq_179(.in0(eq_179_in0), .in1(eq_179_in1), .out(eq_179_out));

	reg [31:0] eq_180_in0;
	reg [31:0] eq_180_in1;
	wire [0:0] eq_180_out;
	eq #(.WIDTH(32)) eq_180(.in0(eq_180_in0), .in1(eq_180_in1), .out(eq_180_out));

	reg [0:0] andOp_181_in0;
	reg [0:0] andOp_181_in1;
	wire [0:0] andOp_181_out;
	andOp #(.WIDTH(1)) andOp_181(.in0(andOp_181_in0), .in1(andOp_181_in1), .out(andOp_181_out));

	reg [0:0] andOp_182_in0;
	reg [0:0] andOp_182_in1;
	wire [0:0] andOp_182_out;
	andOp #(.WIDTH(1)) andOp_182(.in0(andOp_182_in0), .in1(andOp_182_in1), .out(andOp_182_out));

	reg [31:0] eq_183_in0;
	reg [31:0] eq_183_in1;
	wire [0:0] eq_183_out;
	eq #(.WIDTH(32)) eq_183(.in0(eq_183_in0), .in1(eq_183_in1), .out(eq_183_out));

	reg [31:0] eq_184_in0;
	reg [31:0] eq_184_in1;
	wire [0:0] eq_184_out;
	eq #(.WIDTH(32)) eq_184(.in0(eq_184_in0), .in1(eq_184_in1), .out(eq_184_out));

	// End Functional Units

	reg [31:0] data_store_0_0;
	reg [31:0] data_store_0_2;
	reg [31:0] data_store_1_4;
	reg [31:0] data_store_1_6;
	reg [31:0] data_store_2_10;
	reg [31:0] data_store_2_8;
	reg [31:0] data_store_3_12;
	reg [31:0] data_store_3_14;
	reg [0:0] data_store_3_16;
	reg [31:0] data_store_4_17;
	reg [31:0] data_store_4_19;
	reg [0:0] data_store_4_21;
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

	// controller for add_add_12.add_in0_add_12
	// controller for add_add_12.add_in1_add_12
	// Insensitive connections
	always @(*) begin
		add_in0_add_12 = valid ? rdata_ram_0 : rdata_ram_0;
		add_in1_add_12 = valid ? tmp_output_143_out_data : tmp_output_143_out_data;
	end
	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? data_in_3_13_out_data : data_in_3_13_out_data;
		add_in1_add_14 = valid ? 32'd1 : 32'd1;
	end
	// controller for andOp_101.andOp_101_in0
	// controller for andOp_101.andOp_101_in1
	// Insensitive connections
	always @(*) begin
		andOp_101_in0 = valid ? notOp_100_out : notOp_100_out;
		andOp_101_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for andOp_104.andOp_104_in0
	// controller for andOp_104.andOp_104_in1
	// Insensitive connections
	always @(*) begin
		andOp_104_in0 = valid ? notOp_103_out : notOp_103_out;
		andOp_104_in1 = valid ? andOp_39_out : andOp_39_out;
	end
	// controller for andOp_107.andOp_107_in0
	// controller for andOp_107.andOp_107_in1
	// Insensitive connections
	always @(*) begin
		andOp_107_in0 = valid ? notOp_106_out : notOp_106_out;
		andOp_107_in1 = valid ? andOp_30_out : andOp_30_out;
	end
	// controller for andOp_111.andOp_111_in0
	// controller for andOp_111.andOp_111_in1
	// Insensitive connections
	always @(*) begin
		andOp_111_in0 = valid ? notOp_110_out : notOp_110_out;
		andOp_111_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for andOp_115.andOp_115_in0
	// controller for andOp_115.andOp_115_in1
	// Insensitive connections
	always @(*) begin
		andOp_115_in0 = valid ? notOp_114_out : notOp_114_out;
		andOp_115_in1 = valid ? andOp_47_out : andOp_47_out;
	end
	// controller for andOp_119.andOp_119_in0
	// controller for andOp_119.andOp_119_in1
	// Insensitive connections
	always @(*) begin
		andOp_119_in0 = valid ? notOp_118_out : notOp_118_out;
		andOp_119_in1 = valid ? andOp_71_out : andOp_71_out;
	end
	// controller for andOp_122.andOp_122_in0
	// controller for andOp_122.andOp_122_in1
	// Insensitive connections
	always @(*) begin
		andOp_122_in0 = valid ? notOp_121_out : notOp_121_out;
		andOp_122_in1 = valid ? andOp_63_out : andOp_63_out;
	end
	// controller for andOp_125.andOp_125_in0
	// controller for andOp_125.andOp_125_in1
	// Insensitive connections
	always @(*) begin
		andOp_125_in0 = valid ? notOp_124_out : notOp_124_out;
		andOp_125_in1 = valid ? andOp_54_out : andOp_54_out;
	end
	// controller for andOp_128.andOp_128_in0
	// controller for andOp_128.andOp_128_in1
	// Insensitive connections
	always @(*) begin
		andOp_128_in0 = valid ? notOp_127_out : notOp_127_out;
		andOp_128_in1 = valid ? andOp_66_out : andOp_66_out;
	end
	// controller for andOp_129.andOp_129_in0
	// controller for andOp_129.andOp_129_in1
	// Insensitive connections
	always @(*) begin
		andOp_129_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_129_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_130.andOp_130_in0
	// controller for andOp_130.andOp_130_in1
	// Insensitive connections
	always @(*) begin
		andOp_130_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_130_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_131.andOp_131_in0
	// controller for andOp_131.andOp_131_in1
	// Insensitive connections
	always @(*) begin
		andOp_131_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_131_in1 = valid ? state_0_is_active : state_0_is_active;
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
		andOp_133_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_133_in1 = valid ? state_3_is_active : state_3_is_active;
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
		andOp_135_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_135_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_136.andOp_136_in0
	// controller for andOp_136.andOp_136_in1
	// Insensitive connections
	always @(*) begin
		andOp_136_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_136_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_139.andOp_139_in0
	// controller for andOp_139.andOp_139_in1
	// Insensitive connections
	always @(*) begin
		andOp_139_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_139_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_140.andOp_140_in0
	// controller for andOp_140.andOp_140_in1
	// Insensitive connections
	always @(*) begin
		andOp_140_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_140_in1 = valid ? state_2_is_active : state_2_is_active;
	end
	// controller for andOp_141.andOp_141_in0
	// controller for andOp_141.andOp_141_in1
	// Insensitive connections
	always @(*) begin
		andOp_141_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_141_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_142.andOp_142_in0
	// controller for andOp_142.andOp_142_in1
	// Insensitive connections
	always @(*) begin
		andOp_142_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_142_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_145.andOp_145_in0
	// controller for andOp_145.andOp_145_in1
	// Insensitive connections
	always @(*) begin
		andOp_145_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_145_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_146.andOp_146_in0
	// controller for andOp_146.andOp_146_in1
	// Insensitive connections
	always @(*) begin
		andOp_146_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_146_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_147.andOp_147_in0
	// controller for andOp_147.andOp_147_in1
	// Insensitive connections
	always @(*) begin
		andOp_147_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_147_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_148.andOp_148_in0
	// controller for andOp_148.andOp_148_in1
	// Insensitive connections
	always @(*) begin
		andOp_148_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_148_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_149.andOp_149_in0
	// controller for andOp_149.andOp_149_in1
	// Insensitive connections
	always @(*) begin
		andOp_149_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_149_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_150.andOp_150_in0
	// controller for andOp_150.andOp_150_in1
	// Insensitive connections
	always @(*) begin
		andOp_150_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_150_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_151.andOp_151_in0
	// controller for andOp_151.andOp_151_in1
	// Insensitive connections
	always @(*) begin
		andOp_151_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_151_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_152.andOp_152_in0
	// controller for andOp_152.andOp_152_in1
	// Insensitive connections
	always @(*) begin
		andOp_152_in0 = valid ? bb_0_active_in_state_0_out_data : bb_0_active_in_state_0_out_data;
		andOp_152_in1 = valid ? state_0_is_active : state_0_is_active;
	end
	// controller for andOp_153.andOp_153_in0
	// controller for andOp_153.andOp_153_in1
	// Insensitive connections
	always @(*) begin
		andOp_153_in0 = valid ? bb_10_active_in_state_2_out_data : bb_10_active_in_state_2_out_data;
		andOp_153_in1 = valid ? state_2_is_active : state_2_is_active;
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
		andOp_155_in0 = valid ? bb_2_active_in_state_4_out_data : bb_2_active_in_state_4_out_data;
		andOp_155_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_157.andOp_157_in0
	// controller for andOp_157.andOp_157_in1
	// Insensitive connections
	always @(*) begin
		andOp_157_in0 = valid ? notOp_156_out : notOp_156_out;
		andOp_157_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_159.andOp_159_in0
	// controller for andOp_159.andOp_159_in1
	// Insensitive connections
	always @(*) begin
		andOp_159_in0 = valid ? notOp_158_out : notOp_158_out;
		andOp_159_in1 = valid ? andOp_157_out : andOp_157_out;
	end
	// controller for andOp_161.andOp_161_in0
	// controller for andOp_161.andOp_161_in1
	// Insensitive connections
	always @(*) begin
		andOp_161_in0 = valid ? notOp_160_out : notOp_160_out;
		andOp_161_in1 = valid ? andOp_159_out : andOp_159_out;
	end
	// controller for andOp_163.andOp_163_in0
	// controller for andOp_163.andOp_163_in1
	// Insensitive connections
	always @(*) begin
		andOp_163_in0 = valid ? notOp_162_out : notOp_162_out;
		andOp_163_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_165.andOp_165_in0
	// controller for andOp_165.andOp_165_in1
	// Insensitive connections
	always @(*) begin
		andOp_165_in0 = valid ? notOp_164_out : notOp_164_out;
		andOp_165_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_167.andOp_167_in0
	// controller for andOp_167.andOp_167_in1
	// Insensitive connections
	always @(*) begin
		andOp_167_in0 = valid ? notOp_166_out : notOp_166_out;
		andOp_167_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_169.andOp_169_in0
	// controller for andOp_169.andOp_169_in1
	// Insensitive connections
	always @(*) begin
		andOp_169_in0 = valid ? notOp_168_out : notOp_168_out;
		andOp_169_in1 = valid ? andOp_167_out : andOp_167_out;
	end
	// controller for andOp_171.andOp_171_in0
	// controller for andOp_171.andOp_171_in1
	// Insensitive connections
	always @(*) begin
		andOp_171_in0 = valid ? notOp_170_out : notOp_170_out;
		andOp_171_in1 = valid ? andOp_169_out : andOp_169_out;
	end
	// controller for andOp_176.andOp_176_in0
	// controller for andOp_176.andOp_176_in1
	// Insensitive connections
	always @(*) begin
		andOp_176_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_176_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_181.andOp_181_in0
	// controller for andOp_181.andOp_181_in1
	// Insensitive connections
	always @(*) begin
		andOp_181_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_181_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_182.andOp_182_in0
	// controller for andOp_182.andOp_182_in1
	// Insensitive connections
	always @(*) begin
		andOp_182_in0 = valid ? bb_4_active_in_state_3_out_data : bb_4_active_in_state_3_out_data;
		andOp_182_in1 = valid ? state_3_is_active : state_3_is_active;
	end
	// controller for andOp_23.andOp_23_in0
	// controller for andOp_23.andOp_23_in1
	// Insensitive connections
	always @(*) begin
		andOp_23_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_23_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_26_in0 = valid ? bb_0_active_in_state_1_out_data : bb_0_active_in_state_1_out_data;
		andOp_26_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_29_in0 = valid ? bb_3_active_in_state_1_out_data : bb_3_active_in_state_1_out_data;
		andOp_29_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_32_in0 = valid ? bb_9_active_in_state_1_out_data : bb_9_active_in_state_1_out_data;
		andOp_32_in1 = valid ? state_1_is_active : state_1_is_active;
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
		andOp_35_in0 = valid ? andOp_33_out : andOp_33_out;
		andOp_35_in1 = valid ? in_read_ready : in_read_ready;
	end
	// controller for andOp_37.andOp_37_in0
	// controller for andOp_37.andOp_37_in1
	// Insensitive connections
	always @(*) begin
		andOp_37_in0 = valid ? andOp_33_out : andOp_33_out;
		andOp_37_in1 = valid ? notOp_36_out : notOp_36_out;
	end
	// controller for andOp_38.andOp_38_in0
	// controller for andOp_38.andOp_38_in1
	// Insensitive connections
	always @(*) begin
		andOp_38_in0 = valid ? bb_8_active_in_state_1_out_data : bb_8_active_in_state_1_out_data;
		andOp_38_in1 = valid ? state_1_is_active : state_1_is_active;
	end
	// controller for andOp_39.andOp_39_in0
	// controller for andOp_39.andOp_39_in1
	// Insensitive connections
	always @(*) begin
		andOp_39_in0 = valid ? andOp_38_out : andOp_38_out;
		andOp_39_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_41.andOp_41_in0
	// controller for andOp_41.andOp_41_in1
	// Insensitive connections
	always @(*) begin
		andOp_41_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_41_in1 = valid ? state_3_is_active : state_3_is_active;
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
		andOp_44_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_44_in1 = valid ? state_4_is_active : state_4_is_active;
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
		andOp_47_in0 = valid ? andOp_45_out : andOp_45_out;
		andOp_47_in1 = valid ? data_in_4_22_out_data : data_in_4_22_out_data;
	end
	// controller for andOp_49.andOp_49_in0
	// controller for andOp_49.andOp_49_in1
	// Insensitive connections
	always @(*) begin
		andOp_49_in0 = valid ? andOp_45_out : andOp_45_out;
		andOp_49_in1 = valid ? notOp_48_out : notOp_48_out;
	end
	// controller for andOp_50.andOp_50_in0
	// controller for andOp_50.andOp_50_in1
	// Insensitive connections
	always @(*) begin
		andOp_50_in0 = valid ? bb_10_active_in_state_3_out_data : bb_10_active_in_state_3_out_data;
		andOp_50_in1 = valid ? state_3_is_active : state_3_is_active;
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
		andOp_53_in0 = valid ? bb_1_active_in_state_4_out_data : bb_1_active_in_state_4_out_data;
		andOp_53_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_54.andOp_54_in0
	// controller for andOp_54.andOp_54_in1
	// Insensitive connections
	always @(*) begin
		andOp_54_in0 = valid ? andOp_53_out : andOp_53_out;
		andOp_54_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_56.andOp_56_in0
	// controller for andOp_56.andOp_56_in1
	// Insensitive connections
	always @(*) begin
		andOp_56_in0 = valid ? bb_4_active_in_state_4_out_data : bb_4_active_in_state_4_out_data;
		andOp_56_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_57.andOp_57_in0
	// controller for andOp_57.andOp_57_in1
	// Insensitive connections
	always @(*) begin
		andOp_57_in0 = valid ? andOp_56_out : andOp_56_out;
		andOp_57_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_59.andOp_59_in0
	// controller for andOp_59.andOp_59_in1
	// Insensitive connections
	always @(*) begin
		andOp_59_in0 = valid ? andOp_57_out : andOp_57_out;
		andOp_59_in1 = valid ? data_in_4_22_out_data : data_in_4_22_out_data;
	end
	// controller for andOp_61.andOp_61_in0
	// controller for andOp_61.andOp_61_in1
	// Insensitive connections
	always @(*) begin
		andOp_61_in0 = valid ? andOp_57_out : andOp_57_out;
		andOp_61_in1 = valid ? notOp_60_out : notOp_60_out;
	end
	// controller for andOp_62.andOp_62_in0
	// controller for andOp_62.andOp_62_in1
	// Insensitive connections
	always @(*) begin
		andOp_62_in0 = valid ? bb_7_active_in_state_4_out_data : bb_7_active_in_state_4_out_data;
		andOp_62_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_63.andOp_63_in0
	// controller for andOp_63.andOp_63_in1
	// Insensitive connections
	always @(*) begin
		andOp_63_in0 = valid ? andOp_62_out : andOp_62_out;
		andOp_63_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_65.andOp_65_in0
	// controller for andOp_65.andOp_65_in1
	// Insensitive connections
	always @(*) begin
		andOp_65_in0 = valid ? bb_5_active_in_state_4_out_data : bb_5_active_in_state_4_out_data;
		andOp_65_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_66.andOp_66_in0
	// controller for andOp_66.andOp_66_in1
	// Insensitive connections
	always @(*) begin
		andOp_66_in0 = valid ? andOp_65_out : andOp_65_out;
		andOp_66_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_68.andOp_68_in0
	// controller for andOp_68.andOp_68_in1
	// Insensitive connections
	always @(*) begin
		andOp_68_in0 = valid ? bb_6_active_in_state_4_out_data : bb_6_active_in_state_4_out_data;
		andOp_68_in1 = valid ? state_4_is_active : state_4_is_active;
	end
	// controller for andOp_69.andOp_69_in0
	// controller for andOp_69.andOp_69_in1
	// Insensitive connections
	always @(*) begin
		andOp_69_in0 = valid ? andOp_68_out : andOp_68_out;
		andOp_69_in1 = valid ? 1'd1 : 1'd1;
	end
	// controller for andOp_71.andOp_71_in0
	// controller for andOp_71.andOp_71_in1
	// Insensitive connections
	always @(*) begin
		andOp_71_in0 = valid ? andOp_69_out : andOp_69_out;
		andOp_71_in1 = valid ? out_write_ready : out_write_ready;
	end
	// controller for andOp_73.andOp_73_in0
	// controller for andOp_73.andOp_73_in1
	// Insensitive connections
	always @(*) begin
		andOp_73_in0 = valid ? andOp_69_out : andOp_69_out;
		andOp_73_in1 = valid ? notOp_72_out : notOp_72_out;
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_74_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_75_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_97_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_98_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_2.bb_10_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_2_in_data = eq_82_out;
		end else begin
			bb_10_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_active_in_state_3.bb_10_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_10_active_in_state_3_in_data = eq_85_out;
		end else begin
			bb_10_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_2.bb_10_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_108_out) begin 
			bb_10_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for bb_10_predecessor_in_state_3.bb_10_predecessor_in_state_3_in_data
	always @(*) begin
		if (eq_112_out) begin 
			bb_10_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_10_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_1_active_in_state_4.bb_1_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_state_4_in_data = orOp_87_out;
		end else begin
			bb_1_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_1_predecessor_in_state_4.bb_1_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_115_out) begin 
			bb_1_predecessor_in_state_4_in_data = 32'd4;
		end else if (eq_113_out) begin 
			bb_1_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_1_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_active_in_state_4.bb_2_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_state_4_in_data = orOp_92_out;
		end else begin
			bb_2_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_2_predecessor_in_state_4.bb_2_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_122_out) begin 
			bb_2_predecessor_in_state_4_in_data = 32'd7;
		end else if (eq_120_out) begin 
			bb_2_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_2_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_3_active_in_state_1.bb_3_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_state_1_in_data = orOp_77_out;
		end else begin
			bb_3_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_3_predecessor_in_state_1.bb_3_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_101_out) begin 
			bb_3_predecessor_in_state_1_in_data = 32'd0;
		end else if (eq_99_out) begin 
			bb_3_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_3_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_3.bb_4_active_in_state_3_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_3_in_data = orOp_84_out;
		end else begin
			bb_4_active_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_active_in_state_4.bb_4_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_state_4_in_data = eq_88_out;
		end else begin
			bb_4_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_3.bb_4_predecessor_in_state_3_in_data
	always @(*) begin
		if (andOp_111_out) begin 
			bb_4_predecessor_in_state_3_in_data = 32'd10;
		end else if (eq_109_out) begin 
			bb_4_predecessor_in_state_3_in_data = state_3_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_3_in_data = 0;
		end
	end
	// controller for bb_4_predecessor_in_state_4.bb_4_predecessor_in_state_4_in_data
	always @(*) begin
		if (eq_116_out) begin 
			bb_4_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_4_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_active_in_state_4.bb_5_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_5_active_in_state_4_in_data = orOp_94_out;
		end else begin
			bb_5_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_5_predecessor_in_state_4.bb_5_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_125_out) begin 
			bb_5_predecessor_in_state_4_in_data = 32'd1;
		end else if (eq_123_out) begin 
			bb_5_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_5_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_active_in_state_4.bb_6_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_6_active_in_state_4_in_data = orOp_96_out;
		end else begin
			bb_6_active_in_state_4_in_data = 0;
		end
	end
	// controller for bb_6_predecessor_in_state_4.bb_6_predecessor_in_state_4_in_data
	always @(*) begin
		if (andOp_128_out) begin 
			bb_6_predecessor_in_state_4_in_data = 32'd5;
		end else if (eq_126_out) begin 
			bb_6_predecessor_in_state_4_in_data = state_4_last_BB_reg;
		end else begin
			bb_6_predecessor_in_state_4_in_data = 0;
		end
	end
	// controller for bb_7_active_in_state_4.bb_7_active_in_state_4_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_7_active_in_state_4_in_data = orOp_90_out;
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
			bb_8_active_in_state_1_in_data = orOp_81_out;
		end else begin
			bb_8_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_8_predecessor_in_state_1.bb_8_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_107_out) begin 
			bb_8_predecessor_in_state_1_in_data = 32'd3;
		end else if (eq_105_out) begin 
			bb_8_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_8_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_active_in_state_1.bb_9_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_9_active_in_state_1_in_data = orOp_79_out;
		end else begin
			bb_9_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_9_predecessor_in_state_1.bb_9_predecessor_in_state_1_in_data
	always @(*) begin
		if (andOp_104_out) begin 
			bb_9_predecessor_in_state_1_in_data = 32'd8;
		end else if (eq_102_out) begin 
			bb_9_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_9_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_0.br_0_happened_in_state_0_in_data
	always @(*) begin
		if (andOp_24_out) begin 
			br_0_happened_in_state_0_in_data = 1'd1;
		end else if (notOp_25_out) begin 
			br_0_happened_in_state_0_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_0_in_data = 0;
		end
	end
	// controller for br_0_happened_in_state_1.br_0_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_27_out) begin 
			br_0_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_28_out) begin 
			br_0_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_0_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_2.br_10_happened_in_state_2_in_data
	always @(*) begin
		if (andOp_42_out) begin 
			br_10_happened_in_state_2_in_data = 1'd1;
		end else if (notOp_43_out) begin 
			br_10_happened_in_state_2_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_2_in_data = 0;
		end
	end
	// controller for br_10_happened_in_state_3.br_10_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_51_out) begin 
			br_10_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_52_out) begin 
			br_10_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_10_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_1_happened_in_state_4.br_1_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_54_out) begin 
			br_1_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_55_out) begin 
			br_1_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_1_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_3_happened_in_state_1.br_3_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_30_out) begin 
			br_3_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_31_out) begin 
			br_3_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_3_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_3.br_4_happened_in_state_3_in_data
	always @(*) begin
		if (andOp_45_out) begin 
			br_4_happened_in_state_3_in_data = 1'd1;
		end else if (notOp_46_out) begin 
			br_4_happened_in_state_3_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_3_in_data = 0;
		end
	end
	// controller for br_4_happened_in_state_4.br_4_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_57_out) begin 
			br_4_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_58_out) begin 
			br_4_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_4_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_5_happened_in_state_4.br_5_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_66_out) begin 
			br_5_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_67_out) begin 
			br_5_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_5_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_6_happened_in_state_4.br_6_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_69_out) begin 
			br_6_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_70_out) begin 
			br_6_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_6_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_7_happened_in_state_4.br_7_happened_in_state_4_in_data
	always @(*) begin
		if (andOp_63_out) begin 
			br_7_happened_in_state_4_in_data = 1'd1;
		end else if (notOp_64_out) begin 
			br_7_happened_in_state_4_in_data = 1'd0;
		end else begin
			br_7_happened_in_state_4_in_data = 0;
		end
	end
	// controller for br_8_happened_in_state_1.br_8_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_39_out) begin 
			br_8_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_40_out) begin 
			br_8_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_8_happened_in_state_1_in_data = 0;
		end
	end
	// controller for br_9_happened_in_state_1.br_9_happened_in_state_1_in_data
	always @(*) begin
		if (andOp_33_out) begin 
			br_9_happened_in_state_1_in_data = 1'd1;
		end else if (notOp_34_out) begin 
			br_9_happened_in_state_1_in_data = 1'd0;
		end else begin
			br_9_happened_in_state_1_in_data = 0;
		end
	end
	// controller for concat_137.concat_137_in0
	// controller for concat_137.concat_137_in1
	// Insensitive connections
	always @(*) begin
		concat_137_in0 = valid ? data_in_1_7_out_data : data_in_1_7_out_data;
		concat_137_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for concat_138.concat_138_in0
	// controller for concat_138.concat_138_in1
	// Insensitive connections
	always @(*) begin
		concat_138_in0 = valid ? 32'd4 : 32'd4;
		concat_138_in1 = valid ? 32'd0 : 32'd0;
	end
	// controller for data_in_0_1.data_in_0_1_in_data
	always @(*) begin
		if (eq_172_out) begin 
			data_in_0_1_in_data = data_store_0_0;
		end else begin
			data_in_0_1_in_data = 0;
		end
	end
	// controller for data_in_0_3.data_in_0_3_in_data
	always @(*) begin
		if (eq_172_out) begin 
			data_in_0_3_in_data = data_store_0_2;
		end else begin
			data_in_0_3_in_data = 0;
		end
	end
	// controller for data_in_1_5.data_in_1_5_in_data
	always @(*) begin
		if (eq_173_out) begin 
			data_in_1_5_in_data = data_store_0_0;
		end else if (eq_174_out) begin 
			data_in_1_5_in_data = data_store_1_4;
		end else if (eq_175_out) begin 
			data_in_1_5_in_data = data_store_4_17;
		end else begin
			data_in_1_5_in_data = 0;
		end
	end
	// controller for data_in_1_7.data_in_1_7_in_data
	always @(*) begin
		if (eq_173_out) begin 
			data_in_1_7_in_data = data_store_0_2;
		end else if (eq_174_out) begin 
			data_in_1_7_in_data = data_store_1_6;
		end else if (eq_175_out) begin 
			data_in_1_7_in_data = data_store_4_19;
		end else begin
			data_in_1_7_in_data = 0;
		end
	end
	// controller for data_in_2_11.data_in_2_11_in_data
	always @(*) begin
		if (eq_177_out) begin 
			data_in_2_11_in_data = data_store_1_6;
		end else if (eq_178_out) begin 
			data_in_2_11_in_data = data_store_2_10;
		end else begin
			data_in_2_11_in_data = 0;
		end
	end
	// controller for data_in_2_9.data_in_2_9_in_data
	always @(*) begin
		if (eq_177_out) begin 
			data_in_2_9_in_data = data_store_1_4;
		end else if (eq_178_out) begin 
			data_in_2_9_in_data = data_store_2_8;
		end else begin
			data_in_2_9_in_data = 0;
		end
	end
	// controller for data_in_3_13.data_in_3_13_in_data
	always @(*) begin
		if (eq_179_out) begin 
			data_in_3_13_in_data = data_store_2_8;
		end else if (eq_180_out) begin 
			data_in_3_13_in_data = data_store_3_12;
		end else begin
			data_in_3_13_in_data = 0;
		end
	end
	// controller for data_in_3_15.data_in_3_15_in_data
	always @(*) begin
		if (eq_179_out) begin 
			data_in_3_15_in_data = data_store_2_10;
		end else if (eq_180_out) begin 
			data_in_3_15_in_data = data_store_3_14;
		end else begin
			data_in_3_15_in_data = 0;
		end
	end
	// controller for data_in_4_18.data_in_4_18_in_data
	always @(*) begin
		if (eq_183_out) begin 
			data_in_4_18_in_data = data_store_3_12;
		end else if (eq_184_out) begin 
			data_in_4_18_in_data = data_store_4_17;
		end else begin
			data_in_4_18_in_data = 0;
		end
	end
	// controller for data_in_4_20.data_in_4_20_in_data
	always @(*) begin
		if (eq_183_out) begin 
			data_in_4_20_in_data = data_store_3_14;
		end else if (eq_184_out) begin 
			data_in_4_20_in_data = data_store_4_19;
		end else begin
			data_in_4_20_in_data = 0;
		end
	end
	// controller for data_in_4_22.data_in_4_22_in_data
	always @(*) begin
		if (eq_183_out) begin 
			data_in_4_22_in_data = data_store_3_16;
		end else if (eq_184_out) begin 
			data_in_4_22_in_data = data_store_4_21;
		end else begin
			data_in_4_22_in_data = 0;
		end
	end
	// controller for eq_102.eq_102_in0
	// controller for eq_102.eq_102_in1
	// Insensitive connections
	always @(*) begin
		eq_102_in0 = valid ? 32'd9 : 32'd9;
		eq_102_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_105.eq_105_in0
	// controller for eq_105.eq_105_in1
	// Insensitive connections
	always @(*) begin
		eq_105_in0 = valid ? 32'd8 : 32'd8;
		eq_105_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_108.eq_108_in0
	// controller for eq_108.eq_108_in1
	// Insensitive connections
	always @(*) begin
		eq_108_in0 = valid ? 32'd10 : 32'd10;
		eq_108_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_109.eq_109_in0
	// controller for eq_109.eq_109_in1
	// Insensitive connections
	always @(*) begin
		eq_109_in0 = valid ? 32'd4 : 32'd4;
		eq_109_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_112.eq_112_in0
	// controller for eq_112.eq_112_in1
	// Insensitive connections
	always @(*) begin
		eq_112_in0 = valid ? 32'd10 : 32'd10;
		eq_112_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_113.eq_113_in0
	// controller for eq_113.eq_113_in1
	// Insensitive connections
	always @(*) begin
		eq_113_in0 = valid ? 32'd1 : 32'd1;
		eq_113_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_116.eq_116_in0
	// controller for eq_116.eq_116_in1
	// Insensitive connections
	always @(*) begin
		eq_116_in0 = valid ? 32'd4 : 32'd4;
		eq_116_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
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
		eq_120_in0 = valid ? 32'd2 : 32'd2;
		eq_120_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_123.eq_123_in0
	// controller for eq_123.eq_123_in1
	// Insensitive connections
	always @(*) begin
		eq_123_in0 = valid ? 32'd5 : 32'd5;
		eq_123_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_126.eq_126_in0
	// controller for eq_126.eq_126_in1
	// Insensitive connections
	always @(*) begin
		eq_126_in0 = valid ? 32'd6 : 32'd6;
		eq_126_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_144.eq_144_in0
	// controller for eq_144.eq_144_in1
	// Insensitive connections
	always @(*) begin
		eq_144_in0 = valid ? 32'd10 : 32'd10;
		eq_144_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_172.eq_172_in0
	// controller for eq_172.eq_172_in1
	// Insensitive connections
	always @(*) begin
		eq_172_in0 = valid ? 32'd0 : 32'd0;
		eq_172_in1 = valid ? state_0_last_state : state_0_last_state;
	end
	// controller for eq_173.eq_173_in0
	// controller for eq_173.eq_173_in1
	// Insensitive connections
	always @(*) begin
		eq_173_in0 = valid ? 32'd0 : 32'd0;
		eq_173_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_174.eq_174_in0
	// controller for eq_174.eq_174_in1
	// Insensitive connections
	always @(*) begin
		eq_174_in0 = valid ? 32'd1 : 32'd1;
		eq_174_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_175.eq_175_in0
	// controller for eq_175.eq_175_in1
	// Insensitive connections
	always @(*) begin
		eq_175_in0 = valid ? 32'd4 : 32'd4;
		eq_175_in1 = valid ? state_1_last_state : state_1_last_state;
	end
	// controller for eq_177.eq_177_in0
	// controller for eq_177.eq_177_in1
	// Insensitive connections
	always @(*) begin
		eq_177_in0 = valid ? 32'd1 : 32'd1;
		eq_177_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_178.eq_178_in0
	// controller for eq_178.eq_178_in1
	// Insensitive connections
	always @(*) begin
		eq_178_in0 = valid ? 32'd2 : 32'd2;
		eq_178_in1 = valid ? state_2_last_state : state_2_last_state;
	end
	// controller for eq_179.eq_179_in0
	// controller for eq_179.eq_179_in1
	// Insensitive connections
	always @(*) begin
		eq_179_in0 = valid ? 32'd2 : 32'd2;
		eq_179_in1 = valid ? state_3_last_state : state_3_last_state;
	end
	// controller for eq_180.eq_180_in0
	// controller for eq_180.eq_180_in1
	// Insensitive connections
	always @(*) begin
		eq_180_in0 = valid ? 32'd3 : 32'd3;
		eq_180_in1 = valid ? state_3_last_state : state_3_last_state;
	end
	// controller for eq_183.eq_183_in0
	// controller for eq_183.eq_183_in1
	// Insensitive connections
	always @(*) begin
		eq_183_in0 = valid ? 32'd3 : 32'd3;
		eq_183_in1 = valid ? state_4_last_state : state_4_last_state;
	end
	// controller for eq_184.eq_184_in0
	// controller for eq_184.eq_184_in1
	// Insensitive connections
	always @(*) begin
		eq_184_in0 = valid ? 32'd4 : 32'd4;
		eq_184_in1 = valid ? state_4_last_state : state_4_last_state;
	end
	// controller for eq_74.eq_74_in0
	// controller for eq_74.eq_74_in1
	// Insensitive connections
	always @(*) begin
		eq_74_in0 = valid ? 32'd0 : 32'd0;
		eq_74_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_75.eq_75_in0
	// controller for eq_75.eq_75_in1
	// Insensitive connections
	always @(*) begin
		eq_75_in0 = valid ? 32'd0 : 32'd0;
		eq_75_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_76.eq_76_in0
	// controller for eq_76.eq_76_in1
	// Insensitive connections
	always @(*) begin
		eq_76_in0 = valid ? 32'd3 : 32'd3;
		eq_76_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_78.eq_78_in0
	// controller for eq_78.eq_78_in1
	// Insensitive connections
	always @(*) begin
		eq_78_in0 = valid ? 32'd9 : 32'd9;
		eq_78_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_80.eq_80_in0
	// controller for eq_80.eq_80_in1
	// Insensitive connections
	always @(*) begin
		eq_80_in0 = valid ? 32'd8 : 32'd8;
		eq_80_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_82.eq_82_in0
	// controller for eq_82.eq_82_in1
	// Insensitive connections
	always @(*) begin
		eq_82_in0 = valid ? 32'd10 : 32'd10;
		eq_82_in1 = valid ? state_2_entry_BB_reg : state_2_entry_BB_reg;
	end
	// controller for eq_83.eq_83_in0
	// controller for eq_83.eq_83_in1
	// Insensitive connections
	always @(*) begin
		eq_83_in0 = valid ? 32'd4 : 32'd4;
		eq_83_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_85.eq_85_in0
	// controller for eq_85.eq_85_in1
	// Insensitive connections
	always @(*) begin
		eq_85_in0 = valid ? 32'd10 : 32'd10;
		eq_85_in1 = valid ? state_3_entry_BB_reg : state_3_entry_BB_reg;
	end
	// controller for eq_86.eq_86_in0
	// controller for eq_86.eq_86_in1
	// Insensitive connections
	always @(*) begin
		eq_86_in0 = valid ? 32'd1 : 32'd1;
		eq_86_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_88.eq_88_in0
	// controller for eq_88.eq_88_in1
	// Insensitive connections
	always @(*) begin
		eq_88_in0 = valid ? 32'd4 : 32'd4;
		eq_88_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_89.eq_89_in0
	// controller for eq_89.eq_89_in1
	// Insensitive connections
	always @(*) begin
		eq_89_in0 = valid ? 32'd7 : 32'd7;
		eq_89_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_91.eq_91_in0
	// controller for eq_91.eq_91_in1
	// Insensitive connections
	always @(*) begin
		eq_91_in0 = valid ? 32'd2 : 32'd2;
		eq_91_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_93.eq_93_in0
	// controller for eq_93.eq_93_in1
	// Insensitive connections
	always @(*) begin
		eq_93_in0 = valid ? 32'd5 : 32'd5;
		eq_93_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_95.eq_95_in0
	// controller for eq_95.eq_95_in1
	// Insensitive connections
	always @(*) begin
		eq_95_in0 = valid ? 32'd6 : 32'd6;
		eq_95_in1 = valid ? state_4_entry_BB_reg : state_4_entry_BB_reg;
	end
	// controller for eq_97.eq_97_in0
	// controller for eq_97.eq_97_in1
	// Insensitive connections
	always @(*) begin
		eq_97_in0 = valid ? 32'd0 : 32'd0;
		eq_97_in1 = valid ? state_0_entry_BB_reg : state_0_entry_BB_reg;
	end
	// controller for eq_98.eq_98_in0
	// controller for eq_98.eq_98_in1
	// Insensitive connections
	always @(*) begin
		eq_98_in0 = valid ? 32'd0 : 32'd0;
		eq_98_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for eq_99.eq_99_in0
	// controller for eq_99.eq_99_in1
	// Insensitive connections
	always @(*) begin
		eq_99_in0 = valid ? 32'd3 : 32'd3;
		eq_99_in1 = valid ? state_1_entry_BB_reg : state_1_entry_BB_reg;
	end
	// controller for icmp_15.cmp_in0_icmp_15
	// controller for icmp_15.cmp_in1_icmp_15
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_15 = valid ? add_out_add_14 : add_out_add_14;
		cmp_in1_icmp_15 = valid ? 32'd4 : 32'd4;
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if (andOp_140_out) begin 
			in_read_valid_reg = -(1'd1);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for notOp_100.notOp_100_in0
	// Insensitive connections
	always @(*) begin
		notOp_100_in0 = valid ? eq_99_out : eq_99_out;
	end
	// controller for notOp_103.notOp_103_in0
	// Insensitive connections
	always @(*) begin
		notOp_103_in0 = valid ? eq_102_out : eq_102_out;
	end
	// controller for notOp_106.notOp_106_in0
	// Insensitive connections
	always @(*) begin
		notOp_106_in0 = valid ? eq_105_out : eq_105_out;
	end
	// controller for notOp_110.notOp_110_in0
	// Insensitive connections
	always @(*) begin
		notOp_110_in0 = valid ? eq_109_out : eq_109_out;
	end
	// controller for notOp_114.notOp_114_in0
	// Insensitive connections
	always @(*) begin
		notOp_114_in0 = valid ? eq_113_out : eq_113_out;
	end
	// controller for notOp_118.notOp_118_in0
	// Insensitive connections
	always @(*) begin
		notOp_118_in0 = valid ? eq_117_out : eq_117_out;
	end
	// controller for notOp_121.notOp_121_in0
	// Insensitive connections
	always @(*) begin
		notOp_121_in0 = valid ? eq_120_out : eq_120_out;
	end
	// controller for notOp_124.notOp_124_in0
	// Insensitive connections
	always @(*) begin
		notOp_124_in0 = valid ? eq_123_out : eq_123_out;
	end
	// controller for notOp_127.notOp_127_in0
	// Insensitive connections
	always @(*) begin
		notOp_127_in0 = valid ? eq_126_out : eq_126_out;
	end
	// controller for notOp_156.notOp_156_in0
	// Insensitive connections
	always @(*) begin
		notOp_156_in0 = valid ? andOp_152_out : andOp_152_out;
	end
	// controller for notOp_158.notOp_158_in0
	// Insensitive connections
	always @(*) begin
		notOp_158_in0 = valid ? andOp_37_out : andOp_37_out;
	end
	// controller for notOp_160.notOp_160_in0
	// Insensitive connections
	always @(*) begin
		notOp_160_in0 = valid ? andOp_49_out : andOp_49_out;
	end
	// controller for notOp_162.notOp_162_in0
	// Insensitive connections
	always @(*) begin
		notOp_162_in0 = valid ? andOp_35_out : andOp_35_out;
	end
	// controller for notOp_164.notOp_164_in0
	// Insensitive connections
	always @(*) begin
		notOp_164_in0 = valid ? andOp_153_out : andOp_153_out;
	end
	// controller for notOp_166.notOp_166_in0
	// Insensitive connections
	always @(*) begin
		notOp_166_in0 = valid ? andOp_154_out : andOp_154_out;
	end
	// controller for notOp_168.notOp_168_in0
	// Insensitive connections
	always @(*) begin
		notOp_168_in0 = valid ? andOp_155_out : andOp_155_out;
	end
	// controller for notOp_170.notOp_170_in0
	// Insensitive connections
	always @(*) begin
		notOp_170_in0 = valid ? andOp_73_out : andOp_73_out;
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
	// controller for notOp_36.notOp_36_in0
	// Insensitive connections
	always @(*) begin
		notOp_36_in0 = valid ? in_read_ready : in_read_ready;
	end
	// controller for notOp_40.notOp_40_in0
	// Insensitive connections
	always @(*) begin
		notOp_40_in0 = valid ? andOp_39_out : andOp_39_out;
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
	// controller for notOp_48.notOp_48_in0
	// Insensitive connections
	always @(*) begin
		notOp_48_in0 = valid ? data_in_4_22_out_data : data_in_4_22_out_data;
	end
	// controller for notOp_52.notOp_52_in0
	// Insensitive connections
	always @(*) begin
		notOp_52_in0 = valid ? andOp_51_out : andOp_51_out;
	end
	// controller for notOp_55.notOp_55_in0
	// Insensitive connections
	always @(*) begin
		notOp_55_in0 = valid ? andOp_54_out : andOp_54_out;
	end
	// controller for notOp_58.notOp_58_in0
	// Insensitive connections
	always @(*) begin
		notOp_58_in0 = valid ? andOp_57_out : andOp_57_out;
	end
	// controller for notOp_60.notOp_60_in0
	// Insensitive connections
	always @(*) begin
		notOp_60_in0 = valid ? data_in_4_22_out_data : data_in_4_22_out_data;
	end
	// controller for notOp_64.notOp_64_in0
	// Insensitive connections
	always @(*) begin
		notOp_64_in0 = valid ? andOp_63_out : andOp_63_out;
	end
	// controller for notOp_67.notOp_67_in0
	// Insensitive connections
	always @(*) begin
		notOp_67_in0 = valid ? andOp_66_out : andOp_66_out;
	end
	// controller for notOp_70.notOp_70_in0
	// Insensitive connections
	always @(*) begin
		notOp_70_in0 = valid ? andOp_69_out : andOp_69_out;
	end
	// controller for notOp_72.notOp_72_in0
	// Insensitive connections
	always @(*) begin
		notOp_72_in0 = valid ? out_write_ready : out_write_ready;
	end
	// controller for orOp_77.orOp_77_in0
	// controller for orOp_77.orOp_77_in1
	// Insensitive connections
	always @(*) begin
		orOp_77_in0 = valid ? eq_76_out : eq_76_out;
		orOp_77_in1 = valid ? andOp_24_out : andOp_24_out;
	end
	// controller for orOp_79.orOp_79_in0
	// controller for orOp_79.orOp_79_in1
	// Insensitive connections
	always @(*) begin
		orOp_79_in0 = valid ? eq_78_out : eq_78_out;
		orOp_79_in1 = valid ? andOp_39_out : andOp_39_out;
	end
	// controller for orOp_81.orOp_81_in0
	// controller for orOp_81.orOp_81_in1
	// Insensitive connections
	always @(*) begin
		orOp_81_in0 = valid ? eq_80_out : eq_80_out;
		orOp_81_in1 = valid ? andOp_30_out : andOp_30_out;
	end
	// controller for orOp_84.orOp_84_in0
	// controller for orOp_84.orOp_84_in1
	// Insensitive connections
	always @(*) begin
		orOp_84_in0 = valid ? eq_83_out : eq_83_out;
		orOp_84_in1 = valid ? andOp_42_out : andOp_42_out;
	end
	// controller for orOp_87.orOp_87_in0
	// controller for orOp_87.orOp_87_in1
	// Insensitive connections
	always @(*) begin
		orOp_87_in0 = valid ? eq_86_out : eq_86_out;
		orOp_87_in1 = valid ? andOp_47_out : andOp_47_out;
	end
	// controller for orOp_90.orOp_90_in0
	// controller for orOp_90.orOp_90_in1
	// Insensitive connections
	always @(*) begin
		orOp_90_in0 = valid ? eq_89_out : eq_89_out;
		orOp_90_in1 = valid ? andOp_71_out : andOp_71_out;
	end
	// controller for orOp_92.orOp_92_in0
	// controller for orOp_92.orOp_92_in1
	// Insensitive connections
	always @(*) begin
		orOp_92_in0 = valid ? eq_91_out : eq_91_out;
		orOp_92_in1 = valid ? andOp_63_out : andOp_63_out;
	end
	// controller for orOp_94.orOp_94_in0
	// controller for orOp_94.orOp_94_in1
	// Insensitive connections
	always @(*) begin
		orOp_94_in0 = valid ? eq_93_out : eq_93_out;
		orOp_94_in1 = valid ? andOp_54_out : andOp_54_out;
	end
	// controller for orOp_96.orOp_96_in0
	// controller for orOp_96.orOp_96_in1
	// Insensitive connections
	always @(*) begin
		orOp_96_in0 = valid ? eq_95_out : eq_95_out;
		orOp_96_in1 = valid ? andOp_66_out : andOp_66_out;
	end
	// controller for out.out_in_data_reg
	always @(*) begin
		if (andOp_151_out) begin 
			out_in_data_reg = rdata_ram_0;
		end else begin
			out_in_data_reg = 0;
		end
	end
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (andOp_149_out) begin 
			out_write_valid_reg = -(1'd1);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// controller for phi_5.phi_in_phi_5
	// controller for phi_5.phi_last_block_phi_5
	// controller for phi_5.phi_s_phi_5
	// Insensitive connections
	always @(*) begin
		phi_in_phi_5 = valid ? concat_137_out : concat_137_out;
		phi_last_block_phi_5 = valid ? bb_3_predecessor_in_state_1_out_data : bb_3_predecessor_in_state_1_out_data;
		phi_s_phi_5 = valid ? concat_138_out : concat_138_out;
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (andOp_133_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else if (andOp_135_out) begin 
			raddr_ram_0_reg = 32'd0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (andOp_132_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else if (andOp_134_out) begin 
			waddr_ram_0_reg = 32'd0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (andOp_132_out) begin 
			wdata_ram_0_reg = 32'd0;
		end else if (andOp_134_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (andOp_132_out) begin 
			wen_ram_0_reg = 1'd1;
		end else if (andOp_134_out) begin 
			wen_ram_0_reg = 1'd1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_19.valid_reg
	always @(*) begin
		if (andOp_148_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// controller for tmp_output_143.tmp_output_143_in_data
	always @(*) begin
		if (eq_144_out) begin 
			tmp_output_143_in_data = in_out_data;
		end else begin
			tmp_output_143_in_data = 0;
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
			data_store_0_2 <= 0;
		end else begin
			if (state_0_is_active) begin
				data_store_0_2 <= data_in_0_3_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_4 <= 0;
		end else begin
			if (andOp_176_out) begin
				data_store_1_4 <= phi_out_phi_5;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_1_6 <= 0;
		end else begin
			if (state_1_is_active) begin
				data_store_1_6 <= data_in_1_7_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_10 <= 0;
		end else begin
			if (state_2_is_active) begin
				data_store_2_10 <= data_in_2_11_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_2_8 <= 0;
		end else begin
			if (state_2_is_active) begin
				data_store_2_8 <= data_in_2_9_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_12 <= 0;
		end else begin
			if (state_3_is_active) begin
				data_store_3_12 <= data_in_3_13_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_14 <= 0;
		end else begin
			if (andOp_181_out) begin
				data_store_3_14 <= add_out_add_14;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_3_16 <= 0;
		end else begin
			if (andOp_182_out) begin
				data_store_3_16 <= cmp_out_icmp_15;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_17 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_17 <= data_in_4_18_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_19 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_19 <= data_in_4_20_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			data_store_4_21 <= 0;
		end else begin
			if (state_4_is_active) begin
				data_store_4_21 <= data_in_4_22_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_152_out) begin
				global_state <= 32'd1;
			end
			if (andOp_153_out) begin
				global_state <= 32'd3;
			end
			if (andOp_154_out) begin
				global_state <= 32'd4;
			end
			if (andOp_155_out) begin
				global_state <= 32'd4;
			end
			if (andOp_35_out) begin
				global_state <= 32'd2;
			end
			if (andOp_37_out) begin
				global_state <= 32'd1;
			end
			if (andOp_49_out) begin
				global_state <= 32'd1;
			end
			if (andOp_73_out) begin
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
			if (andOp_152_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
			if (andOp_37_out) begin
				state_1_entry_BB_reg <= 32'd9;
			end
			if (andOp_49_out) begin
				state_1_entry_BB_reg <= 32'd3;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_152_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_161_out) begin
				state_1_is_active <= 1'd0;
			end
			if (andOp_37_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_49_out) begin
				state_1_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_152_out) begin
				state_1_last_BB_reg <= bb_0_predecessor_in_state_0_out_data;
			end
			if (andOp_37_out) begin
				state_1_last_BB_reg <= 32'd9;
			end
			if (andOp_49_out) begin
				state_1_last_BB_reg <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_152_out) begin
				state_1_last_state <= 32'd0;
			end
			if (andOp_37_out) begin
				state_1_last_state <= 32'd1;
			end
			if (andOp_49_out) begin
				state_1_last_state <= 32'd4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_35_out) begin
				state_2_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_163_out) begin
				state_2_is_active <= 1'd0;
			end
			if (andOp_35_out) begin
				state_2_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_35_out) begin
				state_2_last_BB_reg <= 32'd9;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_35_out) begin
				state_2_last_state <= 32'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_entry_BB_reg <= 0;
		end else begin
			if (andOp_153_out) begin
				state_3_entry_BB_reg <= 32'd10;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_is_active <= 0;
		end else begin
			if (andOp_153_out) begin
				state_3_is_active <= 1'd1;
			end
			if (andOp_165_out) begin
				state_3_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_BB_reg <= 0;
		end else begin
			if (andOp_153_out) begin
				state_3_last_BB_reg <= bb_10_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_3_last_state <= 0;
		end else begin
			if (andOp_153_out) begin
				state_3_last_state <= 32'd2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_entry_BB_reg <= 0;
		end else begin
			if (andOp_154_out) begin
				state_4_entry_BB_reg <= 32'd4;
			end
			if (andOp_155_out) begin
				state_4_entry_BB_reg <= 32'd2;
			end
			if (andOp_73_out) begin
				state_4_entry_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_is_active <= 0;
		end else begin
			if (andOp_154_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_155_out) begin
				state_4_is_active <= 1'd1;
			end
			if (andOp_171_out) begin
				state_4_is_active <= 1'd0;
			end
			if (andOp_73_out) begin
				state_4_is_active <= 1'd1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_BB_reg <= 0;
		end else begin
			if (andOp_154_out) begin
				state_4_last_BB_reg <= bb_4_predecessor_in_state_3_out_data;
			end
			if (andOp_155_out) begin
				state_4_last_BB_reg <= bb_2_predecessor_in_state_4_out_data;
			end
			if (andOp_73_out) begin
				state_4_last_BB_reg <= 32'd6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_4_last_state <= 0;
		end else begin
			if (andOp_154_out) begin
				state_4_last_state <= 32'd3;
			end
			if (andOp_155_out) begin
				state_4_last_state <= 32'd4;
			end
			if (andOp_73_out) begin
				state_4_last_state <= 32'd4;
			end
		end
	end

endmodule

