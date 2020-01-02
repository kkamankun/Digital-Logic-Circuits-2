//Testbench of 32-bits RCA with Register
`timescale 1ns/100ps

module tb_rca_clk;
	reg clock;
	reg[31:0] tb_a, tb_b;
	reg tb_ci;
	wire[31:0] tb_s_rca;
	wire tb_co_rca;

	parameter STEP = 10;

	rca_clk U0_rca_clk(.clock(clock), .a(tb_a), .b(tb_b), .ci(tb_ci), .s_rca(tb_s_rca), .co_rca(tb_co_rca));

	always # (STEP/2) clock = ~clock;

	initial 
	begin
	clock = 1; tb_a = 32'h00000000; tb_b = 32'h00000000; tb_ci = 0;
			#10; tb_a = 32'hFFFFFFFF;
			#10; tb_a = 32'h0000FFFF; tb_b = 32'hFFFF0000;
			#10; tb_a = 32'h135FA562; tb_b = 32'h35614642;
			#10; tb_ci = 1;
			#10; $stop;
	end
endmodule
