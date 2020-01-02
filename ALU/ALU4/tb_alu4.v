//Self-checking testbench for 4-bits ALU
`timescale 1ns/100ps

module tb_alu4;
	reg[3:0] tb_a, tb_b;
	reg[2:0] tb_op;
	wire[3:0] tb_result;
	wire tb_c, tb_n, tb_z, tb_v;

	alu4 U0_alu4(.a(tb_a), .b(tb_b), .op(tb_op), .result(tb_result), .c(tb_c), .n(tb_n), .z(tb_z), .v(tb_v));

	initial
	begin
		
			// Not A
			tb_a = 4'h0; tb_b = 4'h0; tb_op = 3'b000; #10;
			if (tb_result !== 4'b1111 || tb_c !== 0 || tb_n !== 1 || tb_z !== 0 || tb_v !== 0) $display("opcode 000 failed");
			// Not B
			tb_b = 4'h3; tb_op = 3'b001; #10;
			if (tb_result !== 4'b1100 || tb_c !== 0 || tb_n !== 1 || tb_z !== 0 || tb_v !== 0) $display("opcode 001 failed");
			// AND
			tb_op = 3'b010; #10;
			if (tb_result !== 4'b0000 || tb_c !== 0 || tb_n !== 0 || tb_z !== 1 || tb_v !== 0) $display("opcode 010 failed");
			// OR
			tb_a = 4'h5; tb_op = 3'b011; #10;
			if (tb_result !== 4'b0111 || tb_c !== 0 || tb_n !== 0 || tb_z !== 0 || tb_v !== 0) $display("opcode 011 failed");
			// XOR
			tb_op = 3'b100; #10;
			if (tb_result !== 4'b0110 || tb_c !== 0 || tb_n !== 0 || tb_z !== 0 || tb_v !== 0) $display("opcode 100 failed");
			// XNOR
			tb_op = 3'b101; #10;
			if (tb_result !== 4'b1001 || tb_c !== 0 || tb_n !== 1 || tb_z !== 0 || tb_v !== 0) $display("opcode 101 failed");
			// Addition
			tb_op = 3'b110; #10;
			if (tb_result !== 4'b1000 || tb_c !== 0 || tb_n !== 1 || tb_z !== 0 || tb_v !== 1) $display("opcode 110 failed");
			// Subtraction
			tb_a = 4'h7; tb_b = 4'h1; tb_op = 3'b111; #10;
			if (tb_result !== 4'b0110 || tb_c !== 1 || tb_n !== 0 || tb_z !== 0 || tb_v !== 0) $display("opcode 111 failed");
		end
endmodule
