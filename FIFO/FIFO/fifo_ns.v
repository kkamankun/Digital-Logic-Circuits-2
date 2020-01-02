// next state logic
module fifo_ns(wr_en, rd_en, state, data_count, next_state);
	input wr_en, rd_en;
	input[2:0] state;
	input[3:0] data_count;
	output reg[2:0] next_state;

	parameter INIT 		= 3'b000;
	parameter NO_OP 		= 3'b001;
	parameter WRITE 		= 3'b010;
	parameter WR_ERROR 	= 3'b011;
	parameter READ 		= 3'b100;
	parameter RD_ERROR 	= 3'b101;

	always@(wr_en, rd_en, state, data_count)
		begin
		case(state)
		INIT: begin
				if(rd_en==1 && wr_en==0 && data_count==0)
					next_state = RD_ERROR;
				else if(wr_en==1 && rd_en==0 && data_count<8)
					next_state = WRITE;
				else
					next_state = NO_OP;
				end
		READ: begin
				if(rd_en==1 && wr_en==0 && data_count==0)
					next_state = RD_ERROR;
				else if(rd_en==1 && wr_en==0 && data_count>0)
					next_state = READ;
				else if(wr_en==1 && rd_en==0 && data_count<8)
					next_state = WRITE;
				else
					next_state = NO_OP;
				end
		RD_ERROR: begin
				if(rd_en==1 && wr_en==0 && data_count==0)
					next_state = RD_ERROR;
				else if(wr_en==1 && rd_en==0 && data_count<8)
					next_state = WRITE;
				else
					next_state = NO_OP;
				end
		WRITE: begin
				if(wr_en==1 && rd_en==0 && data_count==8)
					next_state = WR_ERROR;
				else if(wr_en==1 && rd_en==0 && data_count<8)
					next_state = WRITE;
				else if(wr_en==0 && rd_en==1 && data_count>0)
					next_state = READ;
				else 
					next_state = NO_OP;
				end
		WR_ERROR: begin
				if(wr_en==1 && rd_en==0 && data_count==8)
					next_state = WR_ERROR;
				else if(wr_en==0 && rd_en==1 && data_count>0)
					next_state = READ;
				else 
					next_state = NO_OP;
				end
		NO_OP: begin
				if(rd_en==1 && wr_en==0 && data_count==0)
					next_state = RD_ERROR;
				else if(wr_en==1 && rd_en==0 && data_count==8)
					next_state = WR_ERROR;
				else if(wr_en==1 && rd_en==0 && data_count<8)
					next_state = WRITE;
				else if(wr_en==0 && rd_en==1 && data_count>0)
					next_state = READ;
				else
					next_state = NO_OP;
				end
		default: next_state = 3'bx;
		endcase
		end
endmodule



