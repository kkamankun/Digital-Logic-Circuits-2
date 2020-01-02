// Bus
module BUS(clk, reset_n, m0_req, m0_wr, m0_addr, m0_dout,
m1_req, m1_wr, m1_addr, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout,
m0_grant, m1_grant, m_din, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_addr, s_wr, s_din);
	input clk, reset_n, m0_req, m0_wr, m1_req, m1_wr;
	input[15:0] m0_addr, m1_addr;
	input[31:0] m0_dout, m1_dout, s0_dout, s1_dout, s2_dout, s3_dout, s4_dout;
	output m0_grant, m1_grant, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel, s_wr;
	output[31:0] m_din, s_din;
	output[15:0] s_addr;

	// Wire
	wire[4:0] to_Mux_6;
	
	// Arbiter
	bus_arbit U0_Arbiter(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
	
	// addr decoder
	bus_addr U1_Address_decoder(s_addr, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel);
	
	// Write Multiplexer
	mux2 U2_Mux_1(.d0(m0_wr), .d1(m1_wr), .s(m1_grant), .y(s_wr));
	
	// Slave addr Multiplexer
	mux2_16bit U3_Mux_2(.d0(m0_addr), .d1(m1_addr), .s(m1_grant), .y(s_addr));
	
	// Slave data input multiplexer
	mux2_32bit U4_Mux_3(m0_dout, m1_dout, m1_grant, s_din);
	
	// Master data input multiplexer
	mux6_32bit U5_Mux_4(s0_dout, s1_dout, s2_dout, s3_dout, s4_dout, 32'h0, to_Mux_6, m_din);
	
	// D Flip-Flop with active low asynchronous reset
	dff_r_5 U6_DFF(.clk(clk), .reset_n(reset_n), .d({s4_sel, s3_sel, s2_sel, s1_sel, s0_sel}), .q(to_Mux_6));
		

endmodule

// Bus Arbiter
module bus_arbit(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
// Declare input and output variables
	input	clk, reset_n, m0_req, m1_req;
	output reg m0_grant, m1_grant;
	
	always @ (posedge clk) begin
		if (~reset_n) begin
			m0_grant = 1;
			m1_grant = 0;
		end
		else begin
			case({m1_grant, m0_grant})
				// m0 Grant
				2'b01	:	begin
					if(m0_req == 1) begin
						m0_grant = 1; m1_grant = 0;
					end
					else if((m0_req == 0) && (m1_req == 0)) begin
						m0_grant = 1; m1_grant = 0;
					end
					else if ((m0_req == 0) && (m1_req == 1)) begin
						m0_grant = 0; m1_grant = 1;
					end
				end
					
				
				// m1 Grant
				2'b10	:	begin
					if(m1_req == 1)
						m1_grant = 1;
					else if (m1_req == 0) begin
						m0_grant = 1; m1_grant = 0;
					end
				end
				// Exception
				default	:	begin
					m0_grant = 1'bx; m1_grant = 1'bx;
				end
			endcase
		end
	end
endmodule

// bus address decoder
module bus_addr(s_addr, s0_sel, s1_sel, s2_sel, s3_sel, s4_sel);
	input[15:0] s_addr;
	output reg s0_sel, s1_sel, s2_sel, s3_sel, s4_sel;

	always@(s_addr)
	begin	
	if(s_addr[15:8] == 8'h00)
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b00001;					// Slave0
	else if(s_addr[15:8] == 8'h01)
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b00010;					// Slave1
	else if(s_addr[15:8] == 8'h02)
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b00100;					// Slave2
	else if(s_addr[15:8] == 8'h03)
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b01000;					// Slave3	
	else if(s_addr[15:8] == 8'h04)
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b10000;					// Slave4
	else
		{s4_sel, s3_sel, s2_sel, s1_sel, s0_sel} = 5'b00000;					// NON
	end
endmodule

// mux2, m_wr
module mux2(d0, d1, s, y);
	input d0, d1;
	input s;
	output y;
		
	assign y = (s == 1'b1) ? d1 : d0;
endmodule

// 16 bit mux2, m_address
module mux2_16bit(d0, d1, s, y);
	input[15:0] d0, d1;
	input s;
	output[15:0] y;
		
	assign y = (s == 1'b1) ? d1 : d0;
endmodule

// 32bit mux2, m_dout
module mux2_32bit(d0, d1, s, y);
	input[31:0] d0, d1;
	input s;
	output[31:0] y;
		
	assign y = (s == 1'b1) ? d1 : d0;
endmodule

// 32bit mux6, s_dout
module mux6_32bit(d0, d1, d2, d3, d4, d5, s, y);
	input[31:0] d0, d1, d2, d3, d4, d5;
	input[4:0] s;
	output reg[31:0] y;
		
	always@(d0 or d1 or d2 or d3 or d4 or d5 or s) begin
		if(s == 5'b00001) y = d0;
		else if(s == 5'b00010) y = d1;
		else if(s == 5'b00100) y = d2;
		else if(s == 5'b01000) y = d3;
		else if(s == 5'b10000) y = d4;
		else if(s == 5'b00000) y = d5;
		else y = 32'h0;
	end		
endmodule

	