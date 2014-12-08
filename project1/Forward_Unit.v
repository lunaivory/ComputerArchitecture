module Forward_Unit(
  input        EXMEM_WB_i,//RegWrite FROM WB[1]
  input        MEMWB_WB_i,////RegWrite FROM WB[1]
  input  [4:0] IDEX_RsAddr_i,
  input  [4:0] IDEX_RtAddr_i,
  input  [4:0] EXMEM_WriteAddr_i, //RegisterRd
  input  [4:0] MEMWB_WriteAddr_i,
  output reg [1:0]  mux6_o,
  output reg [1:0]  mux7_o
);

/*always @(*) begin
	mux6_o = 2'b00;
	mux7_o = 2'b00;

	if (MEMWB_WB_i && (MEMWB_WriteAddr_i != 1'b0)
	&& !(EXMEM_WB_i && (EXMEM_WriteAddr_i != 1'b0)
		&& (EXMEM_WriteAddr_i != IDEX_RsAddr_i))
	&& (IDEX_RsAddr_i == MEMWB_WriteAddr_i)) begin
		mux6_o = 2'b01;
	end
	if (MEMWB_WB_i
	&& (MEMWB_WriteAddr_i != 1'b0)
	&& !(EXMEM_WB_i && (EXMEM_WriteAddr_i != 1'b0)
		&& (EXMEM_WriteAddr_i != IDEX_RsAddr_i))
	&& (IDEX_RtAddr_i == EXMEM_WriteAddr_i)) begin
		mux7_o = 2'b01;
	end

	if (EXMEM_WriteAddr_i
	&& (EXMEM_WriteAddr_i != 1'b0)
	&& (EXMEM_WriteAddr_i == IDEX_RsAddr_i))begin
		mux6_o = 2'b10;
	end
	if (EXMEM_WriteAddr_i
	&& (EXMEM_WriteAddr_i != 1'b0)
	&& (EXMEM_WriteAddr_i == IDEX_RtAddr_i))begin
		mux7_o = 2'b10;
	end
*/

always @(*) begin
	mux6_o = 2'b00;
	mux7_o = 2'b00;
  if (EXMEM_WB_i && (EXMEM_WriteAddr_i != 1'b0)) begin
		if(EXMEM_WriteAddr_i == IDEX_RsAddr_i)  mux6_o = 2'b10;
		if(EXMEM_WriteAddr_i == IDEX_RtAddr_i)  mux7_o = 2'b10;
  end
  if (MEMWB_WB_i && MEMWB_WriteAddr_i != 1'b0 ) begin
		if(MEMWB_WriteAddr_i == IDEX_RsAddr_i)  mux6_o = 2'b01;
		if(MEMWB_WriteAddr_i == IDEX_RtAddr_i)  mux7_o = 2'b01;
  end
//&&
//	   !(EXMEM_WB_i && EXMEM_WriteAddr_i != 1'b0 && ((EXMEM_WriteAddr_i == IDEX_RsAddr_i) || (EXMEM_WriteAddr_i == IDEX_RtAddr_i)))
end
	
//end

endmodule
