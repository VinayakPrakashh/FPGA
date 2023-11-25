`timescale 1ns / 1ps

module _2_1_mux(D1,D0,S,Y);
input D1,D0;
input S;
output Y;
wire W[2:0];
and and1(W[0],D1,S);
not not1(W[1],S);
and and2(W[2],W[1],D0);
or or1(Y,W[0],W[2]);
endmodule