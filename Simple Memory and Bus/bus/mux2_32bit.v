// 32bit mux2, m_dout
module mux2_32bit(d0, d1, s, y);
	input[31:0] d0, d1;
	input s;
	output[31:0] y;
		
	assign y = (s == 1'b1) ? d1 : d0;
	
endmodule

