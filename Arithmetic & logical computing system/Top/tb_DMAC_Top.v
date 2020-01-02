// Testbench of DMAC_Top
module tb_DMAC_Top;
	reg clk, reset_n;
	reg m_grant;
	reg [31:0] m_din, s_din;
	reg s_sel, s_wr;
	reg [15:0] s_addr;

	wire  m_req, m_wr;
	wire [15:0] m_addr;
	wire [31:0] m_dout, s_dout;
	wire s_interrupt;
	
	DMAC_Top U0_DMAC_Top(clk, reset_n, m_grant, m_din, s_sel, s_wr, s_addr, s_din, m_req, m_wr, m_addr, m_dout, s_dout, s_interrupt);
	
	always #5 clk = ~clk;
	
	initial
	begin
	#0; clk = 0; reset_n = 0; m_grant = 0; m_din = 32'h0; s_din = 32'h0; s_sel = 1; s_wr = 1; s_addr = 16'hFFFF;
	#7; reset_n = 1; m_grant = 0; m_din = 32'h0;
	
	// DMAC REQ initialization
	#10;   s_addr = 16'h0002; s_din = 32'h0000_0001;   //interrupt driven method
   #10;   s_addr = 16'h0003; s_din = 32'h0000_0300; 	//src    :RAM #2 INST
   #10;   s_addr = 16'h0004; s_din = 32'h0000_0103;   //dest   :ALU INST FIFO
   #10;   s_addr = 16'h0005; s_din = 32'h0000_0008;   //size   :8
   #10;   s_addr = 16'h0006; s_din = 32'h0000_0001;   //push descriptor
   #10;   s_addr = 16'h0007; s_din = 32'h0000_0001;   //opmode :linear, fixed
		
	//////////// DMAC OPERATION START //////////////
   #10; s_addr = 16'h0000; s_din = 32'h0000_0001;	// opstart = 1
	#40; m_grant = 1;
   #300; $stop;
   end
endmodule
