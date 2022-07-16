`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/29 15:22:51
// Design Name: 
// Module Name: SEXT
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


module SEXT(
    input wire [24:0] din,
    input wire [2:0]  extop,
    output wire [31:0] ext
);


assign ext = (extop == 3'b000) ? 32'b0 :
             (extop == 3'b001) ? (din[24] == 1'b1 ? {20'b1111_1111_1111_1111_1111, din[24:13]} : {20'b0000_0000_0000_0000_0000, din[24:13]}) :
             (extop == 3'b010) ? (din[24] == 1'b1 ? {20'b1111_1111_1111_1111_1111, din[24:18], din[4:0]} : {20'b0000_0000_0000_0000_0000, din[24:18], din[4:0]})   :
             (extop == 3'b011) ? (din[24] == 1'b1 ? {19'b1111_1111_1111_1111_111, din[24], din[0], din[23:18], din[4:1], 1'b0} : {19'b0000_0000_0000_0000_000, din[24], din[0], din[23:18], din[4:1], 1'b0})  :
             (extop == 3'b100) ? {din[24:5], 12'b0000_0000_0000} : 
                                   (din[24] == 1'b1 ? {11'b1111_1111_111, din[24], din[12:5], din[13], din[23:14], 1'b0} : {11'b0000_0000_000, din[24], din[12:5], din[13], din[23:14], 1'b0});
endmodule