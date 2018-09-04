module mux(in1, in2, sel, out); //sel port is connect to a clk

input [15:0]in1,in2;
input sel;
output reg [15:0]out;
 always @ (sel) //clk has an offset before starting. Here, I use T=100 for main CNN, clk for sel should be 400, falling edge fisrt. 
 begin : MUX       //The offset is 105 here(at the very beginning).
   if (sel == 1'b0) begin
      out = in1;
   end else begin
       out = in2 ;
   end
end
 
endmodule //End Of Module mux
