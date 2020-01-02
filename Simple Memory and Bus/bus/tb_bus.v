// Testbench of top module
`timescale 1ns/100ps
module tb_bus;
	reg clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	reg[7:0] m0_address, m1_address;
	reg[31:0] m0_dout, m1_dout, s0_dout, s1_dout;
	wire m0_grant, m1_grant, s0_sel, s1_sel, s_wr;
	wire[31:0] m_din, s_din;
	wire[7:0] s_address;
	
	bus U0_bus(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout,
	m1_req, m1_wr, m1_address, m1_dout, s0_dout, s1_dout,
	m0_grant, m1_grant, m_din, s0_sel, s1_sel, s_address, s_wr, s_din);

	always#(5) clk = ~clk;
	
	initial
	begin
	#0; clk = 1; reset_n =0; m0_req = 0; m0_wr = 0; m1_req = 0; m1_wr = 0; m0_address = 0; m1_address = 0; m0_dout = 0; m1_dout = 0; s0_dout = 0; s1_dout = 0; 
	#13; reset_n = 1;
	// Master 0 granted
	#10; m0_req = 1; s0_dout = 1; s1_dout = 2;
	#10; m0_wr = 1;
	#10; m0_address = 8'h01; m0_dout = 32'h00000002;
	#10; m0_address = 8'h02; m0_dout = 32'h00000004;
	#10; m0_address = 8'h03; m0_dout = 32'h00000006;
	#10; m0_address = 8'h20; m0_dout = 32'h00000020;
	// Master 0 granted, while m0_req is high
	m1_req = 1; m1_wr = 1;
	#10; m0_address = 8'h21; m0_dout = 32'h00000022;
	#10; m0_address = 8'h22; m0_dout = 32'h00000024;
	#10; m0_address = 8'hA0; m0_dout = 32'h000000FF;				// Out of range
	// Master 1 granted
	#10; m0_req = 0; m0_wr = 0;
	#10; s0_dout = 7; s1_dout = 8;
	#20; m1_address = 8'h05; m1_dout = 32'h00000010;
	#10; m1_address = 8'h06; m1_dout = 32'h00000012;
	#10; m1_address = 8'h07; m1_dout = 32'h00000014;
	#10; m1_address = 8'h25; m1_dout = 32'h00000030;
	// Master 1 granted, while m1_req is high
	m0_req = 1; m0_wr = 1;
	#10; m1_address = 8'h26; m1_dout = 32'h00000032;
	#10; m1_address = 8'h27; m1_dout = 32'h00000034;
	#10; m1_address = 8'hA0; m1_dout = 32'h000FF0FF;				// Out of range
	#30; $stop;
	end
endmodule

