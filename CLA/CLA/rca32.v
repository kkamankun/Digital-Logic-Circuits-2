//32-bits Ripple Carry Adder
module rca32(a, b, ci, s, co);
	input[31:0] a, b;
	input ci;
	output[31:0] s;
	output co;
	wire[6:0] c;

	rca4 U0_rca4(.a(a[3:0]), .b(b[3:0]), .ci(ci), .s(s[3:0]), .co(c[0]));
	rca4 U1_rca4(.a(a[7:4]), .b(b[7:4]), .ci(c[0]), .s(s[7:4]), .co(c[1]));
	rca4 U2_rca4(.a(a[11:8]), .b(b[11:8]), .ci(c[1]), .s(s[11:8]), .co(c[2]));
	rca4 U3_rca4(.a(a[15:12]), .b(b[15:12]), .ci(c[2]), .s(s[15:12]), .co(c[3]));
	rca4 U4_rca4(.a(a[19:16]), .b(b[19:16]), .ci(c[3]), .s(s[19:16]), .co(c[4]));
	rca4 U5_rca4(.a(a[23:20]), .b(b[23:20]), .ci(c[4]), .s(s[23:20]), .co(c[5]));
	rca4 U6_rca4(.a(a[27:24]), .b(b[27:24]), .ci(c[5]), .s(s[27:24]), .co(c[6]));
	rca4 U7_rca4(.a(a[31:28]), .b(b[31:28]), .ci(c[6]), .s(s[31:28]), .co(co));
endmodule
