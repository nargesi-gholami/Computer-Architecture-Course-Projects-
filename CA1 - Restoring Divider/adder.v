`timescale 1ps/1ps
module adder(input[6:0] D,input cin, input[6:0]A, output[6:0] A_PLUS );

    assign A_PLUS = A + D + cin;
    
endmodule
