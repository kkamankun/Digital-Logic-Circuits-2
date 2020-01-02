// Random Access Memory(RAM)
module ram(clk, cen, wen, addr, din, dout);
	input clk;
	input cen, wen;
	input [4:0] addr;
	input [31:0] din;
	output reg [31:0] dout;
	
	reg [31:0] mem [0:31];
	
	integer i;
	
	// memory initialization
	initial begin
		for(i=0; i<32; i=i+1) begin
			mem[i] = 0;
		end
	end
	
	always@(posedge clk)
	begin
	if(cen == 0)
		dout = 0;
	else if(cen == 1 && wen == 1) begin
		dout = 0;
		mem[addr] = din;
		end
	else if(cen == 1 && wen == 0)
		dout = mem[addr];
	end
endmodule

	