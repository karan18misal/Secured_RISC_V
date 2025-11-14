module memory(
    input clk,
    input [31:0] data_in,
    input [9:0] read_address,
    input [9:0] write_address,
    input [31:0] data_in_reg,
    input [9:0] read_address_reg,
    input [9:0] write_address_reg,
    input wenable,
    input renable,
    input wenable_reg,
    input renable_reg,
    output reg [31:0] data_out,
    output reg [31:0] data_out_reg,
    output [15:0] key_access
);

	reg [31:0] memory [1023:0];

    assign key_access = 16'h0032;

    always @(posedge clk) begin
	if(wenable)
		memory[write_address] <= data_in;
	if(renable)
		data_out <= memory[read_address];
	if(wenable_reg)
		memory[write_address_reg] <= data_in_reg;
	if(renable_reg)		
		data_out_reg <= memory[read_address_reg];
    end

    

endmodule
