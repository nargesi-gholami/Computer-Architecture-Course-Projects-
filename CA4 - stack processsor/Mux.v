`timescale 1ps/1ps

module multiplexer #(parameter size = 8) (input [size-1:0] in1 , in2 , input s , output [size-1:0] out );
  assign out = s ? in2 : in1;
endmodule
