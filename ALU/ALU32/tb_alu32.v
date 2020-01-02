// Self-checking testbench with testvectors for 32-bits ALU
`timescale 1ns/100ps 

module tb_alu32;
	
	reg tb_clk, tb_reset; 
	reg [31:0] vectornum, errors; // bookkeeping variables 
	reg [103:0] testvectors[100:0]; // array of testvectors
	reg [31:0] exp_result; // expected outputs
	reg exp_c, exp_n, exp_z, exp_v; // expected outputs
	
	
	reg [31:0] tb_a, tb_b; 
	reg [2:0] tb_op; 
	reg dummy; 
	wire [31:0] tb_result; 
	wire tb_c, tb_n, tb_z, tb_v; 
	
	// instantiate device under test
	alu32 U0_alu32(.a(tb_a), .b(tb_b), .op(tb_op), .result(tb_result), .c(tb_c), .n(tb_n), .z(tb_z), .v(tb_v)); 
	
	// generate clock
	always	// no sensitivity list, so it always executes
	begin
		tb_clk = 1; #5; tb_clk = 0; #5; 
	end
	// at start of test, load vectors and pulse reset

	initial
		begin
			$readmemh("./../../example.tv",testvectors); 
			vectornum=0; errors=0; tb_reset=1; #4; tb_reset=0;
		end
	
	// Note: $readmemh reads testvector files written in hexadecimal
	// apply test vectors on rising edge of clk
	always @ (posedge tb_clk) 
		begin
			#1; {tb_a, tb_b, dummy, tb_op, exp_result, exp_c, exp_n, exp_z, exp_v} = testvectors[vectornum]; //data is stored 
		end
	
	// check results on falling edge of clk
	always @ (negedge tb_clk) 
		if(~tb_reset) 
			begin 
				if(tb_result !== exp_result || tb_c !== exp_c || tb_n !== exp_n || tb_z !== exp_z || tb_v !== exp_v) 
					begin 
						$display("Error: inputs = a: %h, b: %h, op: %b",tb_a, tb_b, tb_op);
						$display("outputs = result: %h, c: %b, n: %b, z: %b, v: %b (%h %b %b %b %b expected)", tb_result, tb_c, tb_n, tb_z, tb_v, exp_result, exp_c, exp_n, exp_z, exp_v);
						errors = errors + 1; 
					end
	// Note: to print in hexadecimal, use %h
	// increment array index and read next testvector
				vectornum = vectornum + 1; 
			if(testvectors[vectornum] === 104'hx) 
				begin 
					$display("%d tests completed with %d errors", vectornum, errors); 
					$finish;
				end
		end
	
	
endmodule
