module control(
    input wire [5:0] inst,
    output reg RegDst, Jump, Branch, MemRead, MemToReg,
    output reg [1:0] ALUOp,
    output reg MemWrite, ALUSrc, RegWrite
    );

    always @(*) begin
        RegDst <= 1'b1;
        Jump <= 1'b0;
        ALUSrc <= 1'b0;
        MemToReg <= 1'b0;
        RegWrite <= 1'b1;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp[1] <= 1'b1;
        ALUOp[0] <= 1'b0;

        case (inst)
            6'b100011: begin // lw
                RegDst <= 1'b0;
                ALUSrc <= 1'b1;
                MemToReg <= 1'b1;
                RegWrite <= 1'b1;
                MemRead <= 1'b1;
                ALUOp[1] <= 1'b0;
            end
            6'b101011: begin //sw
                ALUSrc <= 1'b1;
                RegWrite <= 1'b0;
                MemWrite <= 1'b1;
                ALUOp[1] <= 1'b0;
            end
            6'b000100: begin //beq
                RegWrite <= 1'b0;
                Branch <= 1'b1;
                ALUOp[1] <= 2'b0;
                ALUOp[0] <= 2'b1;
            end
            6'b000010: begin
                Jump <= 1'b1;
            end
        endcase
    end

endmodule