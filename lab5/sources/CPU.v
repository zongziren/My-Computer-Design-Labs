
`timescale 1ns / 1ps

module CPU(
           input clk, rst,

           // IO_bus
           output [7:0] io_addr,
           output [31:0] io_dout,
           output io_we,
           input [31:0] io_din,

           // Debug_bus
           input [7:0] m_rf_addr,
           output [31:0] rf_data,
           output [31:0] m_data,

           // PC/IF/ID
           output [31:0] pc,
           output [31:0] pcd,
           output [31:0] ir,
           output [31:0] pcin,

           // ID/EX
           output [31:0] pce,
           output [31:0] a,
           output [31:0] b,
           output [31:0] imm,
           output [4:0] rd,
           output [31:0] ctrl,

           // EX/MEM
           output [31:0] y,
           output [31:0] bm,
           output [4:0] rdm,
           output [31:0] ctrlm,

           // MEM/WB
           output [31:0] yw,
           output [31:0] mdr,
           output [4:0] rdw,
           output [31:0] ctrlw
       );

/* IF */
wire fstall;

// mem_ins
wire [31:0] ins;

// pc
wire [31:0] pc_4;
wire [31:0] pc_4_d;
wire [31:0] pc_4_e;
wire [31:0] pc_4_m;
wire [31:0] pc_4_w;
wire [31:0] offset;
wire [31:0] pc_target;
wire PCSrc;

/* ID */
wire dstall;
wire dflush;

// control
wire [31:0] ctrl_i;



// imm_gen
wire [31:0] imm_i;

/* EX */
wire eflush;
wire [6:0] opcode;


// forwarding_unit
wire [4:0] rs1;
wire [4:0] rs2;
wire [1:0] a_fwd;
wire [1:0] b_fwd;


wire [31:0] alu_i;
wire [31:0] alu_a;
wire [31:0] alu_b;
wire [31:0] ALUresult;
wire Zero;
assign PCSrc = ctrl[9] | (ctrl[8] & Zero);

FORWARDING  MY_FORWARDING (
    .rs1                     ( rs1 ),
    .rs2                     ( rs2 ),
    .wbm                     ( ctrlm[18] ),
    .wbw                     ( ctrlw[18] ),
    .rdm                     ( rdm ),
    .rdw                     ( rdw ),

    .a_fwd                   ( a_fwd ),
    .b_fwd                   ( b_fwd )
);

HAZARD  MY_HAZARD (
    .PCSrc                   ( PCSrc         ),
    .rs1                     ( ir[19:15]     ),
    .rs2                     ( ir[24:20]     ),
    .opcode                  ( opcode  [6:0] ),
    .rd                      ( rd      [4:0] ),
    .m_rd                    ( ctrl[13]      ),
    .wbm                     ( ctrlm[18]     ),
    .wbw                     ( ctrlm[18]     ),

    .fstall                  ( fstall        ),
    .dstall                  ( dstall        ),
    .dflush                  ( dflush        ),
    .eflush                  ( eflush        )
);

wire [31:0] data;
wire [31:0] mdr_i;
assign io_addr = y[7:0];
assign io_we = y[10] & ctrlm[12];
assign io_dout = bm;

add #(32) add_4(pc, 32'h4, pc_4);
mux2 #(32) mux_pc(pc_4, pc_target, PCSrc, pcin);

PC  MY_program_counter (
    .clk                     ( clk          ),
    .rst                     ( rst          ),
    .en                      ( ~fstall      ),
    .in                      ( pcin         ),
    .out                     ( PC           )
);

mem_ins mem_ins(pc[9:2], ins);
// registers
wire [31:0] rd1;
wire [31:0] rd2;
wire [31:0] wd;

IF_ID  MY_IF_ID (
    .clk                     ( clk              ),
    .rst                     ( rst | dflush     ),
    .en                      ( ~dstall          ),
    .pc_4_d_i                ( pc_4             ),
    .pcd_i                   ( pc_4_d           ),
    .ir_i                    ( pc               ),

    .pc_4_d_o                ( pcd              ),
    .pcd_o                   ( ins              ),
    .ir_o                    ( ir               )
);

control MY_control (
    .opcode                  ( ir       ),

    .ctrl                    ( ctrl_i   )
);

register_file  MY_register_file (
    .clk                     ( clk              ),
    .ra0                     ( ir[19:15]        ),
    .ra1                     ( rd1              ),
    .ra2                     ( ir[24:20]        ),
    .wa                      ( rd2              ),
    .we                      ( m_rf_addr[4:0]   ),
    .wd                      ( rf_data          ),

    .rd0                     ( rdw              ),
    .rd1                     ( ctrlw[18]        ),
    .rd2                     ( wd               )
);
imm_gen imm_gen(ir, imm_i);



ID_EX ID_EX(clk, rst | eflush, 1'b1, pc_4_d, pc_4_e, pcd, pce, rd1, a, rd2, b, imm_i, imm, ir[19:15], rs1, ir[24:20], rs2, ir[11:7], rd, ir[6:0], opcode ,ctrl_i, ctrl);

shift_left #(32) shifter(imm, offset);
add #(32) add_pc(pce, offset, pc_target);
mux3 #(32) mux_a(a, y, wd, a_fwd, alu_a);
mux3 #(32) mux_b(b, y, wd, b_fwd, alu_i);
mux2 #(32) mux_alu(alu_i, imm, ctrl[4], alu_b);
alu #(32) alu(alu_a, alu_b, ctrl[3:0], ALUresult, Zero);

EX_MEM EX_MEM(clk, rst, 1'b1, pc_4_e, pc_4_m, ALUresult, y, alu_i, bm, rd, rdm, ctrl, ctrlm);

mem_data mem_data(y[9:2], bm, m_rf_addr, clk, ctrlm[12], data, m_data);
mux2 #(32) mux_io(data, io_din, y[10], mdr_i);

MEM_WB MEM_WB(clk, rst, 1'b1, pc_4_m, pc_4_w, y, yw, mdr_i, mdr, rdm, rdw, ctrlm, ctrlw);

mux3 #(32) mux_wd(yw, mdr, pc, ctrlw[17:16], wd);

endmodule
