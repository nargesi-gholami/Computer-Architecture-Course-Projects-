`timescale 1ps/1ps
module mult_xor(input [6:0] in, input sel, output reg [6:0] out);
	integer i;
	always@(sel) begin
		for(i = 0; i < 7; i = i + 1) begin
			out[i] <= in[i]^sel;
		end
	end
endmodule