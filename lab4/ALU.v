module  ALU
    #(parameter WIDTH = 32)(
    input [WIDTH -1: 0]  a, b,
    input [2:0] s,
    output reg[WIDTH -1: 0] y,
    output zf
    );
    localparam ADD=3'd0,SUB=3'd1;
    reg tempt;
    always @(*)
    begin
        case(s)
            ADD:{tempt,y} =a + b;
            SUB:{tempt,y} =a - b;
            default:y=0;
        endcase
    end

    assign zf = ~|y;
endmodule
