module sel_in(Dados, Entrada2, Sel_in, Saida);

input [5:0] Dados;
input [5:0] Entrada2;
input Sel_in;
output reg [5:0] Saida;


always@(*)
begin	
	if(!Sel_in)
		Saida <= Dados;
	else 
		Saida <= Entrada2;
end


endmodule 