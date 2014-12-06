//TODO
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

endmodule