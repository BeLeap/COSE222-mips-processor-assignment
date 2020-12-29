# COSE222 Single Cycle MIPS Processor

## cpu.v

```verilog
wire [31:0] new_pc;
wire [31:0] pc;
pc PC(rst, out_clk, new_pc, pc);

seg7 s0(rst, pc % 10, seg0);
seg7 s1(rst, (pc / 10) % 10, seg1);
```

새로운 pc를 넘긴 후 pc를 7-segment에 출력한다.

```verilog
wire [31:0] pc4;
assign pc4 = pc + 4;
```

pc에 4를 더 한다.(다음 instruction)

```verilog
wire [31:0] inst;
instruction_memory InstructionMemory(pc, inst);
```

새로운 pc를 이용해 instruction을 가져온다.

```verilog
wire [31:0] jump_addr;
assign jump_addr = {pc[31:28], inst[25:0], 2'b00};
```

jump할 주소를 계산한다.
instruction이 jump인 경우 사용된다.

```verilog
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
```

후에 사용하기 편하도록 instruction을 field별로 분리해둔다.

```verilog
wire RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
control Control(opcode, RegDst, Jump, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
```

control에 opcode를 넘기고 control flag를 받아온다.
자세한 동작은 control.v에서 설명하겠습니다.

```verilog
wire [4:0] write_reg;
mux21 m1(rt, rd, RegDst, write_reg);
```

어떤 register가 write register로 사용될지 결정한다.

```verilog
wire [31:0] read1;
wire [31:0] read2;
wire [31:0] write_data;
register r1(rst, out_clk, rs, rt, write_reg, write_data, RegWrite, read1, read2);
```

register 모듈에 `rs`, `rt`, `write_reg`, `write_data`, `RegWrite`(Control Flag)를 넘기고 `read1`, `read2`를 받아온다. 자세한 동작은 register.v에서 설명하겠습니다.

```verilog
wire [31:0] sign_extended;
sign_ex se(inst[15:0], sign_extended);
```

immediate, branch 연산을 위해 sign extend 시켜줍니다.

```verilog
wire [31:0] ALUResult2;
assign ALUResult2 = (sign_extended << 2) + pc4;
```

branch의 결과로 jump할 location을 계산합니다.

```verilog
wire [31:0] alu_source;
mux21 m2(read2, sign_extended ,ALUSrc, alu_source);
```

register에서 읽은 값을 ALU에서 사용할지 sign extend된 값을 ALU에서 사용할지 결정합니다.

```verilog
wire [3:0] alu_control;
aludec ALUControl(funct, ALUOp, alu_control);
```

`ALUOp`와 `funct`를 기반으로 `alu_control`을 만듭니다.(ALU에서 무슨 동작을 할지 결정합니다)
자세한 동작은 aludec.v에서 설명하겠습니다.

```verilog
wire zero;
wire [31:0] ALUResult;
alu_mips ALU(read1, alu_source, shamt, alu_control, ALUResult, zero);
```

ALU에서 계산을 합니다. `zero`는 `ALUResult`가 0인지 알려주는 값입니다. `shamt`는 shift 연산에서 사용됩니다. sll이 따로 구현되어 있지 않아서 교수님이 주신 파일에 추가했습니다.

```verilog
wire [31:0] new_pc_temp;
mux21 m4(pc4, ALUResult2, zero & Branch, new_pc_temp);
mux21 m5(new_pc_temp, jump_addr, Jump, new_pc);
```

jump 혹은 branch를 해야하는지 결정합니다. (`beq`의 경우 ALU에서 `sub`를 수행한 값을 사용하기 때문에 `zero`가 0인 경우에만 branch를 수행하고 따라서 mux의 selection으로 `zero & Branch`를 넘겨줍니다.)

```verilog
wire [31:0] read_data;
memory mem(rst, out_clk, ALUResult, read2, MemWrite, MemRead, read_data);
```

memory 동작을 수행합니다. 자세한 동작은 memory.v에서 설명하겠습니다.

```verilog
mux21 m3(ALUResult, read_data, MemToReg, write_data);
```

ALUResult 혹은 memory에서 읽은 data 중 어떤 data가 register에 쓰여질지 결정합니다.

```verilog
seg7 s2(rst, write_data % 10, seg2);
seg7 s3(rst, (write_data / 10) % 10, seg3);
seg7 s4(rst, (write_data / 100) % 10, seg4);
seg7 s5(rst, (write_data / 1000) % 10, seg5);
```

register에 쓸 데이터를 7-segment에 출력합니다.

## control.v

```verilog
RegWrite <= 1'b1;
RegDst <= 1'b1;
ALUSrc <= 1'b0;
Branch <= 1'b0;
MemRead <= 1'b0;
MemWrite <= 1'b0;
MemToReg <= 1'b0;
ALUOp[1:0] <= 2'b10;
Jump <= 1'b0;
```

R type의 경우입니다. 가장 흔하기 때문에 기본값으로 뒀습니다.

```verilog
case (opcode)
    6'b100011: begin // lw
        RegDst <= 1'b0;
        ALUSrc <= 1'b1;
        MemRead <= 1'b1;
        MemToReg <= 1'b1;
        ALUOp[1:0] <= 2'b00;
    end
    6'b101011: begin // sw
        RegWrite <= 1'b0;
        ALUSrc <= 1'b1;
        MemWrite <= 1'b1;
        ALUOp[1:0] <= 2'b00;
    end
    6'b000100: begin // beq
        RegWrite <= 1'b0;
        Branch <= 1'b1;
        ALUOp <= 1'b01;
    end
    6'b001000: begin // addi
        RegDst <= 1'b0;
        ALUSrc <= 1'b1;
        ALUOp[1:0] <= 2'b00;
    end
    6'b001101: begin // ori
        RegDst <= 1'b0;
        ALUSrc <= 1'b1;
        ALUOp[1:0] <= 2'b00;
    end
    6'b000010: begin // jump
        RegWrite <= 1'b0;
        Jump <= 1'b1;
    end
endcase
```

각각의 명령어에 따라 과제 설명 pdf에 나와있는 표를 참고해 flag를 설정합니다.

## register.v

```verilog
if (!rst) begin
    mem[0] = 32'b00000000000000000000000000000000;
    mem[1] = 32'b00000000000000000000000000000000;
    mem[2] = 32'b00000000000000000000000000000000;
    mem[3] = 32'b00000000000000000000000000000000;
    mem[4] = 32'b00000000000000000000000000000000;
    mem[5] = 32'b00000000000000000000000000000000;
    mem[6] = 32'b00000000000000000000000000000000;
    mem[7] = 32'b00000000000000000000000000000000;
    mem[8] = 32'b00000000000000000000000000000000;
    mem[9] = 32'b00000000000000000000000000000000;
    mem[10] = 32'b00000000000000000000000000000000;
    mem[11] = 32'b00000000000000000000000000000000;
    mem[12] = 32'b00000000000000000000000000000000;
    mem[13] = 32'b00000000000000000000000000000000;
    mem[14] = 32'b00000000000000000000000000000000;
    mem[15] = 32'b00000000000000000000000000000000;
    mem[16] = 32'b00000000000000000000000000000000;
    mem[17] = 32'b00000000000000000000000000000000;
    mem[18] = 32'b00000000000000000000000000000000;
    mem[19] = 32'b00000000000000000000000000000000;
    mem[20] = 32'b00000000000000000000000000000000;
    mem[21] = 32'b00000000000000000000000000000000;
    mem[22] = 32'b00000000000000000000000000000000;
    mem[23] = 32'b00000000000000000000000000000000;
    mem[24] = 32'b00000000000000000000000000000000;
    mem[25] = 32'b00000000000000000000000000000000;
    mem[26] = 32'b00000000000000000000000000000000;
    mem[27] = 32'b00000000000000000000000000000000;
    mem[28] = 32'b00000000000000000000000000000000;
    mem[29] = 32'b00000000000000000000000000000000;
    mem[30] = 32'b00000000000000000000000000000000;
    mem[31] = 32'b00000000000000000000000000000000;
end
```

모든 레지스터를 0으로 초기화합니다.

```verilog
else if (RegWrite == 1 && write_reg != 0) begin
    mem[write_reg] <= write_data;
end
```

RegWrite(control에서 생성)가 1이고 써야하는 레지스터의 주소가 0이 아닌 경우 데이터를 레지스터에 씁니다.

```verilog
assign data1 = (read1 == 0) ? 0 : mem[read1];
assign data2 = (read2 == 0) ? 0 : mem[read2];
```

읽어와야 하는 레지스터의 주소가 0인 경우 0을 넣어주고 아닌 경우에는 적절한 위치에서 값을 읽어옵니다.

## aludec.v

```verilog
case(aluop)
    2'b00: alucontrol <= 4'b0100;  // ori
    2'b01: alucontrol <= 4'b1100;  // sub
    default: case(func)          // RTYPE
        6'b100000: alucontrol <= 4'b0100; // add
        6'b100010: alucontrol <= 4'b1100; // sub
        6'b100100: alucontrol <= 4'b0000; // and
        6'b100101: alucontrol <= 4'b0001; // or
        6'b101011: alucontrol <= 4'b1110; // sltu
        6'b000000: alucontrol <= 4'b0010; // sll
        default:   alucontrol <= 4'bxxxx; // ???
    endcase
endcase
```

`ALUOp`이 00인 경우와 01인 경우 바로 명령어를 알 수 있기 때문에 설정해주고 나머지의 경우에만 `func`를 확인하여 적절한 `alucontrol`값을 설정해줍니다. `sll`이 원래 주신 파일에 없었기 때문에 추가했습니다.

## memory.v

```verilog
if (!rst) begin
    $readmemb("./memory.mem", mem);
end
```

reset해야하는 경우 파일에서 데이터를 읽어와 mem에 로드합니다.

```verilog
else if (MemWrite) begin
        mem[addr] <= write_data;
end
```

`MemWrite`가 1인 경우(memory에 써야하는 경우)에 `write_data`를 `addr`위치에 써줍니다.

```verilog
assign read_data = MemRead ? mem[addr] : write_data;
```

`MemRead`가 1인 경우에는 `mem`의 `addr`에서 데이터를 읽어옵니다. 아닌 경우에는 `write_data`를 넣어줍니다.

## seg7.v

```verilog
if (!rst) begin
    seg = 7'b0111111;
end
else begin
    case(digit)
    4'b0000 : seg = 7'b1000000;
    4'b0001 : seg = 7'b1111001;
    4'b0010 : seg = 7'b0100100;
    4'b0011 : seg = 7'b0110000;
    4'b0100 : seg = 7'b0011001;
    4'b0101 : seg = 7'b0010010;
    4'b0110 : seg = 7'b0000010;
    4'b0111 : seg = 7'b1111000;
    4'b1000 : seg = 7'b0000000;
    4'b1001 : seg = 7'b0010000;
    endcase
end
```

reset인 경우 7-segment를 -로 표시하는 것을 추가했습니다.
