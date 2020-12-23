module register(
    input wire rst, clk,
    input wire [4:0] read1, read2,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire RegWrite,
    output wire [31:0] data1, data2
    );

    reg [31:0] mem[0:31];

    always @(negedge rst or posedge clk) begin
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
        else if (RegWrite == 1'b1 && write_reg != 5'd0) begin
            mem[write_reg] = write_data;
        end
    end

    reg [31:0] _data1, _data2;

    always @(posedge clk) begin
        if (read1 != 5'd0) begin
            _data1 = mem[read1][31:0];
        end
        else begin
            _data1 = 32'd0;
        end

        if (read2 != 5'd0) begin
            _data2 = mem[read2][31:0];
        end
        else begin
            _data2 = 32'd0;
        end
    end

    assign data1 = _data1;
    assign data2 = _data2;

endmodule