module immediate_generator (
    input [31:0] instruction,
    input [31:0]read_reg2,
    input alu_src,
    output [31:0] read_reg_i
);

    wire [6:0] opcode = instruction[6:0];
    wire [31:0]immediate;
    assign read_reg_i = alu_src ? immediate : read_reg2;
    always @(*) begin
        case (opcode)
            7'b0010011: begin // I-type (addi)
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            end
            
            7'b0000011: begin // I-type (lw)
                immediate = {{20{instruction[31]}}, instruction[31:20]};
            end
            
            7'b0100011: begin // S-type (sw)
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end
            
            7'b1100011: begin // B-type (beq)
                immediate = {{19{instruction[31]}}, instruction[31], instruction[7], 
                           instruction[30:25], instruction[11:8], 1'b0};
            end
            
            7'b1101111: begin // J-type (jal)
                immediate = {{11{instruction[31]}}, instruction[31], instruction[19:12], 
                           instruction[20], instruction[30:21], 1'b0};
            end
            
            default: begin
                immediate = 32'h0;
            end
        endcase
    end
    
endmodule
