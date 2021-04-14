`timescale 1ns / 1ps

module SDU(
    input wire clk,  rst, 
    input wire [2:0] head, 
    input wire [7:0] valid, 
    input wire [3:0] rd, 
    output wire [2:0] ra, 
    output reg [7:0] an, 
    output wire [7:0] seg
    );

    wire clkd;
    Freq_divider #(10000) my_freq_divider(.clk(clk), .rst(rst), .clkd(clkd));//分频

    reg [2:0] curDisp;
    always @ (posedge clkd, posedge rst) begin
        if (rst) curDisp <= 0;
        else if (clkd) curDisp <= curDisp + 1;
    end

    assign ra = curDisp;

    reg [3:0] dispData;
    always @ * begin
        if (valid[curDisp]) dispData = rd;
        else dispData = 4'hF;
    end

    DQ my_decoder(.d(dispData), .seg(seg[6:0]));
    assign seg[7] = (curDisp == head) ? 0 : 1;

    always @ * begin
        an = 8'b11111111;
        an[curDisp] = 0;
    end

endmodule

