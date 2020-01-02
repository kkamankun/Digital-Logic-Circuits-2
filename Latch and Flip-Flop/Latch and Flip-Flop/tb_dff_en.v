// Testbench for Enabled D Flip-Flop
`timescale 1ns/100ps

module tb_dff_en;

	reg tb_clk, tb_en, tb_d;
	wire tb_q;

	parameter STEP = 10;

	_dff_en U0_dff_en(.clk(tb_clk), .en(tb_en), .d(tb_d), .q(tb_q));

	// clock period : 10ns
	always #(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
		tb_clk = 1'b0; tb_en = 1'b0; tb_d = 1'b0; #2;
		tb_d = 1'b1; #5;
		tb_d = 1'b0; #5;
		tb_d = 1'b1; tb_en = 1'b1; #10;
		tb_d = 1'b0; #10;
		tb_d = 1'b1; #10;
		tb_d = 1'b0; tb_en = 1'b0; #5;
		tb_d = 1'b1; #5;
		$stop;
	end
endmodule
