// mux2, m_wr
module mux2(d0, d1, s, y);
	input d0, d1;
	input s;
	output y;
		
	assign y = (s == 1'b1) ? d1 : d0;
	
endmodule
