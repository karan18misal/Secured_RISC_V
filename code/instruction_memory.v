module instruction_memory (
    input [31:0] pc,
    output [31:0] instruction
);
    reg [31:0] memory [0:1023];
    integer i;
    initial begin
        memory[0]  = 32'h00A00093; // addi x1, x0, 10
        memory[1]  = 32'h00500113; // addi x2, x0, 5
        memory[2]  = 32'h002081B3; // add x3, x1, x2
        memory[3]  = 32'h40208233; // sub x4, x1, x2
        memory[4]  = 32'h00302023; // sw x3, 0(x0)
        memory[5]  = 32'h00002283; // lw x5, 0(x0)
        memory[6]  = 32'h00108463; // beq x1, x1, 8
        memory[7]  = 32'h06300313; // addi x6, x0, 99
        memory[8]  = 32'h008003EF; // jal x7, 8
        memory[9]  = 32'h05800413; // addi x8, x0, 88
        memory[10] = 32'h04D00493; // addi x9, x0, 77

        for (i = 11; i < 1024; i = i + 1) begin
            memory[i] = 32'h00000013;
        end
    end

    wire [9:0] word_addr = pc[11:2];

    assign instruction = memory[word_addr];

endmodule
