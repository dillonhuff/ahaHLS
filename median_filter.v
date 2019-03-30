module median_filter_inner(input [0:0] clk, input [0:0] rst, output [31:0] in2_in_data, input [31:0] in2_out_data, output [31:0] out_in_data, input [31:0] out_out_data, output [0:0] valid, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data);

	reg [31:0] in2_in_data_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] valid_reg;
	reg [31:0] in0_in_data_reg;
	reg [31:0] in1_in_data_reg;

	assign in2_in_data = in2_in_data_reg;
	assign out_in_data = out_in_data_reg;
	assign valid = valid_reg;
	assign in0_in_data = in0_in_data_reg;
	assign in1_in_data = in1_in_data_reg;

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

	reg [31:0] cmp_in0_icmp_12;
	reg [31:0] cmp_in1_icmp_12;
	wire [0:0] cmp_out_icmp_12;
	ne #(.WIDTH(32)) icmp_12(.in0(cmp_in0_icmp_12), .in1(cmp_in1_icmp_12), .out(cmp_out_icmp_12));

	reg [63:0] phi_in_phi_14;
	reg [31:0] phi_last_block_phi_14;
	reg [63:0] phi_s_phi_14;
	wire [31:0] phi_out_phi_14;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_14(.in(phi_in_phi_14), .last_block(phi_last_block_phi_14), .out(phi_out_phi_14), .s(phi_s_phi_14));

	reg [31:0] add_in0_add_15;
	reg [31:0] add_in1_add_15;
	wire [31:0] add_out_add_15;
	add #(.WIDTH(32)) add_add_15(.in0(add_in0_add_15), .in1(add_in1_add_15), .out(add_out_add_15));

	// End Functional Units

	// Start instruction result storage
	reg [31:0] add_tmp_4;
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
			if ((global_state == 1)) begin
			end
			if ((global_state == 2)) begin
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
				// Condition = True

				if (1) begin
					global_state <= 4;
				end
			end
			if ((global_state == 4)) begin 
				// Next state transition logic
				// Condition = (  %8 = icmp ne i32 %3, 8533)
				if ((cmp_out_icmp_12)) begin
					global_state <= 4;
				end
				// Condition = (!(  %8 = icmp ne i32 %3, 8533))
				if (!(cmp_out_icmp_12)) begin
					global_state <= 5;
				end
			end
			if ((global_state == 5)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 6;
				end
			end
			if ((global_state == 6)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 6;
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
			end
			if ((global_state == 4)) begin 
				// Temporary storage
				// Store data computed at the stage
					add_tmp_4 <= add_out_add_15;
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

	always @(*) begin
		if ((global_state == 0)) begin 
				//   %m = alloca %class.median, align 4
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_rst_n(%class.median* %m, i1 true)
				m_rst_n = -(1'd1);
		end else 		if ((global_state == 2)) begin 
				//   call void @builtin_write_port_rst_n(%class.median* %m, i1 false)
				m_rst_n = (1'd0);
		end else 		if ((global_state == 3)) begin 
				//   call void @builtin_write_port_rst_n(%class.median* %m, i1 true)
				m_rst_n = -(1'd1);
		end else 		if ((global_state == 4)) begin 
				//   call void @builtin_write_port_word0(%class.median* %m, i32 %4)
				m_word0 = in0_out_data;
				//   call void @builtin_write_port_word1(%class.median* %m, i32 %5)
				m_word1 = in1_out_data;
				//   call void @builtin_write_port_word2(%class.median* %m, i32 %6)
				m_word2 = in2_out_data;
				//   %7 = call i32 @builtin_read_port_median_word(%class.median* %m)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   %6 = call i32 @builtin_read_port_out_data(%class.ac_channel* %in2)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   call void @builtin_write_port_in_data(%class.ac_channel* %out, i32 %7)
				out_in_data_reg = m_median_word;
		end else begin 
			// Default values
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %8 = icmp ne i32 %3, 8533
				cmp_in0_icmp_12 = add_out_add_15;
				cmp_in1_icmp_12 = (32'd8533);
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %2 = phi i32 [ 0, %entry_block_il ], [ %3, %_il ]
				phi_in_phi_14 = {(32'd0), add_tmp_4};
				phi_last_block_phi_14 = last_BB_reg;
				phi_s_phi_14 = {32'd2, 32'd4};
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %3 = add i32 %2, 1
				add_in0_add_15 = phi_out_phi_14;
				add_in1_add_15 = (32'd1);
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   %4 = call i32 @builtin_read_port_out_data(%class.ac_channel* %in0)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   %5 = call i32 @builtin_read_port_out_data(%class.ac_channel* %in1)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 6)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module median_filter(input [0:0] clk, input [0:0] rst, output [31:0] in2_in_data, input [31:0] in2_out_data, output [31:0] out_in_data, input [31:0] out_out_data, output [0:0] valid, output [31:0] in0_in_data, input [31:0] in0_out_data, output [31:0] in1_in_data, input [31:0] in1_out_data);


	initial begin
	end




	median_filter_inner inner(.clk(clk), .in0_in_data(in0_in_data), .in0_out_data(in0_out_data), .in1_in_data(in1_in_data), .in1_out_data(in1_out_data), .in2_in_data(in2_in_data), .in2_out_data(in2_out_data), .out_in_data(out_in_data), .out_out_data(out_out_data), .rst(rst), .valid(valid));

endmodule
