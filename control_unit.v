module control_unit(
    input [4:0] opcode,
    output reg [3:0] alu_ctrl,
    output reg wenable,
    output reg renable,
    output reg wenable_reg,
    output reg renable_reg,
    output reg wenable_mem,
    output reg renable_mem,
    output reg wenable_alu,
    output reg renable_alu
);

    parameter IDLE         = 5'b00000;
    parameter LOAD_STORE   = 5'b00001;
    parameter memory_access= 5'b00010;
    parameter ADD          = 5'b00011;
    parameter SUB          = 5'b00100;
    parameter AND          = 5'b00101;
    parameter OR           = 5'b00110;
    parameter XOR          = 5'b00111;
    parameter SLT          = 5'b01000;
    parameter SLTU         = 5'b01001;

    always @(*) begin
        case(opcode)
            IDLE: begin
                alu_ctrl = 4'b1111;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 0; renable_alu = 0;
            end
            LOAD_STORE: begin
                alu_ctrl = 4'b1111;
                wenable = 0; renable = 0;
                wenable_reg = 1; renable_reg = 1;
                wenable_mem = 1; renable_mem = 1;
                wenable_alu = 0; renable_alu = 0;
            end
            memory_access: begin
                alu_ctrl = 4'b1111;
                wenable = 1; renable = 1;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 0; renable_alu = 0;
            end
            ADD: begin
                alu_ctrl = 4'b0000;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            SUB: begin
                alu_ctrl = 4'b0001;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            AND: begin
                alu_ctrl = 4'b0010;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            OR: begin
                alu_ctrl = 4'b0011;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            XOR: begin
                alu_ctrl = 4'b0100;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            SLT: begin
                alu_ctrl = 4'b0101;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            SLTU: begin
                alu_ctrl = 4'b0110;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 1; renable_alu = 1;
            end
            default: begin
                alu_ctrl = 4'b1111;
                wenable = 0; renable = 0;
                wenable_reg = 0; renable_reg = 0;
                wenable_mem = 0; renable_mem = 0;
                wenable_alu = 0; renable_alu = 0;
            end
        endcase
    end
endmodule

