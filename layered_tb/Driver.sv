`include "Generator.sv"
class Driver;
  virtual top_main_if vif;

  function new(virtual top_main_if vif);
    this.vif = vif;
  endfunction
Generator gen1;

  task drive();
    Generator gen = new();
    vif.data_in         <= gen.data_in;
    vif.opcode          <= gen.opcode;
    vif.read_address    <= gen.read_address;
    vif.write_address   <= gen.write_address;
    vif.read_address_reg <= gen.read_address_reg;
    vif.write_address_reg <= gen.write_address_reg;
    vif.reg1            <= gen.reg1;
    vif.reg2            <= gen.reg2;
    vif.address_mem     <= gen.address_mem;
    vif.address_alu     <= gen.address_alu;
    vif.address_to_mem  <= gen.address_to_mem;
  endtask
endclass
