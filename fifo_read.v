module fifo_read_inner(input [0:0] clk, input [0:0] rst, output [31:0] arg_0_in_data, output [0:0] arg_0_read_valid, output [0:0] arg_0_rst, output [31:0] arg_0_write_valid, input [31:0] arg_0_out_data, input [0:0] arg_0_read_ready, input [0:0] arg_0_write_ready, output [0:0] valid);

	reg [31:0] arg_0_in_data_reg;
	reg [0:0] arg_0_read_valid_reg;
	reg [0:0] arg_0_rst_reg;
	reg [31:0] arg_0_write_valid_reg;
	reg [0:0] valid_reg;

	assign arg_0_in_data = arg_0_in_data_reg;
	assign arg_0_read_valid = arg_0_read_valid_reg;
	assign arg_0_rst = arg_0_rst_reg;
	assign arg_0_write_valid = arg_0_write_valid_reg;
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
			if ((global_state == 0)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_0_read_ready) begin 
					global_state <= 1;
				end
				end
				// Store data computed at the stage
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 2;
				end
				// Store data computed at the stage
			end
			if ((global_state == 2)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 2;
				end
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	always @(*) begin
		if ((global_state == 0)) begin 
				//   %1 = call i1 @builtin_read_port_read_ready(%builtin_fifo_32* %0)
				if (arg_0_read_ready) begin
				end
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_read_valid(%builtin_fifo_32* %0, i1 true)
				arg_0_read_valid_reg = -(1'd1);
		end else 		if ((global_state == 2)) begin 
				//   call void @builtin_write_port_read_valid(%builtin_fifo_32* %0, i1 false)
				arg_0_read_valid_reg = (1'd0);
				//   %2 = call i32 @builtin_read_port_out_data(%builtin_fifo_32* %0)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @builtin_stall(i1 %1)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   ret i32 %2
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module fifo_read(input [0:0] clk, input [0:0] rst, output [31:0] arg_0_in_data, output [0:0] arg_0_read_valid, output [0:0] arg_0_rst, output [31:0] arg_0_write_valid, input [31:0] arg_0_out_data, input [0:0] arg_0_read_ready, input [0:0] arg_0_write_ready, output [0:0] valid);


	initial begin
	end




	fifo_read_inner inner(.arg_0_in_data(arg_0_in_data), .arg_0_out_data(arg_0_out_data), .arg_0_read_ready(arg_0_read_ready), .arg_0_read_valid(arg_0_read_valid), .arg_0_rst(arg_0_rst), .arg_0_write_ready(arg_0_write_ready), .arg_0_write_valid(arg_0_write_valid), .clk(clk), .rst(rst), .valid(valid));

endmodule
