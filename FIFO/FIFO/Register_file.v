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

// 8-to-1 MUX
module _8_to_1_MUX(a, b, c, d, e, f, g, h, sel, d_out);
	input [31:0] a, b, c, d, e, f, g, h;
	input [2:0] sel;
	output reg[31:0] d_out;

	always@(sel, a, b, c, d, e, f, g, h) begin
		case(sel)
		3'b000 : d_out = a;
		3'b001 : d_out = b;
		3'b010 : d_out = c;
		3'b011 : d_out = d;
		3'b100 : d_out = e;
		3'b101 : d_out = f;
		3'b110 : d_out = g;
		3'b111 : d_out = h;
		default : d_out = 32'hx;
		endcase
	end
endmodule

// Read operation
module read_operation(Addr, Data, from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5,
	 from_reg6, from_reg7);
	 input[31:0] from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5,
	 from_reg6, from_reg7;
	 input[2:0] Addr;
	 output[31:0] Data;
	 
	 _8_to_1_MUX U0_8_to_1_MUX(from_reg0, from_reg1, from_reg2, from_reg3, from_reg4, from_reg5,
	 from_reg6, from_reg7, Addr, Data);
 endmodule
 
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

// Register_file
module Register_file(clk, reset_n, wAddr, wData, we, rAddr, rData);
	input clk, reset_n, we;
	input[2:0] wAddr, rAddr;
	input[31:0] wData;
	output[31:0] rData;

	wire[7:0] to_reg;
	wire[31:0] from_reg[7:0];

	register32_8 U0_register32_8(.clk(clk), .reset_n(reset_n), .en(to_reg), .d_in(wData), .d_out0(from_reg[0]), .d_out1(from_reg[1]), 
	.d_out2(from_reg[2]), .d_out3(from_reg[3]), .d_out4(from_reg[4]), .d_out5(from_reg[5]), .d_out6(from_reg[6]), .d_out7(from_reg[7]));
	 
	 write_operation U1_write_operation(wAddr, we, to_reg);
	 
	 read_operation U2_read_operation(.Addr(rAddr), .Data(rData), .from_reg0(from_reg[0]), .from_reg1(from_reg[1]), .from_reg2(from_reg[2]),
	.from_reg3(from_reg[3]), .from_reg4(from_reg[4]), .from_reg5(from_reg[5]), .from_reg6(from_reg[6]), .from_reg7(from_reg[7]));
 endmodule
 