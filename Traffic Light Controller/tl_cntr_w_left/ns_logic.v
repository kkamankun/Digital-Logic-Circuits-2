// Next State Logic of TCL with Left Turn Signals

module ns_logic(Ta, Tal, Tb, Tbl, q, d);
	input Ta, Tal, Tb, Tbl;
	input[2:0] q;
	output[2:0] d;
	
	wire w_d2_q2_bar, w_d2_q1_bar, w_d2_q0_bar, w_d2_and_0, w_d2_and_1, w_d2_and_2;
	wire w_d0_q1_bar, w0_d0_q2_bar, w1_d0_q2_bar, w1_d0_q1_bar, w_d0_or_0, w_d0_or_1, w_d0_or_2, w_d0_or_3;

	// D2
	_inv	U0_inv(q[2], w_d2_q2_bar);
	_inv	U1_inv(q[1], w_d2_q1_bar);
	_inv	U2_inv(q[0], w_d2_q0_bar);
	_and3 U3_and3(w_d2_q2_bar, q[1], q[0], w_d2_and_0);
	_and2 U4_and3(q[2], w_d2_q1_bar, w_d2_and_1);
	_and3 U5_and3(q[2], q[1], w_d2_q0_bar, w_d2_and_2);
	_or3 U6_or3(w_d2_and_0, w_d2_and_1, w_d2_and_2, d[2]);

	// D1
	_xor2	U7_xor2(q[1], q[0], d[1]);

	// D0
	// Note : instantiate nor gate instead of and gate 
	_inv	U8_inv(.a(q[1]), .y(w0_d0_q1_bar));
	_inv	U9_inv(.a(q[2]), .y(w0_d0_q2_bar));
	_inv	U10_inv(.a(q[2]), .y(w1_d0_q2_bar));
	_inv	U11_inv(.a(q[1]), .y(w1_d0_q1_bar));
	_nor4	U12_nor4(.a(q[2]), .b(q[1]), .c(q[0]), .d(Ta), .y(w_d0_or_0));
	_nor4	U13_nor4(.a(q[2]), .b(w0_d0_q1_bar), .c(q[0]), .d(Tal), .y(w_d0_or_1));
	_nor4	U14_nor4(.a(w0_d0_q2_bar), .b(q[1]), .c(q[0]), .d(Tb), .y(w_d0_or_2));
	_nor4	U15_nor4(.a(w1_d0_q2_bar), .b(w1_d0_q1_bar), .c(q[0]), .d(Tbl), .y(w_d0_or_3));
	_or4	U16_or4(.a(w_d0_or_0), .b(w_d0_or_1), .c(w_d0_or_2), .d(w_d0_or_3), .y(d[0]));
endmodule


/*
module ns_logic(Ta, Tal, Tb, Tbl, q, d);
	input Ta, Tal, Tb, Tbl;
	input[2:0] q;
	output reg[2:0] d;
	
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	parameter S5 = 3'b101;
	parameter S6 = 3'b110;
	parameter S7 = 3'b111;
	
	always@(q or Ta or Tal or Tb or Tbl)
	begin
		casex({q, Ta, Tal, Tb, Tbl})
		{S0, 1'b0, 1'bx, 1'bx, 1'bx}: d <= S1;
		{S0, 1'b1, 1'bx, 1'bx, 1'bx}: d <= S0;
		{S1, 1'bx, 1'bx, 1'bx, 1'bx}: d <= S2;
		{S2, 1'bx, 1'b0, 1'bx, 1'bx}: d <= S3;
		{S2, 1'bx, 1'b1, 1'bx, 1'bx}: d <= S2;
		{S3, 1'bx, 1'bx, 1'bx, 1'bx}: d <= S4;
		{S4, 1'bx, 1'bx, 1'b0, 1'bx}: d <= S5;
		{S4, 1'bx, 1'bx, 1'b1, 1'bx}: d <= S4;
		{S5, 1'bx, 1'bx, 1'bx, 1'bx}: d <= S6;
		{S6, 1'bx, 1'bx, 1'bx, 1'b0}: d <= S7;
		{S6, 1'bx, 1'bx, 1'bx, 1'b1}: d <= S6;
		{S7, 1'bx, 1'bx, 1'bx, 1'bx}: d <= S0;
		default: d <= 3'bx;
		endcase
	end
endmodule
*/
		