module RF(
    input wire clk,we,
    input wire [4:0] wa, 
    input wire [31:0] wd, 
    input wire [4:0] ra1, ra2, ra3,
    output wire [31:0] rd1, rd2, rd3
    );
    
    reg [31:0] regfile[0:31];

    initial 
    begin
        regfile[0]=0;   
    end
    
    assign  rd1 = regfile[ra1];
    assign  rd2 = regfile[ra2];
    assign  rd3 = regfile[ra3];

    always @ (posedge clk)
    begin
        if(we && wa != 0)
            regfile[wa] <= wd;
    end
endmodule
