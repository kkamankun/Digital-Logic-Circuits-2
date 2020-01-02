// output logic of Traffic light controller

/*
module o_logic(q, La, Lb);
	input[1:0] q;
	output[1:0] La, Lb;

	wire w_q1_bar;
	
	//LA1
	assign La[1] = q[1];

	//LA0
	_inv U0_inv(q[1], w_q1_bar);
	_and2 U1_and2(w_q1_bar, q[0], La[0]);

	//LB1
	assign Lb[1] = w_q1_bar;

	//LB0
	_and2 U3_and2(q[1], q[0], Lb[0]);
endmodule
*/


module o_logic(q, La, Lb);
	input[1:0] q;
	output reg [1:0] La, Lb;
	
	parameter green = 2'b00;
	parameter yellow = 2'b1;
	parameter red = 2'b10;
	
	always@(q)
	begin
		case(q)
			 2'b00: begin La <= green; Lb <= red; end
			 2'b01: begin La <= yellow; Lb <= red; end
			 2'b10: begin La <=red; Lb <= green; end
			 2'b11: begin La <= red; Lb = yellow; end
			 default: begin La <= green; Lb <= red; end
		 endcase
	 end
endmodule

	 
	 
	