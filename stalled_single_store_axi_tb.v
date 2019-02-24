`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end


// Significant problem in indenpendent testing of stalls: If the module issues
// a memory operation to the external mem that takes 3 cycles and then stalls
// for 5 cycles the memory operation will complete, passing data back to the
// module, but the module itself will not save the result of the completed operation
// because it is stalled
module test();

   reg clk;
   reg rst;
   wire valid;

   parameter ADDR_WIDTH = 5;
   parameter DATA_WIDTH = 32;
   parameter STRB_WIDTH = (DATA_WIDTH/8);   

   // --- AXI Vars   
   // Not used   
   wire[2:0]            s_axil_awprot;
   // Not used
   wire[2:0]            s_axil_arprot;

   wire [31:0]          global_state_dbg;

   wire [ADDR_WIDTH-1:0] s_axil_awaddr;

   wire [DATA_WIDTH-1:0] s_axil_wdata;
   wire [STRB_WIDTH-1:0] s_axil_wstrb;
   wire                  s_axil_wvalid;
   wire                  s_axil_bready;

   wire [ADDR_WIDTH-1:0] s_axil_araddr;
   wire                 s_axil_arvalid;
   wire                   s_axil_rready;

   
   wire                 s_axil_awready;
   wire                 s_axil_wready;
   wire [1:0]           s_axil_bresp;
   wire                 s_axil_bvalid;


   wire                 s_axil_arready;
   wire [DATA_WIDTH-1:0] s_axil_rdata;
   wire [1:0]            s_axil_rresp;
   wire                  s_axil_rvalid;

   // Depth 16, width 32 RAM
   wire [4:0] raddr;
   wire [4:0] waddr;
   wire [31:0] wdata;
   wire [0:0] wen;

   reg [4:0] debug_addr;
   wire [31:0] debug_data;

   reg [4:0]  debug_write_addr;
   reg [31:0] debug_write_data;
   reg        debug_write_en;
   
   wire [31:0] rdata;

   initial begin

      #1 debug_addr = 0;

      #1 rst = 1;

      #1 clk = 0;
      #1 clk = 1;

      // Still in reset      
      #1 debug_write_addr = 1;
      #1 debug_write_data = 10;
      #1 debug_write_en = 1;


      #1 clk = 0;
      #1 clk = 1;

      // GS == 0

      #1 debug_write_en = 0;
      #1 rst = 0;

      $display("debug_data = %d", debug_data);


      #1 clk = 0;
      #1 clk = 1;

      // GS == 1      

      #1 clk = 0;
      #1 clk = 1;

      // GS == 2

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd0)
      
      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 `assert(valid, 1'd0)
      
      #1 clk = 0;
      #1 clk = 1;
      
      $display("debug_data = %d", debug_data);
      
      // In global state 3, we should be done, but reads have a delay of one
//      #1 `assert(valid, 1'd0)

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 $display("Debug data = %d", debug_data);      

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;

      #1 clk = 0;
      #1 clk = 1;
      
      #1 `assert(valid, 1'd1)
      #1 `assert(debug_data, 20)

      #1 $display("Passed");

   end

   axil_ram #(.DATA_WIDTH(32), .ADDR_WIDTH(5))
   ram(.clk(clk),
       .rst(rst),

       // Debug ports
       .debug_addr(debug_addr),
       .debug_data(debug_data),
       .debug_wr_addr(debug_write_addr),
       .debug_wr_data(debug_write_data),
       .debug_wr_en(debug_write_en),
       // End debug ports

       .s_axil_awprot(s_axil_awprot),
       .s_axil_arprot(s_axil_arprot),

       .s_axil_awaddr(s_axil_awaddr),       
       .s_axil_awvalid(s_axil_awvalid),

       .s_axil_awready(s_axil_awready),
       .s_axil_wdata(s_axil_wdata),

       .s_axil_wstrb(s_axil_wstrb),
       .s_axil_wvalid(s_axil_wvalid),

       .s_axil_wready(s_axil_wready),
       .s_axil_bresp(s_axil_bresp),

       .s_axil_bvalid(s_axil_bvalid),

       .s_axil_bready(s_axil_bready),
       .s_axil_araddr(s_axil_araddr),

       .s_axil_arvalid(s_axil_arvalid),
       .s_axil_arready(s_axil_arready),

       .s_axil_rdata(s_axil_rdata),
       .s_axil_rresp(s_axil_rresp),

       .s_axil_rvalid(s_axil_rvalid),
       .s_axil_rready(s_axil_rready));

   wire [31: 0] reader_read_data;
   wire [4 : 0] reader_read_addr;
   wire         reader_start_read;
   wire         reader_ready;
   wire         reader_valid;
   
   axi_read_handler reader(.clk(clk), .rst(rst),
                           .read_data(reader_read_data),
                           .read_addr(reader_read_addr),
                           .start_read(reader_start_read),
                           .ready(reader_ready),
                           .valid(reader_valid),

                           .s_axil_araddr(s_axil_araddr),

                           .s_axil_arvalid(s_axil_arvalid),
                           .s_axil_arready(s_axil_arready),

                           .s_axil_rdata(s_axil_rdata),
                           .s_axil_rresp(s_axil_rresp),

                           .s_axil_rvalid(s_axil_rvalid),
                           .s_axil_rready(s_axil_rready));
                           

   wire [31: 0] writer_write_data;
   wire [4 : 0] writer_write_addr;
   wire         writer_start_write;
   wire         writer_ready;
   wire         writer_valid;

   always @(posedge clk) begin
      $display("global state = %d, reader_start_read = %d", global_state_dbg, reader_start_read);
      
   end
   
   axi_write_handler writer(.clk(clk), .rst(rst),
                            .write_data(writer_write_data),
                            .write_addr(writer_write_addr),
                            .start_write(writer_start_writer),
                            .ready(writer_ready),
                            .valid(writer_valid),

                            .s_axil_awvalid(s_axil_awvalid),
                            .s_axil_wvalid(s_axil_wvalid),
                            .s_axil_wdata(s_axil_wdata),
                            .s_axil_awaddr(s_axil_awaddr),
                            
                            .s_axil_bvalid(s_axil_bvalid),
                            .s_axil_bresp(s_axil_bresp),
                            .s_axil_wstrb(s_axil_wstrb),
                            .s_axil_bready(s_axil_bready));

   stalled_single_store_axi ss(.clk(clk),
                               .rst(rst),
                               .valid(valid),

                               .global_state_dbg(global_state_dbg),

                               .reader_read_data(reader_read_data),
                               .reader_read_addr(reader_read_addr),
                               .reader_start_read(reader_start_read),
                               .reader_ready(reader_ready),
                               .reader_valid(reader_valid),
                               
                               .writer_write_data(writer_write_data),
                               .writer_write_addr(writer_write_addr),
                               .writer_start_write(writer_start_writer),
                               .writer_ready(writer_ready),
                               .writer_valid(writer_valid));
   

                               // .s_axil_awprot(s_axil_awprot),
                               // .s_axil_arprot(s_axil_arprot),

                               // .s_axil_awaddr(s_axil_awaddr),       
                               // .s_axil_awvalid(s_axil_awvalid),

                               // .s_axil_awready(s_axil_awready),
                               // .s_axil_wdata(s_axil_wdata),

                               // .s_axil_wstrb(s_axil_wstrb),
                               // .s_axil_wvalid(s_axil_wvalid),

                               // .s_axil_wready(s_axil_wready),
                               // .s_axil_bresp(s_axil_bresp),

                               // .s_axil_bvalid(s_axil_bvalid),

                               // .s_axil_bready(s_axil_bready),
                               // .s_axil_araddr(s_axil_araddr),

                               // .s_axil_arvalid(s_axil_arvalid),
                               // .s_axil_arready(s_axil_arready),

                               // .s_axil_rdata(s_axil_rdata),
                               // .s_axil_rresp(s_axil_rresp),

                               // .s_axil_rvalid(s_axil_rvalid),
                               // .s_axil_rready(s_axil_rready));

endmodule
