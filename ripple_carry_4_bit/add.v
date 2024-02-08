`timescale 1ns / 1ps
module add(cy_out,sum,a,b,c_in);
input a,b,c_in;
output sum,cy_out;
sum s1(sum,a,b,c_in);
carry c1(cy_out,a,b,c_in);

endmodule
