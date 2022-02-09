module regfile(input clk, input [4:0] radd1, radd2, wadd, input en_write, input [31:0] data, output reg [31:0] out1, out2);

reg [31:0] registers[31:0];

integer i;

//filling all registers with zero
initial begin
	for(i=0;i<32;i=i+1)
		registers[i] <= 32'b0;
	registers[25] <= 32'd10;
	//registers[2] <= 32'd2;// test case
end

always @(radd1, radd2)begin
    out1 <= registers[radd1];
    out2 <= registers[radd2];
end

always @(posedge clk)begin
    if(en_write)
	if(wadd != 32'b0)
        	registers[wadd] <= data;
end

endmodule
