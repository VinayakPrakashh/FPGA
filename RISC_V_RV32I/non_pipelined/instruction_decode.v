`timescale 1ns / 1ps
//`include "decode_unit.v"
module instruction_decode (IF_ID_IR,IF_ID_NPC,ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,WE,RE,RW_addr,RD1_addr,RD1,RD2,WR1
);
input [31:0] IF_ID_IR,IF_ID_NPC;
output [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR;
output WE,RE;
output [4:0] RW_addr,RD1_addr;
input  [31:0] RD1,RD2;
output [31:0] WR1;
decode_unit decode_unit1(.IR(IF_ID_IR),.A(ID_EX_A),.B(ID_EX_B),
    .WE(WE),
    .RE(RE),
    .RW_addr(RW_addr),
    .RD1_addr(RD1_addr),
    .RD1(RD1),
    .RD2(RD2),
    .WR1(WR1));
sign_extend sign_extend1(.IR(IF_ID_IR),.IMM(ID_EX_IMM));
assign ID_EX_NPC=IF_ID_NPC;
assign ID_EX_IR =IF_ID_IR;

endmodule
