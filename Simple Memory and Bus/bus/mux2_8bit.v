// 8 bit mux2, m_address
module mux2_8bit(d0, d1, s, y);
	input[7:0] d0, d1;
	input s;
	output[7:0] y;
		
	assign y = (s == 1'b1) ? d1 : d0;
	
endmodule
