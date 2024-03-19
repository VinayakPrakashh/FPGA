`timescale 1ns / 1ps

module am4bit_tb;

reg [3:0] A,B;
wire [7:0] S;
am4bit am(A,B,S);
initial begin 
A = 4'b1111;
B = 4'b0100;
#100
A = 4'b1000;
B = 4'b0111;
end
endmodule
