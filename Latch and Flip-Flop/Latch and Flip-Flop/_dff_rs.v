// Synchronous Set/Resettable D Flip-Flop
module _dff_rs(clk, set_n, reset_n, d, q);
	input clk, set_n, reset_n, d;
	output q;

	wire w_not_or, w_or_and, w_d;

	_inv U0_inv(.a(set_n), .y(w_not_or));
	_or2 U1_or2(.a(d), .b(w_not_or), .y(w_or_and));
	_and2 U2_and2(.a(w_or_and), .b(reset_n), .y(w_d));
	_dff U3_dff(.clk(clk), .d(w_d), .q(q), .q_bar());
	
	// Note : D flip-flop with active-low synchronous reset and set
endmodule
