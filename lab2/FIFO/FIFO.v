`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/08 17:04:32
// Design Name: 
// Module Name: FIFO
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


module FIFO(
    input clk, rst,  //时钟（上升沿有效）、同步复位（高电平有效）
    input enq, 		//入队列使能，高电平有效
    input [3:0] in,	//入队列数据
    input deq,		//出队列使能，高电平有效
    output [3:0] out, 	//出队列数据
    output [7:0] an,	//数码管选择
    output [7:0] seg,	//数码管数据
    output wire emp,    //空队标志
    output wire full    //满队标志
    );
    
    wire [2:0] ra0;
    wire [3:0] rd0;
    wire [2:0] ra1;
    wire [3:0] rd1;
    wire [2:0] wa;
    wire [3:0] wd;
    wire we;
    wire [7:0] valid;
    wire [2:0] head;

    LCU my_LCU(clk, rst, enq , deq , in, rd0, ra0, we, wa, wd, out, emp, full, head, valid);
    RF #(4,3) my_RF(clk, we, wa, ra0, ra1, wd, rd0, rd1);
    SDU my_SDU(clk, rst, head, valid, rd1, ra1, an, seg);

endmodule