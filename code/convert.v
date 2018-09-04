module convert( float, int8,clk);
input clk;
output [15:0] float;
input [7:0] int8;
reg [4:0] exp;
reg [9:0] mantissa;
integer i;

always @(negedge clk)
begin
if(int8 != 8'b0) 
begin
for(i = 0; i < 8; i = i + 1)
    if(int8[i]) 
      exp = i;
      if(exp < 10)
      mantissa = int8 << (10 - exp);
      else
      mantissa = int8;
      exp = exp + 15;
 end

else begin
 mantissa=0;
exp=0;
    end
end

assign float = {1'b0, exp, mantissa};
endmodule
