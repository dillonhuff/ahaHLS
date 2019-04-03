module ram_read_inner(input [0:0] clk, input [0:0] rst, output [3:0] arg_0_debug_addr, output [3:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [3:0] arg_0_raddr_0, output [0:0] arg_0_rst, output [3:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [31:0] arg_0_debug_data, input [31:0] arg_0_rdata_0, output [31:0] return_value, output [0:0] valid, input [31:0] arg_1_out_data);

	reg [3:0] arg_0_debug_addr_reg;
	reg [3:0] arg_0_debug_write_addr_reg;
	reg [31:0] arg_0_debug_write_data_reg;
	reg [0:0] arg_0_debug_write_en_reg;
	reg [3:0] arg_0_raddr_0_reg;
	reg [0:0] arg_0_rst_reg;
	reg [3:0] arg_0_waddr_0_reg;
	reg [31:0] arg_0_wdata_0_reg;
	reg [0:0] arg_0_wen_0_reg;
	reg [31:0] return_value_reg;
	reg [0:0] valid_reg;

	assign arg_0_debug_addr = arg_0_debug_addr_reg;
	assign arg_0_debug_write_addr = arg_0_debug_write_addr_reg;
	assign arg_0_debug_write_data = arg_0_debug_write_data_reg;
	assign arg_0_debug_write_en = arg_0_debug_write_en_reg;
	assign arg_0_raddr_0 = arg_0_raddr_0_reg;
	assign arg_0_rst = arg_0_rst_reg;
	assign arg_0_waddr_0 = arg_0_waddr_0_reg;
	assign arg_0_wdata_0 = arg_0_wdata_0_reg;
	assign arg_0_wen_0 = arg_0_wen_0_reg;
	assign return_value = return_value_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
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
					global_state <= 1;
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
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for arg_0.arg_0_raddr_0_reg
	// Insensitive connections
	always @(*) begin
		arg_0_raddr_0_reg = valid ? arg_1_out_data : arg_1_out_data;
	end
	// controller for ret_2.return_value_reg
	// controller for ret_2.valid_reg
	always @(*) begin
		if ((global_state == 1)) begin 
			if (1) begin
				valid_reg = 1;
			end
		end else begin
			valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		return_value_reg = valid ? arg_0_rdata_0 : arg_0_rdata_0;
	end
endmodule

module ram_read(input [0:0] clk, input [0:0] rst, output [3:0] arg_0_debug_addr, output [3:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [3:0] arg_0_raddr_0, output [0:0] arg_0_rst, output [3:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [31:0] arg_0_debug_data, input [31:0] arg_0_rdata_0, output [31:0] return_value, output [0:0] valid, input [31:0] arg_1_out_data);


	initial begin
	end




	ram_read_inner inner(.arg_0_debug_addr(arg_0_debug_addr), .arg_0_debug_data(arg_0_debug_data), .arg_0_debug_write_addr(arg_0_debug_write_addr), .arg_0_debug_write_data(arg_0_debug_write_data), .arg_0_debug_write_en(arg_0_debug_write_en), .arg_0_raddr_0(arg_0_raddr_0), .arg_0_rdata_0(arg_0_rdata_0), .arg_0_rst(arg_0_rst), .arg_0_waddr_0(arg_0_waddr_0), .arg_0_wdata_0(arg_0_wdata_0), .arg_0_wen_0(arg_0_wen_0), .arg_1_out_data(arg_1_out_data), .clk(clk), .return_value(return_value), .rst(rst), .valid(valid));

endmodule
