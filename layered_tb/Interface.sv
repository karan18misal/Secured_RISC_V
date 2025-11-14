interface top_main_if(input bit clk);
  bit [31:0] data_in;
  bit [4:0] opcode;
  bit [7:0] read_address, write_address;
  bit [7:0] read_address_reg, write_address_reg;
  bit [7:0] reg1, reg2;
  bit [7:0] address_mem, address_alu, address_to_mem;
  bit [31:0] data_out_mem;
  bit zero;
endinterface
