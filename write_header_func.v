module write_header_func(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [47:0] arg_0_raddr, input [47:0] arg_0_rdata, output [47:0] arg_0_waddr, output [47:0] arg_0_wdata, output [0:0] arg_0_wen, output [47:0] arg_1_raddr, input [47:0] arg_1_rdata, output [47:0] arg_1_waddr, output [47:0] arg_1_wdata, output [0:0] arg_1_wen, output [15:0] arg_2_raddr, input [15:0] arg_2_rdata, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [0:0] arg_3_busy, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, input [0:0] arg_3_s_eth_hdr_ready, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, input [0:0] arg_3_s_eth_payload_axis_tready, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type);

	reg [0:0] valid_reg;
	reg [47:0] arg_0_raddr_reg;
	reg [47:0] arg_0_waddr_reg;
	reg [47:0] arg_0_wdata_reg;
	reg [0:0] arg_0_wen_reg;
	reg [47:0] arg_1_raddr_reg;
	reg [47:0] arg_1_waddr_reg;
	reg [47:0] arg_1_wdata_reg;
	reg [0:0] arg_1_wen_reg;
	reg [15:0] arg_2_raddr_reg;
	reg [15:0] arg_2_waddr_reg;
	reg [15:0] arg_2_wdata_reg;
	reg [0:0] arg_2_wen_reg;
	reg [0:0] arg_3_m_axis_tready_reg;
	reg [47:0] arg_3_s_eth_dest_mac_reg;
	reg [0:0] arg_3_s_eth_hdr_valid_reg;
	reg [7:0] arg_3_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_3_s_eth_src_mac_reg;
	reg [15:0] arg_3_s_eth_type_reg;

	assign valid = valid_reg;
	assign arg_0_raddr = arg_0_raddr_reg;
	assign arg_0_waddr = arg_0_waddr_reg;
	assign arg_0_wdata = arg_0_wdata_reg;
	assign arg_0_wen = arg_0_wen_reg;
	assign arg_1_raddr = arg_1_raddr_reg;
	assign arg_1_waddr = arg_1_waddr_reg;
	assign arg_1_wdata = arg_1_wdata_reg;
	assign arg_1_wen = arg_1_wen_reg;
	assign arg_2_raddr = arg_2_raddr_reg;
	assign arg_2_waddr = arg_2_waddr_reg;
	assign arg_2_wdata = arg_2_wdata_reg;
	assign arg_2_wen = arg_2_wen_reg;
	assign arg_3_m_axis_tready = arg_3_m_axis_tready_reg;
	assign arg_3_s_eth_dest_mac = arg_3_s_eth_dest_mac_reg;
	assign arg_3_s_eth_hdr_valid = arg_3_s_eth_hdr_valid_reg;
	assign arg_3_s_eth_payload_axis_tdata = arg_3_s_eth_payload_axis_tdata_reg;
	assign arg_3_s_eth_payload_axis_tlast = arg_3_s_eth_payload_axis_tlast_reg;
	assign arg_3_s_eth_payload_axis_tuser = arg_3_s_eth_payload_axis_tuser_reg;
	assign arg_3_s_eth_payload_axis_tvalid = arg_3_s_eth_payload_axis_tvalid_reg;
	assign arg_3_s_eth_src_mac = arg_3_s_eth_src_mac_reg;
	assign arg_3_s_eth_type = arg_3_s_eth_type_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call1();

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

	reg [0:0] bb_0_active_in_state_2_in_data;
	wire [0:0] bb_0_active_in_state_2_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active_in_state_2(.in_data(bb_0_active_in_state_2_in_data), .out_data(bb_0_active_in_state_2_out_data));

	reg [31:0] bb_0_predecessor_in_state_2_in_data;
	wire [31:0] bb_0_predecessor_in_state_2_out_data;
	hls_wire #(.WIDTH(32)) bb_0_predecessor_in_state_2(.in_data(bb_0_predecessor_in_state_2_in_data), .out_data(bb_0_predecessor_in_state_2_out_data));

	wire [31:0] eq_0_in0;
	wire [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	wire [31:0] eq_1_in0;
	wire [31:0] eq_1_in1;
	wire [0:0] eq_1_out;
	eq #(.WIDTH(32)) eq_1(.in0(eq_1_in0), .in1(eq_1_in1), .out(eq_1_out));

	wire [31:0] eq_2_in0;
	wire [31:0] eq_2_in1;
	wire [0:0] eq_2_out;
	eq #(.WIDTH(32)) eq_2(.in0(eq_2_in0), .in1(eq_2_in1), .out(eq_2_out));

	wire [31:0] eq_3_in0;
	wire [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	wire [31:0] eq_4_in0;
	wire [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	wire [31:0] eq_5_in0;
	wire [31:0] eq_5_in1;
	wire [0:0] eq_5_out;
	eq #(.WIDTH(32)) eq_5(.in0(eq_5_in0), .in1(eq_5_in1), .out(eq_5_out));

	wire [0:0] andOp_6_in0;
	wire [0:0] andOp_6_in1;
	wire [0:0] andOp_6_out;
	andOp #(.WIDTH(1)) andOp_6(.in0(andOp_6_in0), .in1(andOp_6_in1), .out(andOp_6_out));

	wire [0:0] andOp_7_in0;
	wire [0:0] andOp_7_in1;
	wire [0:0] andOp_7_out;
	andOp #(.WIDTH(1)) andOp_7(.in0(andOp_7_in0), .in1(andOp_7_in1), .out(andOp_7_out));

	wire [0:0] andOp_8_in0;
	wire [0:0] andOp_8_in1;
	wire [0:0] andOp_8_out;
	andOp #(.WIDTH(1)) andOp_8(.in0(andOp_8_in0), .in1(andOp_8_in1), .out(andOp_8_out));

	wire [0:0] andOp_9_in0;
	wire [0:0] andOp_9_in1;
	wire [0:0] andOp_9_out;
	andOp #(.WIDTH(1)) andOp_9(.in0(andOp_9_in0), .in1(andOp_9_in1), .out(andOp_9_out));

	wire [0:0] andOp_10_in0;
	wire [0:0] andOp_10_in1;
	wire [0:0] andOp_10_out;
	andOp #(.WIDTH(1)) andOp_10(.in0(andOp_10_in0), .in1(andOp_10_in1), .out(andOp_10_out));

	wire [0:0] andOp_11_in0;
	wire [0:0] andOp_11_in1;
	wire [0:0] andOp_11_out;
	andOp #(.WIDTH(1)) andOp_11(.in0(andOp_11_in0), .in1(andOp_11_in1), .out(andOp_11_out));

	wire [0:0] andOp_12_in0;
	wire [0:0] andOp_12_in1;
	wire [0:0] andOp_12_out;
	andOp #(.WIDTH(1)) andOp_12(.in0(andOp_12_in0), .in1(andOp_12_in1), .out(andOp_12_out));

	wire [0:0] andOp_13_in0;
	wire [0:0] andOp_13_in1;
	wire [0:0] andOp_13_out;
	andOp #(.WIDTH(1)) andOp_13(.in0(andOp_13_in0), .in1(andOp_13_in1), .out(andOp_13_out));

	wire [0:0] andOp_14_in0;
	wire [0:0] andOp_14_in1;
	wire [0:0] andOp_14_out;
	andOp #(.WIDTH(1)) andOp_14(.in0(andOp_14_in0), .in1(andOp_14_in1), .out(andOp_14_out));

	wire [0:0] andOp_15_in0;
	wire [0:0] andOp_15_in1;
	wire [0:0] andOp_15_out;
	andOp #(.WIDTH(1)) andOp_15(.in0(andOp_15_in0), .in1(andOp_15_in1), .out(andOp_15_out));

	wire [0:0] andOp_16_in0;
	wire [0:0] andOp_16_in1;
	wire [0:0] andOp_16_out;
	andOp #(.WIDTH(1)) andOp_16(.in0(andOp_16_in0), .in1(andOp_16_in1), .out(andOp_16_out));

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

	wire [0:0] notOp_23_in0;
	wire [0:0] notOp_23_out;
	notOp #(.WIDTH(1)) notOp_23(.in(notOp_23_in0), .out(notOp_23_out));

	wire [0:0] andOp_24_in0;
	wire [0:0] andOp_24_in1;
	wire [0:0] andOp_24_out;
	andOp #(.WIDTH(1)) andOp_24(.in0(andOp_24_in0), .in1(andOp_24_in1), .out(andOp_24_out));

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

	// End Functional Units

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

	// controller for andOp_10.andOp_10_in0
	// controller for andOp_10.andOp_10_in1
	// Insensitive connections
	assign andOp_10_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_10_in1 = state_1_is_active;
	// controller for andOp_11.andOp_11_in0
	// controller for andOp_11.andOp_11_in1
	// Insensitive connections
	assign andOp_11_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_11_in1 = state_0_is_active;
	// controller for andOp_12.andOp_12_in0
	// controller for andOp_12.andOp_12_in1
	// Insensitive connections
	assign andOp_12_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_12_in1 = state_1_is_active;
	// controller for andOp_13.andOp_13_in0
	// controller for andOp_13.andOp_13_in1
	// Insensitive connections
	assign andOp_13_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_13_in1 = state_1_is_active;
	// controller for andOp_14.andOp_14_in0
	// controller for andOp_14.andOp_14_in1
	// Insensitive connections
	assign andOp_14_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_14_in1 = state_1_is_active;
	// controller for andOp_15.andOp_15_in0
	// controller for andOp_15.andOp_15_in1
	// Insensitive connections
	assign andOp_15_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_15_in1 = state_2_is_active;
	// controller for andOp_16.andOp_16_in0
	// controller for andOp_16.andOp_16_in1
	// Insensitive connections
	assign andOp_16_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_16_in1 = state_0_is_active;
	// controller for andOp_17.andOp_17_in0
	// controller for andOp_17.andOp_17_in1
	// Insensitive connections
	assign andOp_17_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_17_in1 = state_1_is_active;
	// controller for andOp_18.andOp_18_in0
	// controller for andOp_18.andOp_18_in1
	// Insensitive connections
	assign andOp_18_in0 = bb_0_active_in_state_2_out_data;
	assign andOp_18_in1 = state_2_is_active;
	// controller for andOp_20.andOp_20_in0
	// controller for andOp_20.andOp_20_in1
	// Insensitive connections
	assign andOp_20_in0 = notOp_19_out;
	assign andOp_20_in1 = 1'd1;
	// controller for andOp_22.andOp_22_in0
	// controller for andOp_22.andOp_22_in1
	// Insensitive connections
	assign andOp_22_in0 = notOp_21_out;
	assign andOp_22_in1 = 1'd1;
	// controller for andOp_24.andOp_24_in0
	// controller for andOp_24.andOp_24_in1
	// Insensitive connections
	assign andOp_24_in0 = notOp_23_out;
	assign andOp_24_in1 = andOp_22_out;
	// controller for andOp_6.andOp_6_in0
	// controller for andOp_6.andOp_6_in1
	// Insensitive connections
	assign andOp_6_in0 = bb_0_active_in_state_0_out_data;
	assign andOp_6_in1 = state_0_is_active;
	// controller for andOp_7.andOp_7_in0
	// controller for andOp_7.andOp_7_in1
	// Insensitive connections
	assign andOp_7_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_7_in1 = state_1_is_active;
	// controller for andOp_8.andOp_8_in0
	// controller for andOp_8.andOp_8_in1
	// Insensitive connections
	assign andOp_8_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_8_in1 = state_1_is_active;
	// controller for andOp_9.andOp_9_in0
	// controller for andOp_9.andOp_9_in1
	// Insensitive connections
	assign andOp_9_in0 = bb_0_active_in_state_1_out_data;
	assign andOp_9_in1 = state_1_is_active;
	// controller for arg_0.arg_0_raddr_reg
	always @(*) begin
		if (andOp_14_out) begin 
			arg_0_raddr_reg = arg_0_rdata;
		end else begin
			arg_0_raddr_reg = 0;
		end
	end
	// controller for arg_1.arg_1_raddr_reg
	always @(*) begin
		if (andOp_13_out) begin 
			arg_1_raddr_reg = arg_1_rdata;
		end else begin
			arg_1_raddr_reg = 0;
		end
	end
	// controller for arg_2.arg_2_raddr_reg
	always @(*) begin
		if (andOp_12_out) begin 
			arg_2_raddr_reg = arg_2_rdata;
		end else begin
			arg_2_raddr_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_eth_dest_mac_reg
	always @(*) begin
		if (andOp_8_out) begin 
			arg_3_s_eth_dest_mac_reg = arg_0_rdata;
		end else begin
			arg_3_s_eth_dest_mac_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_eth_hdr_valid_reg
	always @(*) begin
		if (andOp_7_out) begin 
			arg_3_s_eth_hdr_valid_reg = 32'd1;
		end else begin
			arg_3_s_eth_hdr_valid_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_eth_src_mac_reg
	always @(*) begin
		if (andOp_9_out) begin 
			arg_3_s_eth_src_mac_reg = arg_1_rdata;
		end else begin
			arg_3_s_eth_src_mac_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_eth_type_reg
	always @(*) begin
		if (andOp_10_out) begin 
			arg_3_s_eth_type_reg = arg_2_rdata;
		end else begin
			arg_3_s_eth_type_reg = 0;
		end
	end
	// controller for bb_0_active_in_state_0.bb_0_active_in_state_0_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_0_in_data = eq_0_out;
		end else begin
			bb_0_active_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_1.bb_0_active_in_state_1_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_1_in_data = eq_1_out;
		end else begin
			bb_0_active_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_active_in_state_2.bb_0_active_in_state_2_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_state_2_in_data = eq_2_out;
		end else begin
			bb_0_active_in_state_2_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_0.bb_0_predecessor_in_state_0_in_data
	always @(*) begin
		if (eq_3_out) begin 
			bb_0_predecessor_in_state_0_in_data = state_0_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_0_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_1.bb_0_predecessor_in_state_1_in_data
	always @(*) begin
		if (eq_4_out) begin 
			bb_0_predecessor_in_state_1_in_data = state_1_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_1_in_data = 0;
		end
	end
	// controller for bb_0_predecessor_in_state_2.bb_0_predecessor_in_state_2_in_data
	always @(*) begin
		if (eq_5_out) begin 
			bb_0_predecessor_in_state_2_in_data = state_2_last_BB_reg;
		end else begin
			bb_0_predecessor_in_state_2_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	assign eq_0_in0 = 32'd0;
	assign eq_0_in1 = state_0_entry_BB_reg;
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	assign eq_1_in0 = 32'd0;
	assign eq_1_in1 = state_1_entry_BB_reg;
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	assign eq_2_in0 = 32'd0;
	assign eq_2_in1 = state_2_entry_BB_reg;
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	assign eq_25_in0 = 32'd0;
	assign eq_25_in1 = state_0_last_state;
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	assign eq_26_in0 = 32'd0;
	assign eq_26_in1 = state_1_last_state;
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	assign eq_27_in0 = 32'd1;
	assign eq_27_in1 = state_1_last_state;
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	assign eq_28_in0 = 32'd1;
	assign eq_28_in1 = state_2_last_state;
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	assign eq_29_in0 = 32'd2;
	assign eq_29_in1 = state_2_last_state;
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	assign eq_3_in0 = 32'd0;
	assign eq_3_in1 = state_0_entry_BB_reg;
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	assign eq_4_in0 = 32'd0;
	assign eq_4_in1 = state_1_entry_BB_reg;
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	assign eq_5_in0 = 32'd0;
	assign eq_5_in1 = state_2_entry_BB_reg;
	// controller for notOp_19.notOp_19_in0
	// Insensitive connections
	assign notOp_19_in0 = andOp_16_out;
	// controller for notOp_21.notOp_21_in0
	// Insensitive connections
	assign notOp_21_in0 = andOp_17_out;
	// controller for notOp_23.notOp_23_in0
	// Insensitive connections
	assign notOp_23_in0 = andOp_18_out;
	// controller for ret9.valid_reg
	always @(*) begin
		if (andOp_15_out) begin 
			valid_reg = 1'd1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (andOp_16_out) begin
				global_state <= 32'd1;
			end
			if (andOp_17_out) begin
				global_state <= 32'd2;
			end
			if (andOp_18_out) begin
				global_state <= 32'd2;
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
			if (andOp_16_out) begin
				state_1_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_is_active <= 0;
		end else begin
			if (andOp_16_out) begin
				state_1_is_active <= 1'd1;
			end
			if (andOp_20_out) begin
				state_1_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_BB_reg <= 0;
		end else begin
			if (andOp_16_out) begin
				state_1_last_BB_reg <= bb_0_predecessor_in_state_0_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_1_last_state <= 0;
		end else begin
			if (andOp_16_out) begin
				state_1_last_state <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_entry_BB_reg <= 0;
		end else begin
			if (andOp_17_out) begin
				state_2_entry_BB_reg <= 32'd0;
			end
			if (andOp_18_out) begin
				state_2_entry_BB_reg <= 32'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_is_active <= 0;
		end else begin
			if (andOp_17_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_18_out) begin
				state_2_is_active <= 1'd1;
			end
			if (andOp_24_out) begin
				state_2_is_active <= 1'd0;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_BB_reg <= 0;
		end else begin
			if (andOp_17_out) begin
				state_2_last_BB_reg <= bb_0_predecessor_in_state_1_out_data;
			end
			if (andOp_18_out) begin
				state_2_last_BB_reg <= bb_0_predecessor_in_state_2_out_data;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			state_2_last_state <= 0;
		end else begin
			if (andOp_17_out) begin
				state_2_last_state <= 32'd1;
			end
			if (andOp_18_out) begin
				state_2_last_state <= 32'd2;
			end
		end
	end

endmodule

