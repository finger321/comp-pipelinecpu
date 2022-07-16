module RES_DISPLAY (
    input wire         clk,
    input wire         rst,
    input wire [31: 0] cal_result,
    output reg [7: 0]  led_en,
    output reg         led_ca,
    output reg         led_cb,
    output reg         led_cc,
    output reg         led_cd,
    output reg         led_ce,
    output reg         led_cf,
    output reg         led_cg,
    output reg         led_dp
);

parameter   N = 20000; // 20000
reg [31: 0] cnt ;
wire        cnt_end = (cnt == N);
reg [31: 0] display_num ;
reg [31: 0] get_display_num;
reg [5: 0]  index;
reg [1: 0]  flag;
reg         ok;


always @(posedge clk or negedge rst) begin
    if (rst)
        cnt <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
//    else if (button)
//        cnt <= 32'b0;
    else if (cnt_end)
        cnt <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
    else
        cnt <= cnt + 1'b1;
end

always @(posedge clk or negedge rst) begin
    if (rst) begin
        {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11111111;
//        {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000000;
        led_en <= 8'b11111110;
//         led_en <= 8'b11111110;
    end
//    else if (button) begin
//        led_en <= 8'b11111110;
//        {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11111111;
//    end
    else if (cnt_end) begin
        led_en <= {led_en[6: 0], led_en[7]};
        case (led_en)
            8'b01111111: begin
                case(cal_result[3: 0])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11111110: begin
                case(cal_result[7: 4])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11111101: begin
                case(cal_result[11: 8])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11111011: begin
                case(cal_result[15: 12])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11110111: begin
                case(cal_result[19: 16])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11101111: begin
                case(cal_result[23: 20])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b11011111: begin
                case(cal_result[27: 24])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            8'b10111111: begin
                case(cal_result[31: 28])
                    4'b0000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000011; // 0
                    4'b0001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011111; // 1
                    4'b0010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00100101; // 2
                    4'b0011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00001101; // 3
                    4'b0100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10011001; // 4
                    4'b0101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01001001; // 5
                    4'b0110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01000001; // 6
                    4'b0111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011111; // 7
                    4'b1000: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00000001; // 8
                    4'b1001: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00011001; // 9
                    4'b1010: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b00010001; // A
                    4'b1011: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11000001; // b
                    4'b1100: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b11100101; // c
                    4'b1101: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b10000101; // D
                    4'b1110: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01100001; // E
                    4'b1111: {led_ca, led_cb, led_cc, led_cd, led_ce, led_cf, led_cg, led_dp} <= 8'b01110001; // F
                endcase
            end
            //default: 
        endcase
    end
end




endmodule