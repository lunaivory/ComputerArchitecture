module MEM_WB(
  input             clk_i,
  input      [1:0]  WB_i,
  input      [31:0] MEM_data_i,
  input      [31:0] ALU_data_i,
  input      [5:0]  RegWriteAddr_i,
  output reg        RegWrite_o,
  output reg        MemToReg_o,
  output reg [31:0] Mem_data_o,
  output reg [31:0] ALU_data_o,
  output reg [5:0]  RegWriteAddr_o
);

reg [31:0] MEM_data, ALU_data;
reg [5:0] RegWriteAddr;
reg [1:0] WB;

always @(posedge clk_i) begin
	WB = WB_i;
	MEM_data = MEM_data_i;
	ALU_data = ALU_data_i;
	RegWriteAddr = RegWriteAddr_i;
end

always @(negedge clk_i) begin
	RegWrite = WB[1];
	MemToReg = WB[0];
	MEM_data_o = MEM_data;
	ALU_data_o = ALU_data;
	RegWriteAddr = RegWriteAddr_i;
end

endmodule
