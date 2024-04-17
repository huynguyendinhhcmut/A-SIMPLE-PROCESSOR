module system (
	input logic mclk, pclk, run, resetn,
	output logic Done,
	output logic [8:0] BUS
);

logic [4:0] ADDRESS; 
logic Gout, Dinout, IRin, Ain, Gin, AddSub;
logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in;
logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out;
logic [8:0] IR, Din;

up_counter5b upcounter5b (.clk(mclk), .rst(resetn), .ADDRESS(ADDRESS));

top_mem topmem (.clk(mclk), .ADDRESS(ADDRESS), .DATA(Din));

ControlunitFSM FSM (	.clk(pclk), .rst(resetn), .run(run), .resetn(resetn),
							.Din(Din), .Gout(Gout), .Dinout(Dinout), .IRin(IRin), .Ain(Ain), .Gin(Gin), .AddSub(AddSub), .Done(Done),
							.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in),
							.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out));
					
datapath datapath (.clk(pclk), .rst(resetn), .Din(Din), .Ain(Ain), .Gin(Gin), .IRin(IRin), .Gout(Gout), .Dinout(Dinout), .AddSub(AddSub),
						 .R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in),
						 .R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out),
						 .BUS(BUS), .IR(IR));

endmodule