module jr_control(opcode, func, ReadData1, JR_control);

    //declarar entradas e saídas
    input wire [31:0] ReadData1;
    input wire [2:0] opcode;
    input wire [5:0] func;
    output wire [31:0] JR_control;

    assign JR_control = ({opcode, func} == 9'b000001000) ? ReadData1 : 32'bz;

endmodule