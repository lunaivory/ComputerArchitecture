module Control(
    input      [5:0]  Op_i,
    output reg        RegDst_o,
    output reg [1:0]  ALUOp_o,
    output reg        ALUSrc_o,
    output reg        RegWrite_o
);

always @(*)begin
    if(Op_i == 6'b000000) begin //Rtype
        RegDst_o    <= 1'b1;
        ALUOp_o     <= 2'b01;
        ALUSrc_o    <= 1'b0;
        RegWrite_o  <= 1'b1;
    end
    else if(Op_i == 6'b001000) begin //I type
        RegDst_o    <= 1'b0;
        ALUOp_o     <= 2'b00;
        ALUSrc_o    <= 1'b1;
        RegWrite_o  <= 1'b1;
    end
end

endmodule