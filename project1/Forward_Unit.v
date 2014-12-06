module Forward_Unit(
  input  	        EXMEM_WB_i,//RegWrite FROM WB[1]
  input  	        MEMWB_WB_i,////RegWrite FROM WB[1]
  input  	 [5:0]  IDEX_RsAddr_i,
  input  	 [5:0]  IDEX_RtAddr_i,
  input  	 [5:0]  EXMEM_WriteAddr_i,
  input  	 [5:0]  MEMWB_WriteAddr_i,
  output reg [1:0]  mux6_o,
  output reg [1:0]	mux7_o
);

always @(*) begin
  if (EXMEM_WB_i and EXMEM_WriteAddr_i != 0) begin
    if(EXMEM_WriteAddr_i == IDEX_RsAddr_i)  mux6_o <= 2'b10;
    if(EXMEM_WriteAddr_i == IDEX_RtAddr_i)  mux7_o <= 2'b10;
  end
  if (MEMWB_WB_i and MEMWB_WriteAddr_i != 0 and
      not (EXMEM_WB_i and EXMEM_WriteAddr_i != 0 and ((EXMEM_WriteAddr_i == IDEX_RsAddr_i) or (EXMEM_WriteAddr_i == IDEX_RtAddr_i)))) begin
    if(MEMWB_WriteAddr_i == IDEX_RsAddr_i)  mux6_o <= 2'b01;
    if(MEMWB_WriteAddr_i == IDEX_RtAddr_i)  mux7_o <= 2'b01;
  end
end
endmodule