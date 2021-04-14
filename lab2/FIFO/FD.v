`timescale 1ns / 1ps

module Freq_divider //分频
    #(parameter DIVIDE = 100000)(
    input wire clk, 
    input wire rst, 
    output reg clkd
    );

    reg [31:0] count;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            count <= 0;
            clkd <= 0;
        end
        else if (clk) begin
            if (count == DIVIDE - 1) count <= 0;
            else count <= count + 1;
            if (count >= DIVIDE / 2) clkd <= 1;
            else clkd <= 0;
        end
    end
    
endmodule

