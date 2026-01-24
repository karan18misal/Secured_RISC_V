module processor(
  input clk,
  input reset,
  input [31:0]data_in,
  output [31:0] data_out_mem
);
  
  program_counter pc_unit(
              .clk(clk),
              .rst(rst),
              .branch(branch),
              .jump(jump),
              .alu_zero(alu_zero),
              .immediate(immediate),
              .pc(pc),
              .pc_plus4(pc_plus4)
  );

  instruction_memory im(
              .pc(pc),
              .instruction(instruction)
  );
  control_unit cu(
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
  immediate_generator ig(
              .instruction(instruction),
              .read_reg2(read_reg2),
              .alu_src(alu_src),
              .read_reg_i(read_reg_i)
  );



  
endmodule
