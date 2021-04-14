`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 15:01:05
// Design Name: 
// Module Name: ALU
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
module ADD#(
parameter WIDTH = 8 	//数据宽度
)(   
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg cf		//进位/借位标志
);
always@(*)
begin
{cf,y}=a+b;
end
endmodule
