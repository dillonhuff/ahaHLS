module channel_reduce_4_inner(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [31:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [31:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);

	reg [31:0] out_in_data_reg;
	reg [0:0] out_read_valid_reg;
	reg [0:0] out_rst_reg;
	reg [31:0] out_write_valid_reg;
	reg [31:0] in_in_data_reg;
	reg [0:0] in_read_valid_reg;
	reg [0:0] in_rst_reg;
	reg [31:0] in_write_valid_reg;
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
				if (in_read_ready) begin 
					global_state <= 3;
				end
				end
				// Store data computed at the stage
					load_tmp_2 <= rdata_ram_0;
					add_tmp_3 <= add_out_add_9;
					icmp_tmp_4 <= cmp_out_icmp_10;
			end
			if ((global_state == 3)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 4;
				end
				// Store data computed at the stage
			end
			if ((global_state == 4)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 5;
				end
				// Store data computed at the stage
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
				// Store data computed at the stage
			end
			if ((global_state == 6)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (out_write_ready) begin 
					global_state <= 7;
				end
				end
				// Store data computed at the stage
			end
			if ((global_state == 7)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 8;
				end
				// Store data computed at the stage
			end
			if ((global_state == 8)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 8;
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
				//   %sum = alloca i32, align 4
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %1 = bitcast i32* %sum to i8*
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @llvm.lifetime.start.p0i8(i64 4, i8* %1) #14
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i32 0, i32* %sum, align 4, !tbaa !2
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = (32'd0);
				wen_ram_0_reg = 1;
		end else 		if ((global_state == 2)) begin 
				//   %8 = load i32, i32* %sum, align 4, !tbaa !2
				if (in_read_ready) begin
				raddr_ram_0_reg = 0;
				end
		end else 		if ((global_state == 4)) begin 
				//   store i32 %9, i32* %sum, align 4, !tbaa !2
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = add_out_add_14;
				wen_ram_0_reg = 1;
		end else 		if ((global_state == 7)) begin 
				//   %4 = load i32, i32* %sum
				raddr_ram_0_reg = 0;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   %6 = call i1 @builtin_read_port_read_ready(%class.ac_channel* %in)
				if (in_read_ready) begin
				end
			in_in_data_reg = 0;
			in_read_valid_reg = 0;
			in_write_valid_reg = 0;
		end else 		if ((global_state == 3)) begin 
				//   call void @builtin_write_port_read_valid(%class.ac_channel* %in, i1 true)
				in_read_valid_reg = -(1'd1);
			in_in_data_reg = 0;
			in_write_valid_reg = 0;
		end else 		if ((global_state == 4)) begin 
				//   call void @builtin_write_port_read_valid(%class.ac_channel* %in, i1 false)
				in_read_valid_reg = (1'd0);
				//   %7 = call i32 @builtin_read_port_out_data(%class.ac_channel* %in)
			in_in_data_reg = 0;
			in_write_valid_reg = 0;
		end else begin 
			// Default values
				in_in_data_reg = 0;
				in_read_valid_reg = 0;
				in_write_valid_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   call void @builtin_stall(i1 %6)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   %i.01 = phi i32 [ 0, %0 ], [ %10, %5 ]
				if (in_read_ready) begin
				phi_in_phi_7 = {(32'd0), add_tmp_3};
				phi_last_block_phi_7 = last_BB_reg;
				phi_s_phi_7 = {32'd0, 32'd2};
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   %10 = add nuw nsw i32 %i.01, 1
				if (in_read_ready) begin
				add_in0_add_9 = phi_out_phi_7;
				add_in1_add_9 = (32'd1);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 2)) begin 
				//   %exitcond = icmp eq i32 %10, 4
				if (in_read_ready) begin
				cmp_in0_icmp_10 = add_out_add_9;
				cmp_in1_icmp_10 = (32'd4);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 4)) begin 
				//   %9 = add nsw i32 %8, %7
				add_in0_add_14 = load_tmp_2;
				add_in1_add_14 = in_out_data;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 6)) begin 
				//   %3 = call i1 @builtin_read_port_write_ready(%class.ac_channel* %out)
				if (out_write_ready) begin
				end
			out_in_data_reg = 0;
			out_read_valid_reg = 0;
			out_write_valid_reg = 0;
		end else 		if ((global_state == 7)) begin 
				//   call void @builtin_write_port_write_valid(%class.ac_channel* %out, i1 true)
				out_write_valid_reg = -(1'd1);
				//   call void @builtin_write_port_in_data(%class.ac_channel* %out, i32 %4)
				out_in_data_reg = rdata_ram_0;
			out_read_valid_reg = 0;
		end else 		if ((global_state == 8)) begin 
				//   call void @builtin_write_port_write_valid(%class.ac_channel* %out, i1 false)
				out_write_valid_reg = (1'd0);
			out_in_data_reg = 0;
			out_read_valid_reg = 0;
		end else begin 
			// Default values
				out_in_data_reg = 0;
				out_read_valid_reg = 0;
				out_write_valid_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 6)) begin 
				//   call void @builtin_stall(i1 %3)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 6)) begin 
				//   call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %1) #14
				if (out_write_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 8)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module channel_reduce_4(input [0:0] clk, input [0:0] rst, output [31:0] out_in_data, output [0:0] out_read_valid, output [0:0] out_rst, output [31:0] out_write_valid, input [31:0] out_out_data, input [0:0] out_read_ready, input [0:0] out_write_ready, output [31:0] in_in_data, output [0:0] in_read_valid, output [0:0] in_rst, output [31:0] in_write_valid, input [31:0] in_out_data, input [0:0] in_read_ready, input [0:0] in_write_ready, output [0:0] valid);


	initial begin
	end




	channel_reduce_4_inner inner(.clk(clk), .in_in_data(in_in_data), .in_out_data(in_out_data), .in_read_ready(in_read_ready), .in_read_valid(in_read_valid), .in_rst(in_rst), .in_write_ready(in_write_ready), .in_write_valid(in_write_valid), .out_in_data(out_in_data), .out_out_data(out_out_data), .out_read_ready(out_read_ready), .out_read_valid(out_read_valid), .out_rst(out_rst), .out_write_ready(out_write_ready), .out_write_valid(out_write_valid), .rst(rst), .valid(valid));

endmodule
