`timescale 1ps/1ps

module controller(input clk, rst, start, A_0,
	 output reg ldA, ldQ, ldD, Ashl, Qshl, sel1, ready, toggle, sel2);

	parameter [3:0] IDLE = 0, LOAD = 1, WAIT =  2, SUB = 3, SHL = 4, DONE = 5, ADD = 6, LOAD_A = 7, LOAD_A2 = 8, TOGGLE = 9;
	wire cout;
	wire [2:0] rep;
	reg init, cnt;
	reg [3:0] ns, ps;

	always@(A_0, start, ps) begin
   		ns = 0;
    		case( ps )
      			IDLE : ns = start ? LOAD : IDLE;
      			LOAD : ns = WAIT;
      			WAIT : ns = SHL;
			SHL : ns = SUB;
      			SUB : ns = LOAD_A;
			LOAD_A: ns = A_0 ? ADD : TOGGLE;
			TOGGLE: ns = DONE;
			ADD : ns = LOAD_A2;
			LOAD_A2 : ns = DONE;
      			DONE : ns = cout ? IDLE : SHL;
    		endcase 
  	end
	
	always@(A_0,start ,ps) begin 
    		{ ready, ldA, ldQ, ldD, cnt, Ashl, Qshl, sel1, sel2, init,toggle } = 0;
    		case( ps )
			IDLE:
				ready = 1;
      			LOAD : begin
        			ldA = 1;
        			ldQ = 1;
					init = 1;
					ldD = 1;
					sel1 = 1;
      			end
			SUB: begin
				ldA = 1;
				sel2 = 1;
				cnt = 1;
			end
			ADD:
				ldA = 1;
			SHL: begin
				Qshl = 1;
				Ashl = 1;
			end
			TOGGLE:
				toggle = 1'b1;		
   		endcase
 	end
	
	always@(posedge clk, posedge rst) begin
    		if( rst )
      			ps <= IDLE;
    		else 
      			ps <= ns;
  	end  

	counter cntr(clk, rst, cnt,init,  cout , rep);

endmodule
	
	
	