`timescale 1ns / 1ps



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/15 22:46:14
// Design Name: 
// Module Name: display_decoder
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

module DQ(
    input wire [3:0] d, // 8421 BCD
    output reg [6:0] seg
    );

    always @* begin
        case (d)
            0: seg = 7'b0111111;
            1: seg = 7'b0000110;
            2: seg = 7'b1011011;
            3: seg = 7'b1001111;
            4: seg = 7'b1100110;
            5: seg = 7'b1101101;
            6: seg = 7'b1111101;
            7: seg = 7'b0000111;
            8: seg = 7'b1111111;
            9: seg = 7'b1101111;
            default: seg = 7'b00000000;
        endcase
        seg = ~seg;
    end

endmodule

