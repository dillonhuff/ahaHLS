module write_byte_func_inner(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_2_m_axis_tready, output [47:0] arg_2_s_eth_dest_mac, output [0:0] arg_2_s_eth_hdr_valid, output [7:0] arg_2_s_eth_payload_axis_tdata, output [0:0] arg_2_s_eth_payload_axis_tlast, output [0:0] arg_2_s_eth_payload_axis_tuser, output [0:0] arg_2_s_eth_payload_axis_tvalid, output [47:0] arg_2_s_eth_src_mac, output [15:0] arg_2_s_eth_type, input [0:0] arg_2_busy, input [0:0] arg_2_s_eth_hdr_ready, input [0:0] arg_2_s_eth_payload_axis_tready, input [7:0] arg_0_out_data, input [0:0] arg_1_out_data);

	reg [0:0] valid_reg;
	reg [0:0] arg_2_m_axis_tready_reg;
	reg [47:0] arg_2_s_eth_dest_mac_reg;
	reg [0:0] arg_2_s_eth_hdr_valid_reg;
	reg [7:0] arg_2_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_2_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_2_s_eth_src_mac_reg;
	reg [15:0] arg_2_s_eth_type_reg;

	assign valid = valid_reg;
	assign arg_2_m_axis_tready = arg_2_m_axis_tready_reg;
	assign arg_2_s_eth_dest_mac = arg_2_s_eth_dest_mac_reg;
	assign arg_2_s_eth_hdr_valid = arg_2_s_eth_hdr_valid_reg;
	assign arg_2_s_eth_payload_axis_tdata = arg_2_s_eth_payload_axis_tdata_reg;
	assign arg_2_s_eth_payload_axis_tlast = arg_2_s_eth_payload_axis_tlast_reg;
	assign arg_2_s_eth_payload_axis_tuser = arg_2_s_eth_payload_axis_tuser_reg;
	assign arg_2_s_eth_payload_axis_tvalid = arg_2_s_eth_payload_axis_tvalid_reg;
	assign arg_2_s_eth_src_mac = arg_2_s_eth_src_mac_reg;
	assign arg_2_s_eth_type = arg_2_s_eth_type_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add alloca_0();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [7:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [7:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(8)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	reg [31:0] base_addr_getelementptr_2;
	reg [31:0] gep_add_in1_getelementptr_2;
	wire [31:0] getelementptr_out_getelementptr_2;
	getelementptr_1 getelementptr_2(.base_addr(base_addr_getelementptr_2), .in1(gep_add_in1_getelementptr_2), .out(getelementptr_out_getelementptr_2));

	add alloca_3();

	reg [31:0] raddr_ram_2_reg;
	reg [31:0] waddr_ram_2_reg;
	reg [0:0] wdata_ram_2_reg;
	reg [0:0] wen_ram_2_reg;
	wire [0:0] rdata_ram_2;
	reg_passthrough #(.WIDTH(1)) ram_2(.clk(clk), .raddr(raddr_ram_2_reg), .rdata(rdata_ram_2), .rst(rst), .waddr(waddr_ram_2_reg), .wdata(wdata_ram_2_reg), .wen(wen_ram_2_reg));

	reg [31:0] base_addr_getelementptr_6;
	reg [31:0] gep_add_in1_getelementptr_6;
	wire [31:0] getelementptr_out_getelementptr_6;
	getelementptr_1 getelementptr_6(.base_addr(base_addr_getelementptr_6), .in1(gep_add_in1_getelementptr_6), .out(getelementptr_out_getelementptr_6));

	add alloca_8();

	add alloca_9();

	reg [31:0] raddr_ram_6_reg;
	reg [31:0] waddr_ram_6_reg;
	reg [7:0] wdata_ram_6_reg;
	reg [0:0] wen_ram_6_reg;
	wire [7:0] rdata_ram_6;
	reg_passthrough #(.WIDTH(8)) ram_6(.clk(clk), .raddr(raddr_ram_6_reg), .rdata(rdata_ram_6), .rst(rst), .waddr(waddr_ram_6_reg), .wdata(wdata_ram_6_reg), .wen(wen_ram_6_reg));

	reg [31:0] raddr_ram_7_reg;
	reg [31:0] waddr_ram_7_reg;
	reg [0:0] wdata_ram_7_reg;
	reg [0:0] wen_ram_7_reg;
	wire [0:0] rdata_ram_7;
	reg_passthrough #(.WIDTH(1)) ram_7(.clk(clk), .raddr(raddr_ram_7_reg), .rdata(rdata_ram_7), .rst(rst), .waddr(waddr_ram_7_reg), .wdata(wdata_ram_7_reg), .wen(wen_ram_7_reg));

	add call_13();

	reg [31:0] base_addr_getelementptr_14;
	reg [31:0] gep_add_in1_getelementptr_14;
	wire [31:0] getelementptr_out_getelementptr_14;
	getelementptr_1 getelementptr_14(.base_addr(base_addr_getelementptr_14), .in1(gep_add_in1_getelementptr_14), .out(getelementptr_out_getelementptr_14));

	reg [31:0] base_addr_getelementptr_16;
	reg [31:0] gep_add_in1_getelementptr_16;
	wire [31:0] getelementptr_out_getelementptr_16;
	getelementptr_1 getelementptr_16(.base_addr(base_addr_getelementptr_16), .in1(gep_add_in1_getelementptr_16), .out(getelementptr_out_getelementptr_16));

	// End Functional Units

	// Start instruction result storage
	reg [0:0] load_tmp_6;
	reg [7:0] load_tmp_8;
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
				if (arg_2_s_eth_payload_axis_tready) begin 
					global_state <= 1;
				end
				end
				// Store data computed at the stage
					load_tmp_6 <= rdata_ram_7;
					load_tmp_8 <= rdata_ram_6;
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 1;
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
				//   %0 = alloca i8
				if (arg_2_s_eth_payload_axis_tready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i8 %arg_0, i8* %0
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = arg_0_out_data;
				wen_ram_0_reg = 1;
				end
				//   %3 = load i8, i8* %2
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_0_reg = getelementptr_out_getelementptr_2;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %2 = getelementptr i8, i8* %0, i32 0
				if (arg_2_s_eth_payload_axis_tready) begin
				base_addr_getelementptr_2 = 0;
				gep_add_in1_getelementptr_2 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %1 = alloca i1
				if (arg_2_s_eth_payload_axis_tready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i1 %arg_1, i1* %1
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_2_reg = 0;
				wdata_ram_2_reg = arg_1_out_data;
				wen_ram_2_reg = 1;
				end
				//   %5 = load i1, i1* %4
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_2_reg = getelementptr_out_getelementptr_6;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %4 = getelementptr i1, i1* %1, i32 0
				if (arg_2_s_eth_payload_axis_tready) begin
				base_addr_getelementptr_6 = 0;
				gep_add_in1_getelementptr_6 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %6 = alloca i8
				if (arg_2_s_eth_payload_axis_tready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %7 = alloca i1
				if (arg_2_s_eth_payload_axis_tready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i8 %3, i8* %6
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_6_reg = 0;
				wdata_ram_6_reg = rdata_ram_0;
				wen_ram_6_reg = 1;
				end
				//   %12 = load i8, i8* %11
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_6_reg = getelementptr_out_getelementptr_16;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i1 %5, i1* %7
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_7_reg = 0;
				wdata_ram_7_reg = rdata_ram_2;
				wen_ram_7_reg = 1;
				end
				//   %10 = load i1, i1* %9
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_7_reg = getelementptr_out_getelementptr_14;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %8 = call i1 @builtin_read_port_s_eth_payload_axis_tready(%eth_axis_tx* %arg_2)
				if (arg_2_s_eth_payload_axis_tready) begin
				end
			arg_2_s_eth_hdr_valid_reg = 0;
			arg_2_s_eth_payload_axis_tvalid_reg = 0;
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_s_eth_payload_axis_tvalid(%eth_axis_tx* %arg_2, i32 1)
				arg_2_s_eth_payload_axis_tvalid_reg = (32'd1);
				//   call void @builtin_write_port_s_eth_payload_axis_tlast(%eth_axis_tx* %arg_2, i1 %10)
				arg_2_s_eth_payload_axis_tlast_reg = load_tmp_6;
				//   call void @builtin_write_port_s_eth_payload_axis_tdata(%eth_axis_tx* %arg_2, i8 %12)
				arg_2_s_eth_payload_axis_tdata_reg = load_tmp_8;
			arg_2_s_eth_hdr_valid_reg = 0;
		end else begin 
			// Default values
				arg_2_s_eth_hdr_valid_reg = 0;
				arg_2_s_eth_payload_axis_tvalid_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @builtin_stall(i1 %8)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %9 = getelementptr i1, i1* %7, i32 0
				if (arg_2_s_eth_payload_axis_tready) begin
				base_addr_getelementptr_14 = 0;
				gep_add_in1_getelementptr_14 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %11 = getelementptr i8, i8* %6, i32 0
				if (arg_2_s_eth_payload_axis_tready) begin
				base_addr_getelementptr_16 = 0;
				gep_add_in1_getelementptr_16 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 1)) begin 
				//   ret void
				valid_reg = 1;
		end else begin 
			// Default values
				valid_reg = 0;
		end
	end
endmodule

module write_byte_func(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_2_m_axis_tready, output [47:0] arg_2_s_eth_dest_mac, output [0:0] arg_2_s_eth_hdr_valid, output [7:0] arg_2_s_eth_payload_axis_tdata, output [0:0] arg_2_s_eth_payload_axis_tlast, output [0:0] arg_2_s_eth_payload_axis_tuser, output [0:0] arg_2_s_eth_payload_axis_tvalid, output [47:0] arg_2_s_eth_src_mac, output [15:0] arg_2_s_eth_type, input [0:0] arg_2_busy, input [0:0] arg_2_s_eth_hdr_ready, input [0:0] arg_2_s_eth_payload_axis_tready, input [7:0] arg_0_out_data, input [0:0] arg_1_out_data);


	initial begin
	end




	write_byte_func_inner inner(.arg_0_out_data(arg_0_out_data), .arg_1_out_data(arg_1_out_data), .arg_2_busy(arg_2_busy), .arg_2_m_axis_tready(arg_2_m_axis_tready), .arg_2_s_eth_dest_mac(arg_2_s_eth_dest_mac), .arg_2_s_eth_hdr_ready(arg_2_s_eth_hdr_ready), .arg_2_s_eth_hdr_valid(arg_2_s_eth_hdr_valid), .arg_2_s_eth_payload_axis_tdata(arg_2_s_eth_payload_axis_tdata), .arg_2_s_eth_payload_axis_tlast(arg_2_s_eth_payload_axis_tlast), .arg_2_s_eth_payload_axis_tready(arg_2_s_eth_payload_axis_tready), .arg_2_s_eth_payload_axis_tuser(arg_2_s_eth_payload_axis_tuser), .arg_2_s_eth_payload_axis_tvalid(arg_2_s_eth_payload_axis_tvalid), .arg_2_s_eth_src_mac(arg_2_s_eth_src_mac), .arg_2_s_eth_type(arg_2_s_eth_type), .clk(clk), .rst(rst), .valid(valid));

endmodule
