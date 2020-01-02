// inverter
module _inv(a, y);
	input a;
	output y;
	assign y = ~a;
endmodule

// 2-to-1 and gate
module _and2(a, b, y);
	input a, b;
	output y;
	assign y = a & b;
endmodule

// 2-to-1 nor gate
module _nor2(a, b, y);
	input a, b;
	output y;
	assign y = ~(a | b);
endmodule

// SR Latch
module _srlatch(r, s, q, q_bar);
	input r, s;
	output q, q_bar;

	_nor2 U0_nor2(.a(r), .b(q_bar), .y(q));
	_nor2 U1_nor2(.a(q), .b(s), .y(q_bar));
endmodule

// D Latch
module _dlatch(clk, d, q, q_bar);
	input clk, d;
	output q, q_bar;
	wire d_bar, r, s;

	_inv U0_inv(.a(d), .y(d_bar));
	_and2 U1_and2(.a(clk), .b(d_bar), .y(r));
	_and2 U2_and2(.a(clk), .b(d), .y(s));
	_srlatch U3_srlatch(.r(r), .s(s), .q(q), .q_bar(q_bar));
endmodule

// D Flip-Flop
module _dff(clk, d, q, q_bar);
	input clk, d;
	output q, q_bar;
	wire clk_bar, w_q;

	_inv U0_inv(.a(clk), .y(clk_bar));
	_dlatch U1_dlatch(.clk(clk_bar), .d(d), .q(w_q), .q_bar());
	_dlatch U2_dlatch(.clk(clk), .d(w_q), .q(q), .q_bar(q_bar));
endmodule

// Resettable D Flip-Flop(active-low)
module _dff_r(clk, reset_n, d, q);
	input clk, reset_n, d;
	output q;

	wire w_d;

	_and2 U0_and2(.a(d), .b(reset_n), .y(w_d));
	_dff U1_dff(.clk(clk), .d(w_d), .q(q), .q_bar());
endmodule

// 3bit Resettable D Flip-Flop(active-low)
module _dff_3_r(clk, reset_n, d, q);
	input clk, reset_n;
	input[2:0] d;
	output[2:0] q;

	_dff_r U0_dff_r(clk, reset_n, d[0], q[0]);
	_dff_r U1_dff_r(clk, reset_n, d[1], q[1]);
	_dff_r U2_dff_r(clk, reset_n, d[2], q[2]);
endmodule

// 4bit Resettable D Flip-Flop(active-low)
module _dff_4_r(clk, reset_n, d, q);
	input clk, reset_n;
	input[3:0] d;
	output[3:0] q;

	_dff_r U0_dff_r(clk, reset_n, d[0], q[0]);
	_dff_r U1_dff_r(clk, reset_n, d[1], q[1]);
	_dff_r U2_dff_r(clk, reset_n, d[2], q[2]);
	_dff_r U3_dff_r(clk, reset_n, d[3], q[3]);
endmodule

// 4bit D Flip-Flop
module _dff_4(clk, d, q);
	input clk;
	input[3:0] d;
	output[3:0] q;

	_dff U0_dff(.clk(clk), .d(d[0]), .q(q[0]), .q_bar());
	_dff U1_dff(.clk(clk), .d(d[1]), .q(q[1]), .q_bar());
	_dff U2_dff(.clk(clk), .d(d[2]), .q(q[2]), .q_bar());
	_dff U3_dff(.clk(clk), .d(d[3]), .q(q[3]), .q_bar());
endmodule

// 32bit D Flip-Flop
module _DFF32(clk, d, q);
	input clk;
	input[31:0] d;
	output[31:0] q;

	_dff_4 U0_dff_4(clk, d[3:0], q[3:0]);
	_dff_4 U1_dff_4(clk, d[7:4], q[7:4]);
	_dff_4 U2_dff_4(clk, d[11:8], q[11:8]);
	_dff_4 U3_dff_4(clk, d[15:12], q[15:12]);
	_dff_4 U4_dff_4(clk, d[19:16], q[19:16]);
	_dff_4 U5_dff_4(clk, d[23:20], q[23:20]);
	_dff_4 U6_dff_4(clk, d[27:24], q[27:24]);
	_dff_4 U7_dff_4(clk, d[31:28], q[31:28]);
endmodule





