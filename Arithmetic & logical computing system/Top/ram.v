// Random Access Memory(RAM)
module ram(clk, cen, wen, addr, din, dout);
	input clk;
	input cen, wen;
	input [15:0] addr;
	input [31:0] din;
	output reg [31:0] dout;
	
	reg [31:0] mem [0:63];
	
	integer i;
	
	// memory initialization
	initial begin
		for(i=0; i<64; i=i+1) begin
			mem[i] = 32'b0;
		end
	end
	
	always@(posedge clk)
	begin
	if(cen == 1 && wen == 1) begin	// Write
		dout = 0;
		mem[addr[5:0]] = din;
	end
	else if(cen == 1)		// Read
		dout = mem[addr[5:0]];
	else 
		dout = 32'b0;
	end
endmodule
