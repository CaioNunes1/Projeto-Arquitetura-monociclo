module ula_control(ula_operation, func, operation);
    input wire [3:0] ula_operation;
    input wire [5:0] func;
    output reg [3:0] operation;

    always @(*) begin
        if (ula_operation == 4'b0000) begin
            operation <= 4'b0010; // LW, SW => ADD
        end else if (ula_operation == 4'b0001) begin
            operation <= 4'b0110; // Branch => SUB
        end else if (ula_operation == 4'b0010) begin // R-type 
            case (func)
                6'b000100: operation <= 4'b1110; //SLLV
                6'b000110: operation <= 4'b1111; //SRLV
                6'b000111: operation <= 4'b1010; //SRAV
                6'b000011: operation <= 4'b0100; //SRA
                6'b000010: operation <= 4'b0101; //SRL
                6'b000000: operation <= 4'b0011; //SLL
                6'b100000: operation <= 4'b0010; //add
                6'b100010: operation <= 4'b0110; //sub
                6'b100100: operation <= 4'b0000; //and
                6'b100101: operation <= 4'b0001; //or
                6'b100110: operation <= 4'b1101; //xor
                6'b100111: operation <= 4'b1100; //nor
                6'b101010: operation <= 4'b0111; //SLT
                6'b101011: operation <= 4'b0111; //SLTU
                default: operation <= 4'b0000; //default  AND
            endcase
        end else if (ula_operation == 4'b0011) begin
            operation <= 4'b0111; // slti
        end else if (ula_operation == 4'b1000) begin
            operation <= 4'b1000; // sltiu
        end else if (ula_operation == 4'b0100) begin
            operation <= 4'b0000; // andi
        end else if (ula_operation == 4'b0101) begin
            operation <= 4'b0001; // ori
        end else if (ula_operation == 4'b0110) begin
            operation <= 4'b1101; // xori
        end else if (ula_operation == 4'b0111) begin
            operation <= 4'b1011; // lui
        end else begin
            operation <= 4'b0000; // default AND
        end
    end
endmodule