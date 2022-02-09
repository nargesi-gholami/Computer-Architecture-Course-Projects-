`timescale 1ps/1ps
module datapath(input clk,input rst,input ldA,ldQ,ldD,input Ashl, Qshl,sel1, toggle, sel2,
    input [6:0]A_BUS, [5:0]Q_BUS, [6:0]D_BUS, output A_0,output[6:0]remainder,[5:0]quotient);

    wire [2:0]cnt;
    wire [6:0] A_PLUS, xorOut;
    wire [6:0] A_OUT;
    wire [6:0]A;
    wire [5:0]Q;
    wire [6:0]D;

    multiplexer m( A_BUS , A_PLUS , sel1 ,  A_OUT );

    shift_register regA(clk, rst, ldA,Ashl,Q[5],1'b0, A_OUT, A);
    shift_register #(5)regQ(clk, rst, ldQ, Qshl, 1'b0, toggle, Q_BUS, Q);
    shift_register regD(clk, rst,ldD,1'b0,1'b0,1'b0, D_BUS, D);
    mult_xor mx(D, sel2, xorOut);
    adder add(xorOut ,sel2, A, A_PLUS);

    assign remainder = A;
    assign quotient = Q;
    assign A_0 = A[6];

endmodule
