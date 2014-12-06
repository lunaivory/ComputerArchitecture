module ForwardMUX(
  input      [31:0] data0_i,
  input      [31:0] data1_i,
  input      [31:0] data2_i,
  input      [1:0]  select_i,
  output reg [31:0] data_o
);
always@(*) begin
  if(select_i == 2'd00) data_o <= data0_i;
  if(select_i == 2'd01) data_o <= data1_i;
  if(select_i == 2'd10) data_o <= data2_i;
end

endmodule