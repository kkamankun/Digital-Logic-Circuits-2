// Testbench of Radix-2 booth multiplier
`timescale 1ns/100ps
module tb_multiplier;
	reg tb_clk, tb_reset_n;
	reg[63:0] tb_multiplier, tb_multiplicand;
	reg tb_op_start, tb_op_clear;
	wire tb_op_done;
	wire[127:0] tb_result;
	
	parameter STEP = 10;
	
	multiplier U0_multiplier(.clk(tb_clk), .reset_n(tb_reset_n), .multiplier(tb_multiplier),
	.multiplicand(tb_multiplicand), .op_start(tb_op_start), .op_clear(tb_op_clear), .op_done(tb_op_done), .result(tb_result));
	
	always#(STEP/2) tb_clk = ~tb_clk;
	initial
	begin
	#0; tb_clk = 0; tb_reset_n = 0; tb_multiplier = 7; tb_multiplicand = 50; tb_op_start = 0; tb_op_clear = 0;
	#7; tb_reset_n = 1; 
	#5; tb_op_start = 1;
	#1100; tb_op_clear = 1;
	#3; tb_multiplier = 56; tb_multiplicand = 73;
	#5; tb_op_clear = 0; 
	#1100; tb_op_clear = 1;
	#3; tb_multiplier = -6; tb_multiplicand = 3;
	#30; tb_op_clear = 0;
	#200; tb_multiplicand = 10;
	#5; tb_op_clear = 0; 
	#1100; tb_op_clear = 1;
	#5; tb_multiplier = -6; tb_multiplicand = -3;
	#6; tb_op_clear = 0;
	#400; tb_multiplier = 10; 
	#1100; tb_op_clear = 1;
	#10; tb_multiplier = 30; tb_multiplicand = 30;
	#10; tb_op_clear = 1;
	#10; tb_op_clear = 0;
	#100; tb_op_clear = 1;
	#100; $stop;
	$stop;
	end
endmodule
