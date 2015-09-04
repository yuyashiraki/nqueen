//top.v

module top(in, clk, rst);
	`include "define.h"
	input[3:0] in;
	input clk, rst;
	wire[3:0] dst, src0, src1, alu_op;
	wire[5:0] pc_in, jmp_addr, pc;
	wire[7:0] data1, data2, data3, data4, data_in, alu_in, alu_out, reg_out, mem_data;
	wire[17:0] op;
	wire pc_we, reg_we, mem_we, sel1, sel2;

	pc pc1(.pc_in(pc_in), .we(pc_we), .clk(clk), .rst(rst), .pc_out(pc));

	imem imem(.pc(pc), .op(op));

	decoder decoder(.op(op), .jmp_addr(jmp_addr), .dst(dst), .reg_we(reg_we), .src0(src0), .src1(src1), .data(data1), .sel1(sel1), .sel2(sel2), .alu_op(alu_op), .mem_we(mem_we));

	alu alu(.op(alu_op), .in0(data_in), .in1(alu_in), .in2(data3), .in3(data4), .out(alu_out));

	register register(.src0(src0), .src1(src1), .dst(dst), .we(reg_we), .clk(clk), .rst(rst), .data0(reg_out), .data1(alu_in), .data2(data3), .data3(data4), .data(data2));

	selector selector1(.sel(sel1), .in0(data1), .in1(reg_out), .out(data_in));

	selector selector2(.sel(sel2), .in0(alu_out), .in1(mem_data), .out(data2));

	jmpsel jmpsel1(.alu_op(alu_op), .alu_out(alu_out), .jmp_addr(jmp_addr), .pc_in(pc_in), .pc_we(pc_we), .clk(clk), .rst(rst));

	memory memory(.we(mem_we), .addr(alu_in), .di(alu_out), .do(mem_data), .clk(clk), .rst(rst));
endmodule
