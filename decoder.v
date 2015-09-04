//decoder.v

module decoder(op, alu_op, src0, src1, dst, sel1, sel2, reg_we, mem_we, data, jmp_addr);
	`include "define.h"
	input [17:0] op;
	output sel1, sel2, reg_we, mem_we;
	output [3:0] alu_op, src0, src1, dst;
	output [5:0] jmp_addr;
	output [7:0] data;

	reg sel1, sel2, reg_we, mem_we;
	reg [3:0] alu_op, src0, src1, dst;
	reg [5:0] jmp_addr;
	reg [7:0] data;

	always @(*) begin
		case (op[17:14])
		// synopsys parallel_case
		// synopsys full_case
			ADD, SUB, MUL: begin
				alu_op <= op[17:14];
				src0 <= op[13:10];
				src1 <= op[9:6];
				dst <= op[5:2];
				sel1 <= 1;
				sel2 <= 0;
				reg_we <= 1;
				mem_we <= 0;
			end

			CHECK, SUPERCHECK: begin
				alu_op <= op[17:14];
				src0 <= op[13:10];
				src1 <= op[9:6];
				jmp_addr <= op[5:0];
				sel1 <= 1;
				sel2 <= 0;
				reg_we <= 0;
				mem_we <= 0;
			end

			INC, DEC: begin
				alu_op <= op[17:14];
				src0 <= op[13:10];
				dst <= op[5:2];
				sel1 <= 1;
				sel2 <= 0;
				reg_we <= 1;
				mem_we <= 0;
			end

			JUMP: begin
				alu_op <= op[17:14];
				jmp_addr <= op[13:8];
				reg_we <= 0;
				mem_we <= 0;
			end

			LOADIN: begin
				alu_op <= op[17:14];
				dst <= op[5:2];
				data <= op[13:6];
				sel1 <= 0;
				sel2 <= 0;
				reg_we <= 1;
				mem_we <= 0;
			end

			STORE: begin
				alu_op <= op[17:14];
				src0 <= op[13:10];
				src1 <= op[9:6];
				sel1 <= 1;
				sel2 <= 0;
				reg_we <= 0;
				mem_we <= 1;
			end

			LOAD: begin
				alu_op <= op[17:14];
				src1 <= op[9:6];
				dst <= op[5:2];
				sel1 <= 0;
				sel2 <= 1;
				reg_we <= 1;
				mem_we <= 0;
			end

		endcase
	end
endmodule
