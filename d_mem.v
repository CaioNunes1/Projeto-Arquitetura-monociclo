module d_mem #(parameter MEMORY_SIZE = 64) (
    input wire [31:0] memAddress,        // Endereço de memória para leitura e escrita
    input wire [31:0] writeData,         // Dados a serem escritos na memória
    input wire clk, memWrite, memRead,   // Sinais de controle para escrita e leitura da memória
    output reg [31:0] readData           // Dados lidos da memória
);

   // Declaração dos elementos internos
   reg [31:0] memArray [MEMORY_SIZE - 1:0]; // Cria memória com tamanho definido por MEMORY_SIZE em bytes

   // Lógica de escrita
   always @(posedge clk) begin
      if (memWrite) begin
         memArray[memAddress] = writeData; // Grava os dados fornecidos no endereço indicado se memWrite está ativo
      end
   end

   // Lógica de leitura
   always @(*) begin
      if (memRead) begin
         readData = memArray[memAddress]; // Lê os dados da memória no endereço dado por memAddress se memRead está ativo
      end
      else begin
         readData = 32'bz; // Caso contrário, atribui '32'bz' a readData
      end
   end

endmodule