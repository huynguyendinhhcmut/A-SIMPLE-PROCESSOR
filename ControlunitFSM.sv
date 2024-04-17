module ControlunitFSM (
	input logic clk, rst, run, resetn,
	input logic [8:0] Din,
	output logic Gout, Dinout, IRin, Ain,
	output logic Gin, AddSub, Done,
	output logic R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in,
	output logic R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out
);

logic [7:0] outX, outY;
logic [8:0] IR;
logic RXout, RYout, RXin, RYin;
D_FF9b dffIR (.clk(clk), .rst(rst), .enable(IRin), .data_i(Din), .data_o(IR));

decoder3to8 decoder3to8RX (.in(IR[5:3]), .out(outX));
decoder3to8 decoder3to8RY (.in(IR[2:0]), .out(outY));

assign R0in = (outX[0] & RXin) | (outY[0] & RYin);
assign R1in = (outX[1] & RXin) | (outY[1] & RYin);
assign R2in = (outX[2] & RXin) | (outY[2] & RYin);
assign R3in = (outX[3] & RXin) | (outY[3] & RYin);
assign R4in = (outX[4] & RXin) | (outY[4] & RYin);
assign R5in = (outX[5] & RXin) | (outY[5] & RYin);
assign R6in = (outX[6] & RXin) | (outY[6] & RYin);
assign R7in = (outX[7] & RXin) | (outY[7] & RYin);

assign R0out = (outX[0] & RXout) | (outY[0] & RYout);
assign R1out = (outX[1] & RXout) | (outY[1] & RYout);
assign R2out = (outX[2] & RXout) | (outY[2] & RYout);
assign R3out = (outX[3] & RXout) | (outY[3] & RYout);
assign R4out = (outX[4] & RXout) | (outY[4] & RYout);
assign R5out = (outX[5] & RXout) | (outY[5] & RYout);
assign R6out = (outX[6] & RXout) | (outY[6] & RYout);
assign R7out = (outX[7] & RXout) | (outY[7] & RYout);

typedef enum bit [3:0] {reset	=	4'b0000,
								fetch =	4'b0001,
								mv 	=	4'b0010,
								mvi 	= 	4'b0011,
								add1 	= 	4'b0100,
								add2 	= 	4'b0101,
								add3 	= 	4'b0110,
								sub1 	= 	4'b0111,
								sub2 	= 	4'b1000,
								sub3 	= 	4'b1001} state_t;
state_t state_reg, state_next;

always_ff @(posedge clk or negedge resetn)
	if (!resetn)
		state_reg <= reset;
	else 
		state_reg <= state_next;
	
always_comb begin
	state_next = state_reg;
	RXout = 1'b0; 
	RYout = 1'b0;
	Gout = 1'b0;
	Dinout = 1'b0; 
	IRin = 1'b0; 
	Ain = 1'b0;
	RXin = 1'b0; 
	RYin = 1'b0; 
	Gin = 1'b0; 
	AddSub = 1'b0; 
	Done = 1'b0;
	case (state_reg)
		reset:	begin
						if (!resetn) 
							state_next = reset;
						else state_next = fetch;
					end
		fetch:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b1; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
						if (!run)
							state_next = fetch;
						else if (run && IR[8:6] == 3'b000)
							state_next = mv;
						else if (run && IR[8:6] == 3'b001)
							state_next = mvi;
						else if (run && IR[8:6] == 3'b010)
							state_next = add1;
						else if (run && IR[8:6] == 3'b011)
							state_next = sub1;
					end
		mv:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;				
						if (clk)
							state_next = fetch;
				end
		mvi:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b1; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;
						if (clk) 
							state_next = fetch;
				end
		add1:	begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b1;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;					
						if (clk)
							state_next = add2;
				end
		add2:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b1; 
					AddSub = 1'b0; 
					Done = 1'b0;				
						if (clk)
							state_next = add3;
				end
		add3:	begin
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b1;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;					
						if (clk)
							state_next = fetch;
				end
		sub1:	begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b1;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;					
						if (clk) 
							state_next = sub2;
				end
		sub2:	begin
					RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					RYin = 1'b0; 
					Gin = 1'b1; 
					AddSub = 1'b1; 
					Done = 1'b0;					
						if (clk) 
							state_next = sub3;
				end
		sub3: begin	
					RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b1;
					Dinout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b1; 
					RYin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b1;				
						if (clk)
							state_next = fetch;
				end
	endcase
end
endmodule