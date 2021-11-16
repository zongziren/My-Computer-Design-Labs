`timescale 1ns / 1ps
module add
       #(parameter WIDTH = 32)
       (
           input [WIDTH - 1:0] b, a,
           output [WIDTH - 1:0] y
       );

assign y = a + b;

endmodule
