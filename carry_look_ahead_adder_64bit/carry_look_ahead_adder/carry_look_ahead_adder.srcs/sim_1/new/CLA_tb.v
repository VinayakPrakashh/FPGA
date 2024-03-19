`timescale 1ns / 1ps
module CLA_tb;
reg [63:0] A,B;
reg C0;
wire [63:0] S;
wire C4;
CLA64bit uut(A,B,C0,S,C4);
initial begin
A <= 64'h2345675476547654;
B <= 64'h5784634576547625;
C0 <= 0;
#100
A <= 64'h2345675476547654;
B <= 64'h2345675476547654;
C0 <= 1;
end
endmodule
