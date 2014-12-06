module Hazard_Detection_Unit(
  input       [5:0]   Op_i,
  input       [4:0]   IFID_RsAddr_i,
  input       [4:0]   IFID_RtAddr_i,
  input       [4:0]   IDEX_RtAddr_i,
  input               IDEX_MemRead_i,
  output reg          PC_stall_o,
  output reg          IFID_stall_o,
  output reg          IDEX_stall_o
);

always @(*) begin
  if (IDEX_MemRead_i) begin
  //addi
    if (Op_i == 6'b001000 and IFID_RsAddr_i == IDEX_RtAddr_i) begin 
      PC_stall_o <= 1'b1;
      IFID_stall_o <= 1'b1;
      IDEX_stall_o <= 1'b1;
    end
  //beq or Rtype
    else if ((Op_i == 6'b000100 or Op_i == 6'b000000)and 
            (IFID_RsAddr_i == IDEX_RtAddr_i or IFID_RtAddr_i == IDEX_RtAddr_i)) begin
      PC_stall_o <= 1'b1;
      IFID_stall_o <= 1'b1;
      IDEX_stall_o <= 1'b1;
    end
    else begin
      PC_stall_o <= 1'b0;
      IFID_stall_o <= 1'b0;
      IDEX_stall_o <= 1'b0;
    end
  end
  else begin
      PC_stall_o <= 1'b0;
      IFID_stall_o <= 1'b0;
      IDEX_stall_o <= 1'b0;
  end
end
endmodule