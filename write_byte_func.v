module write_byte_func(input [0:0] clk, input [0:0] rst, output [7:0] arg_0_raddr, output [7:0] arg_0_waddr, output [7:0] arg_0_wdata, output [0:0] arg_0_wen, input [7:0] arg_0_rdata, output [0:0] arg_1_raddr, output [0:0] arg_1_waddr, output [0:0] arg_1_wdata, output [0:0] arg_1_wen, input [0:0] arg_1_rdata, output [0:0] valid, output [0:0] arg_2_m_axis_tready, output [47:0] arg_2_s_eth_dest_mac, output [0:0] arg_2_s_eth_hdr_valid, output [7:0] arg_2_s_eth_payload_axis_tdata, output [0:0] arg_2_s_eth_payload_axis_tlast, output [0:0] arg_2_s_eth_payload_axis_tuser, output [0:0] arg_2_s_eth_payload_axis_tvalid, output [47:0] arg_2_s_eth_src_mac, output [15:0] arg_2_s_eth_type, input [0:0] arg_2_busy, input [0:0] arg_2_s_eth_hdr_ready, input [0:0] arg_2_s_eth_payload_axis_tready);

	reg [7:0] arg_0_raddr_reg;
	reg [7:0] arg_0_waddr_reg;
	reg [7:0] arg_0_wdata_reg;
	reg [0:0] arg_0_wen_reg;
	reg [0:0] arg_1_raddr_reg;
	reg [0:0] arg_1_waddr_reg;
	reg [0:0] arg_1_wdata_reg;
	reg [0:0] arg_1_wen_reg;
	reg [0:0] valid_reg;
	reg [0:0] arg_2_m_axis_tready_reg;
	reg [47:0] arg_2_s_eth_dest_mac_reg;
	reg [0:0] arg_2_s_eth_hdr_valid_reg;
	reg [7:0] arg_2_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_2_s_eth_src_mac_reg;
	reg [15:0] arg_2_s_eth_type_reg;

	assign arg_0_raddr = arg_0_raddr_reg;
	assign arg_0_waddr = arg_0_waddr_reg;
	assign arg_0_wdata = arg_0_wdata_reg;
	assign arg_0_wen = arg_0_wen_reg;
	assign arg_1_raddr = arg_1_raddr_reg;
	assign arg_1_waddr = arg_1_waddr_reg;
	assign arg_1_wdata = arg_1_wdata_reg;
	assign arg_1_wen = arg_1_wen_reg;
	assign valid = valid_reg;
	assign arg_2_m_axis_tready = arg_2_m_axis_tready_reg;
	assign arg_2_s_eth_dest_mac = arg_2_s_eth_dest_mac_reg;
	assign arg_2_s_eth_hdr_valid = arg_2_s_eth_hdr_valid_reg;
	assign arg_2_s_eth_payload_axis_tdata = arg_2_s_eth_payload_axis_tdata_reg;
	assign arg_2_s_eth_payload_axis_tlast = arg_2_s_eth_payload_axis_tlast_reg;
	assign arg_2_s_eth_payload_axis_tuser = arg_2_s_eth_payload_axis_tuser_reg;
	assign arg_2_s_eth_payload_axis_tvalid = arg_2_s_eth_payload_axis_tvalid_reg;
	assign arg_2_s_eth_src_mac = arg_2_s_eth_src_mac_reg;
	assign arg_2_s_eth_type = arg_2_s_eth_type_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_1();

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

	reg [31:0] eq_5_in0;
	reg [31:0] eq_5_in1;
	wire [0:0] eq_5_out;
	eq #(.WIDTH(32)) eq_5(.in0(eq_5_in0), .in1(eq_5_in1), .out(eq_5_out));

	reg [31:0] eq_6_in0;
	reg [31:0] eq_6_in1;
	wire [0:0] eq_6_out;
	eq #(.WIDTH(32)) eq_6(.in0(eq_6_in0), .in1(eq_6_in1), .out(eq_6_out));

	reg [31:0] eq_7_in0;
	reg [31:0] eq_7_in1;
	wire [0:0] eq_7_out;
	eq #(.WIDTH(32)) eq_7(.in0(eq_7_in0), .in1(eq_7_in1), .out(eq_7_out));

	reg [31:0] eq_8_in0;
	reg [31:0] eq_8_in1;
	wire [0:0] eq_8_out;
	eq #(.WIDTH(32)) eq_8(.in0(eq_8_in0), .in1(eq_8_in1), .out(eq_8_out));

	reg [31:0] eq_9_in0;
	reg [31:0] eq_9_in1;
	wire [0:0] eq_9_out;
	eq #(.WIDTH(32)) eq_9(.in0(eq_9_in0), .in1(eq_9_in1), .out(eq_9_out));

	reg [31:0] eq_10_in0;
	reg [31:0] eq_10_in1;
	wire [0:0] eq_10_out;
	eq #(.WIDTH(32)) eq_10(.in0(eq_10_in0), .in1(eq_10_in1), .out(eq_10_out));

	reg [31:0] eq_11_in0;
	reg [31:0] eq_11_in1;
	wire [0:0] eq_11_out;
	eq #(.WIDTH(32)) eq_11(.in0(eq_11_in0), .in1(eq_11_in1), .out(eq_11_out));

	reg [31:0] eq_12_in0;
	reg [31:0] eq_12_in1;
	wire [0:0] eq_12_out;
	eq #(.WIDTH(32)) eq_12(.in0(eq_12_in0), .in1(eq_12_in1), .out(eq_12_out));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_13_in0;
	reg [31:0] eq_13_in1;
	wire [0:0] eq_13_out;
	eq #(.WIDTH(32)) eq_13(.in0(eq_13_in0), .in1(eq_13_in1), .out(eq_13_out));

	// End Functional Units

	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [31:0] last_BB_reg;

	// controller for arg_0.arg_0_raddr_reg
	// Insensitive connections
	always @(*) begin
		arg_0_raddr_reg = valid ? arg_0_rdata : arg_0_rdata;
	end
	// controller for arg_1.arg_1_raddr_reg
	// Insensitive connections
	always @(*) begin
		arg_1_raddr_reg = valid ? arg_1_rdata : arg_1_rdata;
	end
	// controller for arg_2.arg_2_s_eth_payload_axis_tdata_reg
	// controller for arg_2.arg_2_s_eth_payload_axis_tlast_reg
	// controller for arg_2.arg_2_s_eth_payload_axis_tvalid_reg
	always @(*) begin
		if (eq_2_out) begin 
			arg_2_s_eth_payload_axis_tvalid_reg = (32'd1);
		end else begin
			arg_2_s_eth_payload_axis_tvalid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		arg_2_s_eth_payload_axis_tdata_reg = valid ? arg_0_rdata : arg_0_rdata;
		arg_2_s_eth_payload_axis_tlast_reg = valid ? arg_1_rdata : arg_1_rdata;
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_13_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd1 : 32'd1;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	always @(*) begin
		eq_1_in0 = valid ? 32'd1 : 32'd1;
		eq_1_in1 = valid ? global_state : global_state;
	end
	// controller for eq_10.eq_10_in0
	// controller for eq_10.eq_10_in1
	// Insensitive connections
	always @(*) begin
		eq_10_in0 = valid ? 32'd0 : 32'd0;
		eq_10_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd1 : 32'd1;
		eq_11_in1 = valid ? global_state : global_state;
	end
	// controller for eq_12.eq_12_in0
	// controller for eq_12.eq_12_in1
	// Insensitive connections
	always @(*) begin
		eq_12_in0 = valid ? 32'd2 : 32'd2;
		eq_12_in1 = valid ? global_state : global_state;
	end
	// controller for eq_13.eq_13_in0
	// controller for eq_13.eq_13_in1
	// Insensitive connections
	always @(*) begin
		eq_13_in0 = valid ? 32'd0 : 32'd0;
		eq_13_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	always @(*) begin
		eq_2_in0 = valid ? 32'd1 : 32'd1;
		eq_2_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd1 : 32'd1;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd1 : 32'd1;
		eq_4_in1 = valid ? global_state : global_state;
	end
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	always @(*) begin
		eq_5_in0 = valid ? 32'd2 : 32'd2;
		eq_5_in1 = valid ? global_state : global_state;
	end
	// controller for eq_6.eq_6_in0
	// controller for eq_6.eq_6_in1
	// Insensitive connections
	always @(*) begin
		eq_6_in0 = valid ? 32'd2 : 32'd2;
		eq_6_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd0 : 32'd0;
		eq_7_in1 = valid ? global_state : global_state;
	end
	// controller for eq_8.eq_8_in0
	// controller for eq_8.eq_8_in1
	// Insensitive connections
	always @(*) begin
		eq_8_in0 = valid ? 32'd1 : 32'd1;
		eq_8_in1 = valid ? global_state : global_state;
	end
	// controller for eq_9.eq_9_in0
	// controller for eq_9.eq_9_in1
	// Insensitive connections
	always @(*) begin
		eq_9_in0 = valid ? 32'd2 : 32'd2;
		eq_9_in1 = valid ? global_state : global_state;
	end
	// controller for ret_7.valid_reg
	always @(*) begin
		if (eq_5_out) begin 
			valid_reg = 1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if (eq_7_out && 1 && arg_2_s_eth_payload_axis_tready) begin
				global_state <= 1;
			end
			if (eq_8_out && 1) begin
				global_state <= 2;
			end
			if (eq_9_out && 1) begin
				global_state <= 2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_6_out) begin
				last_BB_reg <= 0;
			end
		end
	end

endmodule

