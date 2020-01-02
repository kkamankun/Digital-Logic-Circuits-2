// Testbench of SR Latch
`timescale 1ns/100ps

module tb_srlatch;
	reg tb_r, tb_s;
	wire tb_q, tb_q_bar;

	_srlatch U0_srlatch(.r(tb_r), .s(tb_s), .q(tb_q), .q_bar(tb_q_bar));

	initial
	begin
		tb_r = 1'b0; tb_s = 1'b0; #10;
		tb_r = 1'b1; tb_s = 1'b0; #10;
		tb_r = 1'b0; tb_s = 1'b1; #10;
		tb_r = 1'b1; tb_s = 1'b1; #10;
		tb_r = 1'b1; tb_s = 1'b0; #10;
		tb_r = 1'b0; tb_s = 1'b0; #10;
		$stop;
	end
	// Note : simulator does not work after input s and r are 1
endmodule
