// 8-bit Loadable Up/Down Counter
module cntr8(clk, reset_n, inc, load, d_in, d_out, o_state);
input clk, reset_n, inc, load;
input[7:0] d_in;
output[7:0] d_out;
output[2:0] o_state;

wire[2:0] next_state;
wire[2:0] state;

assign o_state = state;

ns_logic U1_ns_logic(load,inc, state, next_state);
_register3_r U0_reg3r(clk, reset_n, next_state, state);
os_logic U2_os_logic(state, d_in, d_out);

endmodule
