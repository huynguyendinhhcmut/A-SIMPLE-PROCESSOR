module MyROM#(
	parameter int unsigned width = 9,
	parameter int unsigned depth = 32,
	parameter intFile = "inst_mem.bin"
)

(
	input logic clk,
	input logic [$clog2(depth)-1:0] addr,
	output logic [width-1:0] data_read
);

logic [width-1:0] ram [0:depth-1];
initial $readmemb(intFile, ram);

always_ff @ (posedge clk) begin
	data_read <= ram[addr];
end 
endmodule