// Testbench of ram
`timescale 1ns/100ps
module tb_ram;
	reg tb_clk;
	reg tb_cen, tb_wen;
	reg [4:0] tb_addr;
	reg [31:0] tb_din;
	wire [31:0] tb_dout;

	ram U0_ram(tb_clk, tb_cen, tb_wen, tb_addr, tb_din, tb_dout);

	always#(5) tb_clk = ~tb_clk;	
	initial begin
		#0; tb_clk=0; tb_cen=0; tb_wen=0; tb_addr=0; tb_din=0;
		#17; tb_cen=1; tb_wen=1;				// Write
		#10; tb_addr = 1; tb_din = 1;
		#10; tb_addr = 2; tb_din = 2;
		#10; tb_addr = 3; tb_din = 3;
		#10; tb_addr = 4; tb_din = 4;
		#10; tb_addr = 5; tb_din = 5;
		#10; tb_addr = 6; tb_din = 6;
		#10; tb_addr = 7; tb_din = 7;
		#10; tb_addr = 8; tb_din = 8;
		#10; tb_addr = 9; tb_din = 9;
		#10; tb_addr = 10; tb_din = 10;
		#10; tb_addr = 11; tb_din = 11;
		#10; tb_addr = 12; tb_din = 12;
		#10; tb_addr = 13; tb_din = 13;
		#10; tb_addr = 14; tb_din = 14;
		#10; tb_addr = 15; tb_din = 15;
		#10; tb_addr = 16; tb_din = 16;
		#10; tb_addr = 17; tb_din = 17;
		#10; tb_addr = 18; tb_din = 18;
		#10; tb_addr = 19; tb_din = 19;
		#10; tb_addr = 20; tb_din = 20;
		#10; tb_addr = 21; tb_din = 21;
		#10; tb_addr = 22; tb_din = 22;
		#10; tb_addr = 23; tb_din = 23;
		#10; tb_addr = 24; tb_din = 24;
		#10; tb_addr = 25; tb_din = 25;
		#10; tb_addr = 26; tb_din = 26;
		#10; tb_addr = 27; tb_din = 27;
		#10; tb_addr = 28; tb_din = 28;
		#10; tb_addr = 29; tb_din = 29;
		#10; tb_addr = 30; tb_din = 30;
		#10; tb_addr = 31; tb_din = 31;
		#10; tb_wen = 0; tb_cen = 0;
		#10; tb_cen = 1; 							// Read
		#10; tb_addr = 1;
		#10; tb_addr = 2;
		#10; tb_addr = 3;
		#10; tb_addr = 4;
		#10; tb_addr = 5;
		#10; tb_addr = 6;
		#10; tb_addr = 7;
		#10; tb_addr = 8;
		#10; tb_addr = 9;
		#10; tb_addr = 10;
		#10; tb_addr = 11;
		#10; tb_addr = 12;
		#10; tb_addr = 13;
		#10; tb_addr = 14;
		#10; tb_addr = 15;
		#10; tb_addr = 16;
		#10; tb_addr = 17;
		#10; tb_addr = 18;
		#10; tb_addr = 19;
		#10; tb_addr = 20;
		#10; tb_addr = 21;
		#10; tb_addr = 22;
		#10; tb_addr = 23;
		#10; tb_addr = 24;
		#10; tb_addr = 25;
		#10; tb_addr = 26;
		#10; tb_addr = 27;
		#10; tb_addr = 28;
		#10; tb_addr = 29;
		#10; tb_addr = 30;
		#10; tb_addr = 31;
		#30; tb_cen = 0; tb_addr = 0; tb_din = 0;
		#50; $stop;
	end
endmodule
