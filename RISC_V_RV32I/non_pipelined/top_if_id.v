module top_if_id (
    clk,rst,ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,
    PC_NEXT
);
input clk,rst;
input [31:0] PC_NEXT;

output [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR;

wire [31:0] PC_MEM,IR_MEM;
wire [31:0] IF_ID_IR,IF_ID_NPC;
wire [4:0] EX_RW_addr,EX_RD1_addr;
wire [31:0] EX_WR1,EX_RD1,EX_RD2;
instruction_mem1 instruction_memory6(
    .A(PC_MEM),
    .RD(IR_MEM)
);

instruction_fetch instruction_fetch1(
    .PC_NEXT(PC_NEXT),
    .clk(clk),
    .rst(rst),
    .IF_ID_IR(IF_ID_IR),
    .IF_ID_NPC(IF_ID_NPC),
    .PC(PC_MEM),
    .IR_MEM(IR_MEM)
);
reg_file rg(.WE(EX_WE),.RE(EX_RE),.RW_addr(EX_RW_addr),.RD1_addr(EX_RD1_addr),.RD1(EX_RD1),.RD2(EX_RD2),.WR1(EX_WR1));
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
endmodule