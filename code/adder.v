module adder(R_add, L, S, sign, Sum_M_C, Sub_M_C,lza_count_reg,clk );

input clk;
input [15:0] L, S;              //output of module "compare
input sign;                      //get sign of final result
input [14:0] Sum_M_C;            //sum of mantissa(15bits)'
input [13:0] Sub_M_C;           //subtract of mantissa(14bits)'
reg [13:0] Sub_M_CS;                    //create a new sub for shifting
input [13:0] lza_count_reg;               //count leading zero 
output reg [15:0] R_add;               //result for adder




always @(posedge clk)
begin
if (L==0 &  S==0)
  begin
  R_add=16'b0;
  end
  else begin
if (L[15]^S[15]==0)           //both are positive or negative
 begin
R_add[15]=sign;                     //assign sign 
R_add[14:10]=L[14:10]+Sum_M_C[14];  //exponent +1, if the sum of mantissa is larger than 2
 if (Sum_M_C[14]==1)
 begin
 R_add[9:0]=Sum_M_C[13:4];
 end 
 else begin
 R_add[9:0]=Sum_M_C[12:3];            //assign mantissa
 end
 end 
 else begin                        //two numbers have diferent sign
R_add[15]=sign;
R_add[14:10]=L[14:10]-lza_count_reg;
Sub_M_CS[13:0]=(Sub_M_C[13:0]<<lza_count_reg);
R_add[9:0]=Sub_M_CS[12:3];          
end
end
end
endmodule
