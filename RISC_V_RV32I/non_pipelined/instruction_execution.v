`timescale 1ns / 1ps
//`include "ALU_main.v"
//`include "branching_unit.v"
module instruction_execution(
    ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR,
    EX_MEM_ALU_OUT,ID_EX_IR,EX_MEM_IR,EX_MEM_PC
);
 parameter R_TYPE = 7'b0110011, I_TYPE = 7'b0010011, B_TYPE = 7'b1100011, L_TYPE = 7'b0000001, S_TYPE = 7'b0100011, J_TYPE = 7'b1101111 ;
 parameter BEQ = 3'B000, BNE = 3'B001, BLT = 3'B010, BGT = 3'B011;
input [31:0] ID_EX_A,ID_EX_B,ID_EX_IMM,ID_EX_NPC,ID_EX_IR;
output [31:0] EX_MEM_ALU_OUT,EX_MEM_IR;
output reg [31:0] EX_MEM_PC;
wire [31:0] branch_pc;
reg BRANCH;
reg en_alu;
reg [31:0] A_IMM;
always @(*) begin
if(BRANCH==1'b1) EX_MEM_PC <= branch_pc;
else EX_MEM_PC <= ID_EX_NPC;
end
assign EX_MEM_IR = ID_EX_IR;
ALU ALU1(
    .A(ID_EX_A),
    .B(A_IMM),
    .func(ID_EX_IR[14:12]),
    .opcode(ID_EX_IR[6:0]),
    .Y(EX_MEM_ALU_OUT),
    .ALU_EN(en_alu)
    
);
branching_unit branching_unit1(
    .ID_EX_A(ID_EX_A),
    .ID_EX_B(ID_EX_B),
    .ID_EX_NPC(ID_EX_NPC),
    .ID_EX_IMM(ID_EX_IMM),
    .br_en(BRANCH),
    .EX_MEM_PC(branch_pc),
    .ID_EX_IR(ID_EX_IR)
);
always @(*) begin

case (ID_EX_IR[6:0])
    R_TYPE,I_TYPE:begin  en_alu<=1; A_IMM<=ID_EX_B;  end
    S_TYPE,L_TYPE:begin  en_alu<=1; A_IMM<=ID_EX_IMM; end
    B_TYPE,J_TYPE:begin BRANCH<= 1'b1; end
endcase
end
endmodule