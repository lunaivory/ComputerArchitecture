//TODO
module ID_EX(
  input             clk_i,
  input      [1:0]  WB_i,
  input      [1:0]  MEM_i,
  input      [3:0]  EX_i,
  input      [31:0] Reg_data1_i,
  input      [31:0] Reg_data2_i,
  input      [5:0]  RsAddr_FW_i,
  input      [5:0]  RtAddr_FW_i,
  input      [5:0]  RtAddr_WB_i,
  input      [5:0]  RdAddr_WB_i,
  input      [31:0] immd_i,
  output reg [1:0]  WB_o,
  output reg [1:0]  MEM_o,
  output reg [31:0] Reg_data1_o,
  output reg [31:0] Reg_data2_o,
  output reg [31:0] immd_o,
  output reg        ALU_Src_o,
  output reg [1:0]  ALU_OP_o,
  output reg        Reg_Dst_o,
  output reg [5:0]  RsAddr_FW_o,
  output reg [5:0]  RtAddr_FW_o,
  output reg [5:0]  RtAddr_WB_o,
  output reg [5:0]  RdAddr_WB_o 
);
endmodule