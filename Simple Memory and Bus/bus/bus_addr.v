// bus address decoder
module bus_addr(s_addr, s0_sel, s1_sel);
	input[7:0] s_addr;
	output reg s0_sel, s1_sel;

	always@(s_addr)
	begin	
	if(s_addr[7:5] == 3'b000)
		{s0_sel, s1_sel} = 2'b10;					// Slave0
	else if(s_addr[7:5] == 3'b001)
		{s0_sel, s1_sel} = 2'b01;					// Slave1
	else
		{s0_sel, s1_sel} = 2'b00;					// non
	end
endmodule
	