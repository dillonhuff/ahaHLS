module write_header_func_inner(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, input [47:0] arg_0_out_data, input [47:0] arg_1_out_data, input [15:0] arg_2_out_data);

	reg [0:0] valid_reg;
	reg [0:0] arg_3_m_axis_tready_reg;
	reg [47:0] arg_3_s_eth_dest_mac_reg;
	reg [0:0] arg_3_s_eth_hdr_valid_reg;
	reg [7:0] arg_3_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_3_s_eth_src_mac_reg;
	reg [15:0] arg_3_s_eth_type_reg;

	assign valid = valid_reg;
	assign arg_3_m_axis_tready = arg_3_m_axis_tready_reg;
	assign arg_3_s_eth_dest_mac = arg_3_s_eth_dest_mac_reg;
	assign arg_3_s_eth_hdr_valid = arg_3_s_eth_hdr_valid_reg;
	assign arg_3_s_eth_payload_axis_tdata = arg_3_s_eth_payload_axis_tdata_reg;
	assign arg_3_s_eth_payload_axis_tlast = arg_3_s_eth_payload_axis_tlast_reg;
	assign arg_3_s_eth_payload_axis_tuser = arg_3_s_eth_payload_axis_tuser_reg;
	assign arg_3_s_eth_payload_axis_tvalid = arg_3_s_eth_payload_axis_tvalid_reg;
	assign arg_3_s_eth_src_mac = arg_3_s_eth_src_mac_reg;
	assign arg_3_s_eth_type = arg_3_s_eth_type_reg;

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add alloca_0();

	reg [31:0] raddr_ram_0_reg;
	reg [31:0] waddr_ram_0_reg;
	reg [47:0] wdata_ram_0_reg;
	reg [0:0] wen_ram_0_reg;
	wire [47:0] rdata_ram_0;
	reg_passthrough #(.WIDTH(48)) ram_0(.clk(clk), .raddr(raddr_ram_0_reg), .rdata(rdata_ram_0), .rst(rst), .waddr(waddr_ram_0_reg), .wdata(wdata_ram_0_reg), .wen(wen_ram_0_reg));

	add alloca_2();

	reg [31:0] raddr_ram_1_reg;
	reg [31:0] waddr_ram_1_reg;
	reg [47:0] wdata_ram_1_reg;
	reg [0:0] wen_ram_1_reg;
	wire [47:0] rdata_ram_1;
	reg_passthrough #(.WIDTH(48)) ram_1(.clk(clk), .raddr(raddr_ram_1_reg), .rdata(rdata_ram_1), .rst(rst), .waddr(waddr_ram_1_reg), .wdata(wdata_ram_1_reg), .wen(wen_ram_1_reg));

	reg [31:0] base_addr_getelementptr_4;
	reg [31:0] gep_add_in1_getelementptr_4;
	wire [31:0] getelementptr_out_getelementptr_4;
	getelementptr_1 getelementptr_4(.base_addr(base_addr_getelementptr_4), .in1(gep_add_in1_getelementptr_4), .out(getelementptr_out_getelementptr_4));

	add alloca_5();

	reg [31:0] raddr_ram_3_reg;
	reg [31:0] waddr_ram_3_reg;
	reg [15:0] wdata_ram_3_reg;
	reg [0:0] wen_ram_3_reg;
	wire [15:0] rdata_ram_3;
	reg_passthrough #(.WIDTH(16)) ram_3(.clk(clk), .raddr(raddr_ram_3_reg), .rdata(rdata_ram_3), .rst(rst), .waddr(waddr_ram_3_reg), .wdata(wdata_ram_3_reg), .wen(wen_ram_3_reg));

	reg [31:0] base_addr_getelementptr_7;
	reg [31:0] gep_add_in1_getelementptr_7;
	wire [31:0] getelementptr_out_getelementptr_7;
	getelementptr_1 getelementptr_7(.base_addr(base_addr_getelementptr_7), .in1(gep_add_in1_getelementptr_7), .out(getelementptr_out_getelementptr_7));

	reg [31:0] base_addr_getelementptr_10;
	reg [31:0] gep_add_in1_getelementptr_10;
	wire [31:0] getelementptr_out_getelementptr_10;
	getelementptr_1 getelementptr_10(.base_addr(base_addr_getelementptr_10), .in1(gep_add_in1_getelementptr_10), .out(getelementptr_out_getelementptr_10));

	add call_13();

	reg [31:0] base_addr_getelementptr_14;
	reg [31:0] gep_add_in1_getelementptr_14;
	wire [31:0] getelementptr_out_getelementptr_14;
	getelementptr_1 getelementptr_14(.base_addr(base_addr_getelementptr_14), .in1(gep_add_in1_getelementptr_14), .out(getelementptr_out_getelementptr_14));

	reg [31:0] raddr_ram_9_reg;
	reg [31:0] waddr_ram_9_reg;
	reg [47:0] wdata_ram_9_reg;
	reg [0:0] wen_ram_9_reg;
	wire [47:0] rdata_ram_9;
	reg_passthrough #(.WIDTH(48)) ram_9(.clk(clk), .raddr(raddr_ram_9_reg), .rdata(rdata_ram_9), .rst(rst), .waddr(waddr_ram_9_reg), .wdata(wdata_ram_9_reg), .wen(wen_ram_9_reg));

	reg [31:0] base_addr_getelementptr_16;
	reg [31:0] gep_add_in1_getelementptr_16;
	wire [31:0] getelementptr_out_getelementptr_16;
	getelementptr_1 getelementptr_16(.base_addr(base_addr_getelementptr_16), .in1(gep_add_in1_getelementptr_16), .out(getelementptr_out_getelementptr_16));

	reg [31:0] raddr_ram_11_reg;
	reg [31:0] waddr_ram_11_reg;
	reg [47:0] wdata_ram_11_reg;
	reg [0:0] wen_ram_11_reg;
	wire [47:0] rdata_ram_11;
	reg_passthrough #(.WIDTH(48)) ram_11(.clk(clk), .raddr(raddr_ram_11_reg), .rdata(rdata_ram_11), .rst(rst), .waddr(waddr_ram_11_reg), .wdata(wdata_ram_11_reg), .wen(wen_ram_11_reg));

	add alloca_18();

	add alloca_20();

	add alloca_22();

	reg [31:0] raddr_ram_15_reg;
	reg [31:0] waddr_ram_15_reg;
	reg [15:0] wdata_ram_15_reg;
	reg [0:0] wen_ram_15_reg;
	wire [15:0] rdata_ram_15;
	reg_passthrough #(.WIDTH(16)) ram_15(.clk(clk), .raddr(raddr_ram_15_reg), .rdata(rdata_ram_15), .rst(rst), .waddr(waddr_ram_15_reg), .wdata(wdata_ram_15_reg), .wen(wen_ram_15_reg));

	reg [31:0] base_addr_getelementptr_24;
	reg [31:0] gep_add_in1_getelementptr_24;
	wire [31:0] getelementptr_out_getelementptr_24;
	getelementptr_1 getelementptr_24(.base_addr(base_addr_getelementptr_24), .in1(gep_add_in1_getelementptr_24), .out(getelementptr_out_getelementptr_24));

	// End Functional Units

	// Start instruction result storage
	reg [47:0] load_tmp_8;
	reg [47:0] load_tmp_10;
	reg [15:0] load_tmp_12;
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
			// Control code
			if ((global_state == 0)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
				if (arg_3_s_eth_hdr_ready) begin 
					global_state <= 1;
				end
				end
			end
			if ((global_state == 1)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 1;
				end
			end

			// Temporary storage code
			if ((global_state == 0)) begin 
				// Temporary storage
				// Store data computed at the stage
					load_tmp_8 <= rdata_ram_9;
					load_tmp_10 <= rdata_ram_11;
					load_tmp_12 <= rdata_ram_15;
			end
			if ((global_state == 1)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	always @(*) begin
		if ((global_state == 0)) begin 
				//   %0 = alloca i48
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i48 %arg_0, i48* %0
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = arg_0_out_data;
				wen_ram_0_reg = 1;
				end
				//   %4 = load i48, i48* %3
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_0_reg = getelementptr_out_getelementptr_7;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %1 = alloca i48
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i48 %arg_1, i48* %1
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_1_reg = 0;
				wdata_ram_1_reg = arg_1_out_data;
				wen_ram_1_reg = 1;
				end
				//   %6 = load i48, i48* %5
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_1_reg = getelementptr_out_getelementptr_4;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %5 = getelementptr i48, i48* %1, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_4 = 0;
				gep_add_in1_getelementptr_4 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %2 = alloca i16
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i16 %arg_2, i16* %2
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_3_reg = 0;
				wdata_ram_3_reg = arg_2_out_data;
				wen_ram_3_reg = 1;
				end
				//   %8 = load i16, i16* %7
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_3_reg = getelementptr_out_getelementptr_10;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %3 = getelementptr i48, i48* %0, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_7 = 0;
				gep_add_in1_getelementptr_7 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %7 = getelementptr i16, i16* %2, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_10 = 0;
				gep_add_in1_getelementptr_10 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %12 = call i1 @builtin_read_port_s_eth_hdr_ready(%eth_axis_tx* %arg_3)
				if (arg_3_s_eth_hdr_ready) begin
				end
			arg_3_s_eth_dest_mac_reg = 0;
			arg_3_s_eth_hdr_valid_reg = 0;
			arg_3_s_eth_payload_axis_tdata_reg = 0;
			arg_3_s_eth_payload_axis_tlast_reg = 0;
			arg_3_s_eth_payload_axis_tuser_reg = 0;
			arg_3_s_eth_payload_axis_tvalid_reg = 0;
			arg_3_s_eth_src_mac_reg = 0;
			arg_3_s_eth_type_reg = 0;
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_s_eth_hdr_valid(%eth_axis_tx* %arg_3, i32 1)
				arg_3_s_eth_hdr_valid_reg = (32'd1);
				//   call void @builtin_write_port_s_eth_dest_mac(%eth_axis_tx* %arg_3, i48 %14)
				arg_3_s_eth_dest_mac_reg = load_tmp_8;
				//   call void @builtin_write_port_s_eth_src_mac(%eth_axis_tx* %arg_3, i48 %16)
				arg_3_s_eth_src_mac_reg = load_tmp_10;
				//   call void @builtin_write_port_s_eth_type(%eth_axis_tx* %arg_3, i16 %18)
				arg_3_s_eth_type_reg = load_tmp_12;
			arg_3_s_eth_payload_axis_tdata_reg = 0;
			arg_3_s_eth_payload_axis_tlast_reg = 0;
			arg_3_s_eth_payload_axis_tuser_reg = 0;
			arg_3_s_eth_payload_axis_tvalid_reg = 0;
		end else begin 
			// Default values
				arg_3_s_eth_dest_mac_reg = 0;
				arg_3_s_eth_hdr_valid_reg = 0;
				arg_3_s_eth_payload_axis_tdata_reg = 0;
				arg_3_s_eth_payload_axis_tlast_reg = 0;
				arg_3_s_eth_payload_axis_tuser_reg = 0;
				arg_3_s_eth_payload_axis_tvalid_reg = 0;
				arg_3_s_eth_src_mac_reg = 0;
				arg_3_s_eth_type_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   call void @builtin_stall(i1 %12)
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %13 = getelementptr i48, i48* %9, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_14 = 0;
				gep_add_in1_getelementptr_14 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %14 = load i48, i48* %13
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_9_reg = getelementptr_out_getelementptr_14;
				end
				//   store i48 %4, i48* %9
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_9_reg = 0;
				wdata_ram_9_reg = rdata_ram_0;
				wen_ram_9_reg = 1;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %15 = getelementptr i48, i48* %10, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_16 = 0;
				gep_add_in1_getelementptr_16 = (32'd0);
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %16 = load i48, i48* %15
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_11_reg = getelementptr_out_getelementptr_16;
				end
				//   store i48 %6, i48* %10
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_11_reg = 0;
				wdata_ram_11_reg = rdata_ram_1;
				wen_ram_11_reg = 1;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %9 = alloca i48
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %10 = alloca i48
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %11 = alloca i16
				if (arg_3_s_eth_hdr_ready) begin
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i16 %8, i16* %11
				if (arg_3_s_eth_hdr_ready) begin
				waddr_ram_15_reg = 0;
				wdata_ram_15_reg = rdata_ram_3;
				wen_ram_15_reg = 1;
				end
				//   %18 = load i16, i16* %17
				if (arg_3_s_eth_hdr_ready) begin
				raddr_ram_15_reg = getelementptr_out_getelementptr_24;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %17 = getelementptr i16, i16* %11, i32 0
				if (arg_3_s_eth_hdr_ready) begin
				base_addr_getelementptr_24 = 0;
				gep_add_in1_getelementptr_24 = (32'd0);
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

module write_header_func(input [0:0] clk, input [0:0] rst, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, input [47:0] arg_0_out_data, input [47:0] arg_1_out_data, input [15:0] arg_2_out_data);


	initial begin
	end




	write_header_func_inner inner(.arg_0_out_data(arg_0_out_data), .arg_1_out_data(arg_1_out_data), .arg_2_out_data(arg_2_out_data), .arg_3_busy(arg_3_busy), .arg_3_m_axis_tready(arg_3_m_axis_tready), .arg_3_s_eth_dest_mac(arg_3_s_eth_dest_mac), .arg_3_s_eth_hdr_ready(arg_3_s_eth_hdr_ready), .arg_3_s_eth_hdr_valid(arg_3_s_eth_hdr_valid), .arg_3_s_eth_payload_axis_tdata(arg_3_s_eth_payload_axis_tdata), .arg_3_s_eth_payload_axis_tlast(arg_3_s_eth_payload_axis_tlast), .arg_3_s_eth_payload_axis_tready(arg_3_s_eth_payload_axis_tready), .arg_3_s_eth_payload_axis_tuser(arg_3_s_eth_payload_axis_tuser), .arg_3_s_eth_payload_axis_tvalid(arg_3_s_eth_payload_axis_tvalid), .arg_3_s_eth_src_mac(arg_3_s_eth_src_mac), .arg_3_s_eth_type(arg_3_s_eth_type), .clk(clk), .rst(rst), .valid(valid));

endmodule
