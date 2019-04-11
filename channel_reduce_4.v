module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [0:0] valid, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready);

	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [0:0] out_write_valid_reg;
	reg [0:0] valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [0:0] in_write_valid_reg;

	assign out_in_data = out_in_data_reg;
	assign out_read_valid = out_read_valid_reg;
	assign out_rst = out_rst_reg;
	assign out_write_valid = out_write_valid_reg;
	assign valid = valid_reg;
	assign in_in_data = in_in_data_reg;
	assign in_read_valid = in_read_valid_reg;
	assign in_rst = in_rst_reg;
	assign in_write_valid = in_write_valid_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add alloca_0();

	add bitcast_1();

	add call_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	br_dummy br_unit();

	add call_17();

	reg [63:0] phi_in_phi_5;
	reg [31:0] phi_last_block_phi_5;
	reg [63:0] phi_s_phi_5;
	wire [31:0] phi_out_phi_5;
	phi #(.NB_PAIR(2), .WIDTH(32)) phi_5(.in(phi_in_phi_5), .last_block(phi_last_block_phi_5), .out(phi_out_phi_5), .s(phi_s_phi_5));

	reg [31:0] add_in0_add_12;
	reg [31:0] add_in1_add_12;
	wire [31:0] add_out_add_12;
	add #(.WIDTH(32)) add_add_12(.in0(add_in0_add_12), .in1(add_in1_add_12), .out(add_out_add_12));

	reg [31:0] add_in0_add_7;
	reg [31:0] add_in1_add_7;
	wire [31:0] add_out_add_7;
	add #(.WIDTH(32)) add_add_7(.in0(add_in0_add_7), .in1(add_in1_add_7), .out(add_out_add_7));

	reg [31:0] cmp_in0_icmp_8;
	reg [31:0] cmp_in1_icmp_8;
	wire [0:0] cmp_out_icmp_8;
	eq #(.WIDTH(32)) icmp_8(.in0(cmp_in0_icmp_8), .in1(cmp_in1_icmp_8), .out(cmp_out_icmp_8));

	add call_10();

	add call_19();

	reg [0:0] bb_0_active_in_data;
	wire [0:0] bb_0_active_out_data;
	hls_wire #(.WIDTH(1)) bb_0_active(.in_data(bb_0_active_in_data), .out_data(bb_0_active_out_data));

	reg [31:0] eq_0_in0;
	reg [31:0] eq_0_in1;
	wire [0:0] eq_0_out;
	eq #(.WIDTH(32)) eq_0(.in0(eq_0_in0), .in1(eq_0_in1), .out(eq_0_out));

	reg [0:0] bb_1_active_in_data;
	wire [0:0] bb_1_active_out_data;
	hls_wire #(.WIDTH(1)) bb_1_active(.in_data(bb_1_active_in_data), .out_data(bb_1_active_out_data));

	reg [31:0] eq_1_in0;
	reg [31:0] eq_1_in1;
	wire [0:0] eq_1_out;
	eq #(.WIDTH(32)) eq_1(.in0(eq_1_in0), .in1(eq_1_in1), .out(eq_1_out));

	reg [0:0] bb_2_active_in_data;
	wire [0:0] bb_2_active_out_data;
	hls_wire #(.WIDTH(1)) bb_2_active(.in_data(bb_2_active_in_data), .out_data(bb_2_active_out_data));

	reg [31:0] eq_2_in0;
	reg [31:0] eq_2_in1;
	wire [0:0] eq_2_out;
	eq #(.WIDTH(32)) eq_2(.in0(eq_2_in0), .in1(eq_2_in1), .out(eq_2_out));

	// End Functional Units

	reg [31:0] add_tmp_2;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_3;
	reg [31:0] last_BB_reg;
	reg [31:0] load_tmp_1;

	// controller for add_add_12.add_in0_add_12
	// controller for add_add_12.add_in1_add_12
	// Insensitive connections
	always @(*) begin
		add_in0_add_12 = valid ? load_tmp_1 : load_tmp_1;
		add_in1_add_12 = valid ? in_out_data : in_out_data;
	end
	// controller for add_add_7.add_in0_add_7
	// controller for add_add_7.add_in1_add_7
	// Insensitive connections
	always @(*) begin
		add_in0_add_7 = valid ? phi_out_phi_5 : phi_out_phi_5;
		add_in1_add_7 = valid ? (32'd1) : (32'd1);
	end
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_0_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_1_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_2_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_0_in0 = 32'd0;
		end else begin
			eq_0_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_0_in1 = global_next_block;
		end else begin
			eq_0_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_1_in0 = 32'd1;
		end else begin
			eq_1_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_1_in1 = global_next_block;
		end else begin
			eq_1_in1 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_2_in0 = 32'd2;
		end else begin
			eq_2_in0 = 0;
		end
	end
	always @(*) begin
		if (1'd1) begin 
			eq_2_in1 = global_next_block;
		end else begin
			eq_2_in1 = 0;
		end
	end
	// controller for icmp_8.cmp_in0_icmp_8
	// controller for icmp_8.cmp_in1_icmp_8
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_8 = valid ? add_out_add_7 : add_out_add_7;
		cmp_in1_icmp_8 = valid ? (32'd4) : (32'd4);
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
	// controller for phi_5.phi_in_phi_5
	// controller for phi_5.phi_last_block_phi_5
	// controller for phi_5.phi_s_phi_5
	// Insensitive connections
	always @(*) begin
		phi_in_phi_5 = valid ? {(32'd0), add_tmp_2} : {(32'd0), add_tmp_2};
		phi_last_block_phi_5 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_5 = valid ? {32'd0, 32'd2} : {32'd0, 32'd2};
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
				wdata_ram_0_reg = add_out_add_12;
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
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_2 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				add_tmp_2 <= add_out_add_7;
			end
		end
	end

	always @(posedge clk) begin
		if (rst) begin
			global_next_block <= 0;
		end else begin
		end
	end

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
			if ((global_state == 5) && !(icmp_tmp_3)) begin
				global_state <= 2;
			end
			if ((global_state == 5) && (icmp_tmp_3)) begin
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

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_3 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				icmp_tmp_3 <= cmp_out_icmp_8;
			end
		end
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
			load_tmp_1 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				load_tmp_1 <= rdata_ram_0;
			end
		end
	end

endmodule

