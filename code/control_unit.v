module control_unit(
    input [31:0]instruction; 
    output alu_op_on;
    output load_on;
    output store_on;
    output wenable,
    output renable,
    output wenable_reg,
    output renable_reg,
    output jump,
    output branch,
    output alu_src,
    output [4:0] reg1,
    output [4:0] reg2,
    output [4:0] address_mem,
    output [4:0] address_alu,
    output [4:0] address_to_mem,
    output [9:0] read_address,
    output [9:0] write_address,
    output [9:0] read_address_reg,
    output [9:0] write_address_reg,
    output [3:0] alu_ctrl
);
    parameter R_TYPE = 7'b0110011; // add, sub
    parameter I_TYPE = 7'b0010011; // addi
    parameter LOAD = 7'b0000011; // lw
    parameter STORE = 7'b0100011; // sw
    parameter BRANCH = 7'b1100011; // beq
    parameter JAL = 7'b1101111; // jal
    
    wire [6:0] opcode = instruction[6:0];
    wire [4:0] rd = instruction[11:7];
    wire [2:0] funct3 = instruction[14:12];
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    wire [6:0] funct7 = instruction[31:25];
    
    always @(*) begin
        case (opcode)
            R_TYPE: begin
                alu_src = 1'b0;
                alu_op_on = 1'b1;
                address_alu <= rd;
                reg1 <= rs1;
                reg2 <= rs2;
                if (funct3 == 3'b000) begin
                        if (funct7 == 7'b0000000)
                            alu_ctrl = 4'b0000;
                        else if (funct7 == 7'b0100000)
                            alu_ctrl = 4'b0001;
                    end
            end
            
            I_TYPE: begin
                    reg1 <= rs1;
                    alu_op_on = 1'b1;
                    alu_src = 1'b1;
                    if (funct3 == 3'b000)
                        alu_ctrl = 4'b0000;
                end
            
            BRANCH: begin 
                    branch = 1'b1;
                    alu_src = 1'b0;
                    alu_ctrl = 4'b0001;
                end
            JAL: begin
                    load_on = 1'b1;
                    jump = 1'b1;
                end
        endcase
    end
endmodule
