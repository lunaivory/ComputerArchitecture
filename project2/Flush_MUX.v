/*flush_i == 1 不變
  flush_i == 0 把output都設成0 */
module Flush_MUX(
  input      [1:0]  WB_i,
  input      [3:0]  EX_i,
  input      [1:0]  MEM_i,
  input             flush_i,
  output reg [1:0]  WB_o,
  output reg [3:0]  EX_o,
  output reg [1:0]  MEM_o 
);
always@(*) begin  
  if(flush_i) begin
    WB_o <= WB_i;
    EX_o <= EX_i;
    MEM_o <= MEM_i;
  end
  else begin
    WB_o <= 2'd0;
    EX_o <= 3'd0;
    MEM_o <= 2'd0;
  end
end


endmodule
