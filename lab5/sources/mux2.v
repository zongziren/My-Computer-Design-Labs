`timescale 1ns / 1ps

module mux2
       #(parameter WIDTH = 32)
       (
           input [WIDTH - 1:0] a,
           input [WIDTH - 1:0] b,
           input sel,
           output [WIDTH - 1:0] out
       );

assign out = sel ? a : b;

endmodule
