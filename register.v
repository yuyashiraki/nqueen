//register.v
module register(src0,src1,we,dst,clk,rst,data0,data1,data2,data3,data);
	input we,clk,rst;
	input [3:0] src0,src1,dst;
	input [7:0] data;
	output [7:0] data0;
	output [7:0] data1;
	output [7:0] data2;
	output [7:0] data3;
	reg [7:0] regis[15:0];
	integer i;

	always @(posedge clk) begin
		if(rst==1)begin
			for (i=0; i <= 15; i=i+1)
				regis[i] <= 0;
		end else if (we == 1)
			regis[dst] <= data;
		else
			regis[dst] <= regis[dst];
	end

	assign data0 = regis[src0];
	assign data1 = regis[src1];
	assign data2 = regis[4'b1110];
	assign data3 = regis[4'b1100];

endmodule
