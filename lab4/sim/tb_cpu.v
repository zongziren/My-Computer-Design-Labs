`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/05 01:08:16
// Design Name: 
// Module Name: tb_cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_cpu(
);
reg clk,rst;
//IO_BUS
wire [7:0] io_addr;
wire [31:0] io_dout;
wire io_we;         
reg [31:0] io_din;
//Debug_BUS
reg [7:0] m_rf_addr;
wire [31:0] rf_data;
wire [31:0] m_data;
wire [31:0] pc;

CPU cpu(
.clk(clk),
.rst(rst),
.io_addr(io_addr),
.io_dout(io_dout),
.io_we(io_we),
.io_din(io_din),
.m_rf_addr(m_rf_addr),
.rf_data(rf_data),
.m_data(m_data),
.pc(pc)
);

initial 
begin
    rst = 0;
    clk=0;
    io_din=0;
    m_rf_addr=8'h07;
end

always #5 clk = ~clk;

endmodule
