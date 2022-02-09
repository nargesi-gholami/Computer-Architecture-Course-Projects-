`timescale 1ps/1ps
module booth_TB();

wire [5:0]quotient;
wire [6:0]remainder;
wire ready;
reg clk,rst,start;
reg[11:0] A_BUS;
reg[5:0] B_BUS;

Booth_multiplier Booth(clk, rst, start, A_BUS, B_BUS,
            ready, quotient, remainder);
    initial begin 
      clk = 1'b0; rst = 1'b0;
      #20000 $stop;
    end 

    initial begin 
      forever #5 clk = ~clk;
    end

  initial begin
     start = 0; 
     #40 start = 1; A_BUS = 12'b010000011010; B_BUS = 6'b011111;//1050/31
     #60 start = 0;
     #1000 start = 1; A_BUS = 12'b010010110101; B_BUS = 6'b011110;//1205/30
     #60 start = 0;
     #1000 start = 1; A_BUS = 12'b001110011110; B_BUS = 6'b010011;//926/19
     #60 start = 0;
     #1000 start = 1; A_BUS = 12'b001101001011; B_BUS = 6'b010101;//843/21
     #60 start = 0;
     #1000 start = 1; A_BUS = 12'b001110000100; B_BUS = 6'b011110;//900/30
     #60 start = 0;
  end
endmodule