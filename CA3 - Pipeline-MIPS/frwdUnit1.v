`timescale 1ps/1ps
module frwdUnit(input [4:0] Rt, Rs, EXMEMRd, MWBRd, input EXMEMrw, MWBrw, output reg [1:0] forwardA, forwardB);

always@(Rt, Rs, EXMEMRd, MWBRd, EXMEMrw, MWBrw) begin
	if((EXMEMrw == 1) & (EXMEMRd == Rs) & (EXMEMRd != 6'b0))
		forwardA = 01;
	else if((MWBrw == 1) & (MWBRd == Rs) & (MWBRd != 6'b0))
		forwardA = 10;
	else
		forwardA = 00;
	if((EXMEMrw == 1) & (EXMEMRd == Rt) & (EXMEMRd != 6'b0))
		forwardB = 01;
	else if((MWBrw == 1) & (MWBRd == Rt) & (MWBRd != 6'b0))
		forwardB = 10;
	else
		forwardB = 00;
end
endmodule
