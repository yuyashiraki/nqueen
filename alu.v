//alu.v

module alu(op, in0, in1, in2, in3, out);
	`include "define.h"
	input [3:0] op;
	input [7:0] in0, in1, in2, in3;
	output [7:0] out;
	reg [7:0] out;
	wire [7:0] sum0, sum1, sum2, sum3;

	assign sum0 = in0 + in2;
	assign sum1 = in1 + in3;
	assign sum2 = in1 + in2;
	assign sum3 = in0 + in3;

	always@(*)begin
		case (op)
// synopsys parallel_case
// synopsys full_case
		ADD: out <= in0 + in1;
		SUB: out <= in0 - in1;
		MUL: out <= in0 * in1;
		INC: out <= in0 + 1;
		DEC: out <= in0 - 1;
		CHECK: if (in0 != in1) out <= 1;
		       else out <= 0;
		LOADIN: out <= in0;
		STORE: out <= in0;
		SUPERCHECK: if (in0 != in1 && sum0 != sum1 && sum2 != sum3) out <= 1;
		            else out <= 0;
		default out <= 0;
		endcase
	end
endmodule
