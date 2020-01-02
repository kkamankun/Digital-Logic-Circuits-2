// 3 to 8 decoder
module _3_to_8_decoder(d, q);
input[2:0] d;
output reg[7:0] q;

always@(d) begin
case(d)
3'b000:q=8'b00000001;
3'b001:q=8'b00000010;
3'b010:q=8'b00000100;
3'b011:q=8'b00001000;
3'b100:q=8'b00010000;
3'b101:q=8'b00100000;
3'b110:q=8'b01000000;
3'b111:q=8'b10000000;
default:q=8'hx;
endcase
end
endmodule

// Wirte operation
module write_operation(Addr, we, to_reg);
input we;
input[2:0] Addr;
output[7:0] to_reg;

wire[7:0] w_a;

// Instance of decoder, 2-input and gates(#8)
_3_to_8_decoder U0_3_to_8_decoder(Addr, w_a);
_and2 U1_and2(we, w_a[0], to_reg[0]);
_and2 U2_and2(we, w_a[1], to_reg[1]);
_and2 U3_and2(we, w_a[2], to_reg[2]);
_and2 U4_and2(we, w_a[3], to_reg[3]);
_and2 U5_and2(we, w_a[4], to_reg[4]);
_and2 U6_and2(we, w_a[5], to_reg[5]);
_and2 U7_and2(we, w_a[6], to_reg[6]);
_and2 U8_and2(we, w_a[7], to_reg[7]);
endmodule

