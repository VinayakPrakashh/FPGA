`timescale 1ns / 1ps
//`include "PC.v"
//`include "instruction_mem.v"
module instruction_fetch (
PC_NEXT,clk,rst,IF_ID_IR,IF_ID_NPC
);
input clk,rst;
output [31:0] IF_ID_IR,IF_ID_NPC;
input [31:0] PC_NEXT;
wire [31:0] PC;
 
P_C1 P_C4(
    .clk(clk),
    .rst(rst),
    .PC_NEXT(PC_NEXT),
    .PC(PC)
);
instruction_mem1 instruction_memory6(
    .A(PC),
    .RD(IF_ID_IR)
);
assign IF_ID_NPC=PC+1;
endmodule