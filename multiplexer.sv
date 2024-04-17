module multiplexer (
	input logic [8:0] Din,
	input logic [8:0] R0, R1, R2, R3, R4, R5, R6, R7, G,
	input logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Dinout, Gin,
	output logic [8:0] BUS
);

logic [9:0] sel;
assign sel [9:0] = {R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Dinout};

always @(*) begin
	case (sel) 
		10'b1000000000: BUS = R0;
		10'b0100000000: BUS = R1;
		10'b0010000000: BUS = R2;
		10'b0001000000: BUS = R3;
		10'b0000100000: BUS = R4;
		10'b0000010000: BUS = R5;
		10'b0000001000: BUS = R6;
		10'b0000000100: BUS = R7;
		10'b0000000010: BUS = G;
		10'b0000000001: BUS = Din;
		default: BUS = 9'b0000000000;
	endcase
end 
endmodule
	
	