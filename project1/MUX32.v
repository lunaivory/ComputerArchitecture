//NOT MODIFIED
//if 1 then output data1_i(the upper line), else data2_i
module MUX32(
  input       [31:0]  data1_i,
  input       [31:0]  data2_i,
  input               select_i,
  output reg  [31:0]  data_o
);

always@(*) begin
    if(select_i)  data_o <= data1_i;
    else          data_o <= data2_i;
end

endmodule