// 32bit mux3, s_dout
module mux3_32bit(d0, d1, d2, s, y);
	input[31:0] d0, d1, d2;
	input[1:0] s;
	output[31:0] y;
		
	assign y = (s == 2'b10) ? d2 : (( s == 2'b01) ? d1 : d0);
endmodule
