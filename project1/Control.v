//TODO 
module Control(
    input      [5:0]  Op_i,
    output reg        FlushMUX_o  ,
    output reg        jumpCtrl_o  ,
    output reg        branchCtrl_o,
    output reg [1:0]  WB_o        ,//RegWrite MemToReg
    output reg [3:0]  EX_o        ,//ALUSrc ALUOp RegDst
    output reg [1:0]  MEM_o       //MemWrite MemRead
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