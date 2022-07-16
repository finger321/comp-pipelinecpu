`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/09 13:26:13
// Design Name: 
// Module Name: BUS
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


module BUS(
  input wire clk,
  input wire rst,
  input wire[23:0]switch,
  input wire[31:0] addr,
  input wire[31:0] din,
  input wire wen,
  output reg [31:0]result,
  output reg[31:0] read_data,
  output reg[23:0] led
    );
wire [31:0]spo;

wire we;
reg we_g;
assign we=we_g;

//read
always@ (*)begin
    if(!wen)begin
        if(addr==32'hFFFF_F070)begin
        read_data={8'b0000_0000,switch};
    end
    else begin
        read_data=spo;
    end
    
    end
end
//write
always@ (posedge clk)begin
    if(wen)begin
      if(addr==32'hFFFF_F000)begin
        result=din;
        we_g=1'b0;
      end
      else if(addr==32'hFFFF_F060)begin
        led=din[23:0];
        we_g=1'b0; 
      end
      else we_g=1'b1;
    end
    else begin
    we_g=1'b0;
    end
end
wire [31:0]waddr_tmp = addr- 16'h4000;
dram dmem(
    .clk(clk),
    .a  (waddr_tmp[15:2]),
    .spo(spo),
    .we (we),
    .d  (din)
);   
//RES_DISPLAY u_res_display(
//    .clk(clk),
//    .rst(rst),
//    .cal_result(result),
//    .led_en(led_en),
//    .led_ca(led_ca_o),
//    .led_cb(led_cb_o),
//    .led_cc(led_cc_o),
//    .led_cd(led_cd_o),
//    .led_ce(led_ce_o),
//    .led_cf(led_cf_o),
//    .led_cg(led_cg_o),
//    .led_dp(led_dp_o)
//);
endmodule
