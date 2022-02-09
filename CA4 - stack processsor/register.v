`timescale 1ps/1ps
module register#(parameter size = 8)(input clk,rst,ld, input [size - 1:0] r_in, output reg [size-1:0] r_out);

	always@(posedge clk, posedge rst)begin
		if(rst == 1'b1)
			r_out <= 0;
		else
			if(ld == 1'b1)
				r_out <= r_in;
	end
 endmodule
