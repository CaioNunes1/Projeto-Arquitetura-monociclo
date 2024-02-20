module jump(
    input wire [3:0] next_pc,
    input wire [25:0] address,
    output wire [31:0] new_pc
);

    assign new_pc = {{27'b0}, next_pc, address};

endmodule