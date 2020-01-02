// Testbench for 32-bits register
`timescale 1ns/100ps

module tb_register32;
	reg tb_clk;
	reg[31:0] tb_d;
	wire[31:0] tb_q;

	parameter STEP = 10;

	_register32 U0_regitser32(.clk(tb_clk), .d(tb_d), .q(tb_q));

	// clock period : 10ns
	always#(STEP/2) tb_clk = ~tb_clk; 

	initial
	begin
		tb_clk = 1'b0; tb_d = 32'h12345678; #7;
		tb_d = 32'h98765432; #7;
		tb_d = 32'hffeeddcc; #7;
		tb_d = 32'hbbaabbaa; #7;
		tb_d = 32'h77665544; #7;
		tb_d = 32'h33221100; #7;
		tb_d = 32'h12345678; #7;
	$stop;
	end
endmodule
