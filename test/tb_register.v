`timescale 1ns/1ns

module tb_register();

reg rst, clk, RegWrite;
reg [4:0] read1, read2, write_reg;
reg [31:0] write_data;
wire [31:0] data1, data2;

register uut(rst, clk, read1, read2, write_reg, write_data, RegWrite, data1, data2);

initial begin
    rst = 0;
    #50; rst = 1; clk = 0; RegWrite = 0; read1 = 0; read2 = 0; write_reg = 0; write_data = 0;
    #50; RegWrite = 1; write_reg = 1; read1 = 1; write_data = 1;
    #50; RegWrite = 0;
    #50; read1 = 0; read2 = 1;
    #50; rst = 0;
    #50; rst = 1; read1 = 1; read2 = 0;
end

always #25 begin
    clk = ~clk;
end

endmodule