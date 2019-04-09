module channel_reduce_4_inner(input [0:0] clk, input [0:0] rst, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready);

	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;
	reg [0:0] valid_reg;
	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;

	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;
	assign valid = valid_reg;
	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	br_dummy br_unit();

	add call_17();

	reg [63:0] phi_in_phi_6;
	reg [31:0] phi_last_block_phi_6;
	reg [63:0] phi_s_phi_6;
	wire [31:0] phi_out_phi_6;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_6(.in(phi_in_phi_6), .last_block(phi_last_block_phi_6), .out(phi_out_phi_6), .s(phi_s_phi_6));

	reg [31:0] add_in0_add_13;
	reg [31:0] add_in1_add_13;
	wire [31:0] add_out_add_13;
	add #(.WIDTH(32)) add_add_13(.in0(add_in0_add_13), .in1(add_in1_add_13), .out(add_out_add_13));

	reg [31:0] add_in0_add_8;
	reg [31:0] add_in1_add_8;
	wire [31:0] add_out_add_8;
	add #(.WIDTH(32)) add_add_8(.in0(add_in0_add_8), .in1(add_in1_add_8), .out(add_out_add_8));

	reg [31:0] cmp_in0_icmp_9;
	reg [31:0] cmp_in1_icmp_9;
	wire [0:0] cmp_out_icmp_9;
	eq #(.WIDTH(32)) icmp_9(.in0(cmp_in0_icmp_9), .in1(cmp_in1_icmp_9), .out(cmp_out_icmp_9));

	add alloca_1();

	add bitcast_2();

	add call_3();

	add call_10();

	add call_19();

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
	// Start pipeline valid chain block
	always @(posedge clk) begin

		if (!rst) begin
		end
	end
	// End pipeline valid chain block

	always @(posedge clk) begin
	end
	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 1)) begin
				last_BB_reg <= 0;
			end
			if ((global_state == 5)) begin
				last_BB_reg <= 2;
			end
			if ((global_state == 8)) begin
				last_BB_reg <= 1;
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
				if (in_read_ready) begin
				// Store data computed at the stage
					load_tmp_2 <= rdata_ram_0;
					add_tmp_3 <= add_out_add_8;
					icmp_tmp_4 <= cmp_out_icmp_9;
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
				wdata_ram_0_reg = add_out_add_13;
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
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
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
	// controller for phi_6.phi_in_phi_6
	// controller for phi_6.phi_last_block_phi_6
	// controller for phi_6.phi_s_phi_6
	// Insensitive connections
	always @(*) begin
		phi_in_phi_6 = valid ? {(32'd0), add_tmp_3} : {(32'd0), add_tmp_3};
		phi_last_block_phi_6 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_6 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
	end
	// controller for add_add_8.add_in0_add_8
	// controller for add_add_8.add_in1_add_8
	// Insensitive connections
	always @(*) begin
		add_in0_add_8 = valid ? phi_out_phi_6 : phi_out_phi_6;
		add_in1_add_8 = valid ? (32'd1) : (32'd1);
	end
	// controller for icmp_9.cmp_in0_icmp_9
	// controller for icmp_9.cmp_in1_icmp_9
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_9 = valid ? add_out_add_8 : add_out_add_8;
		cmp_in1_icmp_9 = valid ? (32'd4) : (32'd4);
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for add_add_13.add_in0_add_13
	// controller for add_add_13.add_in1_add_13
	// Insensitive connections
	always @(*) begin
		add_in0_add_13 = valid ? load_tmp_2 : load_tmp_2;
		add_in1_add_13 = valid ? in_out_data : in_out_data;
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
	// Insensitive connections
	always @(*) begin
	end
	// controller for ret_23.valid_reg
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
	// Register controllers
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
			if ((global_state == 2) && 1 && in_read_ready) begin
				global_state <= 3;
			end
			if ((global_state == 3) && 1) begin
				global_state <= 4;
			end
			if ((global_state == 4) && 1) begin
				global_state <= 5;
			end
			if ((global_state == 5) && !(icmp_tmp_4)) begin
				global_state <= 2;
			end
			if ((global_state == 5) && (icmp_tmp_4)) begin
				global_state <= 6;
			end
			if ((global_state == 6) && 1 && out_write_ready) begin
				global_state <= 7;
			end
			if ((global_state == 7) && 1) begin
				global_state <= 8;
			end
			if ((global_state == 8) && 1) begin
				global_state <= 8;
			end
		end
	end

endmodule

module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready);


	initial begin
	end




	channel_reduce_4_inner inner(.clk(clk), .in_in_data(in_in_data), .in_out_data(in_out_data), .in_read_ready(in_read_ready), .in_read_valid(in_read_valid), .in_rst(in_rst), .in_write_ready(in_write_ready), .in_write_valid(in_write_valid), .out_in_data(out_in_data), .out_out_data(out_out_data), .out_read_ready(out_read_ready), .out_read_valid(out_read_valid), .out_rst(out_rst), .out_write_ready(out_write_ready), .out_write_valid(out_write_valid), .rst(rst), .valid(valid));

endmodule
