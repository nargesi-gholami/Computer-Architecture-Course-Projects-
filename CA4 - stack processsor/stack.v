`timescale 1ps/ 1ps
module stack(input clk, input[7:0] d_in, input push,tos,pop, output reg[7:0] d_out);

reg [4:0]pointer;
reg [7:0] stack_reg[31:0];
integer i;

//filling all registers with zero
initial begin
	for(i=0;i<32;i=i+1)
		stack_reg[i] <= 32'b0;
	pointer <= 5'b0;
end


always@(posedge clk)begin
	if(push)begin
		stack_reg[pointer] <= d_in;
		pointer = pointer + 1'b1;
		
	end

	else if(tos)
		d_out <= stack_reg[pointer-1];

	else if(pop)begin
		d_out <= stack_reg[pointer-1];
		pointer <= pointer - 1'b1;
	end
end
endmodule
