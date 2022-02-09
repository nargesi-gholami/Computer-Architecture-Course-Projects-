`timescale 1ps/1ps
module data_memory(input [4:0] addr, [7:0]data, input read, write, output reg [7:0] dataout);

      integer i;  

      integer j = 0;
      reg [7:0] ram [0:31];  
      //making an array with 10 elemnts starting from 1000
      initial begin  
           ram[0]  = 8'b10000001;//push a to stack
	   ram[4]  = 8'b10000010;//push b to stack
 	   ram[8]  = 8'b00000000;// a + b
	   ram[12] = 8'b10000011;//push c to stack
	   ram[16] = 8'b10000101;//push d to stack
	   ram[20] = 8'b00000000;//c + d
	   ram[24] = 8'b00100000;// (a+b) - (c + d)
	   ram[28] = 8'b10111111;//store in ram[31] pop
		// instruction
	   /*ram[1] = 8'd10;//a
	   ram[2] = 8'd20;//b
 	   ram[3] = 8'd30;//c
	   ram[5] = 8'd10;//d*/
	   ram[1] = 8'd15;//a
	   ram[2] = 8'd25;//b
 	   ram[3] = 8'd35;//c
	   ram[5] = 8'd5;//d
	//data
      end 

      //assign dataout = (read==1'b1) ? ram[addr] : 8'd0;

      always@(write, read) begin
      	   if(write)
		ram[addr] = data;
	   if(read)
		dataout = ram[addr];
      end
endmodule  
