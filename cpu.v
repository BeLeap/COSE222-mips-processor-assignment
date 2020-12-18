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
    wire [31:0] read1;
    wire [31:0] read2;

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
    control Control(opcode, RegDst, Jump, Branch, MemRead, MemToReg, ALUSrc, RegWrite);

    wire [4:0] write_reg;

    mux21 m1(rt, rd, RegDst, write_reg);

    register r1(rst, out_clk, rs, rt, write_reg, write_data, RegWrite, read1, read2);
endmodule