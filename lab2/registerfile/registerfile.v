`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021
// Design Name: 
// Module Name: register
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


module register
#(parameter WIDTH = 32,parameter WORD_LINE = 3)
(
input wire clk,
input wire we,
input wire [WORD_LINE-1:0] wa, ra0, ra1,
input wire [WIDTH-1:0] wd,
output wire [WIDTH-1:0] rd0, rd1
    );
reg  [WIDTH-1:0] regfile [0:(1 << WORD_LINE) - 1];
assign  rd0 = regfile [ra0],
    	rd1 = regfile [ra1];
always @(posedge clk)
begin   
        if (we)
            regfile [wa]  <=  wd;
end    

endmodule
