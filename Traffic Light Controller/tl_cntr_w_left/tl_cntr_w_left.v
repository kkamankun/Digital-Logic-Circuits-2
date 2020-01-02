// Traffic Light Controller with Left turn signals
module tl_cntr_w_left(clk, reset_n, Ta, Tal, Tb, Tbl, La, Lb);
	input clk, reset_n, Ta, Tal, Tb, Tbl;
	output[1:0] La, Lb;

	wire[2:0] w_d, w_q;

	ns_logic U0_ns_logic(Ta, Tal, Tb, Tbl, w_q, w_d);

	_register3_r U1_register3_r(clk, reset_n, w_d, w_q);

	o_logic U2_o_logic(w_q, La, Lb);
endmodule
