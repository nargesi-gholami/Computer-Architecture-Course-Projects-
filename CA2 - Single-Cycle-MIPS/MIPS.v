`timescale 1ps/1ps
module MIPS(input clk, rst);

wire [5:0] opcode, func; 
wire pcsrc1, pcsrc2, pcsrc3, rgdst1, rgdst2, rgdst3, regwrite, alusrc, memread, memwrite, memtoreg, branch, rfsrc, zero;
wire [1:0] aluop;
wire [2:0] alu_cntlr;


MIPS_Control mc(opcode, clk, rst, zero, pcsrc1, pcsrc2, rgdst1, rgdst2, rgdst3, regwrite, alusrc,ld,
		 memread, memwrite, memtoreg, branch, rfsrc, aluop);

ALUControl aluc(aluop, func, alu_cntlr);

JR_Control jrc(aluop, func, pcsrc3);

MIPSDP mdp(clk, rst, pcsrc1, pcsrc2, pcsrc3, rgdst1, rgdst2, rgdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc,ld, alu_cntlr, zero, func,opcode);

endmodule
