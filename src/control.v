module control(
    input wire [5:0] opcode,
    output reg RegDst, Jump, Branch, MemRead, MemToReg,
    output reg [1:0] ALUOp,
    output reg MemWrite, ALUSrc, RegWrite
    );

    always @(*) begin
        RegWrite <= 1'b1;
        RegDst <= 1'b1;
        ALUSrc <= 1'b0;
        Branch <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        MemToReg <= 1'b0;
        ALUOp[1:0] <= 2'b10;
        Jump <= 1'b0;

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
            6'b001101: begin
                RegDst <= 1'b0;
                ALUSrc <= 1'b1;
                ALUOp[1:0] <= 2'b00;
            end
            6'b000010: begin
                RegWrite <= 1'b0;
                Jump <= 1'b1;
            end
        endcase
    end

endmodule