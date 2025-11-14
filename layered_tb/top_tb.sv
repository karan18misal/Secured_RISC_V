`include "Interface.sv"
`include "Driver.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

module top_main_tb;

  bit clk;
  top_main_if tb_if(clk);

  top_main uut (
    .clk(tb_if.clk),
    .data_in(tb_if.data_in),
    .opcode(tb_if.opcode),
    .read_address(tb_if.read_address),
    .write_address(tb_if.write_address),
    .read_address_reg(tb_if.read_address_reg),
    .write_address_reg(tb_if.write_address_reg),
    .reg1(tb_if.reg1),
    .reg2(tb_if.reg2),
    .address_mem(tb_if.address_mem),
    .address_alu(tb_if.address_alu),
    .address_to_mem(tb_if.address_to_mem),
    .data_out_mem(tb_if.data_out_mem),
    .zero(tb_if.zero)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  Driver drv;
  Monitor mon;
  scoreboard sb;

  initial begin
    drv = new(tb_if);
    mon = new(tb_if);
    sb  = new(tb_if, uut.m0, uut.r0, uut.a0);

    repeat (10) begin
      drv.drive();
      #10;
      mon.observe();
      sb.check_all_opcodes();
    end

    $finish;
  end

endmodule
