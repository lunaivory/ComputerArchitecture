module PC
(
    input               clk_i,
    //input               rst_i,
    input               start_i,
    input       [31:0]  pc_i,
    input               stall_i,
    output reg  [31:0]  pc_o
);

//always@(posedge clk_i or negedge rst_i) begin
   // if(~rst_i) begin
    //    pc_o <= 32'b0;
reg [31:0] pc;

initial begin
	pc_o = 0;
end

always@(posedge clk_i) begin
    if(start_i  && (stall_i==1'b0)) pc_o = pc_i;
    if(!start_i) pc_o = 0;                        
end
/*always@(posedge clk_i) begin
    if(start_i) begin
        if(stall_i)
            pc_o = pc_o;
        else
            pc_o = pc_i;
    end else
        pc_o = 0;
end*/
endmodule
