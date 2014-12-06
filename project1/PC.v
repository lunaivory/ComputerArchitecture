module PC
(
    input               clk_i,
    input               rst_i,
    input               start_i,
    input       [31:0]  pc_i,
    input               stall_i,
    output reg  [31:0]  pc_o
);


always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        pc_o <= 32'b0;
	end else begin
        if(start_i and stall_i==1'b0)
            pc_o <= pc_i;
        else
            pc_o <= pc_o;
    end
end

endmodule
