module tb_cpu();

reg rst, clk;
// wire [6:0] seg0, seg1, seg2, seg3, seg4, seg5;
// cpu uut(rst, clk ,seg0, seg1, seg2, seg3, seg4, seg5);

wire [6:0] seg0, seg1, seg2, seg3, seg4, seg5;
cpu uut(rst, clk, seg0, seg1, seg2, seg3, seg4, seg5);

initial begin
    rst = 0; clk = 0;
    #5000; rst = 1;
    #5000; rst = 0;
    #5000; rst = 1;
end

always #25 begin
    clk = ~clk;
end

endmodule