module RF(
    input wire clk,
    // input wire rst_n,
    input wire RFWE,
    input wire[4:0] rR1,
    input wire[4:0] rR2,
    input wire[4:0] WR,
    input wire[31:0] WD,
    output wire[31:0] rD1,
    output wire[31:0] rD2,
    output wire[31:0] result
);

reg[31:0] registers[31:0];

assign rD1 = (RFWE&&WR!=0)?((WR==rR1)?WD :registers[rR1]):registers[rR1];
assign rD2 = (RFWE&&WR!=0)?((WR==rR2)?WD :registers[rR2]):registers[rR2];
assign result= registers[5'd19];

always@(posedge clk) begin
    if (RFWE == 1'b1 && WR != 5'h0) begin
        registers[WR] <= WD;
        registers[0] <= 32'h0000_0000;
    end
    else begin
        registers[0] <= 32'h0000_0000;
    end
end

endmodule