module fpu_add_inner(input [0:0] clk, input [0:0] rst, output [31:0] arg_0_input_a, output [0:0] arg_0_input_a_stb, output [31:0] arg_0_input_b, output [0:0] arg_0_input_b_stb, output [0:0] arg_0_rst, input [0:0] arg_0_input_a_ack, input [0:0] arg_0_input_b_ack, input [31:0] arg_0_output_z, input [0:0] arg_0_output_z_stb, output [31:0] return_value, output [0:0] valid, input [31:0] arg_1_out_data, input [31:0] arg_2_out_data);

	reg [31:0] arg_0_input_a_reg;
	reg [0:0] arg_0_input_a_stb_reg;
	reg [31:0] arg_0_input_b_reg;
	reg [0:0] arg_0_input_b_stb_reg;
	reg [0:0] arg_0_rst_reg;
	reg [31:0] return_value_reg;
	reg [0:0] valid_reg;

	assign arg_0_input_a = arg_0_input_a_reg;
	assign arg_0_input_a_stb = arg_0_input_a_stb_reg;
	assign arg_0_input_b = arg_0_input_b_reg;
	assign arg_0_input_b_stb = arg_0_input_b_stb_reg;
	assign arg_0_rst = arg_0_rst_reg;
	assign return_value = return_value_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_5();

	add call_10();

	add call_13();

	// End Functional Units

	// Start instruction result storage
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
			end
			if ((global_state == 3)) begin
			end
			if ((global_state == 4)) begin
					last_BB_reg <= 0;
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
				if (arg_0_input_a_ack) begin 
					global_state <= 3;
				end
				end
			end
			if ((global_state == 3)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_0_input_b_ack) begin 
					global_state <= 4;
				end
				end
			end
			if ((global_state == 4)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_0_output_z_stb) begin 
					global_state <= 4;
				end
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
				if (arg_0_input_a_ack) begin
				// Store data computed at the stage
				end
			end
			if ((global_state == 3)) begin 
				// Temporary storage
				if (arg_0_input_b_ack) begin
				// Store data computed at the stage
				end
			end
			if ((global_state == 4)) begin 
				// Temporary storage
				if (arg_0_output_z_stb) begin
				// Store data computed at the stage
				end
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for arg_0.arg_0_input_a_reg
	always @(*) begin
		if ((global_state == 2)) begin 
			if (arg_0_input_a_ack) begin
				arg_0_input_a_reg = arg_1_out_data;
			end
		end else begin
			arg_0_input_a_reg = 0;
		end
	end
	// controller for arg_0.arg_0_input_a_stb_reg
	always @(*) begin
		if ((global_state == 2)) begin 
			if (arg_0_input_a_ack) begin
				arg_0_input_a_stb_reg = -(1'd1);
			end
		end else if ((global_state == 3)) begin 
			if (arg_0_input_b_ack) begin
				arg_0_input_a_stb_reg = (1'd0);
			end
		end else begin
			arg_0_input_a_stb_reg = 0;
		end
	end
	// controller for arg_0.arg_0_input_b_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			if (arg_0_input_b_ack) begin
				arg_0_input_b_reg = arg_2_out_data;
			end
		end else begin
			arg_0_input_b_reg = 0;
		end
	end
	// controller for arg_0.arg_0_input_b_stb_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			if (arg_0_input_b_ack) begin
				arg_0_input_b_stb_reg = -(1'd1);
			end
		end else if ((global_state == 4)) begin 
			if (arg_0_output_z_stb) begin
				arg_0_input_b_stb_reg = (1'd0);
			end
		end else begin
			arg_0_input_b_stb_reg = 0;
		end
	end
	// controller for arg_0.arg_0_rst_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				arg_0_rst_reg = -(1'd1);
			end
		end else if ((global_state == 1)) begin 
			if (1) begin
				arg_0_rst_reg = (1'd0);
			end
		end else begin
			arg_0_rst_reg = 0;
		end
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
	// Insensitive connections
	always @(*) begin
	end
	// controller for ret_15.return_value_reg
	always @(*) begin
		if ((global_state == 4)) begin 
			if (arg_0_output_z_stb) begin
				return_value_reg = arg_0_output_z;
			end
		end else begin
			return_value_reg = 0;
		end
	end
	// controller for ret_15.valid_reg
	always @(*) begin
		if ((global_state == 4)) begin 
			if (arg_0_output_z_stb) begin
				valid_reg = 1;
			end
		end else begin
			valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
endmodule

module fpu_add(input [0:0] clk, input [0:0] rst, output [31:0] arg_0_input_a, output [0:0] arg_0_input_a_stb, output [31:0] arg_0_input_b, output [0:0] arg_0_input_b_stb, output [0:0] arg_0_rst, input [0:0] arg_0_input_a_ack, input [0:0] arg_0_input_b_ack, input [31:0] arg_0_output_z, input [0:0] arg_0_output_z_stb, output [31:0] return_value, output [0:0] valid, input [31:0] arg_1_out_data, input [31:0] arg_2_out_data);


	initial begin
	end




	fpu_add_inner inner(.arg_0_input_a(arg_0_input_a), .arg_0_input_a_ack(arg_0_input_a_ack), .arg_0_input_a_stb(arg_0_input_a_stb), .arg_0_input_b(arg_0_input_b), .arg_0_input_b_ack(arg_0_input_b_ack), .arg_0_input_b_stb(arg_0_input_b_stb), .arg_0_output_z(arg_0_output_z), .arg_0_output_z_stb(arg_0_output_z_stb), .arg_0_rst(arg_0_rst), .arg_1_out_data(arg_1_out_data), .arg_2_out_data(arg_2_out_data), .clk(clk), .return_value(return_value), .rst(rst), .valid(valid));

endmodule
