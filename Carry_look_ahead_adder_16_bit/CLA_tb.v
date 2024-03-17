`timescale 1ns / 1ps
module CLA_tb;
reg [15:0] A,B;
reg C0;
wire [15:0] S;
wire C4;
CLA16bit uut(A,B,C0,S,C4);
initial begin
A <= 16'b1111000000000000;
B <= 16'b1111000100000001;
C0 <= 0;
#100
A <= 16'b1110111101010001;
B <= 16'b1111101010010110;
C0 <= 0;
end
endmodule
