module compare_adder (C_L, C_S, A, B,clk);
input [15:0] A, B;
input clk;
output reg[15:0] C_L, C_S;

always@ (posedge clk)

if (A[14:0]>=B[14:0])
 begin
C_L=A[15:0]; C_S=B[15:0];
 end
 else begin
C_L=B[15:0]; C_S=A[15:0];
 end
endmodule
