module top_mem (
input logic clk,
input logic [4:0] ADDRESS,
output logic [8:0] DATA
);
MyROM U0 (
.clk (clk),
.ADDRESS (ADDRESS),
.DATAOUT (DATA)
);
endmodule : top_mem