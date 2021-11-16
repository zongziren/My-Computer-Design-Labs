`timescale 1ns / 1ps

module MEM_WB(
           input clk, rst, en,
           input [31:0] pc_4_w_i,
           output [31:0] pc_4_w_o,
           input [31:0] ym_i,
           output [31:0] ym_o,
           input [31:0] mdr_i,
           output [31:0] mdr_o,
           input [4:0] rdw_i,
           output [4:0] rdw_o,
           input [31:0] ctrlw_i,
           output [31:0] ctrlw_o
       );

register #(32) reg_pc_4_w(clk, rst, en, pc_4_w_i, pc_4_w_o);
register #(32) reg_ym(clk, rst, en, ym_i, ym_o);
register #(32) reg_mdr(clk, rst, en, mdr_i, mdr_o);
register #(5) reg_rdw(clk, rst, en, rdw_i, rdw_o);
register #(32) reg_ctrlw(clk, rst, en, ctrlw_i, ctrlw_o);

endmodule
