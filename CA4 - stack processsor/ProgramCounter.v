`timescale 1ps/1ps
module programCounter(input clk, rst, input ld, input[4:0] in ,output reg [4:0] out );

initial begin 
	out <= 5'b0;
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
