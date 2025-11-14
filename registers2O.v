module registers(
    input clk,
    input [9:0] reg1,
    input [9:0] reg2,
    input [9:0] address_mem,
    input [9:0] address_alu,
    input [9:0] address_to_mem,
    input [31:0] write_data_mem,
    input [31:0] write_data_alu,
    output reg [31:0] read_reg1,
    output reg [31:0] read_reg2,
    output reg [31:0] memory_out,
    output [15:0] key_access
);

    reg [31:0] memory [1023:0];
    initial begin
  memory[0]  = 32'h00000000; // value = 0
  memory[1]  = 32'h00000001; // value = 1
  memory[2]  = 32'h00000002; // value = 2
  memory[3]  = 32'h00000003; // value = 3
  memory[4]  = 32'h00000004; // value = 4
  memory[5]  = 32'h00000005; // value = 5
  memory[6]  = 32'h00000006; // value = 6
  memory[7]  = 32'h00000007; // value = 7
  memory[8]  = 32'h00000008; // value = 8
  memory[9]  = 32'h00000009; // value = 9
  memory[10] = 32'h0000000A; // value = 10
end


    always @(posedge clk) begin
            memory[address_mem] <= write_data_mem;
            memory[address_alu] <= write_data_alu;
            read_reg1 <= memory[reg1];
            read_reg2 <= memory[reg2];
            memory_out <= memory[address_to_mem];
    end

    assign key_access = 16'h0032;

endmodule
