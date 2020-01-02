module _dff(clk, reset_n, d, q); // Synchronous resettable D F/F
	input  d;
	input clk,reset_n;
	output reg q;
	
	always @(posedge clk)
		begin
		if(reset_n == 0)
			q = 0;
		else
			q = d;
		end
endmodule

module dff8_r(d,reset_n,clk, q);// 8bit synchronous resettable D F/F 
	input [7:0] d;
	input reset_n, clk;
	output reg [7:0] q;
	
	always @(posedge clk)
		begin
		if(reset_n == 0) q = 0;
		else q <= d;
		end

endmodule

module _dff_r_en(clk, reset_n, en , d, q); // Asynchornous resettable enable D F/F
	input clk,reset_n, en,d;
	output reg q;
	
	always@(posedge clk or negedge reset_n) 
	begin
			if(reset_n == 0)	q<=1'b0;
			else if(en)		q<=d;
			else				q<=q;
	end
endmodule

module dff32_r_en_c(d,reset_n,clk,en,op_clear,q);//32bit asynchronous resettable D F/F with op_clear
	input [31:0]d;
	input reset_n, clk,op_clear,en;
	output reg [31:0]q;
	
	always @(posedge clk or negedge reset_n or posedge op_clear)
		begin
		if(reset_n == 0 || op_clear == 1) q = 0;
		else if(en != 1)
			q<=q;
		else q <= d;
		end
endmodule

module dff32_r_en(clk, reset_n, en, d, q);//32bit asynchronous resettable D F/F
	input reset_n, clk, en;
	input [31:0] d;
	output reg [31:0] q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 0) q = 0;
		else if(en != 1)
			q<=q;
		else q <= d;
		end
endmodule

module dff9_r(d,reset_n,clk, q);// 9bit asynchronous resettable D F/F 
	input [8:0] d;
	input reset_n, clk;
	output reg [8:0] q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 0) q = 0;
		else q <= d;
		end

endmodule

module dff32_r_en_c2(d,reset_n,clk,en,op_clear,q); // 32bit asynchornous resettable with D F/F with op_clear
	input [31:0]d;
	input reset_n, clk,op_clear,en;
	output reg [31:0]q;
	
	always @(posedge clk or negedge reset_n or posedge op_clear)
		begin
		if(reset_n == 1'b0 || op_clear == 1'b1) q = 32'h0000;
		else if(en != 1'b1)
			q<=32'h0000;
		else q = d;
		end

endmodule

module dff32_r_en_c3(d,reset_n,clk,en,op_clear,q); // 32bit asynchornous resettable with D F/F with op_clear
	input [31:0]d;
	input reset_n, clk,op_clear,en;
	output reg [31:0]q;
	
	always @(negedge clk or negedge reset_n or posedge op_clear)  // negedge 
		begin
		if(reset_n == 1'b0 || op_clear == 1'b1) q = 32'h0000;
		else if(en != 1'b1)
			q<=32'h0000;
		else q = d;
		end

endmodule

module dff32_r_c(d,reset_n,clk,op_clear,q);// 32bit asynchronous resettable D F/F with op_clear
	input [31:0]d;
	input reset_n, clk,op_clear;
	output reg [31:0]q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 1'b0) q = 32'h0000;
		else if(op_clear == 1'b1) q=32'h0000;
		else q = d;
		end

endmodule

module dff32_r(d,reset_n,clk,q);// 32bit synchronous resettable D F/F
	input [31:0]d;
	input reset_n, clk;
	output reg [31:0]q;
	
	always @(posedge clk)
		begin
		if(reset_n == 1'b0) q = 32'h0000;
		else q = d;
		end

endmodule


module dff5_r(d,reset_n,clk,q);// 5bit asynchronous resettable D F/F
	input [4:0]d;
	input reset_n, clk;
	output reg [4:0]q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 1'b0)
			q = 5'b0000;
		else 
			q = d;
		end

endmodule

module dff4_r(d,reset_n,clk,q);// 4bit synchronous resettable D F/F
	input [3:0]d;
	input reset_n, clk;
	output reg [3:0]q;
	
	always @(posedge clk)
		begin
		if(reset_n == 0)
			q = 0;
		else 
			q = d;
		end

endmodule

module dff3_r(d,reset_n,clk,q);//3bit asynchronous resettable D F/F
	input [2:0]d;
	input reset_n, clk;
	output reg [2:0]q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 1'b0)
			q = 3'b000;
		else
			q = d;
		end

endmodule

module dff2_r(d,q,clk,reset_n);// 2bit asynchronous resettable D F/F
	input  [1:0]d;
	input clk,reset_n;
	output reg [1:0]q;
	
	always @(posedge clk or negedge reset_n)
		begin
		if(reset_n == 1'b0)
			q = 2'b0;
		else
			q = d;
		end
endmodule

module dff_r_5(d,q,clk,reset_n);// 5bit synchronous resettable D F/F
	input [4:0] d;
	input clk,reset_n;
	output reg [4:0]q;
	
	always @(posedge clk)
		begin
		if(reset_n == 1'b0)
			q = 5'b0;
		else
			q = d;
		end
endmodule
