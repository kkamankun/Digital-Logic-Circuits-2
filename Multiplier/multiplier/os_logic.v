// Output logic
module os_logic(state, cal_result, result, op_done);
	input[1:0] state;
	input[127:0] cal_result;
	output[127:0] result;
	output reg op_done;

	parameter IDLE = 2'b00;
	parameter EXEC = 2'b01;
	parameter DONE = 2'b10;
	
	assign result = cal_result;
	
	always@(state)
	begin
	case(state)
		IDLE : begin
			op_done = 0;
			end
		EXEC :
			op_done = 0;
		DONE : 
			op_done = 1;
		default:
			op_done = 1'bx;
	endcase
	end
endmodule
