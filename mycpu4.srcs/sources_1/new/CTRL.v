module CTRL(
    input wire [2:0] func3,
    input wire  func7_5,
    input wire [6:0] opcode,
    output wire [1:0] npcop,
    output wire [1:0] WDSel,
    output wire DRAM_WE,
    output wire ctrl_branch,
    output wire [3:0] aluop,  
    output wire Bsel,   // select operandB
    output wire [2:0] extop,
    output wire RFWE,      // rf's we
    output wire id_mem_read
);

assign RFWE = (opcode==7'b0000000)?1'b0:
              (opcode == 7'b1100011 || opcode == 7'b0100011) ? 1'b0 : 1'b1;
//                    ^ b series               ^ sw

// 00  ---> pc + 4
// 11  ---> pc + imm(b)
// 10  ---> base_adr + imm(jalr)
// 01  ---> pc + imm(jal) 
assign npcop = (opcode[6:5] == 2'b11) ? (opcode == 7'b1100111 ? 2'b10 : 
                                          (opcode == 7'b1101111 ? 2'b01 : 2'b11)) : 2'b00;
// 00 ---> rd = rs1 op rs2
// 01 ---> rd = pc + 4
// 10 ---> rd = mem
// 11 ---> rd = imm (lui)
assign WDSel = (opcode[6:4] == 3'b000) ? 2'b10 : 
                   (opcode[6:5] == 2'b11) ?  2'b01 :  2'b00;

assign DRAM_WE = (opcode[6:4] == 3'b010) ? 1'b1 : 1'b0;

assign ctrl_branch = ({opcode[6:4], opcode[2]} == 4'b1100) ? 1'b1 : 1'b0;

assign aluop =    (opcode==7'b0110111)? 4'b1100:
                  (opcode[6:5] == 2'b11) ? 
                    (
                     // b
                  (func3[2:0] == 3'b000) ? 4'b1000 :
                  (func3[2:0] == 3'b001) ? 4'b1001 :
                  (func3[2:0] == 3'b100) ? 4'b1010 : 4'b1011 
                     ) : (
                     // not b
                  (func3[2:0] == 3'b111) ? 4'b0010 :
                  (func3[2:0] == 3'b110) ? 4'b0011 :
                  (func3[2:0] == 3'b100) ? 4'b0100 :
                  (func3[2:0] == 3'b001) ? 4'b0101 : 
                  (func3[2:0] == 3'b000) ? ((opcode == 7'b0010011) ? 4'b0000 : (func7_5 == 1'b0 ? 4'b0000 : 4'b0001)) :
                  (func3[2:0] == 3'b010) ? 4'b0000 :
                  (func7_5 == 1'b0) ? 4'b0110 : 4'b0111
                     );

assign Bsel = (opcode[6:4] == 3'b001 || func3[2:0] == 3'b010||opcode==7'b0110111) ? 1'b1 : 1'b0;
assign extop = (opcode == 7'b0110011) ? 3'b000 :   // no
               (opcode == 7'b1100011) ? 3'b011 :    // beq
               (opcode == 7'b0100011) ? 3'b010 :    // sw
               (opcode == 7'b0110111) ? 3'b100 :    // lui
               (opcode == 7'b1101111) ? 3'b101 :    // jal
                                          3'b001;     // other
assign   id_mem_read=(opcode==7'b0000011)?1'b1:1'b0;
endmodule