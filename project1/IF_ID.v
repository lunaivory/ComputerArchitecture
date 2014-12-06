//TODO 
module IF_ID(
  input              clk_i,
  input       [31:0] addedPC_i,
  input              IF_Hazard_i,
  input       [31:0] inst_i,
  input              flush_i,
  input              brench_i,
  output reg  [31:0] addedPC_o,
  output reg  [31:0] inst_o 
);

endmodule