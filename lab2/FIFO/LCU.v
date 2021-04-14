`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/21 22:33:34
// Design Name: 
// Module Name: lcu
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


module LCU(
    input wire clk, rst, 
    input wire eno, eni, 
    input wire [3:0] in, 
    input wire [3:0] rd, 
    output wire [2:0] ra, 
    output wire we, 
    output wire [2:0] wa, 
    output wire [3:0] wd, 
    output reg [3:0] out, 
    output reg emp, 
    output reg full, 
    output reg [2:0] head, 
    output reg [7:0] valid
    );

    reg prevEno;
    wire enoPosedge;
    
    always @ (posedge clk, posedge rst) begin
        if (rst) prevEno <= 0;
        else if (clk) prevEno <= eno;
    end
    assign enoPosedge = (~prevEno & eno) ? 1 : 0;

    reg prevEni;
    wire eniPosedge;
    always @ (posedge clk, posedge rst) begin
        if (rst) prevEni <= 0;
        else if (clk) prevEni <= eni;
    end
    assign eniPosedge = (~prevEni & eni) ? 1 : 0;

    reg [2:0] tail;
    always @ (posedge clk, posedge rst) begin
        if (rst) tail <= 7;
        else if (clk) begin
            if (eniPosedge && !full && in <= 9) tail <= tail - 1;
        end
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) head <= 7;
        else if (clk) begin
            if (enoPosedge && !emp) head <= head - 1;
        end
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            emp <= 1;
            full <= 0;
        end
        else if (clk) begin
            if (enoPosedge && (head - 1 == tail || tail == 7 && head == 0)) emp <= 1;
            else if (eniPosedge && in <= 9) emp <= 0;
            
            if (eniPosedge && (tail - 1 == head || head == 7 && tail == 0) && in <= 9) full <= 1;
            else if (enoPosedge) full <= 0;
        end
    end

    assign ra = head;
    always @ (posedge clk, posedge rst) begin
        if (rst) out <= 0;
        else if (clk) begin
            if (enoPosedge && !emp) out <= rd;
        end
    end

    assign wa = tail;
    assign wd = in;
    assign we = (!full && in <= 9) ? eniPosedge : 0;

    always @ * begin : cl_valid
        integer i;
        for (i = 7; i >= 0; i = i - 1) begin
            if (full) valid[i] = 1;
            else if (head >= tail) begin
                if (i <= head && i > tail) valid[i] = 1;
                else valid[i] = 0;
            end
            else begin
                if (i <= head || i > tail) valid[i] = 1;
                else valid[i] = 0;
            end
        end
    end

endmodule
