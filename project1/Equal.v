module Equal(
  input [31:0] data1_i,
  input [31:0] data2_i,
  output reg   data_o
);

always @(data1_i or data2_i)
	data_o = (data1_i == data2_i)
end

endmodule
