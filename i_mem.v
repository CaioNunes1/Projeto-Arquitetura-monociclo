module i_mem (addr, i_output);
    // Declaração dos parâmetros referentes à memória ROM
    parameter mem_size = 256;
    parameter addr_data = 32;

    // Declaração de entradas e saída
    input wire [addr_data-1:0] addr;
    output wire [addr_data-1:0] i_output;

    // Declaração da memória ROM
    reg [addr_data-1:0] rom_memory [0:mem_size-1];

    // Inicializando o arquivo com as instruções MIPS
    // TODO: Completar arquivo com mais instruções
    initial begin
        $readmemb("tests/instruction.list", rom_memory);
    end

    // Leitura assíncrona. Apenas o addr é considerado no always.
    // Nesse caso, a saída recebe a instrução presente no índice dado
    // pelos 5 últimos bits do addr. Então, esse índice referencia
    // à localização da instrução no arquivo da rom_memory 
    assign i_output = rom_memory[addr[addr_data-1:2]];
    
endmodule