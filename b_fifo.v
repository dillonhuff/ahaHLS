module b_fifo(input clk,
            input                  rst,

            input                  read_valid,
            output                 read_ready,

            input                  write_valid,
            output                 write_ready,
            
            input [WIDTH - 1 : 0]  in_data,
            output [WIDTH - 1 : 0] out_data);
   
   parameter WIDTH = 32;
   parameter DEPTH = 16;

   reg [WIDTH - 1 : 0]               ram [DEPTH - 1 : 0];

   reg                               empty;

   reg [$clog2(DEPTH) - 1 : 0]                write_addr;
   reg [$clog2(DEPTH) - 1 : 0]                read_addr;
   wire [$clog2(DEPTH) - 1 : 0]                next_read_addr;
   wire [$clog2(DEPTH) - 1 : 0]                next_write_addr;

   always @(posedge clk) begin
      if (!rst) begin
         if (write_valid) begin

            $display("writing %d to address %d", in_data, write_addr);
//            $display("write_addr = %b, next_write_addr = %b, depth = %b", write_addr, next_write_addr, DEPTH);            
            
            `assert(write_ready, 1'd1)

            ram[write_addr] <= in_data;
            write_addr <= next_write_addr;

            empty <= 0;
         end
      end
   end


   
   assign next_read_addr = (DEPTH == (read_addr + 1)) ? 0 : read_addr + 1;
   assign next_write_addr = (DEPTH == (write_addr + 1)) ? 0 : write_addr + 1;

   always @(posedge clk) begin
      if (!rst) begin
         if (read_valid) begin
            `assert(read_ready, 1'd1)

//            $display("reading %d, from address %d", ram[read_addr], read_addr);            

            // Wraparound
            read_addr <= next_read_addr;

            if (!empty && (next_read_addr == write_addr) && !write_valid) begin
//               $display("FIFO empty: next_read_addr = %d, write_addr = %d", next_read_addr, write_addr);
               empty <= 1;
            end
         end
      end
   end

   reg [WIDTH - 1 : 0] out_data_reg;

   always @(posedge clk) begin
      if (read_valid) begin
         out_data_reg <= ram[read_addr];
      end
   end

   assign out_data = out_data_reg;
   
   assign full = !empty && (write_addr == read_addr);
   assign write_ready = !full;

   // always @(posedge clk) begin
   //    $display("empty = %d", empty);
   //    $display("full  = %d", full);      
   // end

   assign read_ready = !empty;

   always @(posedge clk) begin
      if (rst) begin
         empty <= 1;

//         $display("reseting");
         write_addr <= 0;
         read_addr <= 0;

      end
   end
   
endmodule
