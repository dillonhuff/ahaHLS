module run_median_inner(input [0:0] clk, input [0:0] rst, output [31:0] arg_2_in_data, input [31:0] arg_2_out_data, output [31:0] arg_3_in_data, input [31:0] arg_3_out_data, output [31:0] arg_4_in_data, input [31:0] arg_4_out_data, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [31:0] arg_0_median_word, output [0:0] valid, output [31:0] arg_1_in_data, input [31:0] arg_1_out_data);

	reg [31:0] arg_2_in_data_reg;
	reg [31:0] arg_3_in_data_reg;
	reg [31:0] arg_4_in_data_reg;
	reg [0:0] arg_0_rst_n_reg;
	reg [31:0] arg_0_word0_reg;
	reg [31:0] arg_0_word1_reg;
	reg [31:0] arg_0_word2_reg;
	reg [0:0] valid_reg;
	reg [31:0] arg_1_in_data_reg;

	assign arg_2_in_data = arg_2_in_data_reg;
	assign arg_3_in_data = arg_3_in_data_reg;
	assign arg_4_in_data = arg_4_in_data_reg;
	assign arg_0_rst_n = arg_0_rst_n_reg;
	assign arg_0_word0 = arg_0_word0_reg;
	assign arg_0_word1 = arg_0_word1_reg;
	assign arg_0_word2 = arg_0_word2_reg;
	assign valid = valid_reg;
	assign arg_1_in_data = arg_1_in_data_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [63:0] phi_in_phi_9;
	reg [31:0] phi_last_block_phi_9;
	reg [63:0] phi_s_phi_9;
	wire [31:0] phi_out_phi_9;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_9(.in(phi_in_phi_9), .last_block(phi_last_block_phi_9), .out(phi_out_phi_9), .s(phi_s_phi_9));

	reg [31:0] add_in0_add_10;
	reg [31:0] add_in1_add_10;
	wire [31:0] add_out_add_10;
	add #(.WIDTH(32)) add_add_10(.in0(add_in0_add_10), .in1(add_in1_add_10), .out(add_out_add_10));

	reg [31:0] cmp_in0_icmp_13;
	reg [31:0] cmp_in1_icmp_13;
	wire [0:0] cmp_out_icmp_13;
	ne #(.WIDTH(32)) icmp_13(.in0(cmp_in0_icmp_13), .in1(cmp_in1_icmp_13), .out(cmp_out_icmp_13));

	br_dummy br_unit();

	// End Functional Units

	// Start instruction result storage
	reg [31:0] add_tmp_3;
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
			end
			if ((global_state == 1)) begin
			end
			if ((global_state == 2)) begin
					last_BB_reg <= 0;
			end
			if ((global_state == 3)) begin
					last_BB_reg <= 2;
			end
			if ((global_state == 4)) begin
					last_BB_reg <= 1;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			// Control code
			if ((global_state == 0)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 1;
				end
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 2;
				end
			end
			if ((global_state == 2)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 3;
				end
			end
			if ((global_state == 3)) begin 
				// Next state transition logic
				// Condition = (  %7 = icmp ne i32 %2, 8533)
				if ((cmp_out_icmp_13)) begin
					global_state <= 3;
				end
				// Condition = (!(  %7 = icmp ne i32 %2, 8533))
				if (!(cmp_out_icmp_13)) begin
					global_state <= 4;
				end
			end
			if ((global_state == 4)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 4;
				end
			end

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
					add_tmp_3 <= add_out_add_10;
			end
			if ((global_state == 4)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for arg_0.arg_0_rst_n_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				arg_0_rst_n_reg = -(1'd1);
			end else begin
				arg_0_rst_n_reg = 0;
			end
		end else if ((global_state == 1)) begin 
			if (1) begin
				arg_0_rst_n_reg = (1'd0);
			end else begin
				arg_0_rst_n_reg = 0;
			end
		end else if ((global_state == 2)) begin 
			if (1) begin
				arg_0_rst_n_reg = -(1'd1);
			end else begin
				arg_0_rst_n_reg = 0;
			end
		end
	end
	// controller for arg_0.arg_0_word0_reg
	// controller for arg_0.arg_0_word1_reg
	// controller for arg_0.arg_0_word2_reg
	// Insensitive connections
	always @(*) begin
		arg_0_word0_reg = valid ? arg_1_out_data : arg_1_out_data;
		arg_0_word1_reg = valid ? arg_2_out_data : arg_2_out_data;
		arg_0_word2_reg = valid ? arg_3_out_data : arg_3_out_data;
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for arg_4.arg_4_in_data_reg
	// Insensitive connections
	always @(*) begin
		arg_4_in_data_reg = valid ? arg_0_median_word : arg_0_median_word;
	end
	// controller for phi_9.phi_in_phi_9
	// controller for phi_9.phi_last_block_phi_9
	// controller for phi_9.phi_s_phi_9
	// Insensitive connections
	always @(*) begin
		phi_in_phi_9 = valid ? {(32'd0), add_tmp_3} : {(32'd0), add_tmp_3};
		phi_last_block_phi_9 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_9 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for add_add_10.add_in0_add_10
	// controller for add_add_10.add_in1_add_10
	// Insensitive connections
	always @(*) begin
		add_in0_add_10 = valid ? phi_out_phi_9 : phi_out_phi_9;
		add_in1_add_10 = valid ? (32'd1) : (32'd1);
	end
	// controller for icmp_13.cmp_in0_icmp_13
	// controller for icmp_13.cmp_in1_icmp_13
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_13 = valid ? add_out_add_10 : add_out_add_10;
		cmp_in1_icmp_13 = valid ? (32'd8533) : (32'd8533);
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for ret_16.valid_reg
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
endmodule

module run_median(input [0:0] clk, input [0:0] rst, output [31:0] arg_2_in_data, input [31:0] arg_2_out_data, output [31:0] arg_3_in_data, input [31:0] arg_3_out_data, output [31:0] arg_4_in_data, input [31:0] arg_4_out_data, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [31:0] arg_0_median_word, output [0:0] valid, output [31:0] arg_1_in_data, input [31:0] arg_1_out_data);


	initial begin
	end




	run_median_inner inner(.arg_0_median_word(arg_0_median_word), .arg_0_rst_n(arg_0_rst_n), .arg_0_word0(arg_0_word0), .arg_0_word1(arg_0_word1), .arg_0_word2(arg_0_word2), .arg_1_in_data(arg_1_in_data), .arg_1_out_data(arg_1_out_data), .arg_2_in_data(arg_2_in_data), .arg_2_out_data(arg_2_out_data), .arg_3_in_data(arg_3_in_data), .arg_3_out_data(arg_3_out_data), .arg_4_in_data(arg_4_in_data), .arg_4_out_data(arg_4_out_data), .clk(clk), .rst(rst), .valid(valid));

endmodule
