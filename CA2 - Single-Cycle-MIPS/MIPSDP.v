`timescale 1ps/1ps
module MIPSDP(input clk, rst, pcsrc1, pcsrc2, pcsrc3, rdst1, rdst2, rdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc,ld, input [2:0] aluop, output zero, output [5:0] func,opcode);

wire [31:0] pcout, inst, seout, muxin1, muxout1, muxout2, pcin, rdata1, rdata2, rdata3, aluout, muxout7, wdata, aluin;
wire [4:0] muxout4, muxout5, wregin;

assign opcode = inst[31:26];
//reading instructions
assign func = inst[5:0];
signExtend se(inst[15:0], seout);
assign muxin1 = pcout + 4;
multiplexer mux1(muxin1, muxin1+{seout[29:0],2'b00}, pcsrc1, muxout1);
multiplexer mux2({muxin1[31:28],inst[25:0],2'b00}, muxout1, pcsrc2, muxout2);
multiplexer mux3(rdata1, muxout2, pcsrc3, pcin);
programCounter pc(clk, rst, ld, pcin, pcout);
instMem im(pcout, inst);

//RegisterFile
multiplexer #5 mux4(inst[20:16], inst[15:11], rdst1, muxout4);
multiplexer #5 mux5(muxout4, 5'd29, rdst2, muxout5);
multiplexer #5 mux6(muxout5, 5'd31, rdst3, wregin);
multiplexer mux7(rdata3, aluout, memtoreg, muxout7);
multiplexer mux8(muxin1, muxout7, rfsrc, wdata);
regfile rf(clk, inst[25:21], inst[20:16], wregin, regwrite, wdata, rdata1, rdata2);

//alu
multiplexer mux9(rdata2, seout, alusrc, aluin);
ALU alu(rdata1, aluin, aluop, zero, aluout);

//DataMemory
data_memory dm(aluout, rdata2, memread, memwrite, rdata3);

endmodule






