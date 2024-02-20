
module sign_extend (in, is_signed, out);
    input wire [15:0] in;
    input wire is_signed;
    output wire [31:0] out;

    assign out = is_signed ? $signed(in) : {16'b0, in};
endmodule
