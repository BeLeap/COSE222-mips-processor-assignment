module memory(
    input wire rst, clk,
    input wire [31:0] addr, write_data,
    input wire MemWrite, MemRead,
    output wire [31:0] read_data
    );

    reg [31:0] mem [0:63];

    initial begin
        mem [0] = 00000000000000000000000000000000;
        mem [1] = 00000000000000000000000000000001;
        mem [2] = 00000000000000000000000000000010;
        mem [3] = 00000000000000000000000000000011;
        mem [4] = 00000000000000000000000000000100;
        mem [5] = 00000000000000000000000000000111;
        mem [6] = 00000000000000000000000000000110;
        mem [7] = 00000000000000000000000000000111;
        mem [8] = 00000000000000000000000000001000;
        mem [9] = 00000000000000000000000000001001;
        mem [10] = 00000000000000000000000000001010;
        mem [11] = 00000000000000000000000000001011;
        mem [12] = 00000000000000000000000000001100;
        mem [13] = 00000000000000000000000000001101;
        mem [14] = 00000000000000000000000000001110;
        mem [15] = 00000000000000000000000000001111;
        mem [16] = 00000000000000000000000000010000;
        mem [17] = 00000000000000000000000000010001;
        mem [18] = 00000000000000000000000000010010;
        mem [19] = 00000000000000000000000000010011;
        mem [20] = 00000000000000000000000000010100;
        mem [21] = 00000000000000000000000000010101;
        mem [22] = 00000000000000000000000000010110;
        mem [23] = 00000000000000000000000000010111;
        mem [24] = 00000000000000000000000000011000;
        mem [25] = 00000000000000000000000000011001;
        mem [26] = 00000000000000000000000000011010;
        mem [27] = 00000000000000000000000000011011;
        mem [28] = 00000000000000000000000000011100;
        mem [29] = 00000000000000000000000000011101;
        mem [30] = 00000000000000000000000000011110;
        mem [31] = 00000000000000000000000000011111;
        mem [32] = 00000000000000000000000000000000;
        mem [33] = 00000000000000000000000000000001;
        mem [34] = 00000000000000000000000000000010;
        mem [35] = 00000000000000000000000000000011;
        mem [36] = 00000000000000000000000000000100;
        mem [37] = 00000000000000000000000000000101;
        mem [38] = 00000000000000000000000000000110;
        mem [39] = 00000000000000000000000000000111;
        mem [40] = 00000000000000000000000000001000;
        mem [41] = 00000000000000000000000000001001;
        mem [42] = 00000000000000000000000000001010;
        mem [43] = 00000000000000000000000000001011;
        mem [44] = 00000000000000000000000000001100;
        mem [45] = 00000000000000000000000000001101;
        mem [46] = 00000000000000000000000000001110;
        mem [47] = 00000000000000000000000000001111;
        mem [48] = 00000000000000000000000000010000;
        mem [49] = 00000000000000000000000000010001;
        mem [50] = 00000000000000000000000000010010;
        mem [51] = 00000000000000000000000000010011;
        mem [52] = 00000000000000000000000000010100;
        mem [53] = 00000000000000000000000000010101;
        mem [54] = 00000000000000000000000000010110;
        mem [55] = 00000000000000000000000000010111;
        mem [56] = 00000000000000000000000000011000;
        mem [57] = 00000000000000000000000000011001;
        mem [58] = 00000000000000000000000000011010;
        mem [59] = 00000000000000000000000000011011;
        mem [60] = 00000000000000000000000000011100;
        mem [61] = 00000000000000000000000000011101;
        mem [62] = 00000000000000000000000000011110;
        mem [63] = 00000000000000000000000000011111;
    end

    always@(negedge rst or posedge clk)
    begin
        if (!rst) begin
            mem [0] = 00000000000000000000000000000000;
            mem [1] = 00000000000000000000000000000001;
            mem [2] = 00000000000000000000000000000010;
            mem [3] = 00000000000000000000000000000011;
            mem [4] = 00000000000000000000000000000100;
            mem [5] = 00000000000000000000000000000111;
            mem [6] = 00000000000000000000000000000110;
            mem [7] = 00000000000000000000000000000111;
            mem [8] = 00000000000000000000000000001000;
            mem [9] = 00000000000000000000000000001001;
            mem [10] = 00000000000000000000000000001010;
            mem [11] = 00000000000000000000000000001011;
            mem [12] = 00000000000000000000000000001100;
            mem [13] = 00000000000000000000000000001101;
            mem [14] = 00000000000000000000000000001110;
            mem [15] = 00000000000000000000000000001111;
            mem [16] = 00000000000000000000000000010000;
            mem [17] = 00000000000000000000000000010001;
            mem [18] = 00000000000000000000000000010010;
            mem [19] = 00000000000000000000000000010011;
            mem [20] = 00000000000000000000000000010100;
            mem [21] = 00000000000000000000000000010101;
            mem [22] = 00000000000000000000000000010110;
            mem [23] = 00000000000000000000000000010111;
            mem [24] = 00000000000000000000000000011000;
            mem [25] = 00000000000000000000000000011001;
            mem [26] = 00000000000000000000000000011010;
            mem [27] = 00000000000000000000000000011011;
            mem [28] = 00000000000000000000000000011100;
            mem [29] = 00000000000000000000000000011101;
            mem [30] = 00000000000000000000000000011110;
            mem [31] = 00000000000000000000000000011111;
            mem [32] = 00000000000000000000000000000000;
            mem [33] = 00000000000000000000000000000001;
            mem [34] = 00000000000000000000000000000010;
            mem [35] = 00000000000000000000000000000011;
            mem [36] = 00000000000000000000000000000100;
            mem [37] = 00000000000000000000000000000101;
            mem [38] = 00000000000000000000000000000110;
            mem [39] = 00000000000000000000000000000111;
            mem [40] = 00000000000000000000000000001000;
            mem [41] = 00000000000000000000000000001001;
            mem [42] = 00000000000000000000000000001010;
            mem [43] = 00000000000000000000000000001011;
            mem [44] = 00000000000000000000000000001100;
            mem [45] = 00000000000000000000000000001101;
            mem [46] = 00000000000000000000000000001110;
            mem [47] = 00000000000000000000000000001111;
            mem [48] = 00000000000000000000000000010000;
            mem [49] = 00000000000000000000000000010001;
            mem [50] = 00000000000000000000000000010010;
            mem [51] = 00000000000000000000000000010011;
            mem [52] = 00000000000000000000000000010100;
            mem [53] = 00000000000000000000000000010101;
            mem [54] = 00000000000000000000000000010110;
            mem [55] = 00000000000000000000000000010111;
            mem [56] = 00000000000000000000000000011000;
            mem [57] = 00000000000000000000000000011001;
            mem [58] = 00000000000000000000000000011010;
            mem [59] = 00000000000000000000000000011011;
            mem [60] = 00000000000000000000000000011100;
            mem [61] = 00000000000000000000000000011101;
            mem [62] = 00000000000000000000000000011110;
            mem [63] = 00000000000000000000000000011111;
        end
        else if (MemWrite) begin
                mem[addr] <= write_data;
        end
    end

    assign read_data = MemWrite ? write_data : mem[addr][31:0];

endmodule