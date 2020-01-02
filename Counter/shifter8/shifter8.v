// shifter8
module shifter8(clk, reset_n, op, shamt, d_in, d_out);
input clk, reset_n;
input[2:0] op; // operation
input[1:0] shamt; // shift amout
input[7:0] d_in;
output[7:0] d_out;

wire[7:0] w_do_next;

cc_logic U1_cc_logic(op, shamt, d_in, d_out, w_do_next);
_register8_r U0_reg8_r(clk, reset_n, w_do_next, d_out);
endmodule
