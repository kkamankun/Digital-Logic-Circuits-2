// topmodule
module fifo(clk, reset_n, rd_en, wr_en, din, dout, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	input clk, reset_n, rd_en, wr_en;
	input[31:0] din;
	output[31:0] dout;
	output full, empty;
	output wr_ack, wr_err, rd_ack, rd_err;
	output[3:0] data_count;

	wire[2:0] head, next_head;
	wire[2:0] tail, next_tail;
	wire[2:0] state, next_state;
	wire[3:0] next_data_count;
	wire we, re;
	wire[31:0] to_mux, to_ff;

	// Next state logic
	fifo_ns U0_ns(.wr_en(wr_en), .rd_en(rd_en), .state(state), .data_count(data_count), .next_state(next_state));
	// Calculate address logic
	fifo_cal_addr U1_cal(.state(next_state), .head(head), .tail(tail), .data_count(data_count), .we(we), .re(re), .next_head(next_head), .next_tail(next_tail), .next_data_count(next_data_count));
	// Output logic
	fifo_out U2_out(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	// 4 dff
	_dff_4_r U3_data_count(.clk(clk), .reset_n(reset_n), .d(next_data_count), .q(data_count));
	_dff_3_r U4_state(clk, reset_n, next_state, state);
	_dff_3_r U5_head(clk, reset_n, next_head, head);
	_dff_3_r U6_tail(clk, reset_n, next_tail, tail);
	// Register file
	Register_file U7_register(.clk(clk), .reset_n(reset_n), .wAddr(tail), .wData(din), .we(we), .rAddr(head), .rData(to_mux));

	mx2_32bits U8_mux(.d0(32'b0), .d1(to_mux), .s(re), .y(to_ff));
	_DFF32 U9_DFF32(.clk(clk), .d(to_ff), .q(dout));
endmodule


