module channel_reduce_4_inner(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);

	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [0:0] valid_reg;

	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign valid = valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_6();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add call_17();

	add alloca_0();

	add bitcast_1();

	add call_2();

	br_dummy br_unit();

	add call_18();

	reg [63:0] phi_in_phi_7;
	reg [31:0] phi_last_block_phi_7;
	reg [63:0] phi_s_phi_7;
	wire [31:0] phi_out_phi_7;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_7(.in(phi_in_phi_7), .last_block(phi_last_block_phi_7), .out(phi_out_phi_7), .s(phi_s_phi_7));

	reg [31:0] add_in0_add_14;
	reg [31:0] add_in1_add_14;
	wire [31:0] add_out_add_14;
	add #(.WIDTH(32)) add_add_14(.in0(add_in0_add_14), .in1(add_in1_add_14), .out(add_out_add_14));

	reg [31:0] add_in0_add_9;
	reg [31:0] add_in1_add_9;
	wire [31:0] add_out_add_9;
	add #(.WIDTH(32)) add_add_9(.in0(add_in0_add_9), .in1(add_in1_add_9), .out(add_out_add_9));

	reg [31:0] cmp_in0_icmp_10;
	reg [31:0] cmp_in1_icmp_10;
	wire [0:0] cmp_out_icmp_10;
	eq #(.WIDTH(32)) icmp_10(.in0(cmp_in0_icmp_10), .in1(cmp_in1_icmp_10), .out(cmp_out_icmp_10));

	// End Functional Units

	// Start instruction result storage
	reg [31:0] load_tmp_2;
	reg [31:0] add_tmp_3;
	reg [0:0] icmp_tmp_4;
	// End instruction result storage

	// Start pipeline variables
	// End pipeline variables

	reg [31:0] global_state;
	reg [31:0] last_BB_reg;


	// Start pipeline reset block
	always @(posedge clk) begin
		if (rst) begin
		end
		 else begin


		 end
	end
	// End pipeline reset block

	always @(posedge clk) begin
	end
	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 0)) begin
			end
			if ((global_state == 1)) begin
					last_BB_reg <= 0;
			end
			if ((global_state == 2)) begin
			end
			if ((global_state == 3)) begin
			end
			if ((global_state == 4)) begin
			end
			if ((global_state == 5)) begin
					last_BB_reg <= 2;
			end
			if ((global_state == 6)) begin
			end
			if ((global_state == 7)) begin
			end
			if ((global_state == 8)) begin
					last_BB_reg <= 1;
			end
		end
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
				if (in_read_ready) begin 
					global_state <= 3;
				end
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
				// Condition = True

				if (1) begin
					global_state <= 5;
				end
			end
			if ((global_state == 5)) begin 
				// Next state transition logic
				// Condition = (  %exitcond = icmp eq i32 %10, 4)
				if ((icmp_tmp_4)) begin
					global_state <= 6;
				end
				// Condition = (!(  %exitcond = icmp eq i32 %10, 4))
				if (!(icmp_tmp_4)) begin
					global_state <= 2;
				end
			end
			if ((global_state == 6)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (out_write_ready) begin 
					global_state <= 7;
				end
				end
			end
			if ((global_state == 7)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 8;
				end
			end
			if ((global_state == 8)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 8;
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
				if (in_read_ready) begin
				// Store data computed at the stage
					load_tmp_2 <= rdata_ram_0;
					add_tmp_3 <= add_out_add_9;
					icmp_tmp_4 <= cmp_out_icmp_10;
				end
			end
			if ((global_state == 3)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 4)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 5)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 6)) begin 
				// Temporary storage
				if (out_write_ready) begin
				// Store data computed at the stage
				end
			end
			if ((global_state == 7)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 8)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if ((global_state == 2)) begin 
			if (in_read_ready) begin
				raddr_ram_0_reg = 0;
			end else begin
				raddr_ram_0_reg = 0;
			end
		end else if ((global_state == 7)) begin 
			if (1) begin
				raddr_ram_0_reg = 0;
			end else begin
				raddr_ram_0_reg = 0;
			end
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				waddr_ram_0_reg = 0;
			end else begin
				waddr_ram_0_reg = 0;
			end
		end else if ((global_state == 4)) begin 
			if (1) begin
				waddr_ram_0_reg = 0;
			end else begin
				waddr_ram_0_reg = 0;
			end
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				wdata_ram_0_reg = (32'd0);
			end else begin
				wdata_ram_0_reg = 0;
			end
		end else if ((global_state == 4)) begin 
			if (1) begin
				wdata_ram_0_reg = add_out_add_14;
			end else begin
				wdata_ram_0_reg = 0;
			end
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (1) begin
				wen_ram_0_reg = 1;
			end else begin
				wen_ram_0_reg = 0;
			end
		end else if ((global_state == 4)) begin 
			if (1) begin
				wen_ram_0_reg = 1;
			end else begin
				wen_ram_0_reg = 0;
			end
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			if (1) begin
				in_read_valid_reg = -(1'd1);
			end else begin
				in_read_valid_reg = 0;
			end
		end else if ((global_state == 4)) begin 
			if (1) begin
				in_read_valid_reg = (1'd0);
			end else begin
				in_read_valid_reg = 0;
			end
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for phi_7.phi_in_phi_7
	// controller for phi_7.phi_last_block_phi_7
	// controller for phi_7.phi_s_phi_7
	// Insensitive connections
	always @(*) begin
		phi_in_phi_7 = valid ? {(32'd0), add_tmp_3} : {(32'd0), add_tmp_3};
		phi_last_block_phi_7 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_7 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for add_add_9.add_in0_add_9
	// controller for add_add_9.add_in1_add_9
	// Insensitive connections
	always @(*) begin
		add_in0_add_9 = valid ? phi_out_phi_7 : phi_out_phi_7;
		add_in1_add_9 = valid ? (32'd1) : (32'd1);
	end
	// controller for icmp_10.cmp_in0_icmp_10
	// controller for icmp_10.cmp_in1_icmp_10
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_10 = valid ? add_out_add_9 : add_out_add_9;
		cmp_in1_icmp_10 = valid ? (32'd4) : (32'd4);
	end
	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? load_tmp_2 : load_tmp_2;
		add_in1_add_14 = valid ? in_out_data : in_out_data;
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for out.out_in_data_reg
	// controller for out.out_write_valid_reg
	always @(*) begin
		if ((global_state == 7)) begin 
			if (1) begin
				out_write_valid_reg = -(1'd1);
			end else begin
				out_write_valid_reg = 0;
			end
		end else if ((global_state == 8)) begin 
			if (1) begin
				out_write_valid_reg = (1'd0);
			end else begin
				out_write_valid_reg = 0;
			end
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? rdata_ram_0 : rdata_ram_0;
	end
	// controller for ret_24.valid_reg
	always @(*) begin
		if ((global_state == 8)) begin 
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

module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);


	initial begin
	end




	channel_reduce_4_inner inner(.clk(clk), .in_in_data(in_in_data), .in_out_data(in_out_data), .in_read_ready(in_read_ready), .in_read_valid(in_read_valid), .in_rst(in_rst), .in_write_ready(in_write_ready), .in_write_valid(in_write_valid), .out_in_data(out_in_data), .out_out_data(out_out_data), .out_read_ready(out_read_ready), .out_read_valid(out_read_valid), .out_rst(out_rst), .out_write_ready(out_write_ready), .out_write_valid(out_write_valid), .rst(rst), .valid(valid));

endmodule
