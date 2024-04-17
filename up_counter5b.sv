module up_counter5b (
	input logic clk, rst,
	output logic [4:0] ADDRESS
);

D_FF dff1 (.clk(clk), .rst(rst), .data_i(~ADDRESS[0]), .data_o(ADDRESS[0]));
D_FF dff2 (.clk(~ADDRESS[0]), .rst(rst), .data_i(~ADDRESS[1]), .data_o(ADDRESS[1]));
D_FF dff3 (.clk(~ADDRESS[1]), .rst(rst), .data_i(~ADDRESS[2]), .data_o(ADDRESS[2]));
D_FF dff4 (.clk(~ADDRESS[2]), .rst(rst), .data_i(~ADDRESS[3]), .data_o(ADDRESS[3]));
D_FF dff5 (.clk(~ADDRESS[3]), .rst(rst), .data_i(~ADDRESS[4]), .data_o(ADDRESS[4]));

endmodule