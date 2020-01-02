// Testbench for Async/Sync Set/Resettable D Flip-Flop
`timescale 1ns/100ps

module tb_dff_rs_sync_async;
	reg tb_clk, tb_set_n, tb_reset_n, tb_d;
	wire tb_q_sync, tb_q_async;

	parameter STEP = 10;

	_dff_rs_sync_async U0_dff_rs_sync_async(.clk(tb_clk), .set_n(tb_set_n), .reset_n(tb_reset_n),
	 .d(tb_d), .q_sync(tb_q_sync), .q_async(tb_q_async));
	 
	always #(STEP/2) tb_clk = ~tb_clk;

	initial
	begin
		tb_clk = 1'b0; tb_reset_n = 1'b0; tb_set_n = 1'b0; #3; 			// tb_q_sync = 1'b0, tb_q_async = 1'b0
		tb_d = 1'b1; #10;
		tb_reset_n = 1'b1; tb_set_n = 1'b0; #10;								// tb_q_sync = 1'b1, tb_q_async = 1'b1
		tb_d = 1'b0; #10;
		tb_set_n = 1'b0; #10;
		tb_reset_n =1'b0; #10;                                         // tb_reset_n falling
		tb_reset_n =1'b1; #10;
		tb_d = 1'b1; #10;
		tb_set_n = 1'b1; #10;														
		tb_set_n = 1'b0; #10;														// tb_set_n falling
		tb_d = 1'b0; #10;
		$stop;
	end
endmodule
