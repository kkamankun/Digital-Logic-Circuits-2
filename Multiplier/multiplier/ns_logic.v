// Next state logic
module ns_logic(op_start, op_clear, count, state, next_state, next_count);
	input op_start, op_clear;
	input[1:0] state;
	input[6:0] count;								// 7bit
	output reg[1:0] next_state;
	output reg[6:0] next_count;
	
	parameter IDLE = 2'b00;
	parameter EXEC = 2'b01;
	parameter DONE = 2'b10;
	
	always@(op_start, op_clear, count, state)
	begin
	case(state) 
	IDLE : begin
		next_count = 0;
		if(op_start == 1)
			next_state = EXEC;
		else 											// op_start == 0
			next_state = IDLE;
		end
	EXEC : begin
		next_count = count + 7'b1;
		if(op_clear == 1)
			next_state = IDLE;
		else if(count == 63)						// 64 = 2'b1000000
			next_state = DONE;
		else
			next_state = EXEC;
		end
	DONE : begin
		next_count = count;
		if(op_clear == 1)
			next_state = IDLE;
		else 
			next_state = DONE;
		end
	default : begin
		next_state = 2'bx;
		next_count = 7'bx;
		end
	endcase
	end
endmodule

		
		
		
			
	