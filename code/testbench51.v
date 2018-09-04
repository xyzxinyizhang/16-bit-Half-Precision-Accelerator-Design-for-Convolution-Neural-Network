// `timesccale 1 ns/ 1 ps
module testbench51();
reg      clk;
reg      clk2;
reg    [15:0]f1,f2,p;
reg  [7:0]in_1;
reg  [7:0]in_2;
wire  [15:0]out;
reg [16:0] num; //num and num2 are used for shifting
reg [16:0] num2;
//reg  error;
reg [7:0] tv[100000000:0]; //define memory, input is 256*256
integer i,j, k;

top_level i1 (
  
	.in_1(in_1),
	.in_2(in_2),
        .out(out),
         .clk(clk),
         .clk2(clk2),
.f1(f1),
.f2(f2),
.p(p)
	);

parameter weight1=16'b0011110000000000;
parameter weight2=16'b0011110000000000;
parameter weight3=16'b0011110000000000;
parameter weight4=16'b0011110000000000;
parameter bias=16'b0011110000000000;


//set clk for checking, T=20ps
always
  begin
  clk=1; #50; clk=0; #50; //set T=100ps
    end

initial
begin
  $readmemb("cnn.tv", tv); //matlab convert the matrix row by row, and then put all 8-bit inputs in one column
  #1;
  for (i=0; i< 254; i=i+1) //254=256-2, 256 is the image rows, determine which row
    for (j=0; j< 254; j=j+1)//254=256-2, 256 is the image colums, determine which column
  begin
  num=i*256; num2=(i+1)*256;
  in_1=tv[num+j];
  in_2=tv[num+j+1];
  f1=weight1;
  f2=weight2;
  p=bias;
  #200;   //200 is twice as 100, the speed of send input is 0.5x of main clk
  in_1=tv[num2+j];
  in_2=tv[num2+j+1];
  f1=weight3;
  f2=weight4;
  p=bias;
  #200;
  end
  
end

initial 
begin
#700;  //cannot get the forst result until 700ps
 for (k=0; k< 50; k=k+1)  //k should be 255*255
begin
$display("\nat current time", $time);
$display("This is result number %d", {k});
#200;  //add delay to show the output, this will avoid the first intermediate data
$display("%b", {out});
#200;
end
end
endmodule
