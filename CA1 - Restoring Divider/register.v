`timescale 1ps/1ps
module shift_register#(parameter size = 6) (input clk, rst,input ld,input shl,sin,toggle, input[size:0] in
                                ,output reg [size:0] out );

    always @(posedge clk, posedge rst) 
    begin
        if(rst)
            out <= 0;
        else 
        begin
            if(ld)
                out <= in;
            else
                if(shl)
                    out <= {out[size-1:0], sin};
		else if(toggle)
			out[0] <= 1;
        end
    end

endmodule