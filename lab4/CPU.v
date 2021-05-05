module  CPU(
  	input clk, 
  	input rst,

  	//IO_BUS
  	output [7:0] io_addr,      	//led和seg的地址
  	output [31:0] io_dout,     	//输出led和seg的数据
  	output io_we,              	//输出led和seg数据时的使能信号
  	input [31:0] io_din,    	//来自sw的输入数据

  	//Debug_BUS
  	input [7:0] m_rf_addr,   	//存储器(MEM)或寄存器堆(RF)的调试读口地址
  	output [31:0] rf_data,    	//从RF读取的数据
  	output [31:0] m_data,    	//从MEM读取的数据
  	output [31:0] pc             //PC的内容
);
	wire [31:0]Next_PC;
  	PC MY_PC(
		.clk(clk),
	  	.rst(rst),
	  	.Next_PC(Next_PC),
		.PC(pc)
  	);

	wire [31:0]PCADD4;
	ADD #(32)MY_PC_ADD(
		.a(pc),
		.b(32'd4),
		.sum(PCADD4)
	);

	wire [31:0] instruct;
	INSTRUCTION_MEMORY MY_IM(
        .a(pc[9:2]),
        .d(0),
        .clk(clk),
        .we(0),
        .spo(instruct)
    );

	//控制信号
	wire jal; 
	wire Branch; 
	wire [1:0] Imm_gen;
	wire [1:0] RegScr; 
	wire [1:0] ALUop;
	wire MemWrite;
	wire ALUSrc;
	wire RegWrite;
	Control MY_Control(
        .opcode(instruct[6:0]),
        .jal(jal),
		.Branch(Branch),
        .Imm_gen(Imm_gen),
        .RegScr(RegScr),
        .ALUop(ALUop),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

	wire [31:0]rd1, rd2, WriteData;
	RF MY_RF(
        .clk(clk),
        .we(RegWrite),
        .wa(instruct[11:7]),
        .ra1(instruct[19:15]),
        .ra2(instruct[24:20]),
        .ra3(m_rf_addr[4:0]),
        .rd1(rd1),
        .rd2(rd2),
        .rd3(rf_data),
        .wd(WriteData)
    );

	wire [31:0] Imm;
    ImmGen MY_ImmGen(
		.Imm_gen(Imm_gen),
		.instruct(instruct),
		.Imm(Imm)
	);

	wire [31:0] ALU_in2;
	MUX_2_1 #(32)MUX_ALU_SRC(
		.a(rd2),
        .b(Imm),
        .sel(ALUSrc),
        .out(ALU_in2)
	);

	wire [2:0] ALU_ctl_input;
	ALU_Control MY_ALU_Control(
    .ALUop(ALUop),
    .func7(instruct[31:25]),
    .func3(instruct[14:12]),
    .ALU_ctl_input(ALU_ctl_input)
	);
	
	wire [31:0] ALUresult;
    wire zero;
    ALU #(32)ALU(
        .a(rd1),
        .b(ALU_in2),
        .s(ALU_ctl_input),
        .y(ALUresult),
        .zf(zero)
    );

	wire [31:0] ReadData1;
	wire [7:0] DM_a_in;
    assign DM_a_in = ALUresult[9:0] >> 2;
    DATA_MEMORY MY_DM(
        .a(DM_a_in),
        .d(rd2),
        .dpra(m_rf_addr),
        .clk(clk),
        .we(MemWrite & (~ALUresult[10])),
        .spo(ReadData1),
        .dpo(m_data)
    );


	wire [31:0] mem_data_out;
	MUX_2_1 #(32)MUX_MEM_OUT(
		.a(ReadData1),
		.b(io_din),
		.sel(ALUresult[10]),
		.out(mem_data_out)
	);

    MUX_3_1 #(32)WriteData_MUX(
        .a(ALUresult),
        .b(mem_data_out),
		.c(PCADD4),
        .sel(RegScr),
        .out(WriteData)
    );

	wire [31:0] PCADDIMM;
	ADD #(32)PC_ADD_IMM(
		.a(pc),
		.b(Imm << 1),
		.sum(PCADDIMM)
	);

	MUX_2_1 #(32)MUX_PC_NEXT(
		.a(PCADD4),
		.b(PCADDIMM),
		.sel((Branch & zero) | jal),
		.out(Next_PC)
	);
	
	assign io_addr = ALUresult[7:0];
	assign io_dout = rd2;
	assign io_we = MemWrite & ALUresult[10];

endmodule
