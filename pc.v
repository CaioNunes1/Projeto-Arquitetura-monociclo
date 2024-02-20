
module PC(nextPC, pc, clock);
	// Declaração de entradas e saída
	input clock;
	input wire [31:0] nextPC;
	output reg [31:0] pc;
	// Declaração de flag
	reg reset;

	// Inicializando reset e pc com 0
	initial begin
		reset = 0;
		pc = 32'b0;
	end

	// Atribuição síncrona. Se reset == 1, pc recebe o mesmo
	// valor que nextPC, caso contrário pc é setado em 0 e reset ´
	// tem o valor alterado
	always @(posedge clock) begin
		if(reset) begin
			pc = nextPC;
		end else begin
			pc = 32'b0;
			reset = 1;
		end
	end
endmodule
