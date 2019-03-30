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

	reg [31:0] raddr_ram_1_reg;
	reg [31:0] waddr_ram_1_reg;
	reg [0:0] wdata_ram_1_reg;
	reg [0:0] wen_ram_1_reg;
	wire [0:0] rdata_ram_1;
	reg_passthrough #(.WIDTH(1)) ram_1(.clk(clk), .raddr(raddr_ram_1_reg), .rdata(rdata_ram_1), .rst(rst), .waddr(waddr_ram_1_reg), .wdata(wdata_ram_1_reg), .wen(wen_ram_1_reg));

	add alloca_3();

	add alloca_6();

	add alloca_7();

	reg [31:0] raddr_ram_4_reg;
	reg [31:0] waddr_ram_4_reg;
	reg [7:0] wdata_ram_4_reg;
	reg [0:0] wen_ram_4_reg;
	wire [7:0] rdata_ram_4;
	reg_passthrough #(.WIDTH(8)) ram_4(.clk(clk), .raddr(raddr_ram_4_reg), .rdata(rdata_ram_4), .rst(rst), .waddr(waddr_ram_4_reg), .wdata(wdata_ram_4_reg), .wen(wen_ram_4_reg));

	reg [31:0] raddr_ram_5_reg;
	reg [31:0] waddr_ram_5_reg;
	reg [0:0] wdata_ram_5_reg;
	reg [0:0] wen_ram_5_reg;
	wire [0:0] rdata_ram_5;
	reg_passthrough #(.WIDTH(1)) ram_5(.clk(clk), .raddr(raddr_ram_5_reg), .rdata(rdata_ram_5), .rst(rst), .waddr(waddr_ram_5_reg), .wdata(wdata_ram_5_reg), .wen(wen_ram_5_reg));

	add call_11();

	// End Functional Units

	// Start instruction result storage
	reg [0:0] load_tmp_3;
	reg [7:0] load_tmp_4;
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
				if (arg_2_s_eth_payload_axis_tready) begin 
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
				if (arg_2_s_eth_payload_axis_tready) begin
				// Store data computed at the stage
					load_tmp_3 <= rdata_ram_5;
					load_tmp_4 <= rdata_ram_4;
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

	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %0 = alloca i8
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i8 %arg_0, i8* %0
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_0_reg = 0;
				wdata_ram_0_reg = arg_0_out_data;
				wen_ram_0_reg = 1;
				end
				//   %2 = load i8, i8* %0
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_0_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %3 = load i1, i1* %1
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_1_reg = 0;
				end
				//   store i1 %arg_1, i1* %1
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_1_reg = 0;
				wdata_ram_1_reg = arg_1_out_data;
				wen_ram_1_reg = 1;
				end
		end else begin 
			// Default values
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %1 = alloca i1
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %5 = alloca i1
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   %4 = alloca i8
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i8 %2, i8* %4
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_4_reg = 0;
				wdata_ram_4_reg = rdata_ram_0;
				wen_ram_4_reg = 1;
				end
				//   %8 = load i8, i8* %4
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_4_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   store i1 %3, i1* %5
				if (arg_2_s_eth_payload_axis_tready) begin
				waddr_ram_5_reg = 0;
				wdata_ram_5_reg = rdata_ram_1;
				wen_ram_5_reg = 1;
				end
				//   %7 = load i1, i1* %5
				if (arg_2_s_eth_payload_axis_tready) begin
				raddr_ram_5_reg = 0;
				end
		end else begin 
			// Default values
		end
	end
	always @(*) begin
		if ((global_state == 0)) begin 
				//   %6 = call i1 @builtin_read_port_s_eth_payload_axis_tready(%eth_axis_tx* %arg_2)
				if (arg_2_s_eth_payload_axis_tready) begin
				end
			arg_2_s_eth_dest_mac_reg = 0;
			arg_2_s_eth_hdr_valid_reg = 0;
			arg_2_s_eth_payload_axis_tdata_reg = 0;
			arg_2_s_eth_payload_axis_tlast_reg = 0;
			arg_2_s_eth_payload_axis_tuser_reg = 0;
			arg_2_s_eth_payload_axis_tvalid_reg = 0;
			arg_2_s_eth_src_mac_reg = 0;
			arg_2_s_eth_type_reg = 0;
		end else 		if ((global_state == 1)) begin 
				//   call void @builtin_write_port_s_eth_payload_axis_tvalid(%eth_axis_tx* %arg_2, i32 1)
				arg_2_s_eth_payload_axis_tvalid_reg = (32'd1);
				//   call void @builtin_write_port_s_eth_payload_axis_tlast(%eth_axis_tx* %arg_2, i1 %7)
				arg_2_s_eth_payload_axis_tlast_reg = load_tmp_3;
				//   call void @builtin_write_port_s_eth_payload_axis_tdata(%eth_axis_tx* %arg_2, i8 %8)
				arg_2_s_eth_payload_axis_tdata_reg = load_tmp_4;
			arg_2_s_eth_dest_mac_reg = 0;
			arg_2_s_eth_hdr_valid_reg = 0;
			arg_2_s_eth_payload_axis_tuser_reg = 0;
			arg_2_s_eth_src_mac_reg = 0;
			arg_2_s_eth_type_reg = 0;
		end else begin 
			// Default values
				arg_2_s_eth_dest_mac_reg = 0;
				arg_2_s_eth_hdr_valid_reg = 0;
				arg_2_s_eth_payload_axis_tdata_reg = 0;
				arg_2_s_eth_payload_axis_tlast_reg = 0;
				arg_2_s_eth_payload_axis_tuser_reg = 0;
				arg_2_s_eth_payload_axis_tvalid_reg = 0;
				arg_2_s_eth_src_mac_reg = 0;
				arg_2_s_eth_type_reg = 0;
		end
	end
	// No controller needed, just assigning to only used values
	always @(*) begin
				//   call void @builtin_stall(i1 %6)
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
