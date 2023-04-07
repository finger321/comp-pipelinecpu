`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/13 11:48:53
// Design Name: 
// Module Name: ForwardUnit
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


module ForwardUnit(
    input wire rst_n,
    input wire ex_rfwe,
    input wire [4:0]ex_WR,
    input wire [4:0]id_rS1,
    input wire [4:0]id_rS2,
    input wire mem_rfwe,
    input wire [4:0]mem_WR,
    input wire wb_rfwe,
    input wire [4:0]wb_WR,
    input wire [31:0]ex_rS1,
    input wire [31:0]ex_rS2,
    output reg [1:0]forwardA,
    output reg [1:0]forwardB ,
    output reg [1:0]forwardC ,
    output reg [1:0]forwardD
);
always @(*) begin
    if(~rst_n)begin
        forwardA=2'b0;
    end
    else begin
        if(mem_rfwe&&mem_WR!=0&&mem_WR==ex_rS1)begin //op_A EX√∞œ’
            forwardA=2'b10;
        end
        else if(wb_rfwe&&wb_WR!=0&&!(mem_rfwe&&mem_WR!=0&&mem_WR==ex_rS1)&&wb_WR==ex_rS1)begin//op_A MEM√∞œ’
            forwardA=2'b01;
        end
        else begin
            forwardA=2'b00;
        end
    end
end
always @(*) begin
    if(~rst_n)begin
        forwardB=2'b0;
    end
    else begin
        if(mem_rfwe&&mem_WR!=0&&mem_WR==ex_rS2)begin//op_B EX√∞œ’
            forwardB=2'b10;
        end
        else if(wb_rfwe&&wb_WR!=0&&!(mem_rfwe&&mem_WR!=0&&mem_WR==ex_rS2)&&wb_WR==ex_rS2)begin//op_B MEM√∞œ’
            forwardB=2'b01;
        end
        else begin
            forwardB=2'b00;
        end
    end
end
always @(*) begin
    if(~rst_n)begin
        forwardC=1'b0;
    end
    else begin
        if(ex_rfwe&&ex_WR!=0&&ex_WR==id_rS1)begin// EX√∞œ’
            forwardC=2'b01;
        end
        else if(mem_rfwe&&mem_WR!=0&&mem_WR==id_rS1)begin//mem√∞œ’
            forwardC=2'b10;
        end
        else begin
            forwardC=2'b0;
        end
    end
end
always @(*) begin
    if(~rst_n)begin
        forwardD=1'b0;
    end
    else begin
        if(ex_rfwe&&ex_WR!=0&&ex_WR==id_rS2)begin//op_B EX√∞œ’
            forwardD=2'b01;
        end
        else if(mem_rfwe&&mem_WR!=0&&mem_WR==id_rS2)begin//op_B EX√∞œ’
            forwardD=2'b10;
        end
        else begin
            forwardD=2'b00;
        end
    end
end
endmodule
