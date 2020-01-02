// Testbench of shifter8
`timescale 1ns/100ps

module tb_shifter8;
reg tb_clk, tb_reset_n;
reg[2:0] tb_op;
reg[1:0] tb_shamt;
reg[7:0] tb_d_in;
wire[7:0] tb_d_out;

parameter STEP = 10;

shifter8 U0_shifter8(tb_clk, tb_reset_n, tb_op, tb_shamt, tb_d_in, tb_d_out);

// clock period = 10ns
always #(STEP/2) tb_clk = ~tb_clk;
initial
begin
#0; tb_clk=0; tb_reset_n=0; tb_op=3'b0; tb_shamt=2'b0; tb_d_in=8'b0; 
#13; tb_reset_n=1;																	
#10; tb_op=3'b001; tb_d_in=8'b01110111;										
#20; tb_op=3'b010;
#20; tb_shamt=2'b01;
#30; tb_op=3'b011;
#20; tb_op=3'b010; tb_shamt=2'b11;
#10; tb_op=3'b001; tb_d_in=8'b10000111;
#30; tb_op=3'b100; tb_shamt=2'b01;
#30; tb_shamt=2'b11;
#30; tb_reset_n=0;
#10; $stop;
end
endmodule

// Note :
// NOP = 3'b000
// LOAD = 3'b001
// LSL = 3'b010
// LSR = 3'b011
// ASR = 3'b100
