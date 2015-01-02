module Shift_Left2(
  input      [31:0] data_i,
  output reg [31:0] data_o
);

	always @(data_i) begin
		data_o = data_i << 2;
	end

endmodule
