module write_header_func_inner(input [0:0] clk, input [0:0] rst, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, output [47:0] arg_0_raddr, output [47:0] arg_0_waddr, output [47:0] arg_0_wdata, output [0:0] arg_0_wen, input [47:0] arg_0_rdata, output [47:0] arg_1_raddr, output [47:0] arg_1_waddr, output [47:0] arg_1_wdata, output [0:0] arg_1_wen, input [47:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata, output [0:0] valid);

	reg [0:0] arg_3_m_axis_tready_reg;
	reg [47:0] arg_3_s_eth_dest_mac_reg;
	reg [0:0] arg_3_s_eth_hdr_valid_reg;
	reg [7:0] arg_3_s_eth_payload_axis_tdata_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tlast_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tuser_reg;
	reg [0:0] arg_3_s_eth_payload_axis_tvalid_reg;
	reg [47:0] arg_3_s_eth_src_mac_reg;
	reg [15:0] arg_3_s_eth_type_reg;
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

	assign arg_3_m_axis_tready = arg_3_m_axis_tready_reg;
	assign arg_3_s_eth_dest_mac = arg_3_s_eth_dest_mac_reg;
	assign arg_3_s_eth_hdr_valid = arg_3_s_eth_hdr_valid_reg;
	assign arg_3_s_eth_payload_axis_tdata = arg_3_s_eth_payload_axis_tdata_reg;
	assign arg_3_s_eth_payload_axis_tlast = arg_3_s_eth_payload_axis_tlast_reg;
	assign arg_3_s_eth_payload_axis_tuser = arg_3_s_eth_payload_axis_tuser_reg;
	assign arg_3_s_eth_payload_axis_tvalid = arg_3_s_eth_payload_axis_tvalid_reg;
	assign arg_3_s_eth_src_mac = arg_3_s_eth_src_mac_reg;
	assign arg_3_s_eth_type = arg_3_s_eth_type_reg;
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

	// Start debug wires and ports

	initial begin
	end





	// End debug wires and ports

	// Start Functional Units
	add call_1();

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
			end
			if ((global_state == 2)) begin
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
					global_state <= 2;
				end
			end
			if ((global_state == 2)) begin 
				// Next state transition logic
				// Condition = True

				if (1) begin
					global_state <= 2;
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
			if ((global_state == 2)) begin 
				// Temporary storage
				// Store data computed at the stage
			end
		end
	end


	// Start pipeline instruction code
	// Start pipeline stages
	// End pipeline instruction code

	// controller for arg_3.arg_3_s_eth_dest_mac_reg
	// controller for arg_3.arg_3_s_eth_hdr_valid_reg
	always @(*) begin
		if ((global_state == 1)) begin 
			if (1) begin
				arg_3_s_eth_hdr_valid_reg = (32'd1);
			end
		end else begin
			arg_3_s_eth_hdr_valid_reg = 0;
		end
	end
	// controller for arg_3.arg_3_s_eth_src_mac_reg
	// controller for arg_3.arg_3_s_eth_type_reg
	// Insensitive connections
	always @(*) begin
		arg_3_s_eth_dest_mac_reg = valid ? arg_0_rdata : arg_0_rdata;
		arg_3_s_eth_src_mac_reg = valid ? arg_1_rdata : arg_1_rdata;
		arg_3_s_eth_type_reg = valid ? arg_2_rdata : arg_2_rdata;
	end
	// Insensitive connections
	always @(*) begin
	end
	// controller for arg_0.arg_0_raddr_reg
	// Insensitive connections
	always @(*) begin
		arg_0_raddr_reg = valid ? arg_0_rdata : arg_0_rdata;
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
	// controller for ret_9.valid_reg
	always @(*) begin
		if ((global_state == 2)) begin 
			if (1) begin
				valid_reg = 1;
			end
		end else begin
			valid_reg = 0;
		end
	end
	// Insensitive connections
	always @(*) begin
	end
endmodule

module write_header_func(input [0:0] clk, input [0:0] rst, output [0:0] arg_3_m_axis_tready, output [47:0] arg_3_s_eth_dest_mac, output [0:0] arg_3_s_eth_hdr_valid, output [7:0] arg_3_s_eth_payload_axis_tdata, output [0:0] arg_3_s_eth_payload_axis_tlast, output [0:0] arg_3_s_eth_payload_axis_tuser, output [0:0] arg_3_s_eth_payload_axis_tvalid, output [47:0] arg_3_s_eth_src_mac, output [15:0] arg_3_s_eth_type, input [0:0] arg_3_busy, input [0:0] arg_3_s_eth_hdr_ready, input [0:0] arg_3_s_eth_payload_axis_tready, output [47:0] arg_0_raddr, output [47:0] arg_0_waddr, output [47:0] arg_0_wdata, output [0:0] arg_0_wen, input [47:0] arg_0_rdata, output [47:0] arg_1_raddr, output [47:0] arg_1_waddr, output [47:0] arg_1_wdata, output [0:0] arg_1_wen, input [47:0] arg_1_rdata, output [15:0] arg_2_raddr, output [15:0] arg_2_waddr, output [15:0] arg_2_wdata, output [0:0] arg_2_wen, input [15:0] arg_2_rdata, output [0:0] valid);


	initial begin
	end




	write_header_func_inner inner(.arg_0_raddr(arg_0_raddr), .arg_0_rdata(arg_0_rdata), .arg_0_waddr(arg_0_waddr), .arg_0_wdata(arg_0_wdata), .arg_0_wen(arg_0_wen), .arg_1_raddr(arg_1_raddr), .arg_1_rdata(arg_1_rdata), .arg_1_waddr(arg_1_waddr), .arg_1_wdata(arg_1_wdata), .arg_1_wen(arg_1_wen), .arg_2_raddr(arg_2_raddr), .arg_2_rdata(arg_2_rdata), .arg_2_waddr(arg_2_waddr), .arg_2_wdata(arg_2_wdata), .arg_2_wen(arg_2_wen), .arg_3_busy(arg_3_busy), .arg_3_m_axis_tready(arg_3_m_axis_tready), .arg_3_s_eth_dest_mac(arg_3_s_eth_dest_mac), .arg_3_s_eth_hdr_ready(arg_3_s_eth_hdr_ready), .arg_3_s_eth_hdr_valid(arg_3_s_eth_hdr_valid), .arg_3_s_eth_payload_axis_tdata(arg_3_s_eth_payload_axis_tdata), .arg_3_s_eth_payload_axis_tlast(arg_3_s_eth_payload_axis_tlast), .arg_3_s_eth_payload_axis_tready(arg_3_s_eth_payload_axis_tready), .arg_3_s_eth_payload_axis_tuser(arg_3_s_eth_payload_axis_tuser), .arg_3_s_eth_payload_axis_tvalid(arg_3_s_eth_payload_axis_tvalid), .arg_3_s_eth_src_mac(arg_3_s_eth_src_mac), .arg_3_s_eth_type(arg_3_s_eth_type), .clk(clk), .rst(rst), .valid(valid));

endmodule
