`timescale 1ps/1ps
module multiplexer3 #(parameter size = 8) (input [size-1:0] in1 , in2 ,in3, input[1:0] s , output [size-1:0] out );
  assign out = s[1] ? in3 : s[0] ? in2 : in1;
endmodule
