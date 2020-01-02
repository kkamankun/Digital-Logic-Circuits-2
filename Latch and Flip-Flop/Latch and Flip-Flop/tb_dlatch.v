// Testbench of D Latch
`timescale 1ns/100ps

module tb_dlatch;
	reg tb_clk, tb_d;
	wire tb_q, tb_q_bar;

	parameter STEP = 10;

	_dlatch U0_dlatch(.clk(tb_clk), .d(tb_d), .q(tb_q), .q_bar(tb_q_bar));

	// clock period : 10ns
	always#(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
		tb_clk = 1'b0; tb_d = 1'b0; #2;
		tb_d = 1'b1; #5;
		tb_d = 1'b0; #5;
		tb_d = 1'b1; #10;
		tb_d = 1'b0; #10;
		tb_d = 1'b1; #10;
		$stop;
	end
endmodule

