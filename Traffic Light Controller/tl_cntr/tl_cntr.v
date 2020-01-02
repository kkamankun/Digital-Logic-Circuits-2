// Traffic Light Controller
module tl_cntr(clk, reset_n, Ta, Tb, La, Lb);
	input clk, reset_n, Ta, Tb;
	output[1:0] La, Lb;

	wire[1:0] w_d, w_q;

	ns_logic U0_ns_logic(Ta, Tb, w_q, w_d);

	_register2_r U1_register2_r(clk, reset_n, w_d, w_q);

	o_logic U2_o_logic(w_q, La, Lb);

endmodule
