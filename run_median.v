module run_median_inner(input [0:0] clk, input [0:0] rst, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [31:0] arg_0_median_word, output [0:0] valid, output [31:0] arg_2_in_data, input [31:0] arg_2_out_data, output [31:0] arg_3_in_data, input [31:0] arg_3_out_data, output [31:0] arg_1_in_data, input [31:0] arg_1_out_data, output [31:0] arg_4_in_data, input [31:0] arg_4_out_data);

	reg [0:0] arg_0_rst_n_reg;
	reg [31:0] arg_0_word0_reg;
	reg [31:0] arg_0_word1_reg;
	reg [31:0] arg_0_word2_reg;
	reg [0:0] valid_reg;
	reg [31:0] arg_2_in_data_reg;
	reg [31:0] arg_3_in_data_reg;
	reg [31:0] arg_1_in_data_reg;
	reg [31:0] arg_4_in_data_reg;

	assign arg_0_rst_n = arg_0_rst_n_reg;
	assign arg_0_word0 = arg_0_word0_reg;
	assign arg_0_word1 = arg_0_word1_reg;
	assign arg_0_word2 = arg_0_word2_reg;
	assign valid = valid_reg;
	assign arg_2_in_data = arg_2_in_data_reg;
	assign arg_3_in_data = arg_3_in_data_reg;
	assign arg_1_in_data = arg_1_in_data_reg;
	assign arg_4_in_data = arg_4_in_data_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [63:0] phi_in_phi_6;
	reg [31:0] phi_last_block_phi_6;
	reg [63:0] phi_s_phi_6;
	wire [31:0] phi_out_phi_6;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_6(.in(phi_in_phi_6), .last_block(phi_last_block_phi_6), .out(phi_out_phi_6), .s(phi_s_phi_6));

	reg [31:0] add_in0_add_7;
	reg [31:0] add_in1_add_7;
	wire [31:0] add_out_add_7;
	add #(.WIDTH(32)) add_add_7(.in0(add_in0_add_7), .in1(add_in1_add_7), .out(add_out_add_7));

	reg [31:0] cmp_in0_icmp_12;
	reg [31:0] cmp_in1_icmp_12;
	wire [0:0] cmp_out_icmp_12;
	ne #(.WIDTH(32)) icmp_12(.in0(cmp_in0_icmp_12), .in1(cmp_in1_icmp_12), .out(cmp_out_icmp_12));

	br_dummy br_unit();

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
				if ((cmp_out_icmp_12)) begin
					global_state <= 3;
				end
				// Condition = (!(  %7 = icmp ne i32 %2, 8533))
				if (!(cmp_out_icmp_12)) begin
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
					add_tmp_1 <= add_out_add_7;
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

	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @builtin_write_port_rst_n(%class.median_filter* %arg_0, i1 true)
				arg_0_rst_n_reg = -(1'd1);
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_rst_n(%class.median_filter* %arg_0, i1 false)
				arg_0_rst_n_reg = (1'd0);
		end else 		if ((global_state == 2)) begin 
				//   call void @builtin_write_port_rst_n(%class.median_filter* %arg_0, i1 true)
				arg_0_rst_n_reg = -(1'd1);
		end else 		if ((global_state == 3)) begin 
				//   call void @builtin_write_port_word0(%class.median_filter* %arg_0, i32 %3)
				arg_0_word0_reg = arg_1_out_data;
				//   call void @builtin_write_port_word1(%class.median_filter* %arg_0, i32 %4)
				arg_0_word1_reg = arg_2_out_data;
				//   call void @builtin_write_port_word2(%class.median_filter* %arg_0, i32 %5)
				arg_0_word2_reg = arg_3_out_data;
				//   %6 = call i32 @builtin_read_port_median_word(%class.median_filter* %arg_0)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %1 = phi i32 [ 0, %entry_block ], [ %2, %0 ]
				phi_in_phi_6 = {(32'd0), add_tmp_1};
				phi_last_block_phi_6 = last_BB_reg;
				phi_s_phi_6 = {32'd0, 32'd2};
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %2 = add i32 %1, 1
				add_in0_add_7 = phi_out_phi_6;
				add_in1_add_7 = (32'd1);
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %4 = call i32 @builtin_read_port_out_data(%builtin_fifo_32* %arg_2)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %5 = call i32 @builtin_read_port_out_data(%builtin_fifo_32* %arg_3)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %7 = icmp ne i32 %2, 8533
				cmp_in0_icmp_12 = add_out_add_7;
				cmp_in1_icmp_12 = (32'd8533);
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   %3 = call i32 @builtin_read_port_out_data(%builtin_fifo_32* %arg_1)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   call void @builtin_write_port_in_data(%builtin_fifo_32* %arg_4, i32 %6)
				arg_4_in_data_reg = arg_0_median_word;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module run_median(input [0:0] clk, input [0:0] rst, output [0:0] arg_0_rst_n, output [31:0] arg_0_word0, output [31:0] arg_0_word1, output [31:0] arg_0_word2, input [31:0] arg_0_median_word, output [0:0] valid, output [31:0] arg_2_in_data, input [31:0] arg_2_out_data, output [31:0] arg_3_in_data, input [31:0] arg_3_out_data, output [31:0] arg_1_in_data, input [31:0] arg_1_out_data, output [31:0] arg_4_in_data, input [31:0] arg_4_out_data);


	initial begin
	end




	run_median_inner inner(.arg_0_median_word(arg_0_median_word), .arg_0_rst_n(arg_0_rst_n), .arg_0_word0(arg_0_word0), .arg_0_word1(arg_0_word1), .arg_0_word2(arg_0_word2), .arg_1_in_data(arg_1_in_data), .arg_1_out_data(arg_1_out_data), .arg_2_in_data(arg_2_in_data), .arg_2_out_data(arg_2_out_data), .arg_3_in_data(arg_3_in_data), .arg_3_out_data(arg_3_out_data), .arg_4_in_data(arg_4_in_data), .arg_4_out_data(arg_4_out_data), .clk(clk), .rst(rst), .valid(valid));

endmodule
