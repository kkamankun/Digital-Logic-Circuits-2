// Radix-2 Booth Multiplication
module multiplier(clk, reset_n, multiplier, multiplicand, op_start, op_clear, op_done, result);
	input clk, reset_n;
	input[63:0] multiplier, multiplicand;
	input op_start, op_clear;
	output op_done;
	output[127:0] result;

	wire[1:0] w_state, w_next_state;
	wire[6:0] w_count, w_next_count;
	wire[127:0] w_cal_result;
	
	// next state logic
	ns_logic U0_ns_logic(.op_start(op_start), .op_clear(op_clear), .count(w_count), .state(w_state), .next_state(w_next_state), .next_count(w_next_count));

	// output logic
	os_logic U1_os_logic(.state(w_state), .cal_result(w_cal_result), .result(result), .op_done(op_done));

	// calculate logic
	cal_logic U2_cal_logic(.clk(clk), .multiplier(multiplier), .multiplicand(multiplicand), .next_state(w_next_state), .count(w_count), .cal_result(w_cal_result));
	
	 // register
	_dff_r_3 U3_state(.clk(clk), .reset_n(reset_n), .d(w_next_state), .q(w_state));
	_dff_r_7 U4_count(.clk(clk), .reset_n(reset_n), .d(w_next_count), .q(w_count));

endmodule
