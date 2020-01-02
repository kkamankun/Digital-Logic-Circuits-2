// testbench for fifo_ns
`timescale 1ns/100ps
module tb_fifo_ns;
	reg tb_wr_en, tb_rd_en;
	reg[2:0] tb_state;
	reg[3:0] tb_data_count;
	wire[2:0] tb_next_state;

	parameter INIT 		= 3'b000;
	parameter NO_OP 		= 3'b001;
	parameter WRITE 		= 3'b010;
	parameter WR_ERROR 	= 3'b011;
	parameter READ 		= 3'b100;
	parameter RD_ERROR 	= 3'b101;
	
	fifo_ns U0_fifo_ns(tb_wr_en, tb_rd_en, tb_state, tb_data_count, tb_next_state);
	
	initial
	begin
	// INIT
	tb_wr_en=0; tb_rd_en=1; tb_state=INIT; tb_data_count=0;			// RD_ERROR 101
	#10; tb_wr_en=1; tb_rd_en=0;										 	 	// WRITE 010
	#10; tb_wr_en=1; tb_rd_en=1; 												// NO_OP 001
	#10; $stop;
	end
endmodule
