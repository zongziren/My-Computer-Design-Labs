`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 14:24:22
// Design Name: 
// Module Name: fifo_tb
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
module fifo_tb();

reg clk, rst, enq, deq;
reg [3:0]in;
wire [3:0]out;
wire emp,full;
wire [7:0]an;
wire [7:0]seg;


FIFO myfifo(
.clk(clk), 
.rst(rst), 
.in(in), 
.enq(enq), 
.deq(deq), 
.out(out), 
.emp(emp),
.full(full),
.an(an),
.seg(seg)
);

initial 
begin
	rst = 0;
	#1 rst = 1;
	#1 rst = 0;
end

initial
begin
clk = 0;
forever #5 clk  = ~clk;
end

initial 
begin
        
        enq = 0;
        deq = 0;
        #30;

        enq = 1;
        deq = 0;
        #2040_1111;
        

        enq = 0;
        deq = 0;
        #2040_1111;
      

        enq = 1;
        deq = 0;
        #2020_2222;

    
        enq = 0;
        deq = 0;
        #2020_2222;
 
        enq = 1;
        deq = 0;
        #2040_1111;
        

        enq = 0;
        deq = 0;
        #2040_1111;
     
     
        enq = 1;
        deq = 0;
        #2020_3333;

     
        enq = 0;
        deq = 0;
        #2020_3333;

        enq = 1;
        deq = 0;
        #2020_3333;

     
        enq = 0;
        deq = 0;
        #2020_3333;
        
         
        enq = 1;
        deq = 0;
        #2040_1111;
        

        enq = 0;
        deq = 0;
        #2040_1111;
     
     
        enq = 1;
        deq = 0;
        #2020_3333;

     
        enq = 0;
        deq = 0;
        #2020_3333;

        enq = 1;
        deq = 0;
        #2020_3333;

     
        enq = 0;
        deq = 0;
        #2020_3333;
        
        enq = 1;
        deq = 0;
        #2020_3333;

     
        enq = 0;
        deq = 0;
        #2020_3333;
        
        enq = 0;
        deq = 1;
        #2020_4444;
        
    
        enq = 0;
        deq = 0;
        #2020_4444;

      
        enq = 0;
        deq = 1;
        #2020_6666;

        
        enq = 0;
        deq = 0;
        #2020_6666;

        
        enq = 1;
        deq = 0;
        #2020_7777;

        
        enq = 0;
        deq = 0;
        #2020_7777;
        
        
        enq = 0;
        deq = 1;
        #2020_7777;
        
        
        enq = 0;
        deq = 0;
        #2020_7777;   
end

initial 
 begin
     in = 4'b1001;
     #40000000;
     
     in = 4'b0010;
     #40000000;

     in = 4'b1110;
     #40000000;
     
     in = 4'b0111;
     #40000000;
     
     in = 4'b0010;
     #40000000;
     
     in = 4'b0011;
     #40000000;
     
     in = 4'b1000;
     #40000000;
     
     in = 4'b0001;
     #40000000;
     
  end


endmodule 