`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end

`define POSEDGE #1 clk = 0; #1 clk = 0; #1 clk = 1; #1 clk = 1;


module test();

   reg clk;
   reg rst;

   wire valid;

   wire read_valid0;
   wire  read_ready0;

   wire write_ready0;
   reg  write_valid0;

   reg [31 : 0]  in_data0;
   wire [31 : 0] out_data0;

   reg read_valid1;
   wire  read_ready1;

   wire write_ready1;
   wire  write_valid1;

   wire [31 : 0]  in_data1;
   wire [31 : 0] out_data1;
   
   initial begin

      #1 rst = 1;

      `POSEDGE

        #1 rst = 0;
      

      #1 `assert(write_ready0, 1'd1)
      #1 `assert(read_ready0, 1'd0)

      #1 in_data0 = 1;
      #1 write_valid0 = 1;

      #1 read_valid1 = 0;

      `POSEDGE

      #1 `assert(read_ready0, 1'd1)

      #1 in_data0 = 2;
      #1 write_valid0 = 1;
      
      `POSEDGE

      #1 in_data0 = 3;
      #1 write_valid0 = 1;
      
      `POSEDGE
        
        #1 write_valid0 = 0;
        
      `POSEDGE

      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE
      `POSEDGE

      `POSEDGE        

      #1 `assert(write_ready0, 1'd1)
      #1 `assert(valid, 1'd1)

      `POSEDGE        

        #1 read_valid1 = 1;

      `POSEDGE        

        #1 `assert(out_data1, (2 + 1) + 1)      
        #1 read_valid1 = 1;

      `POSEDGE        

        #1 `assert(out_data1, (2 + 2) + 2)
        #1 read_valid1 = 1;
      
      `POSEDGE        

        #1 `assert(out_data1, (2 + 3) + 3)
      #1 read_valid1 = 0;
      
      `POSEDGE

      #1 $display("Passed");

   end // initial begin

   always @(posedge clk) begin
      $display("in_data0  = %d", in_data0);      
      $display("out_data0 = %d", out_data0);
      $display("out_data1 = %d", out_data1);
      $display("read_ready0 = %d", read_ready0);            
   end

   fifo #(.WIDTH(32), .DEPTH(16)) in(.clk(clk), .rst(rst), .read_valid(read_valid0), .read_ready(read_ready0), .write_ready(write_ready0), .write_valid(write_valid0), .out_data(out_data0), .in_data(in_data0));

   fifo #(.WIDTH(32), .DEPTH(16)) out(.clk(clk), .rst(rst), .read_valid(read_valid1), .read_ready(read_ready1), .write_ready(write_ready1), .write_valid(write_valid1), .out_data(out_data1), .in_data(in_data1));
   
   fifo_in_loop user(.clk(clk), .rst(rst), .valid(valid),

                     .arg_0_out_data(out_data0),
                     .arg_0_read_valid(read_valid0),
                     .arg_0_read_ready(read_ready0),

                     .fifo_1_in_data(in_data1),
                     .fifo_1_write_valid(write_valid1),
                     .fifo_1_write_ready(write_ready1)
                     );
   
   
endmodule
