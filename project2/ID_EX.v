module ID_EX(
  input             clk_i,
  input      [1:0]  WB_i,
  input      [1:0]  MEM_i,
  input      [3:0]  EX_i,
  input      [31:0] Reg_data1_i,
  input      [31:0] Reg_data2_i,
  input      [4:0]  RsAddr_FW_i,
  input      [4:0]  RtAddr_FW_i,
  input      [4:0]  RtAddr_WB_i,
  input      [4:0]  RdAddr_WB_i,
  input      [31:0] immd_i,
  input 			CacheStall_i,
  output reg [1:0]  WB_o,
  output reg [1:0]  MEM_o,
  output reg [31:0] Reg_data1_o,
  output reg [31:0] Reg_data2_o,
  output reg [31:0] immd_o,
  output reg        ALU_Src_o,
  output reg [1:0]  ALU_OP_o,
  output reg        Reg_Dst_o,
  output reg [4:0]  RsAddr_FW_o,
  output reg [4:0]  RtAddr_FW_o,
  output reg [4:0]  RtAddr_WB_o,
  output reg [4:0]  RdAddr_WB_o 
);

reg [31:0] ALUout, MemWriteData, immd;
reg [31:0] Reg_data1, Reg_data2;
reg [4:0] RsAddr_FW, RtAddr_FW, RtAddr_WB, RdAddr_WB;
reg [3:0] EX;
reg [1:0] WB, MEM;


always @(posedge clk_i) begin
	Reg_data1 <= Reg_data1_i;
	Reg_data2 <= Reg_data2_i;
	immd <= immd_i;
	RsAddr_FW <= RsAddr_FW_i;
	RtAddr_FW <= RtAddr_FW_i;
	RtAddr_WB <= RtAddr_WB_i;
	RdAddr_WB <= RdAddr_WB_i;
	EX <= EX_i;
	WB <= WB_i;
	MEM <= MEM_i;
end

always @(negedge clk_i) begin
	ALU_Src_o <= EX[3];
	ALU_OP_o <= EX[2:1];
	Reg_Dst_o <= EX[0];

	Reg_data1_o <= Reg_data1;
	Reg_data2_o <= Reg_data2;
	immd_o <= immd;
	RsAddr_FW_o <= RsAddr_FW;
	RtAddr_FW_o <= RtAddr_FW;
	RtAddr_WB_o <= RtAddr_WB;
	RdAddr_WB_o <= RdAddr_WB;
	WB_o <= WB;
	MEM_o <= MEM;
end

endmodule
