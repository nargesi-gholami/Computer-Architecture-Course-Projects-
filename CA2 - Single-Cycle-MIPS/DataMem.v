`timescale 1ps/1ps
module data_memory(input [31:0] addr, data, input read, write, output [31:0] dataout);

      integer i;  

      integer j = 0;
      reg [31:0] ram [0:4000];  
      //making an array with 10 elemnts starting from 1000
      initial begin 
	   for(i=0;i<4000;i=i+1)
		ram[i] = 32'b0; 
           ram[1000] = 32'd10;
	   ram[1001] = 32'd20;
 	   ram[1002] = 32'd30;
	   ram[1003] = 32'd40;
	   ram[1004] = 32'd50;
	   ram[1005] = 32'd60;
	   ram[1006] = 32'd70;
	   ram[1007] = 32'd80;
	   ram[1008] = 32'd90;
	   ram[1009] = 32'd100;
	   
      end 

      assign dataout = (read==1'b1) ? ram[addr]: 32'd0;
      always@(addr, data) begin
      	   if(write)
		ram[addr] <= data;
      end
endmodule  
