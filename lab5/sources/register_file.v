`timescale 1ns / 1ps

module register_file
       #(parameter WIDTH = 32, ADDR = 5, DEPTH = 32)
       (input clk,
        input [ADDR - 1:0] ra0,
        output [WIDTH - 1:0] rd0,
        input [ADDR - 1:0] ra1,
        output [WIDTH - 1:0] rd1,
        input [ADDR - 1:0] ra2,
        output [WIDTH - 1:0] rd2,
        input [ADDR - 1:0] wa,
        input we,
        input [WIDTH - 1:0] wd
       );

reg [WIDTH - 1:0] regfile[0:DEPTH - 1];

assign rd0 = we && wa == ra0 ? wd : regfile[ra0];
assign rd1 = we && wa == ra1 ? wd : regfile[ra1];
assign rd2 = we && wa == ra2 ? wd : regfile[ra2];

initial
begin
    regfile[0] = {WIDTH{1'b0}};
end

always @(posedge clk)
begin
    if (we && wa)
    begin
        regfile[wa] <= wd;
    end
end

endmodule
