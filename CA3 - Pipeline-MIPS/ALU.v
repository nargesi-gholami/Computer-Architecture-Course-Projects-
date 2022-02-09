`timescale 1ps/1ps
module ALU(input [31:0] a, b, input [2:0] ALUop, output reg zero, output reg [31:0] Result);

initial begin
	zero = 1'b0;
end

//assign zero = (Result == 0) ? 1'b1 : 1'b0;
always@(Result)begin
	casex(Result)
	32'b0: zero <= 1'b1;
	default: zero <= 1'b0;
	endcase
end


always@(a or b or ALUop)
	begin
        	case (ALUop)
                	3'b000:  Result <= a & b;   // AND
                	3'b001:  Result <= a | b;   // OR
                	3'b010:  Result <= a +  b;    // addition
                	3'b011:  Result <= a - b;    // subtraction
			3'b100:  Result <= a < b ? 1 : 0; //set on lower than
                endcase
           end
endmodule
