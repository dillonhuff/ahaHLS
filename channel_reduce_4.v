module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [0:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [0:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);

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
	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [31:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [31:0] rdata_ram_0;
	register #(.WIDTH(32)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add call_18();

	add call_6();

	add alloca_0();

	add bitcast_1();

	add call_2();

	br_dummy br_unit();

	add call_19();

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

	reg [31:0] add_tmp_3;
	reg [31:0] global_next_block;
	reg [31:0] global_state;
	reg [0:0] icmp_tmp_4;
	reg [31:0] last_BB_reg;
	reg [31:0] load_tmp_2;

	// controller for add_add_14.add_in0_add_14
	// controller for add_add_14.add_in1_add_14
	// Insensitive connections
	always @(*) begin
		add_in0_add_14 = valid ? load_tmp_2 : load_tmp_2;
		add_in1_add_14 = valid ? in_out_data : in_out_data;
	end
	// controller for add_add_9.add_in0_add_9
	// controller for add_add_9.add_in1_add_9
	// Insensitive connections
	always @(*) begin
		add_in0_add_9 = valid ? phi_out_phi_7 : phi_out_phi_7;
		add_in1_add_9 = valid ? (32'd1) : (32'd1);
	end
	// controller for bb_0_active.bb_0_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_0_active_in_data = eq_0_out;
		end else begin
			bb_0_active_in_data = 0;
		end
	end
	// controller for bb_1_active.bb_1_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_1_active_in_data = eq_1_out;
		end else begin
			bb_1_active_in_data = 0;
		end
	end
	// controller for bb_2_active.bb_2_active_in_data
	always @(*) begin
		if (1'd1) begin 
			bb_2_active_in_data = eq_2_out;
		end else begin
			bb_2_active_in_data = 0;
		end
	end
	// controller for eq_0.eq_0_in0
	// controller for eq_0.eq_0_in1
	// Insensitive connections
	always @(*) begin
		eq_0_in0 = valid ? 32'd0 : 32'd0;
		eq_0_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_1.eq_1_in0
	// controller for eq_1.eq_1_in1
	// Insensitive connections
	always @(*) begin
		eq_1_in0 = valid ? 32'd1 : 32'd1;
		eq_1_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for eq_2.eq_2_in0
	// controller for eq_2.eq_2_in1
	// Insensitive connections
	always @(*) begin
		eq_2_in0 = valid ? 32'd2 : 32'd2;
		eq_2_in1 = valid ? global_next_block : global_next_block;
	end
	// controller for icmp_10.cmp_in0_icmp_10
	// controller for icmp_10.cmp_in1_icmp_10
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_10 = valid ? add_out_add_9 : add_out_add_9;
		cmp_in1_icmp_10 = valid ? (32'd4) : (32'd4);
	end
	// controller for in.in_read_valid_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			in_read_valid_reg = -(1'd1);
		end else if ((global_state == 4)) begin 
			in_read_valid_reg = (1'd0);
		end else begin
			in_read_valid_reg = 0;
		end
	end
	// controller for out.out_in_data_reg
	// controller for out.out_write_valid_reg
	always @(*) begin
		if ((global_state == 7)) begin 
			out_write_valid_reg = -(1'd1);
		end else if ((global_state == 8)) begin 
			out_write_valid_reg = (1'd0);
		end else begin
			out_write_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		out_in_data_reg = valid ? rdata_ram_0 : rdata_ram_0;
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
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if ((global_state == 2) && in_read_ready) begin 
			raddr_ram_0_reg = 0;
		end else if ((global_state == 7)) begin 
			raddr_ram_0_reg = 0;
		end else begin
			raddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.waddr_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			waddr_ram_0_reg = 0;
		end else if ((global_state == 4)) begin 
			waddr_ram_0_reg = 0;
		end else begin
			waddr_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wdata_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			wdata_ram_0_reg = (32'd0);
		end else if ((global_state == 4)) begin 
			wdata_ram_0_reg = add_out_add_14;
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			wen_ram_0_reg = 1;
		end else if ((global_state == 4)) begin 
			wen_ram_0_reg = 1;
		end else begin
			wen_ram_0_reg = 0;
		end
	end
	// controller for ret_24.valid_reg
	always @(*) begin
		if ((global_state == 8)) begin 
			valid_reg = 1;
		end else begin
			valid_reg = 0;
		end
	end
	// Register controllers
	always @(posedge clk) begin
		if (rst) begin
			add_tmp_3 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				add_tmp_3 <= add_out_add_9;
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

	always @(posedge clk) begin
		if (rst) begin
			icmp_tmp_4 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				icmp_tmp_4 <= cmp_out_icmp_10;
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
			load_tmp_2 <= 0;
		end else begin
			if ((global_state == 2) && in_read_ready) begin
				load_tmp_2 <= rdata_ram_0;
			end
		end
	end

endmodule

