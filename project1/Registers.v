//NOT MODIFIED
module Registers
(
    input           clk_i,
    input   [4:0]   ReadReg1_i,//RSaddr_i,
    input   [4:0]   ReadReg2_i,//RTaddr_i,
    input   [4:0]   WriteReg_i,//RDaddr_i, 
    input   [31:0]  WriteData_i,//RDdata_i,
    input           RegWrite_i, 
    output  [31:0]  ReadData1_o,//RSdata_o, 
    output  [31:0]  ReadData2_o//RTdata_o 
);

// Register File
reg     [31:0]      register        [0:31];

// Read Data      
assign  ReadData1_o = register[ReadReg1_i];
assign  ReadData2_o = register[ReadReg2_i];

// Write Data   
always@(posedge clk_i) begin
    if(RegWrite_i)
        register[WriteReg_i] <= WriteData_i;
end
   
endmodule 
