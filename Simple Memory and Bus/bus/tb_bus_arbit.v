// Testbench of bus arbiter
`timescale 1ns/100ps
module tb_bus_arbit;
	reg tb_clk, tb_reset_n;
	reg tb_m0_req, tb_m1_req;
	wire tb_m0_grant, tb_m1_grant;
	
	bus_arbit U0_bus_arbit(tb_clk, tb_reset_n, tb_m0_req,  tb_m1_req, tb_m0_grant, tb_m1_grant);
	
	always#(5) tb_clk = ~tb_clk;
	
	initial
	begin
	#0; tb_clk = 1; tb_reset_n = 0;
	#10; tb_reset_n = 1;
	#7; tb_m0_req = 1; tb_m1_req = 1;
	#10; tb_m0_req = 0; 
	#10; tb_m1_req = 0;
	#10; tb_m0_req = 1;
	#10; tb_m1_req = 0;
	#10; tb_m1_req = 0;
	#10; $stop;
	end
endmodule
