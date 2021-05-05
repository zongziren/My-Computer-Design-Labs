module DQ_AN(
    input wire [2:0] d, // 8421 BCD
    output reg [7:0] an
    );
    always @(*)
    begin
        case(d)
            3'd0 : an = 8'h01;
            3'd1 : an = 8'h02;
            3'd2 : an = 8'h04;
            3'd3 : an = 8'h08;
            3'd4 : an = 8'h10;
            3'd5 : an = 8'h20;
            3'd6 : an = 8'h40;
            default : an = 8'h80;
        endcase
        an = ~an;
    end
endmodule