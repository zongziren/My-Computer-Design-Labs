`timescale 1ns / 1ps

module EX_MEM(
           input clk, rst, en,
           input [31:0] pc_4_m_i,
           output [31:0] pc_4_m_o,
           input [31:0] y_i,
           output [31:0] y_o,
           input [31:0] bm_i,
           output [31:0] bm_o,
           input [4:0] rdm_i,
           output [4:0] rdm_o,
           input [31:0] ctrlm_i,
           output [31:0] ctrlm_o
       );

register #(32) reg_bm(clk, rst, en, bm_i, bm_o);
register #(5) reg_rdm(clk, rst, en, rdm_i, rdm_o);
register #(32) reg_ctrlm(clk, rst, en, ctrlm_i, ctrlm_o);
register #(32) reg_pc_4_m(clk, rst, en, pc_4_m_i, pc_4_m_o);
register #(32) reg_y(clk, rst, en, y_i, y_o);


endmodule
