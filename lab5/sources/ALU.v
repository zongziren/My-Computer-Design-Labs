`timescale 1ns / 1ps

module alu
       #(parameter WIDTH = 32)
       (
           input [WIDTH - 1:0] a, b,
           input [3: 0] sel,
           output reg [WIDTH - 1:0] out,
           output z
       );

assign z = ~out;

always @(*)
begin
    case (sel)
        4'b0000:
        //add
            out = a + b;
        4'b0001:
        //or
            out = a | b;
        4'b0010:
        //and
            out = a & b;
        4'b0011:
        //sub
            out = a - b;
        default:
            out = 1'b0;
    endcase
end

endmodule
