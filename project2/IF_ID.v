/*flush = jump_i OR brench_i (可以直接assign嗎？)
  posedge的時候把兩個都存起來
  negedge的時候
  如果Hazard_stall_i == 1 就flush掉
  如果flush == 1 也flush掉
  只有Hazard_stall_i跟flush都是0的時候才output addedPC_i跟inst_i出去
  (但我不確定可以不可以直接把0指定給addedPC跟inst)
  */
module IF_ID(
  input              clk_i,
  input       [31:0] addedPC_i,
  input              Hazard_stall_i,
  input       [31:0] inst_i,
  input              jump_i,
  input              brench_i,
  input  			 CacheStall_i,
  output reg  [31:0] addedPC_o,
  output reg  [31:0] inst_o 
);

reg [31:0] addedPC;
reg [31:0] inst;


always @(posedge clk_i) begin
  addedPC <= addedPC_i;
  inst <= inst_i;
end

always @(negedge clk_i) begin
  if (Hazard_stall_i == 1'b1)begin
  end
  else if((brench_i || jump_i) == 1'b1) begin
    addedPC_o = 32'd0;
    inst_o = 32'd0;
  end
  else begin
    addedPC_o = addedPC;
    inst_o = inst;
  end
end
endmodule
