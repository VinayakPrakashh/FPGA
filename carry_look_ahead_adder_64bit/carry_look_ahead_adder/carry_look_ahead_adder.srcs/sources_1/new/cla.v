`timescale 1ns / 1ps
module adder(
input A,
input B,
output P,
output G);
assign P = A^B;
assign G = A&B;
endmodule



module sum(
input P,
input C,
output S);
assign S = P^C;
endmodule

module CLA4bit(
input [3:0] A,
input [3:0] B,
input C0,
output [3:0] S,
output C4);
wire [3:0] G,P;
wire C1,C2,C3;
adder add0(A[0],B[0],P[0],G[0]);
adder add1(A[1],B[1],P[1],G[1]);
adder add2(A[2],B[2],P[2],G[2]);
adder add3(A[3],B[3],P[3],G[3]);
assign C1 =G[0] | (P[0]&C0);
assign C2 =G[1] | (P[1]&G[0]) | (P[1]&P[0]&C0);
assign C3 =G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]%P[1]&P[0]&C0);
assign C4 =G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]%P[2]&P[1]&P[0]&C0);
sum sum0(P[0],C0,S[0]);
sum sum1(P[1],C1,S[1]);
sum sum2(P[2],C2,S[2]);
sum sum3(P[3],C3,S[3]);
endmodule
module CLA16bit(
input [15:0] A,
input [15:0] B,
input C0,
output [15:0] S,
output C4
);
wire C1,C2,C3;
CLA4bit cla0(A[3:0],B[3:0],C0,S[3:0],C1);
CLA4bit cla1(A[7:4],B[7:4],C1,S[7:4],C2);
CLA4bit cla2(A[11:8],B[11:8],C2,S[11:8],C3);
CLA4bit cla3(A[15:12],B[15:12],C3,S[15:12],C4);

endmodule
module CLA64bit(
input [63:0] A,
input [63:0] B,
input C0,
output [63:0] S,
output C4
);
wire C1,C2,C3;
CLA16bit cla640(A[15:0],B[15:0],C0,S[15:0],C1);
CLA16bit cla641(A[31:16],B[31:16],C1,S[31:16],C2);
CLA16bit cla642(A[47:32],B[47:32],C2,S[47:32],C3);
CLA16bit cla643(A[63:48],B[63:48],C3,S[63:48],C4);
endmodule