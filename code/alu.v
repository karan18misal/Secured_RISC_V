module alu (
    input [31:0] a, // First operand
    input [31:0] b, // Second operand
    input [3:0] alu_ctrl, // ALU control signal
    output reg [31:0] result, // ALU result
    output zero // Zero flag for branch instructions
);
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter AND = 4'b0010;
    parameter OR = 4'b0011;
    parameter XOR = 4'b0100;
    parameter SLT = 4'b0101; // Set less than
    parameter SLTU = 4'b0110; // Set less than unsigned
    
    always @(*) begin
        case (alu_ctrl)
            ADD: result = a + b;
            SUB: result = a - b;
            AND: result = a & b;
            OR: result = a | b;
            XOR: result = a ^ b;
            SLT: result = ($signed(a) < $signed(b)) ? 32'h1 : 32'h0;
            SLTU: result = (a < b) ? 32'h1 : 32'h0;
            default: result = 32'h0;
        endcase
    end
    
    assign zero = (result == 32'h0);
    
endmodule
