module CPU
(
    input   clk_i, 
    input   rst_i,
    input   start_i
);

wire    [31:0]  instruction;//,instruct_addr;


Control Control(
    .Op_i       (instruction[31:26])//,
    //.RegDst_o   (MUX_RegDst.select_i),
    //.ALUOp_o    (ALU_Control.ALUOp_i),
    //.ALUSrc_o   (MUX_ALUSrc.select_i),
    //.RegWrite_o (Registers.RegWrite_i)
);


//done
Adder Add_PC(
    .data1_in   (PC.pc_o),
    .data2_in   (32'd4)//,
    //.data_o     (PC.pc_i)
);


//done
PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (Add_PC.data_o)//,
    //.pc_o       (Add_PC.data1_in)
);


//done
Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    (instruction[31:0])
);


//done
Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (instruction[25:21]),
    .RTaddr_i   (instruction[20:16]),
    .RDaddr_i   (MUX_RegDst.data_o), 
    .RDdata_i   (ALU.data_o),
    .RegWrite_i (Control.RegWrite_o), 
    //.RSdata_o   (ALU.data1_i), 
    .RTdata_o   (MUX_ALUSrc.data1_i) 
);


//done
MUX5 MUX_RegDst(
    .data1_i    (instruction[20:16]),
    .data2_i    (instruction[15:11]),
    .select_i   (Control.RegDst_o)//,
    //.data_o     (Registers.RDaddr_i)
);


//done
MUX32 MUX_ALUSrc(
    //.data1_i    (Resgisters.RTdata_o),
    .data2_i    (Signed_Extend.data_o),
    .select_i   (Control.ALUSrc_o)//,
    //.data_o     (ALU.data2_i)
);


//done
Signed_Extend Signed_Extend(
    .data_i     (instruction[15:0])//,
    //.data_o     (MUX_ALUSrc.data2_i)
);

  
//done
ALU ALU(
    .data1_i    (Registers.RSdata_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    //.data_o     (Registers.RDdata_i),
    .Zero_o     ()
);


//done
ALU_Control ALU_Control(
    .funct_i    (instruction[5:0]),
    .ALUOp_i    (Control.ALUOp_o[1:0])//,
    //.ALUCtrl_o  (ALU.ALUCtrl_i)
);


endmodule

