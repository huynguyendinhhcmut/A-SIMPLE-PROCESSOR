module datapath (
	input logic clk, rst,
	input logic [8:0] Din, 
	input logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, Ain, Gin, 
	input logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, Gout, Dinout, AddSub,
	output logic [8:0] BUS, G, sumG, A, R0, R1, R2, R3, R4, R5, R6, R7
);

//logic [8:0] R0, R1, R2, R3, R4, R5, R6, R7, A, G, sumG;

D_FF9b dffR0 (.clk(clk), .rst(rst), .enable(R0in), .data_i(BUS), .data_o(R0));
D_FF9b dffR1 (.clk(clk), .rst(rst), .enable(R1in), .data_i(BUS), .data_o(R1));
D_FF9b dffR2 (.clk(clk), .rst(rst), .enable(R2in), .data_i(BUS), .data_o(R2));
D_FF9b dffR3 (.clk(clk), .rst(rst), .enable(R3in), .data_i(BUS), .data_o(R3));
D_FF9b dffR4 (.clk(clk), .rst(rst), .enable(R4in), .data_i(BUS), .data_o(R4));
D_FF9b dffR5 (.clk(clk), .rst(rst), .enable(R5in), .data_i(BUS), .data_o(R5));
D_FF9b dffR6 (.clk(clk), .rst(rst), .enable(R6in), .data_i(BUS), .data_o(R6));
D_FF9b dffR7 (.clk(clk), .rst(rst), .enable(R7in), .data_i(BUS), .data_o(R7));

D_FF9b dffA (.clk(clk), .rst(rst), .enable(Ain), .data_i(BUS), .data_o(A));

FA9b Addsub (.a(A), .b(BUS), .cin(AddSub), .sum(sumG));

D_FF9b dffG (.clk(clk), .rst(rst), .enable(Gin), .data_i(sumG), .data_o(G));

multiplexer multiplexer0 (.Din(Din), .R0(R0),  .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .Gin(Gin), .G(G),
								  .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out),
								  .Gout(Gout), .Dinout(Dinout), .BUS(BUS));

endmodule



