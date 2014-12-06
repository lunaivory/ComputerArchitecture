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

reg ALUSrc, RegDst, MemWrite, MemRead, RegWrite, MemtoReg;
reg [2:0] ALUOp;

always @(Op_i)begin
    if(Op_i == 6'b000000) begin //Rtype
        ALUSrc    <= 1'b0;
        ALUOp     <= 2'b10;
        RegDst    <= 1'b1;

		MemWrite  <= 1'b0;
		MemRead   <= 1'b0;

        RegWrite  <= 1'b1;
        MemtoReg  <= 1'b0;
    end
    else if(Op_i == 6'b001000) begin //I type
        ALUSrc    <= 1'b1;
        ALUOp     <= 2'b00; // addi only
        RegDst    <= 1'b0;

		MemWrite  <= 1'b0;
		MemRead   <= 1'b0;

        RegWrite  <= 1'b1;
        MemtoReg  <= 1'b0;
    end
    else if(Op_i == 6'b100011) begin //lw
        ALUSrc    <= 1'b1;
        ALUOp     <= 2'b00;
        RegDst    <= 1'b0;

		MemWrite  <= 1'b0;
		MemRead   <= 1'b1;

        RegWrite  <= 1'b1;
        MemtoReg  <= 1'b1;
    end
    else if(Op_i == 6'b101011) begin //sw
        ALUSrc    <= 1'b1;
        ALUOp     <= 2'b00;
        RegDst    <= 1'b0;

		MemWrite  <= 1'b1;
		MemRead   <= 1'b0;

        RegWrite  <= 1'b0;
        MemtoReg  <= 1'b0;
    end
    else if(Op_i == 6'b000100) begin //beq
        ALUSrc    <= 1'b0; //don't care?
        ALUOp     <= 2'b01;//don't care?
        RegDst    <= 1'b1; //don't care?

		MemWrite  <= 1'b0;
		MemRead   <= 1'b0;

        RegWrite  <= 1'b0;
        MemtoReg  <= 1'b0;
    end
    else if(Op_i == 6'b000010) begin //j
        ALUSrc    <= 1'b0;
        ALUOp     <= 2'b01;
        RegDst    <= 1'b1;

		MemWrite  <= 1'b0;
		MemRead   <= 1'b0;

        RegWrite  <= 1'b0;
        MemtoReg  <= 1'b0;
    end

	EX_o  = (ALUSrc << 3) + (ALUOp << 1) + RegDst;
	MEM_o = (MemWrite << 1) + MemRead;
	WB_o = (RegWrite << 1) + MemtoReg;

end

endmodule
