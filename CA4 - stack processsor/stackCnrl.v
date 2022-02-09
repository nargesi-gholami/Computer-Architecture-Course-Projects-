`timescale 1ps/1ps
module MIPSCntlr(input[2:0] op, input clk, rst, zero, start, output reg pcwrite, IorD, memwrite,
			 memread, IRwrite,memTostack, push, tos, pop,Awrite, ALUsrcA, pcsrc, J, r_or_not,
			 output reg[1:0] ALUsrcB, output reg [1:0] aluop);

parameter[3:0] IF = 4'b0000, ID = 4'b0001, JMP = 4'b0011, JZ = 4'b0100 ,POP = 4'b0101,
	 PUSH = 4'b0110, Rtype = 4'b0111, POP2 = 4'b1000, PUSH2 = 4'b1001, ADD = 4'b1010,
		SUB = 4'b1011, AND =  4'b1100, PTOstack = 4'b1101, Rtype2 = 4'b1110;

reg[3:0] ps, ns;
reg jump;

assign J = zero & jump;

always@(ps, op, start)begin
	ns = IF;
	case(ps) 
	(IF):   ns = ID;
	(ID):   ns = (op[2] == 0)   ? Rtype :
		      (op == 3'b100) ? PUSH:
		      (op == 3'b101) ? POP :
		      (op == 3'b110) ? JMP :
		      (op == 3'b111) ? JZ  : 4'b0000; 

	(JMP)  : ns = IF;
	(JZ)   : ns = IF;
	(POP)  : ns = POP2;
	(POP2) : ns = IF;
	(PUSH) : ns = PUSH2;
	(PUSH2): ns = IF;
	(Rtype): ns = Rtype2;
	(Rtype2): ns = (op == 3'b000) ? ADD : 
		       (op == 3'b001) ? SUB :
		       (op == 3'b010) ? AND :
		       (op == 3'b011) ? PTOstack : IF;//NOT
	(ADD)  : ns = PTOstack; 
	(SUB)  : ns = PTOstack; 
	(AND)  : ns = PTOstack; 
	(PTOstack) : ns = IF;
	default : ns = IF;
	endcase
end

always @(ps, op, start)  begin  
	{pcwrite, IorD, memwrite, memread, IRwrite,
	 memTostack, push, tos, pop, Awrite, ALUsrcA, pcsrc, J, jump} = 0;
	
	case(ps) 
		IF: 
		begin // instruction fetch
			pcwrite = 1'b1;
			IorD = 1'b0;
			IRwrite = 1'b1;
			r_or_not = 1'b0;//new
			ALUsrcA = 1'b0;
			ALUsrcB = 2'b01;
			aluop = 2'b00;
			pcsrc = 1'b1;
			jump = 1'b0;
			memread = 1'b1;//new
		end
//////////////////////////////////////////////
		ID:
		begin //instruction decode
			//memread <= 1'b1;//new
			//Awrite = 1'b1;
			ALUsrcB = 2'b10;
			ALUsrcA = 1'b1;
			tos = 1'b1;//new
		end
//////////////////////////////////////////////
		JMP:
		begin //jump
			pcsrc = 1'b0;
			jump = 1'b0;
			
		end
//////////////////////////////////////////////
		JZ: 
		begin //jump
			jump = 1'b1;
			aluop = 2'b01;
		end
//////////////////////////////////////////////
		POP: 
		begin // pop
			pop = 1'b1;
		end
//////////////////////////////////////////////
		POP2: 
		begin
			IorD = 1'b1;
			memwrite = 1'b1;
		end
/////////////////////////////////////////////
		PUSH: 
		begin // push
			IorD = 1'b1;
			memread = 1'b1;
		end
//////////////////////////////////////////////
		PUSH2: 
		begin
			memTostack = 1'b0;
			push = 1'b1;
		end
//////////////////////////////////////////////
		ADD: 
		begin //Add
			ALUsrcB = 2'b00;
			ALUsrcA = 1'b1;
			aluop = 2'b00;
		end
//////////////////////////////////////////////
		SUB: 
		begin //sub
			ALUsrcB = 2'b00;
			ALUsrcA = 1'b1;
			aluop = 2'b01;
		end
//////////////////////////////////////////////
		AND: 
		begin //and
			ALUsrcB = 2'b00;
			ALUsrcA = 1'b1;
			aluop = 2'b11;
		end
//////////////////////////////////////////////
		Rtype: 
		begin // rtype and not
			pop = 1'b1;
			ALUsrcB = 2'b00;
			ALUsrcA = 1'b1;
			aluop = 2'b10;
			Awrite = 1'b1;			
		end
//////////////////////////////////////////////
		Rtype2:
			pop = 1'b1;
//////////////////////////////////////////////
		PTOstack: 
		begin //end rtype
			memTostack = 1'b1;
			push = 1'b1;
		end
//////////////////////////////////////////////
	endcase
end

always@(posedge clk, posedge rst)begin
	if(rst)
		ps <= IF;
	else
		ps <= ns;
end

endmodule



