module system (
	input logic mclk, pclk, run, resetn,
	output logic Done, AddSub, Ain,
	output logic [8:0] BUS, R0, R1, R2, R3, R4, R5, R6, R7, A, sumG, G, IR,Din,
	output logic [3:0] state,
	output logic [4:0] ADDRESS,
);

//logic [4:0] ADDRESS; 
logic Gout, Dinout, IRin, Gin;//, Ain;//, AddSub;
logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in;
logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
//logic [8:0] /*IR,*/ Din;

up_counter5b upcounter5b (.clk(mclk), .rst(resetn), .ADDRESS(ADDRESS));

MyROM myrom1 (.clk(mclk), .addr(ADDRESS), .data_read(Din));

ControlunitFSM FSM (	.clk(pclk), .run(run), .resetn(resetn),
							.Din(Din), .Gout(Gout), .Dinout(Dinout), .IRin(IRin), .Ain(Ain), .Gin(Gin), .AddSub(AddSub), .Done(Done), .state(state), .IR(IR),
							.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), 
							.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out));
					
datapath datapath (.clk(pclk), .rst(resetn), .Din(Din), .Ain(Ain), .Gin(Gin), .Gout(Gout), .Dinout(Dinout), .AddSub(AddSub),
						 .R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in),
						 .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out),
						 .BUS(BUS), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .A(A), .sumG(sumG), .G(G));

endmodule
