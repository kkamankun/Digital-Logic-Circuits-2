//Modification of 4bits CLA
module cla4_ov(a, b, ci, s, c3, co);
	input[3:0] a, b;
	input ci;
	output[3:0] s;
	output c3, co;
	wire w_c1, w_c2, w_c3;

	fa_v2 U0_fa_v2(.a(a[0]), .b(b[0]), .ci(ci), .s(s[0]));
	fa_v2 U1_fa_v2(.a(a[1]), .b(b[1]), .ci(w_c1), .s(s[1]));
	fa_v2 U2_fa_v2(.a(a[2]), .b(b[2]), .ci(w_c2), .s(s[2]));
	fa_v2 U3_fa_v2(.a(a[3]), .b(b[3]), .ci(w_c3), .s(s[3]));

	clb4 U4_clb4(.a(a), .b(b), .ci(ci), .c1(w_c1), .c2(w_c2), .c3(w_c3), .co(co));

	assign c3 = w_c3;

endmodule
