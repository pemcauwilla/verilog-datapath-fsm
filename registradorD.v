module registradorD(Entrada, Saida, Op_reg, clk, rst);

input [5:0] Entrada;
output reg [5:0] Saida;

input [1:0] Op_reg;
input clk, rst;

always@(posedge clk or negedge rst)
begin
	if(!rst) begin
		Saida <= 6'b000000;
	end
	else begin case(Op_reg)
			2'b00: Saida <= Saida; // Mantém a saida
			2'b01: Saida <= Entrada; // Atualiza a saida
			2'b10: Saida <= {1'b0, Saida[5:1]}; // Deslocamento pra direita, com MSB = 0
			2'b11: Saida <= {Saida[4:0], Saida[0]}; // Deslocamento pra esquerda mantendo o LSB
			default: Saida <= Saida;
		endcase
	end
end


endmodule 