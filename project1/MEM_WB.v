//TODO
module MEM_WB(
  input         clk_i,
  input     [1:0]   WB_i,
  input     [31:0] MEM_data_i,
  input     [31:0] ALU_data_i,
  input     [5:0]  RegWriteAddr_i,
  output reg       RegWrite_o,
  output reg       MemToReg_o,
  output reg [31:0] Mem_data_o,
  output reg [31:0] ALU_data_o,
  output reg [5:0]  RegWriteAddr_o
);

endmodule