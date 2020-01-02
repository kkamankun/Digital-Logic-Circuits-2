// Bus
module bus(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout,
m1_req, m1_wr, m1_address, m1_dout, s0_dout, s1_dout,
m0_grant, m1_grant, m_din, s0_sel, s1_sel, s_address, s_wr, s_din);
	input clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	input[7:0] m0_address, m1_address;
	input[31:0] m0_dout, m1_dout, s0_dout, s1_dout;
	output m0_grant, m1_grant, s0_sel, s1_sel, s_wr;
	output[31:0] m_din, s_din;
	output[7:0] s_address;

	// Wire
	wire[1:0] w_dff_mux3;
	
	// Arbiter
	bus_arbit U0_bus_arbit(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
	
	// Address decoder
	bus_addr U1_bus_addr(s_address, s0_sel, s1_sel);
	
	// Write Multiplexer
	mux2 U2_mux2(.d0(m0_wr), .d1(m1_wr), .s(m1_grant), .y(s_wr));
	
	// Slave address Multiplexer
	mux2_8bit U3_mux2_8bit(.d0(m0_address), .d1(m1_address), .s(m1_grant), .y(s_address));
	
	// Slave data input multiplexer
	mux2_32bit U4_mux2_32bit(m0_dout, m1_dout, m1_grant, s_din);
	
	// Master data input multiplexer
	mux3_32bit U5_mux3_32bit(32'h0, s0_dout, s1_dout, w_dff_mux3, m_din);
	
	// D Flip-Flop with active low asynchronous reset
	dff_r_2 U6_dff_r_2(clk, reset_n, {s1_sel, s0_sel}, w_dff_mux3);
		
endmodule
