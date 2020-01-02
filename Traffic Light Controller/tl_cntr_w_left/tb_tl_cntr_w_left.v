// Testbench of TLC with Left turn signals
`timescale 1ns/100ps

module tb_tl_cntr_w_left;
	reg tb_clk, tb_reset_n, tb_Ta, tb_Tal, tb_Tb, tb_Tbl;
	wire[1:0] tb_La, tb_Lb;
	
	parameter STEP = 6;
	
	tl_cntr_w_left		U0_tl_cntr_w_left(.clk(tb_clk), .reset_n(tb_reset_n), .Ta(tb_Ta), .Tal(tb_Tal), .Tb(tb_Tb), .Tbl(tb_Tbl), .La(tb_La), .Lb(tb_Lb));
	
	always #(STEP/2) tb_clk = ~tb_clk;
	
	initial
	begin
		tb_clk = 0; tb_reset_n = 0; tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0; 	#3;
		tb_Ta = 1; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0;	#3;
		tb_Ta = 0; tb_Tal = 1; tb_Tb = 0; tb_Tbl = 0;	#3;
		tb_Ta = 0; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0;	#3;
		tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 1;	#3;
		tb_reset_n = 1;											#60;
		tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0;	#60;
		tb_Ta = 1; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 0;	#60;
		tb_Ta = 0; tb_Tal = 1; tb_Tb = 0; tb_Tbl = 0;	#60;
		tb_Ta = 0; tb_Tal = 0; tb_Tb = 1; tb_Tbl = 0;	#60;
		tb_Ta = 0; tb_Tal = 0; tb_Tb = 0; tb_Tbl = 1;	#3;
		tb_reset_n = 0;											#10;
		$stop;
	end
endmodule	
