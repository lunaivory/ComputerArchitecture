module EX_MEM(
  input             clk_i,
  input      [1:0]  WB_i,
  input      [1:0]  MEM_i,
  input      [31:0] ALUout_i,
  input      [31:0] MemWriteData_i,
  input      [4:0]  RegWriteAddr_i,
  input	            CacheStall_i,
  output reg [31:0] ALUout_o,
  output reg [31:0] MemWriteData_o,
  output reg [4:0]  RegWriteAddr_o,
  output reg [1:0]  WB_o,
  output reg        MemWrite_o,
  output reg        MemRead_o
);

reg [31:0] ALUout, MemWriteData;
reg [4:0] RegWriteAddr;
reg [1:0] WB, MEM;

always @(posedge clk_i) begin
	ALUout <= ALUout_i;
	MemWriteData <= MemWriteData_i;
	RegWriteAddr <= RegWriteAddr_i;
	WB <= WB_i;
	MEM <= MEM_i;
end

always @(negedge clk_i) begin
	ALUout_o <= ALUout;
	MemWriteData_o <= MemWriteData;
	RegWriteAddr_o <= RegWriteAddr;
	WB_o <= WB;
	MemWrite_o <= MEM[0];
	MemRead_o <= MEM[1];
end

endmodule
