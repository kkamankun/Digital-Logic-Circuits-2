`timescale 1ns/100ps

module tb_Register_file;
reg tb_clk, tb_reset_n, tb_we;
reg[2:0] tb_wAddr, tb_rAddr;
reg[31:0] tb_wData;
wire[31:0] tb_rData;
parameter STEP = 10;

Register_file U0_Register_file(.clk(tb_clk), .reset_n(tb_reset_n), .we(tb_we),
.wAddr(tb_wAddr), .rAddr(tb_rAddr), .wData(tb_wData), .rData(tb_rData));


// clock period = 10ns
always#(STEP/2) tb_clk = ~tb_clk;
initial
begin
tb_clk=0;tb_reset_n=0; tb_we=0; tb_wAddr=0; tb_rAddr=0; tb_wData=0;
#7; tb_reset_n=1; tb_we=1; tb_wData=32'h11111111;
#10; tb_wAddr=3'b001; tb_wData=32'hff00ff00;
#10; tb_wAddr=3'b010;
#10; tb_wAddr=3'b011; tb_wData=32'h00ff00ff;
#10; tb_we=0;
#10; tb_rAddr=3'b001;
#10; tb_rAddr=3'b010;
#10; tb_rAddr=3'b011;
#20; $stop;
end
endmodule
