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
	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add alloca_0();

	add bitcast_1();

	reg [31:0] add_in0_add_12;
	reg [31:0] add_in1_add_12;
	wire [31:0] add_out_add_12;
	add #(.WIDTH(32)) add_add_12(.in0(add_in0_add_12), .in1(add_in1_add_12), .out(add_out_add_12));

	reg [31:0] add_in0_add_6;
	reg [31:0] add_in1_add_6;
	wire [31:0] add_out_add_6;
	add #(.WIDTH(32)) add_add_6(.in0(add_in0_add_6), .in1(add_in1_add_6), .out(add_out_add_6));

	reg [31:0] cmp_in0_icmp_7;
	reg [31:0] cmp_in1_icmp_7;
	wire [0:0] cmp_out_icmp_7;
	eq #(.WIDTH(32)) icmp_7(.in0(cmp_in0_icmp_7), .in1(cmp_in1_icmp_7), .out(cmp_out_icmp_7));

	br_dummy br_unit();

	add call_2();

	add call_17();

	reg [63:0] phi_in_phi_8;
	reg [31:0] phi_last_block_phi_8;
	reg [63:0] phi_s_phi_8;
	wire [31:0] phi_out_phi_8;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_8(.in(phi_in_phi_8), .last_block(phi_last_block_phi_8), .out(phi_out_phi_8), .s(phi_s_phi_8));

	add call_10();

	add call_19();

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

	reg [31:0] eq_13_in0;
	reg [31:0] eq_13_in1;
	wire [0:0] eq_13_out;
	eq #(.WIDTH(32)) eq_13(.in0(eq_13_in0), .in1(eq_13_in1), .out(eq_13_out));

	reg [31:0] eq_14_in0;
	reg [31:0] eq_14_in1;
	wire [0:0] eq_14_out;
	eq #(.WIDTH(32)) eq_14(.in0(eq_14_in0), .in1(eq_14_in1), .out(eq_14_out));

	reg [31:0] eq_15_in0;
	reg [31:0] eq_15_in1;
	wire [0:0] eq_15_out;
	eq #(.WIDTH(32)) eq_15(.in0(eq_15_in0), .in1(eq_15_in1), .out(eq_15_out));

	reg [31:0] eq_16_in0;
	reg [31:0] eq_16_in1;
	wire [0:0] eq_16_out;
	eq #(.WIDTH(32)) eq_16(.in0(eq_16_in0), .in1(eq_16_in1), .out(eq_16_out));

	reg [31:0] eq_17_in0;
	reg [31:0] eq_17_in1;
	wire [0:0] eq_17_out;
	eq #(.WIDTH(32)) eq_17(.in0(eq_17_in0), .in1(eq_17_in1), .out(eq_17_out));

	reg [31:0] eq_18_in0;
	reg [31:0] eq_18_in1;
	wire [0:0] eq_18_out;
	eq #(.WIDTH(32)) eq_18(.in0(eq_18_in0), .in1(eq_18_in1), .out(eq_18_out));

	reg [31:0] eq_19_in0;
	reg [31:0] eq_19_in1;
	wire [0:0] eq_19_out;
	eq #(.WIDTH(32)) eq_19(.in0(eq_19_in0), .in1(eq_19_in1), .out(eq_19_out));

	reg [31:0] eq_20_in0;
	reg [31:0] eq_20_in1;
	wire [0:0] eq_20_out;
	eq #(.WIDTH(32)) eq_20(.in0(eq_20_in0), .in1(eq_20_in1), .out(eq_20_out));

	reg [31:0] eq_21_in0;
	reg [31:0] eq_21_in1;
	wire [0:0] eq_21_out;
	eq #(.WIDTH(32)) eq_21(.in0(eq_21_in0), .in1(eq_21_in1), .out(eq_21_out));

	reg [31:0] eq_22_in0;
	reg [31:0] eq_22_in1;
	wire [0:0] eq_22_out;
	eq #(.WIDTH(32)) eq_22(.in0(eq_22_in0), .in1(eq_22_in1), .out(eq_22_out));

	reg [31:0] eq_23_in0;
	reg [31:0] eq_23_in1;
	wire [0:0] eq_23_out;
	eq #(.WIDTH(32)) eq_23(.in0(eq_23_in0), .in1(eq_23_in1), .out(eq_23_out));

	reg [31:0] eq_24_in0;
	reg [31:0] eq_24_in1;
	wire [0:0] eq_24_out;
	eq #(.WIDTH(32)) eq_24(.in0(eq_24_in0), .in1(eq_24_in1), .out(eq_24_out));

	reg [31:0] eq_25_in0;
	reg [31:0] eq_25_in1;
	wire [0:0] eq_25_out;
	eq #(.WIDTH(32)) eq_25(.in0(eq_25_in0), .in1(eq_25_in1), .out(eq_25_out));

	reg [31:0] eq_26_in0;
	reg [31:0] eq_26_in1;
	wire [0:0] eq_26_out;
	eq #(.WIDTH(32)) eq_26(.in0(eq_26_in0), .in1(eq_26_in1), .out(eq_26_out));

	reg [31:0] eq_27_in0;
	reg [31:0] eq_27_in1;
	wire [0:0] eq_27_out;
	eq #(.WIDTH(32)) eq_27(.in0(eq_27_in0), .in1(eq_27_in1), .out(eq_27_out));

	reg [31:0] eq_28_in0;
	reg [31:0] eq_28_in1;
	wire [0:0] eq_28_out;
	eq #(.WIDTH(32)) eq_28(.in0(eq_28_in0), .in1(eq_28_in1), .out(eq_28_out));

	reg [31:0] eq_29_in0;
	reg [31:0] eq_29_in1;
	wire [0:0] eq_29_out;
	eq #(.WIDTH(32)) eq_29(.in0(eq_29_in0), .in1(eq_29_in1), .out(eq_29_out));

	reg [31:0] eq_30_in0;
	reg [31:0] eq_30_in1;
	wire [0:0] eq_30_out;
	eq #(.WIDTH(32)) eq_30(.in0(eq_30_in0), .in1(eq_30_in1), .out(eq_30_out));

	reg [31:0] eq_31_in0;
	reg [31:0] eq_31_in1;
	wire [0:0] eq_31_out;
	eq #(.WIDTH(32)) eq_31(.in0(eq_31_in0), .in1(eq_31_in1), .out(eq_31_out));

	reg [31:0] eq_32_in0;
	reg [31:0] eq_32_in1;
	wire [0:0] eq_32_out;
	eq #(.WIDTH(32)) eq_32(.in0(eq_32_in0), .in1(eq_32_in1), .out(eq_32_out));

	reg [31:0] eq_33_in0;
	reg [31:0] eq_33_in1;
	wire [0:0] eq_33_out;
	eq #(.WIDTH(32)) eq_33(.in0(eq_33_in0), .in1(eq_33_in1), .out(eq_33_out));

	reg [31:0] eq_34_in0;
	reg [31:0] eq_34_in1;
	wire [0:0] eq_34_out;
	eq #(.WIDTH(32)) eq_34(.in0(eq_34_in0), .in1(eq_34_in1), .out(eq_34_out));

	reg [31:0] eq_35_in0;
	reg [31:0] eq_35_in1;
	wire [0:0] eq_35_out;
	eq #(.WIDTH(32)) eq_35(.in0(eq_35_in0), .in1(eq_35_in1), .out(eq_35_out));

	reg [31:0] eq_36_in0;
	reg [31:0] eq_36_in1;
	wire [0:0] eq_36_out;
	eq #(.WIDTH(32)) eq_36(.in0(eq_36_in0), .in1(eq_36_in1), .out(eq_36_out));

	reg [31:0] eq_37_in0;
	reg [31:0] eq_37_in1;
	wire [0:0] eq_37_out;
	eq #(.WIDTH(32)) eq_37(.in0(eq_37_in0), .in1(eq_37_in1), .out(eq_37_out));

	reg [31:0] eq_38_in0;
	reg [31:0] eq_38_in1;
	wire [0:0] eq_38_out;
	eq #(.WIDTH(32)) eq_38(.in0(eq_38_in0), .in1(eq_38_in1), .out(eq_38_out));

	reg [31:0] eq_39_in0;
	reg [31:0] eq_39_in1;
	wire [0:0] eq_39_out;
	eq #(.WIDTH(32)) eq_39(.in0(eq_39_in0), .in1(eq_39_in1), .out(eq_39_out));

	reg [31:0] eq_40_in0;
	reg [31:0] eq_40_in1;
	wire [0:0] eq_40_out;
	eq #(.WIDTH(32)) eq_40(.in0(eq_40_in0), .in1(eq_40_in1), .out(eq_40_out));

	reg [31:0] eq_41_in0;
	reg [31:0] eq_41_in1;
	wire [0:0] eq_41_out;
	eq #(.WIDTH(32)) eq_41(.in0(eq_41_in0), .in1(eq_41_in1), .out(eq_41_out));

	reg [31:0] eq_42_in0;
	reg [31:0] eq_42_in1;
	wire [0:0] eq_42_out;
	eq #(.WIDTH(32)) eq_42(.in0(eq_42_in0), .in1(eq_42_in1), .out(eq_42_out));

	reg [31:0] eq_43_in0;
	reg [31:0] eq_43_in1;
	wire [0:0] eq_43_out;
	eq #(.WIDTH(32)) eq_43(.in0(eq_43_in0), .in1(eq_43_in1), .out(eq_43_out));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_44_in0;
	reg [31:0] eq_44_in1;
	wire [0:0] eq_44_out;
	eq #(.WIDTH(32)) eq_44(.in0(eq_44_in0), .in1(eq_44_in1), .out(eq_44_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_45_in0;
	reg [31:0] eq_45_in1;
	wire [0:0] eq_45_out;
	eq #(.WIDTH(32)) eq_45(.in0(eq_45_in0), .in1(eq_45_in1), .out(eq_45_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_46_in0;
	reg [31:0] eq_46_in1;
	wire [0:0] eq_46_out;
	eq #(.WIDTH(32)) eq_46(.in0(eq_46_in0), .in1(eq_46_in1), .out(eq_46_out));

	// End Functional Units

	reg [31:0] add_tmp_1;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_2;
	reg [31:0] last_BB_reg;
	reg [31:0] load_tmp_0;

	// controller for add_add_12.add_in0_add_12
	// controller for add_add_12.add_in1_add_12
	// Insensitive connections
	always @(*) begin
		add_in0_add_12 = valid ? load_tmp_0 : load_tmp_0;
		add_in1_add_12 = valid ? in_out_data : in_out_data;
	end
	// controller for add_add_6.add_in0_add_6
	// controller for add_add_6.add_in1_add_6
	// Insensitive connections
	always @(*) begin
		add_in0_add_6 = valid ? phi_out_phi_8 : phi_out_phi_8;
		add_in1_add_6 = valid ? (32'd1) : (32'd1);
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_44_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_45_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_46_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd2 : 32'd2;
		eq_0_in1 = valid ? global_state : global_state;
	end
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	always @(*) begin
		eq_1_in0 = valid ? 32'd7 : 32'd7;
		eq_1_in1 = valid ? global_state : global_state;
	end
	// controller for eq_10.eq_10_in0
	// controller for eq_10.eq_10_in1
	// Insensitive connections
	always @(*) begin
		eq_10_in0 = valid ? 32'd2 : 32'd2;
		eq_10_in1 = valid ? global_state : global_state;
	end
	// controller for eq_11.eq_11_in0
	// controller for eq_11.eq_11_in1
	// Insensitive connections
	always @(*) begin
		eq_11_in0 = valid ? 32'd2 : 32'd2;
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
		eq_13_in0 = valid ? 32'd2 : 32'd2;
		eq_13_in1 = valid ? global_state : global_state;
	end
	// controller for eq_14.eq_14_in0
	// controller for eq_14.eq_14_in1
	// Insensitive connections
	always @(*) begin
		eq_14_in0 = valid ? 32'd2 : 32'd2;
		eq_14_in1 = valid ? global_state : global_state;
	end
	// controller for eq_15.eq_15_in0
	// controller for eq_15.eq_15_in1
	// Insensitive connections
	always @(*) begin
		eq_15_in0 = valid ? 32'd3 : 32'd3;
		eq_15_in1 = valid ? global_state : global_state;
	end
	// controller for eq_16.eq_16_in0
	// controller for eq_16.eq_16_in1
	// Insensitive connections
	always @(*) begin
		eq_16_in0 = valid ? 32'd4 : 32'd4;
		eq_16_in1 = valid ? global_state : global_state;
	end
	// controller for eq_17.eq_17_in0
	// controller for eq_17.eq_17_in1
	// Insensitive connections
	always @(*) begin
		eq_17_in0 = valid ? 32'd4 : 32'd4;
		eq_17_in1 = valid ? global_state : global_state;
	end
	// controller for eq_18.eq_18_in0
	// controller for eq_18.eq_18_in1
	// Insensitive connections
	always @(*) begin
		eq_18_in0 = valid ? 32'd4 : 32'd4;
		eq_18_in1 = valid ? global_state : global_state;
	end
	// controller for eq_19.eq_19_in0
	// controller for eq_19.eq_19_in1
	// Insensitive connections
	always @(*) begin
		eq_19_in0 = valid ? 32'd7 : 32'd7;
		eq_19_in1 = valid ? global_state : global_state;
	end
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	always @(*) begin
		eq_2_in0 = valid ? 32'd0 : 32'd0;
		eq_2_in1 = valid ? global_state : global_state;
	end
	// controller for eq_20.eq_20_in0
	// controller for eq_20.eq_20_in1
	// Insensitive connections
	always @(*) begin
		eq_20_in0 = valid ? 32'd7 : 32'd7;
		eq_20_in1 = valid ? global_state : global_state;
	end
	// controller for eq_21.eq_21_in0
	// controller for eq_21.eq_21_in1
	// Insensitive connections
	always @(*) begin
		eq_21_in0 = valid ? 32'd8 : 32'd8;
		eq_21_in1 = valid ? global_state : global_state;
	end
	// controller for eq_22.eq_22_in0
	// controller for eq_22.eq_22_in1
	// Insensitive connections
	always @(*) begin
		eq_22_in0 = valid ? 32'd8 : 32'd8;
		eq_22_in1 = valid ? global_state : global_state;
	end
	// controller for eq_23.eq_23_in0
	// controller for eq_23.eq_23_in1
	// Insensitive connections
	always @(*) begin
		eq_23_in0 = valid ? 32'd1 : 32'd1;
		eq_23_in1 = valid ? global_state : global_state;
	end
	// controller for eq_24.eq_24_in0
	// controller for eq_24.eq_24_in1
	// Insensitive connections
	always @(*) begin
		eq_24_in0 = valid ? 32'd5 : 32'd5;
		eq_24_in1 = valid ? global_state : global_state;
	end
	// controller for eq_25.eq_25_in0
	// controller for eq_25.eq_25_in1
	// Insensitive connections
	always @(*) begin
		eq_25_in0 = valid ? 32'd8 : 32'd8;
		eq_25_in1 = valid ? global_state : global_state;
	end
	// controller for eq_26.eq_26_in0
	// controller for eq_26.eq_26_in1
	// Insensitive connections
	always @(*) begin
		eq_26_in0 = valid ? 32'd0 : 32'd0;
		eq_26_in1 = valid ? global_state : global_state;
	end
	// controller for eq_27.eq_27_in0
	// controller for eq_27.eq_27_in1
	// Insensitive connections
	always @(*) begin
		eq_27_in0 = valid ? 32'd1 : 32'd1;
		eq_27_in1 = valid ? global_state : global_state;
	end
	// controller for eq_28.eq_28_in0
	// controller for eq_28.eq_28_in1
	// Insensitive connections
	always @(*) begin
		eq_28_in0 = valid ? 32'd2 : 32'd2;
		eq_28_in1 = valid ? global_state : global_state;
	end
	// controller for eq_29.eq_29_in0
	// controller for eq_29.eq_29_in1
	// Insensitive connections
	always @(*) begin
		eq_29_in0 = valid ? 32'd3 : 32'd3;
		eq_29_in1 = valid ? global_state : global_state;
	end
	// controller for eq_3.eq_3_in0
	// controller for eq_3.eq_3_in1
	// Insensitive connections
	always @(*) begin
		eq_3_in0 = valid ? 32'd4 : 32'd4;
		eq_3_in1 = valid ? global_state : global_state;
	end
	// controller for eq_30.eq_30_in0
	// controller for eq_30.eq_30_in1
	// Insensitive connections
	always @(*) begin
		eq_30_in0 = valid ? 32'd4 : 32'd4;
		eq_30_in1 = valid ? global_state : global_state;
	end
	// controller for eq_31.eq_31_in0
	// controller for eq_31.eq_31_in1
	// Insensitive connections
	always @(*) begin
		eq_31_in0 = valid ? 32'd5 : 32'd5;
		eq_31_in1 = valid ? global_state : global_state;
	end
	// controller for eq_32.eq_32_in0
	// controller for eq_32.eq_32_in1
	// Insensitive connections
	always @(*) begin
		eq_32_in0 = valid ? 32'd6 : 32'd6;
		eq_32_in1 = valid ? global_state : global_state;
	end
	// controller for eq_33.eq_33_in0
	// controller for eq_33.eq_33_in1
	// Insensitive connections
	always @(*) begin
		eq_33_in0 = valid ? 32'd7 : 32'd7;
		eq_33_in1 = valid ? global_state : global_state;
	end
	// controller for eq_34.eq_34_in0
	// controller for eq_34.eq_34_in1
	// Insensitive connections
	always @(*) begin
		eq_34_in0 = valid ? 32'd8 : 32'd8;
		eq_34_in1 = valid ? global_state : global_state;
	end
	// controller for eq_35.eq_35_in0
	// controller for eq_35.eq_35_in1
	// Insensitive connections
	always @(*) begin
		eq_35_in0 = valid ? 32'd0 : 32'd0;
		eq_35_in1 = valid ? global_state : global_state;
	end
	// controller for eq_36.eq_36_in0
	// controller for eq_36.eq_36_in1
	// Insensitive connections
	always @(*) begin
		eq_36_in0 = valid ? 32'd1 : 32'd1;
		eq_36_in1 = valid ? global_state : global_state;
	end
	// controller for eq_37.eq_37_in0
	// controller for eq_37.eq_37_in1
	// Insensitive connections
	always @(*) begin
		eq_37_in0 = valid ? 32'd2 : 32'd2;
		eq_37_in1 = valid ? global_state : global_state;
	end
	// controller for eq_38.eq_38_in0
	// controller for eq_38.eq_38_in1
	// Insensitive connections
	always @(*) begin
		eq_38_in0 = valid ? 32'd3 : 32'd3;
		eq_38_in1 = valid ? global_state : global_state;
	end
	// controller for eq_39.eq_39_in0
	// controller for eq_39.eq_39_in1
	// Insensitive connections
	always @(*) begin
		eq_39_in0 = valid ? 32'd4 : 32'd4;
		eq_39_in1 = valid ? global_state : global_state;
	end
	// controller for eq_4.eq_4_in0
	// controller for eq_4.eq_4_in1
	// Insensitive connections
	always @(*) begin
		eq_4_in0 = valid ? 32'd0 : 32'd0;
		eq_4_in1 = valid ? global_state : global_state;
	end
	// controller for eq_40.eq_40_in0
	// controller for eq_40.eq_40_in1
	// Insensitive connections
	always @(*) begin
		eq_40_in0 = valid ? 32'd5 : 32'd5;
		eq_40_in1 = valid ? global_state : global_state;
	end
	// controller for eq_41.eq_41_in0
	// controller for eq_41.eq_41_in1
	// Insensitive connections
	always @(*) begin
		eq_41_in0 = valid ? 32'd6 : 32'd6;
		eq_41_in1 = valid ? global_state : global_state;
	end
	// controller for eq_42.eq_42_in0
	// controller for eq_42.eq_42_in1
	// Insensitive connections
	always @(*) begin
		eq_42_in0 = valid ? 32'd7 : 32'd7;
		eq_42_in1 = valid ? global_state : global_state;
	end
	// controller for eq_43.eq_43_in0
	// controller for eq_43.eq_43_in1
	// Insensitive connections
	always @(*) begin
		eq_43_in0 = valid ? 32'd8 : 32'd8;
		eq_43_in1 = valid ? global_state : global_state;
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
	// controller for eq_46.eq_46_in0
	// controller for eq_46.eq_46_in1
	// Insensitive connections
	always @(*) begin
		eq_46_in0 = valid ? 32'd2 : 32'd2;
		eq_46_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_5.eq_5_in0
	// controller for eq_5.eq_5_in1
	// Insensitive connections
	always @(*) begin
		eq_5_in0 = valid ? 32'd4 : 32'd4;
		eq_5_in1 = valid ? global_state : global_state;
	end
	// controller for eq_6.eq_6_in0
	// controller for eq_6.eq_6_in1
	// Insensitive connections
	always @(*) begin
		eq_6_in0 = valid ? 32'd0 : 32'd0;
		eq_6_in1 = valid ? global_state : global_state;
	end
	// controller for eq_7.eq_7_in0
	// controller for eq_7.eq_7_in1
	// Insensitive connections
	always @(*) begin
		eq_7_in0 = valid ? 32'd4 : 32'd4;
		eq_7_in1 = valid ? global_state : global_state;
	end
	// controller for eq_8.eq_8_in0
	// controller for eq_8.eq_8_in1
	// Insensitive connections
	always @(*) begin
		eq_8_in0 = valid ? 32'd2 : 32'd2;
		eq_8_in1 = valid ? global_state : global_state;
	end
	// controller for eq_9.eq_9_in0
	// controller for eq_9.eq_9_in1
	// Insensitive connections
	always @(*) begin
		eq_9_in0 = valid ? 32'd2 : 32'd2;
		eq_9_in1 = valid ? global_state : global_state;
	end
	// controller for icmp_7.cmp_in0_icmp_7
	// controller for icmp_7.cmp_in1_icmp_7
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_7 = valid ? add_out_add_6 : add_out_add_6;
		cmp_in1_icmp_7 = valid ? (32'd4) : (32'd4);
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if (eq_15_out) begin 
			in_read_valid_reg = -(1'd1);
		end else if (eq_16_out) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for out.out_in_data_reg
	// controller for out.out_write_valid_reg
	always @(*) begin
		if (eq_20_out) begin 
			out_write_valid_reg = -(1'd1);
		end else if (eq_21_out) begin 
			out_write_valid_reg = (1'd0);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? rdata_ram_0 : rdata_ram_0;
	end
	// controller for phi_8.phi_in_phi_8
	// controller for phi_8.phi_last_block_phi_8
	// controller for phi_8.phi_s_phi_8
	// Insensitive connections
	always @(*) begin
		phi_in_phi_8 = valid ? {(32'd0), add_tmp_1} : {(32'd0), add_tmp_1};
		phi_last_block_phi_8 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_8 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if (eq_0_out && in_read_ready) begin 
			raddr_ram_0_reg = 0;
		end else if (eq_1_out) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if (eq_2_out) begin 
			waddr_ram_0_reg = 0;
		end else if (eq_3_out) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if (eq_4_out) begin 
			wdata_ram_0_reg = (32'd0);
		end else if (eq_5_out) begin 
			wdata_ram_0_reg = add_out_add_12;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if (eq_6_out) begin 
			wen_ram_0_reg = 1;
		end else if (eq_7_out) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_23.valid_reg
	always @(*) begin
		if (eq_22_out) begin 
			valid_reg = 1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_1 <= 0;
		end else begin
			if (eq_37_out && in_read_ready) begin
				add_tmp_1 <= add_out_add_6;
			end
		end
	end

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
			if (eq_26_out && 1) begin
				global_state <= 1;
			end
			if (eq_27_out && 1) begin
				global_state <= 2;
			end
			if (eq_28_out && 1 && in_read_ready) begin
				global_state <= 3;
			end
			if (eq_29_out && 1) begin
				global_state <= 4;
			end
			if (eq_30_out && 1) begin
				global_state <= 5;
			end
			if (eq_31_out && !(icmp_tmp_2)) begin
				global_state <= 2;
			end
			if (eq_31_out && (icmp_tmp_2)) begin
				global_state <= 6;
			end
			if (eq_32_out && 1 && out_write_ready) begin
				global_state <= 7;
			end
			if (eq_33_out && 1) begin
				global_state <= 8;
			end
			if (eq_34_out && 1) begin
				global_state <= 8;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_2 <= 0;
		end else begin
			if (eq_37_out && in_read_ready) begin
				icmp_tmp_2 <= cmp_out_icmp_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if (eq_23_out) begin
				last_BB_reg <= 0;
			end
			if (eq_24_out) begin
				last_BB_reg <= 2;
			end
			if (eq_25_out) begin
				last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			load_tmp_0 <= 0;
		end else begin
			if (eq_37_out && in_read_ready) begin
				load_tmp_0 <= rdata_ram_0;
			end
		end
	end

endmodule

