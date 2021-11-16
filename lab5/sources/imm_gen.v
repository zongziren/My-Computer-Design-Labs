`timescale 1ns / 1ps

module imm_gen(
           input [31:0] ins,
           output reg [31:0] imm
       );

parameter [6:0] LW   = 7'b0000011;
parameter [6:0] ADDI = 7'b0010011;
parameter [6:0] SW   = 7'b0100011;
parameter [6:0] ADD  = 7'b0110011;
parameter [6:0] BEQ  = 7'b1100011;
parameter [6:0] JAL  = 7'b1101111;

always @(*)
begin
    case (ins[6:0])
        LW:
        begin
            imm = {{20{ins[31]}}, ins[31:20]};
        end
        ADDI:
        begin
            imm = {{20{ins[31]}}, ins[31:20]};
        end
        SW:
        begin
            imm = {{20{ins[31]}}, ins[31:25], ins[11:7]};
        end
        BEQ:
        begin
            imm = {{20{ins[31]}}, ins[31], ins[7], ins[30:25], ins[11:8]};
        end
        JAL:
        begin
            imm = {{12{ins[31]}}, ins[31], ins[19:12], ins[20], ins[30:21]};
        end
        default:
        begin
            imm = 32'h00000000;
        end
    endcase
end

endmodule
