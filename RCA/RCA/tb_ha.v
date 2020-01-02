//Testbench Half Adder
`timescale 1ns/100ps

module tb_ha;
reg a;
reg b;
wire s;
wire co;

ha U0_ha(.a(a), .b(b), .s(s), .co(co));

initial
begin
a=1'b0; b=1'b0; // s = 0, co = 0
#10; a=1'b1; b=1'b0; // s = 1, co = 0
#10; a=1'b0; b=1'b1; // s = 1, co = 0
#10; a=1'b1; b=1'b1; // s = 0, co = 1
#10; $stop;
end
endmodule
