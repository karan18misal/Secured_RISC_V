module immediate_generator (
    input [31:0] instruction, // 32-bit instruction
    output reg [31:0] immediate // Sign-extended immediate
);

    wire [6:0] opcode = instruction[6:0];
    
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
