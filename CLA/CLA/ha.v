//Half Adder
module ha(a, b, s, co);
	input a, b;
	output s, co;
	//_xor2 U0_xor2(.a(a), .b(b), .y(s));
	//_and2 U1_and2(.a(a), .b(b), .y(co));
	assign s = a ^ b;
	assign co = a & b;
endmodule
