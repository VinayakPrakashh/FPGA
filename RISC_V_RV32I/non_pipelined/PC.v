`timescale 1ns / 1ps
module P_C1(
input clk,rst,
input [31:0] PC_NEXT,
output reg [31:0]PC

);
always @(posedge clk) begin
if(rst==1'b1)
begin
    PC<=32'h00000000;
end
else PC<=PC_NEXT;  
end
endmodule
