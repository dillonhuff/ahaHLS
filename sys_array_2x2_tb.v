`define assert(signal, value) if ((signal) !== (value)) begin $display("ASSERTION FAILED in %m: signal != value"); $finish(1); end
`define POSEDGE #1 clk = 0; #1 clk = 1;

module sys_array_2x2_tb();

   reg [0:0] rst;
   reg [0:0] clk;
   wire [0:0] valid;

   wire            read_valid0;
   wire            read_ready0;   
   reg            write_valid0;
   wire            write_ready0;
   reg [15:0]     in_data0;
   wire [15:0]     out_data0;

   wire           read_valid1;
   wire            read_ready1;   
   reg            write_valid1;
   wire            write_ready1;
   reg [15:0]     in_data1;
   wire [15:0]     out_data1;

   wire           read_valid2;
   wire            read_ready2;   
   reg            write_valid2;
   wire            write_ready2;
   reg [15:0]     in_data2;
   wire [15:0]     out_data2;

   wire           read_valid3;
   wire            read_ready3;   
   reg            write_valid3;
   wire            write_ready3;
   reg [15:0]     in_data3;
   wire [15:0]     out_data3;

   reg           read_valid4;
   wire            read_ready4;   
   wire            write_valid4;
   wire            write_ready4;
   wire [15:0]     in_data4;
   wire [15:0]     out_data4;

   reg            read_valid5;
   wire            read_ready5;   
   wire            write_valid5;
   wire            write_ready5;
   wire [15:0]     in_data5;
   wire [15:0]     out_data5;
   
	initial begin
	   #1 rst = 1;

           #1 write_valid0 = 0;
           #1 write_valid1 = 0;
           #1 write_valid2 = 0;           
           #1 write_valid3 = 0;           

           #1 read_valid4 = 0;
           #1 read_valid5 = 0;                      
           
           `POSEDGE
             
             #1 rst = 0;

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

           #1 write_valid0 = 1;
           #1 write_valid1 = 1;
           #1 write_valid2 = 1;
           #1 write_valid3 = 1;
           
           #1 in_data0 = 1;
           #1 in_data1 = 2;
           #1 in_data2 = 3;           
           #1 in_data3 = 4;

           `POSEDGE

             `assert(valid, 1'b1)
             
             $display("Passed");
           
	end

   fifo #(.WIDTH(16), .DEPTH(8)) fifo0(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid0),
                                       .write_valid(write_valid0),
                                       .read_ready(read_ready0),
                                       .write_ready(write_ready0),
                                       .in_data(in_data0),
                                       .out_data(out_data0));

   fifo #(.WIDTH(16), .DEPTH(8)) fifo1(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid1),
                                       .write_valid(write_valid1),
                                       .read_ready(read_ready1),
                                       .write_ready(write_ready1),
                                       .in_data(in_data1),
                                       .out_data(out_data1));

   fifo #(.WIDTH(16), .DEPTH(8)) fifo2(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid2),
                                       .write_valid(write_valid2),
                                       .read_ready(read_ready2),
                                       .write_ready(write_ready2),
                                       .in_data(in_data2),
                                       .out_data(out_data2));

   fifo #(.WIDTH(16), .DEPTH(8)) fifo3(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid3),
                                       .write_valid(write_valid3),
                                       .read_ready(read_ready3),
                                       .write_ready(write_ready3),
                                       .in_data(in_data3),
                                       .out_data(out_data3));

   fifo #(.WIDTH(16), .DEPTH(8)) fifo4(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid4),
                                       .write_valid(write_valid4),
                                       .read_ready(read_ready4),
                                       .write_ready(write_ready4),
                                       .in_data(in_data4),
                                       .out_data(out_data4));

   fifo #(.WIDTH(16), .DEPTH(8)) fifo5(.clk(clk),
                                       .rst(rst),
                                       .read_valid(read_valid5),
                                       .write_valid(write_valid5),
                                       .read_ready(read_ready5),
                                       .write_ready(write_ready5),
                                       .in_data(in_data5),
                                       .out_data(out_data5));
   
   
   sys_array_2x2 dut(.clk(clk), .rst(rst), .valid(valid),

                     .fifo_0_out_data(out_data0),
                     .fifo_0_read_valid(read_valid0),
                     .fifo_0_read_ready(read_ready0),                

                     .fifo_1_out_data(out_data1),
                     .fifo_1_read_valid(read_valid1),
                     .fifo_1_read_ready(read_ready1),                

                     .fifo_2_out_data(out_data2),
                     .fifo_2_read_valid(read_valid2),
                     .fifo_2_read_ready(read_ready2),                

                     .fifo_3_out_data(out_data3),
                     .fifo_3_read_valid(read_valid3),
                     .fifo_3_read_ready(read_ready3),

                     .fifo_4_in_data(in_data4),
                     .fifo_4_write_valid(write_valid4),
                     .fifo_4_write_ready(write_ready4),

                     .fifo_5_in_data(in_data5),
                     .fifo_5_write_valid(write_valid5),
                     .fifo_5_write_ready(write_ready5)
                     
                     );


endmodule
