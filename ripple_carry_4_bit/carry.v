`timescale 1ns / 1ps
module carry(cy_out,a,b,c_in);
input a,b,c_in;
output cy_out;
assign cy_out = (a&b)| ((a^b)&c_in);
endmodule
