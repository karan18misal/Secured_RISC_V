module processor(
    input clk,
    input reset,
    input [31:0] data_in,
    output [31:0] data_out_mem
);

  wire [31:0] pc;
  wire [31:0] pc_plus4;
  wire [31:0] instruction;
  wire alu_op_on;
  wire load_on;
  wire store_on;
  wire wenable;
  wire renable;
  wire wenable_reg;
  wire renable_reg;
  wire jump;
  wire branch;
  wire alu_src;

  wire [31:0] read_reg1;
  wire [31:0] read_reg2;
  wire [31:0] read_reg_i;
  wire [31:0] data_in_reg;
  wire [31:0] data_out_reg;
  wire [31:0] data_out_reg_go;
  wire key_access_reg;

  wire [31:0] data_out;
  wire key_access_mem;

  wire [4:0] reg1;
  wire [4:0] reg2;
  wire [4:0] address_mem;
  wire [4:0] address_alu;
  wire [4:0] address_to_mem;
  wire [4:0] read_address;
  wire [4:0] write_address;
  wire [4:0] read_address_reg;
  wire [4:0] write_address_reg;

  wire [31:0] alu_result;
  wire alu_zero;
  wire [3:0] alu_ctrl;

  wire [31:0] immediate;

  wire [31:0] alu_or_pc;

  program_counter pc_unit (
      .clk(clk),
      .rst(reset),
      .branch(branch),
      .jump(jump),
      .alu_zero(alu_zero),
      .immediate(immediate),
      .pc(pc),
      .pc_plus4(pc_plus4)
  );

  instruction_memory im (
      .pc(pc),
      .instruction(instruction)
  );

  control_unit cu (
      .instruction(instruction),
      .alu_op_on(alu_op_on),
      .load_on(load_on),
      .store_on(store_on),
      .wenable(wenable),
      .renable(renable),
      .wenable_reg(wenable_reg),
      .renable_reg(renable_reg),
      .jump(jump),
      .branch(branch),
      .alu_src(alu_src),
      .reg1(reg1),
      .reg2(reg2),
      .address_mem(address_mem),
      .address_alu(address_alu),
      .address_to_mem(address_to_mem),
      .read_address(read_address),
      .write_address(write_address),
      .read_address_reg(read_address_reg),
      .write_address_reg(write_address_reg),
      .alu_ctrl(alu_ctrl)
  );

  immediate_generator ig (
      .instruction(instruction),
      .read_reg2(read_reg2),
      .alu_src(alu_src),
      .read_reg_i(read_reg_i)
  );

  registers rf (
      .clk(clk),
      .reg1(reg1),
      .reg2(reg2),
      .address_mem(address_mem),
      .address_alu(address_alu),
      .address_to_mem(address_to_mem),
      .write_data_mem(data_out_reg),
      .write_data_alu(alu_or_pc),
      .alu_op_on(alu_op_on),
      .load_on(load_on),
      .store_on(store_on),
      .read_reg1(read_reg1),
      .read_reg2(read_reg2),
      .memory_out(data_in_reg),
      .key_access(key_access_reg)
  );

  security sec (
      .data_in_memory(data_out_reg_go),
      .data_in_reg(data_in_reg),
      .key_access_mem(key_access_mem),
      .key_access_reg(key_access_reg),
      .read_address(read_address),
      .write_address(write_address),
      .data_out_mem(data_out_mem),
      .data_out_reg(data_out_reg)
  );

  memory mem (
      .clk(clk),
      .data_in(data_in),
      .read_address(read_address),
      .write_address(write_address),
      .data_in_reg(data_out_mem),
      .read_address_reg(read_address_reg),
      .write_address_reg(write_address_reg),
      .wenable(wenable),
      .renable(renable),
      .wenable_reg(wenable_reg),
      .renable_reg(renable_reg),
      .data_out(data_out),
      .data_out_reg(data_out_reg_go),
      .key_access(key_access_mem)
  );
  
  alu alu_unit (
      .a(read_reg1),
      .b(read_reg_i),
      .alu_ctrl(alu_ctrl),
      .result(alu_result),
      .zero(alu_zero)
  );
  
  assign alu_or_pc = jump ? pc_plus4 : alu_result;

endmodule
