// ALU
module ALU_Top(clk, reset_n, s_sel, s_wr, s_addr, s_din, s_dout, s_interrupt);
input clk, reset_n, s_sel, s_wr;
input [15:0] s_addr;
input [31:0] s_din;
output [31:0] s_dout;
output s_interrupt;

endmodule

/*
module ALU_SLAVE(clk, reset_n, s_sel, s_wr, s_addr, s_din, s_dout, s_interrupt, 
	opstart, opdone_clear, status, result_out, result,
	rd_ack_result, rData);
	input clk, reset_n, s_sel, s_wr, rd_ack_result;
	input [1:0] status;
	input [15:0] s_addr;
	input [31:0] rData, result_out;
	
	
	input [31:0] s_din;
	input [63:0] result;
	
	output [31:0] s_dout;
	output s_interrupt;
	output opstart, opdone_clear;
	
	wire [4:0] state, next_state;	
	
	// Registers
	reg [31:0] OPERATION_START;
	reg [31:0] INTERRUPT;
	reg [31:0] INTERRUPT_ENABLE;
	reg [31:0] INSTRUCTION;
	reg [31:0] RESULT;
	reg [31:0] ALU_STATUS;
endmodule

module ALU_EXEC(clk, reset_n, opstart, opdone_clear, inst_out, opA_in, opB_in, rd_en_inst, rd_en, opAaddr, opBaddr, wr_en_fifo);
	input clk, reset_n, opstart, opdone_clear, inst_out, opA_in, opB_in;
	output rd_en_inst, rd_en, opAaddr, opBaddr, wr_en_fifo;

	reg [2:0] next_state;
	// State Encoding
	parameter IDLE = 4'b0000;
	parameter INST_POP1 = 4'b0001;
	parameter EXEC_ELSE = 4'b0010;
	parameter MUL = 4'b0011;
	parameter RESULT_PUSH1 = 4'b0100;
	parameter RESULT_PUSH2 = 4'b0101;
	parameter INST_POP2 = 4'b0110;
	parameter NOP = 4'b0111;
	parameter DONE = 4'b1000;
	parameter FAULT = 4'b1001;
	
	// Next State Logic
	always@* begin
		if(reset_n == 0)
			next_state = IDLE;
		else begin
			case(state)
				IDLE : begin
					if(opstart == 1) next_state = INST_POP1;
					else next_state = IDLE;
				end
				INST_POP1 : begin
					if(rd_err_inst == 1)	next_state = FAULT;
					else if(rd_ack_inst == 1) begin
						if(opcode == 4'h0) next_state = NOP;
						else if(opcode == 4'hF)	next_state = MUL;
						else next_state = EXEC_ELSE;
					end	
				end
				EXEC_ELSE : 
					next_state = RESULT_PUSH1;
				MUL : begin
					if(mul_done == 1) next_state = RESULT_PUSH1;
					else next_state = MUL;
				end
				RESULT_PUSH1 :
					next_state = RESULT_PUSH2;
				RESULT_PUSH2 :
					next_state = INST_POP2;
				INST_POP2 : begin
					if(rd_err_inst == 1) next_state = DONE;
					else if(rd_ack_inst == 1) begin
						if(opcode == 4'h0) next_state = NOP;
						else if(opcode == 4'hF)	next_state = MUL;
						else next_state = EXEC_ELSE;
					end
				end
				NOP : 
					next_state = INST_POP2;
				DONE : begin
					if(opdone_clear == 1) next_state = IDLE;
					else next_state = DONE;
				end
				FAULT : 
					next_state = FAULT;
				default : 
					next_state = FAULT;
			endcase
		end
	end
endmodule
	
module ALU_FIFO();

endmodule

module ALU_RF();

endmodule
*/

