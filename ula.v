module ula(In1, In2, OP, shamt, result, Zero_flag);
	input wire [31:0] In1, In2;
	input wire [3:0] OP;
	input wire [4:0] shamt;
	output wire [31:0] result;
	output wire Zero_flag;

	reg [31:0] ula_result;
	assign result = ula_result;

	// TODO: Add Overflow and Carry flags
	always @(*) begin
		case (OP)
			4'b0000: ula_result <= In1 & In2; //0000: AND
			4'b0001: ula_result <= In1 | In2; //0001: OR
			4'b0010: ula_result <= In1 + In2; //0010: ADD
			4'b0011: ula_result <= In2 << shamt; //0011: Shift left (SLL)
			4'b0100: ula_result <= $signed($signed(In2) >>> shamt); //0100: Shift right arithmetic (SRA)
			4'b0101: ula_result <= In2 >> shamt; //0101: Shift right logical (SRL)
			4'b0110: ula_result <= In1 - In2; //0110: SUB
			4'b0111: ula_result <= ($signed(In1) < $signed(In2)) ? 32'd1 : 32'd0; //0111: SLT
			4'b1000: ula_result <= In1 < In2 ? 32'd1 : 32'd0; //1000: SLTU
			4'b1011: ula_result <= {In2[15:0], 16'h0000}; //1011: LUI
			4'b1100: ula_result <= ~ (In1 | In2); //1100: NOR
			4'b1101: ula_result <= In1 ^ In2; //1101: XOR
			4'b1110: ula_result <= In2 << In1; //1110: SLLV
			4'b1111: ula_result <= In2 >> In1; //1111: SRLV
			4'b1010: ula_result <= $signed($signed(In2) >>> $signed(In1)); //1010: Shift right arithmetic (SRAV)
			default: ula_result <= In1 + In2; //defaults to AND
		endcase
	end

	assign Zero_flag = (result == 0) ? 1'b1 : 1'b0;

endmodule