module fifo_write_inner(input [0:0] clk, input [0:0] rst, output [31:0] arg_1_in_data, output [0:0] arg_1_read_valid, output [0:0] arg_1_rst, output [31:0] arg_1_write_valid, input [31:0] arg_1_out_data, input [0:0] arg_1_read_ready, input [0:0] arg_1_write_ready, output [0:0] valid, input [31:0] arg_0_out_data);

	reg [31:0] arg_1_in_data_reg;
	reg [0:0] arg_1_read_valid_reg;
	reg [0:0] arg_1_rst_reg;
	reg [31:0] arg_1_write_valid_reg;
	reg [0:0] valid_reg;

	assign arg_1_in_data = arg_1_in_data_reg;
	assign arg_1_read_valid = arg_1_read_valid_reg;
	assign arg_1_rst = arg_1_rst_reg;
	assign arg_1_write_valid = arg_1_write_valid_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_1();

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
				if (arg_1_write_ready) begin 
					global_state <= 1;
				end
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
					global_state <= 2;
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
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	always @(*) begin
		if ((global_state == 0)) begin 
				//   %2 = call i1 @builtin_read_port_write_ready(%builtin_fifo_32* %1)
				if (arg_1_write_ready) begin
				end
			arg_1_in_data_reg = 0;
			arg_1_read_valid_reg = 0;
			arg_1_write_valid_reg = 0;
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_write_valid(%builtin_fifo_32* %1, i1 true)
				arg_1_write_valid_reg = -(1'd1);
				//   call void @builtin_write_port_in_data(%builtin_fifo_32* %1, i32 %0)
				arg_1_in_data_reg = arg_0_out_data;
			arg_1_read_valid_reg = 0;
		end else 		if ((global_state == 2)) begin 
				//   call void @builtin_write_port_write_valid(%builtin_fifo_32* %1, i1 false)
				arg_1_write_valid_reg = (1'd0);
			arg_1_in_data_reg = 0;
			arg_1_read_valid_reg = 0;
		end else begin 
			// Default values
				arg_1_in_data_reg = 0;
				arg_1_read_valid_reg = 0;
				arg_1_write_valid_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @builtin_stall(i1 %2)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module fifo_write(input [0:0] clk, input [0:0] rst, output [31:0] arg_1_in_data, output [0:0] arg_1_read_valid, output [0:0] arg_1_rst, output [31:0] arg_1_write_valid, input [31:0] arg_1_out_data, input [0:0] arg_1_read_ready, input [0:0] arg_1_write_ready, output [0:0] valid, input [31:0] arg_0_out_data);


	initial begin
	end




	fifo_write_inner inner(.arg_0_out_data(arg_0_out_data), .arg_1_in_data(arg_1_in_data), .arg_1_out_data(arg_1_out_data), .arg_1_read_ready(arg_1_read_ready), .arg_1_read_valid(arg_1_read_valid), .arg_1_rst(arg_1_rst), .arg_1_write_ready(arg_1_write_ready), .arg_1_write_valid(arg_1_write_valid), .clk(clk), .rst(rst), .valid(valid));

endmodule
