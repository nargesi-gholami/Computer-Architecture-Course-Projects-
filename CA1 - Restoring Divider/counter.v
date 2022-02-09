`timescale 1ps/1ps
module counter(input clk,input rst,input up,input init,output reg cout, output reg [2:0] cnt);

    always @(posedge clk, posedge rst) begin
        if(init)
            cnt <= 3'b001;
        if(rst)
            cnt <= 0;
        else
            if(up)
                cnt <= cnt + 1;

    end
    assign cout = &{cnt};
endmodule