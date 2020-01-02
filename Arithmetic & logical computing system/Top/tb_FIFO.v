// FIFO Testbench
`timescale 1ns/100ps

module tb_FIFO;
   reg clk, reset_n, rd_en, wr_en;
   reg [31:0] din;
   wire rd_ack, wr_err, rd_err;
   wire [31:0] dout;
   
   FIFO U0_FIFO(clk, reset_n, rd_en, wr_en, din, dout, rd_ack, wr_err, rd_err);
   
   always#5 clk = ~clk;
   
   initial
   begin
            
		#0; clk = 0; reset_n = 0; rd_en = 0; wr_en = 0; din = 32'b0; 
      
      //WRITE
      #7;   reset_n = 1'b1; wr_en = 1'b1; din = 32'h0000_0001;
      #10;   din = 32'h0000_0002;
      #10;   din = 32'h0000_0003;
      #10;   din = 32'h0000_0004;
      #10;   din = 32'h0000_0005;
      #10;   din = 32'h0000_0006;
      #10;   din = 32'h0000_0007;
      
      #10;   wr_en = 1'b0; rd_en = 1'b1;
      #20;   wr_en = 1'b1; rd_en = 1'b0;
      
      #10;   din = 32'h0000_0008;
      #10;   din = 32'h0000_0009;
      #10;   din = 32'h0000_000a;
      #10;   din = 32'h0000_000b;
      #10;   din = 32'h0000_000d;
      #10;   din = 32'h0000_000e;
      #10;   din = 32'h0000_000f;
      #10;   din = 32'h0000_0010;
      #10;   din = 32'h0000_0011;
      #10;   din = 32'h0000_0012;
      #10;   din = 32'h0000_0013;
      //READ
      #10;   wr_en = 1'b0; rd_en = 1'b1;
      #180;
      #10;   reset_n = 1'b0;
      #20;   $stop;
   end
endmodule
