module ULA(Entrada1, Entrada2, Saida, Op);

input [5:0] Entrada1, Entrada2;
output reg [5:0] Saida;

input [1:0] Op;

always@(*)
begin
	case(Op)
		2'b00: begin Saida <= Entrada1; end
		2'b01: begin Saida <= Entrada1 + Entrada2; end
		2'b10: begin Saida <= Entrada1 - Entrada2; end
		2'b11: begin Saida <= ~(Entrada1); end
	endcase
end

endmodule 