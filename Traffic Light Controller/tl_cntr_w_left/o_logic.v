// Output Logic of TCL with Left Turn Signals

module o_logic(q, La, Lb);
	input[2:0] q;
	output[1:0] La, Lb;

	wire w_a1_q0_bar, w_a1_and;
	wire w_b1_q2_bar, w_b1_q0_bar, w_b1_and;
	wire w_b0_q2_bar;

	// LA1
	_inv U0_inv(q[0], w_a1_q0_bar);
	_and2 U1_and2(q[1], w_a1_q0_bar, w_a1_and);
	_or2 U2_or2(w_a1_and, q[2], La[1]);

	// LA0
	_or2 U3_or2(q[0], q[2], La[0]);

	// LB1
	_inv U4_inv(q[2], w_b1_q2_bar);
	_inv U5_inv(q[0], w_b1_q0_bar);
	_and2 U6_and2(q[1], w_b1_q0_bar, w_b1_and);
	_or2 U7_or2(w_b1_q2_bar, w_b1_and, Lb[1]);

	// LB0
	_inv U7_inv(q[2], w_b0_q2_bar);
	_or2 U8_or2(w_b0_q2_bar, q[0], Lb[0]);
endmodule


/*
module o_logic(q, La, Lb);
	input[2:0] q;
	output reg[1:0] La, Lb;
	
	parameter green = 2'b00;
	parameter yellow = 2'b01;
	parameter left = 2'b10;
	parameter red = 2'b11;
	
	always@(q)
	begin
		case(q)
			3'b000: begin La <= green; Lb <= red; end
			3'b001: begin La <= yellow; Lb <= red; end
			3'b010: begin La <= left; Lb <= red; end
			3'b011: begin La <= yellow; Lb <= red; end
			3'b100: begin La <= red; Lb <= green; end
			3'b101: begin La <= red; Lb <= yellow; end
			3'b110: begin La <= red; Lb <= left; end
			3'b111: begin La <= red; Lb <= yellow; end
			default: begin La <= 3'bx; Lb <= 3'bx; end
		endcase
	end
endmodule
*/
	
	