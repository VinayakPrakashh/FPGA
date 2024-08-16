`timescale 1ns / 1ps
//`include "decode_unit.v"
module instruction_decode (IF_ID_IR,IF_ID_NPC,ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR
);
input [31:0] IF_ID_IR,IF_ID_NPC;
output [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR;

decode_unit decode_unit1(.IR(IF_ID_IR),.A(ID_EX_A),.B(ID_EX_B),.IMM(ID_EX_IMM));
assign ID_EX_NPC=IF_ID_NPC;
assign ID_EX_IR =IF_ID_IR;

endmodule
