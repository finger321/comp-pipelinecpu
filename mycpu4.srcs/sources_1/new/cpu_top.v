// Add your code here, or replace this file
module cpu_top (
    input  wire clk_i,
    input  wire rst_i,
     input wire [23:0] switch, 
     output wire [7:0] led_en,
     output wire [23:0]led,
     output wire led_ca_o,
     output wire led_cb_o,
     output wire led_cc_o,
     output wire led_cd_o,
     output wire led_ce_o,
     output wire led_cf_o,
     output wire led_cg_o,
     output wire led_dp_o
);

wire pll_clk;
wire clk_lock;

cpuclk u_cpuclk (
     .clk_in1    (clk_i),
     .locked     (clk_lock),
     .clk_out1   (pll_clk)
 );
wire [31:0]RD;
wire [31:0]dram_rd;
wire rst_n = !rst_i;
//variable of irom
wire [31:0] inst;
// variables of cpu
wire [31:0] pc;
wire [1:0]WDSel;
wire [31:0]WD;
wire [31:0]mem_op_C;
wire [31:0]mem_rD2;
wire mem_DRAM_WE;
wire [1:0]mem_WDSel;
wire [4:0]mem_WR;
wire mem_rfwe;
wire [31:0]mem_pc;
wire mem_run;
wire [31:0]trace_result;
//variables of MEM_WBReg
wire wb_rfwe;
wire [31:0]wb_wd;
wire [4:0]wb_wr;
wire [31:0]wb_pc;
wire wb_run;
prgrom imem(
    .a (pc[15:2]),
    .spo (inst)
);
CPU u_cpu(
    .clk(pll_clk),
    .rst_n(rst_n),
    .inst(inst),
    .WB_WD(wb_wd),
    .WB_RFWE(wb_rfwe),
    .WB_WR(wb_wr),
    .pc(pc),
    .mem_op_C(mem_op_C), 
    .mem_rD2(mem_rD2),
    .mem_DRAM_WE(mem_DRAM_WE),
    .mem_WDSel(mem_WDSel),
    .mem_WR(mem_WR),
    .mem_rfwe(mem_rfwe),
    .mem_pc(mem_pc),
    .mem_run(mem_run),
    .trace_result(trace_result)
);
wire [31:0]mem_wd;
assign mem_wd=(mem_WDSel==2'b00)?mem_op_C:
               (mem_WDSel==2'b01)?mem_pc+3'h4:
               (mem_WDSel==2'b10)?RD:32'b0;
MEM_WBReg u_mem_wb(
    .clk(pll_clk),
    .rst_n(rst_n),
    .mem_rfwe(mem_rfwe),  
    .mem_wd(mem_wd),
    .mem_wr(mem_WR),
    .mem_pc(mem_pc),
    .mem_run(mem_run),
    .wb_rfwe(wb_rfwe),
    .wb_wd(wb_wd),
    .wb_wr(wb_wr),
    .wb_pc(wb_pc),
    .wb_run(wb_run)
);
reg [31:0]write_addr_temp;
reg [31:0]write_data_temp;
reg flag;
always @(posedge pll_clk or negedge rst_n ) begin
    if(~rst_n)begin
        write_addr_temp<=32'b0;
    end
    else begin
        if(mem_DRAM_WE)begin
            write_addr_temp<=mem_op_C;
        end
        else begin
           write_addr_temp<=32'b0;
        end
    end
end
always @(posedge pll_clk or negedge rst_n ) begin
    if(~rst_n)begin
        write_data_temp<=32'b0;
    end
    else begin
        if(mem_DRAM_WE)begin
        write_data_temp<=mem_rD2;
        end
        else begin
        write_data_temp<=32'b0;
        end
    end
end
assign RD=(mem_op_C==write_addr_temp)?write_data_temp:dram_rd;
// wire [31:0] waddr_tmp = mem_op_C - 16'h4000;
//dram dmem(
//    .clk(pll_clk),
//    .a  (waddr_tmp[15:2]),
//    .spo(dram_rd),
//    .we (mem_DRAM_WE),
//    .d  (mem_rD2)
//);
wire [31:0] result;
BUS u_BUS(
  .clk(pll_clk),
  .rst(rst_i),
  .switch(switch),
  .addr(mem_op_C),
  .din(mem_rD2),
  .result(result),
  .wen(mem_DRAM_WE),
  .read_data(dram_rd),
  .led(led)
);
RES_DISPLAY u_res_display(
     .clk(pll_clk),
     .rst(rst_i),
     .cal_result(result),
     .led_en(led_en),
     .led_ca(led_ca_o),
     .led_cb(led_cb_o),
     .led_cc(led_cc_o),
     .led_cd(led_cd_o),
     .led_ce(led_ce_o),
     .led_cf(led_cf_o),
     .led_cg(led_cg_o),
     .led_dp(led_dp_o)
 );
endmodule
