// BUS Testbench
`timescale 1ns/100ps
module tb_BUS;
	reg clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	reg[15:0] m0_addr, m1_addr;
	reg[31:0] m0_dout, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout;
	wire m0_grant, m1_grant, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_wr;
	wire[31:0] m_din, s_din;
	wire[15:0] s_addr;
	
	BUS U0_BUS(clk, reset_n, m0_req, m0_wr, m0_addr, m0_dout,
	m1_req, m1_wr, m1_addr, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout,
	m0_grant, m1_grant, m_din, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_addr, s_wr, s_din);

	always#(5) clk = ~clk;
	
	initial
	begin
	#0; clk = 1; reset_n =0; m0_req = 0; m0_wr = 0; m1_req = 0; m1_wr = 0; m0_addr = 0; m1_addr = 0; m0_dout = 0; m1_dout = 0; s0_dout = 0; s1_dout = 0; s2_dout = 0; s3_dout = 0; s4_dout = 0;
	#13; reset_n = 1;
	// Test master 0
	#10; m0_req = 1; s0_dout = 1; s1_dout = 2; s2_dout = 3; s3_dout = 4; s4_dout = 5;
	#10; m0_wr = 1;
	#10; m0_addr = 16'h0001; m0_dout = 32'h00000002;
	#10; m0_addr = 16'h0002; m0_dout = 32'h00000004;
	#10; m0_addr = 16'h0003; m0_dout = 32'h00000006;
	#10; m0_addr = 16'h0200; m0_dout = 32'h00000020;
	// Make sure the Master 0 is maintained
	m1_req = 1; m1_wr = 1;
	#10; m0_addr = 16'h0201; m0_dout = 32'h00000022;
	#10; m0_addr = 16'h0202; m0_dout = 32'h00000024;
	#10; m0_addr = 16'h0A00; m0_dout = 32'h000000FF;
	// Test Master 1
	#10; m0_req = 0; m0_wr = 0;
	#10; s0_dout = 7; s1_dout = 8; s2_dout = 9; s3_dout = 10; s4_dout = 11;
	#20; m1_addr = 16'h0305; m1_dout = 32'h00000010;
	#10; m1_addr = 16'h0306; m1_dout = 32'h00000012;
	#10; m1_addr = 16'h0307; m1_dout = 32'h00000014;
	#10; m1_addr = 16'h0B05; m1_dout = 32'h00000030;
	// Make sure the Master 1 is maintained
	m0_req = 1; m0_wr = 1;
	#10; m1_addr = 16'h0406; m1_dout = 32'h00000032;
	#10; m1_addr = 16'h0407; m1_dout = 32'h00000034;
	#10; m1_addr = 16'h0A00; m1_dout = 32'h000FF0FF;
	#30; $stop;
	end
endmodule
