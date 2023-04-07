`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/12 13:55:10
// Design Name: 
// Module Name: MEM_WBReg
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


module MEM_WBReg(
    input wire clk,
    input wire rst_n,

    input wire mem_rfwe,    //
    input wire[31:0]mem_wd,//
    input wire[4:0]mem_wr, //
    input wire[31:0]mem_pc,
    input wire mem_run,
    output reg wb_rfwe,
    output reg [31:0]wb_wd,
    output reg [4:0]wb_wr,
    output reg [31:0]wb_pc,
    output reg wb_run
    );

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            wb_rfwe<=1'b0;
        end
        else begin
            wb_rfwe<=mem_rfwe;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            wb_wd<=32'b0;
        end
        else begin
            wb_wd<=mem_wd;
        end
    end
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            wb_wr<=5'b0;
        end
        else begin
            wb_wr<=mem_wr;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            wb_pc<=32'b0;
        end
        else begin
            wb_pc<=mem_pc;
        end
    end
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            wb_run<=1'b0;
        end
        else begin
            if(mem_run)begin
            wb_run<=1'b1;
            end
            else begin
            wb_run<=1'b0;
            end
        end
    end
endmodule
