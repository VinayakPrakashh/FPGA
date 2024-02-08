`timescale 1ns / 1ps
module bit4_ripple(s,cy4,c_in,x,y);
input [3:0 ]x,y;
output[3:0] s;
output cy4;
input c_in;
wire [2:0] cy_out;
add b0(cy_out[0],s[0],x[0],y[0],c_in);
add b1(cy_out[1],s[1],x[1],y[1],cy_out[0]);
add b2(cy_out[2],s[2],x[2],y[2],cy_out[1]);
add b3(cy4,s[3],x[3],y[3],cy_out[2]);

endmodule
