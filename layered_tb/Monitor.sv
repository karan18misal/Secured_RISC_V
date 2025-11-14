class Monitor;
  virtual top_main_if vif;

  function new(virtual top_main_if vif);
    this.vif = vif;
  endfunction

  task observe();
    $display("==========================");
    $display("data_in         = %h", vif.data_in);
    $display("opcode          = %b", vif.opcode);
    $display("read_address    = %h", vif.read_address);
    $display("write_address   = %h", vif.write_address);
    $display("read_address_reg= %h", vif.read_address_reg);
    $display("write_address_reg= %h", vif.write_address_reg);
    $display("reg1            = %h", vif.reg1);
    $display("reg2            = %h", vif.reg2);
    $display("address_mem     = %h", vif.address_mem);
    $display("address_alu     = %h", vif.address_alu);
    $display("address_to_mem  = %h", vif.address_to_mem);
    $display("data_out_mem    = %h", vif.data_out_mem);
    $display("zero            = %b", vif.zero);
    $display("==========================");
  endtask

endclass
