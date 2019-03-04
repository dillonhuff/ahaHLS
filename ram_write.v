module ram_write_inner(input [0:0] clk, input [0:0] rst, output [3:0] arg_0_debug_addr, output [3:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [3:0] arg_0_raddr_0, output [0:0] arg_0_rst, output [3:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [31:0] arg_0_debug_data, input [31:0] arg_0_rdata_0, output [0:0] valid, input [31:0] arg_1, input [31:0] arg_2);

	reg [3:0] arg_0_debug_addr_reg;
	reg [3:0] arg_0_debug_write_addr_reg;
	reg [31:0] arg_0_debug_write_data_reg;
	reg [0:0] arg_0_debug_write_en_reg;
	reg [3:0] arg_0_raddr_0_reg;
	reg [0:0] arg_0_rst_reg;
	reg [3:0] arg_0_waddr_0_reg;
	reg [31:0] arg_0_wdata_0_reg;
	reg [0:0] arg_0_wen_0_reg;
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
			if ((global_state == 3)) begin
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
					global_state <= 1;
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
					global_state <= 3;
				end
				// Store data computed at the stage
			end
			if ((global_state == 3)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 3;
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
				//   call void @builtin_write_port_wen_0(%SRAM_32_16* %0, i1 true)
				arg_0_wen_0_reg = -(1'd1);
				//   call void @builtin_write_port_waddr_0(%SRAM_32_16* %0, i32 %1)
				arg_0_waddr_0_reg = arg_1;
				//   call void @builtin_write_port_wdata_0(%SRAM_32_16* %0, i32 %2)
				arg_0_wdata_0_reg = arg_2;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 3)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module ram_write(input [0:0] clk, input [0:0] rst, output [3:0] arg_0_debug_addr, output [3:0] arg_0_debug_write_addr, output [31:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [3:0] arg_0_raddr_0, output [0:0] arg_0_rst, output [3:0] arg_0_waddr_0, output [31:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [31:0] arg_0_debug_data, input [31:0] arg_0_rdata_0, output [0:0] valid, input [31:0] arg_1, input [31:0] arg_2);


	initial begin
	end




	ram_write_inner inner(.arg_0_debug_addr(arg_0_debug_addr), .arg_0_debug_data(arg_0_debug_data), .arg_0_debug_write_addr(arg_0_debug_write_addr), .arg_0_debug_write_data(arg_0_debug_write_data), .arg_0_debug_write_en(arg_0_debug_write_en), .arg_0_raddr_0(arg_0_raddr_0), .arg_0_rdata_0(arg_0_rdata_0), .arg_0_rst(arg_0_rst), .arg_0_waddr_0(arg_0_waddr_0), .arg_0_wdata_0(arg_0_wdata_0), .arg_0_wen_0(arg_0_wen_0), .arg_1(arg_1), .arg_2(arg_2), .clk(clk), .rst(rst), .valid(valid));

endmodule
