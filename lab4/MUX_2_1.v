module MUX_2_1
#(parameter Width = 32)(
input [Width-1:0] a,
input [Width-1:0] b,
input sel,
output reg [Width-1:0] out
);
always @(*)
begin
    case(sel)
        0:out = a;
        1:out = b;
    endcase        
end
endmodule
