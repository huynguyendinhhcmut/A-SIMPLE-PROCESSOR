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
              3'b000: out[0]=1'b1;
              3'b001: out[1]=1'b1;
              3'b010: out[2]=1'b1;
              3'b011: out[3]=1'b1;
              3'b100: out[4]=1'b1;
              3'b101: out[5]=1'b1;
              3'b110: out[6]=1'b1;
              3'b111: out[7]=1'b1;
              default: out=8'b00000000;
          endcase
      end
else 
out=8'b00000000;
end
endmodule