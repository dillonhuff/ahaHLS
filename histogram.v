module histogram_inner(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [7:0] arg_1_debug_addr, output [7:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [7:0] arg_1_raddr_0, output [7:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0, input [31:0] arg_1_debug_data, input [31:0] arg_1_rdata_0, output [11:0] arg_0_debug_addr, output [11:0] arg_0_debug_write_addr, output [7:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [11:0] arg_0_raddr_0, output [11:0] arg_0_waddr_0, output [7:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [7:0] arg_0_debug_data, input [7:0] arg_0_rdata_0);

	reg [0:0] valid_reg;
	reg [7:0] arg_1_debug_addr_reg;
	reg [7:0] arg_1_debug_write_addr_reg;
	reg [31:0] arg_1_debug_write_data_reg;
	reg [0:0] arg_1_debug_write_en_reg;
	reg [7:0] arg_1_raddr_0_reg;
	reg [7:0] arg_1_waddr_0_reg;
	reg [31:0] arg_1_wdata_0_reg;
	reg [0:0] arg_1_wen_0_reg;
	reg [11:0] arg_0_debug_addr_reg;
	reg [11:0] arg_0_debug_write_addr_reg;
	reg [7:0] arg_0_debug_write_data_reg;
	reg [0:0] arg_0_debug_write_en_reg;
	reg [11:0] arg_0_raddr_0_reg;
	reg [11:0] arg_0_waddr_0_reg;
	reg [7:0] arg_0_wdata_0_reg;
	reg [0:0] arg_0_wen_0_reg;

	assign valid = valid_reg;
	assign arg_1_debug_addr = arg_1_debug_addr_reg;
	assign arg_1_debug_write_addr = arg_1_debug_write_addr_reg;
	assign arg_1_debug_write_data = arg_1_debug_write_data_reg;
	assign arg_1_debug_write_en = arg_1_debug_write_en_reg;
	assign arg_1_raddr_0 = arg_1_raddr_0_reg;
	assign arg_1_waddr_0 = arg_1_waddr_0_reg;
	assign arg_1_wdata_0 = arg_1_wdata_0_reg;
	assign arg_1_wen_0 = arg_1_wen_0_reg;
	assign arg_0_debug_addr = arg_0_debug_addr_reg;
	assign arg_0_debug_write_addr = arg_0_debug_write_addr_reg;
	assign arg_0_debug_write_data = arg_0_debug_write_data_reg;
	assign arg_0_debug_write_en = arg_0_debug_write_en_reg;
	assign arg_0_raddr_0 = arg_0_raddr_0_reg;
	assign arg_0_waddr_0 = arg_0_waddr_0_reg;
	assign arg_0_wdata_0 = arg_0_wdata_0_reg;
	assign arg_0_wen_0 = arg_0_wen_0_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	reg [31:0] sgt_in0_sext_1;
	wire [63:0] sgt_out_sext_1;
	sext sext_1(.in(sgt_in0_sext_1), .out(sgt_out_sext_1));

	reg [31:0] add_in0_add_2;
	reg [31:0] add_in1_add_2;
	wire [31:0] add_out_add_2;
	add #(.WIDTH(32)) add_add_2(.in0(add_in0_add_2), .in1(add_in1_add_2), .out(add_out_add_2));

	reg [31:0] sgt_in0_sext_17;
	wire [63:0] sgt_out_sext_17;
	sext sext_17(.in(sgt_in0_sext_17), .out(sgt_out_sext_17));

	reg [31:0] cmp_in0_icmp_18;
	reg [31:0] cmp_in1_icmp_18;
	wire [0:0] cmp_out_icmp_18;
	slt #(.WIDTH(32)) icmp_18(.in0(cmp_in0_icmp_18), .in1(cmp_in1_icmp_18), .out(cmp_out_icmp_18));

	br_dummy br_unit();

	add alloca_3();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [7:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [7:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(8)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	reg [31:0] add_in0_add_6;
	reg [31:0] add_in1_add_6;
	wire [31:0] add_out_add_6;
	add #(.WIDTH(32)) add_add_6(.in0(add_in0_add_6), .in1(add_in1_add_6), .out(add_out_add_6));

	reg [31:0] trunc_in_trunc_7;
	wire [7:0] trunc_out_trunc_7;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_7(.in(trunc_in_trunc_7), .out(trunc_out_trunc_7));

	reg [31:0] trunc_in_trunc_12;
	wire [7:0] trunc_out_trunc_12;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_12(.in(trunc_in_trunc_12), .out(trunc_out_trunc_12));

	reg [15:0] phi_in_phi_16;
	reg [31:0] phi_last_block_phi_16;
	reg [63:0] phi_s_phi_16;
	wire [31:0] phi_out_phi_16;
	phi #(.NB_PAIR(2), .WIDTH(8)) phi_16(.in(phi_in_phi_16), .last_block(phi_last_block_phi_16), .out(phi_out_phi_16), .s(phi_s_phi_16));

	// End Functional Units

	// Start instruction result storage
	reg [7:0] trunc_tmp_3;
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
					last_BB_reg <= 1;
			end
			if ((global_state == 3)) begin
					last_BB_reg <= 2;
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
				// Condition = (  %11 = icmp slt i32 %10, 100)
				if ((cmp_out_icmp_18)) begin
					global_state <= 1;
				end
				// Condition = (!(  %11 = icmp slt i32 %10, 100))
				if (!(cmp_out_icmp_18)) begin
					global_state <= 3;
				end
			end
			if ((global_state == 3)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 3;
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
					trunc_tmp_3 <= trunc_out_trunc_7;
			end
			if ((global_state == 2)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 3)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for sext_1.sgt_in0_sext_1
	// Insensitive connections
	always @(*) begin
		sgt_in0_sext_1 = valid ? phi_out_phi_16 : phi_out_phi_16;
	end
	// controller for add_add_2.add_in0_add_2
	// controller for add_add_2.add_in1_add_2
	// Insensitive connections
	always @(*) begin
		add_in0_add_2 = valid ? sgt_out_sext_1 : sgt_out_sext_1;
		add_in1_add_2 = valid ? (32'd1) : (32'd1);
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for ram_0.raddr_ram_0_reg
	always @(*) begin
		if ((global_state == 1)) begin 
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
		if ((global_state == 1)) begin 
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
		if ((global_state == 1)) begin 
			if (1) begin
				wdata_ram_0_reg = phi_out_phi_16;
			end else begin
				wdata_ram_0_reg = 0;
			end
		end else begin
			wdata_ram_0_reg = 0;
		end
	end
	// controller for ram_0.wen_ram_0_reg
	always @(*) begin
		if ((global_state == 1)) begin 
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
	// controller for arg_1.arg_1_raddr_0_reg
	// controller for arg_1.arg_1_waddr_0_reg
	// controller for arg_1.arg_1_wdata_0_reg
	// controller for arg_1.arg_1_wen_0_reg
	// Insensitive connections
	always @(*) begin
		arg_1_raddr_0_reg = valid ? trunc_out_trunc_12 : trunc_out_trunc_12;
		arg_1_waddr_0_reg = valid ? trunc_out_trunc_12 : trunc_out_trunc_12;
		arg_1_wdata_0_reg = valid ? add_out_add_6 : add_out_add_6;
		arg_1_wen_0_reg = valid ? (32'd1) : (32'd1);
	end
	// controller for add_add_6.add_in0_add_6
	// controller for add_add_6.add_in1_add_6
	// Insensitive connections
	always @(*) begin
		add_in0_add_6 = valid ? arg_1_rdata_0 : arg_1_rdata_0;
		add_in1_add_6 = valid ? (32'd1) : (32'd1);
	end
	// controller for trunc_7.trunc_in_trunc_7
	// Insensitive connections
	always @(*) begin
		trunc_in_trunc_7 = valid ? add_out_add_2 : add_out_add_2;
	end
	// controller for arg_0.arg_0_raddr_0_reg
	// Insensitive connections
	always @(*) begin
		arg_0_raddr_0_reg = valid ? rdata_ram_0 : rdata_ram_0;
	end
	// controller for trunc_12.trunc_in_trunc_12
	// Insensitive connections
	always @(*) begin
		trunc_in_trunc_12 = valid ? arg_0_rdata_0 : arg_0_rdata_0;
	end
	// controller for phi_16.phi_in_phi_16
	// controller for phi_16.phi_last_block_phi_16
	// controller for phi_16.phi_s_phi_16
	// Insensitive connections
	always @(*) begin
		phi_in_phi_16 = valid ? {trunc_tmp_3, (8'd0)} : {trunc_tmp_3, (8'd0)};
		phi_last_block_phi_16 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_16 = valid ? {32'd1, 32'd0} : {32'd1, 32'd0};
	end
	// controller for sext_17.sgt_in0_sext_17
	// Insensitive connections
	always @(*) begin
		sgt_in0_sext_17 = valid ? trunc_tmp_3 : trunc_tmp_3;
	end
	// controller for icmp_18.cmp_in0_icmp_18
	// controller for icmp_18.cmp_in1_icmp_18
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_18 = valid ? sgt_out_sext_17 : sgt_out_sext_17;
		cmp_in1_icmp_18 = valid ? (32'd100) : (32'd100);
	end
	// controller for ret_20.valid_reg
	always @(*) begin
		if ((global_state == 3)) begin 
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

module histogram(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [7:0] arg_1_debug_addr, output [7:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [7:0] arg_1_raddr_0, output [7:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0, input [31:0] arg_1_debug_data, input [31:0] arg_1_rdata_0, output [11:0] arg_0_debug_addr, output [11:0] arg_0_debug_write_addr, output [7:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [11:0] arg_0_raddr_0, output [11:0] arg_0_waddr_0, output [7:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [7:0] arg_0_debug_data, input [7:0] arg_0_rdata_0);


	initial begin
	end




	histogram_inner inner(.arg_0_debug_addr(arg_0_debug_addr), .arg_0_debug_data(arg_0_debug_data), .arg_0_debug_write_addr(arg_0_debug_write_addr), .arg_0_debug_write_data(arg_0_debug_write_data), .arg_0_debug_write_en(arg_0_debug_write_en), .arg_0_raddr_0(arg_0_raddr_0), .arg_0_rdata_0(arg_0_rdata_0), .arg_0_waddr_0(arg_0_waddr_0), .arg_0_wdata_0(arg_0_wdata_0), .arg_0_wen_0(arg_0_wen_0), .arg_1_debug_addr(arg_1_debug_addr), .arg_1_debug_data(arg_1_debug_data), .arg_1_debug_write_addr(arg_1_debug_write_addr), .arg_1_debug_write_data(arg_1_debug_write_data), .arg_1_debug_write_en(arg_1_debug_write_en), .arg_1_raddr_0(arg_1_raddr_0), .arg_1_rdata_0(arg_1_rdata_0), .arg_1_waddr_0(arg_1_waddr_0), .arg_1_wdata_0(arg_1_wdata_0), .arg_1_wen_0(arg_1_wen_0), .clk(clk), .rst(rst), .valid(valid));

endmodule
