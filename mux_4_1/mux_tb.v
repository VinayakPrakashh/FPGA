`timescale 1ns / 1ps
module MUX_TB;
reg [3:0]I;
reg [1:0]s;
wire Y;
MUX_4_1 dut(I,s,Y);
initial begin
s[0] = 0;s[1] = 0; I[0] = 1;
#50
s[0] = 0;s[1] = 0; I[0] = 0;
end
endmodule
