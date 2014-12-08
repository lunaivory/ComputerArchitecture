module CPU
(
    input   clk_i, 
    //input   rst_i,
    input   start_i
);

wire    [31:0]  instruction;//,instruct_addr;

Adder Add_PC(
    .data1_i   (PC.pc_o),
    .data2_i   (32'd4)//,
    //.data_o     ()
);


PC PC(
    .clk_i      (clk_i),
    //.rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (Jump_MUX.data_o),
    .stall_i    (HD.PC_stall_o)//,
    //.pc_o       ()
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    (instruction[31:0])
);

AND Brench_AND(
    .data1_i    (Equal.data_o),
    .data2_i    (Control.brenchCtrl_o)//,
    //.data_o     ()
);

MUX32 Brench_MUX( //MUX1
    .data1_i    (Add_Jump.data_o),
    .data2_i    (Add_PC.data_o),
    .select_i   (Brench_AND.data_o)//,
    //.data_o     ()
);

MUX32 Jump_MUX( //MUX2
    .data1_i    (JumpAddr.jumpAddr_o),
    .data2_i    (Brench_MUX.data_o),
    .select_i   (Control.jumpCtrl_o)//,
    //.data_o     ()
);

IF_ID IF_ID(
    .clk_i          (clk_i),
    .addedPC_i      (Add_PC.data_o),
    .Hazard_stall_i (HD.IFID_stall_o),
    .inst_i         (instruction),
    .jump_i         (Control.jumpCtrl_o),
    .brench_i       (Brench_AND.data_o)//,
   // .addedPC_o      (),
   // .inst_o         ()
);

Shift_Left2_Concat JumpAddr(
    .inst_i     (IF_ID.inst_o[25:0]),
    .jumpPC_i   (Brench_MUX.data_o[31:28])//,
    //.jumpAddr_o(Brench_MUX.data_o[31:28])
);

Hazard_Detection_Unit HD(
    .Op_i           (IF_ID.inst_o[31:26]),
    .IFID_RsAddr_i  (IF_ID.inst_o[25:21]),
    .IFID_RtAddr_i  (IF_ID.inst_o[20:16]),
    .IDEX_RtAddr_i  (ID_EX.RtAddr_WB_o),
    .IDEX_MemWrite_i (ID_EX.MEM_o[0])//,
    //.PC_stall_o      (),
    //.IFID_stall_o   (),
    //.IDEX_stall_o        ()
);

Flush_MUX Flush_MUX(
    .WB_i           (Control.WB_o),
    .EX_i           (Control.EX_o),
    .MEM_i          (Control.MEM_o),
    .flush_i        (HD.IDEX_stall_o)//,
    //.WB_o           (),
    //.EX_o           (),
    //.MEM_o          ()
);

Control Control(
    .Op_i       (IF_ID.inst_o[31:26])//,
    //.MUX8_o         (),
    //.jumpCtrl_o     (),
    //.brenchCtrl_o   (),
    //.WB_o           (),
    //.EX_o           (),
    //.MEM_o          ()
);

Adder Add_Jump(
    .data1_i    (brenchx4.data_o),
    .data2_i    (IF_ID.addedPC_o)//,
    //.data_o     ()
);

Shift_Left2 brenchx4(
    .data_i     (Signed_Extend.data_o)//,
    //.data_o     ()
);

Signed_Extend Signed_Extend(
    .data_i     (IF_ID.inst_o[15:0])//,
    //.data_o     ()
);

Registers Registers(
    .clk_i      (clk_i),
    .ReadReg1_i   (IF_ID.inst_o[25:21]),
    .ReadReg2_i   (IF_ID.inst_o[20:16]),
    .WriteReg_i   (MEM_WB.RegWriteAddr_o), 
    .WriteData_i   (DataToReg.data_o),
    .RegWrite_i (MEM_WB.RegWrite_o)//, 
    //.RSdata_o   (), 
    //.RTdata_o   () 
);

Equal Equal(
    .data1_i    (Registers.ReadData1_o),
    .data2_i    (Registers.ReadData2_o)//,
    //.data_o     ()
);

ID_EX ID_EX(
    .clk_i          (clk_i),
    .WB_i           (Flush_MUX.WB_o),
    .MEM_i          (Flush_MUX.MEM_o),
    .EX_i           (Flush_MUX.EX_o),
    .Reg_data1_i    (Registers.ReadData1_o),
    .Reg_data2_i    (Registers.ReadData2_o),
    .RsAddr_FW_i    (IF_ID.inst_o[25:21]), //RegRs
    .RtAddr_FW_i    (IF_ID.inst_o[20:16]), //RegRt
    .RtAddr_WB_i    (IF_ID.inst_o[20:16]), //RegRt
    .RdAddr_WB_i    (IF_ID.inst_o[15:11]), //RegRd
    .immd_i         (Signed_Extend.data_o)//,
    //.WB_o           (),
    //.MEM_o          (),
    //.Reg_data1_o    (),
    //.Reg_data2_o    (),
    //.immd_o         (),
    //.ALU_Src_o      (),
    //.ALU_OP_o       (),
    //.Reg_Dst_o      (),
    //.RsAddr_FW_o    (), //RegRs[25:21]
    //.RtAddr_FW_o    (), //RegRt[20:16]
    //.RtAddr_WB_o    (), //RegRt[20:16]
    //.RdAddr_WB_o    () //RegRd[15:11]
);

ForwardMUX MUX6( //mux6, 7
    .data0_i    (Registers.ReadData1_o),
    .data1_i    (DataToReg.data_o),
    .data2_i    (EX_MEM.ALUout_o),
    .select_i   (Forward_Unit.mux6_o)//,
    //.data_o     ()
);

ForwardMUX MUX7( //mux6, 7
    .data0_i    (Registers.ReadData2_o),
    .data1_i    (DataToReg.data_o),
    .data2_i    (EX_MEM.ALUout_o),
    .select_i   (Forward_Unit.mux7_o)//,
    //.data_o     ()
);

MUX32 MUX_ALUSrc(
    .data1_i    (ID_EX.immd_o),
    .data2_i    (MUX7.data_o),
    .select_i   (ID_EX.ALU_Src_o)//,
    //.data_o     ()
);

MUX5 MUX_RegDst(
    .data1_i    (ID_EX.RdAddr_WB_o),
    .data2_i    (ID_EX.RtAddr_WB_o),
    .select_i   (ID_EX.Reg_Dst_o)//,
    //.data_o     ()
);

ALU ALU(
    .data1_i    (MUX6.data_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    //.data_o     (),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (ID_EX.immd_o[5:0]),
    .ALUOp_i    (Control.EX_o[1:0])//,
    //.ALUCtrl_o  ()
);

Forward_Unit Forward_Unit(
    .EXMEM_WB_i         (EX_MEM.WB_o[1]),
    .MEMWB_WB_i         (MEM_WB.RegWrite_o),
    .IDEX_RsAddr_i      (ID_EX.RsAddr_FW_o),
    .IDEX_RtAddr_i      (ID_EX.RtAddr_FW_o),
    .EXMEM_WriteAddr_i  (EX_MEM.RegWriteAddr_o),
    .MEMWB_WriteAddr_i  (MEM_WB.RegWriteAddr_o)//,
    //.mux6_o             (),
    //.mux7_o             (),
);

EX_MEM EX_MEM(
    .clk_i          (clk_i),
    .WB_i           (ID_EX.WB_o),
    .MEM_i          (ID_EX.MEM_o),
    .ALUout_i       (ALU.data_o), 
    .MemWriteData_i (MUX7.data_o),
    .RegWriteAddr_i (MUX_RegDst.data_o)//,
    //.ALUout_o       (),
    //.MemWriteData_o (),
    //.RegWriteAddr_o (),
    //.WB_o           (),
    //.MemWrite_o     (),
    //.MemRead_o      ()
);

Data_Memory Data_Memory(
    .clk_i          (clk_i),
    .addr_i         (EX_MEM.ALUout_o),
    .write_data_i   (EX_MEM.MemWriteData_o),
    .MemRead_i      (EX_MEM.MemRead_o),
    .MemWrite_i     (EX_MEM.MemWrite_o)//,
    //.data_o         ()
);
MEM_WB MEM_WB(
    .clk_i          (clk_i),
    .WB_i           (EX_MEM.WB_o),
    .MEM_data_i     (Data_Memory.data_o),
    .ALU_data_i     (EX_MEM.ALUout_o), //from EX_MEM.ALUout_o
    .RegWriteAddr_i (EX_MEM.RegWriteAddr_o)//,
    //.RegWrite_o     (),
    //.MemToReg_o     (), //to mux5
    //.Mem_data_o     (),
    //.ALU_data_o     (), //to mux5
    //.RegWriteAddr_o ()
);

MUX32 DataToReg(
    .data1_i    (Data_Memory.data_o),
    .data2_i    (MEM_WB.ALU_data_o),
    .select_i   (MEM_WB.MemToReg_o)//,
    //.data_o     ()
);

endmodule

