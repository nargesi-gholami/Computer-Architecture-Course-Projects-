`timescale 1ps/1ps
module MIPS_Control(input[5:0] opcode, opcode_out, input zero, branch_out, output reg rgdst1, rgdst2, rgdst3, regwrite, alusrc
		,ld, memread, memwrite, memtoreg, branch, rfsrc, output reg [1:0] aluop, pcsrc);


always @(*) begin
	case(opcode_out)
	6'b010000: pcsrc <= 2'b01;
	6'b011000: pcsrc <= 2'b10;
	6'b100000: pcsrc <= (branch_out & zero) ? 2'b11 : 2'b00;
	default: pcsrc <= 2'b00;
	endcase
end

wire x;
assign x = (opcode == 6'b000000);
wire y ;
assign y = (branch_out & zero);


always @(*)  begin  
      {pcsrc, rgdst1, rgdst2, rgdst3, regwrite, alusrc
		, memread, memwrite, memtoreg, branch, rfsrc, aluop} = 0;
	ld = 1'b1;
      case(opcode)
		6'b000000: begin //rtype
			rgdst1 = 1'b1;
			rgdst2 = 1'b0;
			rgdst3 = 1'b0;
			alusrc = 1'b0;
			memtoreg = 1'b1;
			regwrite = 1'b1;
			rfsrc = 1'b1;
			aluop = 2'b00;
		end
		6'b010000: begin //jump
			//pcsrc = 2'b01;
		end
		6'b011000: begin //jump and link
			//pcsrc = 2'b10;
			rgdst3 = 1'b1;
			regwrite = 1'b1;
			rfsrc = 1'b0;
			aluop = 2'b10;
		end
		6'b100000: begin //branch equal
			branch = 1'b1;
			//pcsrc = zero ? 2'b11 : 2'b00;
			alusrc = 1'b0;
			aluop = 2'b10;
		end
		6'b101000: begin //branch not equal
			branch = 1'b1;
			//pcsrc = !zero ? 2'b11 : 2'b00;
			alusrc = 1'b0;
			aluop = 2'b10;
		end
		6'b000001: begin //add immediate
			regwrite = 1'b1;
			rgdst1 = 1'b0;
			rgdst2 = 1'b0;
			rgdst3 = 1'b0;
			memtoreg = 1'b1;
			rfsrc = 1'b1;
			alusrc = 1'b1;
			aluop = 2'b01;
		end
		6'b010001: begin //set on lower than immediate
			regwrite = 1'b1;
			rgdst1 = 1'b0;
			rgdst2 = 1'b0;
			rgdst3 = 1'b0;
			memtoreg = 1'b1;
			rfsrc = 1'b1;
			alusrc = 1'b1;
			aluop = 2'b11;
		end
		6'b011100: begin //load word
			alusrc = 1'b1;
			regwrite = 1'b1;
			aluop = 2'b01;
			memread = 1'b1;
			memtoreg = 1'b0;
			rfsrc = 1'b1;
		end
		6'b011101: begin //store word
			alusrc = 1'b1;
			aluop = 2'b01;
			memwrite = 1'b1;
		end
	endcase
end

endmodule

			
			
			
			
		