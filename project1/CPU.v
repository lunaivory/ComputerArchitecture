module CPU
(
    input   clk_i, 
    input   rst_i,
    input   start_i
);

wire    [31:0]  instruction;//,instruct_addr;

Adder Add_PC(
    .data1_in   (PC.pc_o),
    .data2_in   (32'd4)//,
    //.data_o     (PC.pc_i)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (Add_PC.data_o)//,
    //.pc_o       (Add_PC.data1_in)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    (instruction[31:0])
);

MUX32 Brench_MUX(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

MUX32 Jump_MUX(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

IF_ID IF_ID(
    .clk_i      (clk_i),
    .addedPC_i  (),
    .IFinst_i   (),
    .flush_i    (),
    .addedPC_o  (),
    .inst_o   ()
);

Shift_Left2_Concat JumpAddr(
    .inst_i(),
    .addedPC_i(),
    .jumpAddr_o()
);

Hazard_Detection_Unit HD(
    .inst_i(),
    .ID_EX_i(),
    .ID_EX_M_i(),
    .PC_o(),
    .control_o(),
    .flush_o()
);

FLUSH_MUX Flush_MUX(
    .WB_i           (),
    .EX_i           (),
    .MEM_i          (),
    .flush_i        (),
    .WB_o           (),
    .EX_o           (),
    .MEM_o          ()
);

Control Control(
    .Op_i       (instruction[31:26]),
    .MUX8_o     (),
    .jumpCtrl_o     (),
    .branchCtrl_o   (),
    .WB_o           (),
    .EX_o           (),
    .MEM_o          ()
);

Adder Add_Jump(
    .data1_i(),
    .data2_i(),
    .data_o()
);

Shift_Left2 branchx4(
    .data_i(),
    .data_o()
);

Signed_Extend Signed_Extend(
    .data_i     (instruction[15:0])//,
    //.data_o     (MUX_ALUSrc.data2_i)
);

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

Equal EQ(
    .data1_i(),
    .data2_i(),
    .branch_o()
);

ID_EX ID_EX(
    .clk_i      (clk_i),
    .WB_i       (),
    .MEM_i        (),
    .EX_i       (),
    .Reg_data1_i(),
    .Reg_data2_i(),
    .inst2521_i (), //RegRs
    .inst2016_i (), //RegRt
    .inst2016_i (), //RegRt
    .inst1511_i (), //RegRd
    .immd_i     (),
    .WB_o       (),
    .M_o        (),
    .Reg_data1_o(),
    .Reg_data2_o(),
    .immd_o(),
    .inst2521_o (), //RegRs
    .inst2016_o (), //RegRt
    .inst2016_o (), //RegRt
    .inst1511_o () //RegRd

)

ForwardMUX MUX6( //mux6, 7
    .data0_i    (),
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

ForwardMUX MUX7( //mux6, 7
    .data0_i    (),
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

MUX32 MUX_ALUSrc(
    .data1_i    (),
    .data2_i    (),
    .select_i   ()//,
    //.data_o     ()
);

MUX5 MUX_RegDst(
    .data1_i(),
    .data2_i(),
    .select_i(),
    .data_o()
);

ALU ALU(
    .data1_i    (Registers.RSdata_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    //.data_o     (Registers.RDdata_i),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (instruction[5:0]),
    .ALUOp_i    (Control.ALUOp_o[1:0])//,
    //.ALUCtrl_o  (ALU.ALUCtrl_i)
);

ForwardUnit ForwardUnit(
    .EX_MEM_WB_i    (),
    .MEM_WB_WB_i    (),
    .EX_MEM_inst_i  (),
    .MEM_WB_inst_i  (),
    .inst2521_i (), //RegRs
    .inst2016_i (), //RegRt
    .mux6_o     (),
    .mux7_o     (),
)

EX_MEM EX_MEM(
    .clk_i      (clk_i),
    .WB_i       (),
    .MEM_i        (),
    .ALUout_i   (), 
    .MUX7_i     (),
    .muxRegDst_i    (),
    .ALUout_o   (),
    .mux7_o     (),
    .muxRegDst_o    (),
    .WB_o       (),
    .M_o        ()
);

Data_Memory DataMemory(
    .clk_i      (clk_i),
    .addr_i     (),
    .write_data_i   (),
    .MemRead_i  (),
    .MemWrite_i (),
    .data_o     ()
);

MEM_WB MEM_WB(
    .clk_i      (clk_i),
    .WB_i       (),
    .MEM_data_i (),
    .MEM_addr_i (), //from EX_MEM.ALUout_o
    .RegDst_i  (),
    .MEM_addr_o     (), //to mux5
    .RegDst_o   (),
    .Data_o     (), //to mux5
    .MEM_WB_o   ()
);

MUX32 MemToReg(
    .data1_i(),
    .data2_i(),
    .select_i(),
    .data_o()
);

endmodule

