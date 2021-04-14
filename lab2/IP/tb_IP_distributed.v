`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 19:27:38
// Design Name: 
// Module Name: tb_IP_distributed
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


module tb_IP_distributed;

reg [3 : 0] a;
reg [7 : 0] d;
reg clk;
reg we;
wire [7 : 0] spo;

IP_distributed my_ip(a,d,clk,we,spo);
initial
begin
clk = 0;
forever #5 clk  = ~clk;
end

initial
begin
we = 0;
#10
we = 1;
#40
we = 0;
end

initial
begin
a = 0;
#10
a = 1;
#10 
a = 2;
#10
a = 3;
#10 
a = 4;
#40
a = 0;
#10 
a = 1;
#10 
a = 2;
#10 
a = 3;
end

initial
begin
d = 5;
#10
d = 12;
#10 
d = 7;
#10
d = 8;
#10 
d = 9;
end


endmodule
