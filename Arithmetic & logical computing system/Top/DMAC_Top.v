// DMAC
module DMAC_Top(clk, reset_n, m_grant, m_din, s_sel, s_wr, s_addr, s_din, m_req, m_wr, m_addr, m_dout, s_dout, s_interrupt);
	input clk, reset_n, m_grant, s_sel, s_wr;
	input [31:0] m_din, s_din;
	input [15:0] s_addr;
	output m_req, m_wr, s_interrupt;
	output [15:0] m_addr;
	output [31:0] m_dout, s_dout;

	wire opstart, opdone_clear;						// Slave -> Master
	wire wr_en;												// Slave -> Descriptor
	wire rd_en;												// Master -> Descriptor
	wire [31:0] din0, din1, din2;						// Slave -> Descriptor
	wire [31:0] dout0, dout1, dout2;					// Descriptor -> Master
	wire [4:0] data_count;								// Descriptor -> Master / SlavE
	wire wr_err, rd_err, rd_ack;						// Descriptor -> Master
	wire [1:0] status;									// Master -> Slave
	
	
	// DMAC SLAVE
	DMAC_SLAVE U0_SLAVE(clk, reset_n, opdone_clear, s_sel, s_wr, s_addr, s_din,
	wr_en, din0, din1, din2, s_interrupt, s_dout, opstart, status);

	// DMAC MASTER
	DMAC_MASTER U1_MASTER(clk, reset_n, opstart, opdone_clear, m_req, m_grant, m_wr, m_addr, m_dout, m_din, dout0, dout1,
	dout2, rd_en, rd_ack, wr_err, rd_err, status);
	
	// DMAC FIFO
	DMAC_FIFO U2_FIFO(clk, reset_n, rd_en, wr_en, din0, din1, din2, dout0, dout1, dout2, wr_err, rd_err, rd_ack);
endmodule

// SLAVE of DMAC
module DMAC_SLAVE(clk, reset_n, opdone_clear, s_sel, s_wr, s_addr, s_din,
wr_en, src_addr, dest_addr, data_size, s_interrupt, s_dout, opstart, status);
	input clk, reset_n, s_sel, s_wr; 
	input [15:0] s_addr;
	input [31:0] s_din;
	input [1:0] status;
	
	output reg opdone_clear;
	output reg wr_en;
	output reg opstart, s_interrupt;
	output reg [31:0] dest_addr, src_addr, data_size;
	output reg [31:0] s_dout;
	
	// Registers of DMAC
	reg [31:0] OPERATION_START;
	reg [31:0] INTERRUPT;
	reg [31:0] INTERRUPT_ENABLE;
	reg [31:0] SOURCE_ADDRESS;
	reg [31:0] DESTINATION_ADDRESS;
	reg [31:0] DATA_SIZE;
	reg [31:0] DESCRIPTOR_PUSH;
	reg [31:0] OPERATION_MODE;
	reg [31:0] DMA_STATUS;
	

	always@(posedge clk)	begin
	if(reset_n == 0) begin						// Reset_n
		OPERATION_START = 0;
		INTERRUPT = 0;
		INTERRUPT_ENABLE = 0;
		SOURCE_ADDRESS = 0;
		DESTINATION_ADDRESS = 0;
		DATA_SIZE = 0;
		DESCRIPTOR_PUSH = 0;
		OPERATION_MODE = 0;
		DMA_STATUS = 0;
		wr_en = 0;
	end
	else if(s_sel == 1) begin
		if(DESCRIPTOR_PUSH[0] == 1) DESCRIPTOR_PUSH = 32'h0;
		if(INTERRUPT[0] == 1) OPERATION_START = 32'h0;	
		if(s_wr == 1) begin // WRITE
			s_dout = 0;
			case(s_addr[7:0])
				8'h00 :
					OPERATION_START = {31'h0, s_din[0]};
				8'h01 : 
					INTERRUPT = {31'h0, s_din[0]};
				8'h02 :
					INTERRUPT_ENABLE = {31'h0, s_din[0]};
				8'h03 : 
					SOURCE_ADDRESS = {16'h0, s_din[15:0]};
				8'h04 : 
					DESTINATION_ADDRESS = {16'h0, s_din[15:0]};	
				8'h05 : 
					DATA_SIZE = {27'h0, s_din[4:0]};
				8'h06 : 
					DESCRIPTOR_PUSH = {31'h0, s_din[0]};
				8'h07 :
					OPERATION_MODE =  {30'h0, s_din[1:0]};
				default :
					DMA_STATUS = 32'h3; // FAULT
			endcase
		end
		else begin // READ
			case(s_addr[7:0])
				8'h00 :
					s_dout = OPERATION_START;
				8'h01 : 
					s_dout = INTERRUPT;
				8'h02 :
					s_dout = INTERRUPT_ENABLE;
				8'h03 : 
					s_dout = SOURCE_ADDRESS;
				8'h04 :
					s_dout = DESTINATION_ADDRESS;
				8'h05 :
					s_dout = DATA_SIZE;
				8'h06 :
					s_dout = DESCRIPTOR_PUSH;
				8'h07 :
					s_dout = OPERATION_MODE;
				8'h08 :
					s_dout = DMA_STATUS;
				default : 
					DMA_STATUS = 32'h3;    // FAULT
			endcase
		end
	end
	else begin
		if(status == 2'b10) INTERRUPT = 32'h1;	// DONE
		else begin
			INTERRUPT = 32'h0;
			DMA_STATUS = {30'h0, status};
			s_dout = 0;
		end
	end
				
	// Interrupt		
	s_interrupt = INTERRUPT[0] & INTERRUPT_ENABLE[0];
	
	// To MASTER
	opstart = OPERATION_START[0];
	opdone_clear = ~INTERRUPT[0];
	
	// To FIFO
	src_addr = SOURCE_ADDRESS;
	dest_addr = DESTINATION_ADDRESS;
	data_size = DATA_SIZE;
	wr_en = DESCRIPTOR_PUSH[0];	
	end
endmodule

// master of DMAC
module DMAC_MASTER(clk, reset_n, opstart, opdone_clear, m_req, m_grant, m_wr, m_addr, m_dout, m_din, src_addr, dest_addr,
data_size, rd_en, rd_ack, wr_err, rd_err, status);
	input clk, reset_n, opstart, opdone_clear, m_grant, rd_ack, wr_err, rd_err;
	input [31:0] m_din;
	input [31:0] src_addr, dest_addr, data_size;
	output rd_en;
	output [1:0] status;
	output m_req, m_wr;
	output [15:0] m_addr;
	output [31:0] m_dout;
	
	wire [2:0] next_state, state;
	wire [31:0] next_size, size, next_src, src, next_dest, dest;
	
	// Next State Logic
	DMAC_ns_logic U1_ns_logic(m_grant, opstart, opdone_clear, wr_err, rd_err, rd_ack, state, size, next_state);
	
	// Output Logic
	DMAC_os_logic U2_os_logic(state, src, dest, m_din, m_req, m_wr, m_addr, m_dout);
	
	// Descriptor operation Logic
	DMAC_cal_logic U4_cal_logic(src_addr, dest_addr, data_size, rd_ack, state, status, next_state, rd_en, src, dest, size, next_src, next_dest, next_size);
	
	// D F/F
	dff3_r U5_state(next_state, reset_n, clk, state);
	dff32_r U6_source(next_src, reset_n, clk, src);
	dff32_r U7_destination(next_dest, reset_n, clk, dest);
	dff32_r U8_data_size(next_size, reset_n, clk, size);
endmodule

module DMAC_ns_logic(m_grant, opstart, opdone_clear, wr_err, rd_err, rd_ack, state, data_size, next_state);
	input m_grant, opstart, opdone_clear, wr_err, rd_err, rd_ack;
	input [2:0] state;
	input [31:0] data_size;
	output reg [2:0] next_state;
	
	// State Encoding
	parameter IDLE =	3'b000;
	parameter POP1 = 	3'b001;
	parameter M_REQ = 3'b010;
	parameter READ = 	3'b011;
	parameter WRITE = 3'b100;
	parameter POP2 = 	3'b101;
	parameter DONE = 	3'b110;
	parameter FAULT = 3'b111;
	
	always@* begin
		if(wr_err == 1) next_state = FAULT;
		else begin
			case(state)
				IDLE : begin
					if(opstart == 1) next_state = POP1;
					else next_state = IDLE;
				end
				POP1: begin
						if(rd_err == 1) next_state = FAULT;
						else if(rd_ack == 1) next_state = M_REQ;
						else next_state = POP1;
				end
				M_REQ: begin
						if(m_grant == 1) next_state = READ;
						else next_state = M_REQ;
				end
				READ: begin
						next_state = WRITE;
				end
				WRITE: begin
						if(data_size != 32'b0) next_state = READ;
						else next_state = POP2;
				end
				POP2: begin
						if(rd_err == 1) next_state = DONE;
						else if(rd_ack == 1) next_state = READ;
						else next_state = POP2;
				end
				DONE: begin
						if(opdone_clear == 1) next_state = IDLE;
						else next_state = DONE;
				end
				FAULT: next_state = FAULT;
				default: next_state = FAULT;
			endcase
		end
	end
endmodule

module DMAC_os_logic(state, src, dest, m_din, m_req, m_wr, m_addr, m_dout);
	input [2:0] state;
	input [31:0] src, dest, m_din;
	output reg m_req, m_wr;
	output reg [15:0] m_addr;
	output reg [31:0] m_dout;
	
	// State Encoding
	parameter IDLE =	3'b000;
	parameter POP1 = 	3'b001;	// Descriptor pop
	parameter M_REQ = 3'b010;	// Bus Request
	parameter READ = 	3'b011;	// RAM1, RAM2, ALU result FIFO
	parameter WRITE = 3'b100;	// ALU RF, FIFO, RAM3
	parameter POP2 = 	3'b101;	// Destriptor pop
	parameter DONE = 	3'b110;	
	parameter FAULT = 3'b111;
	
	always@* begin
		case(state)
			IDLE: begin
				m_req = 1'b0;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
			POP1: begin
				m_req = 1'b0;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
			M_REQ: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
			READ: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = src[15:0];
				m_dout = 32'h0;
			end
			WRITE: begin
				m_req = 1'b1;
				m_wr = 1'b1;
				m_addr = dest[15:0];
				m_dout = m_din;
			end
			POP2: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = 16'hFFFF;
				m_dout = 32'h0;
			end
			DONE: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
			FAULT: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
			default: begin
				m_req = 1'b1;
				m_wr = 1'b0;
				m_addr = 16'h0;
				m_dout = 32'h0;
			end
		endcase
	end
endmodule

module DMAC_cal_logic(dout0, dout1, dout2, rd_ack, state, status, next_state, rd_en, src, dest, size, next_src, next_dest, next_size);
	input rd_ack;
	input [31:0] dout0, dout1, dout2, src, dest, size;
	input [2:0] state, next_state;
	output reg [1:0] status;
	output reg rd_en;
	output reg [31:0] next_src, next_dest, next_size;

	// State Encoding
	parameter IDLE =	3'b000;
	parameter POP1 = 	3'b001;
	parameter M_REQ = 3'b010;
	parameter READ = 	3'b011;
	parameter WRITE = 3'b100;
	parameter POP2 = 	3'b101;
	parameter DONE = 	3'b110;
	parameter FAULT = 3'b111;
	
	// NOTE
	// 2'b00 = Waiting
	// 2'b01 = Executing
	// 2'b10 = Done
	// 2'b11 = Fault
		
	always@ * begin
		if(rd_ack == 1) begin
			next_src = dout0;	// src_addr from descriptor
			next_dest = dout1; // dest_addr from descriptor
			next_size = dout2; // data_size from descriptor
		end
	// Generate status, rd_en
		case(next_state)
			IDLE: begin
				status = 2'b00;
				rd_en = 0;
				next_src = 32'h0;
				next_dest = 32'h0;
				next_size = 32'h0;
			end
			POP1: begin
				status = 2'b01;
				rd_en = 1;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			M_REQ: begin
				status = 2'b01;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			READ: begin
				status = 2'b01;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			WRITE: begin
				status = 2'b01;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			POP2: begin
				status = 2'b01;
				rd_en = 1;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			DONE: begin
				status = 2'b10;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			FAULT: begin
				status = 2'b11;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
			default: begin
				status = 2'b00;
				rd_en = 0;
				next_src = src;
				next_dest = dest;
				next_size = size;
			end
		endcase
	end
endmodule

// DMAC FIFO
module DMAC_FIFO(clk, reset_n, rd_en, wr_en, din0, din1, din2, dout0, dout1, dout2, wr_err, rd_err, rd_ack);
	input clk, reset_n;
	input rd_en, wr_en;
	input [31:0] din0, din1, din2;
	output [31:0] dout0, dout1, dout2;
	output wr_err, rd_err, rd_ack;

	wire 	src_rd_ack, src_rd_err, src_wr_ack, src_wr_err,
		des_rd_ack, des_rd_err, des_wr_ack, des_wr_err,
		siz_rd_ack, siz_rd_err, siz_wr_ack, siz_wr_err;

	FIFO16 U0_src_addr(clk, reset_n, rd_en, wr_en, din0, dout0, src_rd_ack, src_wr_err, src_rd_err);
	FIFO16 U1_dest_addr(clk, reset_n, rd_en, wr_en, din1, dout1, des_rd_ack, des_wr_err, des_rd_err); 
	FIFO16 U2_data_size(clk, reset_n, rd_en, wr_en, din2, dout2, siz_rd_ack, siz_wr_err, siz_rd_err);

	// Outputs
	assign wr_err = src_wr_err | des_wr_err | siz_wr_err;
	assign rd_err = src_rd_err | des_rd_err | siz_rd_err; 
	assign rd_ack = src_rd_ack & des_rd_ack & siz_rd_ack;
endmodule	

// FIFO(capacity 16)
module FIFO16(clk, reset_n, rd_en, wr_en, din, dout, rd_ack, wr_err, rd_err);
	input clk, reset_n;
	input rd_en, wr_en;
	input [31:0] din;
	output [31:0] dout;
	output rd_ack, wr_err, rd_err;
	
	wire[3:0] head, next_head;
	wire[3:0] tail, next_tail;
	wire[2:0] state, next_state;
	wire[4:0] data_count, next_data_count;
	wire we, re;
	
	// Next state logic
	fifo16_ns U0_fifo_ns(.wr_en(wr_en),.rd_en(rd_en),.state(state),.data_count(data_count),.next_state(next_state));
	
	// Calculate address logic
	fifo16_cal U1_fifo_cal(.next_state(next_state),.data_count(data_count),.head(head),.tail(tail),
	.next_data_count(next_data_count),.next_head(next_head),.next_tail(next_tail),.we(we),.re(re));
	
	// Output logic
	fifo16_out U2_fifo_out(state, rd_ack, wr_err, rd_err);
	
	
	// D F/F
	dff3_r U3_state(.d(next_state),.reset_n(reset_n),.clk(clk),.q(state));
	dff5_r U4_data_count(.d(next_data_count),.reset_n(reset_n),.clk(clk),.q(data_count));
	dff4_r U5_head(.d(next_head),.reset_n(reset_n),.clk(clk),.q(head));
	dff4_r U6_tail(.d(next_tail),.reset_n(reset_n),.clk(clk),.q(tail));
	
	// Register File
	Register_File16 U7_RF(.clk(clk), .reset_n(reset_n), .wAddr(tail), .wData(din), 
	.we(we), .re(re), .rAddr(head), .rData(dout));	
endmodule


// Next state logic
module fifo16_ns(wr_en,rd_en,state,data_count,next_state);
	input wr_en, rd_en;
	input [2:0] state;
	input [4:0] data_count;
	output reg [2:0] next_state;
	
	// State encoding
	parameter IDLE=3'b000;
	parameter WRITE=3'b001;
	parameter READ=3'b010;
	parameter WR_ERROR=3'b011;
	parameter RD_ERROR=3'b100;
	
	always @*
		begin
		if(wr_en == 0 && rd_en == 0)
			next_state = IDLE;
		else if(wr_en == 1 && rd_en == 0 && data_count != 16)
			next_state = WRITE;
		else if(wr_en == 1 && rd_en == 0 && data_count == 16)
			next_state = WR_ERROR;
		else if(wr_en == 0 && rd_en == 1 && data_count != 16)
			next_state = READ;
		else if(wr_en == 0 && rd_en == 1 && data_count == 16)
			next_state = RD_ERROR;
		else
			next_state = state;
		end
endmodule


// Calculate address logic
module fifo16_cal(next_state, data_count, head, tail, next_data_count, next_head, 
next_tail, we, re);
	input [2:0] next_state;
	input [3:0] head, tail;
	input [4:0] data_count;
	output reg re, we;
	output reg [4:0] next_data_count;
	output reg [3:0] next_head, next_tail;
	
	// State encoding
	parameter IDLE=3'b000;
	parameter WRITE=3'b001;
	parameter READ=3'b010;
	parameter WR_ERROR=3'b011;
	parameter RD_ERROR=3'b100;
	
	always @*
		begin
		if(next_state == WRITE)
			begin
			re = 0; we = 1;
			next_data_count = data_count + 5'b00001;
			if(tail == 4'b1111) next_tail = 4'b0000;
			else next_tail = tail + 4'b0001;
			next_head = head;
			end
		else if(next_state == READ)
			begin
			re = 1; we = 0;
			next_data_count = data_count - 5'b00001;
			if(head == 4'b1111) next_head =4'b0000;
			else next_head = head + 4'b0001;
			next_tail = tail;
			end
		else
			begin
			re = 0; we = 0;
			next_data_count = data_count;
			next_head = head;
			next_tail = tail;
			end
		end
endmodule

// output logic
module fifo16_out(state, rd_ack, wr_err, rd_err);
	input[2:0] state;										
	output reg rd_ack;				// determine by state
	output reg wr_err, rd_err;					

	parameter INIT 		= 3'b000;
	parameter NO_OP 	= 3'b001;
	parameter WRITE 	= 3'b010;
	parameter WR_ERROR 	= 3'b011;
	parameter READ 		= 3'b100;
	parameter RD_ERROR 	= 3'b101;


	always@(state)	begin
		case(state)
			INIT		: begin
				rd_ack = 0;
				wr_err = 0;
				rd_err = 0;
			end
			NO_OP		: begin
				rd_ack = 0;
				wr_err = 0;
				rd_err = 0;
			end
			WRITE		: begin
				rd_ack = 0;
				wr_err = 0;
				rd_err = 0;
			end
			WR_ERROR	: begin
				rd_ack = 0;
				wr_err = 1;
				rd_err = 0;
			end
			READ		: begin
				rd_ack = 1;
				wr_err = 0;
				rd_err = 0;
			end
			RD_ERROR	: begin
				rd_ack = 0;
				wr_err = 0;
				rd_err = 1;
			end
			default	: begin
				rd_ack = 0;
				wr_err = 0;
				rd_err = 0;
			end
		endcase
	end
endmodule

// Register File. 16 32bit data can be stored
module Register_File16(clk, reset_n, wAddr, wData, we, re, rAddr, rData);
   
   input clk, reset_n, we, re;
   input [3:0] wAddr, rAddr; 
   input [31:0] wData;
   output reg [31:0] rData;
   
   reg [31:0] mem [0:15];
   
   integer i;
   
   // Initialize memory
   initial begin
      for(i=0; i<16; i=i+1) begin
         mem[i] = 32'b0;
      end
   end
   
	// Read and Write operation
   always @ (posedge clk) begin
      if(reset_n == 0) begin
         mem[0] = 32'b0; mem[1] = 32'b0; mem[2] = 32'b0;   mem[3] = 32'b0;
         mem[4] = 32'b0; mem[5] = 32'b0; mem[6] = 32'b0;   mem[7] = 32'b0;
         mem[8] = 32'b0; mem[9] = 32'b0; mem[10] = 32'b0;   mem[11] = 32'b0;
         mem[12] = 32'b0; mem[13] = 32'b0; mem[14] = 32'b0;   mem[15] = 32'b0;
      end
      else if(re == 1'b1) 		    //READ
         rData = mem[rAddr];
      else if(we == 1'b1) begin 	 //WRITE
         mem[wAddr] = wData;
         rData = 32'b0;
      end
      else 
         rData = 32'b0;
   end
endmodule
	
	
	
	
	
	



