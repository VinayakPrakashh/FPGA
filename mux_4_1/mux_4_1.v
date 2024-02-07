`timescale 1ns / 1ps
module MUX_4_1(I,s,Y);

input [3:0]I;
output reg Y;
input [1:0] s;

always @(*)
begin
case ({s[1],s[0]})
2'b00: Y = I[0];
2'b01: Y = I[1];
2'b10: Y = I[2];
2'b11: Y = I[3];
endcase
end
endmodule
