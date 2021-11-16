`timescale 1ns / 1ps

module ID_EX(
           input clk, rst, en,
           input [31:0] pc_4_e_i,
           output [31:0] pc_4_e_o,
           input [31:0] pce_i,
           output [31:0] pce_o,
           input [31:0] a_i,
           output [31:0] a_o,
           input [31:0] b_i,
           output [31:0] b_o,
           input [31:0] imm_i,
           output [31:0] imm_o,
           input [4:0] rs1_i,
           output [4:0] rs1_o,
           input [4:0] rs2_i,
           output [4:0] rs2_o,
           input [4:0] rd_i,
           output [4:0] rd_o,
           input [6:0] opcode_i,
           output [6:0] opcode_o,
           input [31:0] ctrl_i,
           output [31:0] ctrl_o
       );

register #(32) reg_pc_4_e(clk, rst, en, pc_4_e_i, pc_4_e_o);
register #(32) reg_pce(clk, rst, en, pce_i, pce_o);
register #(32) reg_a(clk, rst, en, a_i, a_o);
register #(32) reg_b(clk, rst, en, b_i, b_o);
register #(32) reg_imm(clk, rst, en, imm_i, imm_o);
register #(5) reg_rs1(clk, rst, en, rs1_i, rs1_o);
register #(5) reg_rs2(clk, rst, en, rs2_i, rs2_o);
register #(5) reg_rd(clk, rst, en, rd_i, rd_o);
register #(7) reg_opcode(clk, rst, en, opcode_i, opcode_o);
register #(32) reg_ctrl(clk, rst, en, ctrl_i, ctrl_o);

endmodule
