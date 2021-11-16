`timescale 1ns / 1ps

module IF_ID(
           input clk, rst, en,
           input [31:0] pc_4_d_i,
           output [31:0] pc_4_d_o,
           input [31:0] pcd_i,
           output [31:0] pcd_o,
           input [31:0] ir_i,
           output [31:0] ir_o
       );

register #(32) reg_pc_4_d(clk, rst, en, pc_4_d_i, pc_4_d_o);
register #(32) reg_pcd(clk, rst, en, pcd_i, pcd_o);
register #(32) reg_ir(clk, rst, en, ir_i, ir_o);

endmodule
