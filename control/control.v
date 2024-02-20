

`include "jr_control.v"
`include "pc_source_control.v"
`include "ula_control.v"

module control (
  // Entrada: Opcode da instrução
  input wire [5:0] opcode,

  // Saídas controlando diversas unidades de hardware
  output reg MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, isJAL, isSigned,
  output reg [1:0] PCOp, RegDst,
  output reg [4:0] ALUOp
);

  // Decodifica o opcode e configura os sinais de controle de acordo
  always @(opcode) begin
    case (opcode)
      // Instruções R-type (sll, srl, sra, add, sub, and, or, xor, nor, slt, sltu)
      6'b000000: begin
        RegDst = 2'b01; // Destino é o registrador especificado no campo Rd
        PCOp = 2'b00; // Incrementa o PC normalmente
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0010; // Realiza operação ALU (dependendo do funct)
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b0; // Seleciona o registrador Rs como segundo operando da ALU
        RegWrite = 1'b1; // Escreve no registrador de destino
        isJAL = 1'b0; // Não é uma instrução jump-and-link
        isSigned = 1'b1; // A operação ALU é com sinal
      end

      // Instrução j (jump)
      6'b000010: begin
        RegDst = 2'b00; // Ignora o campo Rd
        PCOp = 2'b11; // Carrega o valor imediato no PC
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0000; // Ignora a operação ALU
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b0; // Ignora o segundo operando da ALU
        RegWrite = 1'b0; // Não escreve no registrador de destino
        isJAL = 1'b0; // Não é uma instrução jump-and-link
        isSigned = 1'b1; // Ignora o sinal da operação
      end

      // Instrução jal (jump and link)
      6'b000011: begin
        RegDst = 2'b10; // Destino é o registrador $ra (retorno)
        PCOp = 2'b11; // Carrega o valor imediato no PC
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0000; // Ignora a operação ALU
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b0; // Ignora o segundo operando da ALU
        RegWrite = 1'b1; // Escreve no registrador de destino
        isJAL = 1'b1; // É uma instrução jump-and-link
        isSigned = 1'b1; // Ignora o sinal da operação
      end

      // Instruções I-type (addi, slti, sltiu, andi, ori, xori, lui)
      6'b001000: begin
        RegDst = 2'b00; // Destino é o registrador especificado no campo Rt
        PCOp = 2'b00; // Incrementa o PC normalmente
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0000; // Realiza operação ALU (dependendo do opcode)
        MemWrite = 1'b0; // Não escreve na memória
		  end

        6'b001000: begin // Instrução addi
        RegDst = 2'b00; // Destino é o registrador especificado no campo Rt
        PCOp = 2'b00; // Incrementa o PC normalmente
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0000; // Realiza soma com sinal (addi)
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b1; // Seleciona o valor imediato como segundo operando da ALU
        RegWrite = 1'b1; // Escreve no registrador de destino
        isJAL = 1'b0; // Não é uma instrução jump-and-link
        isSigned = 1'b1; // A operação ALU é com sinal
      end

      6'b001010: begin // Instrução slti
        RegDst = 2'b00; // Destino é o registrador especificado no campo Rt
        PCOp = 2'b00; // Incrementa o PC normalmente
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0011; // Realiza comparação menor que com sinal (slti)
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b1; // Seleciona o valor imediato como segundo operando da ALU
        RegWrite = 1'b1; // Escreve no registrador de destino
        isJAL = 1'b0; // Não é uma instrução jump-and-link
        isSigned = 1'b1; // A operação ALU é com sinal
      end

      // ... (outros casos para instruções I-type, load, store, branch)

      default: begin // Opcode inválido
        RegDst = 2'b00; // Ignora o registrador de destino
        PCOp = 2'b00; // Mantém o PC inalterado
        MemRead = 1'b0; // Não lê da memória
        MemtoReg = 1'b0; // Não escreve na memória
        ALUOp = 4'b0000; // Ignora a operação ALU
        MemWrite = 1'b0; // Não escreve na memória
        ALUSrc = 1'b0; // Ignora o segundo operando da ALU
        RegWrite = 1'b0; // Não escreve no registrador de destino
        isJAL = 1'b0; // Não é uma instrução jump-and-link
        isSigned = 1'b1; // Ignora o sinal da operação
      end
    endcase
  end

endmodule
