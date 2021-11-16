`timescale 1ns / 1ps

module mux3
       #(parameter WIDTH = 32)
       (
           input [WIDTH - 1:0] in0,
           input [WIDTH - 1:0] in1,
           input [WIDTH - 1:0] in2,
           input [1:0] sel,
           output reg [WIDTH - 1:0] out
       );

always @(*)
begin
    case (sel)
        2'b00:
        begin
            out = in0;
        end
        2'b01:
        begin
            out = in1;
        end
        2'b10:
        begin
            out = in2;
        end
        default:
        begin
            out = {WIDTH{1'b0}};
        end
    endcase
end

endmodule
