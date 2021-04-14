`timescale  1ns / 1ps

module tb_TOP_ALU;

// TOP_ALU Parameters
parameter PERIOD = 10;
parameter WIDTH  = 32;

// TOP_ALU Inputs
reg   en                                   = 0 ;
reg   clk                                  = 0 ;
reg   [1:0]  sel                           = 0 ;
reg   [WIDTH-1:0]  x                       = 0 ;

// TOP_ALU Outputs
wire  [WIDTH-1:0]  y                       ;
wire  zf                                   ;
wire  cf                                   ;
wire  of                                   ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end


TOP_ALU #(
    .WIDTH ( WIDTH ))
 u_TOP_ALU (
    .en                      ( en               ),
    .clk                     ( clk              ),
    .sel                     ( sel  [1:0]       ),
    .x                       ( x    [WIDTH-1:0] ),

    .y                       ( y    [WIDTH-1:0] ),
    .zf                      ( zf               ),
    .cf                      ( cf               ),
    .of                      ( of               )
);
initial
begin
    sel = 1;
    #40
    sel = 2;
    #40
    sel = 0;

end

initial
begin
    x = 32'hffffff;
    #40
    x = 32'h1;
    #40
    x = 0;//add
    #40
    x = 1;//sub
    #40
    x = 2;//and
    #40
    x = 3;//or
    #40
    x = 4;//xor
    #40
    x = 5;//not
end


initial
begin
    en = 1;
    #20
    en = 0;
    #20
    en = 1;
    #20
    en = 0;
    #20
    en = 1;
    #20
    en = 0;
    #20
    en = 1;
    #20
    en = 0;
    #20
    en = 1;
    #20
    en = 0;
    #20
    en = 1;
end

endmodule;

