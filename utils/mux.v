module mux_32 (
    input wire [31:0] in1, in2,
    input wire sel,
    output wire [31:0] out
);
    assign out = sel ? in2 : in1;
endmodule

// Módulo mux_32_4
module mux_32_4 (
    input wire [31:0] in1, in2, in3, in4,
    input wire [1:0] sel,
    output wire [31:0] out
);
    assign out = (sel[1] == 1'b1) ? ((sel[0] == 1'b1) ? in4 : in3) : ((sel[0] == 1'b1) ? in2 : in1);
endmodule

// Módulo mux_src
module mux_src (
    input wire ALUsrc,
    input wire [31:0] ReadData2, SignExtended32,
    output reg [31:0] ALUin2
);
    always @(*) begin
        case (ALUsrc)
            1'b0: ALUin2 = ReadData2;
            1'b1: ALUin2 = SignExtended32;
        endcase
    end
endmodule

// Módulo mux_5_4
module mux_5_4 (
    input wire [4:0] inst0, inst1, inst2, inst3,
    input wire [1:0] RegDst,
    output wire [4:0] imem_mux_to_write_register
);
    assign imem_mux_to_write_register = (RegDst[1] == 1'b1) ? ((RegDst[0] == 1'b1) ? inst3 : inst2) : ((RegDst[0] == 1'b1) ? inst1 : inst0);
endmodule