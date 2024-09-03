`timescale 1ns / 1ps
//`include "ALU_main.v"
//`include "branching_unit.v"
module instruction_execution(
    ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,
    EX_MEM_ALU_OUT,EX_MEM_IR,EX_MEM_PC,ID_EX_PC
);
input [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,ID_EX_PC;
output [31:0] EX_MEM_ALU_OUT,EX_MEM_IR;
output[31:0] EX_MEM_PC;
wire [31:0] branch_pc;
wire BRANCH;
reg en_alu;
reg [31:0] A_IMM;
assign EX_MEM_IR = ID_EX_IR;
alu alu1(.A(ID_EX_A),.B(ID_EX_B),.IMM(ID_EX_IMM),.IR(ID_EX_IR),.PC(ID_EX_PC),.ALU_OUT(EX_MEM_ALU_OUT),.branch(BRANCH));
branching_unit branch1(.branch(BRANCH),.IR(ID_EX_IR),.IMM(ID_EX_IMM),.NPC(ID_EX_NPC),.PC(ID_EX_PC),.PC_out(EX_MEM_PC),.A(ID_EX_A));
endmodule