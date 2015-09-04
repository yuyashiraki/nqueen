module imem(pc, op);
	`include "define.h"
	input [5:0] pc;
	output [17:0] op;
	reg [17:0] op;

	parameter N = 8'b0000_0101;

	always @(pc) begin
		case(pc)
// synopsys parallel_case
// synopsys full_case

//初期化
		0: op = {LOADIN, N, 4'b1111, DC2}; //$15 = N of Nqueen
		1: op = {LOADIN, 8'b0000_0001, 4'b1110, DC2}; //x1の値を$14に代入
		2: op = {LOADIN, 8'b0000_0001, 4'b1101, DC2}; //y1の値を$13に代入
		3: op = {LOADIN, 8'b0000_0010, 4'b1100, DC2}; //x2の値を$12に代入
		4: op = {LOADIN, 8'b0000_0011, 4'b1011, DC2}; //y2の値を$11に代入
		5: op = {LOADIN, 8'b0000_0000, 4'b1010, DC2}; //$10を今まで出た解の数を数えるcounter
		6: op = {LOADIN, 8'b0000_0000, 4'b0000, DC2}; //$0 = 0
		7: op = {LOADIN, 8'b0000_0001, 4'b0001, DC2}; //$1 = 1
		8: op = {LOADIN, 8'b0000_0010, 4'b0010, DC2}; //$2 = 2

//START
		9: op = {STORE, 4'b1101, 4'b1110, DC6}; //mem[x1] = reg[y1]

//SUPERCHECK
		10: op = {SUPERCHECK, 4'b1101, 4'b1011, 6'b011100}; //全チェック。全部OKなら[GOOD]にJUMP

//終了チェック
		11: op = {CHECK, 4'b1011, 4'b1111, 6'b010000}; //y2<Nで[y2ループ]にJUMP
		12: op = {CHECK, 4'b1100, 4'b0010, 6'b010100}; //x2>2で[1個戻りy2ループ]にJUMP
		13: op = {LOAD, DC4, 4'b0001, 4'b1101, DC2}; //reg[y1]=mem[1]
		14: op = {CHECK, 4'b1101, 4'b1111, 6'b010111}; //x1==1の時のy1<Nで[NotFINISHED]にJUMP
		15: op = {JUMP, 6'b001111, DC8}; // 終了。ここにJUMPし続ける（ダイナミックエンド）

//y2ループ
		16: op = {INC, 4'b1011, DC4, 4'b1011, DC2}; //y2+=1
		17: op = {LOADIN, 8'b0000_0001, 4'b1110, DC2}; //x1=1

//RESTART
		18: op = {LOAD, DC4, 4'b1110, 4'b1101, DC2}; //reg[y1]=mem[x1]
		19: op = {JUMP, 6'b001010, DC8}; //[SUPERCHECK]にJUMP

//1個戻りy2ループ
		20: op = {DEC, 4'b1100, DC4, 4'b1100, DC2}; //x2-=1
		21: op = {LOAD, DC4, 4'b1100, 4'b1011, DC2}; //reg[y2]=mem[x2]
		22: op = {JUMP, 6'b001011, DC8}; //[終了チェック]にJUMP

//NotFINISHED
		23: op = {INC, 4'b1101, DC4, 4'b1101, DC2}; //y1<Nなのでy1+=1
		24: op = {LOADIN, 8'b0000_0001, 4'b1110, DC2}; //x1=1
		25: op = {LOADIN, 8'b0000_0010, 4'b1100, DC2}; //x2=2
		26: op = {LOADIN, 8'b0000_0001, 4'b1011, DC2}; //y2=1
		27: op = {JUMP, 6'b001001, DC8}; //[START]にJUMP

//GOOD
		28: op = {INC, 4'b1110, DC4, 4'b1110, DC2}; //x1を1つ右に移動
		29: op = {CHECK, 4'b1100, 4'b1110, 6'b010010}; //x1!=x2で[RESTART]にJUMP

//置けること確定
		30: op = {STORE, 4'b1011, 4'b1100, DC6}; //置けるからmem[x2]=reg[y2]
		31: op = {CHECK, 4'b1100, 4'b1111, 6'b100011}; //x2<Nで[x2ループ]にJUMP

//x2ループ終了
		32: op = {INC, 4'b1010, DC4, 4'b1010, DC2}; //1個解が求まったのでcounter+=1
		33: op = {STORE, 4'b1010, 4'b0000, DC6}; //mem[0]+=1 counterの値をメモリに投げる
		34: op = {JUMP, 6'b001011, DC8}; //[終了チェック]にJUMP

//x2ループ
		35: op = {INC, 4'b1100, DC4, 4'b1100, DC2}; //x2+=1
		36: op = {LOADIN, 8'b0000_0001, 4'b1011, DC2}; //y2=1
		37: op = {LOADIN, 8'b0000_0001, 4'b1110, DC2}; //x1=1
		38: op = {JUMP, 6'b010010, DC8}; //[RESTART]にJUMP

		endcase
	end
endmodule
