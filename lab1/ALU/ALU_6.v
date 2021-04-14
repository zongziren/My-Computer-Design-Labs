`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:USTC
// Engineer:PB19000362 zsr 
// 
// Create Date: 2021/03/31 18:52:12
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
module  TOP_ALU #(
parameter WIDTH = 6 	//数据宽度
)(
input wire en,
input wire clk,
input wire [1:0] sel,       //选择输入信号类型  0：输入给f信号 1:输入给a信号 2:输入给b信号
input wire [WIDTH-1:0] x,	//输入数

output wire [WIDTH-1:0] y, 	//运算结果
output wire zf, 		//零标志
output wire cf, 		//进位/借位标志
output wire of 		//溢出标志
);
wire ef,ea,eb;
wire [WIDTH-1:0] a,b;
wire [2:0] f;

Decode Decode1(en,sel,ef,ea,eb);
register_3 register_f(clk,ef,x[2:0],f);
register_6 register_a(clk,ea,x,a);
register_6 register_b(clk,eb,x,b);
ALU ALU1(a,b,f,y,zf,cf,of);
endmodule

module  Decode #(
parameter WIDTH = 6 	//数据宽度
)(
input wire en,
input wire [1:0] sel,
output reg ef, 		//f使能
output reg ea, 		//a使能
output reg eb 		//b使能
);
always@(*)
begin
    if(en==1)
    begin
        case(sel)
            2'b00:
            begin
                ef=1;
                ea=0;
                eb=0;
            end
            2'b01:
            begin
                ef=0;
                ea=1;
                eb=0;
            end
            2'b10:
            begin
                ef=0;
                ea=0;
                eb=1;
            end
            default:
            begin
                ef=0;
                ea=0;
                eb=0;
            end
        endcase
    end
    else
    begin
        ef=0;
        ea=0;
        eb=0;
    end
end
endmodule

module  register_6#(
    parameter WIDTH = 6
    )(
    input wire clk, en,
    input wire [WIDTH-1 : 0]  d,
    output reg  [WIDTH-1 : 0] q
    );
    always @(posedge clk)
    begin
        if (en)
        q <= d;  
    end
endmodule

module  register_3#(
    parameter WIDTH = 3
    )(
    input wire clk, en,
    input wire [WIDTH-1 : 0]  d,
    output reg  [WIDTH-1 : 0] q
    );
    always @(posedge clk)
    begin
        if (en)
        q <= d;  
    end
endmodule

module  ALU #(
parameter WIDTH = 6 	//数据宽度
)(
input wire [WIDTH-1:0] a, b,	//两操作数
input wire [2:0] s,	//操作选择
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
wire [WIDTH-1:0]tmpt_add_y,tmpt_sub_y,tmpt_and_y,tmpt_or_y,tmpt_xor_y,tmpt_not_y;
ADD add1(a,b,tmpt_add_y,tmpt_add_zf,tmpt_add_cf,tmpt_add_of);
SUB sub1(a,b,tmpt_sub_y,tmpt_sub_zf,tmpt_sub_cf,tmpt_sub_of);
AND and1(a,b,tmpt_and_y,tmpt_and_zf,tmpt_and_cf,tmpt_and_of);
OR or1(a,b,tmpt_or_y,tmpt_or_zf,tmpt_or_cf,tmpt_or_of);
XOR xor1(a,b,tmpt_xor_y,tmpt_xor_zf,tmpt_xor_cf,tmpt_xor_of);
NOT not1(a,b,tmpt_not_y,tmpt_not_zf,tmpt_not_cf,tmpt_not_of);
always@(*)
begin
case (s)
    3'b000:begin
            y=tmpt_add_y;
            zf=tmpt_add_zf;
            cf=tmpt_add_cf;
            of=tmpt_add_of;
            end
	3'b001:begin
            y=tmpt_sub_y;
            zf=tmpt_sub_zf;
            cf=tmpt_sub_cf;
            of=tmpt_sub_of;
            end
	3'b010:begin
	        y=tmpt_and_y;
            zf=tmpt_and_zf;
            cf=tmpt_and_cf;
            of=tmpt_and_of;
            end
    3'b011:begin
	        y=tmpt_or_y;
            zf=tmpt_or_zf;
            cf=tmpt_or_cf;
            of=tmpt_or_of;
            end
	3'b100:begin
	    y=tmpt_xor_y;
            zf=tmpt_xor_zf;
            cf=tmpt_xor_cf;
            of=tmpt_xor_of;
            end
	3'b101:begin
	    y=tmpt_not_y;
            zf=tmpt_not_zf;
            cf=tmpt_not_cf;
            of=tmpt_not_of;
            end
	default:begin
            y = 0;
            of =0;
            cf =0;
            zf =1;
            end
endcase
end
endmodule

module ADD#(
parameter WIDTH = 6 	//数据宽度
)(   
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
{cf,y}=a+b;
of = (a[WIDTH-1]==b[WIDTH-1])&&(a[WIDTH-1]!=y[WIDTH-1]);
zf = y==0?1:0;
end
endmodule

module SUB#(
parameter WIDTH = 6 	//数据宽度
)(   
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
{cf,y}=a-b;
of = (a[WIDTH-1]!=b[WIDTH-1])&&(a[WIDTH-1]!=y[WIDTH-1]);
zf = y==0?1:0;
end
endmodule

module AND#(
parameter WIDTH = 6 	//数据宽度
)(
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
y=a&b;
of =0;
cf =0;
zf = y==0?1:0;
end
endmodule

module OR#(
parameter WIDTH = 6  	//数据宽度
)(
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
y=a|b;
of =0;
cf =0;
zf = y==0?1:0;
end
endmodule

module XOR#(
parameter WIDTH = 6 	//数据宽度
)(
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
y=a^b;
of =0;
cf =0;
zf = y==0?1:0;
end
endmodule

module NOT#(
parameter WIDTH = 6 	//数据宽度
)(
input wire [WIDTH-1:0] a, b,	//两操作数
output reg [WIDTH-1:0] y, 	//运算结果
output reg zf, 		//零标志
output reg cf, 		//进位/借位标志
output reg of 		//溢出标志
);
always@(*)
begin
y=~a;
of =0;
cf =0;
zf = y==0?1:0;
end
endmodule






