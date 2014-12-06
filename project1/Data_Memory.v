module Data_Memory(
  input             clk_i,
  input      [31:0] addr_i,
  input      [31:0] write_data_i,
  input             MemRead_i,
  input             MemWrite_i,
  output reg [31:0] data_o
);

reg [7:0] memory [0:31];

always @(posedge clk_i) begin
	if(MemRead_i) begin
		data_o <= (memory[addr_i] + (memory[addr_i+1] << 1) +
					(memory[addr_i+2] << 2) + (memory[addr_i+3] << 2));
	end
end

always @(negedge clk_i) begin
	if(MemWrite_i) begin
		memory[addr_i+0] = write_data_i[7:0];
		memory[addr_i+1] = write_data_i[15:8];
		memory[addr_i+2] = write_data_i[23:16];
		memory[addr_i+3] = write_data_i[31:24];
	end
end

endmodule
