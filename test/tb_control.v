`timescale 1ns/1ns

module tb_control();
reg [5:0] inst;
wire RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

control uut(inst, RegDst, Jump, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);

initial
begin
    inst = 6'b000000;
    #50; inst = 6'b100011;
    #50; inst = 6'b101011;
    #50; inst = 6'b000100;
    #50; inst = 6'b000010;
end

always #10
begin
    $display("RegDst: %b", RegDst);
    $display(" Jump: %b", Jump);
    $display(" Branch: %b", Branch);
    $display(" MemRead: %b", MemRead);
    $display(" MemToReg: %b", MemToReg);
    $display(" ALUOp: %b", ALUOp);
    $display(" MemWrite: %b", MemWrite);
    $display(" ALUSrc: %b", ALUSrc);
    $display(" RegWrite: %b\n", RegWrite);
end

endmodule
