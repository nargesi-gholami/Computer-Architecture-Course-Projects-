`timescale 1ps/1ps
module multiplexer4 #(parameter size = 32) (input [size-1:0] in1 , in2 ,in3, in4, input[1:0] s , output [size-1:0] out );

  assign out = (s[1] & s[0]) ? in4 : (s[1] & ~s[0]) ? in3 : (~s[1] & s[0]) ? in2 : in1;

endmodule
