module UDC(instrucao, enA, enB, enC, Sel_in, Sel_R, Op, Op_reg, fim, clk, rst);

input instrucao, clk, rst;

output reg enA, enB, enC, Sel_in, Sel_R, fim;
output reg[1:0] Op, Op_reg;

reg [3:0] state;

localparam loadA = 4'b0000, loadB = 4'b0001, loadC = 4'b0010, sumB1 = 4'b0100, sumB2 = 4'b0101, sumC = 4'b0110, subC = 4'b0111, loadD = 4'b1000, divide = 4'b1001, endOp = 4'b1010;

always@(posedge clk or negedge rst) begin

	if(!rst) begin 
		state <= loadA; // carrega A
	end
	else begin
		case(state)
		loadA: state <= loadB; // carrega B
		loadB: state <= loadC; // carrega C
		loadC: state <= sumB1; // A + B
		sumB1: begin if(instrucao) begin state <= sumC; end else begin state <= sumB2; end end // if(instrucao) -> {resultado_anterior + C} else {resultado_anterior - C} --- resultado_anterior = A + B
		sumB2: state <= subC; // - C
		subC : state <= loadD; // + C
		sumC : state <= loadD; // Saida = A + B + c
		loadD: begin if(instrucao) begin state <= divide; end else begin state <= endOp; end end // if(instrucao) saida / 2 
		divide: state <= endOp; // acabou operacao
		endOp: state <= loadA; // reinicia
		default: state <= loadA; // padrao é começar carregando A
		endcase
	end

end

always@(state) begin
	case(state)
		loadA: begin enA = 1'b1; enB = 1'b0; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b00; fim = 1'b0; end 
		loadB: begin enA = 1'b0; enB = 1'b1; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b00; fim = 1'b0; end 
		loadC: begin enA = 1'b0; enB = 1'b0; enC = 1'b1; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b00; fim = 1'b0; end 
		sumB1: begin enA = 1'b1; enB = 1'b0; enC = 1'b0; Sel_in = 1'b1; Sel_R = 1'b0; Op = 2'b01; Op_reg = 2'b00; fim = 1'b0; end // pega o valor de A, soma com B e carrega em A
		sumB2: begin enA = 1'b1; enB = 1'b0; enC = 1'b0; Sel_in = 1'b1; Sel_R = 1'b0; Op = 2'b01; Op_reg = 2'b00; fim = 1'b0; end // repete a primeira soma (multiplicação)
		sumC : begin enA = 1'b0; enB = 1'b1; enC = 1'b0; Sel_in = 1'b1; Sel_R = 1'b1; Op = 2'b01; Op_reg = 2'b00; fim = 1'b0; end // pega o valor de A , soma com C, e carrega em B
		subC : begin enA = 1'b0; enB = 1'b1; enC = 1'b0; Sel_in = 1'b1; Sel_R = 1'b1; Op = 2'b10; Op_reg = 2'b00; fim = 1'b0; end // pega o valor de A, subtrai com C, e carrega em B
		loadD : begin enA = 1'b0; enB = 1'b0; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b01; fim = 1'b0; end // carrega o valor de B em D
		divide : begin enA = 1'b0; enB = 1'b0; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b10; fim = 1'b0; end
		endOp : begin enA = 1'b0; enB = 1'b0; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b00; fim = 1'b0; end
		default: begin enA = 1'b0; enB = 1'b0; enC = 1'b0; Sel_in = 1'b0; Sel_R = 1'b0; Op = 2'b00; Op_reg = 2'b00; fim = 1'b0; end
	endcase
end

endmodule