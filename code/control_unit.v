module control_unit(
    input [31:0]instruction,
    output reg alu_op_on,
    output reg load_on,
    output reg store_on,
    output reg wenable,
    output reg renable,
    output reg wenable_reg,
    output reg renable_reg,
    output reg jump,
    output reg branch,
    output reg alu_src,
    output reg [4:0] reg1,
    output reg [4:0] reg2,
    output reg [4:0] address_mem,
    output reg [4:0] address_alu,
    output reg [4:0] address_to_mem,
    output reg [9:0] read_address,
    output reg [9:0] write_address,
    output reg [9:0] read_address_reg,
    output reg [9:0] write_address_reg,
    output reg [3:0] alu_ctrl
);

    parameter R_TYPE = 7'b0110011;
    parameter I_TYPE = 7'b0010011;
    parameter LOAD   = 7'b0000011;
    parameter STORE  = 7'b0100011;
    parameter BRANCH = 7'b1100011;
    parameter JAL    = 7'b1101111;

    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd     = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1    = instruction[19:15];
    wire [4:0] rs2    = instruction[24:20];
    wire [6:0] funct7 = instruction[31:25];

    always @(*) begin
        alu_op_on       = 1'b0;
        load_on         = 1'b0;
        store_on        = 1'b0;
        wenable         = 1'b0;
        renable         = 1'b0;
        wenable_reg     = 1'b0;
        renable_reg     = 1'b0;
        jump            = 1'b0;
        branch          = 1'b0;
        alu_src         = 1'b0;
        reg1            = 5'b0;
        reg2            = 5'b0;
        address_mem     = 5'b0;
        address_alu     = 5'b0;
        address_to_mem  = 5'b0;
        read_address    = 10'b0;
        write_address   = 10'b0;
        read_address_reg  = 10'b0;
        write_address_reg = 10'b0;
        alu_ctrl        = 4'b0000;

        case (opcode)
            R_TYPE: begin
                alu_op_on   = 1'b1;
                alu_src     = 1'b0;
                reg1        = rs1;
                reg2        = rs2;
                address_alu = rd;
                wenable_reg = 1'b1;

                if (funct3 == 3'b000) begin
                    if (funct7 == 7'b0000000)
                        alu_ctrl = 4'b0000; // ADD
                    else if (funct7 == 7'b0100000)
                        alu_ctrl = 4'b0001; // SUB
                end
            end

            I_TYPE: begin
                alu_op_on   = 1'b1;
                alu_src     = 1'b1;
                reg1        = rs1;
                address_alu = rd;
                wenable_reg = 1'b1;

                if (funct3 == 3'b000)
                    alu_ctrl = 4'b0000;
            end

            BRANCH: begin
                branch   = 1'b1;
                alu_src = 1'b0;
                reg1    = rs1;
                reg2    = rs2;
                alu_ctrl = 4'b0001;
            end

            JAL: begin
                jump        = 1'b1;
                load_on    = 1'b1;
                address_alu = rd;
                wenable_reg = 1'b1;
            end
        endcase
    end
endmodule
