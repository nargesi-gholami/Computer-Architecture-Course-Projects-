`timescale 1ps/1ps
module instMem(input [31:0] addr, output [31:0] dataout);

      parameter [5:0] LW = 6'b011100, RT = 6'b000000, ADD = 6'b000100, BEQ = 6'b100000,
		 ADDI = 6'b000001,SW =6'b011101, J = 6'b010000,SLT = 6'b010101,
		 BNE = 6'b101000, JAL = 6'b011000, SLTI = 6'b010001, 
		 SUB = 6'b010100 , JR = 6'b000001 ; 
      parameter [4:0] SUM_R = 5'b00110, CNT_R = 5'b00001, OP_R = 5'b00010, END = 5'b11001,
		 R_0 = 5'b00000, R_1 = 5'b00001;
      parameter [15:0] EADDR = 16'd9, START = 16'd1000, SADD = 16'd2000; 
      integer i = 0;  
      reg [31:0] ram [0:4000];  
     
      //filling instructions to sum all elements of an array of length 10;
      initial begin  
      		ram[0] = {BEQ, END, CNT_R, EADDR};
		ram[1] = {RT, R_0, R_0, R_0, 5'b0, ADD};
		ram[2] = {RT, R_0, R_0, R_0, 5'b0, ADD};
		ram[3] = {LW, CNT_R, OP_R, START};
		ram[4] = {RT, R_0, R_0, R_0, 5'b0, ADD};
		ram[5] = {RT, SUM_R, OP_R, SUM_R, 5'b0,ADD};
		ram[6] = {ADDI, CNT_R, CNT_R, 16'd1};
		ram[7] = { J, 26'b0 };
		ram[8] = {RT, R_0, R_0, R_0, 5'b0, ADD};
		ram[9] = {RT, R_0, R_0, R_0, 5'b0, ADD};
		ram[10] = {SW, R_0, SUM_R, SADD};
		/*ram[0] = { RT , OP_R, 15'b0, JR};//correct
		ram[1] = 32'b0;
		ram[2] = {RT ,R_0, OP_R, R_1,5'b0, SLT};// R_1 <= 1 
		ram[3] = {BNE,  R_0, R_1, 16'd1};// jump to 16'd5
		ram[4] = {32'b0};
		ram[5] = {SLTI,R_1,SUM_R, 16'd2}; // SUM_R < 1
		ram[6] = {JAL, 26'd1}; // jump to zero  */
      end 
      
      assign dataout = ram[{2'b00, addr[31:2]}];
endmodule  

