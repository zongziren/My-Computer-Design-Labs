module DQ_SEG(
    input wire [3:0] d, // 8421 BCD
    output reg [6:0] seg
    );
    always @* 
    begin
        case (d)
            4'h0: seg = 7'b0111111;
            4'h1: seg = 7'b0000110;
            4'h2: seg = 7'b1011011;
            4'h3: seg = 7'b1001111;
            4'h4: seg = 7'b1100110;
            4'h5: seg = 7'b1101101;
            4'h6: seg = 7'b1111101;
            4'h7: seg = 7'b0000111;
            4'h8: seg = 7'b1111111;
            4'h9: seg = 7'b1101111;
            4'ha: seg = 7'b1110111;
            4'hb: seg = 7'b1111100;
            4'hc: seg = 7'b0111001;
            4'hd: seg = 7'b1011110;
            4'he: seg = 7'b1111001;
            4'hf: seg = 7'b1110001;
            default: seg = 7'b00000000;
        endcase
        seg = ~seg;
    end

endmodule