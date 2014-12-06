module Forward_Unit(
  input        EXMEM_WB_i,//RegWrite FROM WB[1]
  input        MEMWB_WB_i,////RegWrite FROM WB[1]
  input  [5:0] IDEX_RsAddr_i,
  input  [5:0] IDEX_RtAddr_i,
  input  [5:0] EXMEM_WriteAddr_i, //RegisterRd
  input  [5:0] MEMWB_WriteAddr_i,
  output reg [1:0]  mux6_o,
  output reg [1:0]  mux7_o
);

always @(*) begin
	mux6_o <= 2'b00;
	mux7_o <= 2'b00;

	if (MEMWB_WB_i[1]
	and (MEMWB_WriteAddr_i != 0)
	and not(EXMEM_WB_i[1] and (EXMEM_WriteAddr_i != 0)
		and (EXMEM_WriteAddr_i != IDEX_RsAddr_i))
	and (IDEX_RsAddr_i == MEMWB_WriteAddr_i)) begin
		mux6_o <= 2'b01;
	end
	if (MEMWB_WB_i[1]
	and (MEMWB_WriteAddr_i !=0)
	and not(EXMEM_WB_i[1] and (EXMEM_WriteAddr_i != 0)
		and (EXMEM_WriteAddr_i != IDEX_RsAddr_i))
	and (IDEX_RtAddr_i == EXMEM_WriteAddr_i)) begin
		mux7_o <= 2'b01;
	end

	if (EXMEM_WriteAddr_i
	and (EXMEM_WriteAddr_i != 0)
	and (EXMEM_WriteAddr_i == IDEX_RsAddr_i))begin
		mux6_o <= 2'b10;
	end
	if (EXMEM_WriteAddr_i
	and (EXMEM_WriteAddr_i != 0)
	and (EXMEM_WriteAddr_i == IDEX_RtAddr_i))begin
		mux7_o <= 2'b10;
	end
end

endmodule