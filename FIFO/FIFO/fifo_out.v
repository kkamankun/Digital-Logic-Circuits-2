// output logic
module fifo_out(state, data_count, full, empty, wr_ack, wr_err, rd_ack, rd_err);
	input[2:0] state;
	input[3:0] data_count;
	output reg full, empty;										// determine by data_count
	output reg wr_ack, wr_err, rd_ack, rd_err;			// determine by state

	parameter INIT 		= 3'b000;
	parameter NO_OP 		= 3'b001;
	parameter WRITE 		= 3'b010;
	parameter WR_ERROR 	= 3'b011;
	parameter READ 		= 3'b100;
	parameter RD_ERROR 	= 3'b101;
	
always@(data_count)
			begin
			if(data_count == 0) begin
				full = 0;
				empty = 1; 
				end
			else if(data_count == 8) begin
				full = 1;
				empty = 0;
				end
			else begin			// [1, 7]
				full = 0;
				empty = 0;
				end
			end


always @ (state) begin
		case(state)
			INIT		: begin
				wr_ack = 0;
				wr_err = 0;
				rd_ack = 0;
				rd_err = 0;
			end
			
			NO_OP		: begin
				wr_ack = 0;
				wr_err = 0;
				rd_ack = 0;
				rd_err = 0;
			end
			
			WRITE		: begin
				wr_ack = 1;
				wr_err = 0;
				rd_ack = 0;
				rd_err = 0;
			end
			
			WR_ERROR	: begin
				wr_ack = 0;
				wr_err = 1;
				rd_ack = 0;
				rd_err = 0;
			end
			
			READ		: begin
				wr_ack = 0;
				wr_err = 0;
				rd_ack = 1;
				rd_err = 0;
			end
			
			RD_ERROR	: begin
				wr_ack = 0;
				wr_err = 0;
				rd_ack = 0;
				rd_err = 1;
			end
			default	: begin
				wr_ack = 1'bx;
				wr_err = 1'bx;
				rd_ack = 1'bx;
				rd_err = 1'bx;
			end
		endcase
		end
	
/*	
always@(state)
	begin
	if(state == INIT) begin
		wr_ack =0; wr_err =0; rd_ack =0; rd_err =0; end
	else if(state == NO_OP) begin
		wr_ack =0; wr_err =0; rd_ack =0; rd_err =0; end
	else if(state == WRITE) begin
		wr_ack =1; wr_err =0; rd_ack =0; rd_err =0; end
	else if(state == WR_ERROR) begin
		wr_ack =0; wr_err =1; rd_ack =0; rd_err =0; end
	else if(state == READ) begin
		wr_ack =0; wr_err =0; rd_ack =1; rd_err =0; end
	else if(state == RD_ERROR) begin
		wr_ack =0; wr_err =0; rd_ack =0; rd_err =1; end
	end
*/
	
endmodule

	
	
	