`timescale 1ps/1ps
module MIPS(input clk, rst);

wire [5:0] opcode, func, opcode_out;
wire [4:0] Rt, Rs, wregin_out, wregin_out2, Rd; 
wire  rgdst1, rgdst2, rgdst3, regwrite, alusrc, memread, memwrite, memtoreg, branch, rfsrc, zero, regw_out2, regw_out3,branch_out;
wire [1:0] aluop, A_src, B_src, pcsrc;
wire [2:0] alu_cntlr;

frwdUnit fu(Rt, Rs, wregin_out, wregin_out2, regw_out2, regw_out3, A_src, B_src);

MIPS_Control mc(opcode, opcode_out, zero, branch_out,rgdst1, rgdst2, rgdst3, regwrite, alusrc,ld,
		 memread, memwrite, memtoreg, branch, rfsrc, aluop, pcsrc);

ALUControl aluc(aluop, func, alu_cntlr);

MIPSDP mdp(clk, rst, pcsrc, rgdst1, rgdst2, rgdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc,ld, A_src, B_src, alu_cntlr, zero,branch_out, regw_out2
		, regw_out3, func,opcode,opcode_out, Rt, Rs, Rd, wregin_out, wregin_out2);

endmodule
