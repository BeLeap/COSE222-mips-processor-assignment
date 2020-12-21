`timescale 1ns/1ns
module tb_memory();

reg rst, clk, MemWrite, MemRead;
reg [31:0] addr, write_data;
wire [31:0] read_data;

memory uut(rst, clk, addr, write_data, MemWrite, MemRead, read_data);

initial
begin
    rst = 1; clk = 1; MemRead = 1; MemWrite = 0; addr = 1;
    #50; addr = 2;
    #50; MemRead = 0; MemWrite = 1; addr = 1; write_data = 32'b1000;
    #50; MemRead = 1; MemWrite = 0; addr = 1;
    #50; rst = 0;
    #50; rst = 1;
    #50; MemRead = 1; MemWrite = 0; addr = 1;
end

always #50
begin
    clk = ~clk;
end

always #10
begin
    $display("Read Data: %b", read_data);
end

endmodule