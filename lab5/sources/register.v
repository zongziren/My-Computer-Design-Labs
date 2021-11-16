`timescale 1ns / 1ps

module register
       #(parameter WIDTH = 32)
       (
           input clk, rst, en,
           input [WIDTH - 1:0] in,
           output reg [WIDTH - 1:0] out
       );

always @(posedge clk)
begin
    if (rst)
    begin
        out <= {WIDTH{1'b0}};
    end
    else if (en)
    begin
        out <= in;
    end
end

endmodule
