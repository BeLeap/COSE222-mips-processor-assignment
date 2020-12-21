module mux21(
    input wire [31:0] D0, D1,
    input wire S,
    output reg [31:0] Y
    );

    always @(D0 or D1 or S)
    begin
        if(S)
            Y = D1;
        else
            Y = D0;
    end
endmodule