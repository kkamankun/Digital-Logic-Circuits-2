//Full Adder in CLA
module fa_v2(a, b, ci, s);
	input a, b;
	input ci;
	output s;
	wire w;
	
	_xor2 U0_xor2(.a(a), .b(b), .y(w));
	_xor2 U1_xor2(.a(w), .b(ci), .y(s));
endmodule
