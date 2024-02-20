
module add32 (
    input wire [31:0] in1, in2,
    output wire [31:0] out
);
    assign out = in1 + in2;
endmodule

// Módulo Adder
module Adder (
    input wire [31:0] pc,
    output wire [31:0] pc_increment
);
    // Declaração do 4 para somar ao pc
    reg [31:0] four = 32'h00000004;

    // Atribuição da soma do pc
    assign pc_increment = four + pc;
endmodule