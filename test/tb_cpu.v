module tb_cpu();

reg rst, clk;
// wire [6:0] seg0, seg1, seg2, seg3, seg4, seg5;
// cpu uut(rst, clk ,seg0, seg1, seg2, seg3, seg4, seg5);

wire [31:0] result, chk;
cpu uut(rst, clk, result, chk);

initial begin
    rst = 0; clk = 0;
    #50 rst = 1;
end

always #25 begin
    clk = ~clk;
end

endmodule