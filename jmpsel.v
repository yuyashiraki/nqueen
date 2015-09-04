//jmpsel.v
module jmpsel(alu_op, alu_out, jmp_addr, pc_in, clk, rst, pc_we);
	`include "define.h"
	input rst, clk;
	input [3:0] alu_op;
	input [7:0] alu_out;
	input [5:0] jmp_addr;
	output [5:0] pc_in;
	output pc_we;
	reg [5:0] pc_in;
	reg pc_we;

	always @(posedge clk or negedge rst) begin
		if (rst == 1'b1) begin
			pc_in = 5'b0;
			pc_we = 1'b0;
		end
		// SUPERCHECK$B!&(BCHECK$BL?Na$N$H$-$+$D%A%'%C%/$G%U%i%0$,N)$C$F$$$k>l9g(B
		// $B$b$7$/$O(BJMP$BL?Na$N>l9g(B
		// $B%8%c%s%W@h$r%;%C%H(B
		if (alu_op == JUMP || ((alu_op == SUPERCHECK || alu_op == CHECK) && alu_out == 1)) begin
			pc_in = jmp_addr;
			pc_we = 1'b1;
		end else begin
			pc_in = 5'b0;
			pc_we = 1'b0;
		end
	end
endmodule
