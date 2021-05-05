module MAIN(
    input clk,
    input rst,

    //选择CPU工作方式;
    input run, 
    input step,
    input valid,
    input [4:0] in,

    //输出led和seg 
    output [1:0] check,             //led6-5:查看类型
    output [4:0] out0,              //led4-0
    output [7:0] an,                //8个数码管 
    output [6:0] seg,               //FPGA数码管显示,ps:此2项在FPGA online有区别
    output ready                    //led7
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
    wire [31:0] pc;

    //SEG and AN from PDU
    wire [2:0] an_from_PDU;     
    wire [3:0] seg_from_PDU;

    CPU MY_CPU(
        .clk(clk_cpu),
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
    
    PDU MY_PDU(
        .clk(clk),
        .rst(rst),

        .run(run),
        .step(step),
        .clk_cpu(clk_cpu),

        .valid(valid),
        .in(in),

        .check(check),
        .out0(out0),
        .an(an_from_PDU), 
        .seg(seg_from_PDU),
        .ready(ready),

        .io_addr(io_addr),
        .io_dout(io_dout),
        .io_we(io_we),
        .io_din(io_din),

        .m_rf_addr(m_rf_addr),
        .rf_data(rf_data),
        .m_data(m_data),
        .pc(pc)
    );

    DQ_SEG MY_DQ_SEG(
        .d(seg_from_PDU), 
        .seg(seg)
    );

    DQ_AN MY_DQ_AN(
        .d(an_from_PDU),
        .an(an)
    );
endmodule
