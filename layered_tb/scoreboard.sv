class scoreboard;
  virtual top_main_if vif;
  memory m0;
  registers r0;
  alu a0;

  function new(virtual top_main_if vif, memory m0, registers r0, alu a0);
    this.vif = vif;
    this.m0 = m0;
    this.r0 = r0;
    this.a0 = a0;
  endfunction

  task check_all_opcodes();
    bit pass = 1;
    bit [31:0] expected;

    case (vif.opcode)
      5'b00011: begin
        expected = r0.memory[vif.reg1] + r0.memory[vif.reg2];
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b00100: begin
        expected = r0.memory[vif.reg1] - r0.memory[vif.reg2];
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b00101: begin
        expected = r0.memory[vif.reg1] & r0.memory[vif.reg2];
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b00110: begin
        expected = r0.memory[vif.reg1] | r0.memory[vif.reg2];
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b00111: begin
        expected = r0.memory[vif.reg1] ^ r0.memory[vif.reg2];
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b01000: begin
        expected = ($signed(r0.memory[vif.reg1]) < $signed(r0.memory[vif.reg2])) ? 32'h1 : 32'h0;
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      5'b01001: begin
        expected = (r0.memory[vif.reg1] < r0.memory[vif.reg2]) ? 32'h1 : 32'h0;
        if (r0.memory[vif.address_alu] !== expected)
          pass = 0;
      end

      default: pass = 0;
    endcase

    if (pass)
      $display("Opcode %b check passed", vif.opcode);
    else
      $display("Opcode %b check failed", vif.opcode);
  endtask
endclass
