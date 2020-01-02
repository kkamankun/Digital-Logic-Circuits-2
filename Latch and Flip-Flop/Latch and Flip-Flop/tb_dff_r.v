// Testbench for Ressetable D Flip-Flop
`timescale 1ns/100ps

module tb_dff_r;

	reg tb_clk, tb_reset_n, tb_d;
	wire tb_q;

	parameter STEP = 10;

	_dff_r U0_dff_r(.clk(tb_clk), .reset_n(tb_reset_n), .d(tb_d), .q(tb_q));

	// clock period : 10ns
	always #(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
		tb_clk = 1'b0; tb_reset_n = 1'b0; tb_d = 1'b0; #2;
		tb_d = 1'b1; #5;
		tb_reset_n = 1'b1; #5;
		tb_d = 1'b1; #5;
		tb_d = 1'b0; #5;
		tb_d = 1'b1; #5;
		tb_reset_n = 1'b0; tb_d = 1'b1; #10;
		$stop;
	end
	// Note : D flip-flop with active-low synchronous reset
endmodule

