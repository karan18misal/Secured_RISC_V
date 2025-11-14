class Generator;

  rand bit [31:0] data_in;
  rand bit [4:0] opcode;
  rand bit [7:0] read_address, write_address;
  rand bit [7:0] read_address_reg, write_address_reg;
  rand bit [7:0] reg1, reg2;
  rand bit [7:0] address_mem, address_alu, address_to_mem;


  constraint opcode_range {
    opcode >= 5'd0;
    opcode <= 5'd9;
  }

  constraint address_valid {
    read_address != write_address;
    read_address_reg != write_address;
    read_address != write_address_reg;
    read_address_reg != write_address_reg;

    reg1 != address_mem;
    reg2 != address_mem;
    address_to_mem != address_mem;
    reg1 != address_alu;
    reg2 != address_alu;
    address_to_mem != address_alu;

    read_address       inside {[8'd00:8'd10]};
    write_address      inside {[8'd00:8'd10]};
    read_address_reg   inside {[8'd00:8'd10]};
    write_address_reg  inside {[8'd00:8'd10]};
    reg1               inside {[8'd00:8'd10]};
    reg2               inside {[8'd00:8'd10]};
    address_mem        inside {[8'd00:8'd10]};
    address_alu        inside {[8'd00:8'd10]};
    address_to_mem     inside {[8'd00:8'd10]};


  }
  function new();
    assert(this.randomize()) else $fatal("Randomization failed");
  endfunction

endclass
