`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/11 16:17:08
// Design Name: 
// Module Name: IF_IDReg
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


module IF_IDReg(
 input wire clk,
 input wire rst_n,
 input wire IF_ID_flush,
 input wire if_run,
 input wire stop,
 input wire[31:0]if_pc,
 input wire[31:0]if_inst,
 output reg[31:0]id_inst,
 output reg[31:0]id_pc,
 output reg id_run
    );
reg flag1;
reg flag2;
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        id_pc<=32'b0;
        flag1<=1'b1;
    end
    else if(IF_ID_flush)begin
        id_pc<=32'b0;
    end
    else begin
        if(!stop)begin
           if(flag1)begin
            id_pc<=32'b0;
            flag1<=1'b0;
           end
           else begin
           id_pc<=if_pc;
           end
        end
        else begin
        flag1<=1'b0;
        end
    end
end
    
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        id_inst<=32'b0;
        flag2<=1'b1;
    end
    else if(IF_ID_flush)begin
        id_inst<=32'b0;
    end
    else begin
        if(!stop)begin
           if(flag2)begin
            id_inst<=32'b0;
            flag2<=1'b0;
           end
           else begin
           id_inst<=if_inst;
           end
        end
        else begin
        flag2=1'b0;
        end
    end
end    
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        id_run<=1'b0;
    end
    else if(IF_ID_flush)begin
        id_run<=1'b0;
    end
    else  begin
            id_run<=if_run;
    end
end

endmodule
