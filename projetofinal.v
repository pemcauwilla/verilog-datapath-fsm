module projetofinal(Dados, Hex, HexA, HexB, HexC, clk, rst, instrucao, fim);

// declaracao das entradas e saidas

input [3:0] Dados;
input clk, rst, instrucao;

output [6:0] Hex, HexA, HexB, HexC;
output fim;


// -----------------------------

// declaracao dos modulos e fios auxiliares

wire [5:0] saidaULA, entradaULA;

wire [5:0] saidaSel;

wire [5:0] entrada1Sel_R, entrada2Sel_R, saidaSel_R;

wire [5:0] Saida;

wire enA, enB, enC;

wire Sel_in, Sel_R;

wire [1:0] Op, Op_reg;

sel_in SEL_IN(.Dados({2'b00, Dados}), .Entrada2(saidaULA), .Sel_in(Sel_in), .Saida(saidaSel));

registrador regA(.Entrada(saidaSel), .Saida(entradaULA), .en(enA), .clk(clk), .rst(rst));

registrador regB(.Entrada(saidaSel), .Saida(entrada1Sel_R), .en(enB), .clk(clk), .rst(rst));

registrador regC(.Entrada(saidaSel), .Saida(entrada2Sel_R), .en(enC), .clk(clk), .rst(rst));

sel_in SEL_R(.Dados(entrada1Sel_R), .Entrada2(entrada2Sel_R), .Sel_in(Sel_R), .Saida(saidaSel_R));

ULA ula(.Entrada1(entradaULA), .Entrada2(saidaSel_R), .Saida(saidaULA), .Op(Op));

registradorD regD(.Entrada(saidaSel_R), .Saida(Saida), .Op_reg(Op_reg),.clk(clk), .rst(rst));

// -----------------------------

// logica da maquina de estados

UDC udc(.instrucao(instrucao), .enA(enA), .enB(enB), .enC(enC), .Sel_in(Sel_in), .Sel_R(Sel_R), .Op(Op), .Op_reg(Op_reg), .fim(fim), .clk(clk), .rst(rst));

// -----------------------------

// Displays

display displayRegA(.Entrada(entradaULA), .Saida(HexA));
display displayRegB(.Entrada(entrada1Sel_R), .Saida(HexB));
display displayRegC(.Entrada(entrada2Sel_R), .Saida(HexC));
display displaySaida(.Entrada(Saida), .Saida(Hex));

endmodule 