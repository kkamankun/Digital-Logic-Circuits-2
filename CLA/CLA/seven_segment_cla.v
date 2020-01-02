//seven_segment_cla
module seven_segment_cla(a, b, cin, dec_out);
	input [3:0] a;
	input [3:0] b;
	input cin;
	output [13:0] dec_out;
	
	wire [3:0] s;
	wire c;
	
	cla4 U0_cla4(.a(a), .b(b), .ci(cin), .s(s), .co(c));
	seg_dec U1_seg_dec(.iHex(s), .oSEG7(dec_out[6:0]));
	seg_dec U2_seg_dec(.iHex({3'b000, c}), .oSEG7(dec_out[13:7]));
	
endmodule
