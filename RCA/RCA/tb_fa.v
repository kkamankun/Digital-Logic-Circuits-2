//Testbench Full Adder
`timescale 1ns/100ps

module tb_fa;
reg a, b, ci;
wire s, co;

fa U0_fa(.a(a), .b(b), .ci(ci), .s(s), .co(co));

initial
begin
a = 1'b0; b = 1'b0; ci = 1'b0; // s = 0, co = 0
#10; a = 1'b0; b = 1'b0; ci = 1'b1; // s = 1, co = 0
#10; a = 1'b0; b = 1'b1; ci = 1'b0; // s = 0, co = 1
#10; a = 1'b0; b = 1'b1; ci = 1'b1; // s = 0, co = 1
#10; a = 1'b1; b = 1'b0; ci = 1'b0; // s = 1, co = 0
#10; a = 1'b1; b = 1'b0; ci = 1'b1; // s = 0, co = 1
#10; a = 1'b1; b = 1'b1; ci = 1'b0; // s = 0, co = 1
#10; a = 1'b1; b = 1'b1; ci = 1'b1; // s = 1, co = 1
#10; $stop;
end
endmodule


