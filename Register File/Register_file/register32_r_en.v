// Resettable enabled D Flip-Flop
module _dff_r_en(clk, reset_n, en, d, q);
input clk, reset_n, en, d;
output reg q;

always@(posedge clk or negedge reset_n)
begin
if(reset_n == 0) q<=1'b0;
else if(en) q<=d;
else q<=q;
end
endmodule

// 8bits Resettable enabled Register
module register8_r_en(clk, reset_n, en, d_in, d_out);
input clk, reset_n, en;
input[7:0] d_in;
output[7:0] d_out;

_dff_r_en U0_dff_r_en(clk, reset_n, en, d_in[0], d_out[0]);
_dff_r_en U1_dff_r_en(clk, reset_n, en, d_in[1], d_out[1]);
_dff_r_en U2_dff_r_en(clk, reset_n, en, d_in[2], d_out[2]);
_dff_r_en U3_dff_r_en(clk, reset_n, en, d_in[3], d_out[3]);
_dff_r_en U4_dff_r_en(clk, reset_n, en, d_in[4], d_out[4]);
_dff_r_en U5_dff_r_en(clk, reset_n, en, d_in[5], d_out[5]);
_dff_r_en U6_dff_r_en(clk, reset_n, en, d_in[6], d_out[6]);
_dff_r_en U7_dff_r_en(clk, reset_n, en, d_in[7], d_out[7]);
endmodule

// 32bit Resettable enabled Register
module register32_r_en(clk, reset_n, en, d_in, d_out);
input clk, reset_n, en;
input[31:0] d_in;
output[31:0] d_out;

register8_r_en U0_register8_r_en(clk, reset_n, en, d_in[7:0], d_out[7:0]);
register8_r_en U1_register8_r_en(clk, reset_n, en, d_in[15:8], d_out[15:8]);
register8_r_en U2_register8_r_en(clk, reset_n, en, d_in[23:16], d_out[23:16]);
register8_r_en U3_register8_r_en(clk, reset_n, en, d_in[31:24], d_out[31:24]);
endmodule

// Eight 32bit Resettable enabled Register
module register32_8(clk, reset_n, en, d_in, d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7);
input clk, reset_n;
input[7:0] en;
input[31:0] d_in;
output[31:0] d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7;

register32_r_en U0_register32_r_en(clk, reset_n, en[0], d_in, d_out0);
register32_r_en U1_register32_r_en(clk, reset_n, en[1], d_in, d_out1);
register32_r_en U2_register32_r_en(clk, reset_n, en[2], d_in, d_out2);
register32_r_en U3_register32_r_en(clk, reset_n, en[3], d_in, d_out3);
register32_r_en U4_register32_r_en(clk, reset_n, en[4], d_in, d_out4);
register32_r_en U5_register32_r_en(clk, reset_n, en[5], d_in, d_out5);
register32_r_en U6_register32_r_en(clk, reset_n, en[6], d_in, d_out6);
register32_r_en U7_register32_r_en(clk, reset_n, en[7], d_in, d_out7);
endmodule
