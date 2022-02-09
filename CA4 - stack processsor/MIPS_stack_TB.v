`timescale 1ps/ 1ps
module MIPS_STACK_TB();

reg clk, start, rst;

MIPS_STACK MS(clk,start, rst);


initial begin
	clk = 1'b0;
	rst = 1'b0;
	start = 1'b0;
	repeat(200)
	#25 clk = ~clk;
  	
end


endmodule

