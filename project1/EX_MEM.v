module EX_MEM(
    input             clk_i,
    input      [1:0]  WB_i,
    input      [1:0]  MEM_i,
    input      [31:0] ALUout_i,
    input      [31:0] MemWriteData_i,
    input      [5:0]  RegWriteAddr_i,
    output reg [31:0] ALUout_o,
    output reg [31:0] MemWriteData_o,
    output reg [5:0]  RegWriteAddr_o,
    output reg [1:0]  WB_o,
    output reg        MemWrite_o,
    output reg        MemRead_o
);

reg [31:0] ALUout, MemWriteData;
reg [5:0] RegWriteAddr;
reg [1:0] WB, MEM;

always @(posedge clk_i) begin
	ALUout <= ALUout_i;
	MemwriteData <= MemwriteData_i;
	RegWriteAddr <= RegWriteAddr_i;
	WB <= WB_i;
	MEM <= MEM_i;
end

always @(negedge clk_i) begin
	ALUout_o <= ALUout;
	MemwriteData_o <= MemwriteData;
	RegWriteAddr_o <= RegWriteAddr;
	WB_o <= WB;
	MemWrite_o <= MEM_i[1];
	MemRead_o <= MEM_i[0];
end

endmodule
