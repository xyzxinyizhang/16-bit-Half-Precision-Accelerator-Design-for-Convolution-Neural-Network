module mult(B,C, A, clk);
input  [15:0]A;
input clk;
input [15:0]B;
output reg    [15:0]C;

wire          [5:0]e;  //value of E in calculation
wire           [21:0]m; //value of 1.Ma*1.Mb in calculation
wire            [10:0]A_m;    //1.Ma
wire            [10:0]B_m;    //1.Mb

reg           [4:0]C_e; //get E for C
wire            C_sign; //get sign for C
reg           [9:0]C_m; //get Mantissa for C
//get sign

assign C_sign=(A[15]^B[15]); 
//get E
assign e[5:0]=(A[14:10]+B[14:10]-4'b1111); 
//get 1.Matissa for  A:1XXXX  B:XXXX   
assign A_m[10:0]={1'b1, A[9:0]};
assign B_m[10:0]={1'b1, B[9:0]};
assign m[21:0]=(A_m[10:0])*(B_m[10:0]);  //get a new 1.M


//end calculation

//get mantissa in C 
always@(posedge clk)
begin

if (A==0)  //consider 0 case
  begin
  C=16'b0;
  end
else begin
    if (m[21]==1'b1) 
    begin
    C_m=m[20:11];
    C_e=e[4:0]+m[21];
    C={C_sign,C_e[4:0],C_m[9:0]};
    end 
    else begin
    C_m=m[19:10];
    C_e=e[4:0]+m[21];
    C={C_sign,C_e[4:0],C_m[9:0]};
    end
end

//C_e=e[4:0]+m[21];
//C={C_sign,C_e[4:0],C_m[9:0]};
end
endmodule

