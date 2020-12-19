module cpu (
    input rst, clk,
    output [6:0] seg
    );

    wire out_clk;
    wire [31:0] new_pc;
    wire [31:0] pc;
    wire [31:0] inst;

    wire [31:0] pc4;
    wire [31:0] jump_addr;

    wire [31:0] write_data;

    // clock divider
    clk_dll ClockDivider(rst, clk, out_clk);
    // assign out_clk = clk

    pc PC(rst, out_clk, new_pc, pc);

    instruction_memory InstructionMemory(pc, inst);

    assign pc4 = pc + 4;

    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] funct;

    assign opcode = inst[31:26];
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign shamt = inst[10:6];
    assign funct = inst[5:0];

    wire RegDst, Jump, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite;
    control Control(opcode, RegDst, Jump, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);

    wire [4:0] write_reg;

    mux21 m1(rt, rd, RegDst, write_reg);

    wire [31:0] read1;
    wire [31:0] read2;

    register r1(rst, out_clk, rs, rt, write_reg, write_data, RegWrite, read1, read2);

    wire [31:0] sign_extended;

    sign_ex se(inst[15:0], sign_extended);

    wire [31:0] alu_source;

    mux21 m2(read2, sign_extended ,ALUSrc, alu_source);

    wire [2:0] alu_control;

    aludec ALUControl(funct, ALUOp, alu_control);

    wire zero;
    wire [31:0] ALUResult;

    alu_mips ALU(read1, alu_source, alu_control, ALUResult, zero);

    wire [31:0] read_data;
    memory mem(ALUResult, read2, MemWrite, MemRead, read_data);

    mux21 m3(read_data, ALUResult, MemToReg, write_data);
endmodule