`timescale 1ns / 1ps
module am4bit(
input [3:0] A,
input [3:0] B,
output [7:0] S
    );
    wire [3:0] W0,W1,W2,W3;
    wire sm,sm1,sm2,sm3,sm4,sm5;
    wire C1,C2,C3,C4,C5,C6,C7,C8,C9,C10;
    genvar g;
    generate
    for(g = 0; g<4; g=g+1) begin
      and a0(W0[g],A[g],B[0]);
      and a1(W1[g],A[g],B[1]);
      and a2(W2[g],A[g],B[2]);
      and a3(W3[g],A[g],B[3]);
    end
  endgenerate
  assign S[0] = W0[0];
  half_adder ha0(W0[1],W1[0],S[1],C1);
  full_adder fa0(W0[2],W1[1],C1,sm,C2);
  full_adder fa1(W0[3],W1[2],C2,sm1,C3);
  half_adder ha1(W1[3],C3,sm2,C4);
  
   half_adder ha2(sm,W2[0],S[2],C5);
   full_adder fa2(sm1,W2[1],C5,sm3,C6);
  full_adder fa3(sm2,W2[2],C6,sm4,C7);
  full_adder fa4(C4,W2[3],C7,sm5,C8);
  
  half_adder ha3(sm3,W3[0],S[3],C9);
  full_adder fa5(sm4,W3[1],C9,S[4],C10);
  full_adder fa6(sm5,W3[2],C10,S[5],C11);
  full_adder fa7(C8,W3[3],C11,S[6],S[7]);
endmodule

module full_adder(
input a,input b,input c_in,
output sum,output carry);
assign sum = a^b^c_in;
assign carry = (a&b) | (c_in&(a^b));
endmodule
module half_adder(
input a,input b,
output sum,output carry);
assign sum = a^b;
assign carry = a&b;
endmodule