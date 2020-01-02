//4-bits Carry Look-ahead Block
module clb4(a, b, ci, c1, c2, c3, co);
	input[3:0] a, b;
	input ci;
	output c1, c2, c3, co;

	wire[3:0] g, p;

	wire w0_c1;
	wire w0_c2, w1_c2;
	wire w0_c3, w1_c3, w2_c3;
	wire w0_co, w1_co, w2_co, w3_co;

	//Generate
	_and2 G0_and2(.a(a[0]), .b(b[0]), .y(g[0]));
	_and2 G1_and2(.a(a[1]), .b(b[1]), .y(g[1]));
	_and2 G2_and2(.a(a[2]), .b(b[2]), .y(g[2]));
	_and2 G3_and2(.a(a[3]), .b(b[3]), .y(g[3]));

	//Propogate
	_or2 P0_or2(.a(a[0]), .b(b[0]), .y(p[0]));
	_or2 P1_or2(.a(a[1]), .b(b[1]), .y(p[1]));
	_or2 P2_or2(.a(a[2]), .b(b[2]), .y(p[2]));
	_or2 P3_or2(.a(a[3]), .b(b[3]), .y(p[3]));

	//c1 = g[0] | (p[0] & ci);
	_and2 C10_and2(.a(p[0]), .b(ci), .y(w0_c1));
	_or2 C11_or2(.a(w0_c1), .b(g[0]), .y(c1));

	//c2 = g[1]
	//	| (p[1] & g[0])
	// | (p[1] & p[0] & ci);
	_and3 C20_and3(.a(p[1]), .b(p[0]), .c(ci), .y(w0_c2));
	_and2 C21_and2(.a(p[1]), .b(g[0]), .y(w1_c2));
	_or3 C22_or3(.a(g[1]), .b(w0_c2), .c(w1_c2), .y(c2));

	//c3 = g[2]
	// | (p[2] & g[1])
	// | (p[2] & p[1] & g[0])
	// | (p[2] & p[1] & p[0] & ci);
	_and4 C30_and4(.a(p[2]), .b(p[1]), .c(p[0]), .d(ci), .y(w0_c3));
	_and3 C31_and3(.a(p[2]), .b(p[1]), .c(g[0]), .y(w1_c3));
	_and2 C32_and2(.a(p[2]), .b(g[1]), .y(w2_c3));
	_or4 C33_or4(.a(g[2]), .b(w0_c3), .c(w1_c3), .d(w2_c3), .y(c3));

	//co = g[3]
	// | (p[3] & g[2])
	// | (p[3] & p[2] & g[1])
	// | (p[3] & p[2] & p[1] & g[0])
	// | (p[3] & p[2] & p[1] & p[0] & ci);
	_and5 C40_and5(.a(p[3]), .b(p[2]), .c(p[1]), .d(p[0]), .e(ci), .y(w0_c4));
	_and4 C41_and4(.a(p[3]), .b(p[2]), .c(p[1]), .d(g[0]), .y(w1_c4));
	_and3 C42_and3(.a(p[3]), .b(p[2]), .c(g[1]), .y(w2_c4));
	_and2 C43_and2(.a(p[3]), .b(g[2]), .y(w3_c4));
	_or5 C44_or5(.a(g[3]), .b(w0_c4), .c(w1_c4), .d(w2_c4), .e(w3_c4), .y(co));
endmodule
