`timescale 1ps/1ps
module Booth_multiplier(input clk,rst,start,input[11:0] A_BUS,input [5:0]D_BUS,
            output ready,output[5:0]quotient,[6:0]remainder);

    wire[6:0] A = {1'b0 , A_BUS[11:6]};
    wire[5:0] Q = A_BUS[5:0];
    wire[6:0] D = {1'b0, D_BUS};

    wire sign,cout, sel2;
    wire A_0, sel1,ldA, ldQ, ldD, Ashl, Qshl,toggle;

    controller c(clk, rst, start, A_0, 
                        ldA, ldQ, ldD, Ashl, Qshl,
                         sel1,
                          ready, toggle, sel2);

    datapath d(clk,rst,ldA,ldQ,ldD,Ashl, Qshl,
                sel1,toggle,sel2,
                A,Q,D,
                A_0,remainder,quotient);


endmodule
