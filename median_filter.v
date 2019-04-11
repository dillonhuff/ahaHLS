module median_filter(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, input [31:0] out_out_data, output [0:0] valid, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data, output [31:0] in2_in_data, input [31:0] in2_out_data);

	reg [31:0] out_in_data_reg;
	reg [0:0] valid_reg;
	reg [31:0] in0_in_data_reg;
	reg [31:0] in1_in_data_reg;
	reg [31:0] in2_in_data_reg;

	assign out_in_data = out_in_data_reg;
	assign valid = valid_reg;
	assign in0_in_data = in0_in_data_reg;
	assign in1_in_data = in1_in_data_reg;
	assign in2_in_data = in2_in_data_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	br_dummy br_unit();

	reg [0:0] m_rst_n;
	reg [31:0] m_word0;
	reg [31:0] m_word1;
	reg [31:0] m_word2;
	wire [31:0] m_median_word;
	median m(.clk(clk), .median_word(m_median_word), .rst_n(m_rst_n), .word0(m_word0), .word1(m_word1), .word2(m_word2));

	reg [31:0] cmp_in0_icmp_11;
	reg [31:0] cmp_in1_icmp_11;
	wire [0:0] cmp_out_icmp_11;
	ne #(.WIDTH(32)) icmp_11(.in0(cmp_in0_icmp_11), .in1(cmp_in1_icmp_11), .out(cmp_out_icmp_11));

	reg [63:0] phi_in_phi_13;
	reg [31:0] phi_last_block_phi_13;
	reg [63:0] phi_s_phi_13;
	wire [31:0] phi_out_phi_13;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_13(.in(phi_in_phi_13), .last_block(phi_last_block_phi_13), .out(phi_out_phi_13), .s(phi_s_phi_13));

	reg [31:0] add_in0_add_14;
	reg [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_1_in0;
	reg [31:0] eq_1_in1;
	wire [0:0] eq_1_out;
	eq #(.WIDTH(32)) eq_1(.in0(eq_1_in0), .in1(eq_1_in1), .out(eq_1_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_2_in0;
	reg [31:0] eq_2_in1;
	wire [0:0] eq_2_out;
	eq #(.WIDTH(32)) eq_2(.in0(eq_2_in0), .in1(eq_2_in1), .out(eq_2_out));

	reg [0:0] bb_3_active_in_data;
	wire [0:0] bb_3_active_out_data;
	hls_wire #(.WIDTH(1)) bb_3_active(.in_data(bb_3_active_in_data), .out_data(bb_3_active_out_data));

	reg [31:0] eq_3_in0;
	reg [31:0] eq_3_in1;
	wire [0:0] eq_3_out;
	eq #(.WIDTH(32)) eq_3(.in0(eq_3_in0), .in1(eq_3_in1), .out(eq_3_out));

	reg [0:0] bb_4_active_in_data;
	wire [0:0] bb_4_active_out_data;
	hls_wire #(.WIDTH(1)) bb_4_active(.in_data(bb_4_active_in_data), .out_data(bb_4_active_out_data));

	reg [31:0] eq_4_in0;
	reg [31:0] eq_4_in1;
	wire [0:0] eq_4_out;
	eq #(.WIDTH(32)) eq_4(.in0(eq_4_in0), .in1(eq_4_in1), .out(eq_4_out));

	// End Functional Units

	reg [31:0] add_tmp_3;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [31:0] last_BB_reg;

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? phi_out_phi_13 : phi_out_phi_13;
		add_in1_add_14 = valid ? (32'd1) : (32'd1);
	end
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_0_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_1_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_2_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_3_active_in_data = eq_3_out;
		end else begin
			bb_3_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_4_active_in_data = eq_4_out;
		end else begin
			bb_4_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_0_in0 = 32'd0;
		end else begin
			eq_0_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_0_in1 = global_next_block;
		end else begin
			eq_0_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_1_in0 = 32'd1;
		end else begin
			eq_1_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_1_in1 = global_next_block;
		end else begin
			eq_1_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_2_in0 = 32'd2;
		end else begin
			eq_2_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_2_in1 = global_next_block;
		end else begin
			eq_2_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_3_in0 = 32'd3;
		end else begin
			eq_3_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_3_in1 = global_next_block;
		end else begin
			eq_3_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_4_in0 = 32'd4;
		end else begin
			eq_4_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_4_in1 = global_next_block;
		end else begin
			eq_4_in1 = 0;
		end
	end
	// controller for icmp_11.cmp_in0_icmp_11
	// controller for icmp_11.cmp_in1_icmp_11
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_11 = valid ? add_out_add_14 : add_out_add_14;
		cmp_in1_icmp_11 = valid ? (32'd8533) : (32'd8533);
	end
	// controller for m.m_rst_n
	always @(*) begin
		if ((global_state == 1)) begin 
			if (1) begin
				m_rst_n = -(1'd1);
			end else begin
				m_rst_n = 0;
			end
		end else if ((global_state == 2)) begin 
			if (1) begin
				m_rst_n = (1'd0);
			end else begin
				m_rst_n = 0;
			end
		end else if ((global_state == 3)) begin 
			if (1) begin
				m_rst_n = -(1'd1);
			end else begin
				m_rst_n = 0;
			end
		end else begin
			m_rst_n = 0;
		end
	end
	// controller for m.m_word0
	// controller for m.m_word1
	// controller for m.m_word2
	// Insensitive connections
	always @(*) begin
		m_word0 = valid ? in0_out_data : in0_out_data;
		m_word1 = valid ? in1_out_data : in1_out_data;
		m_word2 = valid ? in2_out_data : in2_out_data;
	end
	// controller for out.out_in_data_reg
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? m_median_word : m_median_word;
	end
	// controller for phi_13.phi_in_phi_13
	// controller for phi_13.phi_last_block_phi_13
	// controller for phi_13.phi_s_phi_13
	// Insensitive connections
	always @(*) begin
		phi_in_phi_13 = valid ? {(32'd0), add_tmp_3} : {(32'd0), add_tmp_3};
		phi_last_block_phi_13 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_13 = valid ? {32'd2, 32'd4} : {32'd2, 32'd4};
	end
	// controller for ret_19.valid_reg
	always @(*) begin
		if ((global_state == 6)) begin 
			if (1) begin
				valid_reg = 1;
			end else begin
				valid_reg = 0;
			end
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_3 <= 0;
		end else begin
			if ((global_state == 4)) begin
				add_tmp_3 <= add_out_add_14;
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
			if ((global_state == 0) && 1) begin
				global_state <= 1;
			end
			if ((global_state == 1) && 1) begin
				global_state <= 2;
			end
			if ((global_state == 2) && 1) begin
				global_state <= 3;
			end
			if ((global_state == 3) && 1) begin
				global_state <= 4;
			end
			if ((global_state == 4) && !(cmp_out_icmp_11)) begin
				global_state <= 5;
			end
			if ((global_state == 4) && (cmp_out_icmp_11)) begin
				global_state <= 4;
			end
			if ((global_state == 5) && 1) begin
				global_state <= 6;
			end
			if ((global_state == 6) && 1) begin
				global_state <= 6;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 0)) begin
				last_BB_reg <= 0;
			end
			if ((global_state == 3)) begin
				last_BB_reg <= 2;
			end
			if ((global_state == 4)) begin
				last_BB_reg <= 4;
			end
			if ((global_state == 5)) begin
				last_BB_reg <= 3;
			end
			if ((global_state == 6)) begin
				last_BB_reg <= 1;
			end
		end
	end

endmodule

