`timescale 1ns / 1ps

module HAZARD(
           input PCSrc,
           input [4:0] rs1,
           input [4:0] rs2,
           input [6:0] opcode,
           input [4:0] rd,
           input m_rd,
           input wbm,
           input wbw,
           output reg fstall,
           output reg dstall,
           output reg dflush,
           output reg eflush
       );

always @(*)
begin
    if (PCSrc)
    begin
        fstall = 1'b0;
        dstall = 1'b0;
        dflush = 1'b1;
        eflush = 1'b1;
    end
    else if (m_rd && rd && (rd == rs1 || rd == rs2))
    begin
        dflush = 1'b0;
        eflush = 1'b1;
        fstall = 1'b1;
        dstall = 1'b1;
    end
    else
    begin
        dflush = 1'b0;
        eflush = 1'b0;
        fstall = 1'b0;
        dstall = 1'b0;
    end
end

endmodule
