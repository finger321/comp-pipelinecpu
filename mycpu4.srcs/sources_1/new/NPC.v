module NPC(
    input wire jump,
    input wire[1:0] npcop,
    input wire[31:0] pc,
    input wire[31:0] imm,
    input wire[31:0] base_adr,
    output wire[31:0] npc,
    output wire[31:0] pc4
);

assign pc4 = pc + 3'h4;

assign npc = npcop == 2'b00 ? pc + 3'h4 :
             npcop == 2'b01 ? pc + imm  :
             npcop == 2'b10 ? base_adr + imm :
             jump == 1'b1    ? pc + imm : pc + 3'h4;


endmodule