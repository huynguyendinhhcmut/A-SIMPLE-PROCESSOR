module decoder3to8 ( 
	input logic [2:0] in,
	output logic [7:0] out
);

logic enable;
assign enable = 1'b1;

always @(*) begin
		if (enable) 
        begin
          out=8'd0;
          case (in)
              3'b000: out = 8'b00000001;
              3'b001: out = 8'b00000010;
              3'b010: out = 8'b00000100;
              3'b011: out = 8'b00001000;
              3'b100: out = 8'b00010000;
              3'b101: out = 8'b00100000;
              3'b110: out = 8'b01000000;
              3'b111: out = 8'b10000000;
              default: out=8'b00000000;
          endcase
      end
else 
out=8'b00000000;
end
endmodule