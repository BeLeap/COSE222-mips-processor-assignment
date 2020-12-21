module register(
    input wire rst, clk,
    input wire [4:0] read1, read2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire RegWrite,
    output reg [31:0] data1, data2
    );

    reg [31:0] mem [0:31];

    always @(posedge clk) begin
        if (read1 == 5'd0)
            data1 = 32'd0;
        else if ((read1 == write_reg) && RegWrite)
            mem[write_reg] <= write_data;
        else
            data1 = mem[read1][31:0];
    end

    always @(posedge clk) begin
        if (read2 == 5'd0)
            data2 = 32'd0;
        else if ((read2 == write_reg) && RegWrite)
            mem[write_reg] <= write_data;
        else
            data2 = mem[read2][31:0];
    end

endmodule