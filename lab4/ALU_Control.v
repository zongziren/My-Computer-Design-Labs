`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/04 22:53:42
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(
    input [1:0] ALUop,
    input [6:0] func7,
    input [2:0] func3,
    output reg [2:0] ALU_ctl_input
    );
      always @(*) 
    begin
        case (ALUop)
            2'b01: ALU_ctl_input=3'd1;
            default: ALU_ctl_input=3'd0;
        endcase   
    end
endmodule
