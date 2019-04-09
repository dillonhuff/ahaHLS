module median_filter_inner(input [0:0] clk, input [0:0] rst, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data, output [0:0] valid, output [31:0] out_in_data, input [31:0] out_out_data, output [31:0] in2_in_data, input [31:0] in2_out_data);

	reg [31:0] in0_in_data_reg;
	reg [31:0] in1_in_data_reg;
	reg [0:0] valid_reg;
	reg [31:0] out_in_data_reg;
	reg [31:0] in2_in_data_reg;

	assign in0_in_data = in0_in_data_reg;
	assign in1_in_data = in1_in_data_reg;
	assign valid = valid_reg;
	assign out_in_data = out_in_data_reg;
	assign in2_in_data = in2_in_data_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [31:0] cmp_in0_icmp_6;
	reg [31:0] cmp_in1_icmp_6;
	wire [0:0] cmp_out_icmp_6;
	ne #(.WIDTH(32)) icmp_6(.in0(cmp_in0_icmp_6), .in1(cmp_in1_icmp_6), .out(cmp_out_icmp_6));

	br_dummy br_unit();

	reg [0:0] m_rst_n;
	reg [31:0] m_word0;
	reg [31:0] m_word1;
	reg [31:0] m_word2;
	wire [31:0] m_median_word;
	median m(.clk(clk), .median_word(m_median_word), .rst_n(m_rst_n), .word0(m_word0), .word1(m_word1), .word2(m_word2));

	reg [31:0] add_in0_add_8;
	reg [31:0] add_in1_add_8;
	wire [31:0] add_out_add_8;
	add #(.WIDTH(32)) add_add_8(.in0(add_in0_add_8), .in1(add_in1_add_8), .out(add_out_add_8));

	reg [63:0] phi_in_phi_11;
	reg [31:0] phi_last_block_phi_11;
	reg [63:0] phi_s_phi_11;
	wire [31:0] phi_out_phi_11;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_11(.in(phi_in_phi_11), .last_block(phi_last_block_phi_11), .out(phi_out_phi_11), .s(phi_s_phi_11));

	// End Functional Units

	// Start instruction result storage
	reg [31:0] add_tmp_1;
	// End instruction result storage

	// Start pipeline variables
	// End pipeline variables

	reg [31:0] global_state;
	reg [31:0] last_BB_reg;
	// Start pipeline reset block
	always @(posedge clk) begin
		if (rst) begin
		end
	end
	// End pipeline reset block

	// Start pipeline valid chain block
	always @(posedge clk) begin

		if (!rst) begin
		end
	end
	// End pipeline valid chain block

	always @(posedge clk) begin
	end
	// Start pipeline initiation block
	always @(posedge clk) begin
	end
	// End pipeline initiation block

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
			if ((global_state == 4) && !(cmp_out_icmp_6)) begin
				global_state <= 5;
			end
			if ((global_state == 4) && (cmp_out_icmp_6)) begin
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
		end else begin
			// Temporary storage code
			if ((global_state == 0)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 1)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 2)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 3)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 4)) begin 
				// Temporary storage
				// Store data computed at the stage
					add_tmp_1 <= add_out_add_8;
			end
			if ((global_state == 5)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 6)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

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
	// controller for icmp_6.cmp_in0_icmp_6
	// controller for icmp_6.cmp_in1_icmp_6
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_6 = valid ? add_out_add_8 : add_out_add_8;
		cmp_in1_icmp_6 = valid ? (32'd8533) : (32'd8533);
	end
	// controller for add_add_8.add_in0_add_8
	// controller for add_add_8.add_in1_add_8
	// Insensitive connections
	always @(*) begin
		add_in0_add_8 = valid ? phi_out_phi_11 : phi_out_phi_11;
		add_in1_add_8 = valid ? (32'd1) : (32'd1);
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for phi_11.phi_in_phi_11
	// controller for phi_11.phi_last_block_phi_11
	// controller for phi_11.phi_s_phi_11
	// Insensitive connections
	always @(*) begin
		phi_in_phi_11 = valid ? {(32'd0), add_tmp_1} : {(32'd0), add_tmp_1};
		phi_last_block_phi_11 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_11 = valid ? {32'd2, 32'd4} : {32'd2, 32'd4};
	end
	// controller for out.out_in_data_reg
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? m_median_word : m_median_word;
	end
	// Insensitive connections
	always @(*) begin
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
	// Insensitive connections
	always @(*) begin
	end
endmodule

module median_filter(input [0:0] clk, input [0:0] rst, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data, output [0:0] valid, output [31:0] out_in_data, input [31:0] out_out_data, output [31:0] in2_in_data, input [31:0] in2_out_data);


	initial begin
	end




	median_filter_inner inner(.clk(clk), .in0_in_data(in0_in_data), .in0_out_data(in0_out_data), .in1_in_data(in1_in_data), .in1_out_data(in1_out_data), .in2_in_data(in2_in_data), .in2_out_data(in2_out_data), .out_in_data(out_in_data), .out_out_data(out_out_data), .rst(rst), .valid(valid));

endmodule
