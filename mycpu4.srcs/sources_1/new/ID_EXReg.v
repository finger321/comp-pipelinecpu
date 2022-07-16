`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 16:42:48
// Design Name: 
// Module Name: ID_EXReg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ID_EXReg(
    input wire clk,
    input wire rst_n,
    input wire ID_EX_flush,
    input wire[1:0]id_WDSel,
    input wire[1:0] id_npcop,
    input wire id_dram_we,
    input wire id_branch,
    input wire[3:0] id_ALuop, 
    input wire [31:0]id_pc,   
    input wire[31:0]id_ext,
    input wire[31:0]id_rD1,
    input wire[31:0]id_op_B,
    input wire[31:0]id_rD2,
    input wire[31:0]id_inst,
    input wire [4:0]id_rS1,
    input wire [4:0]id_rS2,
    input wire[4:0] id_WR,
    input wire id_rfwe,
    input wire id_run,
    input wire id_Bsel,
    input wire id_mem_read,
    output reg[1:0]ex_WDSel,
    output reg[1:0] ex_npcop,
    output reg ex_dram_we,
    output reg ex_branch,
    output reg[3:0] ex_ALuop,
    output reg [31:0]ex_pc,
    output reg[31:0]ex_ext,
    output reg[31:0]ex_rD1,
    output reg[31:0]ex_op_B,
    output reg[31:0]ex_rD2,
    output reg[31:0]ex_inst,
    output reg[4:0]ex_rS1,
    output reg[4:0]ex_rS2,
    output reg[4:0] ex_WR,
    output reg ex_rfwe,
    output reg ex_run,
    output reg ex_Bsel,
    output reg ex_mem_read
    );
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_WDSel<=2'b11;
    end
    else if(ID_EX_flush)begin
    ex_WDSel<=2'b11;
    end
    else begin
    ex_WDSel<=id_WDSel;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_npcop<=2'b0;
    end
    else if(ID_EX_flush)begin
    ex_npcop<=2'b0;
    end
    else begin
    ex_npcop<=id_npcop;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_branch<=1'b0;
    end
    else if(ID_EX_flush)begin
    ex_branch<=1'b0;
    end
    else begin
    ex_branch<=id_branch;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_dram_we<=1'b0;
    end
    else if(ID_EX_flush)begin
    ex_dram_we<=1'b0;
    end
    else begin
    ex_dram_we<=id_dram_we;
    end
end

always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_ALuop<=4'b0;
    end
    else if(ID_EX_flush)begin
    ex_ALuop<=4'b0000;
    end
    else begin
    ex_ALuop<=id_ALuop;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_pc<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_pc<=32'b0;
    end
    else begin
    ex_pc<=id_pc;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_ext<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_ext<=32'b0;
    end
    else begin
    ex_ext<=id_ext;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_rD1<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_rD1<=32'b0;
    end
    else begin
    ex_rD1<=id_rD1;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_op_B<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_op_B<=32'b0;
    end
    else begin
    ex_op_B<=id_op_B;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_rD2<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_rD2<=32'b0;
    end
    else begin
    ex_rD2<=id_rD2;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_inst<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_inst<=32'b0;
    end
    else begin
    ex_inst<=id_inst;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_WR<=5'b0;
    end
    else if(ID_EX_flush)begin
    ex_WR<=5'b0;
    end
    else begin
    ex_WR<=id_WR;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_rS1<=5'b0;
    end
    else if(ID_EX_flush)begin
    ex_rS1<=5'b0;
    end
    else begin
    ex_rS1<=id_rS1;
    end
end
always @(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_rS2<=5'b0;
    end
    else if(ID_EX_flush)begin
    ex_rS2<=5'b0;
    end
    else begin
    ex_rS2<=id_rS2;
    end
end
always@(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_rfwe<=1'b0;
    end
    else if(ID_EX_flush)begin
    ex_rfwe<=1'b0;
    end
    else begin
    ex_rfwe<=id_rfwe;
    end
end
always@(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    ex_inst<=32'b0;
    end
    else if(ID_EX_flush)begin
    ex_inst<=32'b0;
    end
    else begin
    ex_inst<=id_inst;
    end
end
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        ex_run<=1'b0;
    end
    else if(ID_EX_flush)begin
        ex_run<=1'b0;
    end
    else  begin
        if(id_run)begin
            ex_run<=1'b1;
        end
        else begin
            ex_run<=1'b0;
        end
    end
end
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        ex_Bsel<=1'b0;
    end
    else if(ID_EX_flush)begin
        ex_Bsel<=1'b0;
    end
    else  begin
        ex_Bsel<=id_Bsel;
    end
end
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        ex_mem_read<=1'b0;
    end
    else if(ID_EX_flush)begin
        ex_mem_read<=1'b0;
    end
    else  begin
        ex_mem_read<=id_mem_read;
    end
end
endmodule
