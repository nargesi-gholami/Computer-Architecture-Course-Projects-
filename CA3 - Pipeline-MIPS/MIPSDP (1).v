`timescale 1ps/1ps
module MIPSDP(input clk, rst, input[1:0] pcsrc,input rdst1, rdst2, rdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc,ld, input [1:0] A_src, B_src, input [2:0] aluop, 
		output zero,branch_out, regw_out2, regw_out3, output [5:0] func,opcode, opcode_out, output [4:0] Rt, Rs, Rd, wregin_out, wregin_out2);

wire [31:0] pcout, inst, seout, next_add, muxout1, muxout2, pcin, rdata1, rdata2, rdata3, aluout, muxout7, wdata, aluin, rdata1_out,
		rdata2_out, seout_out, NA_out2, JAL_out, aluout_out, moB_out, NA_out3,  rdata3_out, aluout_out2, NA_out4,
		inst_out, NA_out, moA, moB, NA_out1;
wire [4:0] muxout4, muxout5, wregin;
wire  memr_out, memw_out, mtr_out, rfsrc_out, regw_out, rdst1_out, rdst2_out, rdst3_out, alusrc_out,
	memr_out2, memw_out2, mtr_out2, rfsrc_out2, 
	zero_out,
	mtr_out3, rfsrc_out3; 
wire [2:0] aluop_out;
wire [1:0] pcsrc_out;


assign opcode = inst_out[31:26];

//reading instructions
//ID/EX registers:
//Memory control signal registers
register #2 reg1(clk, rst, 1'b1, pcsrc, pcsrc_out);
register #1 reg4(clk, rst, 1'b1, memread, memr_out);
register #1 reg5(clk, rst, 1'b1, memwrite, memw_out);
//Write back control signal registers
register #1 reg6(clk, rst, 1'b1, memtoreg, mtr_out);
register #1 reg7(clk, rst, 1'b1, rfsrc, rfsrc_out);
register #1 reg8(clk, rst, 1'b1, regwrite, regw_out);
//Execution control signal registers
register #1 reg9(clk, rst, 1'b1, rdst1, rdst1_out);
register #1 reg10(clk, rst, 1'b1, rdst2, rdst2_out);
register #1 reg11(clk, rst, 1'b1, rdst3, rdst3_out);
register #3 reg12(clk, rst, 1'b1, aluop, aluop_out);
register #1 reg13(clk, rst, 1'b1, alusrc, alusrc_out);
//Data registers
register #32 reg14(clk, rst, 1'b1, rdata1, rdata1_out);
register #32 reg15(clk, rst, 1'b1, rdata2, rdata2_out);
register #32 reg16(clk, rst, 1'b1, seout, seout_out);
register #32 reg40(clk, rst, 1'b1, NA_out, NA_out2);
register #32 reg43(clk, rst, 1'b1, {NA_out[31:28],inst_out[25:0],2'b00}, JAL_out);
register #5 reg17(clk, rst, 1'b1, inst_out[25:21], Rs);
register #5 reg18(clk, rst, 1'b1, inst_out[20:16], Rt);
register #5 reg19(clk, rst, 1'b1, inst_out[15:11], Rd);
register #6 reg60(clk, rst, 1'b1, inst_out[31:26], opcode_out);
//EO ID/EX registers

//EX/MEM registers
//Memory control signal registers
register #1 reg23(clk, rst, 1'b1, memr_out, memr_out2);
register #1 reg24(clk, rst, 1'b1, memw_out, memw_out2);
//Write back control signal registers
register #1 reg25(clk, rst, 1'b1, mtr_out, mtr_out2);
register #1 reg26(clk, rst, 1'b1, rfsrc_out, rfsrc_out2);
register #1 reg27(clk, rst, 1'b1, regw_out, regw_out2);
//Data registers
register #5 reg28(clk, rst, 1'b1, wregin, wregin_out);
register #1 reg29(clk, rst, 1'b1, zero, zero_out);
register #32 reg30(clk, rst, 1'b1, aluout, aluout_out);
register #32 reg31(clk, rst, 1'b1, moB, moB_out);
register #32 reg41(clk, rst, 1'b1, NA_out2, NA_out3);
//
register #1 reg49(clk, rst, 1'b1, branch, branch_out);
//EO EX/MEM registers    

//MEM/WB registers
//Write back control signal registers
register #1 reg32(clk, rst, 1'b1, mtr_out2, mtr_out3);
register #1 reg33(clk, rst, 1'b1, rfsrc_out2, rfsrc_out3);
register #1 reg34(clk, rst, 1'b1, regw_out2, regw_out3);
//Data registers
register #5 reg35(clk, rst, 1'b1, wregin_out, wregin_out2);
register #32 reg36(clk, rst, 1'b1, rdata3, rdata3_out);
register #32 reg37(clk, rst, 1'b1, aluout_out, aluout_out2);
register #32 reg42(clk, rst, 1'b1, NA_out3, NA_out4);
//EO MEM/WB registers

//IF/ID registers
register #32 reg38(clk, rst, 1'b1, inst, inst_out);
register #32 reg39(clk, rst, 1'b1, next_add, NA_out);
//EO IF/ID registers

assign func = inst_out[5:0];
signExtend se(inst_out[15:0], seout);
assign next_add = pcout + 4;
multiplexer4 mux_addr(next_add, JAL_out, rdata1_out ,NA_out2+{seout_out[29:0],2'b00}, pcsrc, pcin);
programCounter pc(clk, rst, 1'b1, pcin, pcout);
instMem im(pcout, inst);

//RegisterFile
multiplexer #5 mux4(Rt, Rd, rdst1_out, muxout4);
multiplexer #5 mux5(muxout4, 5'd29, rdst2_out, muxout5);
multiplexer #5 mux6(muxout5, 5'd31, rdst3_out, wregin);
//avaz
multiplexer mux7(rdata3_out, aluout_out2, mtr_out3, muxout7);
multiplexer mux8(NA_out4, muxout7, rfsrc_out3, wdata);
regfile rf(clk, inst_out[25:21], inst_out[20:16], wregin_out2, regw_out3, wdata, rdata1, rdata2);

//alu
multiplexer mux9(moB, seout_out, alusrc_out, aluin);
multiplexer3 #32 mux31(rdata1_out, aluout_out, wdata, A_src, moA);
multiplexer3 #32 mux32(rdata2_out, aluout_out, wdata, B_src, moB);
ALU alu(moA, aluin, aluop_out, zero, aluout);

//DataMemory
data_memory dm(aluout_out, moB_out, memr_out2, memw_out2, rdata3);

endmodule






