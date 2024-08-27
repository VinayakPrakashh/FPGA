`timescale 1ns / 1ps
//`include "instruction_fetch.v"
//`include "instruction_decode.v"
//`include "instruction_execution.v"
//`include "Memory_acess.v"
//`include "write_back.v"
module single_cycle_top (
clk,rst
);
input clk,rst;
wire [31:0] PC_NEXT;
wire [31:0] MEM_WB_ALU_OUT,MEM_WB_IR,MEM_WB_PC;
wire [31:0] EX_MEM_ALU_OUT,EX_MEM_IR;
wire [31:0] EX_MEM_PC;
wire [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR;
wire [31:0] IF_ID_IR,IF_ID_NPC;
wire [31:0] PC_MEM,IR_MEM;
wire EX_WE,EX_RE;
wire [4:0] EX_RW_addr,EX_RD1_addr;
wire [31:0] EX_WR1,EX_RD1,EX_RD2;



instruction_mem1 instruction_memory6(
    .A(PC_MEM),
    .RD(IR_MEM)
);
reg_file rg(.WE(EX_WE),.RE(EX_RE),.RW_addr(EX_RW_addr),.RD1_addr(EX_RD1_addr),.RD1(EX_RD1),.RD2(EX_RD2),.WR1(EX_WR1));
instruction_fetch instruction_fetch1(
    .PC_NEXT(PC_NEXT),
    .clk(clk),
    .rst(rst),
    .IF_ID_IR(IF_ID_IR),
    .IF_ID_NPC(IF_ID_NPC),
    .PC(PC_MEM),
    .IR_MEM(IR_MEM)
);
instruction_decode instruction_decode1(
    .IF_ID_IR(IF_ID_IR),
    .IF_ID_NPC(IF_ID_NPC),
    .ID_EX_A(ID_EX_A),
    .ID_EX_B(ID_EX_B),
    .ID_EX_IMM(ID_EX_IMM),
    .ID_EX_NPC(ID_EX_NPC),
    .ID_EX_IR(ID_EX_IR),
    .WE(EX_WE),
    .RE(EX_RE),
    .RW_addr(EX_RW_addr),
    .RD1_addr(EX_RD1_addr),
    .WR1(EX_WR1),
    .RD1(EX_RD1),
    .RD2(EX_RD2)

);
instruction_execution instruction_execution1(
    .ID_EX_A(ID_EX_A),
    .ID_EX_B(ID_EX_B),
    .ID_EX_IMM(ID_EX_IMM),
    .ID_EX_NPC(ID_EX_NPC),
    .ID_EX_IR(ID_EX_IR),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .EX_MEM_IR(EX_MEM_IR),
    .EX_MEM_PC(EX_MEM_PC)
    
);
Memory_access Memory_access1(
    
    .EX_MEM_PC(EX_MEM_PC),
    .EX_MEM_IR(EX_MEM_IR),
    .EX_MEM_ALU_OUT(EX_MEM_ALU_OUT),
    .MEM_WB_PC(MEM_WB_PC),
    .MEM_WB_IR(MEM_WB_IR),
    .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT)
);
write_back write_back1(
    .MEM_WB_PC(MEM_WB_PC),
    .MEM_WB_IR(MEM_WB_IR),
    .MEM_WB_ALU_OUT(MEM_WB_ALU_OUT),
    .WB_IF_PC(PC_NEXT)
);

endmodule