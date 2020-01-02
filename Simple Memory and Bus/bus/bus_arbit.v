// bus arbiter
module bus_arbit(clk, reset_n, m0_req, m1_req, m0_grant, m1_grant);
	input clk, reset_n, m0_req, m1_req;
	output reg m0_grant, m1_grant;

always@(posedge clk)
	begin
	if(reset_n == 0) begin		// M0_grant
		m0_grant = 1;
		m1_grant = 0;
		end
	else if((m0_req == 0 && m1_req == 0) || m0_req == 1) begin // M0_grant
		m0_grant = 1;
		m1_grant = 0;
		end
	else if(m0_req == 0 && m1_req == 1) begin // M1_grant
		m0_grant = 0;
		m1_grant = 1;
		end
	else if(m1_req == 1) begin // M1_grant
		m0_grant = 0;
		m1_grant = 1;
		end
	else if(m1_req == 0) begin // M0_grant
		m0_grant = 1;
		m1_grant = 0;
		end
	else begin
		m0_grant = 1;
		m1_grant = 0;
		end
	end
endmodule
