module registrador(Entrada, Saida, en, clk, rst);

input [5:0] Entrada;
output reg [5:0] Saida;

input clk, rst, en;

always@(posedge clk or negedge rst)
begin
	if(!rst) begin 
		Saida <= 6'b000000;
	end else if(en) begin
			Saida <= Entrada;
		end
end

endmodule  