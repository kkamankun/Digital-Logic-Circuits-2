// Testbench for fifo
`timescale 1ns/100ps

	module tb_fifo;
	reg tb_clk, tb_reset_n, tb_rd_en, tb_wr_en;
	reg[31:0] tb_din;
	wire[31:0] tb_dout;
	wire tb_full, tb_empty;
	wire tb_wr_ack, tb_wr_err, tb_rd_ack, tb_rd_err;
	wire[3:0] tb_data_count;

	parameter STEP = 10;

	fifo U0_fifo(tb_clk, tb_reset_n, tb_rd_en, tb_wr_en, tb_din, tb_dout, tb_data_count, tb_full, tb_empty, tb_wr_ack, tb_wr_err, tb_rd_ack, tb_rd_err);

	always#(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
	#0; tb_clk=0; tb_reset_n=0; tb_rd_en=0; tb_wr_en=0; tb_din=32'h0; 	// INIT
	#7; tb_reset_n=1; tb_wr_en=1; tb_din=32'h0001;								// WRITE
	#10; tb_din=32'h0002;																
	#10; tb_din=32'h0003;
	#10; tb_din=32'h0004;
	#10; tb_din=32'h0005;
	#10; tb_din=32'h0006;
	#10; tb_din=32'h0007;
	#10; tb_din=32'h0008;																
	#10; tb_din=32'h0009;																// full, WR_ERROR
	#10;																						// NO_OP
	#10; tb_wr_en=0; tb_rd_en=1; 														// READ
	#10;
	#10;
	#10;
	#10;
	#10;
	#10;
	#10;
	#10;																						// RD_ERROR
	#10;																						// NO_OP
	#10;
	#10; tb_reset_n=0;																	// INIT
	#10; $stop;	
	end
endmodule

