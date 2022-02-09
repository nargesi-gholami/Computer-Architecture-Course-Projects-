`timescale 1ps/1ps
module MIPSC_TB();

reg clk, rst;


MIPS MTB(clk, rst);

initial begin
	clk = 1'b0;
	rst = 1'b0;
	repeat(2000)
  	#25 clk = ~clk;
end

endmodule
