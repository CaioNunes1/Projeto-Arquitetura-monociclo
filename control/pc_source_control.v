module PCControl (
    input wire [1:0] PCSource,
    input wire ZeroFlag,
    output reg [1:0] Source
);
    always @(*) begin
        case (PCSource)
            2'b00: Source <= 2'b00; // Incremento padrão (PC + 4)
            2'b01: Source <= {1'b0, ZeroFlag}; // BEQ (Branch se igual)
            2'b10: Source <= {1'b0, !ZeroFlag}; // BNE (Branch se diferente)
            2'b11: Source <= 2'b10; // Jumps J e JAL (PC Sourcing)
        endcase
    end
endmodule