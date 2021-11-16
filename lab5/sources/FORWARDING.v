module FORWARDING(
           input [4:0] rs1,
           input [4:0] rs2,
           input wbm,
           input wbw,
           input [4:0] rdm,
           input [4:0] rdw,
           output reg [1:0] a_fwd,
           output reg [1:0] b_fwd
       );

always @(*)
begin
    if (wbm && rdm && rs1 == rdm)
    begin
        a_fwd = 2'b01;
    end
    else if (wbw && rdw && rs1 == rdw)
    begin
        a_fwd = 2'b10;
    end
    else
    begin
        a_fwd = 2'b00;
    end

    if (wbm && rdm && rs2 == rdm)
    begin
        b_fwd = 2'b01;
    end
    else if (wbw && rdw && rs2 == rdw)
    begin
        b_fwd = 2'b10;
    end
    else
    begin
        b_fwd = 2'b00;
    end
end

endmodule
