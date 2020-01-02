// 3bit Resettable D Flip-Flop with active low
// state
module _dff_r_3(clk, reset_n, d, q);
	input clk, reset_n;
	input[2:0] d;
	output reg[2:0] q;
	
	always@(posedge clk or negedge reset_n)
		begin
		if(reset_n==0) q <= 0;
		else q <= d;
		end
endmodule
	
// 7bit Resettable D Flip-Flop with active low
// count
module _dff_r_7(clk, reset_n, d, q);
	input clk, reset_n;
	input[6:0] d;
	output reg[6:0] q;
	
	always@(posedge clk or negedge reset_n)
		begin
		if(reset_n==0) q <= 0;
		else q <= d;
		end
endmodule
