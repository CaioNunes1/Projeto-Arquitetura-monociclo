// Universidade Federal Rural de Pernambuco
// 2021.2
// Arquitetura e Organização de Computadores - 2ªVA
// Alunos:
// Steffano Pereira
// Haga Fedra
// João Carvalho
// Julyanne Correia
// -----------------------------
module i_mem (address, i_out);
    // Declaração dos parâmetros referentes À memória ROM
    parameter memory_size = 256;
    parameter address_data = 32;

    // Declaração de entradas e saída
    input wire [address_data-1:0] address;
    output wire [address_data-1:0] i_out;

    // Declaração da memória ROM
    reg [address_data-1:0] rom_mem [0:memory_size-1];

    // Inicializando o arquivo com as instruções MIPS
    // TODO: Completar arquivo com mais instruções
    initial begin
        $readmemb("tests/instruction.list", rom_mem);
    end

    // Leitura assíncrona. Apenas o address é considerado no always.
    // Nesse caso, a saída recebe a instrução presente no índice dado
    // pelos 5 últimos bits do address. Então, esse índice referencia
    // à localização da instrução no arquivo da rom_mem 
    assign i_out = rom_mem[address[address_data-1:2]];
    
endmodule