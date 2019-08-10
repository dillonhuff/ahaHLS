module histogram_inner(input [0:0] clk, input [0:0] rst, output [7:0] arg_1_debug_addr, output [7:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [7:0] arg_1_raddr_0, output [7:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0, input [31:0] arg_1_debug_data, input [31:0] arg_1_rdata_0, output [0:0] valid, output [11:0] arg_0_debug_addr, output [11:0] arg_0_debug_write_addr, output [7:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [11:0] arg_0_raddr_0, output [11:0] arg_0_waddr_0, output [7:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [7:0] arg_0_debug_data, input [7:0] arg_0_rdata_0);

	reg [7:0] arg_1_debug_addr_reg;
	reg [7:0] arg_1_debug_write_addr_reg;
	reg [31:0] arg_1_debug_write_data_reg;
	reg [0:0] arg_1_debug_write_en_reg;
	reg [7:0] arg_1_raddr_0_reg;
	reg [7:0] arg_1_waddr_0_reg;
	reg [31:0] arg_1_wdata_0_reg;
	reg [0:0] arg_1_wen_0_reg;
	reg [0:0] valid_reg;
	reg [11:0] arg_0_debug_addr_reg;
	reg [11:0] arg_0_debug_write_addr_reg;
	reg [7:0] arg_0_debug_write_data_reg;
	reg [0:0] arg_0_debug_write_en_reg;
	reg [11:0] arg_0_raddr_0_reg;
	reg [11:0] arg_0_waddr_0_reg;
	reg [7:0] arg_0_wdata_0_reg;
	reg [0:0] arg_0_wen_0_reg;

	assign arg_1_debug_addr = arg_1_debug_addr_reg;
	assign arg_1_debug_write_addr = arg_1_debug_write_addr_reg;
	assign arg_1_debug_write_data = arg_1_debug_write_data_reg;
	assign arg_1_debug_write_en = arg_1_debug_write_en_reg;
	assign arg_1_raddr_0 = arg_1_raddr_0_reg;
	assign arg_1_waddr_0 = arg_1_waddr_0_reg;
	assign arg_1_wdata_0 = arg_1_wdata_0_reg;
	assign arg_1_wen_0 = arg_1_wen_0_reg;
	assign valid = valid_reg;
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
	reg [15:0] phi_in_phi_1;
	reg [31:0] phi_last_block_phi_1;
	reg [63:0] phi_s_phi_1;
	wire [31:0] phi_out_phi_1;
	phi #(.NB_PAIR(2), .WIDTH(8)) phi_1(.in(phi_in_phi_1), .last_block(phi_last_block_phi_1), .out(phi_out_phi_1), .s(phi_s_phi_1));

	br_dummy br_unit();

	add alloca_2();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [7:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [7:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(8)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	reg [31:0] add_in0_add_4;
	reg [31:0] add_in1_add_4;
	wire [31:0] add_out_add_4;
	add #(.WIDTH(32)) add_add_4(.in0(add_in0_add_4), .in1(add_in1_add_4), .out(add_out_add_4));

	reg [31:0] sgt_in0_sext_6;
	wire [63:0] sgt_out_sext_6;
	sext sext_6(.in(sgt_in0_sext_6), .out(sgt_out_sext_6));

	reg [31:0] add_in0_add_7;
	reg [31:0] add_in1_add_7;
	wire [31:0] add_out_add_7;
	add #(.WIDTH(32)) add_add_7(.in0(add_in0_add_7), .in1(add_in1_add_7), .out(add_out_add_7));

	reg [31:0] sgt_in0_sext_17;
	wire [63:0] sgt_out_sext_17;
	sext sext_17(.in(sgt_in0_sext_17), .out(sgt_out_sext_17));

	reg [31:0] cmp_in0_icmp_18;
	reg [31:0] cmp_in1_icmp_18;
	wire [0:0] cmp_out_icmp_18;
	slt #(.WIDTH(32)) icmp_18(.in0(cmp_in0_icmp_18), .in1(cmp_in1_icmp_18), .out(cmp_out_icmp_18));

	reg [31:0] trunc_in_trunc_8;
	wire [7:0] trunc_out_trunc_8;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_8(.in(trunc_in_trunc_8), .out(trunc_out_trunc_8));

	reg [31:0] trunc_in_trunc_13;
	wire [7:0] trunc_out_trunc_13;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_13(.in(trunc_in_trunc_13), .out(trunc_out_trunc_13));

	// End Functional Units

	// Start instruction result storage
	reg [7:0] trunc_tmp_4;
	// End instruction result storage

	// Start pipeline variables
	// -- Pipeline, II = 1
	wire [0:0] in_pipeline_0;
	reg [0:0] pipeline_stage_0_valid;
	reg [0:0] pipeline_stage_1_valid;
	// Start stage registers
	// Start stage
	reg [31:0] pipeline_phi0_0_0;
	reg [31:0] pipeline_add0_0_1;
	reg [31:0] pipeline_sext0_0_2;
	reg [31:0] pipeline_add0_0_3;
	reg [31:0] pipeline_trunc0_0_4;
	reg [31:0] pipeline_load0_0_5;
	reg [31:0] pipeline_call0_0_6;
	reg [31:0] pipeline_call0_0_7;
	reg [31:0] pipeline_trunc0_0_8;
	// End stage
	// Start stage
	reg [31:0] pipeline_phi_0_1_9;
	reg [31:0] pipeline_add_0_1_10;
	reg [31:0] pipeline_sext_0_1_11;
	reg [31:0] pipeline_add_0_1_12;
	reg [31:0] pipeline_sext0_1_18;
	reg [31:0] pipeline_icmp0_1_19;
	reg [31:0] pipeline_trunc_0_1_13;
	reg [31:0] pipeline_load_0_1_14;
	reg [31:0] pipeline_call_0_1_15;
	reg [31:0] pipeline_call_0_1_16;
	reg [31:0] pipeline_trunc_0_1_17;
	// End stage
	// End stage registers
	// End pipeline variables

	reg [31:0] global_state;
	reg [31:0] last_BB_reg;
	// Start pipeline reset block
	always @(posedge clk) begin
		if (rst) begin
			pipeline_stage_0_valid <= 0;
			pipeline_stage_1_valid <= 0;
		end
	end
	// End pipeline reset block

	// Start pipeline valid chain block
	always @(posedge clk) begin
	if (in_pipeline_0) begin		$display("// CLK Cycle");
		$display("in_pipeline_0 = %d", in_pipeline_0);
		$display("pipeline_stage_0_valid = %d", pipeline_stage_0_valid);
		$display("pipeline_stage_1_valid = %d", pipeline_stage_1_valid);
	end

		if (!rst) begin
			pipeline_stage_1_valid <= pipeline_stage_0_valid;
		end
	end
	// End pipeline valid chain block

	always @(posedge clk) begin
		// Pipeline register chain
		// Register transfer from stage 0 to 1
		// Register transfer from stage 1 to regular storage
		trunc_tmp_4 <= pipeline_trunc_0_1_13;
	end
	// Start pipeline initiation block
	always @(posedge clk) begin
			if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
					if(!(cmp_out_icmp_18)) begin
						pipeline_stage_0_valid <= 0;
					end else begin
						pipeline_stage_0_valid <= 1;
					end
				end else if (in_pipeline_0) begin pipeline_stage_0_valid <= 0; end
	end
	// End pipeline initiation block

	always @(posedge clk) begin
		if (rst) begin
			last_BB_reg <= 0;
		end else begin
			if ((global_state == 0)) begin
					last_BB_reg <= 0;
			end
			if ((global_state == 200000)) begin
				last_BB_reg <= 1;
			end
			if ((global_state == 3)) begin
					last_BB_reg <= 2;
			end
		end
	end

	assign in_pipeline_0 = global_state == 200000;
	always @(posedge clk) begin
		if (rst) begin
			global_state <= 0;
		end else begin
			// Control code
			if ((global_state == 0)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 200000;
					pipeline_stage_0_valid <= 1;
				end
			end
			if ((in_pipeline_0 && pipeline_stage_0_valid)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 200000;
				end
			end
			if ((in_pipeline_0 && pipeline_stage_1_valid)) begin 
				// Next state transition logic
				// Condition = (  %11 = icmp slt i32 %10, 100)
				if ((cmp_out_icmp_18)) begin
					global_state <= 200000;
				end
				// Condition = (!(  %11 = icmp slt i32 %10, 100))
				if (!(cmp_out_icmp_18) && (!pipeline_stage_0_valid)) begin
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
			if ((in_pipeline_0 && pipeline_stage_0_valid)) begin 
				// Temporary storage
				// Store data computed at the stage
					pipeline_trunc_0_1_13 <= trunc_out_trunc_8;
			end
			if ((in_pipeline_0 && pipeline_stage_1_valid)) begin 
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
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				phi_in_phi_1 = {pipeline_trunc_0_1_13, (8'd0)};
				phi_last_block_phi_1 = last_BB_reg;
				phi_s_phi_1 = {32'd1, 32'd0};
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = phi_out_phi_1;
				wen_ram_0_reg = 1;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				add_in0_add_4 = arg_1_rdata_0;
				add_in1_add_4 = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_1_wen_0_reg = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				sgt_in0_sext_6 = phi_out_phi_1;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				add_in0_add_7 = sgt_out_sext_6;
				add_in1_add_7 = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				trunc_in_trunc_8 = add_out_add_7;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				raddr_ram_0_reg = 0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_0_raddr_0_reg = rdata_ram_0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				trunc_in_trunc_13 = arg_0_rdata_0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_1_raddr_0_reg = trunc_out_trunc_13;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_1_wdata_0_reg = add_out_add_4;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_1_waddr_0_reg = trunc_out_trunc_13;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
				sgt_in0_sext_17 = pipeline_trunc_0_1_13;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
				cmp_in0_icmp_18 = sgt_out_sext_17;
				cmp_in1_icmp_18 = (32'd100);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
		end
	end
	// End pipeline instruction code

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

module histogram(input [0:0] clk, input [0:0] rst, output [7:0] arg_1_debug_addr, output [7:0] arg_1_debug_write_addr, output [31:0] arg_1_debug_write_data, output [0:0] arg_1_debug_write_en, output [7:0] arg_1_raddr_0, output [7:0] arg_1_waddr_0, output [31:0] arg_1_wdata_0, output [0:0] arg_1_wen_0, input [31:0] arg_1_debug_data, input [31:0] arg_1_rdata_0, output [0:0] valid, output [11:0] arg_0_debug_addr, output [11:0] arg_0_debug_write_addr, output [7:0] arg_0_debug_write_data, output [0:0] arg_0_debug_write_en, output [11:0] arg_0_raddr_0, output [11:0] arg_0_waddr_0, output [7:0] arg_0_wdata_0, output [0:0] arg_0_wen_0, input [7:0] arg_0_debug_data, input [7:0] arg_0_rdata_0);


	initial begin
	end




	histogram_inner inner(.arg_0_debug_addr(arg_0_debug_addr), .arg_0_debug_data(arg_0_debug_data), .arg_0_debug_write_addr(arg_0_debug_write_addr), .arg_0_debug_write_data(arg_0_debug_write_data), .arg_0_debug_write_en(arg_0_debug_write_en), .arg_0_raddr_0(arg_0_raddr_0), .arg_0_rdata_0(arg_0_rdata_0), .arg_0_waddr_0(arg_0_waddr_0), .arg_0_wdata_0(arg_0_wdata_0), .arg_0_wen_0(arg_0_wen_0), .arg_1_debug_addr(arg_1_debug_addr), .arg_1_debug_data(arg_1_debug_data), .arg_1_debug_write_addr(arg_1_debug_write_addr), .arg_1_debug_write_data(arg_1_debug_write_data), .arg_1_debug_write_en(arg_1_debug_write_en), .arg_1_raddr_0(arg_1_raddr_0), .arg_1_rdata_0(arg_1_rdata_0), .arg_1_waddr_0(arg_1_waddr_0), .arg_1_wdata_0(arg_1_wdata_0), .arg_1_wen_0(arg_1_wen_0), .clk(clk), .rst(rst), .valid(valid));

endmodule
