module write_header_func_inner(input [0:0] clk, input [0:0] rst, output [47:0] arg_0_raddr, output [47:0] arg_0_waddr, output [47:0] arg_0_wdata, output [0:0] arg_0_wen, input [47:0] arg_0_rdata, output [47:0] arg_1_raddr, output [47:0] arg_1_waddr, output [47:0] arg_1_wdata, output [0:0] arg_1_wen, input [47:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready);

	reg [47:0] arg_0_raddr_reg;
	reg [47:0] arg_0_waddr_reg;
	reg [47:0] arg_0_wdata_reg;
	reg [0:0] arg_0_wen_reg;
	reg [47:0] arg_1_raddr_reg;
	reg [47:0] arg_1_waddr_reg;
	reg [47:0] arg_1_wdata_reg;
	reg [0:0] arg_1_wen_reg;
	reg [15:0] arg_2_raddr_reg;
	reg [15:0] arg_2_waddr_reg;
	reg [15:0] arg_2_wdata_reg;
	reg [0:0] arg_2_wen_reg;
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

	assign arg_0_raddr = arg_0_raddr_reg;
	assign arg_0_waddr = arg_0_waddr_reg;
	assign arg_0_wdata = arg_0_wdata_reg;
	assign arg_0_wen = arg_0_wen_reg;
	assign arg_1_raddr = arg_1_raddr_reg;
	assign arg_1_waddr = arg_1_waddr_reg;
	assign arg_1_wdata = arg_1_wdata_reg;
	assign arg_1_wen = arg_1_wen_reg;
	assign arg_2_raddr = arg_2_raddr_reg;
	assign arg_2_waddr = arg_2_waddr_reg;
	assign arg_2_wdata = arg_2_wdata_reg;
	assign arg_2_wen = arg_2_wen_reg;
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
	add alloca_1();

	reg [31:0] raddr_ram_1_reg;
	reg [31:0] waddr_ram_1_reg;
	reg [47:0] wdata_ram_1_reg;
	reg [0:0] wen_ram_1_reg;
	wire [47:0] rdata_ram_1;
	reg_passthrough #(.WIDTH(48)) ram_1(.clk(clk), .raddr(raddr_ram_1_reg), .rdata(rdata_ram_1), .rst(rst), .waddr(waddr_ram_1_reg), .wdata(wdata_ram_1_reg), .wen(wen_ram_1_reg));

	add alloca_4();

	reg [31:0] raddr_ram_4_reg;
	reg [31:0] waddr_ram_4_reg;
	reg [15:0] wdata_ram_4_reg;
	reg [0:0] wen_ram_4_reg;
	wire [15:0] rdata_ram_4;
	reg_passthrough #(.WIDTH(16)) ram_4(.clk(clk), .raddr(raddr_ram_4_reg), .rdata(rdata_ram_4), .rst(rst), .waddr(waddr_ram_4_reg), .wdata(wdata_ram_4_reg), .wen(wen_ram_4_reg));

	add alloca_5();

	reg [31:0] raddr_ram_5_reg;
	reg [31:0] waddr_ram_5_reg;
	reg [47:0] wdata_ram_5_reg;
	reg [0:0] wen_ram_5_reg;
	wire [47:0] rdata_ram_5;
	reg_passthrough #(.WIDTH(48)) ram_5(.clk(clk), .raddr(raddr_ram_5_reg), .rdata(rdata_ram_5), .rst(rst), .waddr(waddr_ram_5_reg), .wdata(wdata_ram_5_reg), .wen(wen_ram_5_reg));

	add call_7();

	// End Functional Units

	// Start instruction result storage
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
				if (arg_3_s_eth_hdr_ready) begin
				// Store data computed at the stage
				end
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
				//   %0 = load i48, i48* %arg_0
				if (arg_3_s_eth_hdr_ready) begin
				arg_0_raddr_reg = arg_0_rdata;
				end
			arg_0_wen_reg = 0;
		end else begin 
			// Default values
				arg_0_wen_reg = 0;
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %1 = alloca i48
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %2 = load i48, i48* %arg_1
				if (arg_3_s_eth_hdr_ready) begin
				arg_1_raddr_reg = arg_1_rdata;
				end
			arg_1_wen_reg = 0;
		end else begin 
			// Default values
				arg_1_wen_reg = 0;
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %4 = load i16, i16* %arg_2
				if (arg_3_s_eth_hdr_ready) begin
				arg_2_raddr_reg = arg_2_rdata;
				end
			arg_2_wen_reg = 0;
		end else begin 
			// Default values
				arg_2_wen_reg = 0;
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %5 = alloca i16
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %3 = alloca i48
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %6 = call i1 @builtin_read_port_s_eth_hdr_ready(%eth_axis_tx* %arg_3)
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
				//   call void @builtin_write_port_s_eth_dest_mac(%eth_axis_tx* %arg_3, i48 %7)
				arg_3_s_eth_dest_mac_reg = rdata_ram_1;
				//   call void @builtin_write_port_s_eth_src_mac(%eth_axis_tx* %arg_3, i48 %8)
				arg_3_s_eth_src_mac_reg = rdata_ram_5;
				//   call void @builtin_write_port_s_eth_type(%eth_axis_tx* %arg_3, i16 %9)
				arg_3_s_eth_type_reg = rdata_ram_4;
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
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   call void @builtin_stall(i1 %6)
	end
	always @(*) begin
		if ((global_state == 1)) begin 
				//   store i48 %0, i48* %1
				waddr_ram_1_reg = 0;
				wdata_ram_1_reg = arg_0_rdata;
				wen_ram_1_reg = 1;
				//   %7 = load i48, i48* %1
				raddr_ram_1_reg = 0;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 1)) begin 
				//   store i16 %4, i16* %5
				waddr_ram_4_reg = 0;
				wdata_ram_4_reg = arg_2_rdata;
				wen_ram_4_reg = 1;
				//   %9 = load i16, i16* %5
				raddr_ram_4_reg = 0;
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 1)) begin 
				//   store i48 %2, i48* %3
				waddr_ram_5_reg = 0;
				wdata_ram_5_reg = arg_1_rdata;
				wen_ram_5_reg = 1;
				//   %8 = load i48, i48* %3
				raddr_ram_5_reg = 0;
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

module write_header_func(input [0:0] clk, input [0:0] rst, output [47:0] arg_0_raddr, output [47:0] arg_0_waddr, output [47:0] arg_0_wdata, output [0:0] arg_0_wen, input [47:0] arg_0_rdata, output [47:0] arg_1_raddr, output [47:0] arg_1_waddr, output [47:0] arg_1_wdata, output [0:0] arg_1_wen, input [47:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata, output [0:0] valid, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready);


	initial begin
	end




	write_header_func_inner inner(.arg_0_raddr(arg_0_raddr), .arg_0_rdata(arg_0_rdata), .arg_0_waddr(arg_0_waddr), .arg_0_wdata(arg_0_wdata), .arg_0_wen(arg_0_wen), .arg_1_raddr(arg_1_raddr), .arg_1_rdata(arg_1_rdata), .arg_1_waddr(arg_1_waddr), .arg_1_wdata(arg_1_wdata), .arg_1_wen(arg_1_wen), .arg_2_raddr(arg_2_raddr), .arg_2_rdata(arg_2_rdata), .arg_2_waddr(arg_2_waddr), .arg_2_wdata(arg_2_wdata), .arg_2_wen(arg_2_wen), .arg_3_busy(arg_3_busy), .arg_3_m_axis_tready(arg_3_m_axis_tready), .arg_3_s_eth_dest_mac(arg_3_s_eth_dest_mac), .arg_3_s_eth_hdr_ready(arg_3_s_eth_hdr_ready), .arg_3_s_eth_hdr_valid(arg_3_s_eth_hdr_valid), .arg_3_s_eth_payload_axis_tdata(arg_3_s_eth_payload_axis_tdata), .arg_3_s_eth_payload_axis_tlast(arg_3_s_eth_payload_axis_tlast), .arg_3_s_eth_payload_axis_tready(arg_3_s_eth_payload_axis_tready), .arg_3_s_eth_payload_axis_tuser(arg_3_s_eth_payload_axis_tuser), .arg_3_s_eth_payload_axis_tvalid(arg_3_s_eth_payload_axis_tvalid), .arg_3_s_eth_src_mac(arg_3_s_eth_src_mac), .arg_3_s_eth_type(arg_3_s_eth_type), .clk(clk), .rst(rst), .valid(valid));

endmodule
