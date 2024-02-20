
module regfile(ReadAddr1, ReadAddr2, ReadData1, ReadData2, Clock, WriteAddr, WriteData, RegWrite, Reset);
	
	// Declaração de entradas e saídas
	input [4:0] ReadAddr1, ReadAddr2, WriteAddr;
	input [31:0] WriteData;
	input Clock, RegWrite, Reset;

	output [31:0] ReadData1, ReadData2;

	// Declaração do Registrador
	reg [31:0] Reg[0:31];

	/*Valores das posições indicadas pelos endereços ReadAddr1 e ReadAddr2 
	sendo atribuídos de forma assíncrona às saídas ReadData1 e ReadData2, 
	respectivamente*/
	assign ReadData1 = Reg[ReadAddr1];
	assign ReadData2 = Reg[ReadAddr2];

	// Bloco executado a cada pulso de Clock ou de Reset
	always @(posedge Clock or posedge Reset) begin

		// Condição de reset do Registrador 
		if(Reset) begin
			Reg[0] <= 32'b0;  
			Reg[1] <= 32'b0;  
			Reg[2] <= 32'b0;  
			Reg[3] <= 32'b0;  
			Reg[4] <= 32'b0;  
			Reg[5] <= 32'b0;  
			Reg[6] <= 32'b0;  
			Reg[7] <= 32'b0;
			Reg[8] <= 32'b0;  
			Reg[9] <= 32'b0;  
			Reg[10] <= 32'b0;  
			Reg[11] <= 32'b0;  
			Reg[12] <= 32'b0;  
			Reg[13] <= 32'b0;  
			Reg[14] <= 32'b0;  
			Reg[15] <= 32'b0;
			Reg[16] <= 32'b0;  
			Reg[17] <= 32'b0;  
			Reg[18] <= 32'b0;  
			Reg[19] <= 32'b0;  
			Reg[20] <= 32'b0;  
			Reg[21] <= 32'b0;  
			Reg[22] <= 32'b0;  
			Reg[23] <= 32'b0;
			Reg[24] <= 32'b0;  
			Reg[25] <= 32'b0;  
			Reg[26] <= 32'b0;  
			Reg[27] <= 32'b0;  
			Reg[28] <= 32'b0;  
			Reg[29] <= 32'b0;  
			Reg[30] <= 32'b0;  
			Reg[31] <= 32'b0;
		end	
		// Caso não seja executado o reset
		else begin
			// Condição para adicionar informações no dado de escrita
			if(RegWrite == 1'b1) Reg[WriteAddr] = WriteData;
		end	
	end
endmodule
