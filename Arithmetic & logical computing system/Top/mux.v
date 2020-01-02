module mx2_8bits(d0,d1,s,y); // 8bit 2-to-1 mux
input [7:0]d0,d1;
input s;
output [7:0]y;

assign y=(s==1'b0)?d0:d1;
endmodule

module MUX_6_to_1(d0,d1,d2,d3,d4,d5,s,y); // 32bit 6-to-1 mux
	input [31:0] d0,d1,d2,d3,d4,d5;
	input [5:0]s;
	
	output reg [31:0] y;
	always@(s , d0, d1, d2,d3,d4,d5)
		begin
		case(s)
		6'b000001: y=d0;
		6'b000010: y=d1;
		6'b000100: y=d2;
		6'b001000: y=d3;
		6'b010000: y=d4;
		6'b100000: y=d5;
		default: y <= 32'b0;
		endcase
		end
endmodule

module MUX_4_to_1(reset_n,d0,d1,d2,d3,s,y);
	input [31:0] d0,d1,d2,d3;
	input [2:0]s;
	input reset_n;
	output reg [31:0] y;
	always@(s , d0, d1, d2, d3,reset_n)
		begin
		if(reset_n == 1'b0)
			begin
			y = 32'b0;
			end
		else
			begin
				case(s)
				3'b001: y=d0;
				3'b010: y=d1;
				3'b100: y=d2;
				default: y=d3;
				endcase
			end
		end
endmodule

module mx5_32bits(d0,d1,d2,d3,d4,d5,s,y); // 32bit 5-to-1 mux.
input [31:0]d0,d1,d2,d3,d4,d5;
input [4:0]s;
output reg[31:0]y;

	always@* begin
		case(s)
			5'b00000: y = d0;
			5'b00001: y = d1;
			5'b00010: y = d2;
			5'b00100: y = d3;
			5'b01000: y = d4;
			5'b10000: y = d5;
			default: y = 32'bx;
		endcase
		end
endmodule

module mx2_32bits(d0, d1, s, y); // 32bit 2-to-1 mux
	input [31:0] d0, d1;
	input s;
	output [31:0] y;

	assign y = (s == 0) ? d0: d1;
endmodule

module mx2(d0,d1,s,y); // 1bit 2-to-1 mux
	input d0,d1;
	input s;
	output y;

	assign y=(s==1)?d1:d0;
endmodule


