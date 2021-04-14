`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 17:36:24
// Design Name: 
// Module Name: tb_FLS
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
//~ `New testbench
`timescale  1ns / 1ps

module tb_FLS;

// FLS Parameters
parameter PERIOD  = 10;


// FLS Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   en                                   = 0 ;
reg   [7 : 0]  d                           = 0 ;

// FLS Outputs
wire  [7 : 0]  f                           ;
wire  cf                                   ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    rst = 1;
    #8 
    rst  =  0;
end

FLS  u_FLS (
    .clk                     ( clk          ),
    .rst                     ( rst          ),
    .en                      ( en           ),
    .d                       ( d    [7 : 0] ),

    .f                       ( f    [7 : 0] ),
    .cf                      ( cf           )
);

initial
begin
    en = 0;
    #3
    en = 1;
    #25
    en = 0;
    #10
    en = 1;
    #11
    en = 0;
    #11
    en = 1;
    #10
    en = 0;
    #10
    en = 1;
    #10
    en = 0;
    #10
    en = 1;
end

initial 
begin
    d=2;
    #34
    d=3;
end

endmodule


