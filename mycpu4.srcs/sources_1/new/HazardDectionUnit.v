`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/12 17:11:52
// Design Name: 
// Module Name: HazardDectionUnit
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


module HazardDectionUnit(
    input wire rst_n,
    input wire ex_mem_read,
    input wire[4:0] ex_WR,
    input wire [4:0]id_rS1,
    input wire [4:0]id_rS2,
    output reg stall
    );
always @(*) begin
    if(~rst_n)begin
        stall=1'b0;
    end
    else begin
        if(ex_mem_read&&((ex_WR==id_rS1)||(ex_WR==id_rS2)))begin
        stall=1'b1;
        end
        else begin
        stall=1'b0;
        end
    end
end
endmodule
