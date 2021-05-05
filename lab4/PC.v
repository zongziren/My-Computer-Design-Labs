module PC(
    input clk,rst,
    input [31:0]Next_PC,
    output reg [31:0]PC
    );
    always @(posedge clk, posedge rst) 
    begin
        if(rst) 
            PC <= 0;
        else 
            PC <= Next_PC;
    end

endmodule
