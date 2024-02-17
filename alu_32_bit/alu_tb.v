`timescale 1ns / 1ps
module alu_tb;
reg [2:0] opcode;
reg [31:0] a,b;
reg en;
wire [31:0] y;
alu dut(y,a,b,opcode,en);
initial begin 
en=0;
#10
en =1;
opcode = 3'b000;
a = 32'd4245; b = 32'd2345;
end
endmodule
