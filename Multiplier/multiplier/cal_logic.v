module cal_logic(clk, multiplier, multiplicand, next_state, count, cal_result);
	input clk;
	input[63:0] multiplicand, multiplier;
	input[6:0] count;
	input[1:0] next_state;
	output reg[127:0] cal_result;

	reg[63:0] u, v, x;
	reg x_prev;

	parameter IDLE = 2'b00;
	parameter EXEC = 2'b01;
	parameter DONE	= 2'b10;


	always@(posedge clk)
	begin
	if(count == 63) 
	cal_result = {u, v};
	else
		case(next_state)
			IDLE : begin
				u = 0;
				v = 0;
				x = multiplier;
				x_prev = 0;
				cal_result = 0;
				end
			EXEC : begin
				case({x[0], x_prev})
				2'b00 : begin											// Shift only
					v = v >> 1;
					v[63] = u[0];
					u = u >> 1;											// Arithmetic right shift
					u[63] = u[62];
					x_prev = x[0];
					x = x >> 1; 										// Circular right shift
					x[63] = x_prev;
					end
				2'b01 : begin											// Add and shift
					u = u + multiplicand;
					v = v >> 1; v[63] = u[0];
					u = u >> 1;											// Arithmetic right shift
					u[63] = u[62];
					x_prev = x[0];
					x = x >> 1; 										// Circular right shift
					x[63] = x_prev;
					end
				2'b10 : begin											// Subtract and shift
					u = u - multiplicand;
					v = v >> 1; v[63] = u[0];
					u = u >> 1;											// Arithmetic right shift
					u[63] = u[62];
					x_prev = x[0];
					x = x >> 1; 										// Circular right shift
					x[63] = x_prev;
					end
				2'b11 : begin											// Shift only
					v = v >> 1;
					v[63] = u[0];
					u = u >> 1;											// Arithmetic right shift
					u[63] = u[62];
					x_prev = x[0];
					x = x >> 1; 										// Circular right shift
					x[63] = x_prev;
					end
				default : begin
					u = 64'bx;
					v = 64'bx;
					x = 64'bx;
					x_prev = 1'bx;
					end
				endcase
				end
			DONE : begin
				cal_result = {u, v};
				end
			default : begin
				u = 64'bx;
				v = 64'bx;
				x = 64'bx;
				x_prev = 1'bx;
				end
		endcase
	end
endmodule

