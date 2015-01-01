//NOT MODIFIED
module ALU_Control(
    input       [5:0] funct_i,
    input       [1:0] ALUOp_i,
    output reg  [2:0] ALUCtrl_o
);
  
always @(*) begin
    if (ALUOp_i == 2'b10) begin
        case(funct_i)
            6'b100100:  ALUCtrl_o <= 3'b000;  //and
            6'b100101:  ALUCtrl_o <= 3'b001;  //or
            6'b100000:  ALUCtrl_o <= 3'b010;  //add
            6'b100010:  ALUCtrl_o <= 3'b011;  //sub
            6'b011000:  ALUCtrl_o <= 3'b100;  //mul
        endcase
    end
    else    ALUCtrl_o <= 3'b010;  //addi
end

endmodule