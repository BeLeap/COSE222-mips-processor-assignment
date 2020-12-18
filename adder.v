module adder(
    input wire [31:0] a, b,
    output wire [31:0] out
    );

assign out = a + b;

endmodule