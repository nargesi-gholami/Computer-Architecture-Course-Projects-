`timescale 1ps/1ps
module ALUControl(input [1:0] ALUOp, input [5:0] Function, output reg[2:0] ALU_Control);  
	wire [7:0] ALUControlIn;  
	assign ALUControlIn = {ALUOp,Function};  
	always @(ALUControlIn) begin 
		casex (ALUControlIn)  
  			8'b01xxxxxx: ALU_Control <=3'b010;  //lw, sw
  			8'b10xxxxxx: ALU_Control <=3'b011;  //control flow
			8'b11xxxxxx: ALU_Control <=3'b100;  //set less than i
  			8'b00100100: ALU_Control <=3'b000;  //r_type(and)
  			8'b00101100: ALU_Control <=3'b001;  //r_type(or)
  			8'b00000100: ALU_Control <=3'b010;  //r_type(add)
  			8'b00010100: ALU_Control <=3'b011;  //r_type(sub)
  			8'b00010101: ALU_Control <=3'b100;  //r_type(slt)
  			default: ALU_Control <= 3'b000;  
  		endcase  
	end
endmodule  

module JR_Control( input[1:0] alu_op, input [5:0] funct, output pcsrc3);

assign pcsrc3 = ({alu_op,funct}==8'b00000001) ? 1'b0 : 1'b1;
			
endmodule