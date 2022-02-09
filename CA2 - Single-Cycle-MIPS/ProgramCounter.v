`timescale 1ps/1ps
module programCounter(input clk, rst, input ld, input[31:0] in ,output reg [31:0] out );


    initial begin 
	out <= 32'b0;
    end

    always @(posedge clk, posedge rst) 
    begin
        if(rst)
            out <= 0;
        else 
        begin
            if(ld)
                out <= in;
	end
    end
endmodule
