module D_FF9b
#(parameter WIDTH=9) // fill number of bits 
(
	input logic clk, rst, enable,
	input logic [WIDTH-1:0] data_i,
	output logic [WIDTH-1:0] data_o
);
reg [WIDTH-1:0] data;
always_ff@ (posedge clk or negedge rst)
	if (!rst) begin
		data <= 0;
	end else if (enable) begin
	data <= data_i;
	end else begin data <= data;
	end
assign data_o=data;
endmodule 