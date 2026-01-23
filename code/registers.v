module registers(
    input clk,
    input [4:0] reg1,
    input [4:0] reg2,
    input [4:0] address_mem,
    input [4:0] address_alu,
    input [4:0] address_to_mem,
    input [31:0] write_data_mem,
    input [31:0] write_data_alu,
    output reg [31:0] read_reg1,
    output reg [31:0] read_reg2,
    output reg [31:0] memory_out,
    output [15:0] key_access
);

    reg [31:0] memory [31:0];
    


    always @(posedge clk) begin
            memory[address_mem] <= write_data_mem;
            memory[address_alu] <= write_data_alu;
            read_reg1 <= memory[reg1];
            read_reg2 <= memory[reg2];
            memory_out <= memory[address_to_mem];
    end

    assign key_access = 16'h0032;

endmodule
