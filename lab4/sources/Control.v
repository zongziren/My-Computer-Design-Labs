//ALUoP:
//2'b10:R-type
//2'b00:lw
//2'b00:sw
//2'b01:beq


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


module Control(
    input   wire [6:0] opcode,
    output  reg jal,
    output  reg Branch,
    output  reg [1:0] Imm_gen,
    output  reg [1:0] RegScr,
    output  reg [1:0] ALUop,
    output  reg MemWrite,
    output  reg ALUSrc,
    output  reg RegWrite
    );

     always @(*) begin
        case(opcode)
            7'b0110011:         //add
            begin   
                jal      = 0;
                Branch   = 0;
                Imm_gen  = 2'b00; 
                RegScr   = 2'b00;
                ALUop    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;
            end

            7'b0010011:         //addi
            begin   
                jal      = 0;
                Branch   = 0;
                Imm_gen  = 2'b00; 
                RegScr   = 2'b00;
                ALUop    = 2'b10;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 1;
            end

            7'b0000011:         //lw
            begin
                jal      = 0;
                Branch   = 0;
                Imm_gen  = 2'b00; 
                RegScr   = 2'b01;
                ALUop    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 1;
                RegWrite = 1;
            end

            7'b0100011:         //sw
            begin   
                jal      = 0;
                Branch   = 0;
                Imm_gen  = 2'b01; 
                RegScr   = 2'b00;
                ALUop    = 2'b00;
                MemWrite = 1;
                ALUSrc   = 1;
                RegWrite = 0;
            end

            7'b1100011:         //beq
            begin   
                jal      = 0;
                Branch   = 1;
                Imm_gen  = 2'b10; 
                RegScr   = 2'b00;
                ALUop    = 2'b01;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;
            end

            7'b1101111:         //jal
            begin   
                jal      = 1;
                Branch   = 1;
                Imm_gen  = 2'b11; 
                RegScr   = 2'b10;
                ALUop    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 1;

            end
            default: begin 
                jal      = 0;
                Branch   = 0;
                Imm_gen  = 2'b00; 
                RegScr   = 2'b00;
                ALUop    = 2'b00;
                MemWrite = 0;
                ALUSrc   = 0;
                RegWrite = 0;  
            end
        endcase
    end

endmodule
