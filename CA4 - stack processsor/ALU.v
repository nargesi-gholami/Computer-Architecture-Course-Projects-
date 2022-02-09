`timescale 1ps/1ps
module ALU(input [7:0] a, b, input [1:0] ALUop, output zero, output reg [7:0] Result);

assign zero = (Result == 8'b0) ? 1'b1 : 1'b0;

always@(a or b or ALUop)
	begin
        	case (ALUop)
                	3'b11:  Result = a & b;       // AND
                	3'b10:  Result =  ~a;        // NOT
                	3'b01:  Result = a - b;     // subtraction
			3'b00:  Result = a +  b;   // addition
                endcase
           end
endmodule
