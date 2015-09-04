//top_test.v

module top_test;
	`include "define.h"
	reg[3:0] in;
	reg clk, rst;
	top top(in, clk, rst);
	always #1 clk = ~clk;
	initial begin

	$dumpfile("top_test.vcd");
	$dumpvars(0, top);
	$dumplimit(1000000000000);
	clk = 1;
	rst = 1;
	#20
	rst = 0;
	#1000000000
	$finish;
end
endmodule
