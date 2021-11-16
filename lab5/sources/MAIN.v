`timescale 1ns / 1ps

module top(
    input clk, rst,

    //选择CPU工作方式;
    input run, step,
    input valid,
    input [4:0] in,

     //输出led和seg 
    output [1:0] check,
    output [4:0] out0,
    output [7:0] an,
    output [6:0] seg,
    output ready
       );
    //CPU_CLK
    wire clk_cpu;

    //IO_BUS
    wire [7:0] io_addr;
    wire [31:0] io_dout;
    wire io_we;
    wire [31:0] io_din;

    //Debug_BUS
    wire [7:0] m_rf_addr;
    wire [31:0] rf_data;
    wire [31:0] m_data;
    wire [31:0] pcin, pc, pcd, pce;
    wire [31:0] ir, imm, mdr;
    wire [31:0] a, b, y, bm, yw;
    wire [4:0] rd, rdm, rdw;
    wire [31:0] ctrl, ctrlm, ctrlw;

    //SEG and AN from PDU
    wire [2:0] an_from_PDU;     
    wire [3:0] seg_from_PDU;

    CPU  MY_CPU (
    .clk                     ( clk_cpu           ),
    .rst                     ( rst               ),
    .io_din                  ( io_din     [31:0] ),
    .m_rf_addr               ( m_rf_addr  [7:0]  ),

    .io_addr                 ( io_addr    [7:0]  ),
    .io_dout                 ( io_dout    [31:0] ),
    .io_we                   ( io_we             ),
    .rf_data                 ( rf_data    [31:0] ),
    .m_data                  ( m_data     [31:0] ),
    .pc                      ( pc         [31:0] ),
    .pcd                     ( pcd        [31:0] ),
    .ir                      ( ir         [31:0] ),
    .pcin                    ( pcin       [31:0] ),
    .pce                     ( pce        [31:0] ),
    .a                       ( a          [31:0] ),
    .b                       ( b          [31:0] ),
    .imm                     ( imm        [31:0] ),
    .rd                      ( rd         [4:0]  ),
    .ctrl                    ( ctrl       [31:0] ),
    .y                       ( y          [31:0] ),
    .bm                      ( bm         [31:0] ),
    .rdm                     ( rdm        [4:0]  ),
    .ctrlm                   ( ctrlm      [31:0] ),
    .yw                      ( yw         [31:0] ),
    .mdr                     ( mdr        [31:0] ),
    .rdw                     ( rdw        [4:0]  ),
    .ctrlw                   ( ctrlw      [31:0] )
   );

PDU  u_PDU (
    .clk                     ( clk                        ),
    .rst                     ( rst                        ),
    .run                     ( run                        ),
    .step                    ( step                       ),
    .valid                   ( valid                      ),
    .in                      ( in                  [4:0]  ),
    .io_addr                 ( io_addr             [7:0]  ),
    .io_dout                 ( io_dout             [31:0] ),
    .io_we                   ( io_we                      ),
    .rf_data                 ( rf_data             [31:0] ),
    .m_data                  ( m_data              [31:0] ),
    .pcin                    ( pcin                [31:0] ),
    .pc                      ( pc                  [31:0] ),
    .pcd                     ( pcd                 [31:0] ),
    .pce                     ( pce                 [31:0] ),
    .ir                      ( ir                  [31:0] ),
    .imm                     ( imm                 [31:0] ),
    .mdr                     ( mdr                 [31:0] ),
    .a                       ( a                   [31:0] ),
    .b                       ( b                   [31:0] ),
    .y                       ( y                   [31:0] ),
    .bm                      ( bm                  [31:0] ),
    .yw                      ( yw                  [31:0] ),
    .rd                      ( rd                  [4:0]  ),
    .rdm                     ( rdm                 [4:0]  ),
    .rdw                     ( rdw                 [4:0]  ),
    .ctrl                    ( ctrl                [31:0] ),
    .ctrlm                   ( ctrlm               [31:0] ),
    .ctrlw                   ( ctrlw               [31:0] ),

    .clk_cpu                 ( clk_cpu                    ),
    .check                   ( check               [1:0]  ),
    .out0                    ( out0                [4:0]  ),
    .an                      ( an_from_PDU                ),
    .seg                     ( seg_from_PDU               ),
    .ready                   ( ready                      ),
    .io_din                  ( io_din              [31:0] ),
    .m_rf_addr               ( m_rf_addr                  )
   );
    DQ_SEG MY_DQ_SEG(seg_from_PDU,seg);
    DQ_AN MY_DQ_AN(an_from_PDU,an);
    endmodule
