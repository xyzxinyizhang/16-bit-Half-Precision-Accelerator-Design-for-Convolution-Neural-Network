module shift_adder ( sign, Sum_M_C, Sub_M_C, lza_count_reg,L, S,clk);

input [15:0] L, S;  
input clk;            //output of module "compare
output reg sign;                      //get sign of final result
reg [13:0] M_C_L, M_C_S;       //mantissa after adding 3 bits
reg [13:0]M_C_Lnew, M_C_Snew;  //mantissa after shifting
output  reg[14:0] Sum_M_C;            //sum of mantissa(15bits)'
output  reg[13:0] Sub_M_C;           //subtract of mantissa(14bits)'


reg [13:0] Sub_M_CS;                    //create a new sub for shifting
output reg [13:0] lza_count_reg;               //count leading zero 
reg [4:0] count; 
always@ (*)

begin
M_C_L[13:0]={1'b1, L[9:0], 3'b000};                     //add additional bits 
M_C_S[13:0]={1'b1, S[9:0], 3'b000};

sign=L[15];                                             // the sign of result is always the same as the C_L

M_C_Snew[13:0]=M_C_S[13:0]>>(L[14:10]-S[14:10]);        // C_S mantissa after alignment
M_C_Lnew[13:0]=M_C_L[13:0];                             // C_L mantissa after alignment

Sum_M_C[14:0]=M_C_Lnew[13:0]+ M_C_Snew[13:0];           //sum of mantissa
Sub_M_C[13:0]=M_C_Lnew[13:0]- M_C_Snew[13:0];           //substract of mantissa

begin 
//Sub_M_CS[13:0]<=Sub_M_C[13:0];
//lza_count_reg=14;                                         //start from LSB, if bit=1, lza_
for( count=0; count<14; count=count+1 ) 
if( Sub_M_C[ count ] ) 
lza_count_reg=13-count; 
end 
end
endmodule
