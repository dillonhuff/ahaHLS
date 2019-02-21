`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 1;
module test();

   reg clk;
   reg rst;
   wire valid;
   

   // Depth 16, width 32 RAM
   wire [3:0] raddr;
   wire [3:0] waddr;
   wire [63:0] wdata;
   wire [0:0] wen;

   reg [3:0] debug_addr;
   wire [63:0] debug_data;

   reg [3:0]   debug_write_addr;
   reg [63:0]  debug_write_data;
   reg  debug_write_en;
   
   
   wire [63:0] rdata;

   reg [63:0]  expected;
   
   
   initial begin

      #1 expected = {32'd2 + 32'd7, 32'd8 + 32'd9};
      
      #1 rst = 1;
      #1 debug_write_en = 1;
      #1 debug_write_addr = 0;
      #1 debug_write_data = {32'd2, 32'd8};
      

      `POSEDGE
        
      #1 debug_write_en = 1;
      #1 debug_write_addr = 1;
      #1 debug_write_data = {32'd7, 32'd9};
      
      `POSEDGE

        #1 debug_write_en = 0;
                            
      #1 debug_addr = 3;

      #1 clk = 0;
      #1 rst = 1;
      #1 clk = 1;

      // In global state 0
      #1 `assert(debug_data, 64'hxxxxxxxx)
      #1 `assert(valid, 1'd0)
      
      #1 rst = 0;

      #1 clk = 0;
      #1 clk = 1;

      // In global state 1
      #1 `assert(debug_data, 64'hxxxxxxxx)
      #1 `assert(valid, 1'd0)
      
      #1 clk = 0;
      #1 clk = 1;

      // In global state 2
      #1 `assert(debug_data, 64'hxxxxxxxx)
      #1 `assert(valid, 1'd0)

      #1 clk = 0;
      #1 clk = 1;

      // In global state 3

      `POSEDGE

        #1 $display("debug_data = %b", debug_data);
        
        // gs 4
      `POSEDGE

        // gs 5, done

        #1 $display("debug_data = %b", debug_data);
      
      #1 `assert(valid, 1'd1)
      #1 `assert(debug_data, expected)
        
      `POSEDGE

      `POSEDGE

      `POSEDGE        

      #1 clk = 0;
      #1 clk = 1;

      // #1 `assert(debug_data, expected)
      #1 `assert(valid, 1'd1) 
      
      #1 $display("Passed");

   end

   RAM #(.WIDTH(64), .DEPTH(16)) mem(.clk(clk),
           .rst(rst),
           .raddr_0(raddr),
           .rdata_0(rdata),
           .wen_0(wen),
           .wdata_0(wdata),
           .waddr_0(waddr),
           .debug_addr(debug_addr),
           .debug_data(debug_data),

           .debug_write_addr(debug_write_addr),
           .debug_write_data(debug_write_data),
           .debug_write_en(debug_write_en));
   
   
   complex_num ss(.clk(clk), .rst(rst), .valid(valid), .ram_waddr_0(waddr), .ram_wdata_0(wdata), .ram_wen_0(wen), .ram_raddr_0(raddr), .ram_rdata_0(rdata));
   
endmodule
