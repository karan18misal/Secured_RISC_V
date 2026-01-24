module program_counter (
    input  clk,
    input  rst,

    input  branch,
    input  jump,
    input  alu_zero,
    input  [31:0] immediate,

    output reg [31:0] pc,
    output     [31:0] pc_plus4
);

    wire [31:0] pc_next;
    wire [31:0] pc_branch;
    wire [31:0] pc_jump;
    wire pc_src;

    assign pc_plus4  = pc + 4;
    assign pc_branch = pc + immediate;
    assign pc_jump   = pc + immediate;

    assign pc_src = (branch & alu_zero) | jump;

    assign pc_next = pc_src ? (jump ? pc_jump : pc_branch)
                             : pc_plus4;

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'h0;
        else
            pc <= pc_next;
    end

endmodule
