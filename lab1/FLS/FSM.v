`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 15:04:45
// Design Name: 
// Module Name: FSM
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



module FSM(
    input wire clk,
    input wire rst,
    input wire en,
    output reg[1:0]  control
    );

    reg [2:0] cs;
    reg [2:0] ns;
    reg last_en;


    parameter S0 =2'b00;
    parameter S1 =2'b01;
    parameter S2 =2'b10;
    // S0:复位状态
    // S1:输入了一个数
    // S2:输入了两个数

// 描述CS
    always  @(posedge clk)
    begin
        
        if (rst)   
        begin
            cs <= S0;  //同步复位  
            last_en<=0;
        end    
        else 
            begin
                cs <= ns;
                last_en<=en;
            end
            
    end
    

// 描述NS
    always  @* 
    begin        
        ns = cs;	     //默认赋值
	case (cs)            
        S0: 
        begin
            control = 0;
            if(!(last_en==0 && en==1))
                ns = S0;
            else
                ns = S1;
        end
        S1: 
        begin
            control = 1;
            if(!(last_en==0 && en==1))
                ns = S1;
            else
                ns = S2;
        end
        S2: 
        begin
            control = 2;
            if(!(last_en==0 && en==1))
                ns = S2;
            else
                ns = S2;
        end
    endcase    
    end
endmodule

