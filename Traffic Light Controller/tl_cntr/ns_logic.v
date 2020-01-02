// next state logic of Traffic light controller
module ns_logic(Ta, Tb, q, d);
	input Ta, Tb;
	input[1:0] q;
	output[1:0] d;
	
	wire w_q1_bar, w0_to_or, w1_to_or;

	// D1
	_xor2 U0_xor2(q[1], q[0], d[1]);

	// D0
	_inv U1_inv(q[1], w_q1_bar);
	_nor3 U2_nor3(q[1], q[0], Ta, w0_to_or);
	_nor3 U3_nor3(w_q1_bar, q[0], Tb, w1_to_or);
	_or2 U3_or(w0_to_or, w1_to_or, d[0]);
	
	// Note : instantiate nor gate instead of and gate
endmodule


/*
module ns_logic(Ta, Tb, q, d);
	input Ta, Tb;
	input[1:0] q;
	output reg[1:0] d;
	
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	
	always@(Ta or Tb or q)
	begin
		casex({q, Ta, Tb})
			{S0, 1'b0, 1'bx}: d <= S1;
			{S0, 1'b1, 1'bx}: d <= S0;
			{S1, 1'bx, 1'bx}: d <= S2;
			{S2, 1'bx, 1'b0}: d <= S3;
			{S2, 1'bx, 1'b1}: d <= S2;
			{S3, 1'bx, 1'bx}: d <= S0;
			default: d <= 2'bx;
		endcase
	end
endmodule
*/
