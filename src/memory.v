module memory(
    input wire rst, clk,
    input wire [31:0] addr, write_data,
    input wire MemWrite, MemRead,
    output wire [31:0] read_data
    );

    reg [31:0] mem [0:63];

    always @(negedge rst or posedge clk) begin
        if (!rst) begin
            $readmemb("./memory.mem", mem);
        end
        else if (MemWrite) begin
                mem[addr] <= write_data;
        end
    end

    assign read_data = MemWrite ? write_data : mem[addr];

endmodule