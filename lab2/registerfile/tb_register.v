`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 19:11:46
// Design Name: 
// Module Name: tb_register
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


module tb_register#(parameter WIDTH = 32,parameter WORD_LINE = 3);

reg clk;
reg we;
reg [WORD_LINE-1:0] wa, ra0, ra1;
reg [WIDTH-1:0] wd;
wire [WIDTH-1:0] rd0, rd1;

register my_reg(clk,we,wa,ra0,ra1,wd,rd0,rd1);

initial
begin
clk = 0;
forever #5 clk  = ~clk;
end

initial
begin
ra0 = 0;
#40
ra0 = 1;
#40 
ra0 = 2;
#40
ra0 = 3;
end

initial
begin
ra1 = 2;
#40
ra1 = 5;
#40 
ra1 = 6;
#40
ra1 = 7;
#40
ra1 = 1;
end

initial
begin
we = 0;
#10
we = 1;
end

initial
begin
wa = 0;
#10
wa = 1;
#10
wa = 2;
#10
wa = 3;
#10
wa = 4;
#10
wa = 5;
#10
wa = 6;
#10
wa = 7;
end

initial
begin
wd = 20;
#10
wd = 10;
#10
wd = 30;
end

endmodule
