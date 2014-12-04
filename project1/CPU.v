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
    .pc_i       (Add_PC.data_o),
    .stall_i   ()//,
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
    .IF_Hazard_i   (),
    .flush_i    (),
    .brench_i    (),
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
    .IDEX_RT_addr_i(),
    .IDEX_MemRead_i(),
    .PCWrite_o(),
    .IFID_Write_o(),
    .stall_o()
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
    .RsAddr_FW_i (), //RegRs
    .RtAddr_FW_i (), //RegRt
    .RtAddr_WB_i (), //RegRt
    .RdAddr_WB_i (), //RegRd
    .immd_i     (),
    .WB_o       (),
    .M_o        (),
    .Reg_data1_o(),
    .Reg_data2_o(),
    .immd_o(),
    .ALU_Src_o(),
    .ALU_OP_o(),
    .Reg_Dst_o(),
    .RsAddr_FW_o (), //RegRs[25:21]
    .RtAddr_FW_o (), //RegRt[20:16]
    .RtAddr_WB_o (), //RegRt[20:16]
    .RdAddr_WB_o () //RegRd[15:11]
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

Forward_Unit Forward_Unit(
    .EXMEM_WB_i    (),
    .MEMWB_WB_i    (),
    .IDEX_RsAddr_i  (),
    .IDEX_RtAddr_i  (),
    .EXMEM_WriteAddr_i (),
    .MEMWB_WriteAddr_i (),
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
    .MemWrite_o (),
    .MemRead_o ()
);

Data_Memory Data_Memory(
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
    .ALU_data_i (), //from EX_MEM.ALUout_o
    .RegDst_i  (),
    .RegWrite_o(),
    .MemToReg_o     (), //to mux5
    .Mem_data_o  (),
    .ALU_data_o    (), //to mux5
    .RegWriteAddr_o  ()
);

MUX32 MemToReg(
    .data1_i(),
    .data2_i(),
    .select_i(),
    .data_o()
);

endmodule

