`timescale 1ns / 1ps

module shift_left
       #(parameter WIDTH = 32)
       (
           input [WIDTH - 1:0] in,
           output [WIDTH - 1:0] out
       );

assign out = in << 1;

endmodule
