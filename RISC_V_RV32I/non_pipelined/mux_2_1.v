`timescale 1ns / 1ps
module mux_2_1(
A,B,S,Y
    );
    input [31:0] A,B;
    input S;
    output [31:0] Y;
    assign Y = (S==1'b1)?B:A;
endmodule
