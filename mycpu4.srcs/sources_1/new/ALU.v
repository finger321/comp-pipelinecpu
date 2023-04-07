module ALU(
    input wire[31:0] A,
    input wire[31:0] B,
    input wire[3:0]  aluop,
    output reg branch,
    output reg[31:0] C
);
always @(*) begin
    case (aluop)
        4'b0000:begin
         C = A + B;
        end
        4'b0001:begin
         C = A + ~B + 1'b1;
        end
        4'b0010:begin
         C = A & B;
        end
        4'b0011 :begin 
         C = A | B;
        end
        4'b0100:begin
        C= A ^ B;
        end
        4'b0101:begin
         C= A << B[4:0];
         end
        4'b0110:begin
         C = A >> B[4:0];
         end
        4'b0111:begin 
         C = ($signed(A)) >>> B[4:0];
        end
        4'b1100:begin
         C = B;
        end
        default:
        C=32'b0;
    endcase
end
always @(*)begin
        case (aluop)
        4'b1000:begin
         branch = A == B ? 1'b1 : 1'b0;
        end
        4'b1001:begin
         branch = A == B ? 1'b0 : 1'b1;
        end
        4'b1010:begin
         branch = ($signed(A)) < ($signed(B)) ? 1'b1 : 1'b0;
        end
        4'b1011:begin
         branch = ($signed(A)) < ($signed(B)) ? 1'b0 : 1'b1;
        end
        default branch=1'b0;
    endcase
end


endmodule