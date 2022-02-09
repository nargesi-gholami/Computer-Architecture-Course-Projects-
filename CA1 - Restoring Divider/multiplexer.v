`timescale 1ps/1ps

module multiplexer (input [6:0] in1 , in2 , input s , output [6:0] out );
  assign out = s ? in1 : in2;
endmodule
