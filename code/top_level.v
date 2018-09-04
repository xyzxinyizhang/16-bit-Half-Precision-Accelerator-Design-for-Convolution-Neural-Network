module top_level(f1,f2,p,in_1,in_2,out,clk,clk2);
input [7:0]in_1, in_2;
input clk;
input clk2;
input [15:0]p;  //bias
input [15:0]f1,f2; //weight for every two numbers
output [15:0]out;

wire [15:0]a,b;
wire [15:0]r1,r2,r3,r4,r5;

convert inst_1(.float(a), .int8(in_1), .clk(clk)); //parallel int to float16
convert inst_2(.float(b), .int8(in_2), .clk(clk));
mult inst_3(.B(f1), .C(r1), .A(a), .clk(clk));  //parallel multi, .B(f) is the weight, .A(a) is the float16  .C is the multiply result
mult inst_4(.B(f2), .C(r2), .A(b), .clk(clk));
main_adder inst_5 (.AA(r1), .BB(r2),.clk(clk), .R_add(r3));// sum of first two multi
mux inst_6(.in1(r4), .in2(p), .sel(clk2), .out(r5)); //p at port 1, r4 at port 0
main_adder inst_7 (.AA(r3), .BB(r5),.clk(clk), .R_add(r4)); //the first value is intermediate data, should only keep the second one (for each 2*2 block)
//a mux can be added after inst_7, so the output can alway be the needed one..might add it later.
assign out=r4;




endmodule
