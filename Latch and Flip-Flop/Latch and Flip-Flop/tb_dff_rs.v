// Testbench for Synchronous Set/Resettable D Flip-Flop
`timescale 1ns/100ps

module tb_dff_rs;
	reg tb_clk, tb_set_n, tb_reset_n, tb_d;
	wire tb_q;

	parameter STEP = 10;

	_dff_rs U0_dff_rs(.clk(tb_clk), .set_n(tb_set_n), .reset_n(tb_reset_n), .d(tb_d), .q(tb_q));

	// clock period : 10ns
	always#(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
		tb_clk = 1'b0; tb_reset_n = 1'b0; #2; 							// tb_q = 1'b0
		tb_d = 1'b1; #10;
		tb_d = 1'b0; tb_set_n = 1'b0; tb_reset_n = 1'b1; #10; 	// tb_q = 1'b1
		tb_d = 1'b0; #5;
		tb_set_n = 1'b1; #5;													// tb_reset_n = 1'b1 & tb_set_n =1'b1
		tb_d = 1'b1; #10;
		tb_d = 1'b0; #10;
		tb_set_n = 1'b0; #10; 												// tb_q = 1'b1
		tb_reset_n = 1'b0; #10; 											// tb_q = 1'b0
		tb_d = 1'b1;
		$stop;
		// Note : 
		// D F/F does not work, if tb_reset_n = 1'b0 & tb_set_n = 1'b0
		// D F/F outputs 1, if tb_reset_n = 1'b1 & tb_set_n = 1'b0
		// D F/F, if tb_reset_n = 1'b1 & tb_set_n =1'b1
	end
endmodule
