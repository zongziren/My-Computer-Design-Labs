`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 14:58:29
// Design Name: 
// Module Name: FLS
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


module FLS(
	input  wire clk, rst, en, 
	input  wire [7 : 0] d,
	output reg [7 : 0]  f,
	output reg cf
    );
wire [1:0]control;
FSM FSM1(clk,rst,en,control);
reg last_en;
reg [7 : 0] a;
reg [7 : 0] b;

wire [7 : 0] sum_ab;
wire sum_ab_cf;
ADD ADD1(a,b,sum_ab,sum_ab_cf);

always  @(posedge clk)
begin
	if (rst)   
        begin
            a <= 0;  //同步复位 
			b <= 0; 
            last_en<=0;
			f<=0;
        end 
	else
		last_en<=en;
	if(last_en==0 && en==1)
	begin
		case(control)
			2'b00:
			begin
            cf<=0;
			f<=d;
			a<=d;
        	end
			2'b01:
			begin
			cf<=0;
			f<=d;
			b<=d;	
			end
			2'b10:
			begin
			f<=sum_ab;
			cf<=sum_ab_cf;
			a<=b;
			b<=sum_ab;	
			end

		endcase
	end	
end

endmodule
