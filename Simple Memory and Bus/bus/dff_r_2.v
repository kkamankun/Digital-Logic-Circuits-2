// 2bit D Flip Flop with active low
module dff_r_2(clk, reset_n, d, q);
	input clk, reset_n;
	input[1:0] d;
	output reg[1:0] q;
	
	always@(posedge clk)
	begin
		if(reset_n == 0)
			q = 0;
		else 
			q = d;
	end
endmodule
