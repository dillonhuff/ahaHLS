module run_median_func(input [0:0] clk, input [0:0] rst, output [7:0] arg_4_in_wire, input [7:0] arg_4_out_wire, output [7:0] arg_6_in_wire, input [7:0] arg_6_out_wire, output [7:0] arg_5_in_wire, input [7:0] arg_5_out_wire, output [7:0] arg_7_in_wire, input [7:0] arg_7_out_wire, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [7:0] arg_0_pixel1, input [7:0] arg_0_pixel2, input [7:0] arg_0_pixel3, input [7:0] arg_0_pixel4, output [0:0] valid, output [31:0] arg_1_in_wire, input [31:0] arg_1_out_wire, output [31:0] arg_2_in_wire, input [31:0] arg_2_out_wire, output [31:0] arg_3_in_wire, input [31:0] arg_3_out_wire);

	reg [7:0] arg_4_in_wire_reg;
	reg [7:0] arg_6_in_wire_reg;
	reg [7:0] arg_5_in_wire_reg;
	reg [7:0] arg_7_in_wire_reg;
	reg [0:0] arg_0_rst_n_reg;
	reg [31:0] arg_0_word0_reg;
	reg [31:0] arg_0_word1_reg;
	reg [31:0] arg_0_word2_reg;
	reg [0:0] valid_reg;
	reg [31:0] arg_1_in_wire_reg;
	reg [31:0] arg_2_in_wire_reg;
	reg [31:0] arg_3_in_wire_reg;

	assign arg_4_in_wire = arg_4_in_wire_reg;
	assign arg_6_in_wire = arg_6_in_wire_reg;
	assign arg_5_in_wire = arg_5_in_wire_reg;
	assign arg_7_in_wire = arg_7_in_wire_reg;
	assign arg_0_rst_n = arg_0_rst_n_reg;
	assign arg_0_word0 = arg_0_word0_reg;
	assign arg_0_word1 = arg_0_word1_reg;
	assign arg_0_word2 = arg_0_word2_reg;
	assign valid = valid_reg;
	assign arg_1_in_wire = arg_1_in_wire_reg;
	assign arg_2_in_wire = arg_2_in_wire_reg;
	assign arg_3_in_wire = arg_3_in_wire_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [39:0] phi_in_phi_7;
	reg [31:0] phi_last_block_phi_7;
	reg [63:0] phi_s_phi_7;
	wire [31:0] phi_out_phi_7;
	phi #(.NB_PAIR(2), .WIDTH(20)) phi_7(.in(phi_in_phi_7), .last_block(phi_last_block_phi_7), .out(phi_out_phi_7), .s(phi_s_phi_7));

	reg [31:0] add_in0_add_9;
	reg [31:0] add_in1_add_9;
	wire [31:0] add_out_add_9;
	add #(.WIDTH(32)) add_add_9(.in0(add_in0_add_9), .in1(add_in1_add_9), .out(add_out_add_9));

	reg [31:0] trunc_in_trunc_10;
	wire [19:0] trunc_out_trunc_10;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(20)) trunc_10(.in(trunc_in_trunc_10), .out(trunc_out_trunc_10));

	reg [31:0] cmp_in0_icmp_11;
	reg [31:0] cmp_in1_icmp_11;
	wire [0:0] cmp_out_icmp_11;
	slt #(.WIDTH(32)) icmp_11(.in0(cmp_in0_icmp_11), .in1(cmp_in1_icmp_11), .out(cmp_out_icmp_11));

	br_dummy br_unit();

	reg [31:0] sgt_in0_sext_14;
	wire [63:0] sgt_out_sext_14;
	sext sext_14(.in(sgt_in0_sext_14), .out(sgt_out_sext_14));

	reg [31:0] sgt_in0_sext_17;
	wire [63:0] sgt_out_sext_17;
	sext sext_17(.in(sgt_in0_sext_17), .out(sgt_out_sext_17));

	// End Functional Units

	// Start instruction result storage
	reg [19:0] trunc_tmp_2;
	// End instruction result storage

	// Start pipeline variables
	// End pipeline variables

	reg [31:0] global_state;
	reg [31:0] last_BB_reg;
	// Start pipeline valid chain block
	always @(posedge clk) begin
	end
	// End pipeline valid chain block


	// controller for arg_0.arg_0_rst_n_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				arg_0_rst_n_reg = (32'd1);
			end else begin
				arg_0_rst_n_reg = 1;
			end
		end else if ((global_state == 1)) begin 
			if (1) begin
				arg_0_rst_n_reg = (32'd0);
			end else begin
				arg_0_rst_n_reg = 1;
			end
		end else if ((global_state == 2)) begin 
			if (1) begin
				arg_0_rst_n_reg = (32'd1);
			end else begin
				arg_0_rst_n_reg = 1;
			end
		end else begin
			arg_0_rst_n_reg = 1;
		end
	end
	// controller for arg_0.arg_0_word0_reg
	// controller for arg_0.arg_0_word1_reg
	// controller for arg_0.arg_0_word2_reg
	// Insensitive connections
	always @(*) begin
		arg_0_word0_reg = valid ? arg_1_out_wire : arg_1_out_wire;
		arg_0_word1_reg = valid ? arg_2_out_wire : arg_2_out_wire;
		arg_0_word2_reg = valid ? arg_3_out_wire : arg_3_out_wire;
	end
	// controller for arg_4.arg_4_in_wire_reg
	// Insensitive connections
	always @(*) begin
		arg_4_in_wire_reg = valid ? arg_0_pixel1 : arg_0_pixel1;
	end
	// controller for arg_6.arg_6_in_wire_reg
	// Insensitive connections
	always @(*) begin
		arg_6_in_wire_reg = valid ? arg_0_pixel3 : arg_0_pixel3;
	end
	// controller for arg_5.arg_5_in_wire_reg
	// Insensitive connections
	always @(*) begin
		arg_5_in_wire_reg = valid ? arg_0_pixel2 : arg_0_pixel2;
	end
	// controller for phi_7.phi_in_phi_7
	// controller for phi_7.phi_last_block_phi_7
	// controller for phi_7.phi_s_phi_7
	// Insensitive connections
	always @(*) begin
		phi_in_phi_7 = valid ? {trunc_tmp_2, (20'd0)} : {trunc_tmp_2, (20'd0)};
		phi_last_block_phi_7 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_7 = valid ? {32'd1, 32'd0} : {32'd1, 32'd0};
	end
	// controller for arg_7.arg_7_in_wire_reg
	// Insensitive connections
	always @(*) begin
		arg_7_in_wire_reg = valid ? arg_0_pixel4 : arg_0_pixel4;
	end
	// controller for add_add_9.add_in0_add_9
	// controller for add_add_9.add_in1_add_9
	// Insensitive connections
	always @(*) begin
		add_in0_add_9 = valid ? sgt_out_sext_17 : sgt_out_sext_17;
		add_in1_add_9 = valid ? (32'd1) : (32'd1);
	end
	// controller for trunc_10.trunc_in_trunc_10
	// Insensitive connections
	always @(*) begin
		trunc_in_trunc_10 = valid ? add_out_add_9 : add_out_add_9;
	end
	// controller for icmp_11.cmp_in0_icmp_11
	// controller for icmp_11.cmp_in1_icmp_11
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_11 = valid ? sgt_out_sext_14 : sgt_out_sext_14;
		cmp_in1_icmp_11 = valid ? (32'd101125) : (32'd101125);
	end
	// controller for sext_14.sgt_in0_sext_14
	// Insensitive connections
	always @(*) begin
		sgt_in0_sext_14 = valid ? trunc_out_trunc_10 : trunc_out_trunc_10;
	end
	// controller for sext_17.sgt_in0_sext_17
	// Insensitive connections
	always @(*) begin
		sgt_in0_sext_17 = valid ? phi_out_phi_7 : phi_out_phi_7;
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for ret_25.valid_reg
	always @(*) begin
		if ((global_state == 4)) begin 
			if (1) begin
				valid_reg = 1;
			end else begin
				valid_reg = 0;
			end
		end else begin
			valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			if ((global_state == 0) && 1) begin
				global_state <= 1;
			end
			if ((global_state == 1) && 1) begin
				global_state <= 2;
			end
			if ((global_state == 2) && 1) begin
				global_state <= 3;
			end
			if ((global_state == 3) && !(cmp_out_icmp_11)) begin
				global_state <= 4;
			end
			if ((global_state == 3) && (cmp_out_icmp_11)) begin
				global_state <= 3;
			end
			if ((global_state == 4) && 1) begin
				global_state <= 4;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 2)) begin
				last_BB_reg <= 0;
			end
			if ((global_state == 3)) begin
				last_BB_reg <= 1;
			end
			if ((global_state == 4)) begin
				last_BB_reg <= 2;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			trunc_tmp_2 <= 0;
		end else begin
			if ((global_state == 3)) begin
				trunc_tmp_2 <= trunc_out_trunc_10;
			end
		end
	end

endmodule

