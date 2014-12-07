module Shift_Left2_Concat(
  input       [25:0]  inst_i,
  input       [3:0]   jumpPC_i,
  output reg  [31:0]  jumpAddr_o
);

always @(inst_i or jumpPC_i) begin
	jumpAddr_o = inst_i + jumpPC_i<<26;
end

endmodule
