`timescale 1ns / 1ps

module control(
           input [6:0] opcode,
           output [31:0] ctrl
       );

//不同指令操作码
parameter [6:0] LW   = 7'b0000011;
parameter [6:0] ADDI = 7'b0010011;
parameter [6:0] SW   = 7'b0100011;
parameter [6:0] ADD  = 7'b0110011;
parameter [6:0] BEQ  = 7'b1100011;
parameter [6:0] JAL  = 7'b1101111;

reg m_rd;
reg m_wr;
reg jal;
reg br;
reg a_sel;
reg b_sel;
reg [1:0] a_fwd;
reg [1:0] b_fwd;
reg rf_wr;
reg [1:0] wb_sel;
reg [3:0] alu_op;

assign ctrl = {6'b0, a_fwd, 2'b0, b_fwd, 1'b0, rf_wr, wb_sel, 2'b0, m_rd, m_wr, 2'b0, jal, br, 2'b0, a_sel, b_sel, alu_op};

always @(*)
begin
    case(opcode)
        LW:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b1;
            wb_sel = 2'b01;
            m_rd   = 1'b1;
            m_wr   = 1'b0;
            jal    = 1'b0;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b1;
            alu_op = 4'b0000;
        end
        ADDI:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b1;
            wb_sel = 2'b00;
            m_rd   = 1'b0;
            m_wr   = 1'b0;
            jal    = 1'b0;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b1;
            alu_op = 4'b0000;
        end
        SW:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b0;
            wb_sel = 2'b00;
            m_rd   = 1'b0;
            m_wr   = 1'b1;
            jal    = 1'b0;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b1;
            alu_op = 4'b0000;
        end
        ADD:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b1;
            wb_sel = 2'b00;
            m_rd   = 1'b0;
            m_wr   = 1'b0;
            jal    = 1'b0;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b0;
            alu_op = 4'b0000;
        end
        BEQ:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b0;
            wb_sel = 2'b00;
            m_rd   = 1'b0;
            m_wr   = 1'b0;
            jal    = 1'b0;
            br     = 1'b1;
            a_sel  = 1'b0;
            b_sel  = 1'b0;
            alu_op = 4'b0011;
        end
        JAL:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b1;
            wb_sel = 2'b10;
            m_rd   = 1'b0;
            m_wr   = 1'b0;
            jal    = 1'b1;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b0;
            alu_op = 4'b0000;
        end
        default:
        begin
            a_fwd  = 2'b00;
            b_fwd  = 2'b00;
            rf_wr  = 1'b0;
            wb_sel = 2'b00;
            m_rd   = 1'b0;
            m_wr   = 1'b0;
            jal    = 1'b0;
            br     = 1'b0;
            a_sel  = 1'b0;
            b_sel  = 1'b0;
            alu_op = 4'b0000;
        end
    endcase
end

endmodule
