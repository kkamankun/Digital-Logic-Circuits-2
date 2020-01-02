// Testbench of a 5-way Counter
`timescale 1ns/100ps

module tb_cnt5;

reg	tb_clk, tb_reset_n, tb_inc;
wire[2:0] tb_cnt;

parameter STEP = 10;

cnt5 U0_cnt5(tb_cnt, tb_clk, tb_reset_n, tb_inc);

// clock period : 10ns
always#(STEP/2) tb_clk = ~tb_clk;
initial
begin
tb_clk = 0; tb_reset_n =0; tb_inc =0; #3// set up variables
tb_reset_n = 1; #3;
tb_inc=1; #10;
tb_inc=1; #10;
tb_inc=1; #10;
tb_inc=1; #10;
tb_inc=1; #10;
tb_reset_n = 0; #3;
tb_inc=1; #3;
tb_reset_n = 1; #3
tb_inc=0; #10;
tb_inc=0; #10;
tb_inc=0; #10;
tb_inc=0; #10;
$stop;
end
endmodule
