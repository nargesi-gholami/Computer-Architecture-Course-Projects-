`timescale 1ps/1ps
module MIPS_Control(input[5:0] opcode, input clk, rst, zero, output reg pcsrc1, pcsrc2 ,rgdst1, rgdst2, rgdst3, regwrite, alusrc
		,ld, memread, memwrite, memtoreg, branch, rfsrc, output reg [1:0] aluop);

assign pcsrc1 = (opcode == 6'b100000) ? (zero & branch) : (!zero & branch);
always @(*)  begin  
      {pcsrc1, pcsrc2, rgdst1, rgdst2, rgdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc, aluop} <= 0;
	ld = 1'b1;
      case(opcode)
		6'b000000: begin //rtype
			pcsrc2 <= 1'b1;
			rgdst1 <= 1'b1;
			rgdst2 <= 1'b0;
			rgdst3 <= 1'b0;
			alusrc <= 1'b0;
			memtoreg <= 1'b1;
			regwrite <= 1'b1;
			rfsrc <= 1'b1;
			aluop <= 2'b00;
		end
		6'b010000: begin //jump
			pcsrc2 <= 1'b0;
		end
		6'b011000: begin //jump and link
			pcsrc2 <= 1'b0;
			rgdst3 <= 1'b1;
			regwrite <= 1'b1;
			rfsrc <= 1'b0;
			aluop <= 2'b10;
		end
		6'b100000: begin //branch equal
			branch <= 1'b1;
			pcsrc2 <= 1'b1;
			alusrc <= 1'b0;
			aluop <= 2'b10;
		end
		6'b101000: begin //branch not equal
			branch <= 1'b1;
			pcsrc2 <= 1'b1;
			alusrc <= 1'b0;
			aluop <= 2'b10;
		end
		6'b000001: begin //add immediate
			pcsrc2 <= 1'b1;
			regwrite <= 1'b1;
			rgdst1 <= 1'b0;
			rgdst2 <= 1'b0;
			rgdst3 <= 1'b0;
			memtoreg <= 1'b1;
			rfsrc <= 1'b1;
			alusrc <= 1'b1;
			aluop <= 2'b01;
		end
		6'b010001: begin //set on lower than immediate
			pcsrc2 <= 1'b1;
			regwrite <= 1'b1;
			rgdst1 <= 1'b0;
			rgdst2 <= 1'b0;
			rgdst3 <= 1'b0;
			memtoreg <= 1'b1;
			rfsrc <= 1'b1;
			alusrc <= 1'b1;
			aluop <= 2'b11;
		end
		6'b011100: begin //load word
			
			pcsrc2 <= 1'b1;
			alusrc <= 1'b1;
			regwrite <= 1'b1;
			aluop <= 2'b01;
			memread <= 1'b1;
			memtoreg <= 1'b0;
			rfsrc <= 1'b1;
		end
		6'b011101: begin //store word
			pcsrc2 <= 1'b1;
			alusrc <= 1'b1;
			aluop <= 2'b01;
			memwrite <= 1'b1;
		end
	endcase
end

endmodule

			
			
			
			
		