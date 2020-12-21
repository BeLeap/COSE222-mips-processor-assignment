module register(
    input wire rst, clk,
    input wire [4:0] read1, read2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire RegWrite,
    output wire [31:0] data1, data2
    );

endmodule