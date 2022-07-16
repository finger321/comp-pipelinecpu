module PC (
    input wire clk,
    input wire rst_n,
    input wire stop,
    input wire[31:0] next_pc,
    output reg[31:0] pc
//    output reg next_iter
);

reg flag;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        pc <= 32'h0000_0000;
        flag <= 1'b1;
    end
    else begin
        if(!stop)begin
            if (flag == 1'b1) begin
                pc <= 32'h0000_0000;
                flag <= 1'b0;
            end
            else begin
            pc <= next_pc;
            end
        end
        else begin
            flag<=1'b0;
        end
    end
end

endmodule