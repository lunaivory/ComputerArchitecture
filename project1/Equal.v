Equal EQ(
    .data1_i(),
    .data2_i(),
    .branch_o()
);
module Equal(
  input [31:0] data1_i,
  input [31:0] data2_i,
  output reg   branch_o
);