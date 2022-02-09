`timescale 1ps/1ps
module signExtend(input [15:0] in, output [31:0] out);

assign out = (in[15] == 1) ? {16'b1, in} : {16'b0, in};

endmodule
