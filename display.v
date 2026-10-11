module display(Entrada, Saida);

input [5:0] Entrada;
output reg [6:0] Saida;

always@(*)
	case(Entrada)
		6'b000000: Saida = 7'b1000000; // 0
		6'b000001: Saida = 7'b1111001; // 1
		6'b000010: Saida = 7'b0100100; // 2
		6'b000011: Saida = 7'b0110000; // 3
		6'b000100: Saida = 7'b0011001; // 4
		6'b000101: Saida = 7'b0010010; // 5
		6'b000110: Saida = 7'b0000010; // 6
		6'b000111: Saida = 7'b1111000; // 7
		6'b001000: Saida = 7'b0000000; // 8
		6'b001001: Saida = 7'b0010000; // 9
		6'b001010: Saida = 7'b0001000; // A
		6'b001011: Saida = 7'b0000011; // b
		6'b001100: Saida = 7'b1000110; // C
		6'b001101: Saida = 7'b0100001; // d
		6'b001110: Saida = 7'b0000110; // E
		6'b001111: Saida = 7'b0001110; // F
		default: Saida = 7'b0111111; // '-' 
	endcase
endmodule 