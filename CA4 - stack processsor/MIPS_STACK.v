`timescale 1ps/1ps
module MIPS_STACK(input clk, start, rst);


wire [1:0] aluop, ALUsrcB;
wire [2:0] opcode;
wire  zero, pcwrite, IorD, memwrite, memread, IRwrite,memTostack, push, tos, pop,
			Awrite, ALUsrcA, pcsrc, J, r_or_not;

stack_MIPS_DP mdp(clk, rst, pcwrite, IorD, memwrite, memread, IRwrite, memTostack, push, tos, pop,
			Awrite, ALUsrcA, pcsrc, J, r_or_not, ALUsrcB, aluop, zero, opcode);

MIPSCntlr mcr(opcode, clk, rst, zero, start, pcwrite, IorD, memwrite,
			 memread, IRwrite, memTostack, push, tos, pop, Awrite, ALUsrcA, pcsrc, J, r_or_not,
			  ALUsrcB, aluop);

endmodule
