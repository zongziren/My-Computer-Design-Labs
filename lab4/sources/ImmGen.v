//Imm_gen:
//addi lw 
//2'b00 
//Imm[11:0] = instruction[31:20];

//sw
//2'b01     
//Imm[11:5] = instruction[31:25];
//Imm[4:0]  = instruction[11:7];

//beq
//2'b10
//Imm[11]   = instruction[31];
//Imm[9:4] = instruction[30:25];
//Imm[3:0]  = instruction[11:8];
//Imm[10]   = instruction[7];

//jal
//2'b11
//Imm[19]   = instruction[31];
//Imm[9:0] = instruction[30:21];
//Imm[10]   = instruction[20];
//Imm[18:11]  = instruction[19:12];

module ImmGen (
    input [1:0] Imm_gen,
    input [31:0] instruct,
    output reg [31:0]Imm
);
    always @(*) begin
        case(Imm_gen)
            2'b00:  //addi lw
            begin     
                Imm[11:0] = instruct[31:20];
                if(instruct[31] == 1)
                     Imm[31:12] = 20'hfffff;
                else Imm[31:12] = 20'h00000;
            end

            2'b01: //sw
            begin   
                Imm[11:5] = instruct[31:25];
                Imm[4:0]  = instruct[11:7];
                if(instruct[31] == 1)
                     Imm[31:12] = 20'hfffff;
                else Imm[31:12] = 20'h00000;
            end

            2'b10: //beq
            begin   
                Imm[11]   = instruct[31];
                Imm[9:4]  = instruct[30:25];
                Imm[3:0]  = instruct[11:8];
                Imm[10]   = instruct[7];
                if(instruct[31] == 1)
                    Imm[31:12] = 19'h7ffff;
                else 
                    Imm[31:12] = 19'h00000;
            end
            2'b11: //jal
            begin   
                Imm[19]     = instruct[31];
                Imm[9:0]    = instruct[30:21];
                Imm[10]     = instruct[20];
                Imm[18:11]  = instruct[19:12];
                if(instruct[31] == 1)
                    Imm[31:20] = 11'h7ff;
                else 
                    Imm[31:20] = 11'h000;
            end
            default: 
            begin   
                Imm[31:0] = 32'd0;
            end
        endcase
    end
endmodule
