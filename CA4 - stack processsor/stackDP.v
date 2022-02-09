`timescale 1ns/ 1ns
module stack_MIPS_DP(input clk, rst, pcwrite, IorD, memwrite, memread, IRwrite,memTostack, push, tos, pop,
			Awrite, ALUsrcA, pcsrc, J, r_or_not, input[1:0] ALUsrcB, input [1:0] aluop, output zero, output [2:0]opcode);
wire[7:0] mem_out, data_out, A,A_r_out, A_out, B, result, aluout2, d_in, d_out;
wire[4:0] pc_out, mem_addr, addr_out, pc_in, pc_in2;

assign opcode = mem_out[7:5];

//program counter //pc_in -> pc_out / pcwrite
programCounter pc(clk, rst, pcwrite, pc_in , pc_out);

multiplexer#5 IORD(pc_out , addr_out , IorD , mem_addr);// when s == 1 out <= in2
data_memory data_mem(mem_addr, d_out, memread, memwrite, mem_out);

register#5 IR(clk, rst, IRwrite, mem_out[4:0], addr_out);
register MDR(clk, rst, 1'b1, mem_out, data_out);
multiplexer mem_to_stack(data_out, aluout2, memTostack, d_in);

stack st(clk, d_in, push, tos, pop, d_out);
register A_reg(clk, rst, Awrite, d_out, A_r_out);
multiplexer RORNOT(A_r_out, d_out, r_or_not,  A_out);

multiplexer ALU_src_A({3'b0,mem_addr} , A_out ,  ALUsrcA , A );
multiplexer3 ALU_src_B(d_out , 8'b00000100 ,8'b0,  ALUsrcB , B );

ALU alu(A, B, aluop, zero, result);
register ALU_out(clk, rst, 1'b1, result, aluout2);

multiplexer#5 pc_src(addr_out , result[4:0] ,  pcsrc , pc_in2);
multiplexer#5 Jumpp(pc_in2 , addr_out ,  J , pc_in );

endmodule
