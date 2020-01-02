//Full Adder
module fa(input a, b, ci, output s, co);
wire c1, c2, sm;
	ha U0_ha(.a(b), .b(ci), .s(sm), .co(c1));
	ha U1_ha(.a(a), .b(sm), .s(s), .co(c2));
	_or2 U3_or2(.a(c1), .b(c2), .y(co));
endmodule
