`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 19:47:25
// Design Name: 
// Module Name: IP2
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


module IP_BLOCK(
    input wire [3 : 0] a,
    input wire [7 : 0] d,
    input wire clk,
    input wire we,
    input wire en,
    output wire [7 : 0] spo
    );
blk_mem_gen_0   my_blk_mem (.addra(a),.clka(clk),.dina(d),.douta(spo),.ena(en),.wea(we));      	  	
endmodule
