// DMAC_SLAVE Testbench
`timescale 1ns/100ps
module tb_DMAC_SLAVE;
	reg clk, reset_n, opdone, s_sel, s_wr; 
	reg [15:0] s_addr;
	reg [31:0] s_din;
	
	wire [1:0] wr_en;
	wire op_start, opdone_clear, s_interrupt;
	wire [31:0] data_size;
	wire [31:0] dest_addr, src_addr;
	wire [1:0] opmode;
	wire [31:0] s_dout;
	
	DMAC_SLAVE U0_SLAVE(clk, reset_n, opdone, opdone_clear, s_sel, s_wr, s_addr, s_din,
	wr_en, data_size, dest_addr, src_addr, s_interrupt, s_dout, op_start, opmode);
	
	always#5 clk = ~clk;
	
	initial
	begin
	#0; clk=1; reset_n=0; opdone=0; s_sel=1; s_wr=0; s_addr=0; s_din=0;
	#7; reset_n=1; s_wr=1; s_din=1;														// op_start = 1;
	#10; s_addr=1; s_din=1; 																// s_interrupt = 0;
	#10; s_addr=2; s_din=1;																	// s_interrupt = 1;
	#10; s_addr=3; s_din=32'h0001;														// src_addr = 32'h0001;
	#10; s_addr=4; s_din=32'h0002;
	#10; s_addr=5; s_din=32'h0001;
	#10; s_addr=6; s_din=32'h0001;														// DEFAULT
	#10; s_addr=7; s_din=32'h0001;
	#10; s_addr=8; s_din=32'h0001;														// DEFAULT
	#10; s_addr=0; s_wr=0;
	#10; s_addr=1;
	#10; s_addr=2;
	#10; s_addr=3;
	#10; s_addr=4;
	#10; s_addr=5;
	#10; s_addr=6;
	#10; s_addr=7;
	#10; s_addr=8;
	#10; $stop;
	end
	
endmodule
