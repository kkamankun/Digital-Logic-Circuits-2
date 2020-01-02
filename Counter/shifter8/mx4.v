// 1-bit 4-to-1 multiplexer
module mx4(y, d0, d1, d2, d3, s);
input d0, d1, d2, d3;
input[1:0] s;
output y;

wire[1:0] w;
mx2 U0_mx2(d0, d1, s[0], w[0]);
mx2 U1_mx2(d2, d3, s[0], w[1]);
mx2 U2_mx2(w[0], w[1], s[1], y);
endmodule
