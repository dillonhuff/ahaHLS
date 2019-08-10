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
	br_dummy br_unit();

	add alloca_1();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [7:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [7:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(8)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	reg [31:0] sgt_in0_sext_3;
	wire [63:0] sgt_out_sext_3;
	sext sext_3(.in(sgt_in0_sext_3), .out(sgt_out_sext_3));

	reg [31:0] add_in0_add_12;
	reg [31:0] add_in1_add_12;
	wire [31:0] add_out_add_12;
	add #(.WIDTH(32)) add_add_12(.in0(add_in0_add_12), .in1(add_in1_add_12), .out(add_out_add_12));

	reg [31:0] add_in0_add_4;
	reg [31:0] add_in1_add_4;
	wire [31:0] add_out_add_4;
	add #(.WIDTH(32)) add_add_4(.in0(add_in0_add_4), .in1(add_in1_add_4), .out(add_out_add_4));

	reg [31:0] trunc_in_trunc_5;
	wire [7:0] trunc_out_trunc_5;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_5(.in(trunc_in_trunc_5), .out(trunc_out_trunc_5));

	reg [31:0] sgt_in0_sext_17;
	wire [63:0] sgt_out_sext_17;
	sext sext_17(.in(sgt_in0_sext_17), .out(sgt_out_sext_17));

	reg [31:0] cmp_in0_icmp_18;
	reg [31:0] cmp_in1_icmp_18;
	wire [0:0] cmp_out_icmp_18;
	slt #(.WIDTH(32)) icmp_18(.in0(cmp_in0_icmp_18), .in1(cmp_in1_icmp_18), .out(cmp_out_icmp_18));

	reg [31:0] trunc_in_trunc_10;
	wire [7:0] trunc_out_trunc_10;
	trunc #(.IN_WIDTH(32), .OUT_WIDTH(8)) trunc_10(.in(trunc_in_trunc_10), .out(trunc_out_trunc_10));

	reg [15:0] phi_in_phi_8;
	reg [31:0] phi_last_block_phi_8;
	reg [63:0] phi_s_phi_8;
	wire [31:0] phi_out_phi_8;
	phi #(.NB_PAIR(2), .WIDTH(8)) phi_8(.in(phi_in_phi_8), .last_block(phi_last_block_phi_8), .out(phi_out_phi_8), .s(phi_s_phi_8));

	// End Functional Units

	// Start instruction result storage
	reg [7:0] trunc_tmp_2;
	reg [7:0] trunc_tmp_6;
	// End instruction result storage

	// Start pipeline variables
	// -- Pipeline, II = 2
	wire [0:0] in_pipeline_0;
	reg [0:0] pipeline_stage_0_valid;
	reg [0:0] pipeline_stage_1_valid;
	reg [0:0] pipeline_stage_2_valid;
	reg [0:0] pipeline_stage_3_valid;
	// Start stage registers
	// Start stage
	reg [31:0] pipeline_sext0_0_0;
	reg [31:0] pipeline_add0_0_1;
	reg [31:0] pipeline_trunc0_0_2;
	reg [31:0] pipeline_load0_0_3;
	reg [31:0] pipeline_phi0_0_4;
	// End stage
	// Start stage
	reg [31:0] pipeline_sext_0_1_5;
	reg [31:0] pipeline_add_0_1_6;
	reg [31:0] pipeline_trunc_0_1_7;
	reg [31:0] pipeline_load_0_1_8;
	reg [31:0] pipeline_call0_1_10;
	reg [31:0] pipeline_trunc0_1_11;
	reg [31:0] pipeline_phi_0_1_9;
	// End stage
	// Start stage
	reg [31:0] pipeline_sext_0_2_12;
	reg [31:0] pipeline_add0_2_19;
	reg [31:0] pipeline_add_0_2_13;
	reg [31:0] pipeline_trunc_0_2_14;
	reg [31:0] pipeline_call0_2_20;
	reg [31:0] pipeline_load_0_2_15;
	reg [31:0] pipeline_call_0_2_16;
	reg [31:0] pipeline_trunc_0_2_17;
	reg [31:0] pipeline_phi_0_2_18;
	// End stage
	// Start stage
	reg [31:0] pipeline_sext_0_3_21;
	reg [31:0] pipeline_add_0_3_22;
	reg [31:0] pipeline_add_0_3_23;
	reg [31:0] pipeline_trunc_0_3_24;
	reg [31:0] pipeline_sext0_3_30;
	reg [31:0] pipeline_icmp0_3_31;
	reg [31:0] pipeline_call_0_3_25;
	reg [31:0] pipeline_load_0_3_26;
	reg [31:0] pipeline_call_0_3_27;
	reg [31:0] pipeline_trunc_0_3_28;
	reg [31:0] pipeline_phi_0_3_29;
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
			pipeline_stage_2_valid <= 0;
			pipeline_stage_3_valid <= 0;
		end
	end
	// End pipeline reset block

	// Start pipeline valid chain block
	always @(posedge clk) begin
	if (in_pipeline_0) begin		$display("// CLK Cycle");
		$display("in_pipeline_0 = %d", in_pipeline_0);
		$display("pipeline_stage_0_valid = %d", pipeline_stage_0_valid);
		$display("pipeline_stage_1_valid = %d", pipeline_stage_1_valid);
		$display("pipeline_stage_2_valid = %d", pipeline_stage_2_valid);
		$display("pipeline_stage_3_valid = %d", pipeline_stage_3_valid);
	end

		if (!rst) begin
			pipeline_stage_1_valid <= pipeline_stage_0_valid;
			pipeline_stage_2_valid <= pipeline_stage_1_valid;
			pipeline_stage_3_valid <= pipeline_stage_2_valid;
		end
	end
	// End pipeline valid chain block

	always @(posedge clk) begin
		// Pipeline register chain
		// Register transfer from stage 0 to 1
		// Register transfer from stage 1 to 2
		pipeline_sext_0_2_12 <= pipeline_sext_0_1_5;
		pipeline_add_0_2_13 <= pipeline_add_0_1_6;
		pipeline_trunc_0_2_14 <= pipeline_trunc_0_1_7;
		pipeline_load_0_2_15 <= pipeline_load_0_1_8;
		pipeline_phi_0_2_18 <= pipeline_phi_0_1_9;
		// Register transfer from stage 2 to 3
		pipeline_sext_0_3_21 <= pipeline_sext_0_2_12;
		pipeline_add_0_3_23 <= pipeline_add_0_2_13;
		pipeline_trunc_0_3_24 <= pipeline_trunc_0_2_14;
		pipeline_load_0_3_26 <= pipeline_load_0_2_15;
		pipeline_call_0_3_27 <= pipeline_call_0_2_16;
		pipeline_trunc_0_3_28 <= pipeline_trunc_0_2_17;
		pipeline_phi_0_3_29 <= pipeline_phi_0_2_18;
		// Register transfer from stage 3 to regular storage
		trunc_tmp_2 <= pipeline_trunc_0_3_24;
		trunc_tmp_6 <= pipeline_trunc_0_3_28;
	end
	// Start pipeline initiation block
	always @(posedge clk) begin
			if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
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
			if ((global_state == 5)) begin
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
				// Condition = True

				if (1) begin
					global_state <= 200000;
				end
			end
			if ((in_pipeline_0 && pipeline_stage_2_valid)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 200000;
				end
			end
			if ((in_pipeline_0 && pipeline_stage_3_valid)) begin 
				// Next state transition logic
				// Condition = (  %11 = icmp slt i32 %10, 100)
				if ((cmp_out_icmp_18)) begin
					global_state <= 200000;
				end
				// Condition = (!(  %11 = icmp slt i32 %10, 100))
				if (!(cmp_out_icmp_18) && (!pipeline_stage_0_valid && !pipeline_stage_1_valid && !pipeline_stage_2_valid)) begin
					global_state <= 5;
				end
			end
			if ((global_state == 5)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 5;
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
					pipeline_trunc_0_1_7 <= trunc_out_trunc_5;
			end
			if ((in_pipeline_0 && pipeline_stage_1_valid)) begin 
				// Temporary storage
				// Store data computed at the stage
					pipeline_trunc_0_2_17 <= trunc_out_trunc_10;
			end
			if ((in_pipeline_0 && pipeline_stage_2_valid)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((in_pipeline_0 && pipeline_stage_3_valid)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
			if ((global_state == 5)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = phi_out_phi_8;
				wen_ram_0_reg = 1;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				sgt_in0_sext_3 = phi_out_phi_8;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				add_in0_add_4 = sgt_out_sext_3;
				add_in1_add_4 = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				trunc_in_trunc_5 = add_out_add_4;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				raddr_ram_0_reg = 0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				arg_0_raddr_0_reg = rdata_ram_0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_0_valid)) begin
				phi_in_phi_8 = {pipeline_trunc_0_2_14, (8'd0)};
				phi_last_block_phi_8 = last_BB_reg;
				phi_s_phi_8 = {32'd1, 32'd0};
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
				trunc_in_trunc_10 = arg_0_rdata_0;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_1_valid)) begin
				arg_1_raddr_0_reg = trunc_out_trunc_10;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_2_valid)) begin
				add_in0_add_12 = arg_1_rdata_0;
				add_in1_add_12 = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_2_valid)) begin
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_2_valid)) begin
				arg_1_wdata_0_reg = add_out_add_12;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_2_valid)) begin
				arg_1_wen_0_reg = (32'd1);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_2_valid)) begin
				arg_1_waddr_0_reg = pipeline_trunc_0_2_17;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_3_valid)) begin
				sgt_in0_sext_17 = pipeline_trunc_0_3_24;
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_3_valid)) begin
				cmp_in0_icmp_18 = sgt_out_sext_17;
				cmp_in1_icmp_18 = (32'd100);
		end
	end
	always @(*) begin
		if ((in_pipeline_0 && pipeline_stage_3_valid)) begin
		end
	end
	// End pipeline instruction code

	// controller for ret_20.valid_reg
	always @(*) begin
		if ((global_state == 5)) begin 
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
