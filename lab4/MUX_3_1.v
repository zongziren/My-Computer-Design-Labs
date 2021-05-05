module MUX_3_1
#(parameter Width = 32)(
input [Width-1:0] a,
input [Width-1:0] b,
input [Width-1:0] c,
input [1:0] sel,
output reg [Width-1:0] out
);
always @(*)
begin
    case(sel)
        2'b00:out=a;
        2'b01:out=b;
        2'b10:out=c;
        default:out=0;   
    endcase        
end
endmodule