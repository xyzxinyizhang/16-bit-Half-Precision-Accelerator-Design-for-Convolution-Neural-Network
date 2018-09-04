module main_adder (AA, BB,clk, R_add);
input [15:0] AA, BB; 
input clk;            //input to module "compare 
output  [15:0] R_add;               //result for adder
              //result for substract
wire [14:0]temp_Sum_M_C; 
wire [13:0]temp_Sub_M_C, temp_lza_count_reg;
wire [15:0]temp_L, temp_S;

compare_adder inst_1  (.C_L(temp_L), .C_S(temp_S), .A(AA), .B(BB),.clk(clk)); //get the larger one and smaller one
shift_adder inst_2    ( temp_sign, temp_Sum_M_C, temp_Sub_M_C, temp_lza_count_reg, temp_L, temp_S,clk);
adder inst_3          (R_add, temp_L, temp_S, temp_sign, temp_Sum_M_C, temp_Sub_M_C, temp_lza_count_reg,clk );


endmodule
