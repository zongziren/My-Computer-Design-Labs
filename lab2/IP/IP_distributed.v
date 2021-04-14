`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 18:28:51
// Design Name: 
// Module Name: IP_distributed
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


module IP_distributed(
    input wire [3 : 0] a,
    input wire [7 : 0] d,
    input wire clk,
    input wire we,
    output wire [7 : 0] spo
    );
dist_mem_gen_0   my_dist_mem (
  .a(a),        	
  .d(d),        
  .clk(clk),    	
  .we(we),      
  .spo(spo)    
);
endmodule

