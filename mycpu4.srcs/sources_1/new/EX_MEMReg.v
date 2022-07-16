`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/12 11:17:12
// Design Name: 
// Module Name: EX_MEMReg
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


module EX_MEMReg(
    input wire clk,
    input wire rst_n,
    input wire [1:0]ex_WDSel,
    input wire ex_dramwe,
    input wire[31:0]ex_op_c,
    input wire[31:0]ex_rD2,
    input wire[4:0]ex_WR,
    input wire[31:0]ex_pc,
    input wire ex_rfwe,
    input wire ex_run,
    output reg[1:0]mem_WDSel,
    output reg mem_dramwe,
    output reg[31:0] mem_op_c,
    output reg[31:0]mem_rD2,
    output reg[4:0]mem_WR,
    output reg[31:0]mem_pc,
    output reg mem_rfwe,
    output reg mem_run
    );
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            mem_WDSel<=2'b11;
        end
        else begin
            mem_WDSel<=ex_WDSel;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            mem_dramwe<=1'b0;
        end
        else begin
            mem_dramwe<=ex_dramwe;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            mem_op_c<=32'b0;
        end
        else begin
            mem_op_c<=ex_op_c;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            mem_rD2<=32'b0;
        end
        else begin
            mem_rD2<=ex_rD2;
        end
    end
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            mem_WR<=5'b0;
        end
        else begin
            mem_WR<=ex_WR;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            mem_pc<=32'b0;
        end
        else begin
            mem_pc<=ex_pc;
        end
    end
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            mem_run<=1'b0;
        end
        else begin
            if(ex_run)begin
            mem_run<=1'b1;
            end
            else begin
            mem_run<=1'b0;
            end
        end
    end
    always@(posedge clk or negedge rst_n)begin
    if(~rst_n)begin
    mem_rfwe<=1'b0;
    end
    else begin
    mem_rfwe<=ex_rfwe;
    end
end
endmodule
