//4-bits Carry Look-ahead Adder
module cla4(a, b, ci, s, co);
	input[3:0] a, b;
	input ci;
	output[3:0] s;
	output co;
	wire w1, w2, w3;

	clb4 U0_clb4(.a(a[3:0]), .b(b[3:0]), .ci(ci), .c1(w1), .c2(w2), .c3(w3), .co(co));
	fa_v2 U1_fa_v2(.a(a[0]), .b(b[0]), .ci(ci), .s(s[0]));
	fa_v2 U2_fa_v2(.a(a[1]), .b(b[1]), .ci(w1), .s(s[1]));
	fa_v2 U3_fa_v2(.a(a[2]), .b(b[2]), .ci(w2), .s(s[2]));
	fa_v2 U4_fa_v2(.a(a[3]), .b(b[3]), .ci(w3), .s(s[3]));
endmodule
