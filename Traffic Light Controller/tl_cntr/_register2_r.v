// 2-bits resettable register with active low asynchronous reset
module _register2_r(clk, reset_n, d, q);
	input clk, reset_n;
	input[1:0] d;
	output[1:0] q;

	_dff_r U0_dff_r(clk, reset_n, d[0], q[0]);
	_dff_r U1_dff_r(clk, reset_n, d[1], q[1]);

endmodule
