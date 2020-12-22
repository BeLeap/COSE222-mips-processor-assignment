module alu_mips(a, b, shamt, control, outalu, zero);
input [31:0] a, b;
input [4:0] shamt;
input [3:0] control;
output reg [31:0] outalu;
output zero;

always@(control, a, b)
begin
	case(control)
		0 : outalu=a&b;
		1 : outalu=a|b;
		2 : outalu=a<<shamt;
		4 : outalu=a+b;
		6 : outalu=a-b;
		7 : outalu=a<b?1:0;
		12 : outalu=~(a|b);
		default : outalu=0;
	endcase
end

assign zero=outalu==0?1:0;

endmodule
