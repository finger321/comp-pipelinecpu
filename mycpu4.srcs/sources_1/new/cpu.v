module CPU(
    input clk,
    input rst_n,

    input wire [31:0] inst,
    input wire [31:0] WB_WD,
    input wire  WB_RFWE,
    input wire [4:0]  WB_WR,

    output wire [31:0] pc,

    output wire [31:0] mem_op_C, 
    output wire [31:0] mem_rD2,
    output wire mem_DRAM_WE,
    output wire [1:0]mem_WDSel,
    output wire[4:0]mem_WR,
    output wire mem_rfwe,
    output wire [31:0]mem_pc,
    output wire mem_run,
    output wire [31:0] trace_result
);

// reg [31:0] pc;
wire [31:0] npc;
// ctrl
wire [1:0] npcop;
wire [1:0] WDSel;
wire DRAM_WE;
// wire mem_write;
wire ctrl_branch;
wire [3:0] aluop;
wire Bsel;
wire [2:0] extop;
// rf
wire id_rfwe;
wire [31:0] rD1;
wire [31:0] rD2;
// alu
wire branch;
wire [31:0]C;
// npc
wire jump;
wire [31:0] pc4;
// sext
wire [31:0] ext;
// dm
// varaibles of IF_ID
wire[31:0] id_pc;
wire[31:0] id_inst;
wire [31:0] id_rD1;
wire [31:0]id_rD2;
wire id_run;
wire id_mem_read;
// varaibles of ID_EX
wire[1:0]ex_WDSel;
wire[1:0] ex_npcop;
wire ex_dram_we;
wire ex_branch;
wire[3:0] ex_ALuop;
wire [31:0]ex_pc;
wire [31:0]ex_inst;
wire[31:0]ex_ext;
wire[31:0]ex_rD1;
wire[31:0]ex_op_B;
wire[31:0]ex_rD2;
wire [4:0]ex_WR;
wire ex_rfwe;
wire [4:0]ex_rS1;
wire [4:0]ex_rS2;
wire ex_run;
wire ex_Bsel;
wire ex_mem_read;
wire stall;
//流水线寄存器flush控制信号
wire IF_ID_flush;
wire ID_EX_flush;
assign IF_ID_flush=jump||(ex_inst[6:0]==7'b1101111||ex_inst[6:0]==7'b1100111);
assign ID_EX_flush=jump||(ex_inst[6:0]==7'b1101111||ex_inst[6:0]==7'b1100111)||stall;
//锟睫革拷next_pc锟竭硷拷,默认为pc+4
wire [31:0]pc_4=pc+3'h4;
wire [31:0]next_pc;
assign next_pc=(IF_ID_flush)?npc:pc_4;
// variables of forwardunit
wire [1:0] forwardA;
wire [1:0] forwardB;
wire  [1:0]forwardC;
wire [1:0] forwardD;
// variables of HazarDection


wire if_run;
reg  if_run_g;
assign if_run=if_run_g;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        if_run_g<=1'b0;
    end
    else begin
        if_run_g<=1'b1;
    end
end
PC u_pc(
    .clk(clk),
    .rst_n(rst_n),
    .stop(stall),
    .next_pc(next_pc),
    .pc(pc)
);

IF_IDReg  u_if_id(
    .clk(clk),
    .rst_n(rst_n),
    .stop(stall),
    .if_run(if_run),
    .IF_ID_flush(IF_ID_flush),
    .if_pc(pc),
    .if_inst(inst),
    .id_inst(id_inst),
    .id_pc(id_pc),
    .id_run(id_run)
);
HazardDectionUnit u_HazardDectionUnit(
    .rst_n(rst_n),
    .ex_mem_read(ex_mem_read),
    .ex_WR(ex_WR),
    .id_rS1(id_inst[19:15]),
    .id_rS2(id_inst[24:20]),
    .stall(stall)
);
assign jump=ex_branch&branch;
NPC u_npc(
    .jump(jump),
    .npcop(ex_npcop),
    .pc(ex_pc),
    .imm(ex_ext),
    .base_adr(ex_rD1),
    .npc(npc) ,
    .pc4(pc4)
);


CTRL u_ctrl(
    .func3(id_inst[14:12]),
    .func7_5(id_inst[30]),
    .opcode(id_inst[6:0]),
    .ctrl_branch(ctrl_branch),
    .DRAM_WE(DRAM_WE),
    .npcop(npcop),
    .WDSel(WDSel),
    .aluop(aluop),
    .Bsel(Bsel),
    .extop(extop),
    .RFWE(id_rfwe),
    .id_mem_read(id_mem_read)
);

SEXT u_sext(
    .din(id_inst[31:7]),
    .extop(extop),
    .ext(ext)
);


RF u_RF(
    .clk(clk),
    .RFWE(WB_RFWE),
    .rR1(id_inst[19:15]),
    .rR2(id_inst[24:20]),
    .WR(WB_WR),
    .WD(WB_WD),
    .rD1(rD1),
    .rD2(rD2),
    .result(trace_result)  // the result of the trace test
);
wire [31:0] op_B;
assign op_B=(Bsel)?ext:rD2;
assign id_rD1=(forwardC==2'b01)?C:
               (forwardC==2'b10)?mem_op_C:rD1;
assign id_rD2=(forwardD==2'b01)?C:
               (forwardD==2'b10)?mem_op_C:rD2;

ID_EXReg id_ex(
    .clk(clk),
    .rst_n(rst_n),
    .ID_EX_flush(ID_EX_flush),
    .id_WDSel(WDSel),
    .id_npcop(npcop),
    .id_dram_we(DRAM_WE),
    .id_branch(ctrl_branch),
    .id_ALuop(aluop),
    .id_pc(id_pc),
    .id_inst(id_inst),
    .id_ext(ext),
    .id_rD1(id_rD1),
    .id_op_B(op_B),
    .id_rD2(id_rD2),
    .id_rfwe(id_rfwe),
    .id_rS1(id_inst[19:15]),
    .id_rS2(id_inst[24:20]),
    .id_WR(id_inst[11:7]),
    .id_run(id_run),
    .id_Bsel(Bsel),
    .id_mem_read(id_mem_read),
    .ex_WDSel(ex_WDSel),
    .ex_npcop(ex_npcop),
    .ex_dram_we(ex_dram_we),
    .ex_branch(ex_branch),
    .ex_ALuop(ex_ALuop),
    .ex_pc(ex_pc),
    .ex_inst(ex_inst),
    .ex_ext(ex_ext),
    .ex_rD1(ex_rD1),
    .ex_op_B(ex_op_B),
    .ex_rfwe(ex_rfwe),
    .ex_rD2(ex_rD2),
    .ex_rS1(ex_rS1),
    .ex_rS2(ex_rS2),
    .ex_WR(ex_WR),
    .ex_run(ex_run),
    .ex_Bsel(ex_Bsel),
    .ex_mem_read(ex_mem_read)
);
wire [31:0] alu_op_A;//传入alu的操作数A
assign alu_op_A=(forwardA==2'b10)?mem_op_C:
            (forwardA==2'b01)?WB_WD:(ex_rD1);

wire [31:0] alu_op_B; //传入alu的操作数B
assign alu_op_B=(ex_Bsel)?ex_op_B: 
                (forwardB==2'b10)?mem_op_C:
                (forwardB==2'b01)?WB_WD:ex_op_B;
ALU u_alu(
    .A(alu_op_A),
    .B(alu_op_B),
    .aluop(ex_ALuop),
    .branch(branch),
    .C(C)
);
EX_MEMReg u_ex_mem(
    .clk(clk),
    .rst_n(rst_n),
    .ex_WDSel(ex_WDSel),
    .ex_dramwe(ex_dram_we),
    .ex_op_c(C),
    .ex_rD2(ex_rD2),
    .ex_WR(ex_WR),
    .ex_rfwe(ex_rfwe),
    .ex_pc(ex_pc),
    .ex_run(ex_run),
    .mem_WDSel(mem_WDSel),
    .mem_dramwe(mem_DRAM_WE),
    .mem_op_c(mem_op_C),
    .mem_rD2(mem_rD2),
    .mem_WR(mem_WR),
    .mem_rfwe(mem_rfwe),
    .mem_pc(mem_pc),
    .mem_run(mem_run)
);
ForwardUnit u_ForwardUnit(
    .rst_n(rst_n),
    .ex_rfwe(ex_rfwe),
    .ex_WR(ex_WR),
    .id_rS1(id_inst[19:15]),
    .id_rS2(id_inst[24:20]),
    .mem_rfwe(mem_rfwe),
    .mem_WR(mem_WR),
    .wb_rfwe(WB_RFWE),
    .wb_WR(WB_WR),
    .ex_rS1(ex_rS1),
    .ex_rS2(ex_rS2),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .forwardC(forwardC),
    .forwardD(forwardD)
);
endmodule