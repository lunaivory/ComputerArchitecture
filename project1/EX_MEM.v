//TODO
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

endmodule