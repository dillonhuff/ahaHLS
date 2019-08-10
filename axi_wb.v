module axi_wb_inner(input [0:0] clk, input [0:0] rst, output [15:0] arg_3_s_axi_araddr, output [1:0] arg_3_s_axi_arburst, output [7:0] arg_3_s_axi_arlen, output [2:0] arg_3_s_axi_arsize, output [0:0] arg_3_s_axi_arvalid, output [15:0] arg_3_s_axi_awaddr, output [1:0] arg_3_s_axi_awburst, output [7:0] arg_3_s_axi_awlen, output [2:0] arg_3_s_axi_awsize, output [0:0] arg_3_s_axi_awvalid, output [0:0] arg_3_s_axi_bready, output [0:0] arg_3_s_axi_rready, output [31:0] arg_3_s_axi_wdata, output [3:0] arg_3_s_axi_wstrb, output [0:0] arg_3_s_axi_wvalid, input [0:0] arg_3_s_axi_arready, input [0:0] arg_3_s_axi_awready, input [0:0] arg_3_s_axi_bvalid, input [31:0] arg_3_s_axi_rdata, input [0:0] arg_3_s_axi_rvalid, input [0:0] arg_3_s_axi_wready, output [31:0] arg_0_in_data, output [0:0] arg_0_read_valid, output [0:0] arg_0_write_valid, input [31:0] arg_0_out_data, input [0:0] arg_0_read_ready, input [0:0] arg_0_write_ready, output [0:0] valid, output [7:0] arg_1_raddr, output [7:0] arg_1_waddr, output [7:0] arg_1_wdata, output [0:0] arg_1_wen, input [7:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata);

	reg [15:0] arg_3_s_axi_araddr_reg;
	reg [1:0] arg_3_s_axi_arburst_reg;
	reg [7:0] arg_3_s_axi_arlen_reg;
	reg [2:0] arg_3_s_axi_arsize_reg;
	reg [0:0] arg_3_s_axi_arvalid_reg;
	reg [15:0] arg_3_s_axi_awaddr_reg;
	reg [1:0] arg_3_s_axi_awburst_reg;
	reg [7:0] arg_3_s_axi_awlen_reg;
	reg [2:0] arg_3_s_axi_awsize_reg;
	reg [0:0] arg_3_s_axi_awvalid_reg;
	reg [0:0] arg_3_s_axi_bready_reg;
	reg [0:0] arg_3_s_axi_rready_reg;
	reg [31:0] arg_3_s_axi_wdata_reg;
	reg [3:0] arg_3_s_axi_wstrb_reg;
	reg [0:0] arg_3_s_axi_wvalid_reg;
	reg [31:0] arg_0_in_data_reg;
	reg [0:0] arg_0_read_valid_reg;
	reg [0:0] arg_0_write_valid_reg;
	reg [0:0] valid_reg;
	reg [7:0] arg_1_raddr_reg;
	reg [7:0] arg_1_waddr_reg;
	reg [7:0] arg_1_wdata_reg;
	reg [0:0] arg_1_wen_reg;
	reg [15:0] arg_2_raddr_reg;
	reg [15:0] arg_2_waddr_reg;
	reg [15:0] arg_2_wdata_reg;
	reg [0:0] arg_2_wen_reg;

	assign arg_3_s_axi_araddr = arg_3_s_axi_araddr_reg;
	assign arg_3_s_axi_arburst = arg_3_s_axi_arburst_reg;
	assign arg_3_s_axi_arlen = arg_3_s_axi_arlen_reg;
	assign arg_3_s_axi_arsize = arg_3_s_axi_arsize_reg;
	assign arg_3_s_axi_arvalid = arg_3_s_axi_arvalid_reg;
	assign arg_3_s_axi_awaddr = arg_3_s_axi_awaddr_reg;
	assign arg_3_s_axi_awburst = arg_3_s_axi_awburst_reg;
	assign arg_3_s_axi_awlen = arg_3_s_axi_awlen_reg;
	assign arg_3_s_axi_awsize = arg_3_s_axi_awsize_reg;
	assign arg_3_s_axi_awvalid = arg_3_s_axi_awvalid_reg;
	assign arg_3_s_axi_bready = arg_3_s_axi_bready_reg;
	assign arg_3_s_axi_rready = arg_3_s_axi_rready_reg;
	assign arg_3_s_axi_wdata = arg_3_s_axi_wdata_reg;
	assign arg_3_s_axi_wstrb = arg_3_s_axi_wstrb_reg;
	assign arg_3_s_axi_wvalid = arg_3_s_axi_wvalid_reg;
	assign arg_0_in_data = arg_0_in_data_reg;
	assign arg_0_read_valid = arg_0_read_valid_reg;
	assign arg_0_write_valid = arg_0_write_valid_reg;
	assign valid = valid_reg;
	assign arg_1_raddr = arg_1_raddr_reg;
	assign arg_1_waddr = arg_1_waddr_reg;
	assign arg_1_wdata = arg_1_wdata_reg;
	assign arg_1_wen = arg_1_wen_reg;
	assign arg_2_raddr = arg_2_raddr_reg;
	assign arg_2_waddr = arg_2_waddr_reg;
	assign arg_2_wdata = arg_2_wdata_reg;
	assign arg_2_wen = arg_2_wen_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_3();

	add call_11();

	add call_13();

	reg [15:0] phi_in_phi_14;
	reg [31:0] phi_last_block_phi_14;
	reg [63:0] phi_s_phi_14;
	wire [31:0] phi_out_phi_14;
	phi #(.NB_PAIR(2), .WIDTH(8)) phi_14(.in(phi_in_phi_14), .last_block(phi_last_block_phi_14), .out(phi_out_phi_14), .s(phi_s_phi_14));

	add call_27();

	reg [31:0] sgt_in0_sext_16;
	wire [63:0] sgt_out_sext_16;
	sext sext_16(.in(sgt_in0_sext_16), .out(sgt_out_sext_16));

	reg [31:0] add_in0_add_17;
	reg [31:0] add_in1_add_17;
	wire [31:0] add_out_add_17;
	add #(.WIDTH(32)) add_add_17(.in0(add_in0_add_17), .in1(add_in1_add_17), .out(add_out_add_17));

	reg [7:0] cmp_in0_icmp_24;
	reg [7:0] cmp_in1_icmp_24;
	wire [0:0] cmp_out_icmp_24;
	slt #(.WIDTH(8)) icmp_24(.in0(cmp_in0_icmp_24), .in1(cmp_in1_icmp_24), .out(cmp_out_icmp_24));

	br_dummy br_unit();

	reg [31:0] trunc_in_trunc_18;
	wire [7:0] trunc_out_trunc_18;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_18(.in(trunc_in_trunc_18), .out(trunc_out_trunc_18));

	// End Functional Units

	// Start instruction result storage
	reg [7:0] trunc_tmp_8;
	reg [7:0] load_tmp_1;
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
			end
			if ((global_state == 4)) begin
					last_BB_reg <= 1;
			end
			if ((global_state == 5)) begin
			end
			if ((global_state == 6)) begin
			end
			if ((global_state == 7)) begin
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
				if (arg_3_s_axi_awready) begin 
					global_state <= 1;
				end
				end
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_0_read_ready && arg_3_s_axi_wready) begin 
					global_state <= 2;
				end
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
				// Condition = (  %10 = icmp slt i8 %9, %0)
				if ((cmp_out_icmp_24)) begin
					global_state <= 1;
				end
				// Condition = (!(  %10 = icmp slt i8 %9, %0))
				if (!(cmp_out_icmp_24)) begin
					global_state <= 5;
				end
			end
			if ((global_state == 5)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_3_s_axi_wready) begin 
					global_state <= 6;
				end
				end
			end
			if ((global_state == 6)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 7;
				end
			end
			if ((global_state == 7)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 7;
				end
			end

			// Temporary storage code
			if ((global_state == 0)) begin 
				// Temporary storage
				if (arg_3_s_axi_awready) begin
				// Store data computed at the stage
					load_tmp_1 <= arg_1_rdata;
				end
			end
			if ((global_state == 1)) begin 
				// Temporary storage
				if (arg_0_read_ready && arg_3_s_axi_wready) begin
				// Store data computed at the stage
					trunc_tmp_8 <= trunc_out_trunc_18;
				end
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
			end
			if ((global_state == 5)) begin 
				// Temporary storage
				if (arg_3_s_axi_wready) begin
				// Store data computed at the stage
				end
			end
			if ((global_state == 6)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 7)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for arg_3.arg_3_s_axi_awaddr_reg
	// controller for arg_3.arg_3_s_axi_awburst_reg
	// controller for arg_3.arg_3_s_axi_awlen_reg
	// controller for arg_3.arg_3_s_axi_awsize_reg
	// controller for arg_3.arg_3_s_axi_awvalid_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (arg_3_s_axi_awready) begin
				arg_3_s_axi_awvalid_reg = (32'd1);
			end else begin
				arg_3_s_axi_awvalid_reg = 0;
			end
		end else begin
			arg_3_s_axi_awvalid_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_axi_wdata_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			if (1) begin
				arg_3_s_axi_wdata_reg = arg_0_out_data;
			end else begin
				arg_3_s_axi_wdata_reg = 0;
			end
		end else if ((global_state == 6)) begin 
			if (1) begin
				arg_3_s_axi_wdata_reg = (32'd0);
			end else begin
				arg_3_s_axi_wdata_reg = 0;
			end
		end else begin
			arg_3_s_axi_wdata_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_axi_wstrb_reg
	always @(*) begin
		if ((global_state == 3)) begin 
			if (1) begin
				arg_3_s_axi_wstrb_reg = -(4'd1);
			end else begin
				arg_3_s_axi_wstrb_reg = 0;
			end
		end else if ((global_state == 6)) begin 
			if (1) begin
				arg_3_s_axi_wstrb_reg = (32'd0);
			end else begin
				arg_3_s_axi_wstrb_reg = 0;
			end
		end else begin
			arg_3_s_axi_wstrb_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_axi_wvalid_reg
	always @(*) begin
		if ((global_state == 0)) begin 
			if (arg_3_s_axi_awready) begin
				arg_3_s_axi_wvalid_reg = (32'd1);
			end else begin
				arg_3_s_axi_wvalid_reg = 0;
			end
		end else if ((global_state == 3)) begin 
			if (1) begin
				arg_3_s_axi_wvalid_reg = (32'd1);
			end else begin
				arg_3_s_axi_wvalid_reg = 0;
			end
		end else if ((global_state == 6)) begin 
			if (1) begin
				arg_3_s_axi_wvalid_reg = (32'd1);
			end else begin
				arg_3_s_axi_wvalid_reg = 0;
			end
		end else begin
			arg_3_s_axi_wvalid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
		arg_3_s_axi_awaddr_reg = valid ? arg_2_rdata : arg_2_rdata;
		arg_3_s_axi_awburst_reg = valid ? (2'd1) : (2'd1);
		arg_3_s_axi_awlen_reg = valid ? arg_1_rdata : arg_1_rdata;
		arg_3_s_axi_awsize_reg = valid ? -(3'd3) : -(3'd3);
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for arg_1.arg_1_raddr_reg
	// Insensitive connections
	always @(*) begin
		arg_1_raddr_reg = valid ? arg_1_rdata : arg_1_rdata;
	end
	// controller for arg_2.arg_2_raddr_reg
	// Insensitive connections
	always @(*) begin
		arg_2_raddr_reg = valid ? arg_2_rdata : arg_2_rdata;
	end
	// Insensitive connections
	always @(*) begin
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for phi_14.phi_in_phi_14
	// controller for phi_14.phi_last_block_phi_14
	// controller for phi_14.phi_s_phi_14
	// Insensitive connections
	always @(*) begin
		phi_in_phi_14 = valid ? {trunc_tmp_8, (8'd0)} : {trunc_tmp_8, (8'd0)};
		phi_last_block_phi_14 = valid ? last_BB_reg : last_BB_reg;
		phi_s_phi_14 = valid ? {32'd1, 32'd0} : {32'd1, 32'd0};
	end
	// controller for arg_0.arg_0_read_valid_reg
	always @(*) begin
		if ((global_state == 2)) begin 
			if (1) begin
				arg_0_read_valid_reg = (32'd1);
			end else begin
				arg_0_read_valid_reg = 0;
			end
		end else begin
			arg_0_read_valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for sext_16.sgt_in0_sext_16
	// Insensitive connections
	always @(*) begin
		sgt_in0_sext_16 = valid ? phi_out_phi_14 : phi_out_phi_14;
	end
	// controller for add_add_17.add_in0_add_17
	// controller for add_add_17.add_in1_add_17
	// Insensitive connections
	always @(*) begin
		add_in0_add_17 = valid ? sgt_out_sext_16 : sgt_out_sext_16;
		add_in1_add_17 = valid ? (32'd1) : (32'd1);
	end
	// controller for trunc_18.trunc_in_trunc_18
	// Insensitive connections
	always @(*) begin
		trunc_in_trunc_18 = valid ? add_out_add_17 : add_out_add_17;
	end
	// controller for icmp_24.cmp_in0_icmp_24
	// controller for icmp_24.cmp_in1_icmp_24
	// Insensitive connections
	always @(*) begin
		cmp_in0_icmp_24 = valid ? trunc_tmp_8 : trunc_tmp_8;
		cmp_in1_icmp_24 = valid ? load_tmp_1 : load_tmp_1;
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for ret_31.valid_reg
	always @(*) begin
		if ((global_state == 7)) begin 
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

module axi_wb(input [0:0] clk, input [0:0] rst, output [15:0] arg_3_s_axi_araddr, output [1:0] arg_3_s_axi_arburst, output [7:0] arg_3_s_axi_arlen, output [2:0] arg_3_s_axi_arsize, output [0:0] arg_3_s_axi_arvalid, output [15:0] arg_3_s_axi_awaddr, output [1:0] arg_3_s_axi_awburst, output [7:0] arg_3_s_axi_awlen, output [2:0] arg_3_s_axi_awsize, output [0:0] arg_3_s_axi_awvalid, output [0:0] arg_3_s_axi_bready, output [0:0] arg_3_s_axi_rready, output [31:0] arg_3_s_axi_wdata, output [3:0] arg_3_s_axi_wstrb, output [0:0] arg_3_s_axi_wvalid, input [0:0] arg_3_s_axi_arready, input [0:0] arg_3_s_axi_awready, input [0:0] arg_3_s_axi_bvalid, input [31:0] arg_3_s_axi_rdata, input [0:0] arg_3_s_axi_rvalid, input [0:0] arg_3_s_axi_wready, output [31:0] arg_0_in_data, output [0:0] arg_0_read_valid, output [0:0] arg_0_write_valid, input [31:0] arg_0_out_data, input [0:0] arg_0_read_ready, input [0:0] arg_0_write_ready, output [0:0] valid, output [7:0] arg_1_raddr, output [7:0] arg_1_waddr, output [7:0] arg_1_wdata, output [0:0] arg_1_wen, input [7:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata);


	initial begin
	end




	axi_wb_inner inner(.arg_0_in_data(arg_0_in_data), .arg_0_out_data(arg_0_out_data), .arg_0_read_ready(arg_0_read_ready), .arg_0_read_valid(arg_0_read_valid), .arg_0_write_ready(arg_0_write_ready), .arg_0_write_valid(arg_0_write_valid), .arg_1_raddr(arg_1_raddr), .arg_1_rdata(arg_1_rdata), .arg_1_waddr(arg_1_waddr), .arg_1_wdata(arg_1_wdata), .arg_1_wen(arg_1_wen), .arg_2_raddr(arg_2_raddr), .arg_2_rdata(arg_2_rdata), .arg_2_waddr(arg_2_waddr), .arg_2_wdata(arg_2_wdata), .arg_2_wen(arg_2_wen), .arg_3_s_axi_araddr(arg_3_s_axi_araddr), .arg_3_s_axi_arburst(arg_3_s_axi_arburst), .arg_3_s_axi_arlen(arg_3_s_axi_arlen), .arg_3_s_axi_arready(arg_3_s_axi_arready), .arg_3_s_axi_arsize(arg_3_s_axi_arsize), .arg_3_s_axi_arvalid(arg_3_s_axi_arvalid), .arg_3_s_axi_awaddr(arg_3_s_axi_awaddr), .arg_3_s_axi_awburst(arg_3_s_axi_awburst), .arg_3_s_axi_awlen(arg_3_s_axi_awlen), .arg_3_s_axi_awready(arg_3_s_axi_awready), .arg_3_s_axi_awsize(arg_3_s_axi_awsize), .arg_3_s_axi_awvalid(arg_3_s_axi_awvalid), .arg_3_s_axi_bready(arg_3_s_axi_bready), .arg_3_s_axi_bvalid(arg_3_s_axi_bvalid), .arg_3_s_axi_rdata(arg_3_s_axi_rdata), .arg_3_s_axi_rready(arg_3_s_axi_rready), .arg_3_s_axi_rvalid(arg_3_s_axi_rvalid), .arg_3_s_axi_wdata(arg_3_s_axi_wdata), .arg_3_s_axi_wready(arg_3_s_axi_wready), .arg_3_s_axi_wstrb(arg_3_s_axi_wstrb), .arg_3_s_axi_wvalid(arg_3_s_axi_wvalid), .clk(clk), .rst(rst), .valid(valid));

endmodule
