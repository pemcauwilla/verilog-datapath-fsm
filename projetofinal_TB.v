`timescale 1ns/100ps
module projetofinal_TB();


reg clk, rst, instrucao;

reg [3:0] Dados;

wire fim;
wire [6:0] Hex, HexA, HexB, HexC;


projetofinal DUT(.Dados(Dados), .Hex(Hex), .HexA(HexA), .HexB(HexB), .HexC(HexC),.clk(clk), .rst(rst), .instrucao(instrucao), .fim(fim));

always begin
	#1 clk = !clk;
end

always begin
	#32 instrucao = !instrucao;
end

always begin
	#1 Dados = Dados + 1'b1;
end


initial begin
	#0 clk = 1'b0;
	#0 rst = 1'b0;
	
	#0 Dados = 4'b0000;
	#0 instrucao = 1'b1;
	
	#2 rst = 1'b1;
	
	#128 $stop;
end

endmodule
