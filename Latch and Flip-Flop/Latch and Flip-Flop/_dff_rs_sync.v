// Sync Set/Resettable D Flip-Flop
module _dff_rs_sync(clk, set_n, reset_n, d, q);
	input clk, set_n, reset_n, d;
	output q;
	reg q;

	always@(posedge clk)
	begin
		if(reset_n == 0) q <= 1'b0;
		else if(set_n == 0) q <= 1'b1;
		else q <= d;
	end
	// Note : D F/F with active-low synchronous reset and set
endmodule
